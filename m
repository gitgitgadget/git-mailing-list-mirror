From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 9/9] grep: skip files outside sparse checkout area
Date: Wed,  1 Oct 2008 11:04:09 +0700
Message-ID: <1222833849-22129-10-git-send-email-pclouds@gmail.com>
References: <1222833849-22129-1-git-send-email-pclouds@gmail.com>
 <1222833849-22129-2-git-send-email-pclouds@gmail.com>
 <1222833849-22129-3-git-send-email-pclouds@gmail.com>
 <1222833849-22129-4-git-send-email-pclouds@gmail.com>
 <1222833849-22129-5-git-send-email-pclouds@gmail.com>
 <1222833849-22129-6-git-send-email-pclouds@gmail.com>
 <1222833849-22129-7-git-send-email-pclouds@gmail.com>
 <1222833849-22129-8-git-send-email-pclouds@gmail.com>
 <1222833849-22129-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 06:07:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkszj-0001Sc-5B
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 06:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbYJAEGO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2008 00:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbYJAEGN
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 00:06:13 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:63785 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbYJAEGL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 00:06:11 -0400
Received: by rv-out-0506.google.com with SMTP id k40so384855rvb.1
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 21:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=hiI1dP6wQq9eW+eROAbkg3wxMkZkm4A6tlCqFuQhc1k=;
        b=H+BF1ARF3xOX9Rhi4aaY8+ldrsd1EG66xxhc4250UPF6F6VrRcDxxEamXdg6DQXapt
         lA/X+97JxBvvjiqYuUbbSnZmBuo6Ln/p9/UaFnRQRfzlep1SnMObok2D5qyMmXgY6t6j
         ZDu/OQ/cIVJ6COwcSoTe7VgrcikER8MrUBFGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=wPQQMIEau6z5/HGO9nwB8OXCLNBv93/1jlSXz1cz/uDFbrjtAwbXQ/1SnkQNT2uKQc
         cJRNgwtk+gt4t4YIunpD45hIGQwFreMQiK429F1Jq7LXc7EBnbt4D1+iwoNpHIXPmgxI
         NFH5PZ6AUvKJyUlAo4nQYkkQL8m6CX3Gdd1ak=
Received: by 10.142.192.11 with SMTP id p11mr3157710wff.111.1222833971317;
        Tue, 30 Sep 2008 21:06:11 -0700 (PDT)
Received: from pclouds@gmail.com ([117.5.46.240])
        by mx.google.com with ESMTPS id 30sm4717941wfc.5.2008.09.30.21.06.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 21:06:09 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed,  1 Oct 2008 11:06:03 +0700
X-Mailer: git-send-email 1.6.0.2.488.gf604a
In-Reply-To: <1222833849-22129-9-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97200>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-grep.txt |    4 +++-
 builtin-grep.c             |    7 ++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index fa4d133..ee359c9 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -24,7 +24,9 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Look for specified patterns in the working tree files, blobs
-registered in the index file, or given tree objects.
+registered in the index file, or given tree objects. By default
+it will search in the working tree files. When in sparse checkout
+mode, it only searches checked-out files.
=20
=20
 OPTIONS
diff --git a/builtin-grep.c b/builtin-grep.c
index 3a51662..d5507d7 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -343,6 +343,8 @@ static int external_grep(struct grep_opt *opt, cons=
t char **paths, int cached)
 			continue;
 		if (!pathspec_matches(paths, ce->name))
 			continue;
+		if (ce_no_checkout(ce))
+			continue;
 		name =3D ce->name;
 		if (name[0] =3D=3D '-') {
 			int len =3D ce_namelen(ce);
@@ -404,8 +406,11 @@ static int grep_cache(struct grep_opt *opt, const =
char **paths, int cached)
 				continue;
 			hit |=3D grep_sha1(opt, ce->sha1, ce->name, 0);
 		}
-		else
+		else {
+			if (ce_no_checkout(ce))
+				continue;
 			hit |=3D grep_file(opt, ce->name);
+		}
 		if (ce_stage(ce)) {
 			do {
 				nr++;
--=20
1.6.0.2.488.gf604a
