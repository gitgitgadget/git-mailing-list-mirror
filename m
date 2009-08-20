From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v4 16/19] unpack-trees(): ignore worktree check outside checkout area
Date: Thu, 20 Aug 2009 20:47:10 +0700
Message-ID: <1250776033-12395-17-git-send-email-pclouds@gmail.com>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
 <1250776033-12395-2-git-send-email-pclouds@gmail.com>
 <1250776033-12395-3-git-send-email-pclouds@gmail.com>
 <1250776033-12395-4-git-send-email-pclouds@gmail.com>
 <1250776033-12395-5-git-send-email-pclouds@gmail.com>
 <1250776033-12395-6-git-send-email-pclouds@gmail.com>
 <1250776033-12395-7-git-send-email-pclouds@gmail.com>
 <1250776033-12395-8-git-send-email-pclouds@gmail.com>
 <1250776033-12395-9-git-send-email-pclouds@gmail.com>
 <1250776033-12395-10-git-send-email-pclouds@gmail.com>
 <1250776033-12395-11-git-send-email-pclouds@gmail.com>
 <1250776033-12395-12-git-send-email-pclouds@gmail.com>
 <1250776033-12395-13-git-send-email-pclouds@gmail.com>
 <1250776033-12395-14-git-send-email-pclouds@gmail.com>
 <1250776033-12395-15-git-send-email-pclouds@gmail.com>
 <1250776033-12395-16-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 15:49:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me81N-0007ZS-7k
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692AbZHTNss convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 09:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754689AbZHTNss
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:48:48 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:44339 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494AbZHTNsr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:48:47 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1591323rvb.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 06:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=B8liftl3B9VHc0MGYgV/4OilsuWvoBTBZzSPE5uXncI=;
        b=HfpaFrb7dkeVKdNfjEYbxk/hEP+BZrK9Oh9QlCd6MU6raWTl8a3nx43r6HKHrwNPS+
         pAT27if1bwhoQVRuoOdsHY1gjFf60C01pOQM/F9KqVbJxVHAMH12/SuWmpANDnkYwS5A
         jt+6W/d4dkqGRS9TRCIBusFWJRc6+FAYpb2Oc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DJqW3qtdobei35osIalwTw01FW08OuYnOYcjNXt7jloXWZFDHiQyqaf7CvrcGxxPRp
         5W2knB2B1kLcTbFL4GXPhX9wZx2t/EtOhDJC7g6fcYQgTpEELQqHwsYHYglQFXf8zU2I
         qEN5rVfw84MqPtLEOQqLxa3oj8+1H/UnZKFPg=
Received: by 10.141.51.5 with SMTP id d5mr4718154rvk.172.1250776129744;
        Thu, 20 Aug 2009 06:48:49 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.241.222])
        by mx.google.com with ESMTPS id b39sm7218810rvf.20.2009.08.20.06.48.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 06:48:48 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 20 Aug 2009 20:48:43 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250776033-12395-16-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126637>

verify_absent() and verify_uptodate() are used to ensure worktree
is safe to be updated, then CE_REMOVE or CE_UPDATE will be set.
=46inally check_updates() bases on CE_REMOVE, CE_UPDATE and the
recently added CE_WT_REMOVE to update working directory accordingly.

The entries that are checked may eventually be left out of checkout
area (done later in apply_sparse_checkout()). We don't want to update
outside checkout area. This patch teaches Git to assume "good",
skip these checks when it's sure those entries will be outside checkout
area, and clear CE_REMOVE|CE_UPDATE that could be set due to this
assumption.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 unpack-trees.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 2d8ecb7..72743b3 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -505,6 +505,14 @@ int unpack_trees(unsigned len, struct tree_desc *t=
, struct unpack_trees_options
 				ret =3D -1;
 				goto done;
 			}
+			/*
+			 * Merge strategies may set CE_UPDATE|CE_REMOVE outside checkout
+			 * area as a result of ce_skip_worktree() shortcuts in
+			 * verify_absent() and verify_uptodate(). Clear them.
+			 */
+			if (ce_skip_worktree(ce))
+				ce->ce_flags &=3D ~(CE_UPDATE | CE_REMOVE);
+
 		}
 	}
=20
@@ -577,6 +585,8 @@ static int verify_uptodate_1(struct cache_entry *ce=
,
 static int verify_uptodate(struct cache_entry *ce,
 			   struct unpack_trees_options *o)
 {
+	if (!o->skip_sparse_checkout && will_have_skip_worktree(ce, o))
+		return 0;
 	return verify_uptodate_1(ce, o, ERRORMSG(o, not_uptodate_file));
 }
=20
@@ -776,6 +786,8 @@ static int verify_absent_1(struct cache_entry *ce, =
const char *action,
 static int verify_absent(struct cache_entry *ce, const char *action,
 			 struct unpack_trees_options *o)
 {
+	if (!o->skip_sparse_checkout && will_have_skip_worktree(ce, o))
+		return 0;
 	return verify_absent_1(ce, action, o, ERRORMSG(o, would_lose_untracke=
d));
 }
=20
--=20
1.6.3.GIT
