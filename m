From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] apply: remove lego in i18n string in gitdiff_verify_name
Date: Tue,  8 May 2012 20:38:27 +0700
Message-ID: <1336484307-31553-1-git-send-email-pclouds@gmail.com>
References: <7vwr4n6fcj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 15:42:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRkgC-00033L-5I
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 15:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338Ab2EHNmL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 09:42:11 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64375 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755122Ab2EHNmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 09:42:09 -0400
Received: by pbbrp8 with SMTP id rp8so8058198pbb.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 06:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1JKiezKQio71oMdoshbz6Ue2Suxz0CYIxWlR/AqxIYs=;
        b=bsMxNQiILsKOvvO1WLNBopvrFy55ew6wf5z3QeKXIouqzKJgzfXUhe1rHmC840IXy5
         fPlPi8ahcrup1Suu0NuFQZ5mIkMUpQsFggugsxVtwp72Xhbqa0eouTsFsHPR7tCcGXFP
         hMv+TMLlODJdXW8ztmbHt0mQblcdpTfMUe3zfJMzrtktfVZuNNJXfyHQwGUfM0b5K35G
         zhvpsBHaRZnSisAtIZgBlG9FLH2PsyHUBpS7aSXbyTmEvO3CmRAXRtOtVstnrQ9EeRXu
         hGIEBDaoO4pqzCTXRWtKt8+NVhVXZJcGFB8kuPtNhADZociahmqb4s0JPSI67QWGUz5h
         UVxg==
Received: by 10.68.134.232 with SMTP id pn8mr57272334pbb.106.1336484529389;
        Tue, 08 May 2012 06:42:09 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.158])
        by mx.google.com with ESMTPS id kb12sm2447467pbb.15.2012.05.08.06.42.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 May 2012 06:42:07 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 08 May 2012 20:38:29 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <7vwr4n6fcj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197363>

Currently it marks the string "...inconsistent %s filename..." where
%s is either "old" or "new" from caller. From a translator point of
view, nothing hints what "%s" may be. Make it two strings
"...inconsistent new filename..." and "...inconsistent old
filename..."

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Tue, May 8, 2012 at 1:00 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
 >> diff --git a/builtin/apply.c b/builtin/apply.c
 >> index 725712d..1edd3f7 100644
 >> --- a/builtin/apply.c
 >> +++ b/builtin/apply.c
 >> @@ -919,7 +919,7 @@ static int gitdiff_hdrend(const char *line, str=
uct patch *patch)
 >>   * their names against any previous information, just
 >>   * to make sure..
 >>   */
 >> -static char *gitdiff_verify_name(const char *line, int isnull, cha=
r *orig_name, const char *oldnew)
 >> +static char *gitdiff_verify_name(const char *line, int isnull, cha=
r *orig_name, int new)
 >>  {
 >
 > This change is unwarranted, though.  The callers were much clearer w=
hen
 > they passed "old" vs "new"; now they pass an unexplained 0 vs 1.

 Hmm.. how about this?

 builtin/apply.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 725712d..92ba925 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -933,8 +933,15 @@ static char *gitdiff_verify_name(const char *line,=
 int isnull, char *orig_name,
 		if (isnull)
 			die(_("git apply: bad git-diff - expected /dev/null, got %s on line=
 %d"), name, linenr);
 		another =3D find_name(line, NULL, p_value, TERM_TAB);
-		if (!another || memcmp(another, name, len + 1))
-			die(_("git apply: bad git-diff - inconsistent %s filename on line %=
d"), oldnew, linenr);
+		if (!another || memcmp(another, name, len + 1)) {
+			if (!strcmp(oldnew, "old"))
+				die(_("git apply: bad git-diff - inconsistent old filename on line=
 %d"), linenr);
+			else if (!strcmp(oldnew, "new"))
+				die(_("git apply: bad git-diff - inconsistent new filename on line=
 %d"), linenr);
+			else
+				die("BUG: please add a new full string for '%s' similar to above c=
ode.\n"
+				    "It makes translators' life much simpler. Thanks!", oldnew);
+		}
 		free(another);
 		return orig_name;
 	}
--=20
1.7.8.36.g69ee2
