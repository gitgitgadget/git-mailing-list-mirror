Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF264C3F2D1
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 21:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C6B20CC7
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 21:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEiC7Fdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgCCV4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:56:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41977 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgCCV4y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 16:56:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id v4so6392824wrs.8
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 13:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ja5erqkST08dUMxmPOviMsfulwuq617BbP7qhglZe4A=;
        b=oEiC7Fdu0FC5qsbjlLW0yQwsvIBXv7mM3pp3Gckhki4dG+tw7Gs1k6ewv3uGAhKwRd
         NEsspOmrT43SMaVaoulT1e6IlhVBJuYdRHUk1eorBJ/X+mLAw24zmT7jnyFiJsCm2EE8
         9znNXtTF0kPD2xoFh5mfYAh5j24gDoVcRVLUlaHXAxifPhOCcmC20wgrhvMKNS2+gm7U
         FHdjJCFVCVc3Lgy7l2uQ/6g/hnh+Ps6Qv7Rq0T3WPrp9N6LOVcGK4dpg8CR/AYtKoalH
         T3SAV3x0fuWLUCc/xgNrRdHE0a2TzdNdX2G0aaQP19XEjVafKA7u07fyN99PuKxUBYPn
         QU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ja5erqkST08dUMxmPOviMsfulwuq617BbP7qhglZe4A=;
        b=gR9ixpUU3y2k5L+SAw2JPGFP6ksCiytMWhT9LnI84RcVXORzbk2lJgYIrJi23+nJGN
         yIjt+HCl6d9tRc6oGPy2j87ombeeJSvA3STR+oAiAocbYcl5nOEDcjihnZVCIt0xL/JL
         3tPPg0KpN/G4NasikmON+xO0ml0OpRd4aY6ghUbcc95WcjnBz6EeFIOTWonZDfH1yARY
         L1KEf8qjQ3pdHvSzy1tqanO7yHp/vRFX8p5Rim73CfrmaYf6WBJeg+Y8DTtQF/aZKmiW
         abfTt9SpbjmVbVpc1Lk2ZWCxZd1xuCfj7oTJHQFoWp4DmQSYkJSogE//tbaie+ynVSip
         6iBw==
X-Gm-Message-State: ANhLgQ0KJ1qf+r+5+Z7LiG8bbymCciX1vaYIw+FM+1If/OuwkV3L6q0I
        DvlHY9AnFok9J0Ie3v4nY+0=
X-Google-Smtp-Source: ADFU+vtbaZxhgVxdrdDENe6VoW3MnqtlkEo6TeLjwZ57TDH0xQ4MbwlECls/UdcvuW+S3VyZE2P81Q==
X-Received: by 2002:a5d:6086:: with SMTP id w6mr110044wrt.224.1583272613032;
        Tue, 03 Mar 2020 13:56:53 -0800 (PST)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id j12sm36335353wrt.35.2020.03.03.13.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 13:56:52 -0800 (PST)
Date:   Tue, 3 Mar 2020 22:56:50 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: GIT_DIR in aliases [Re: Spurious GIT_DIR set when in a worktree
 [was Re: Nested submodule status bug]
Message-ID: <20200303215650.vpsfgcjrsv42dqob@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Tue, 03 Mar 2020 22:23:45 +0100
References: <20200214224242.knmzkwx7ls4sote7@doriath>
 <0123F1ED-C421-4C1F-896B-E54C9D345A34@gmail.com>
 <20200226172338.unembhjhog36sqj7@mithrim>
 <20200227100557.ydouc4n3jphzbits@feanor>
 <20200227104330.hp7zf2suquxsf6zw@feanor>
 <20200227155057.7idpa447ixo6sf6j@feanor>
 <6D4FEE68-EF3C-491E-A7C1-3454B88977C3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6D4FEE68-EF3C-491E-A7C1-3454B88977C3@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If that’s what your are trying to do, ‘git submodule foreach’ [1] seems like a better way to go. 
> For example I have an alias ‘st-sub’ that calls git status in the superproject and then recursively in the submodules:
> 
>     $ cat ~/.gitconfig | grep st-sub
>           st-sub = !git status "$@" && git sub foreach --recursive git status "$@"

I have almost the same aliases :)
	s = status --short --branch
	subfor="submodule foreach --recursive"
	subs="!f() { git subfor git s \"$@\";}; f"
	recs="!f() { git s \"$@\"; git subs \"$@\";}; f"

But in practice I often want to run commands only in *changed* submodules.

For instance with the above 'git subs' yields a lot of non informative
messages like:
  Entering 'non/changed/submodule'
  ## master...origin/master
(and git foreach --quiet) removes the first line but not the second.

This is also useful for an alias like 'recursive_commit' where I only want
to commit changed submodules, to not get a lot of messages like
     nothing to commit, working tree clean.

So I wrote a script that parses the output of 'git status --porcelain=v2'
and run a command only in changed submodules (where I can specify if
changed means 'C', 'M' or 'U'). Except that I did not think about unseting
GIT_DIR and stumbled into this bug (I am sorry I went a bit on a wild chase
in this mailing list but I had already spent quite some time in trying to
find a minimal exemple, I first thought that my program had a parsing bug).

Now that I think about it, I probably also could do that with 'git
submodule foreach', by testing 'git diff --no-ext-diff [--cached] --quiet'
first before running the subcommand. This would give me the 'M' submodules,
but it is not clear to me how I could test for 'C' changed submodules with
this method.

-- 
Damien Robert
http://www.normalesup.org/~robert/pro
