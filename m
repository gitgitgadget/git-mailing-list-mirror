From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 06/17] gettext: localize the main git-init message
Date: Mon, 30 Aug 2010 21:28:12 +0000
Message-ID: <1283203703-26923-7-git-send-email-avarab@gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 23:30:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqBvZ-0000N5-Jo
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 23:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755983Ab0H3V26 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 17:28:58 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45001 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900Ab0H3V25 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 17:28:57 -0400
Received: by mail-wy0-f174.google.com with SMTP id 35so7081766wyb.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 14:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=AASI+FYN2vD4ice4KPBN7H8RRRiJUsYj+hM8KNZbM6I=;
        b=rYITx1Rd/sHFfgR8jJ9nkwRaBtA7j9nodZWhXi1zmqeBvSzvdgnYWpUt/n3FnosNFI
         Wp7+WV/h38xvDYFhmWK1z52qQW5VZ4kbaFajd39p+jOi3JfmFkcSOn1MLwhfsP04s5wx
         6mHjDL187DvceFdEMcg/zCg4d7tJ6FE7Y8q6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XWHpcdnauyAlS6vzty+/TL3c98skqXXq8iDLjXhmDFP0q/MkZLd3sSlSwBvvYkSpC/
         mien0UGQXiJVnR+4Qp6MEKhXIKaxSFXZFR4tlCG5jRnXYY1hQj/Ga/vdiEqtWzRI4qbj
         ej/BnCwdSolTEiz6mFIZkd2g6hcvxNBUC3hTo=
Received: by 10.227.137.15 with SMTP id u15mr5431018wbt.129.1283203735626;
        Mon, 30 Aug 2010 14:28:55 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b23sm6923116wbb.22.2010.08.30.14.28.54
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 14:28:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.536.g3f548
In-Reply-To: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154853>

Change the git-init "Initialized empty Git repository" message and its
variants to use gettext.

This is one of the messages that could do with splitting up, I had a
WIP patch to do that that began like this:

    const char *reinit_shared   =3D _("Reinitialized existing shared Gi=
t repository in %s\n");
    const char *init_shared	    =3D _("Initialized empty shared Git rep=
ository in %s\n");
    const char *reinit_noshared =3D _("Reinitialized existing Git repos=
itory in %s\n");
    const char *init_noshared   =3D _("Initialized empty Git repository=
 in %s\n");

But in the first round of gettextization I'm aiming to keep code
changes to a minimum for ease of review.

We can solicit input from translators about which messages that use
too much sprintf-ing are troublesome, and change those later.

Note that the TRANSLATORS comment doesn't use the usual Git
style. This is because everything from "/* TRANSLATORS: " to "*/" will
extracted as-is xgettext(1) and presented to translators, including
newlines and leading "*"'s. There seems to be no way to change that,
short of patching xgettext itself.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/init-db.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 9c08985..0224dee 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -348,9 +348,13 @@ int init_db(const char *template_dir, unsigned int=
 flags)
 	if (!(flags & INIT_DB_QUIET)) {
 		const char *git_dir =3D get_git_dir();
 		int len =3D strlen(git_dir);
-		printf("%s%s Git repository in %s%s\n",
-		       reinit ? "Reinitialized existing" : "Initialized empty",
-		       shared_repository ? " shared" : "",
+
+		/* TRANSLATORS: The first '%s' is either "Reinitialized
+		   existing" or "Initialized empty", the second " shared" or
+		   "", and the last '%s%s' is the verbatim directory name. */
+		printf(_("%s%s Git repository in %s%s\n"),
+		       reinit ? _("Reinitialized existing") : _("Initialized empty")=
,
+		       shared_repository ? _(" shared") : "",
 		       git_dir, len && git_dir[len-1] !=3D '/' ? "/" : "");
 	}
=20
--=20
1.7.2.2.536.g3f548
