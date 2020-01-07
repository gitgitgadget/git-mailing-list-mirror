Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8C0C282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 23:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A9A20715
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 23:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOHogLdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbgAGXMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 18:12:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39578 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgAGXMf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 18:12:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so1422498wrt.6
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 15:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2MrGbrsiSnabOrwXe8jhNznUIg9k6FtEp0kxRDbTmcI=;
        b=SOHogLdSLfeFKNJ4edaj84D8T3D1q4J81OghCZuAONpbtWLLxaiPv/PdklAdsiWvB/
         PNPMQwCAhE3BX6y8JL5MpuzfKIbMC/ZnB1Ki5pbq5JrHYxc0PLqtbhBbgqWEFh5yGWvR
         JBGp7jirsGkzd9AzLNVOwJrJgRDIquGcHsguaBaEurE+kAxwUGegmDT3U9uJr8R51X7i
         noYGhcAjg6KcOC9Ej2DoacEyYJtaXQ3QHPfYXhS5K/oA0468gVxh1ojvyk2ff48cCkc3
         1T2hhi7LeZDRDrtjZXdhQ22znpQ3PA+jPVgmFfKHY87NfI7HHaoUeanN797xvCz4sR5r
         wisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2MrGbrsiSnabOrwXe8jhNznUIg9k6FtEp0kxRDbTmcI=;
        b=nwPNesvRnAxcWHXLPCoxBwKFMA6KsbS33fLS0qEdSXV+cZU5voTOosEhcyj9q2YsOf
         s1JJJ0QytU9yE5LtMRUHFpnO9fpvG3WjxU1n+UiF9e1Kzl2cfNeto1fRAkRsY7mu8zZL
         b4y3nev5/58psK7C4j/TD0kXaqLQ6PbHpMbO2/cgfSsACAGoVTVdPQgOKHBaSPWvSX09
         dLhW1ek8KPSy0GVItgdONv1Hhh/HOW9RlJgMuGVMgiHiC7C1sxsaF88mIq/lMt19vryT
         /as79lI8Sav6wgBdHUlnrR+hvGh8JsbuDYW7He123MUHdOsxmZIEvNJfYlr+M8eTFdER
         OLqQ==
X-Gm-Message-State: APjAAAXmpJaq/QQoDuVpgP0AwvqyTIZOBkC8jBqIs0jsb3fjX0AUqWgj
        88kpwb0+Du/kw5IkHViqXxHtd/04
X-Google-Smtp-Source: APXvYqwRIlBaq7tJshhdq5pLihNI0+AVpDQXKHFaIS86q0gQmMjmavNzK/eu8tFNIDAm5DiM59C0lQ==
X-Received: by 2002:adf:9c8a:: with SMTP id d10mr1361574wre.156.1578438753322;
        Tue, 07 Jan 2020 15:12:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16sm1711099wrm.65.2020.01.07.15.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 15:12:32 -0800 (PST)
Message-Id: <pull.508.v2.git.1578438752.gitgitgadget@gmail.com>
In-Reply-To: <pull.508.git.1577934241.gitgitgadget@gmail.com>
References: <pull.508.git.1577934241.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 23:12:31 +0000
Subject: [PATCH v2 0/1] [Outreachy] add: use advise function to display hints
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The advise function in advice.c provides a neat and a standard format for
hint messages, i.e: the text is colored in yellow and the line starts by the
word "hint:". Also this will allow us to control the hint messages based on
advice.* configuration variables.

This patch suggests using this advise function whenever displaying hints to
improve the user experience, as the user's eyes will get used to the format
and will scan the screen for the yellow hints whenever confused instead of
reading all the output lines looking for advice.

Heba Waly (1):
  add: use advise function to display hints

 advice.c       | 2 ++
 advice.h       | 1 +
 builtin/add.c  | 6 ++++--
 t/t3700-add.sh | 2 +-
 4 files changed, 8 insertions(+), 3 deletions(-)


base-commit: 0a76bd7381ec0dbb7c43776eb6d1ac906bca29e6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-508%2FHebaWaly%2Fformatting_hints-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-508/HebaWaly/formatting_hints-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/508

Range-diff vs v1:

 1:  90608636bf ! 1:  9f9febd3f4 add: use advise function to display hints
     @@ -6,8 +6,43 @@
          it provides a neat and a standard format for hint messages, i.e: the
          text is colored in yellow and the line starts by the word "hint:".
      
     +    Also this will enable us to control the messages using advice.*
     +    configuration variables.
     +
          Signed-off-by: Heba Waly <heba.waly@gmail.com>
      
     + diff --git a/advice.c b/advice.c
     + --- a/advice.c
     + +++ b/advice.c
     +@@
     + int advice_checkout_ambiguous_remote_branch_name = 1;
     + int advice_nested_tag = 1;
     + int advice_submodule_alternate_error_strategy_die = 1;
     ++int advice_add_nothing = 1;
     + 
     + static int advice_use_color = -1;
     + static char advice_colors[][COLOR_MAXLEN] = {
     +@@
     + 	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
     + 	{ "nestedTag", &advice_nested_tag },
     + 	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
     ++	{ "addNothing", &advice_add_nothing },
     + 
     + 	/* make this an alias for backward compatibility */
     + 	{ "pushNonFastForward", &advice_push_update_rejected }
     +
     + diff --git a/advice.h b/advice.h
     + --- a/advice.h
     + +++ b/advice.h
     +@@
     + extern int advice_checkout_ambiguous_remote_branch_name;
     + extern int advice_nested_tag;
     + extern int advice_submodule_alternate_error_strategy_die;
     ++extern int advice_add_nothing;
     + 
     + int git_default_advice_config(const char *var, const char *value);
     + __attribute__((format (printf, 1, 2)))
     +
       diff --git a/builtin/add.c b/builtin/add.c
       --- a/builtin/add.c
       +++ b/builtin/add.c
     @@ -16,7 +51,8 @@
       		for (i = 0; i < dir->ignored_nr; i++)
       			fprintf(stderr, "%s\n", dir->ignored[i]->name);
      -		fprintf(stderr, _("Use -f if you really want to add them.\n"));
     -+		advise(_("Use -f if you really want to add them.\n"));
     ++		if (advice_add_nothing)
     ++			advise(_("Use -f if you really want to add them.\n"));
       		exit_status = 1;
       	}
       
     @@ -25,7 +61,8 @@
       	if (require_pathspec && pathspec.nr == 0) {
       		fprintf(stderr, _("Nothing specified, nothing added.\n"));
      -		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
     -+		advise( _("Maybe you wanted to say 'git add .'?\n"));
     ++		if (advice_add_nothing)
     ++			advise( _("Maybe you wanted to say 'git add .'?\n"));
       		return 0;
       	}
       

-- 
gitgitgadget
