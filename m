Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F36092047F
	for <e@80x24.org>; Thu,  3 Aug 2017 09:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbdHCJVG (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:21:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34295 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbdHCJU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:20:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id x64so1446107wmg.1
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2kz07PY1kOvpMoasQq41TN4mOBMydM1WBcz2VcNjnuo=;
        b=ms0YVQbM/PImf92FaFdqN0TEA/8fdXFmPAliLW5M+4tmMrqxaaocw9Phexh1pA4mn0
         DWaA+pi9s+TtoHPTleY5459WX2KjbVNMPWhagglNvS/tho0yFTNncjIZbIsJhhsLCkqL
         ghGZFCII14Gw+1X4OlZNa90E7ruq4l5yOuhUFGJEEsUDQ0lOcm2Z9NcNETG1RnONL7ol
         Z3fvep4nAnwcD5b7GdgHBOr3rLuiVHu8TWqs1LfhbekLdWY5+9iGMKfBmMuyZFl3mHqA
         aWvo0LwdbJ9YQlRL770cRSyV3XGVKHwYmg0i8ZsscccAuNTgdXN+OxETA6Q+UNOXMWeD
         FCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2kz07PY1kOvpMoasQq41TN4mOBMydM1WBcz2VcNjnuo=;
        b=HMnHck7oH7wwm/FoWqL+eWcksPGy6CLugEUWPKWfUqVOBdTya7lPobdcDvwFdUZtXG
         f5d6mLalxZrqhOljSENEftbkBh0johrKIz8dCi2jKwtr4Gv8sPXv3r96Ncotd3lhoUkX
         NfBH2+cU7DtObgqkxCwrkTNPn7ZLhILJPfmTncIVwPVs/A/TmqdQRnfWyv8oNkhKGsfQ
         b/ThdfolCCY6u9w+fHeZ7J65fRM/MtWGOy3NF1goPhY+6TSP1Ju9yQxWR9dMR6hu9oCi
         2NJaRK+TiM9IUdpUX3sSJddlAqeyXlDm+z1o1udEDrrmFjQQna1h1XxzfqFTmFqmN4+c
         Ustg==
X-Gm-Message-State: AIVw112/FXCjDE2Wce5Sv+iV2T1bME19A6fz5VFOUIIE0TCPcyK+Px+4
        /8SEq+IhoWyHhj43
X-Received: by 10.28.147.200 with SMTP id v191mr676770wmd.95.1501752027561;
        Thu, 03 Aug 2017 02:20:27 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:20:27 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 40/40] Add t0430 to test cloning using bundles
Date:   Thu,  3 Aug 2017 11:19:26 +0200
Message-Id: <20170803091926.1755-41-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0430-clone-bundle-e-odb.sh | 85 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100755 t/t0430-clone-bundle-e-odb.sh

diff --git a/t/t0430-clone-bundle-e-odb.sh b/t/t0430-clone-bundle-e-odb.sh
new file mode 100755
index 0000000000..ac38ae1be5
--- /dev/null
+++ b/t/t0430-clone-bundle-e-odb.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+
+test_description='tests for cloning using a bundle through e-odb'
+
+. ./test-lib.sh
+
+# If we don't specify a port, the current test number will be used
+# which will not work as it is less than 1024, so it can only be used by root.
+LIB_HTTPD_PORT=$(expr ${this_test#t} + 12000)
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+
+start_httpd apache-e-odb.conf
+
+# odb helper script must see this
+export HTTPD_URL
+
+write_script odb-clone-bundle-helper <<\EOF
+die() {
+	printf >&2 "%s\n" "$@"
+	exit 1
+}
+echo >&2 "odb-clone-bundle-helper args:" "$@"
+case "$1" in
+init)
+	ref_hash=$(git rev-parse refs/odbs/magic/bundle) ||
+	die "couldn't find refs/odbs/magic/bundle"
+	GIT_NO_EXTERNAL_ODB=1 git cat-file blob "$ref_hash" >bundle_info ||
+	die "couldn't get blob $ref_hash"
+	bundle_url=$(sed -e 's/bundle url: //' bundle_info)
+	echo >&2 "bundle_url: '$bundle_url'"
+	curl "$bundle_url" -o bundle_file ||
+	die "curl '$bundle_url' failed"
+	GIT_NO_EXTERNAL_ODB=1 git bundle unbundle bundle_file >unbundling_info ||
+	die "unbundling 'bundle_file' failed"
+	;;
+get*)
+	die "odb-clone-bundle-helper '$1' called"
+	;;
+put*)
+	die "odb-clone-bundle-helper '$1' called"
+	;;
+*)
+	die "unknown command '$1'"
+	;;
+esac
+EOF
+HELPER="\"$PWD\"/odb-clone-bundle-helper"
+
+
+test_expect_success 'setup repo with a few commits' '
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	test_commit four
+'
+
+BUNDLE_FILE="file.bundle"
+FILES_DIR="httpd/www/files"
+GET_URL="$HTTPD_URL/files/$BUNDLE_FILE"
+
+test_expect_success 'create a bundle for this repo and check that it can be downloaded' '
+	git bundle create "$BUNDLE_FILE" master &&
+	mkdir "$FILES_DIR" &&
+	cp "$BUNDLE_FILE" "$FILES_DIR/" &&
+	curl "$GET_URL" --output actual &&
+	test_cmp "$BUNDLE_FILE" actual
+'
+
+test_expect_success 'create an e-odb ref for this bundle' '
+	ref_hash=$(echo "bundle url: $GET_URL" | GIT_NO_EXTERNAL_ODB=1 git hash-object -w -t blob --stdin) &&
+	git update-ref refs/odbs/magic/bundle "$ref_hash"
+'
+
+test_expect_success 'clone using the e-odb helper to download and install the bundle' '
+	mkdir my-clone &&
+	(cd my-clone &&
+	 git clone --no-local \
+		-c odb.magic.scriptCommand="$HELPER" \
+		--initial-refspec "refs/odbs/magic/*:refs/odbs/magic/*" .. .)
+'
+
+stop_httpd
+
+test_done
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

