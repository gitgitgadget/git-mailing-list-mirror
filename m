Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6E3C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 11:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E102F22209
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 11:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt/Xet6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgIPLoo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 07:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgIPKcq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 06:32:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162E1C06121E
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:15 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w5so6317905wrp.8
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZUGgYiXbI+kwOXhbioUSqfAvb5eTbe245oPLj6OI7V8=;
        b=gt/Xet6Zjpb3RCuuvTTTaurlfkmO+XcOiGpu/06HxXt5BOoWBpkPiWwqDdR5NtuORl
         9e1fcgCumpIZ7snqG4VSVAYY47Oqj7XcxFKk+M79LqqGeVFquzosLh8+UjngT97UwXTV
         DFAhDv494B8/e3oa21cR9YiNUNZzc6r28nN2xxWfFSqH0lnJWXi9aW4pjEVApQnPXmLj
         pfmOQTXzhqmxCNgDuPo5I2IWBfF6cRwybOlvlEHXFduhTTWsRrvoyddOuhIXrLtrE9T+
         Gfh8Ih286Xwzj+iwVmjTA+hg2JDFt/tjkOoE8jf1dZjHj2fdrVibmZO8VINbnOgBNrzd
         Pc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZUGgYiXbI+kwOXhbioUSqfAvb5eTbe245oPLj6OI7V8=;
        b=jYNVMfU0wxvIx4/m8/6fQ4ZVN5r/HqnYB2XamPSr/hjOia7sU9heUDxR54Gzc9cBpI
         dn2R4FouItVQoEQdLm6TT3JIutCFIwzxDxYdji/zTH9ARw+tZmZC9FvEIzj58vh5E3Dj
         4DZhZZtMgdiG7gR5w/EZA5Ae3dMLBj1VrtJXJl9fF/bhUK/jYJ5J5Pb6dTIStfFHYgMY
         z7HXr8/QJcEyDAmLmsMtAQbJdlVlPhQCDmrmyvkQFRVFug1BWGDR1l/o+mmRWjpPf6nT
         4tcUjYYZXSXuwsoJgu3FNRr5UCCjUuMJM+20ONSg2EjQAjhmY1uJuyTRBocfXa4sJhs9
         dyrw==
X-Gm-Message-State: AOAM533CorZlI9P/hOg1b/F2NKDjMyN03LGTg6YPi7CKqfBgSjC2K19I
        SEDNTdf46HbY+50dMWD4neAYL+Oof9dRoMQt
X-Google-Smtp-Source: ABdhPJz6JRvCvIbAvVvy1wmpV90YwyPLOkOrIC/KPD+yF6ChqaYiLRcUBycMfCdCUlkJwJDN6yn/Bg==
X-Received: by 2002:adf:f084:: with SMTP id n4mr2731923wro.26.1600252213502;
        Wed, 16 Sep 2020 03:30:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n11sm32172916wrx.91.2020.09.16.03.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 03:30:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/15] remote-mediawiki: fix duplicate revisions being imported
Date:   Wed, 16 Sep 2020 12:29:17 +0200
Message-Id: <20200916102918.29805-15-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Simon Legner <Simon.Legner@gmail.com>

Fix a bug with revisions being imported twice. This commit is being
backported from Git-Mediawiki.git's e41ee9b ("All revisions imported
twice", 2018-02-02) to git.git. See [1] for the original commit and
[2] and [3] for the upstream PR and issue.

1. https://github.com/Git-Mediawiki/Git-Mediawiki/commit/e41ee9b3a32416df381cdc79f63350665c84151e
2. https://github.com/Git-Mediawiki/Git-Mediawiki/pull/61
3. https://github.com/Git-Mediawiki/Git-Mediawiki/issues/29

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index 08190e23e1..26d5e1a174 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -807,7 +807,10 @@ sub get_more_refs {
 sub mw_import {
 	# multiple import commands can follow each other.
 	my @refs = (shift, get_more_refs('import'));
+	my $processedRefs;
 	foreach my $ref (@refs) {
+		next if $processedRefs->{$ref}; # skip duplicates: "import refs/heads/master" being issued twice; TODO: why?
+		$processedRefs->{$ref} = 1;
 		mw_import_ref($ref);
 	}
 	print {*STDOUT} "done\n";
-- 
2.28.0.297.g1956fa8f8d

