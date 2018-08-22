Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D36F31F954
	for <e@80x24.org>; Wed, 22 Aug 2018 15:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbeHVSyt (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 14:54:49 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38740 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbeHVSyt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 14:54:49 -0400
Received: by mail-wm0-f49.google.com with SMTP id t25-v6so2609340wmi.3
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 08:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CnKHxXLRcpguNeZgxt43l9FJGoWKmRT6nl3JlC7vBqo=;
        b=FTuOfPtnor7BRbvMDcuf6nvDHg2Ezr0rN+c47wkw76IrDOHOiBmnyPNyCVE7GV0VlF
         R7x2t5QlDZxg5dobqtiAcFDEKmmuFnb2CD6CWvtk9D1hFZwNZIJrnlH5W1ftVn3i+3x4
         1FwyDx8KG5kprmSOwaO0K1x8yEY61DdUKyCgLbcxUlNCU5CuUHC/o7IU9tV1zUSp9nzj
         5A+UVnkCByZTAG8Dj9cE8rF/CaXSClhABXRTQuXkCy4NOyTix+WwdWNtHSSLXFoK/IWN
         35odNE3vCGM4TzjXd3/vgHEuGPu+6ObTyutoY0dKrqbP7ldIolA5iwqtOFwD5rYX0WVG
         YvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CnKHxXLRcpguNeZgxt43l9FJGoWKmRT6nl3JlC7vBqo=;
        b=tBrXt70DU1/MHEZYdoTofEjKvYwwWQt8ZHEcy6tq5KPrb08dpq/xNRFn0paZOHL67T
         yjdxRKxltjEN40TW5uIPNOQP1B5xo+aR31cFacdWzcZftRyvZtoPhzvn6whIGDJLz/7+
         x7SxrKEj+fUjLdczyt092otUcQAvTlXv6z3E34A4zwDYKUNBvdsP7cfbpFE4ycXID0ka
         I+4aTQLMjyanOp8k8rCN3SBKOsDegNfg+tE361N8BSze6r9RYJgImxGlrgMx1mRi4oLc
         wV+6GoZLm2e0djQJe5QqMw+yJw+8PesB5Htdsy1ctuBsGfFXum/5fiXKOb+pnvym2O2M
         n7pg==
X-Gm-Message-State: APzg51DCbIPAzGQfxOx5fb11SPgPWbdh/7xbsfLRFqAXm7Uq591Rak2w
        e+m1tWH+eyLUKriMzqzJiUk=
X-Google-Smtp-Source: ANB0VdaE8UlSHDIpr9AqH9YfQHtKwaWWXmzKMCMcWEVO9ZOajFh5uDO4P/6LUD+vKoRXKwtb1eOoSA==
X-Received: by 2002:a1c:357:: with SMTP id 84-v6mr2585915wmd.8.1534951766657;
        Wed, 22 Aug 2018 08:29:26 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r140-v6sm2658411wmd.7.2018.08.22.08.29.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 08:29:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Daniel =?utf-8?Q?Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 7/7] submodule: support reading .gitmodules even when it's not checked out
References: <20180814110525.17801-1-ao2@ao2.it>
        <20180814110525.17801-8-ao2@ao2.it>
        <xmqqmutoznwe.fsf@gitster-ct.c.googlers.com>
        <20180820233755.dc7b6a6927faccc37b25075f@ao2.it>
        <20180822135152.1d40cd05d0b0cadb5eefb31f@ao2.it>
Date:   Wed, 22 Aug 2018 08:29:25 -0700
In-Reply-To: <20180822135152.1d40cd05d0b0cadb5eefb31f@ao2.it> (Antonio
        Ospite's message of "Wed, 22 Aug 2018 13:51:52 +0200")
Message-ID: <xmqqd0ua773e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antonio Ospite <ao2@ao2.it> writes:

> Maybe "submodule--helper config --check-writeable" could be a better
> name to avoid confusion between the boolean return value of the C
> function (0: false, 1: true) and the exit status returned to the shell
> (0: safe to write, !0: unsafe).

Perhaps.  The main point was to replace the comment that tells the
developers to keep two things stay in sync with an actually shared
implementation; as long as that is done, I am not too much worried
about the details.

>> > > +		else if (get_oid(GITMODULES_HEAD, &oid) >= 0)
>> > > +			config_source.blob = GITMODULES_HEAD;
>> > 
>> Would using ":.gitmodules" instead of "HEAD:.gitmodules" be enough?

Yeah, either "instead of", or "in addition" (i.e. "try the index
version in addition, before falling further back to the HEAD
version"), would be more consistent with the remainder of the system
(or, at least where the remainder of the system wants to go).

>> If so, what name should I use instead of GITMODULES_HEAD?
>> GITMODULES_BLOB is already taken for something different, maybe
>> GITMODULES_REF or GITMODULES_OBJECT?

I do not know why you want to refrain from spelling them out as
"HEAD:.gitmodules" and ":.gitmodules"; at least to me the extra
layer of names do not look like they are making the code easier
to understand that much.

