Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FDDA20401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbdFTH6S (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:58:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35757 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751998AbdFTH4F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id d64so21283960wmf.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eefpvZVSsC1X2Hcs/hshQm0z6eOUzIA19j3yEou84IM=;
        b=hDrLgZdq4rx94qUH2fSNoM59wf7BinjX1rRp10OYFIIPzXnfS5yJmorEOU2SZWSypD
         l8+9Zm1IV1A3ITpCahEPSh26cn8027wz+SDc+0xk3SJvJ8XwUVhUGZc9SsYrKL/RTlmC
         DaalrSNTKBpLQtdYIYxGGmFPsnnSOomR92MKuTrj8R9ywmLoO6qw5m4StMhheszcui2I
         HeCnc25xx/D9N3hWj9SZ6zuHwGRRZVh73uXjyNBPPYBhG/bEBBSHDmlSLKCgzmsd6NJ5
         H6P2t0pNhSWkuO5venxT8qZe+B26Ki0uum9MJcMRcZCzoDblAgvELEtCKCmx6RDKLPnH
         kHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eefpvZVSsC1X2Hcs/hshQm0z6eOUzIA19j3yEou84IM=;
        b=tdTvqJsJWJWw9WZlesgH17WuvXSOXsALQkm0Y5gUY+yDw1HyDSnYdIL3xXY2Gl2hfK
         hombRE8yNt+XE2+Oe6ec2TQO73wJzgY9/PLr8CWKhsQNrC+AW+dGuQI7mtgTDJPiKjqX
         uGpB/JQPHgcLjmVlrrSlFy9aVTUEZYWzrgXOKTOZR6jIfM/LyDf6VCsJiyEHQ9r7BK3G
         74S2/CZjcnPAxwCO3TaEXomFmGlagapI4AJT0wpGBYewa9AswD8VRIRgwLq+2A0Ms2g9
         OYb0o/69CXr36bSBxbu8wsPO8MvNJootnInbwuv2Fe63RBZ7t0U3KuVJsphdbZf4fbov
         hN4A==
X-Gm-Message-State: AKS2vOyM05otUwJNXb7CxJFmbLzxhhfBMCQLPcfN9Kx8CnEdneRPSsKK
        ZQ7mNUZLh4HJR7sC
X-Received: by 10.28.48.83 with SMTP id w80mr1612048wmw.34.1497945364039;
        Tue, 20 Jun 2017 00:56:04 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:03 -0700 (PDT)
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
Subject: [RFC/PATCH v4 11/49] t0400: add 'put' command to odb-helper script
Date:   Tue, 20 Jun 2017 09:54:45 +0200
Message-Id: <20170620075523.26961-12-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0400-external-odb.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index fe85413725..6c6da5cf4f 100755
--- a/t/t0400-external-odb.sh
+++ b/t/t0400-external-odb.sh
@@ -7,6 +7,10 @@ test_description='basic tests for external object databases'
 ALT_SOURCE="$PWD/alt-repo/.git"
 export ALT_SOURCE
 write_script odb-helper <<\EOF
+die() {
+	printf >&2 "%s\n" "$@"
+	exit 1
+}
 GIT_DIR=$ALT_SOURCE; export GIT_DIR
 case "$1" in
 have)
@@ -16,6 +20,16 @@ have)
 get)
 	cat "$GIT_DIR"/objects/$(echo $2 | sed 's#..#&/#')
 	;;
+put)
+	sha1="$2"
+	size="$3"
+	kind="$4"
+	writen=$(git hash-object -w -t "$kind" --stdin)
+	test "$writen" = "$sha1" || die "bad sha1 passed '$sha1' vs writen '$writen'"
+	;;
+*)
+	die "unknown command '$1'"
+	;;
 esac
 EOF
 HELPER="\"$PWD\"/odb-helper"
@@ -43,4 +57,13 @@ test_expect_success 'helper can retrieve alt objects' '
 	test_cmp expect actual
 '
 
+test_expect_success 'helper can add objects to alt repo' '
+	hash=$(echo "Hello odb!" | git hash-object -w -t blob --stdin) &&
+	test -f .git/objects/$(echo $hash | sed "s#..#&/#") &&
+	size=$(git cat-file -s "$hash") &&
+	git cat-file blob "$hash" | ./odb-helper put "$hash" "$size" blob &&
+	alt_size=$(cd alt-repo && git cat-file -s "$hash") &&
+	test "$size" -eq "$alt_size"
+'
+
 test_done
-- 
2.13.1.565.gbfcd7a9048

