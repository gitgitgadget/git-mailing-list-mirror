Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9A821F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 19:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfADT1A (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 14:27:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40580 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfADT1A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 14:27:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id f188so2176363wmf.5
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 11:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SdPXPhxBQdlPU/piV5jtkrlKrzKDu2QS5z+iRsH8EgY=;
        b=DqrlkDnoeAe9Smth9HITJophC9hYxyCwg6i5eVUVdEj2Jr9TTqai2Ukd4IGglot+YB
         Wk4KftGv+m6GOgGUfRRe/XwWR2QuYVATNYc1mIvWWWK+cawvzULbJvDX1VP1mCo8E07t
         ojPzWN9cZzWse8kf7UOdL4OxXg8Zu5fwEKqt3KsUyf8zvbzrrP3vhj8t4+W5s1iZwMnM
         Yy+hld/eztxJfpBFyqsbAVrUx3Y2Cii3k8sX7C25OCUua2wrV5E9F0HIuQxsAzJNZ/7g
         PgNmhsdDPsKPRl+g+6wers3jpSqI9EBr7MSWodxmSWEx5zGFfmI/wds7jfNLGMzSgGrA
         6irQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SdPXPhxBQdlPU/piV5jtkrlKrzKDu2QS5z+iRsH8EgY=;
        b=W9KGNtON0dIXdd2nSxOiOjAybvVsqABUHnpAk2LMJYvgT3Rrg+l/PbI7q5yWW0W2B4
         D6M6O/LhO/qEjMAY542obfiUWFt2N8FsEyrXX+sNYGFEY9T91ZYTyQY4qq/mPhMW5N9O
         oH9v7UtOfbIv/BBwlIHZkLYEDOon4NfbKmP8DM8hf7p4fQCEfeM/FFtPlHCouALBHa1I
         KqrttnJN4pR6KW6ep69rJdZD4cWQdYeWc7oumjlBO2r5DrctPuPNaD8pwP3Qbg4b5Uzo
         XcR55xLPZNDccAT80DGDqm+vtK3SqRPdLPpk4TI6EVNjYYAimtOQLqlsVB09qjcgsNw2
         hH1w==
X-Gm-Message-State: AJcUukdU1vdi3OyT1VHAWpLVMkfWrv4CG5aYX/rlWoWCvRCVC/1uGfIW
        8I/bNyOxpo4ScI5Yyhn9Vuo=
X-Google-Smtp-Source: ALg8bN4FUPTzqR2c1dB8TZjHyJ5wGR4YFHzZWIKSzf2y70tkrqrYGvtE/s+YpbWJOKWLmut/zGUAiQ==
X-Received: by 2002:a1c:90cb:: with SMTP id s194mr2179800wmd.57.1546630017059;
        Fri, 04 Jan 2019 11:26:57 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y8sm1584036wmg.13.2019.01.04.11.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 11:26:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] diff: add support for reading files literally with --no-index
References: <20181220002610.43832-1-sandals@crustytoothpaste.net>
        <20190104021855.GB97188@google.com>
        <20190104025724.GG423984@genre.crustytoothpaste.net>
Date:   Fri, 04 Jan 2019 11:26:56 -0800
In-Reply-To: <20190104025724.GG423984@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 4 Jan 2019 02:57:25 +0000")
Message-ID: <xmqq36q8cjgf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>>  - --dereference to control whether to follow symlinks
>
> This is actually surprisingly difficult. The reason I implemented this
> only for no-index mode is because there are actually several places we
> can stat a file in the diff code, and implementing a --dereference
> option that catches all of those cases and getting the option passed
> down to them is non-trivial.

Another thing to worry about is symlinks that point outside the
working tree.  When a tracked content "dir/link" is a symlink to
"/etc/motd", it probably makes sense to open("/etc/motd") and read()
it on the working tree side of the diff, and probably even on the
index side of the diff, but what about obtaining contents for
"dir/link" in a year-old commit under --deference mode?  I am not
sure if it makes sense to read from the filesystem in such a case.

I personally am perfectly fine if this "do not compare readlink(2),
but read contents literally" is limited to the --no-index mode.

Thanks.
