Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C17C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 14:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244793AbiEZOvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 10:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347853AbiEZOuv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 10:50:51 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672105622D
        for <git@vger.kernel.org>; Thu, 26 May 2022 07:50:50 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n8so1642935plh.1
        for <git@vger.kernel.org>; Thu, 26 May 2022 07:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OUJiAPQx5PYv6Bh8Z475ByWZJAcSSKSrFJcMH+GNLRU=;
        b=lJK4fc8KLWdD48U7ac086qL2weHmMHs6fzq8IEidHgQYah4bvCAYQKH0MTymNfujPT
         ld4bdamRjhZiwE70a5xYdorx+AQUM8raFY8bmxIrBqmjT9h2My5SEY8W4BiaYMSDFgoL
         CBPaWnaLo9odS/ZMNrfbjB9G5W63oFwGCoZL/PRijm0QCEhDShpKCrUnnkd64+Q8vftE
         f1JD+1Wx0oh1BG0BAnzOwxT24ki0gQ7niYL55ptU1MFzsfOlhy591DsN3JYAzZtyupaq
         eKfaI9b2B8tVyOReliUiNpRZ7UCNxw9mKVg1dW7m5nHTIw15kYVVO4ibjYb6Tjf3QLr1
         WS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OUJiAPQx5PYv6Bh8Z475ByWZJAcSSKSrFJcMH+GNLRU=;
        b=ujprf+VjdD+/9s5Gsw60VluPLlRBegxXzE26ZKlOY8PIqG2+BM/6nrhAHbJn0kQnVa
         zFDWrdInzZ3bT5mzrAvTkFcqF5+93+cMI6RAOu2Yv52pFvyc3Pa3Cu4NH3r01+1JJHyz
         wMoWWySI2xKEByF2ARJ9C9XXH657LnZSfHMQlakwb1uLxbI5f8qhjFpD5Klzd8cUiyVa
         NjUds3ad5S3UpvNtkeWXo1GwrA1c1iXxIQeMkDsgiEY3hMk/pTMGfN2i8iWZyYebnw/S
         dLgVP4JXX9Z5D9lWSrSv+ABWwzu0bWsMEyqjPcxqnEsfmkUh0+ZgkANV7Isjly8CiVVd
         +qPQ==
X-Gm-Message-State: AOAM530lzMByZMvqeR6AuFNnNy9k+baSyydRjxBpYjR65E8ikDNa9eH8
        WQWTZ0wELNAcd4PKT967Pd0=
X-Google-Smtp-Source: ABdhPJy6J9kOwgDkcSW5Kc80mNjYWJ0Pn+gm3a6ac5SjJ/hIsHoPZ+pdE0tuPKq1t6imDoFEiyvyxQ==
X-Received: by 2002:a17:902:a9ca:b0:161:54a6:af3f with SMTP id b10-20020a170902a9ca00b0016154a6af3fmr39027098plr.48.1653576649951;
        Thu, 26 May 2022 07:50:49 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i16-20020a056a00005000b00518382bceaesm1597480pfk.57.2022.05.26.07.50.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 May 2022 07:50:49 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v5 09/10] Makefile: add "po-init" rule to initialize po/XX.po
Date:   Thu, 26 May 2022 22:50:34 +0800
Message-Id: <20220526145035.18958-10-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220523152128.26380-1-worldhello.net@gmail.com>
References: <20220523152128.26380-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

The core translation is the minimum set of work that must be done for a
new language translation.

There are over 5000 messages in the template message file "po/git.pot"
that need to be translated. It is not a piece of cake for such a huge
workload. So we used to define a small set of messages called "core
translation" that a new l10n contributor must complete before sending
pull request to the l10n coordinator.

By pulling in some parts of the git-po-helper[^1] logic, we add a new
rule to create this core translation message "po/git-core.pot":

    make po/git-core.pot

To help new l10n contributors to initialized their "po/XX.pot" from
"po/git-core.pot", we also add new rules "po-init":

    make po-init PO_FILE=po/XX.po

[^1]: https://github.com/git-l10n/git-po-helper/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile      | 40 +++++++++++++++++++++++++++++++++++++++-
 po/.gitignore |  1 +
 shared.mak    |  1 +
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index efd242b255..0a5b4b4ede 100644
--- a/Makefile
+++ b/Makefile
@@ -2806,6 +2806,7 @@ po-update: po/git.pot
 	$(check_po_file_envvar)
 	@if test ! -e $(PO_FILE); then \
 		echo >&2 "error: $(PO_FILE) does not exist"; \
+		echo >&2 'To create an initial po file, use: "make po-init PO_FILE=po/XX.po"'; \
 		exit 1; \
 	fi
 	$(QUIET_MSGMERGE)$(MSGMERGE) $(MSGMERGE_FLAGS) $(PO_FILE) po/git.pot
@@ -2813,6 +2814,43 @@ po-update: po/git.pot
 .PHONY: check-pot
 check-pot: $(LOCALIZED_ALL_GEN_PO)
 
+### TODO FIXME: Translating everything in these files is a bad
+### heuristic for "core", as we'll translate obscure error() messages
+### along with commonly seen i18n messages. A better heuristic would
+### be to e.g. use spatch to first remove error/die/warning
+### etc. messages.
+LOCALIZED_C_CORE =
+LOCALIZED_C_CORE += builtin/checkout.c
+LOCALIZED_C_CORE += builtin/clone.c
+LOCALIZED_C_CORE += builtin/index-pack.c
+LOCALIZED_C_CORE += builtin/push.c
+LOCALIZED_C_CORE += builtin/reset.c
+LOCALIZED_C_CORE += remote.c
+LOCALIZED_C_CORE += wt-status.c
+
+LOCALIZED_C_CORE_GEN_PO = $(LOCALIZED_C_CORE:%=.build/pot/po/%.po)
+
+.build/pot/git-core.header: $(LOCALIZED_C_CORE_GEN_PO)
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN)$(gen_pot_header)
+
+po/git-core.pot: .build/pot/git-core.header $(LOCALIZED_C_CORE_GEN_PO)
+	$(QUIET_GEN)$(MSGCAT) $^ >$@
+
+.PHONY: po-init
+po-init: po/git-core.pot
+	$(check_po_file_envvar)
+	@if test -e $(PO_FILE); then \
+		echo >&2 "error: $(PO_FILE) exists already"; \
+		exit 1; \
+	fi
+	$(QUIET_MSGINIT)msginit \
+		--input=$< \
+		--output=$(PO_FILE) \
+		--no-translator \
+		--locale=$(PO_FILE:po/%.po=%)
+
+## po/*.po files & their rules
 ifdef NO_GETTEXT
 POFILES :=
 MOFILES :=
@@ -3348,7 +3386,7 @@ cocciclean:
 
 clean: profile-clean coverage-clean cocciclean
 	$(RM) -r .build
-	$(RM) po/git.pot
+	$(RM) po/git.pot po/git-core.pot
 	$(RM) *.res
 	$(RM) $(OBJECTS)
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
diff --git a/po/.gitignore b/po/.gitignore
index 37d1301b32..ff0e5176a6 100644
--- a/po/.gitignore
+++ b/po/.gitignore
@@ -1,2 +1,3 @@
 /build
 /git.pot
+/git-core.pot
diff --git a/shared.mak b/shared.mak
index 8cd170a7e7..4330192e9c 100644
--- a/shared.mak
+++ b/shared.mak
@@ -62,6 +62,7 @@ ifndef V
 	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
 	QUIET_LNCP     = @echo '   ' LN/CP $@;
 	QUIET_XGETTEXT = @echo '   ' XGETTEXT $@;
+	QUIET_MSGINIT  = @echo '   ' MSGINIT $@;
 	QUIET_MSGFMT   = @echo '   ' MSGFMT $@;
 	QUIET_MSGMERGE = @echo '   ' MSGMERGE $@;
 	QUIET_GCOV     = @echo '   ' GCOV $@;
-- 
2.36.0.1.g15c4090757

