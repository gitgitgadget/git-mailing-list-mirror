Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 849F41F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 06:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbeKTQnM (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 11:43:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36485 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730652AbeKTQnM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 11:43:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so436525pgm.3
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 22:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0cHq+ouaS9kEFB2KDSShfYT6IcBItf7xgS/gEdwjJ6w=;
        b=gUEmQIZpOeedrpmAJo+96QVzmX/t0pm1fesFfU7m5QP6e5HMuVGqbFUdbiI2vLv6fF
         R2kLPvXmzgd5epSdd1XZyD/Y4uI329QJmpTdIVeKIWdLhvlKrfF5Fj2+UTsY4hBVnu5u
         Aoya4pADD83teJk3YnfBuDrEDlRRs17Fi8N8CzgR1qS6WzaXm62Ejz734dGv8PP6CeNV
         NsYXIW8iEMslRoXdclqr0S3eP5XRVYPxvOmsp/D52qSMnhQiHQXld3tCmYaVebH3x27g
         DrYABsJN8Q4336QJ0Z3r8b3UfVw5fAJKkhJ4oI9bLbO0FuGN5gzqreddW2GCiTR3kd7P
         JrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0cHq+ouaS9kEFB2KDSShfYT6IcBItf7xgS/gEdwjJ6w=;
        b=jBR61Ry//ZroS24ALfKBKRHQFl5Jr7NB2mx/Lr3qFx26f+ck+9I5GikIzkHdsYqC1u
         oDaecFV07avzpN6Y3u8AFBlVfutTkwUaBr9ERdLHrVWF++dHDcJYqZMpNrO18umy/Oqv
         EJZlTeKdABjnDjWLvfPKf3cqDK2k3X2f3AFAkc2J9P31X5hNTsgBhiGya+yH8WeLmqGt
         gC+zZ05b95SS6J6YKC0EnHlu6XECaTeaSF/ZYwSzLIZeXeY7BNKWDZnTRUd8XW1S6q53
         Q52ug1PqorkfWhxJWqur9yyFNbfHSXEMy+0v6iLLE+SDcu9p1walFqLX9dCz2NZNfJm0
         WeyA==
X-Gm-Message-State: AA+aEWbbNNdKxX14ns6vuezrLOoIKCJhgexYrnOLeJqreHHShaVN3/gV
        6+Fng0bTnmwMzKpqkm5y/iY=
X-Google-Smtp-Source: AFSGD/W/iskvnSDZSUmnteRfYSsKzpQkIdSAy650p9Q41N/qjIRcTtiyTLzkjyQ2OeN26lPpkgu7Ug==
X-Received: by 2002:a63:62c3:: with SMTP id w186mr742856pgb.345.1542694547093;
        Mon, 19 Nov 2018 22:15:47 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id l187-v6sm48180317pfc.79.2018.11.19.22.15.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 22:15:46 -0800 (PST)
Date:   Mon, 19 Nov 2018 22:15:44 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>,
        jonathantanmy@google.com
Subject: [PATCH 5/5] index: offer advice for unknown index extensions
Message-ID: <20181120061544.GF144753@google.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com>
 <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
 <20181120060920.GA144753@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120060920.GA144753@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is not unusual for multiple distinct versions of Git to act on a
single repository.  For example, some IDEs bundle a particular version
of Git, which can be a different version from the system copy of Git,
or on a Mac, /usr/bin/git quickly goes out of sync with the Homebrew
git in /usr/local/bin/git.

When a newer version of Git writes an index file that an older version
of Git does not know how to make full use of, this is a teaching
opportunity.  The user may not be aware of what version of Git they
are using.  Print an advice message to help the user to use the most
full featured version of Git (e.g. by futzing with their PATH).

  warning: ignoring optional IEOT index extension
  hint: This is likely due to the file having been written by a newer
  hint: version of Git than is reading it.  You can upgrade Git to
  hint: take advantage of performance improvements from the updated
  hint: file format.
  hint:
  hint: You can run "git config advice.unknownIndexExtension false"
  hint: to suppress this message.

This replaces the message

  ignoring IEOT extension

that existed previously and did not provide enough detail for a user
to act on it or suppress it.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
New, based on Junio's hints about the message removed in patch 3/5.

That's the end of the series.  Thanks for reading, and thanks again
for your help so far.

 advice.c     |  2 ++
 advice.h     |  1 +
 read-cache.c | 11 +++++++++++
 3 files changed, 14 insertions(+)

diff --git a/advice.c b/advice.c
index 5f35656409..91a55046fd 100644
--- a/advice.c
+++ b/advice.c
@@ -24,6 +24,7 @@ int advice_add_embedded_repo = 1;
 int advice_ignored_hook = 1;
 int advice_waiting_for_editor = 1;
 int advice_graft_file_deprecated = 1;
+int advice_unknown_index_extension = 1;
 int advice_checkout_ambiguous_remote_branch_name = 1;
 
 static int advice_use_color = -1;
@@ -78,6 +79,7 @@ static struct {
 	{ "ignoredHook", &advice_ignored_hook },
 	{ "waitingForEditor", &advice_waiting_for_editor },
 	{ "graftFileDeprecated", &advice_graft_file_deprecated },
+	{ "unknownIndexExtension", &advice_unknown_index_extension },
 	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
 
 	/* make this an alias for backward compatibility */
diff --git a/advice.h b/advice.h
index 696bf0e7d2..8da0845cfc 100644
--- a/advice.h
+++ b/advice.h
@@ -24,6 +24,7 @@ extern int advice_add_embedded_repo;
 extern int advice_ignored_hook;
 extern int advice_waiting_for_editor;
 extern int advice_graft_file_deprecated;
+extern int advice_unknown_index_extension;
 extern int advice_checkout_ambiguous_remote_branch_name;
 
 int git_default_advice_config(const char *var, const char *value);
diff --git a/read-cache.c b/read-cache.c
index 002ed2c1e4..d1d903e5a1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1727,6 +1727,17 @@ static int read_index_extension(struct index_state *istate,
 			return error("index uses %.4s extension, which we do not understand",
 				     ext);
 		trace_printf("ignoring %.4s extension\n", ext);
+		if (advice_unknown_index_extension) {
+			warning(_("ignoring optional %.4s index extension"), ext);
+			advise(_("This is likely due to the file having been written by a newer\n"
+				 "version of Git than is reading it. You can upgrade Git to\n"
+				 "take advantage of performance improvements from the updated\n"
+				 "file format.\n"
+				 "\n"
+				 "Run \"%s\"\n"
+				 "to suppress this message."),
+			       "git config advice.unknownIndexExtension false");
+		}
 		break;
 	}
 	return 0;
-- 
2.20.0.rc0.387.gc7a69e6b6c

