From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 4/8] t0400: add 'put' command to odb-helper script
Date: Mon, 13 Jun 2016 10:55:42 +0200
Message-ID: <20160613085546.11784-5-chriscool@tuxfamily.org>
References: <20160613085546.11784-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 10:56:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCNfU-0007BL-IM
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 10:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422706AbcFMI4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 04:56:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35367 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161113AbcFMI4J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 04:56:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id k184so13078468wme.2
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 01:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uv0nhmLeKH+jGkcOfJv4I3yvwo/hgwFPeMnaRZWjSW8=;
        b=uuLFju2X97CeBfU23GKV1f4juWwtNSauaoZ6227dBnmHdHXA0lq5k3QiHNJItpfaDi
         fpQmCSLxMlLaSWNoO2smBOF41lmag5S+x16fHVhB4knxVa7ZFQQg75r+ssS1bgYoRJ1o
         Gqk2g+WrumpcHnt2H3c1C98J3yf8fNYm41aGC17a1DhPzMLnwEwQav1eXNcXkGXjhfzs
         hONFMmOkAzCuGC17oSEo12B85PyzYLU7jwTKolTgu9CcOCQWHTmjKhN25PJWgBDklDR+
         DHPcMd11g24cLmqEv6lAmmbR0wl909MsKuBU4WBfKTbCcnMtFVphzFZfMf9Jgy3FLW//
         WPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uv0nhmLeKH+jGkcOfJv4I3yvwo/hgwFPeMnaRZWjSW8=;
        b=Zms9KgDSXHQp9Mgo1aaJrYXhsz6Sta1KgHuUYEPiZyDXzRCP/IUe9M1XgksPc/xrl6
         J3md8fsi6r6fXzXWv5ueH5TarwirbSRiisN53GsegwlCHnhpxtZzMD4+IYwKrRMlPXnF
         1DJzwsUgJW/67Tm1nWUVB108XkEHITkuKkEeFjMgsN3XYzHGPhVDNHjn4n9/JCfXc3aB
         k1J2AfGmspbvFpktb4CvdTPoCN/znUaO60sBO9kviqDu0P8tpm4h/kh+VoumLzwRAMH1
         AWvu01x7vk2GsPUegv4B1faM9TH/axIMJHO6Pu52xAF2/4awjhZRnphW7gLJuY52+Swq
         3jMg==
X-Gm-Message-State: ALyK8tJpt6jpIA41R6QL4rytafou2bGneOzS4azwfoDJVYnIKU9WtdTF2Zs9NpWWdQCw7A==
X-Received: by 10.194.2.225 with SMTP id 1mr12973111wjx.72.1465808168316;
        Mon, 13 Jun 2016 01:56:08 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id z6sm26342384wjv.41.2016.06.13.01.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 01:56:07 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.8.ga2c5126
In-Reply-To: <20160613085546.11784-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297166>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0400-external-odb.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index fe85413..0f1bb97 100755
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
-- 
2.9.0.rc2.362.g3cd93d0
