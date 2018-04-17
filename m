Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E6551F404
	for <e@80x24.org>; Tue, 17 Apr 2018 19:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752310AbeDQTbs (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 15:31:48 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:43489 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbeDQTbr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 15:31:47 -0400
Received: by mail-yw0-f181.google.com with SMTP id i187so8479423ywd.10
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jV6JFclPRuVWrB051ZwiRcgz9F72AVLh303lXcWj/K0=;
        b=eSb5gsobFhrCMMrsK/mO5I8Jvwwl5t75lLwKNx7BYyaL3pdMHqpRNNXn9pyJsjTcR1
         +eV/c4v+LZXebxhPgXumuorOr3EHE3NENSQy8bvW9LUtfw1AMalsvyRojWQIoldbig9Z
         dzsuvb3ou8HEm4L/K07zfnn2/gCWU3+UqXLBVp9krC3S1WaDvU2LdJdbTZ3jZKwmCkTO
         k7nb8PBHo+E0Vtw45H5bsVd0Nskb35LwycyW6C1TVQdd+eN2V2j5FtYEjOx1+D7q52Q4
         NwGKG+gsWXf2QPtXA01jeXqz0a2EbjQR+F2kHo8pyzJPM4qPi964THIi3ajtfcRdShIs
         ofpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jV6JFclPRuVWrB051ZwiRcgz9F72AVLh303lXcWj/K0=;
        b=ulbzpi4YaKX1Ew4sQVE4JXmTqLawe2fEJP3CcynL3QRb/udEl0FmukqszguJkcEU4h
         TsQBiCvW6oHd2Il6V/wz5sKWqwOMxFDaek3I8nixGqlA+9MJEWTXIBNPLC280O9qauHK
         rHkyRIKeUt3De+RqaJwmEd2qfZNyzz3+Lbv0rH+fojRcYaqTCiYyqyatY6/0MbBAU1Qq
         EYYg4gHXh9nSl9wP8D8gDNAe05CoWmxFtoJu9/j2czb0soMlNMKQ4SgBaTyQZVLWSWww
         SBiUQJDYueT3na0wIq4Q49bEUiuOIPpK+5gUDUvY86drVpHNgFx4VneGnSQbAanYt3A5
         iUhw==
X-Gm-Message-State: ALQs6tB5KS5sYMvKAqNED8GaoG6Mc1jrUgoxqsrpUojt9Ekp6DSS+OjA
        98DIawND9Hd2VZSmXKGZhUB3Lo1vI1psn9gxJqjFJA==
X-Google-Smtp-Source: AIpwx497DiN6XS3OvhD/6YW7IIPFPBdBE4QvODFdd5+tt1dlo4wFQht2YECUPVy8/HLcIXNFNzg0fLDHv5sclV//PdE=
X-Received: by 10.129.232.5 with SMTP id a5mr2504718ywm.421.1523993506282;
 Tue, 17 Apr 2018 12:31:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 17 Apr 2018 12:31:45
 -0700 (PDT)
In-Reply-To: <xmqqbmeiv7c2.fsf@gitster-ct.c.googlers.com>
References: <20180416220955.46163-1-sbeller@google.com> <20180416220955.46163-3-sbeller@google.com>
 <xmqqbmeiv7c2.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 17 Apr 2018 12:31:45 -0700
Message-ID: <CAGZ79kb+MEJswk9NU3ktr9gAY7XVdCYS-w=e-Qmmp8knSNsHTg@mail.gmail.com>
Subject: Re: [PATCH 2/2] builtin/blame: highlight recently changed lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 16, 2018 at 8:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> It seems that this
>
> $ git -c color.blame.repeatedlines=cyan blame --heated-lines builtin/blame.c
>
> refuses to run.
>
> Would it work if the configuration is in .git/config instead, or
> would it forever disable --heated-lines once somebody choses to use
> --color-lines feature by default by configuring it in?

That is the unfortunate part of this series, I have not figured out how to
treat these two options at the same time.

One could take the approach to check the config first and see if there
are conflicts and then overlay it with the command line options
(and resolve conflicts there, but CLI taking precedence over config).

Or we'd need to introduce another config
blame.coloring={none, repeatedlines, highlightrecent}
which breaks the tie.

Thanks,
Stefan
