Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C1A4203F3
	for <e@80x24.org>; Sat, 22 Jul 2017 00:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753516AbdGVAwv (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 20:52:51 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35155 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbdGVAwv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 20:52:51 -0400
Received: by mail-pf0-f195.google.com with SMTP id q85so5853673pfq.2
        for <git@vger.kernel.org>; Fri, 21 Jul 2017 17:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jeJvtewAyGhRNWulqXMnTEahgcJcIYth7Q4KFvwKcWk=;
        b=gUxUbcl/6Nwl5uwP4jkiRUSY8K1cibbx9Rucm6Y7V+bA+J2zedX/YT1p4o26ClehzU
         2riBydZhrlobEXr+DS+1TsbwicP7gsO7OufwVptpCRKbs97JoXYBbkqjaxm+oBaJOM1x
         YsAmZcJ1t+/1xALbcV6THc0kDGKjoWM3beyiRVtwWNa7gbIFEr0QmeK89FzWuW139Ft8
         9szommUwcG6vLMBtH3XikqsNlPt9RSpcDehyTO77IeDQOfXfX9dCKNBWineUtp/KR2Ks
         IC00AEdsJTsSNBSs1AFdT1Ii4wgUb2cD4vFgk1dNG3ipJT91/i/2hP/mzGSxXrYxX5WI
         ui2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jeJvtewAyGhRNWulqXMnTEahgcJcIYth7Q4KFvwKcWk=;
        b=PAkyKaKfSYJ1TEDESxzbZG/US3cQYeNX3VvQxD3eUeUSTFos3c5+CutNyP3JirZa+7
         TGIukRSHIeFnL8jl4US9C2YDYp9d+VU58CdcUZD/ES7aST6gr1g6kB0qmabMprBl+zbM
         kOcrjMI1GZGuBJ4Jesxmfymn5QPgFtUTGUExN/ppwRVuRWpfrUU1eYgbsu9SSL3ovv1U
         4QIJ8kaehwCdw2fCASZbnfR/uZf5y5TQa7d4uEo0PXUT5O5F+oohYrh6iuFrUlOf8772
         EynkYN3/ZuVyMkZfX63iYYtjkPT5tUZH1oiTmzQZ4dRIG68qJryayslrXVdWi/wsKhd5
         AaIA==
X-Gm-Message-State: AIVw113/bP8MuA7WqarQBLka4/jcrjvcR8lXd+aYzM1FeEltzkRhZJgi
        NteXHlqmCrI1IktnCP8=
X-Received: by 10.98.210.70 with SMTP id c67mr9355318pfg.6.1500684770390;
        Fri, 21 Jul 2017 17:52:50 -0700 (PDT)
Received: from localhost.localdomain ([138.68.249.68])
        by smtp.googlemail.com with ESMTPSA id h27sm10753109pfd.34.2017.07.21.17.52.48
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 21 Jul 2017 17:52:49 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] Makefile: generate pot file using a tweaked version of xgettext
Date:   Sat, 22 Jul 2017 08:52:38 +0800
Message-Id: <a87e7252bf9de8a87e5dc7712946f72459778d6c.1500684532.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.14.0.rc0.1.g3ccfa2fb49
In-Reply-To: <CANYiYbGkuGNNYn4OF5w=1+Pqn9hEHWcD+DYVB6AXRs0vFEsY2Q@mail.gmail.com>
References: <CANYiYbGkuGNNYn4OF5w=1+Pqn9hEHWcD+DYVB6AXRs0vFEsY2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of doing a sed (s|PRItime|PRIuMAX) in working tree directly, we
can use a tweaked version of gettext, which can replace PRItime macro to
PRIuMAX (version 1.x) in runtime.  We do not need to reset our working
tree anymore, and this operation can be run without a version controlled
working tree.

The tweaked version of gettext is hosted at:

    https://github.com/jiangxin/gettext

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 Makefile | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index 461c845d33..782c519133 100644
--- a/Makefile
+++ b/Makefile
@@ -2221,33 +2221,23 @@ LOCALIZED_SH += t/t0200/test.sh
 LOCALIZED_PERL += t/t0200/test.perl
 endif
 
-## Note that this is meant to be run only by the localization coordinator
-## under a very controlled condition, i.e. (1) it is to be run in a
-## Git repository (not a tarball extract), (2) any local modifications
-## will be lost.
 ## Gettext tools cannot work with our own custom PRItime type, so
-## we replace PRItime with PRIuMAX.  We need to update this to
-## PRIdMAX if we switch to a signed type later.
+## we use a hacked version of xgettext to replace PRItime with PRIuMAX.
+## We need to update this to PRIdMAX if we switch to a signed type later.
 
-po/git.pot: $(GENERATED_H) FORCE
-	# All modifications will be reverted at the end, so we do not
-	# want to have any local change.
-	git diff --quiet HEAD && git diff --quiet --cached
-
-	@for s in $(LOCALIZED_C) $(LOCALIZED_SH) $(LOCALIZED_PERL); \
-	do \
-		sed -e 's|PRItime|PRIuMAX|g' <"$$s" >"$$s+" && \
-		cat "$$s+" >"$$s" && rm "$$s+"; \
-	done
+check-xgettext:
+	@if ! $(XGETTEXT) --version | grep -q "PRItime tweak v1"; then \
+		echo >&2 "Error: must use a hacked version of xgettext, which can convert PRItime macro as we need."; \
+		echo >&2 "Error: download it from https://github.com/jiangxin/gettext"; \
+		exit 1; \
+	fi
 
+po/git.pot: check-xgettext $(GENERATED_H) FORCE
 	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
 	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_SH) \
 		$(LOCALIZED_SH)
 	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_PERL) \
 		$(LOCALIZED_PERL)
-
-	# Reverting the munged source, leaving only the updated $@
-	git reset --hard
 	mv $@+ $@
 
 .PHONY: pot
@@ -2737,6 +2727,7 @@ check-builtins::
 .PHONY: coverage coverage-clean coverage-compile coverage-test coverage-report
 .PHONY: coverage-untested-functions cover_db cover_db_html
 .PHONY: coverage-clean-results
+.PHONY: check-xgettext
 
 coverage:
 	$(MAKE) coverage-test
-- 
2.14.0.rc0.1.g3ccfa2fb49

