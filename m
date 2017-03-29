Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 577C620958
	for <e@80x24.org>; Wed, 29 Mar 2017 21:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933198AbdC2VJ6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 17:09:58 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:36080 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932728AbdC2VJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 17:09:56 -0400
Received: by mail-io0-f172.google.com with SMTP id l7so7327622ioe.3
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 14:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bF4Nfl6HYgaF92E3V7IXUc1mENcthOwW8SHEA0A1uFk=;
        b=d/vnj8ncMp2P2kxW13UCo9ko5nCnqWe81Edd19b+T39pIg8ce3FKXg6tJSipK6O9T8
         oJ2Rhb1qyxP5mih84AtAlcAN4a4KjzbPAMsiS0jsUSLzl+XJMx/rbZhL27H6EAH80H1p
         xP9p/vTZLDPtxKumcsPdPPoj43uJ/ULXJLkxszfrbR6VWxLpeNoQBwIo35Cw1QaS8fFZ
         iCpx24RmqKN+zCRhPkaFwWviW21S5mgyMTD/bUx8XUbi1tWzm/B7QorjdoD7RZkUSBci
         Geb5uaKlOpSFgZmG94wEevlVaclgb9ogRzLctEvIeKWellXtE8q48vtbys3NzBZQmqHr
         JCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bF4Nfl6HYgaF92E3V7IXUc1mENcthOwW8SHEA0A1uFk=;
        b=kQMzM9OFnQSy7U4ImKtSPOIOL29y2qSD8C6hYsz/VRY5ExxhuTUl9yF6CmciCCdpvT
         8qfDAem+MYnrRClRb1FeZw2b9KgLGV7klkeYgW82lgg/DiCQqYAcuyq6ScpiUM12RHTD
         ZOEKVACM/rZtIjT7yfoMkWTOFm0cEqxZKCZ2JQfEruLSHAwu3yVKkEz1z7gT0PAjUSv+
         9sTS8Y4rs3KbcXixe7uhrpwzLNMzYHyi7GOXOHyXGBn1qKJw3yf+2quj3tbdNy9hzSZl
         kAlWj38HPffdTDv1BYDHYcdUGMc4jMY46UU3he1Ld1jy+ysp5cHVH9r8xeL6OdLhpfTV
         tQaQ==
X-Gm-Message-State: AFeK/H0rQwkL0d7vmVfiw77jKwm51OOM2jwHe6zRCJ99N/JiQG14z9AD7o5RdEtlw5BYURuPTtylEclo610PNA==
X-Received: by 10.107.34.68 with SMTP id i65mr3220502ioi.147.1490821789769;
 Wed, 29 Mar 2017 14:09:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Wed, 29 Mar 2017 14:09:28 -0700 (PDT)
In-Reply-To: <20170329181228.n4t77pashdnirl3a@sigill.intra.peff.net>
References: <39b203e9-c3a9-80c3-ec24-649e04ef5620@atlas-elektronik.com>
 <20170329135703.18860-1-avarab@gmail.com> <20170329181228.n4t77pashdnirl3a@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 29 Mar 2017 23:09:28 +0200
Message-ID: <CACBZZX70oXn7McjavzvK5S30EXjXQhLixhb=WYbKCKYXVo1KBA@mail.gmail.com>
Subject: Re: [PATCH v3] perl: regenerate perl.mak if perl -V changes
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        stefan.naewe@atlas-elektronik.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2017 at 8:12 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 29, 2017 at 01:57:03PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Change the perl/perl.mak build process so that the file is regenerated
>> if the output of "perl -V" changes.
>>
>> Before this change updating e.g. /usr/bin/perl to a new major version
>> would cause the next "make" command to fail, since perl.mak has
>> hardcoded paths to perl library paths retrieved from its first run.
>
> This is one of those things that has been bugging me for years, but it
> comes up so rarely that I have never dug into it.

Glad to help. I've only run into this once a couple of days ago, made
a mental note to fix it, and then I saw that thread...

>> Now the logic added in commit ee9be06770 ("perl: detect new files in
>> MakeMaker builds", 2012-07-27) is extended to regenerate
>> perl/perl.mak if there's any change to "perl -V".
>
> Nice. This fix is way simpler than I feared.
>
>> This will in some cases redundantly trigger perl/perl.mak to be
>> re-made, e.g. if @INC is modified in ways the build process doesn't
>> care about through sitecustomize.pl, but the common case is that we
>> just do the right thing and re-generate perl/perl.mak when needed.
>
> I think that's fine. There's a related bug that the generation of
> perl/perl.mak via recursive-make is sometimes racy. So that _might_
> trigger more often as a result of this, but I think the solution is to
> fix that race, not try to pretend it won't happen. :)

We'll also redundantly trigger if you upgrade to a minor new perl
version, but I think that's squarely in "who cares" territory. This'll
only impact people working on git, and *occasionally* they might get a
100 ms hit when running make, as opposed to a cryptic error where
they'll likely stare at it for a bit before running "make clean".

If we were being more pedantic we could only bust the cache on major
perl version upgrades:

    perl -e 'print substr($], 0, 5), "\n"' >>PM.stamp+

Or use Config.pm:

    perl -MConfig -e 'print @Config{qw(api_revision api_version)},
"\n"' >>PM.stamp+

But I think overall leaning on the side of busting the cache more
often to avoid cryptic errors is the right choice, and we should use
"perl -V".
