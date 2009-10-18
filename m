From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Use "--no-" prefix to switch off some of checkout dwimmery
Date: Sun, 18 Oct 2009 23:02:22 +0200
Message-ID: <20091018210222.GA5371@blimp.localdomain>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com> <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de> <7vzl7pyvzl.fsf@alter.siamese.dyndns.org> <7v63adxh9a.fsf_-_@alter.siamese.dyndns.org> <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com> <7v7huspjg0.fsf@alter.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 18 23:02:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzcti-00073K-Mf
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 23:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253AbZJRVCX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Oct 2009 17:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755250AbZJRVCX
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 17:02:23 -0400
Received: from mout5.freenet.de ([195.4.92.95]:58143 "EHLO mout5.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970AbZJRVCW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 17:02:22 -0400
Received: from [195.4.92.16] (helo=6.mx.freenet.de)
	by mout5.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #92)
	id 1MzctU-0002kc-Mb; Sun, 18 Oct 2009 23:02:24 +0200
Received: from x54ad.x.pppool.de ([89.59.84.173]:53221 helo=tigra.home)
	by 6.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #94)
	id 1MzctU-0004Yw-Dv; Sun, 18 Oct 2009 23:02:24 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 7F555277D8;
	Sun, 18 Oct 2009 23:02:23 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 9914636D28; Sun, 18 Oct 2009 23:02:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v7huspjg0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130612>

The one which guesses local branch name from a remote reference.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Junio C Hamano, Sun, Oct 18, 2009 21:53:51 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
>=20
> > On Sun, Oct 18, 2009 at 10:01, Junio C Hamano <gitster@pobox.com> w=
rote:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OPT_SET_INT(0, "nodwim", &dwim_new_l=
ocal_branch,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "do not dwim=
 local branch creation", 0),
> >
> > Isn't there a special negation support for --no-something in parse-=
options?
>=20
> There probably is, but this is a whetherbaloon patch without document=
ation
> and pretty much Porcelain only, so I took the lazy route.
>=20
> Helping hands in polishing it up is very welcome.

Maybe like this?

BTW, can parse-options take care of the " (default)" addition?

 builtin-checkout.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 6ec9b83..22b023b 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -632,8 +632,8 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 		OPT_STRING(0, "conflict", &conflict_style, "style",
 			   "conflict style (merge or diff3)"),
 		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively")=
,
-		OPT_SET_INT(0, "nodwim", &dwim_new_local_branch,
-			    "do not dwim local branch creation", 0),
+		OPT_SET_INT(0, "dwim", &dwim_new_local_branch,
+			    "Guess local branch from remote reference (default)", 0),
 		OPT_END(),
 	};
 	int has_dash_dash;
--=20
1.6.5.1.50.g84e6e
