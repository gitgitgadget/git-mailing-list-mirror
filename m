Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A72C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC531206D9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vHo4bwyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgEDQwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 12:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729830AbgEDQwS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 12:52:18 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2ABC061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 09:52:17 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 145so5765050pfw.13
        for <git@vger.kernel.org>; Mon, 04 May 2020 09:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CXxKJBCDi22nC9zAZgnhSmaM8qWUrtNHMu6EixZtceo=;
        b=vHo4bwylESUPTLjrRWVyoGKwIMaTXAl97I8AacQdkQ52GCTdhn5AaF6A/kvnk4TwzL
         QMKyIfEDQ2cQsKusg46flP1VTMs/8kcpXBs9bKOtw6AAMlaToQj63MrG8xdtfv2A6r+9
         1TrviRIbQi1jcg6v5mw5+McOe+nvvPiiLpkyWNLRLXVNHnpEczy6emKtuPKN2xD6+nR/
         62nfwvqAiIfU//R//nY4rX2S6bTmo+3xZ/4YipRfA38k+1fvcgnbEz4K2tS8GuEq8TKV
         Y2j1CYZDwnhg4WKeC9/jmDOVO5xQdgxKcIrnPI4cH3qPGT7Q9vUL2WDAAIwoZBhZmDQe
         tpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CXxKJBCDi22nC9zAZgnhSmaM8qWUrtNHMu6EixZtceo=;
        b=oCHjsbKOoZyyNgViuqioPo4FUFk/IQaSzYEAUiJnC7nDKh2mP2o0Gbo9BBmka+nXXT
         Vlf2fmBXNKQjoUk94a2/wogCgJrN09irAQdoObcTnYSJDpZchN7JC3MJ7cFqNjS6ON25
         dBrnletNSVNHgLNgUc3tFsQUXB9FONwIWW0fIZ8tAyUpSK2HizUiFfqp44GiKvYyrIFJ
         kg3pIdnQsTcCMKaNYGw5sCYVP5B4LESr3hezaHx2SpJzyzOs7okxZ15ve4N+R5Ppf0xM
         fbxWbuacssScvwywDOAXAQSmKiMw8Hp2rSSDuGTWDnjFHeJ0XKy0MFnhPeKvbkW+mfj+
         qGrQ==
X-Gm-Message-State: AGi0PuY1xRPsqKbqj98mNTVUbaoTKpl9cExLiwsXlDQkAEcmfipvNxGh
        6Szvlbs+j2HK+HXI41sZUSC+f8Cr
X-Google-Smtp-Source: APiQypJjxPu5ngFI1+zouFwCx/eU/2gNAnWqRawYA3T83mFujfkx2CqLWz0b8vZ+0fVzuCCejWz4vQ==
X-Received: by 2002:a63:d709:: with SMTP id d9mr16683958pgg.82.1588611137243;
        Mon, 04 May 2020 09:52:17 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id q7sm8079678pgs.13.2020.05.04.09.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 09:52:16 -0700 (PDT)
Date:   Mon, 4 May 2020 09:52:14 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git 2.26.2 and failed self tests on OS X
Message-ID: <20200504165214.GF86805@Carlos-MBP>
References: <CAH8yC8myTMOetxgaj1wt0MbvSQ0LSRV0FHz4ywsBM1zzhUQG=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH8yC8myTMOetxgaj1wt0MbvSQ0LSRV0FHz4ywsBM1zzhUQG=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 03:03:01AM -0400, Jeffrey Walton wrote:
> 
> I'm building Git 2.26.2 from sources on a Mac-mini with OS X 10.12.6
> and a PowerMac with OS X 10.5. Some of the t3902-quoted.sh tests are
> failing.
> 
> The Mac-Mini uses Bash 3.2.57(1)-release. The PowerMac uses 3.2.17(1)-release.

if the problem is the bash version but you can build/install a newer one that
doesn't have this problem then you can get the test to use it by pointing to
it with TEST_SHELL_PATH as in :

  $ make TEST_SHELL_PATH=/usr/local/bin/bash test

Carlo
