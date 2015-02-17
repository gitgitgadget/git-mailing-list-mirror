From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 01/13] refs: move REF_DELETING to refs.c
Date: Tue, 17 Feb 2015 18:00:11 +0100
Message-ID: <1424192423-27979-2-git-send-email-mhagger@alum.mit.edu>
References: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:00:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNlVy-0003mH-CF
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 18:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbbBQRAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 12:00:37 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:65308 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751621AbbBQRAe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2015 12:00:34 -0500
X-AuditID: 12074412-f79e46d0000036b4-1e-54e373b2f5f7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 64.B1.14004.2B373E45; Tue, 17 Feb 2015 12:00:34 -0500 (EST)
Received: from michael.fritz.box (p5DDB008A.dip0.t-ipconnect.de [93.219.0.138])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1HH0TXW000419
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Feb 2015 12:00:32 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLup+HGIwfcWHouuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLXr7PrFabN7czuLA7vH3/Qcmj52z7rJ7LNhU6nHxkrLH501yAaxR
	3DZJiSVlwZnpefp2CdwZX5a8Yi54y1Xx4+d2pgbG0xxdjJwcEgImEkfv/2CFsMUkLtxbz9bF
	yMUhJHCZUWLSpL2sEM5xJokb50+BVbEJ6Eos6mlmArFFBNQkJrYdYgGxmQVWM0lsvcsGYgsL
	WEu0LNwMZHNwsAioSpybYg8S5hVwkbj35AEzxDI5ifPHf4LZnAKuEst+LWMHsYWAauZ3zGaa
	wMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGumV5uZoleakrpJkZIkAntYFx/Uu4QowAH
	oxIPr8WERyFCrIllxZW5hxglOZiURHnDix6HCPEl5adUZiQWZ8QXleakFh9ilOBgVhLhDUoB
	yvGmJFZWpRblw6SkOViUxHl/Llb3ExJITyxJzU5NLUgtgsnKcHAoSfCaggwVLEpNT61Iy8wp
	QUgzcXCCDOeSEilOzUtJLUosLcmIB0VGfDEwNkBSPEB7s0DaeYsLEnOBohCtpxgVpcR5U0AS
	AiCJjNI8uLGw1PGKURzoS2HedSBVPMC0A9f9CmgwE9Dg+X8egQwuSURISTUwspX926Tub5B8
	6tzxxropHPP8o97yL2fLjtBpqbu/Z49KyusdDNu12X4s93j4WvPYbMNNT+Zun9OsxGXd6mNm
	tvxI2FXZoKVal2TlVpj89Hf0n+Sw+vg7tu83/734s7Tu/O5Jh1ImGvJzGp19+SDr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263957>

It is only used internally now. Document it a little bit better, too.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 6 ++++++
 refs.h | 4 +---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index ab2f2a9..5e6355c 100644
--- a/refs.c
+++ b/refs.c
@@ -35,6 +35,12 @@ static unsigned char refname_disposition[256] = {
 };
 
 /*
+ * Flag passed to lock_ref_sha1_basic() telling it to tolerate broken
+ * refs (i.e., because the reference is about to be deleted anyway).
+ */
+#define REF_DELETING	0x02
+
+/*
  * Used as a flag to ref_transaction_delete when a loose ref is being
  * pruned.
  */
diff --git a/refs.h b/refs.h
index afa3c4d..9bf2148 100644
--- a/refs.h
+++ b/refs.h
@@ -183,12 +183,10 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
  * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
  *              symbolic references.
- * REF_DELETING: tolerate broken refs
  *
- * Flags >= 0x100 are reserved for internal use.
+ * Other flags are reserved for internal use.
  */
 #define REF_NODEREF	0x01
-#define REF_DELETING	0x02
 
 /*
  * Setup reflog before using. Set errno to something meaningful on failure.
-- 
2.1.4
