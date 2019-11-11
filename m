Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72A3A1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 21:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfKKVZZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 16:25:25 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44325 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKKVZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 16:25:25 -0500
Received: by mail-pl1-f196.google.com with SMTP id az9so7507536plb.11
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 13:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kEQPrv0GtSTAVSY2do9NpX0kuUoxdG5WOiWEBow6yps=;
        b=hRg5jghw6a+8rEURPUo0AiId2WZ1ygoJEa7VYzbotqGdkFbameeeUWS/DQPwZdP/+f
         1aYt6Us8hnD8g4I3MMna/PB5MzXaToIR9NpnFJUQU2zQ/I+x9nBkPn/8gMJnv2NvCyjt
         FbspAZNX7jthb++utKJmVVZCiG+X/MD8/XWl32ressY6sZ52pHJKkeNQHCp1wgnr4b9P
         NwpK3CaznR3I/vsVhfvfC/DV+hg9LfAX5R5oKfR9m0a1nL3NrFa13+rFZTZs43fPcsPS
         3dobJIFQ+/sulu8JCnVM0po1Vr/lOCHooInfg5Xo76mrorg8bpwN4D5UwNkoJD8z/d1a
         nszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kEQPrv0GtSTAVSY2do9NpX0kuUoxdG5WOiWEBow6yps=;
        b=bG4ksPNxwQuh0CaOFkw5ZJvW3Mly6CCNCO1aBRCTC6lhuYTaRu7VHbGuTnyHeYGHmI
         v4I788BRubyHuMyyTeu2i7OOCoSAHC2qESzT1kKZspK3eHlSaSQUUH7/mOpUDRL3GBMb
         j/TFmWaYOlUXWIzHzbsTXNi33t9/jQyJYyp50tRvwdWvMUwYH4omNfprFzrIZcovWeZb
         FPhzFFPPs+MUXMUeBSmFA6goh56Gigp2ZwkZT3LrZdWik/k3iFoAlqx3/pfhzY0j98EY
         ePt+HC7ZJPc5DENtoqIU5d1kN61iADIVo+fcD2Y6PKAu088NelpWy5F8x2mgy/T5QHPE
         uUbQ==
X-Gm-Message-State: APjAAAUNAS+aBFJWdogruU1qTHTbv9oeKfBY62qIwvBSPPZik2KsExuS
        66FFvROMiMs/5yztHpUYLsCpCD6X
X-Google-Smtp-Source: APXvYqxQKBklQw7IaQrkeoue43dVyd/wAXmMdVh6zNlLStkx3I5i3QZJFzl+bhFDIwDT9jIXc2ayuQ==
X-Received: by 2002:a17:902:68:: with SMTP id 95mr27569371pla.117.1573507523698;
        Mon, 11 Nov 2019 13:25:23 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id o1sm14046544pgm.1.2019.11.11.13.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 13:25:22 -0800 (PST)
Date:   Mon, 11 Nov 2019 13:25:20 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Paul Jolly <paul@myitcv.io>
Subject: [PATCH] completion: learn to complete `git rebase --onto=`
Message-ID: <22e92546ee49d4502fd5a441741a380d62c834c7.1573507362.git.liu.denton@gmail.com>
References: <CACoUkn6D0cUmN1RbcpfERcOJsbGLdwj6oDeF2oRADV+rX2artQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACoUkn6D0cUmN1RbcpfERcOJsbGLdwj6oDeF2oRADV+rX2artQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 2b9bd488ae ("completion: teach rebase to use __gitcomp_builtin",
2019-09-12), the completion script learned to complete rebase using
__gitcomp_builtin(). However, this resulted in `--onto=` being suggested
instead of `--onto `.

Before, when there was a space, we'd start a new word and, as a result,
fallback to __git_complete_refs() and `--onto` would be completed this
way. However, now we match the `--*` case which does not know how to
offer completions for refs.

Teach _git_rebase() to complete refs in the `--onto=` case so that we
fix this regression.

Reported-by: Paul Jolly <paul@myitcv.io>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Thanks for reporting the bug, Paul. I overlooked this case when I made
the commit that you pointed out.

 contrib/completion/git-completion.bash | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7b1ab46f0b..2b644056af 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2021,6 +2021,10 @@ _git_rebase ()
 		__gitcomp "$__git_whitespacelist" "" "${cur##--whitespace=}"
 		return
 		;;
+	--onto=*)
+		__git_complete_refs --cur="${cur##--onto=}"
+		return
+		;;
 	--*)
 		__gitcomp_builtin rebase "" \
 			"$__git_rebase_interactive_inprogress_options"
-- 
2.24.0.300.g722ba42680

