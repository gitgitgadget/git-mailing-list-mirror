From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/8] archive: add a failure test wrt .gitattributes  misreading
Date: Wed,  8 Apr 2009 20:05:28 +1000
Message-ID: <1239185133-4181-4-git-send-email-pclouds@gmail.com>
References: <1239185133-4181-1-git-send-email-pclouds@gmail.com>
 <1239185133-4181-2-git-send-email-pclouds@gmail.com>
 <1239185133-4181-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 12:08:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrUi0-0005bq-72
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 12:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764005AbZDHKGx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 06:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763898AbZDHKGw
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 06:06:52 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:44704 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763153AbZDHKGv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 06:06:51 -0400
Received: by rv-out-0506.google.com with SMTP id f9so37692rvb.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 03:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=vPBXdpIbodXmxD/ivz6tnO16VzTbmnTfxv2FEtZPvEY=;
        b=g6FQYt4rBKOHCUAt9hSOglaExGj3QwtoCBEvBWgG8YoSnGmhchWlN8UUOmJ9i4DhOo
         xljnO8AbifPxK7P6WKSrCydXXuMptYvJPfMFwl9V3GWVfAiMbcxAd0rvVTQBQO8kZnF5
         KNAhKi0z3Ld7ZiaKbDgvh8F8HLxQLz+nd9JNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Bz2c+SqxuBr2em33Ey/yRk03wnoe8n0zmIekPfnlLAeclqSHrKZuqixzb5P25TB/JF
         dTyrZB+vQfX5jePiuKV60p7KL3TlmG84EUYc5Zv9UQ8e/bUxLQcGkMcvnH4/1zK8eyNF
         IQO69yfQozT5KtWayq1l2ErwiOwtborcXG33I=
Received: by 10.141.82.20 with SMTP id j20mr468000rvl.54.1239185211108;
        Wed, 08 Apr 2009 03:06:51 -0700 (PDT)
Received: from dektop ([121.91.216.142])
        by mx.google.com with ESMTPS id k41sm24859715rvb.6.2009.04.08.03.06.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Apr 2009 03:06:50 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed,  8 Apr 2009 20:06:44 +1000
X-Mailer: git-send-email 1.6.2.2.602.g83ee9f
In-Reply-To: <1239185133-4181-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116065>

"git archive" is used to create archives from a tree (or commit), so
it should not consult any .gitattributes files on working directory.

It currently does, so this patch records the failure.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t0024-crlf-archive.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index c7d0324..9c56e0e 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -43,4 +43,11 @@ test_expect_success UNZIP 'zip archive' '
=20
 '
=20
+test_expect_failure '.gitattributes in workdir should not be consulted=
' '
+	echo "sample -crlf" > .gitattributes &&
+	git archive --format=3Dtar HEAD |
+	( mkdir untarred2 && cd untarred2 && "$TAR" -xf - )
+	test_cmp sample untarred2/sample
+'
+
 test_done
--=20
1.6.2.2.602.g83ee9f
