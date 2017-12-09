Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A750B1F407
	for <e@80x24.org>; Sat,  9 Dec 2017 09:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbdLIJGR (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 04:06:17 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:44850 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbdLIJGD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 04:06:03 -0500
Received: by mail-wm0-f68.google.com with SMTP id t8so6633223wmc.3
        for <git@vger.kernel.org>; Sat, 09 Dec 2017 01:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=kDj4XsPSn6twBnwJVS51yeN+/tgC8hbjB+WMZN/pNko=;
        b=lwobRF76Xu/x8HNcGOPrs46Uc3HrDdvQpeZzW59mYP4gw3/VSaFn+iXcydak7RNyo5
         uWJ87WxN/+iqFsuWDXh466SrPapcfHUMaSWZjYgd2XTM+AmZQLhMmWyhLqe1EHOe/HFb
         M8mINgYGqTM1fdJTitNKpOKDV7iszbTAnY1Pps114PBmiO2mVaWUZTl+g2nti9NBf2Zg
         o8Uu3OMzbZXfE9QhcF/dZmseM54LtlgcKtgLM5+M5j1MNkY9uMA/X+UBGhPB105V/ScK
         cvQCcruKCUN2S2kKPKpLpwn7o30RqsskvpQrElMLf2Bokb4rIAb3T+xdKbKAzDpOSmLs
         TS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=kDj4XsPSn6twBnwJVS51yeN+/tgC8hbjB+WMZN/pNko=;
        b=biejkg6TC0wCVPwQgcJ1+gFM8+K2ZzLwFYzZTlZmJcl1f5wiRmloM8XHEtPlR2dg8g
         ejTraT3v4dWLY2U6iSMS5YTfzy0ezFWpoM739geuXz3AXbZcUvAE3yLmYf/nDJ5A9rxu
         upu9w6sQCAMjfzFKMK5rkiXYs/YSyzQSQkzqJA3mj6nbKaLTVnpoTjoRiI77gqgLGlpD
         z3XydURoLA31TdUpAzJLUMBH6J29G/JTOy81dVERwWrOg3KbTBAUzR1Oq60jcmRy5/B2
         DryMqfBLeKwoKcZ4wYJGz6nBKDjZnt6k2Frb7R6wqRscDbGSw+iHBVASHhpX+d+67l+T
         7X2g==
X-Gm-Message-State: AJaThX50YdIFiCOZiK9ScdUMbh9oH5MRYDArlONNV2H4aCE1E04eSeNY
        +JvviTaKoXqqInZS+Fv+zJAzuGuXZf4=
X-Google-Smtp-Source: AGs4zMZ1EEbWAdqJ5kh9TvqMlabf+GPQPnoIixhksVU87QHxZ3S7LsGTY9wUnETnF9jzuyWZgrfVeA==
X-Received: by 10.80.228.9 with SMTP id d9mr53054046edm.245.1512810361872;
        Sat, 09 Dec 2017 01:06:01 -0800 (PST)
Received: from localhost (se3x.mullvad.net. [193.138.219.228])
        by smtp.gmail.com with ESMTPSA id n3sm2370674edb.46.2017.12.09.01.06.01
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Dec 2017 01:06:01 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] merge: add config option for verifySignatures
Date:   Sat,  9 Dec 2017 09:05:28 +0000
Message-Id: <20171209090530.6747-1-hji@dyntopia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Verify the signature of the tip commit when `merge.verifySignatures` is
true.  This can be overridden with `--no-verify-signatures`.

Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
---
 Documentation/merge-config.txt     |  7 +++++++
 builtin/merge.c                    |  2 ++
 t/t7612-merge-verify-signatures.sh | 43 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index df3ea3779..76571cd3b 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -26,6 +26,13 @@ merge.ff::
 	allowed (equivalent to giving the `--ff-only` option from the
 	command line).
 
+merge.verifySignatures::
+	Verify that the tip commit of the side branch being merged is
+	signed with a valid key, i.e. a key that has a valid uid: in the
+	default trust model, this means the signing key has been signed
+	by a trusted key. If the tip commit of the side branch is not
+	signed with a valid key, the merge is aborted.
+
 include::fmt-merge-msg-config.txt[]
 
 merge.renameLimit::
diff --git a/builtin/merge.c b/builtin/merge.c
index 612dd7bfb..30264cfd7 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -567,6 +567,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 
 	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
 		show_diffstat = git_config_bool(k, v);
+	else if (!strcmp(k, "merge.verifysignatures"))
+		verify_signatures = git_config_bool(k, v);
 	else if (!strcmp(k, "pull.twohead"))
 		return git_config_string(&pull_twohead, k, v);
 	else if (!strcmp(k, "pull.octopus"))
diff --git a/t/t7612-merge-verify-signatures.sh b/t/t7612-merge-verify-signatures.sh
index 8ae69a61c..f1a74a683 100755
--- a/t/t7612-merge-verify-signatures.sh
+++ b/t/t7612-merge-verify-signatures.sh
@@ -39,23 +39,62 @@ test_expect_success GPG 'merge unsigned commit with verification' '
 	test_i18ngrep "does not have a GPG signature" mergeerror
 '
 
+test_expect_success GPG 'merge unsigned commit with merge.verifySignatures=true' '
+	test_config merge.verifySignatures true &&
+	test_must_fail git merge --ff-only side-unsigned 2>mergeerror &&
+	test_i18ngrep "does not have a GPG signature" mergeerror
+'
+
 test_expect_success GPG 'merge commit with bad signature with verification' '
 	test_must_fail git merge --ff-only --verify-signatures $(cat forged.commit) 2>mergeerror &&
 	test_i18ngrep "has a bad GPG signature" mergeerror
 '
 
+test_expect_success GPG 'merge commit with bad signature with merge.verifySignatures=true' '
+	test_config merge.verifySignatures true &&
+	test_must_fail git merge --ff-only $(cat forged.commit) 2>mergeerror &&
+	test_i18ngrep "has a bad GPG signature" mergeerror
+'
+
 test_expect_success GPG 'merge commit with untrusted signature with verification' '
 	test_must_fail git merge --ff-only --verify-signatures side-untrusted 2>mergeerror &&
 	test_i18ngrep "has an untrusted GPG signature" mergeerror
 '
 
+test_expect_success GPG 'merge commit with untrusted signature with merge.verifySignatures=true' '
+	test_config merge.verifySignatures true &&
+	test_must_fail git merge --ff-only side-untrusted 2>mergeerror &&
+	test_i18ngrep "has an untrusted GPG signature" mergeerror
+'
+
 test_expect_success GPG 'merge signed commit with verification' '
 	git merge --verbose --ff-only --verify-signatures side-signed >mergeoutput &&
-	test_i18ngrep "has a good GPG signature" mergeoutput
+	test_i18ngrep "has a good GPG signature" mergeoutput &&
+	git checkout initial
+'
+
+test_expect_success GPG 'merge signed commit with merge.verifySignatures=true' '
+	test_config merge.verifySignatures true &&
+	git merge --verbose --ff-only side-signed >mergeoutput &&
+	test_i18ngrep "has a good GPG signature" mergeoutput &&
+	git checkout initial
 '
 
 test_expect_success GPG 'merge commit with bad signature without verification' '
-	git merge $(cat forged.commit)
+	git merge $(cat forged.commit) &&
+	git checkout initial
+'
+
+test_expect_success GPG 'merge commit with bad signature with merge.verifySignatures=false' '
+	test_config merge.verifySignatures false &&
+	git merge $(cat forged.commit) &&
+	git checkout initial
+'
+
+test_expect_success GPG 'merge commit with bad signature with merge.verifySignatures=true and --no-verify-signatures' '
+	test_config merge.verifySignatures true &&
+	git merge --no-verify-signatures $(cat forged.commit) &&
+	git checkout initial
 '
 
 test_done
-- 
2.11.0

