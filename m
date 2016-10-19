Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A4162098B
	for <e@80x24.org>; Wed, 19 Oct 2016 16:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941030AbcJSOQG (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 10:16:06 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:32946 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934619AbcJSOQD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 10:16:03 -0400
Received: by mail-pf0-f169.google.com with SMTP id 128so17139231pfz.0
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 07:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r4+EoCK9c49UynaO4uQBCMV0NK3AMAtC4HQo0o4QAlQ=;
        b=mT8aD+KCisg1eexuP1KbtX96a+ABsEyUDylYq971+R8Ibh4LjdPNDLOmRCmsyCTxf1
         9nS0ErWUBMVMfrEaXhMrpxZax9iV76GKWJb0GAAR2DGWNPXbWJTIsZdGgo1VUIyLtptZ
         OI5lkggcPJi182J0AjiA37Wf+QuAIiUKLLVns04DDhQnlhoIAQM0avMVaTYbEB2xGIDj
         GnahR9BTXEVFW3eJRFVuBpAT8OsYFg4lYUtKENXxS/CKcJVIQ4qjnwOzuQOyj0+QUMmb
         Js1KnbH1DauNo+s++Lu2svDEl4Yww0ybcneQK2avaqYrzYFAr5nHOJ6tIY5IpaveVUMG
         0jYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r4+EoCK9c49UynaO4uQBCMV0NK3AMAtC4HQo0o4QAlQ=;
        b=WltuJ7+xGGWrMUkpCkjyxIFOninaScF7IyLv0h+3GZiQ+F7msAU02cpIxOXIYkF/1F
         UdQ5sobnPV+wZuOuphk+vy2Xs839BSIZuRAgvMiEsv71QysvKfCStPv7RhPKVbcuO5DD
         QirM+akQBIJ8IiwrdSwULNagDBtSNzh0DK+xaP3uLyZIR/jmgfK5JRkPk7OQgFpOYaAI
         GpYVhGswSxQP9Ysda3lsMgOSuqUzqXxL9AD+P7cEvQxKhxfmbAUfo5BuIh5zWkV9O3XL
         pC7rKGUP/fyVtiMTp9Sx1khZ5ehMgoIf+LxcQd6BtrUzjNYnplXnZsz05DcM5sWTB2Ru
         zxlw==
X-Gm-Message-State: AA6/9RmMbyIpg1tFQudRM+TQd5A9pFVWYhHWE6HdrsB6XRog8lZHAWKIOO17JK9MO08Trw==
X-Received: by 10.99.115.18 with SMTP id o18mr9595504pgc.44.1476884875840;
        Wed, 19 Oct 2016 06:47:55 -0700 (PDT)
Received: from ash ([115.73.162.90])
        by smtp.gmail.com with ESMTPSA id cp2sm31857460pad.3.2016.10.19.06.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Oct 2016 06:47:55 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Oct 2016 20:47:50 +0700
Date:   Wed, 19 Oct 2016 20:47:50 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Raffael Reichelt <raffael.reichelt@gmail.com>
Subject: [PATCH] Add a knob to abort on die() (was Re: git checkout crashes
 after ...)
Message-ID: <20161019134750.GA7256@ash>
References: <6B2BE996-F696-4EB4-91CA-849D40B8802D@gmail.com>
 <CACsJy8B50daiHWfu7zfVQnn_i_=HbUK3gBPmv1U=EUw7ZyuGPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8B50daiHWfu7zfVQnn_i_=HbUK3gBPmv1U=EUw7ZyuGPw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2016 at 08:27:43PM +0700, Duy Nguyen wrote:
> If you set the environment variable GIT_ALLOC_LIMIT ...  git
> attempts to allocate more than that ... then it's caught and we get
> a glimpse of how much memory git may need. Unfortunately we can't
> get a stack trace or anything like that unless you rebuild Git from
> source.

It's moments like this that I wish we had a knob to force core
dumps. And I often modify die_builtin() to add '*(char*)0 = 1;' to
force a core dump when I can't figure out some problem based on the
error message alone.

So.. how about we do something like this? We could extend it to abort
on error() as well as die(). Aborting on warning() may be a bit too
much though. On glibc systems we could even print the back trace
without aborting, which helps in some cases.

The long variable name and value are on purpose to hopefully not
trigger this by mistake.

diff --git a/git.c b/git.c
index ab5c99c..5fea224 100644
--- a/git.c
+++ b/git.c
@@ -622,15 +622,34 @@ static int run_argv(int *argcp, const char ***argv)
 	return done_alias;
 }
 
+static NORETURN void die_by_aborting(const char *err, va_list params)
+{
+	vreportf("fatal: ", err, params);
+	abort();
+}
+
+static NORETURN void die_silently_by_aborting(const char *err, va_list params)
+{
+	abort();
+}
+
 int cmd_main(int argc, const char **argv)
 {
 	const char *cmd;
 	int done_help = 0;
+	const char *die_abort_env = getenv("GIT_ABORT_ON_FATAL_ERRORS");
 
 	cmd = argv[0];
 	if (!cmd)
 		cmd = "git-help";
 
+	if (die_abort_env) {
+		if (!strcmp(die_abort_env, "yes please"))
+			set_die_routine(die_by_aborting);
+		else if (!strcmp(die_abort_env, "just die"))
+			set_die_routine(die_silently_by_aborting);
+	}
+
 	trace_command_performance(argv);
 
 	/*
--
Duy
