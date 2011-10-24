From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 07/11] tree_entry_interesting: make use of local pointer "item"
Date: Mon, 24 Oct 2011 17:36:12 +1100
Message-ID: <1319438176-7304-8-git-send-email-pclouds@gmail.com>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 08:39:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIEBu-0000vA-CX
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 08:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305Ab1JXGjS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 02:39:18 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:65344 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab1JXGjR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 02:39:17 -0400
Received: by ggnb1 with SMTP id b1so5422134ggn.19
        for <git@vger.kernel.org>; Sun, 23 Oct 2011 23:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8qnDM6aB48QF7F7YT0CpDcp8mzjgu9+EONPvIFaBllQ=;
        b=CPLWps8yEMZVbhhK3DJFDu8zafBlPY07p5CMrZGt9/Am8bnccmBm0oS95r+QabLLjU
         JWZxNbyDXEdpGgPDzR0zrL/Yw+DTQzveUXklHLASnqPk6OK8u/ntwxxKuTN001tsMWDe
         IR1WWc6DXe9fP0MJWAJBpVSJaf8cfvXpTEaG0=
Received: by 10.236.176.199 with SMTP id b47mr386526yhm.104.1319438357173;
        Sun, 23 Oct 2011 23:39:17 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id f47sm14316453yhh.8.2011.10.23.23.39.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Oct 2011 23:39:16 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 24 Oct 2011 17:37:35 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184160>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree-walk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index fc03262..2d9d17a 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -622,7 +622,7 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 					&never_interesting))
 				return entry_interesting;
=20
-			if (ps->items[i].use_wildcard) {
+			if (item->use_wildcard) {
 				if (!fnmatch(match + baselen, entry->path, 0))
 					return entry_interesting;
=20
@@ -638,7 +638,7 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 		}
=20
 match_wildcards:
-		if (!ps->items[i].use_wildcard)
+		if (!item->use_wildcard)
 			continue;
=20
 		/*
--=20
1.7.3.1.256.g2539c.dirty
