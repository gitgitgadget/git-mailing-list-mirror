Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8E1320401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752421AbdFTH5S (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:57:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33170 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbdFTH5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:57:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id f90so21272997wmh.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6BjrS2Kn49W9SMbIxhyOlpMsDCqBf0E4HZ5mkvtQ3bA=;
        b=IGWJ76LInx/5QBeGqJImJDVANwFEdLP5zFEW6sPFOT0Q7FN1JcfhuSkcEquK3vBCjh
         fJcWgb9eGJ0FRH+z9fF3aauByRMcD+HImsNBCIi+AWscrTAZU+5Zdj+w5elh0A4BpBsl
         E2hcoWmXy9YFGB4M2O3px5jaNow8RInBE4YzQGGFyT53JB3cwlkvCMmdg+XYmFHwp0D/
         Fto6KajC57rcadhLmkK+Jgz7CNPtYQbDVT8RRGUO6WNdRLm+y2xFfUwg9LTSOHh62gKo
         ve0vLOnbTv6zl2A7kozHEADPxCuZwjCMaz4yIrFKs8u/TGAVas1FyP1HUzFqQYs56MoV
         eMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6BjrS2Kn49W9SMbIxhyOlpMsDCqBf0E4HZ5mkvtQ3bA=;
        b=VcY92cRqWLH0ZKWEH7PFTn0BiflYlLpfAn0seOzlaIEdnbx9/Vz2c4hefZSmOrOrgn
         55UgWJcXZPnnOvyMRvmAOLAIeUwT5reCEdmfxuKVQKGiv5X28uzeNeFYJA6Z+LfOd6cb
         J0Z6Rt1nI1moCCf3FgDHIBIn0FK05Ho46n7RR3hzV/TCTNqhIVreWAa3wLlchPV4Ct7q
         p1OCZzUcRPUINJ9mIhG3/mOWuhG2e1xVBXxiLpOL7a9a7XVFEY1FGWHen03gvIOJMOyB
         RfElhLVNk8kySYoIzcw5dvzsbof8eJ05mcBIxHQ3s4ZsV84IAeBw1whEWbHf3NYLyw8S
         OpJg==
X-Gm-Message-State: AKS2vOx6/Y/wCX1Hr6TBXP80W2pkCcdKwl4qHqU4LoIFx1DNiT0K8n7t
        0YgV0XKIC4w2LqzM
X-Received: by 10.28.95.135 with SMTP id t129mr1761305wmb.61.1497945415747;
        Tue, 20 Jun 2017 00:56:55 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:55 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 49/49] t: add t0430 to test cloning using bundles
Date:   Tue, 20 Jun 2017 09:55:23 +0200
Message-Id: <20170620075523.26961-50-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0430-clone-bundle-e-odb.sh | 91 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100755 t/t0430-clone-bundle-e-odb.sh

diff --git a/t/t0430-clone-bundle-e-odb.sh b/t/t0430-clone-bundle-e-odb.sh
new file mode 100755
index 0000000000..8934bea006
--- /dev/null
+++ b/t/t0430-clone-bundle-e-odb.sh
@@ -0,0 +1,91 @@
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
+get_cap)
+	echo "capability=get"
+	echo "capability=have"
+	;;
+have)
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
+get)
+	die "odb-clone-bundle-helper 'get' called"
+	;;
+put)
+	die "odb-clone-bundle-helper 'put' called"
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
+		-c odb.magic.command="$HELPER" \
+		-c odb.magic.fetchKind="faultin" \
+		-c odb.magic.scriptMode="true" \
+		--initial-refspec "refs/odbs/magic/*:refs/odbs/magic/*" .. .)
+'
+
+stop_httpd
+
+test_done
-- 
2.13.1.565.gbfcd7a9048

