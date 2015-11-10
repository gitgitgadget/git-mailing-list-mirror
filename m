From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 08/12] object: introduce get_object_hash macro.
Date: Tue, 10 Nov 2015 02:22:26 +0000
Message-ID: <1447122150-672570-9-git-send-email-sandals@crustytoothpaste.net>
References: <1447122150-672570-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 03:23:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zvyaz-0001Xj-W9
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 03:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbbKJCXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 21:23:36 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:58418 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752245AbbKJCWz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 21:22:55 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3198A2809C;
	Tue, 10 Nov 2015 02:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1447122174;
	bh=Zt+8a+Qi9OkCGyIOzjzwE3yf3dNAJz9bNnQyVexaKlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zLeXtWHVO65bAMGVwgrQsQApSLqvVX91Dj5LSsGi2Y/kMMnJoyj64M6ejYF7qoXAQ
	 7jb53igq5mmC55jJLtYi6rgLg0XamHiO88z2mD+Ywur4mLo6rQ2vMICSvGwbcvfWMH
	 vuEEQsJmJLJ60mRgFM3HN6k1NvxHrmPPVDXE5ASRUn1xQ5cs15UJN8q/05QbtT8Mpk
	 Ks5zFHDBAtyRu9j4x6qU4gVST2sC0+HKvacEVZp3FiaGds/d4KHfIVHQyzLGrCaE0d
	 SrdmanGXsw5ISgjd8SD1V1JeWKitplVatq1DJi2c/6pQqm7pXI3K1/kQc1qTnfdyvZ
	 XFBp3z17HrUbsiuBJfLX2N0hl56C1G3m/F3UidEPy0l2dnAILOqwzDUeH/B20A0wJO
	 MCQdxwYgMt4CVJBU7M85vA2k+2p6r7dBORcLIcC8FuthFBRrg2GD4qOyJGZP/zh3fl
	 sB39q1ILCQUpjNkGvwMAp6z3kj+z70NEGTAaXZEjdocS3EOkgCn
X-Mailer: git-send-email 2.6.2.409.gb049f0a
In-Reply-To: <1447122150-672570-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281101>

This macro is a temporary change to ease the transition of struct object
to use struct object_id.  It takes an argument of struct object and
returns the object's hash.  Provide this hash next to struct object for
easier conversion.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 object.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/object.h b/object.h
index 6416247d..7c098d03 100644
--- a/object.h
+++ b/object.h
@@ -52,6 +52,8 @@ struct object {
 	unsigned char sha1[20];
 };
 
+#define get_object_hash(x) ((x).sha1)
+
 extern const char *typename(unsigned int type);
 extern int type_from_string_gently(const char *str, ssize_t, int gentle);
 #define type_from_string(str) type_from_string_gently(str, -1, 0)
-- 
2.6.2.409.gb049f0a
