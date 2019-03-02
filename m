Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 353F320248
	for <e@80x24.org>; Sat,  2 Mar 2019 01:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfCBBSV (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 20:18:21 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35187 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfCBBSR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 20:18:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id t18so27739813wrx.2
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 17:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=MolAGhobP0dUvDJlWj2k5MSxB+xrvy+8XJODMSZDmuI=;
        b=GYKIshzb+6LeYz2K6mzqY9PYq9eOlwAE+HvPN1bKBG8f0gxYGhWKr6Jkicnr1oBECI
         bM+A+Cq91ztjQQTdKmnB2J8pA7Ig1KufN8hknoH/ZLVomgJjlO0er21bTcW2gYvb65Rw
         0wjE3Uq+ZvFizCy4ZsLJxTj/7OpxsCIetwLIPTaw/49knp8MPPupRLVT9vxam+Ut5zAP
         yPP8WPYkUnNM7DLroF7NQrK0uPIkMY84jBHOKxXmbFYsqc/bGFtYx5NlpqysRhKOs8D/
         y6jamtOOXlYBExpLu00Z0hiyEVc08HX+AvpGTsYC4w8A0i40WeeBJSjcC5cyZPQ1NRww
         5e+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=MolAGhobP0dUvDJlWj2k5MSxB+xrvy+8XJODMSZDmuI=;
        b=HuZ8/wySAru29vPoWWA/efeKSvvbKl9xsZ6a+wg0sTC7DPfCZKPQB+/ZJXqmSjgTF9
         HEa2R9ueTt8DwbKkRCMeK+JYPhMm4AnFwO37Tbq2UNbbEXxhEOHrfmtvbI4KZihhfqco
         qp6nSJfj/5EWS0hneOxwGNF6PPCxUksvrKe+Qz8st03aCJuuR2rcDMsGovK5ClXiFPui
         3sN2OOXHkQ6a5I8xw5UOcTd7vGp/A4oj7hhznVV5M+boMICsegTgejirI825P+IUcxfv
         KWeHSASYHh6srUw/5errSlJLR3qGeX9tF0BvtlcSxO5N7p4s+gnQ3m2ZcHDbxQRsn6pA
         +tZA==
X-Gm-Message-State: APjAAAW5OnhQhKUvvi+9ZarfsOszay8FH1TTFcpS+HO5S3ckh55EW10O
        wuMq3ZXBw07fUizxCzftn0k=
X-Google-Smtp-Source: APXvYqy6NBNG9SPUNrnRWVwi8D1Sf7PKU1ht7xwpHOybR2UE5C0rKF75ImC47kjbgKwFyzaVyWtKIA==
X-Received: by 2002:adf:f985:: with SMTP id f5mr2026231wrr.96.1551489495617;
        Fri, 01 Mar 2019 17:18:15 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 93sm70342923wrh.15.2019.03.01.17.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 17:18:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
        <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [BUG] completion.commands does not remove multiple commands
References: <20190228230506.GA20625@sigill.intra.peff.net>
        <20190301173443.16429-1-tmz@pobox.com>
        <20190301183017.GB30847@sigill.intra.peff.net>
        <20190301221551.GD31362@zaya.teonanacatl.net>
Date:   Sat, 02 Mar 2019 10:18:14 +0900
Message-ID: <xmqqef7q6pm1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Hmm.  The comments in list_cmds_by_config() made me wonder
> if not using a local repo config was intentional:
>
>         /*
>          * There's no actual repository setup at this point (and even
>          * if there is, we don't really care; only global config
>          * matters). If we accidentally set up a repository, it's ok
>          * too since the caller (git --list-cmds=) should exit shortly
>          * anyway.
>          */

Doesn't the output from list-cmds-by-config get cached at the
completion script layer in $__git_blah variables, and the cached
values are not cleared when you chdir around?  If you allowed the
repo-specific configuration to affect its output, the cached values
need to be reset when you cross repository boundaries.  Otherwise
you'd see complaints like "I have this in repo A but not in repo B;
when I start from repo A, it gets completed even after I go to repo
B.  If I start from repo B, I do not get completion in either of
them" (the former is because repo-A specific result gets cached, the
latter is because the cache is populated with the result taken in
repo-B that doesn't have customization and stays around even when
you visit repo-B).

I think it is a sensible design decision to forbid per-repo config
to relieve us from having to worry about when to invalidate the
cache and all associated complexities.

