Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B8641F404
	for <e@80x24.org>; Sun, 25 Feb 2018 19:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeBYTrb (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 14:47:31 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37627 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751940AbeBYTrT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 14:47:19 -0500
Received: by mail-wm0-f66.google.com with SMTP id 139so256340wmn.2
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 11:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GD/PSa1AYPPjSHxFXcaqWSdjOptoNuUWOAqULlSVG40=;
        b=DNy++ooLgBqiyW3dxIP83JvGav9i99K3Rk6HpCTg8IbxVJeaT7xBOe0z0EAxZQsUzx
         qHNBHogWtPeVLSoPAcXgcMRfP8crHnvj9DD/e10xF8xl8WwMs+AEm/5cvP5d6HxxINZI
         02D84mqtNKIqgHeAkXQGK7Uws20X3uC45FJZGVgYbSQT7w7brQyRBwcy2zd69SlvfeBF
         1XlA7c9wmVyhozhIt61dds0nJEIGW0618TCD63fsQyeVdokj6Py4I6cQBA1G0QZnX4jI
         uT/JBpVRu8qjwSgeGuh32DpILP0pDV336bwYHfWiDlt69JhRRzpBQ7+3q9ceH+XEJvuT
         +yNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GD/PSa1AYPPjSHxFXcaqWSdjOptoNuUWOAqULlSVG40=;
        b=qNe0UO4jayelT/QqiAwfVeZw588jfYKoTXgklEmvTfmet4VDAgA/X5Ek5h45ZYt/jp
         IojmVZowjMq5UPoEhbjXHSqy17UyyXNFHwEQlRu4Lk7b5Gq8tfV99YvbQeb7YrshYQuj
         YvH28Th2pwA2iYlgMexqH4ZmfKL0Rz5YEJwx6WmNUOwa8ScuqGsyb9lWIN+0hCqzS8tk
         sqmnTYe8a6/T3Nv/HpQrTBOPb/869XHiFv6brLWdZNi6bBDkmZCc1qifjx0g152HeytL
         N/wBG2JxoZtxECxWTakcm1YKG2/W6nLQWNSHwNVTUFzcnZbo10Qvfgmx9w530CuUSGZJ
         8t3Q==
X-Gm-Message-State: APf1xPAOPmFo5sHwlhcvEtv//e6gAW1BvAZr4DQa3sxki7p+w5mgVWCC
        6asjH3a3nq/2S6NENTBM7tAYUN3G
X-Google-Smtp-Source: AG47ELvJDOxox1Tw1hYNYMTJMg3+1d2GDTQIdrq/G6WgqRl57oItzPshK9TG0YMAbqGC2DHYyeSulg==
X-Received: by 10.28.111.145 with SMTP id c17mr3851974wmi.74.1519588037151;
        Sun, 25 Feb 2018 11:47:17 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b66sm4394003wmg.28.2018.02.25.11.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2018 11:47:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/13] perl: move the perl/Git/FromCPAN tree to perl/FromCPAN
Date:   Sun, 25 Feb 2018 19:46:35 +0000
Message-Id: <20180225194637.18630-12-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180225194637.18630-1-avarab@gmail.com>
References: <20180225194637.18630-1-avarab@gmail.com>
In-Reply-To: <20180214222146.10655-1-avarab@gmail.com>
References: <20180214222146.10655-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the CPAN modules that have lived under perl/Git/FromCPAN since my
20d2a30f8f ("Makefile: replace perl/Makefile.PL with simple make
rules", 2017-12-10) to perl/FromCPAN.

A subsequent change will teach the Makefile to only install these
copies of CPAN modules if a flag that distro packagers would like to
set isn't set. Due to how the wildcard globbing is being done it's
much easier to accomplish that if they're moved to their own
directory.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                                | 3 +++
 perl/{Git => }/FromCPAN/.gitattributes  | 0
 perl/{Git => }/FromCPAN/Error.pm        | 0
 perl/{Git => }/FromCPAN/Mail/Address.pm | 0
 perl/Git/LoadCPAN.pm                    | 5 ++---
 5 files changed, 5 insertions(+), 3 deletions(-)
 rename perl/{Git => }/FromCPAN/.gitattributes (100%)
 rename perl/{Git => }/FromCPAN/Error.pm (100%)
 rename perl/{Git => }/FromCPAN/Mail/Address.pm (100%)

diff --git a/Makefile b/Makefile
index c56fdc14ca..7b97699864 100644
--- a/Makefile
+++ b/Makefile
@@ -2300,9 +2300,12 @@ po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
 
 LIB_PERL := $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/Git/*/*/*.pm)
 LIB_PERL_GEN := $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PERL))
+LIB_CPAN := $(wildcard perl/FromCPAN/*.pm perl/FromCPAN/*/*.pm)
+LIB_CPAN_GEN := $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_CPAN))
 
 ifndef NO_PERL
 all:: $(LIB_PERL_GEN)
+all:: $(LIB_CPAN_GEN)
 endif
 
 perl/build/lib/%.pm: perl/%.pm
diff --git a/perl/Git/FromCPAN/.gitattributes b/perl/FromCPAN/.gitattributes
similarity index 100%
rename from perl/Git/FromCPAN/.gitattributes
rename to perl/FromCPAN/.gitattributes
diff --git a/perl/Git/FromCPAN/Error.pm b/perl/FromCPAN/Error.pm
similarity index 100%
rename from perl/Git/FromCPAN/Error.pm
rename to perl/FromCPAN/Error.pm
diff --git a/perl/Git/FromCPAN/Mail/Address.pm b/perl/FromCPAN/Mail/Address.pm
similarity index 100%
rename from perl/Git/FromCPAN/Mail/Address.pm
rename to perl/FromCPAN/Mail/Address.pm
diff --git a/perl/Git/LoadCPAN.pm b/perl/Git/LoadCPAN.pm
index 1568c177fe..229c1ee87d 100644
--- a/perl/Git/LoadCPAN.pm
+++ b/perl/Git/LoadCPAN.pm
@@ -16,8 +16,7 @@ source.
 Therefore the L<Git::LoadCPAN> namespace shipped with Git contains
 wrapper modules like C<Git::LoadCPAN::Module::Name> that will first
 attempt to load C<Module::Name> from the OS, and if that doesn't work
-will fall back on C<Git::FromCPAN::Module::Name> shipped with Git
-itself.
+will fall back on C<FromCPAN::Module::Name> shipped with Git itself.
 
 Usually distributors will not ship with Git's Git::FromCPAN tree at
 all, preferring to use their own packaging of CPAN modules instead.
@@ -52,7 +51,7 @@ sub import {
 		my $Git_LoadCPAN_pm_root = File::Basename::dirname($Git_LoadCPAN_pm_path) || die "BUG: Can't figure out lib/Git dirname from '$Git_LoadCPAN_pm_path'!";
 
 		require File::Spec;
-		my $Git_pm_FromCPAN_root = File::Spec->catdir($Git_LoadCPAN_pm_root, 'FromCPAN');
+		my $Git_pm_FromCPAN_root = File::Spec->catdir($Git_LoadCPAN_pm_root, '..', 'FromCPAN');
 		die "BUG: '$Git_pm_FromCPAN_root' should be a directory!" unless -d $Git_pm_FromCPAN_root;
 
 		local @INC = ($Git_pm_FromCPAN_root, @INC);
-- 
2.15.1.424.g9478a66081

