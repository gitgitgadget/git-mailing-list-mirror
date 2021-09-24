Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9B8C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 10:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10380604D1
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 10:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245609AbhIXKpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 06:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhIXKpX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 06:45:23 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7398AC061574
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 03:43:50 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id dm26so151260edb.12
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 03:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=/d1haLfVsyIc9nwx46mgDwaXwqTLIN5S8Pw/WI6LyGo=;
        b=EKtkKFRmNxfB7Dc1g7S0FvMdntr8Fs8Ld0IA6Xr5eumfPqOh2ia2hvZO18rBQ/EdTJ
         NgE3sS/bDhLiDdt+/Wtc9CxHeYpVoy3PpCIkksSrs9mrGF2oxXWObd+g41gSU7OtszmP
         0T30knwuO1aFmu4RvLOzQt1fMFtaPAzfqiL2bJB8c+DIa++NI1QLQfpdaHSRzt/Gw4fZ
         /SczswAlujXWGnS94mDE/uis8XrZyi5LZhRV7YW7DYyQFoLguWdQfDbVTo0Okt3ndYcu
         lftMXCYiy901VSZpBM1QSJKxwb9eLe4LzkVpuoncznieHUuosGpS8CAGiThBZK/tVaDH
         NYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=/d1haLfVsyIc9nwx46mgDwaXwqTLIN5S8Pw/WI6LyGo=;
        b=Um9TkGUB+d1DHJdPoG+S0k3Y2gmc+wkfCPT/RRFCtgtk/O6YHrb5OuxgOsVX2X8hcX
         VVx3rz5Q1LW1hjby/oiV1LPsrv/A3l2KxKU3GmGLOezF6Ko/pcHQ/owZscDArH4GCexS
         8x0uavWWQXjyQUbAp1+dT+rlg3Zjqkw0tZvjGPRIsPAu08FEAWZQkdqzVG6/gifb63zt
         62tbqYtKS6UjlTQngnssV8L52dhu6NRIcOQOsfjtfTpHD4bHpV/wv6GCNZ5m8/sS9oCO
         Ov9Ojp26LdyNpj4/fixkwMkipgN00reiUnHrEkX3oounoQY2T31lo6sEwO1we4bojAw+
         EK6w==
X-Gm-Message-State: AOAM532dWCVzl6IS3eHav9QcIYZKQz7rHm5qAuo2ACQzOHEy6zPGzUjV
        Xer58Bh5daVE5MTo4taQusc=
X-Google-Smtp-Source: ABdhPJyPvE4GEsoVwOzxiub/PSzPr8h5pkEEtBYTkbKe+gFDZc2gZpRW8vlCP0cUonEG3rUHOr582g==
X-Received: by 2002:a17:907:7601:: with SMTP id jx1mr10291852ejc.69.1632480228869;
        Fri, 24 Sep 2021 03:43:48 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s4sm4837507eja.23.2021.09.24.03.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 03:43:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/3] difftool: create a tmpdir path without repeated
 slashes
Date:   Fri, 24 Sep 2021 12:35:52 +0200
References: <20210923041252.52596-1-davvid@gmail.com>
 <20210923041252.52596-3-davvid@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210923041252.52596-3-davvid@gmail.com>
Message-ID: <871r5e45jw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 22 2021, David Aguilar wrote:

> @@ -580,7 +574,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  		flags = 0;
>  	} else
>  		setenv("GIT_DIFFTOOL_DIRDIFF", "true", 1);
> -	rc = run_command_v_opt(helper_argv, flags);
> +	ret = run_command_v_opt(helper_argv, flags);
>  
>  	/* TODO: audit for interaction with sparse-index. */
>  	ensure_full_index(&wtindex);

Just on this part: There was already a logic error in the pre-image
where we'd return error() return values up to cmd_main() et al. This
means that (on POSIX) we return 255, not 1, per the C standard doing
this is "implementation defined".

I think you want the "rc" variable back, and either in another commit or
in some other cleanup this on top or ahead of this patch:

diff --git a/builtin/difftool.c b/builtin/difftool.c
index a867c49067c..6605d17e6bc 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -345,6 +345,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	const char *helper_argv[] = { "difftool--helper", NULL, NULL, NULL };
 	struct hashmap wt_modified, tmp_modified;
 	int indices_loaded = 0;
+	int rc;
 
 	workdir = get_git_work_tree();
 
@@ -574,7 +575,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		flags = 0;
 	} else
 		setenv("GIT_DIFFTOOL_DIRDIFF", "true", 1);
-	ret = run_command_v_opt(helper_argv, flags);
+	rc = run_command_v_opt(helper_argv, flags);
 
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(&wtindex);
@@ -660,7 +661,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	strbuf_release(&tmpdir);
 	UNLEAK(working_tree_dups);
 
-	return ret;
+	return ret < 0 ? 1 : rc;
 }
 
 static int run_file_diff(int prompt, const char *prefix,
