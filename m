Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CCB820285
	for <e@80x24.org>; Wed, 28 Jun 2017 21:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbdF1V6f (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 17:58:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32814 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbdF1V6d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 17:58:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id j85so13885762wmj.0
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 14:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3iF9AnMfQViKMClTe6Zr3vk9TNJgfu+27sdC3ZkJfC4=;
        b=AEcWKSQmz2HsnWOd1/dGtADJ0FIrI5oLGlMTue9N+NhTGeFJOISDnAvIu3rsC37hb2
         1zYGbsNCTxpOqqk9jJ8oIqjDdK7++P5W1QJXzIVmsuNzdhl10Fp0RYKuc6xYVZSwBA+a
         euiOrre8nhSUJeWfXHETJA+z34TIn2OLIZuCeywe22ayEn1Bozx+eTa5nxPV+eQpiU7m
         4iOVcar7ccHc0sByI8muog4cutAlopROcG/dZW5/VMq14KI1VrYuVvoHynn3gQOFgrNc
         wG3cP1UY/AAPgf75xjHgH1sh0Ia7ijB3igSJeGjmMaKmwXieRZyczzgIJvy9g1Vfh2JF
         bPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3iF9AnMfQViKMClTe6Zr3vk9TNJgfu+27sdC3ZkJfC4=;
        b=hT0Uj8B8MYplskvJfvTe384HP7+zgS0pWaZWy6RsqDLZdyaAZRIWuvmeFbEftiHQtp
         HIWl27QuPYqxbZDAHSMyKMy8kZsYaD4Ki4thmFt5f6DpK3fMn2IUxVAVoCS5rg6efX7t
         b26c0TFNNiIhZj5iE05VRAnqdmarOuJDHRhhpZ+JaU8fI+wJZrZqgXaVcW/Jwl+FVku+
         NTuyN4oUy6o2+MhajJDNfkAUgdF8J3e5IUHl7fr76nCXYgTvztcbMw73Ea85Mfmwvx5k
         0LkdTwxCfvD/xzYEMH2lFBdRd7F64d73NddckAUgU+2CxNkYQf21MTfx/0/HssYZnJ2f
         CkBQ==
X-Gm-Message-State: AKS2vOyvAah/UQGdq8le+P6WPE00J+b+5Ktai3E7Qvu6p9PxDL0XwE70
        qVaMtFMDCBD/TIuAHiM=
X-Received: by 10.80.163.70 with SMTP id 64mr9371071edn.78.1498687106921;
        Wed, 28 Jun 2017 14:58:26 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id g25sm1926975eda.59.2017.06.28.14.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jun 2017 14:58:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        J Smith <dark.panda@gmail.com>,
        Joe Ratterman <jratt0@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] grep: remove redundant grep pattern type assignment
Date:   Wed, 28 Jun 2017 21:58:06 +0000
Message-Id: <20170628215809.23060-3-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170628215809.23060-1-avarab@gmail.com>
References: <20170628215809.23060-1-avarab@gmail.com>
In-Reply-To: <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com>
References: <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a redundant assignment to extended_regexp_option to make it
zero if grep.extendedRegexp is not set. This is always called right
after init_grep_defaults() which memsets the entire structure to 0.

This is a logical follow-up to my commit to remove redundant regflags
assignments[1]. This logic was originally introduced in [2], but as
explained in the former commit it's working around a pattern in our
code that no longer exists, and is now confusing as it leads the
reader to think that this needs to be flipped back & forth.

1. e0b9f8ae09 ("grep: remove redundant regflags assignments",
   2017-05-25)
2. b22520a37c ("grep: allow -E and -n to be turned on by default via
   configuration", 2011-03-30)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/grep.c b/grep.c
index 29439886e7..6614042fdc 100644
--- a/grep.c
+++ b/grep.c
@@ -80,8 +80,6 @@ int grep_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "grep.extendedregexp")) {
 		if (git_config_bool(var, value))
 			opt->extended_regexp_option = 1;
-		else
-			opt->extended_regexp_option = 0;
 		return 0;
 	}
 
-- 
2.13.1.611.g7e3b11ae1

