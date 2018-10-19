Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E2AF1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 16:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeJTAT2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 20:19:28 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40704 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbeJTAT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 20:19:28 -0400
Received: by mail-qt1-f194.google.com with SMTP id b4-v6so38856755qtc.7
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 09:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O9bzCs0rDvQqTzkEpqdmPYnhCJ4ZOCGrni9vIcOWmRE=;
        b=C6IHrj70H1F1BhiPtOEP4WdNbGxAjGVeL6LbG/FyXgP2rZR8SAg1KV4O2+kCRI8/mc
         9lp6CBRzE3vC0cPS42Q+atXXVL3rtFb3sbiZYZoKByKoqn+NiiMh2eD4jXap2XUBVTZu
         YetzuUJ9SGq2KxXUdNIf/X3NUN/MRgeLqBb2LpHZMV3SxseanH/xBSZ7DhcQ+XIjzfwl
         BFsTtRmYtAaEdAhQWEGr4h2NEG7BedMHX6ADnoD1gXMwaBEv80Ro4wQJUABEPFYIbpIw
         9/JOhTpuCX47ZLDk2dEous9d+L9GbMOE/pJnbsvaxNpDo/MAEHgCtf079noDcnm5So5a
         yh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O9bzCs0rDvQqTzkEpqdmPYnhCJ4ZOCGrni9vIcOWmRE=;
        b=EnYZs947GB78r/jo86SKCU5yr2l6dGYCPIKgyG0CdUvdB6YhdppgljO16nj4ELYnRv
         ZgCDWQqrNEdDQU7lNUDN0TQcJnpkmpYxa68+yBfWtlANbjCrko9CZNYVwwase4Fw2xky
         aaqRc+mpDPL3XkV4R8YbhzLcVCBikssyCWNcQqL7d2JPZmnQQAIBu1o+RMbWl+ABB/p8
         H7dwP4HEGQqB/W7iNqNF5OZeaJwHvBN1g2x75MOJDERrakmt7phyzUMTVDZ9YSD/6GWW
         c78ur1MC43yJm5/Ey+Rg33DyPQqEhGe4sb1QIZjn7Ap5nOzFBDsRQDZcMJJQijdUNc4F
         L8LA==
X-Gm-Message-State: ABuFfoivLRdzmNL0gwz75s9ARyzP0lGAnhePAL0OHb73hxx1+VTCKmQq
        FPwbHAmREolpleZJYFMYOsDRfUQRRIY=
X-Google-Smtp-Source: ACcGV60tOrYFO5KuVMW2FmrxguaFiUqWeOHyJZ6CqQKpdW5wTOkrj9CqfOHND9g1Yh3kyZIKnnZgeQ==
X-Received: by 2002:ac8:33d6:: with SMTP id d22-v6mr33410362qtb.313.1539965561295;
        Fri, 19 Oct 2018 09:12:41 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id l27-v6sm3666485qkj.79.2018.10.19.09.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 09:12:40 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, peartben@gmail.com,
        peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v2 2/3] reset: add new reset.quiet config setting
Date:   Fri, 19 Oct 2018 12:12:27 -0400
Message-Id: <20181019161228.17196-3-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181019161228.17196-1-peartben@gmail.com>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181019161228.17196-1-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Add a reset.quiet config setting that sets the default value of the --quiet
flag when running the reset command.  This enables users to change the
default behavior to take advantage of the performance advantages of
avoiding the scan for unstaged changes after reset.  Defaults to false.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/config.txt | 3 +++
 builtin/reset.c          | 1 +
 2 files changed, 4 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f6f4c21a54..a2d1b8b116 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2728,6 +2728,9 @@ rerere.enabled::
 	`$GIT_DIR`, e.g. if "rerere" was previously used in the
 	repository.
 
+reset.quiet::
+	When set to true, 'git reset' will default to the '--quiet' option.
+
 include::sendemail-config.txt[]
 
 sequence.editor::
diff --git a/builtin/reset.c b/builtin/reset.c
index 04f0d9b4f5..3b43aee544 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -306,6 +306,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_reset_config, NULL);
+	git_config_get_bool("reset.quiet", &quiet);
 
 	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
-- 
2.18.0.windows.1

