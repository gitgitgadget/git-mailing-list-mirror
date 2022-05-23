Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D11C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 01:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiEWB1y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 May 2022 21:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351844AbiEWBZv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 May 2022 21:25:51 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F8138782
        for <git@vger.kernel.org>; Sun, 22 May 2022 18:25:50 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y199so12342531pfb.9
        for <git@vger.kernel.org>; Sun, 22 May 2022 18:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VFvm0Cs3bg+dqkeMz7Dij/QpnIKBVVAi5WT/SaeElO0=;
        b=Mb6y8CMCTvwq+n7Y+o64koLqKu6bCr0mSKUiArhmqL7ACVagSHbCCOa3mVeB/V2R15
         felenmrhNXwRN+C1FT+kzdlzCpvtgrJqBBH0lqIASs71sTGD6y3bd8g+mD0bkx0iQZh5
         Tf69Ou63uPQnpAZSZ1Cbf9wycE1rzF2ab69a91ujr5GnZvl0t3PfPd9OkymV9wPOgaXW
         AAlNKdeJh7oVKjf7/n2PDfZjTTYgDWWLY9uRfbvQyD8siThtpM5/b297I34oS387Zded
         /gsxj/OvZIsaiIlFgISzXW4u5MKmN2TCviTlfId/pdnOYWUpWfKBiOuuCsyO+z62sLsu
         rPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VFvm0Cs3bg+dqkeMz7Dij/QpnIKBVVAi5WT/SaeElO0=;
        b=49UA/z+Fb6NinyhlqPA7nAfEYWOflGjBdEitk0I5U3S5+43Ue4YKXNTysyMmJ7Nvjg
         1dNYGsfyx502NAI3yZHS6C8rG5Ylve3McyHra7g3QdxKBRcL3ANSJwpYK6PGdlHjbij9
         xQMtsYpGHy1DTzhZd8wza/ZvgQMU5XVnC25Cvc82t3130aeAbRwHVIlJ+nYtu/QuIWVj
         Mv2GtkOIQifkN5+b/Q2rwfnpXS225TJ+Az0wm8W/L7z9YmzYvkl4dVdIT48QTZMliM9I
         wSrktK/zxLoy98kVz0Sds6wTFyLJC2bB1IMDGXjoj9W5jQ+67TFGGHh4wE7HpGb20wJ9
         kW5A==
X-Gm-Message-State: AOAM531OVdyZydKveYsYu+kxLbTxmOxnRjtBrPTt/f6GAew11dN6op0B
        vx18U2QMYH7H1YWxWmWPV4s=
X-Google-Smtp-Source: ABdhPJxqaJd77085SSQy73M1Uz2gJkiBhlVX/zgFwwCreqk/l25XRYEqHlx6v0Jo/doCh83wevyr0A==
X-Received: by 2002:a63:8342:0:b0:3fa:7b7e:8a4 with SMTP id h63-20020a638342000000b003fa7b7e08a4mr348652pge.254.1653269150113;
        Sun, 22 May 2022 18:25:50 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id n26-20020aa7985a000000b00518142f8c37sm6027566pfq.171.2022.05.22.18.25.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2022 18:25:49 -0700 (PDT)
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
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 8/9] Makefile: add "po-init" rule to initialize po/XX.po
Date:   Mon, 23 May 2022 09:25:30 +0800
Message-Id: <20220523012531.4505-9-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220519081548.3380-1-worldhello.net@gmail.com>
References: <20220519081548.3380-1-worldhello.net@gmail.com>
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

By pulling in some parts of the git-po-helper[^1] logic, we add rule
"core-pot" to create this core translation message "po/git-core.pot":

    make core-pot

To help new l10n contributors to initialized their "po/XX.pot" from
"po/git-core.pot", we also add new rules "po-init":

    make po-init PO_FILE=po/XX.po

[^1]: https://github.com/git-l10n/git-po-helper/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile      | 41 +++++++++++++++++++++++++++++++++++++++++
 po/.gitignore |  1 +
 shared.mak    |  1 +
 3 files changed, 43 insertions(+)

diff --git a/Makefile b/Makefile
index 09cbde4c2a..d3eae150de 100644
--- a/Makefile
+++ b/Makefile
@@ -2808,6 +2808,7 @@ po-update: po/git.pot
 	$(check_po_file_envvar)
 	@if test ! -e $(PO_FILE); then \
 		echo >&2 "error: $(PO_FILE) does not exist"; \
+		echo >&2 'To create an initial po file, use: "make po-init PO_FILE=po/XX.po"'; \
 		exit 1; \
 	fi
 	$(QUIET_MSGMERGE)$(MSGMERGE) $(MSGMERGE_FLAGS) $(PO_FILE) po/git.pot
@@ -2815,6 +2816,46 @@ po-update: po/git.pot
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
+.PHONY: core-pot
+core-pot: po/git-core.pot
+
+.build/pot/git-core.header: $(LOCALIZED_C_CORE_GEN_PO)
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN)$(gen_pot_header)
+
+po/git-core.pot: .build/pot/git-core.header $(LOCALIZED_C_CORE_GEN_PO)
+	$(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $^ >$@
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

