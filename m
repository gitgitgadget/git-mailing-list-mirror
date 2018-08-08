Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C98D208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeHHR2y (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:28:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39566 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeHHR2y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:28:54 -0400
Received: by mail-ed1-f66.google.com with SMTP id h4-v6so1425402edi.6
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n8rZ+CEFju32GaZ8xRq9yXtgpQZTEx3H465fASddhZw=;
        b=Aj0nIrHlZL/Yf0fH0lHKmgZxuJKCJ2cj+/j2SniKFG7RxsYdwzSJs4MV5SrRosonT8
         7jtaZkney8CwaFK+DY3vyS692up85Ae6XQ4hT66oWKw3ZU7NnzM4cAWyx7pNNsRROK6H
         XeUCAKdVDxa617mejyyIJFTSiKClOBWu9tpJsFfcEQV1dhUajN2wIhDCjFwZu2R2vEtq
         TojL7V/GHsttpKO0UVxT1ekHfXj3SGVOoyufB+diO4yUkNByzDgq1XVRr/cD2Lq3IA4I
         IYVlugjiU7yxGdW5IXM4q92Eow31LVr+TunzOj1FQl9qDtE3lUVO+Eu8/HIwaT9eGczQ
         MALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n8rZ+CEFju32GaZ8xRq9yXtgpQZTEx3H465fASddhZw=;
        b=o44Ldytp5MzAsPYfPpYcfdU66VmYjj0VLznNkHNsORCo6141bJqd9DSRJKVYVizL1r
         dSsk0XjOstFpld4dXZdX8whVOjIHOdSZ6ATx0ULw2s2lw26aIUJPzGuyx9pFi8Osn2pJ
         xiToKpbPveidSr0xGFMu0w9j2ySMC4RQFcOGd3qUJRpmlUcVELOw1bjLYDQGx5kIdmN+
         NZCIHpZ/s59neDXCGo3zQYHzkSkwazAmm4OtR2vMvhgA+41LpFv6UUkHecG9ZFHygH+c
         cvfMm8ZtGBtwqWL3+WcO3tZAz3GSgHwGz6UgOK9ZwKrNIxeopg2/1cwkmh4SnJy5bz2N
         aVKg==
X-Gm-Message-State: AOUpUlGBydCFAKm/Chxhr/Id+dxkSZr3NCmMVmpziqs15cd173J822nQ
        evx3uOlupOJcdNJJnUVIObTliMmc
X-Google-Smtp-Source: AA+uWPwLpQyG/oxgQfG4EmuvAA6az35zItGGDzTlqkZo6r1ljzXmIzJX77ieUUKxIUN9SrqIz/b5XQ==
X-Received: by 2002:aa7:d40a:: with SMTP id z10-v6mr3736242edq.203.1533740928530;
        Wed, 08 Aug 2018 08:08:48 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id w1-v6sm6771259eda.63.2018.08.08.08.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:08:47 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 4/7] builtin rebase: support --quit
Date:   Wed,  8 Aug 2018 20:51:19 +0545
Message-Id: <20180808150622.9614-5-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808150622.9614-1-predatoramigo@gmail.com>
References: <20180808150622.9614-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With this patch, the builtin rebase handles the `--quit` action which
can be used to abort a rebase without rolling back any changes performed
during the rebase (this is useful when a user forgot that they were in
the middle of a rebase and continued working normally).

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 8e94f6cc85..0d805480a1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -471,6 +471,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		ACTION_CONTINUE,
 		ACTION_SKIP,
 		ACTION_ABORT,
+		ACTION_QUIT,
 	} action = NO_ACTION;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
@@ -500,6 +501,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "abort", &action,
 			    N_("abort and check out the original branch"),
 			    ACTION_ABORT),
+		OPT_CMDMODE(0, "quit", &action,
+			    N_("abort but keep HEAD where it is"), ACTION_QUIT),
 		OPT_END(),
 	};
 
@@ -628,6 +631,14 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		ret = finish_rebase(&options);
 		goto cleanup;
 	}
+	case ACTION_QUIT: {
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, options.state_dir);
+		ret = !!remove_dir_recursively(&buf, 0);
+		if (ret)
+			die(_("could not remove '%s'"), options.state_dir);
+		goto cleanup;
+	}
 	default:
 		die("TODO");
 	}
-- 
2.18.0

