Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CBB01F597
	for <e@80x24.org>; Wed,  1 Aug 2018 18:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732930AbeHAUaY (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 16:30:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50194 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387741AbeHAUaY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 16:30:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so116709wmc.0
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 11:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=tavp4rWYs1xg0kc8zNOL8rmTUHylWRPcaMwrJQao8Hk=;
        b=d2fB5Hy71c5GIFjMFuc6gNWHU2+yR90auwbSBIF0cizQAZMB4F2zYvDdcYHiqzNyR5
         CsWxEU1kvH2zO7ZWBd0jKeL0OxTV5jBVn1V4Ev8YvWn88zp53J7qpO01P4Rh5TFMcrnD
         kTbRHFS6pPxhF1JnyHI6xkEEF8mRCqBq14IHXxCVfSJGW2QcN7r220La2dXH16Yy0fuM
         4ckuy9L43MpimkPZ0e4SYlAlxXkLNrxO5diOrewCD2hTBRRNG0htdP5UNjTNQsgu6VWP
         R0ugSr+p2rgM7QymfKmoaDoi3ZctFBpF7hdqfuiZvJBqrZ7gqPZpYiolqfkR7vQ4jaqw
         lj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=tavp4rWYs1xg0kc8zNOL8rmTUHylWRPcaMwrJQao8Hk=;
        b=Z8vErFbY1HJfC2lKcIgbV+DbCKnjs4VpbUcLQzcCLbs7awjcBJs7q/2zmfQCpohAj4
         zhvoPOGEmhqHo7nw8IuLau7+RDbHaMaoKJo6Yy4SgGzE9Cy3nICnAAa+/POwo/4ZeX63
         mzumcB3W2C1/irOg8xpB36LXf9PKIGD2XM+RNEB/FODhgSmUWtMORS9LEI+h6kIkWTS/
         dfybpWxiVMb8Ce64+N0pQ0mPA4m7ju22m7KyjAsDHvRVJRmZqyo2SIVWSX71i1nDna/c
         z6umTX5BFSg2W5vlyssj6JCsoKvLHOVuasbLiTaHkzTB+a8VIWjz4HU7JnU6DMrQ480d
         E13w==
X-Gm-Message-State: AOUpUlGizuYYn/3Gc+hIlq92+VIJD0tcduDObOjaa4xtUEe1lqYfe2sH
        dZWhSn6AsvRA+D70TvNygcOdRAov
X-Google-Smtp-Source: AAOMgpc/9kA107c8yjEai/XqBo4uhIHpU2V9mSmWX3MVzutks8gEPiOf0vhWFJiVpoFez/jtDPqxcg==
X-Received: by 2002:a1c:7301:: with SMTP id d1-v6mr44009wmb.34.1533148996528;
        Wed, 01 Aug 2018 11:43:16 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y191-v6sm84047wmy.4.2018.08.01.11.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 11:43:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] push: comment on a funny unbalanced option help
Date:   Wed, 01 Aug 2018 11:43:15 -0700
Message-ID: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The option help text for the force-with-lease option to "git push"
reads like this:

    $ git push -h 2>&1 | grep -e force-with-lease
       --force-with-lease[=<refname>:<expect>]

which come from this

 		  0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),

in the source code, with an aparent lack of "<" and ">" at both
ends.

It turns out that parse-options machinery takes the whole string and
encloses it inside a pair of "<>", expecting that it is a single
placeholder.  The help string was written in a funnily unbalanced
way knowing that the end result would balance out.

Add a comment to save future readers from wasting time just like I
did ;-)

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/push.c b/builtin/push.c
index 9cd8e8cd56..9608b0cc4f 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -558,6 +558,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRANSPORT_PUSH_PORCELAIN),
 		OPT_BIT('f', "force", &flags, N_("force updates"), TRANSPORT_PUSH_FORCE),
 		{ OPTION_CALLBACK,
+		  /* N_() will get "<>" around, resulting in "<refname>:<expect>" */
 		  0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
 		  N_("require old value of ref to be at this value"),
 		  PARSE_OPT_OPTARG, parseopt_push_cas_option },
-- 
2.18.0-321-gffc6fa0e39

