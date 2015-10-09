From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 09/13] object: introduce get_object_hash macro.
Date: Fri,  9 Oct 2015 01:43:55 +0000
Message-ID: <1444355039-186351-10-git-send-email-sandals@crustytoothpaste.net>
References: <1444355039-186351-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 03:45:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkMkt-0001vC-Cx
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 03:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755959AbbJIBpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 21:45:47 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:58082 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755839AbbJIBpM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2015 21:45:12 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D9694280A0;
	Fri,  9 Oct 2015 01:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1444355112;
	bh=tluClQH7mhbef5FEh4RDZ9hG1vCUnUecfKVj2FMui/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K/paTrwjFpYbfV3Qd8FTL6nHuSFTnBBtUAuiFsNRpGq1R1L+PLa4P8AO94PCgTKHW
	 w7zol/+1rXKuF8FQ+wLaQrbA2XtSmnfjmJBx35OIz/3OdLZCCKXCsrI0yEmpnEmgwR
	 T/pk67itCqbnwMx6TmFYXPkcreIPwI9ttv6DIjJVLhXHrxP5WOiAnAL0HjH2mFuRVz
	 Ux1pvEGw4g6bCMVTPY8BQfW1Tt4A60R9L9Si/Imu8q4nUBdyqqRsocZpmrgKqK49AT
	 o7pvK7pYjPSjubLt7Yes53WSAIvqvxqtBY1LGohMwAm2UcT9EO6Ewa8q6Vf4mH47N9
	 ufquII8WfAQjdbRcPd6nsQk2ZBDq6VDEne4uon5D7qzUj2SCs+t8yYvNiUR3NNFE3E
	 4bIKWS+b1XXESzxkNlM/elQxaShLUxJhKNwAfSUfIfzOvaY+dRLK/Gmc40hgoiRfVW
	 YYQJmpQsi7/RSUsMe50upiwxCrOGoX2U3ugp3o8B03ScKdRT3+G
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1444355039-186351-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279292>

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
2.6.1
