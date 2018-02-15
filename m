Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 681811F404
	for <e@80x24.org>; Thu, 15 Feb 2018 21:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756027AbeBOV2A (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 16:28:00 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:42919 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755992AbeBOV16 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 16:27:58 -0500
Received: by mail-io0-f196.google.com with SMTP id u84so2167217iod.9
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 13:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BM2nsMlL67U/PkHMoEGjrGbI3lNceThyIqRHR9D87gY=;
        b=rpFfvmzHtSh2pbf+07zLPIHMSfuItT0+XV+f6Fu5Uk60eXmoE68VFnQKPlPe2jhRZk
         K/mfswEQXbyWsv1K9A2GmUHx5WpjWuLO0SuO3CmZislsnqNilUrA3ZghvLA9CrOpnvGv
         46L0MTim1mWctlXDJB/so0YyQ9a3scIs0DUyRfhVHRt894L5tKADwvbF0H5D3gQuXvx9
         dOc6f7zShNAngawb7UR5zU1y9OLeFop9ImZaEagH/pwrzoMGA/VQtVLWBme4EDpPPVYA
         Q0bDHYQ/8dzZ8StupdrrJGHE7gSFdBdvLVjANCjKbQRLZxucd/410jr9yax1VC62B12o
         CjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BM2nsMlL67U/PkHMoEGjrGbI3lNceThyIqRHR9D87gY=;
        b=l466BE09ZIuRoMlrNihpiuwahOuSGt/apssUjcyf49MT+5Gohzqk9DWLBiDOZ/+t28
         c1KB1B2wnmdpvsdY1uEaLoXNsNbdpU1rTEGinZ+3C3EvAv/yX4FeL99BK/xeczPghimp
         D6VN7g7Yzpfmwc5Pq7iWguR3+RGkch21WDgE2sbbVibYQTk+VwXjCXbobTtQNlroc33r
         U7JlHawyGr7WJ9H7qaufsYLofEznTKK/dnj4DsB4750ulLQsEKnyWT7/n8iaFgUsWvQ1
         V7yChMP4Li7/8o2J7xrEa+yrS8SY9LGqH+eEHC9nNacfPLQwIH8El6dc6NcYa6aOxDi9
         J+1A==
X-Gm-Message-State: APf1xPBjVcVzmMcQYNtp0ylUsZ78Qs01DImWMB+337CHrv2RMQaArcah
        4GxDL78m7BSlDpd1JpUmDZY=
X-Google-Smtp-Source: AH8x2242I9joeEL0EYC4QugHFq03lOWu7SPxF8ldPjDS48cIkdJPN4eeYFyyO7aeMBKRD0+CnpMQRw==
X-Received: by 10.107.9.208 with SMTP id 77mr5835548ioj.195.1518730077224;
        Thu, 15 Feb 2018 13:27:57 -0800 (PST)
Received: from flurp.local (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id 5sm815296itb.36.2018.02.15.13.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Feb 2018 13:27:56 -0800 (PST)
Date:   Thu, 15 Feb 2018 16:27:51 -0500
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        matthew.k.gumbel@intel.com
Subject: Re: [PATCH v2] worktree: add: fix 'post-checkout' not knowing new
 worktree location
Message-ID: <20180215212751.GA42108@flurp.local>
References: <20180212031526.40039-1-sunshine@sunshineco.com>
 <20180215191841.40848-1-sunshine@sunshineco.com>
 <xmqqh8qi7z7o.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh8qi7z7o.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 15, 2018 at 12:52:11PM -0800, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> >  test_expect_success '"add" invokes post-checkout hook (branch)' '
> >  	post_checkout_hook &&
> > -	printf "%s %s 1\n" $_z40 $(git rev-parse HEAD) >hook.expect &&
> > +	{
> > +		echo $_z40 $(git rev-parse HEAD) 1 &&
> > +		echo $(pwd)/.git/worktrees/gumby &&
> > +		echo $(pwd)/gumby
> > +	} >hook.expect &&
> >  	git worktree add gumby &&
> > -	test_cmp hook.expect hook.actual
> > +	test_cmp hook.expect gumby/hook.actual
> >  '
> 
> This seems to segfault on me, without leaving hook.actual anywhere.

I'm unable to reproduce the segfault, but I'm guessing it's because
I'm a dummy. Can you squash in the following and retry?

--- >8 ---
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 604a0292b0..f69f862947 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -348,7 +348,7 @@ static int add_worktree(const char *path, const char *refname,
 	if (!ret && opts->checkout) {
 		const char *hook = find_hook("post-checkout");
 		if (hook) {
-			const char *env[] = { "GIT_DIR", "GIT_WORK_TREE" };
+			const char *env[] = { "GIT_DIR", "GIT_WORK_TREE", NULL };
 			cp.git_cmd = 0;
 			cp.no_stdin = 1;
 			cp.stdout_to_stderr = 1;
--- >8 ---

If that fixes it, can you squash it locally or should I re-send?
