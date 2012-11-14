From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: [PATCH] completion: remove 'help' duplicate from porcelain commands
Date: Wed, 14 Nov 2012 01:49:30 +0100
Message-ID: <20121114004930.GT12052@goldbirke>
References: <CAFj1UpE6OtJEojaED1_DZJD0kU=nVsFE_w8xa0oJE-6auCU2rw@mail.gmail.com>
 <CAFj1UpFd9X8Jq5o7B4m35i=merBDvOo4NOtwth=UnG2S5X_rGw@mail.gmail.com>
 <20121113111448.GA3817@goldbirke>
 <CAFj1UpGxx_9GHSnJRpe8hDGB6OTio1mcN71LKcR0pxhSVx2xDw@mail.gmail.com>
 <20121113234636.GS12052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: felipe.contreras@gmail.com
To: Marc Khouzam <marc.khouzam@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 01:50:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYRAw-0001Lc-Oz
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 01:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756076Ab2KNAtl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Nov 2012 19:49:41 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:60654 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756041Ab2KNAtk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 19:49:40 -0500
Received: from localhost6.localdomain6 (p5B13079E.dip0.t-ipconnect.de [91.19.7.158])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MM0VQ-1Tg9Kg2h6C-0088bY; Wed, 14 Nov 2012 01:49:30 +0100
Content-Disposition: inline
In-Reply-To: <20121113234636.GS12052@goldbirke>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:E4lgXs6ECAqVU7bH6mF9iMUCnJk+/bfxBosgJwwPXO2
 F6cgwBj5gxM1qkJDBrk8wjyu6FBrd0iocEqgohgzucLnCW64l/
 m1ACgUBTkeXuVXlAr8wo0HKPRUqF75Q9PucB/MApWKz6Mmp6BC
 fFTVGRywezOylDkbrwPuhdZlRLYxZyb3UHvIxOEGz6PQlsURun
 JV2FEQjSURNA3T7xZe/5OINe44AXf6/We7MJVAuS3y9oWM6OJq
 c3d95X3RBrjlOEI4rtMAQ3EnIXiihvTo3d/FnUAQctY6wfe0dn
 eismLcytmlEHDa9PulkISwWT2J+7eKM0m5dZ6PIG/6AXz+3hZg
 hz4xoQa6bLTwFRe7UJGdCLv2QDcg7TbFz4ec1NYv4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209691>

The list of all git commands is computed from the output of 'git help
-a', which already includes 'help', so there is no need to explicitly
add it once more when computing the list of porcelain commands.

Note that 'help' wasn't actually offered twice because of this,
because Bash filters duplicates from possible completion words.

Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
---

> > > Does the git completion script returns any duplicates at all?
> >=20
> > It does.  'help' is returned twice for example.
>=20
> Right.  Now that you mentioned it, I remember I noticed it a while
> ago, too.  I even wrote a patch to fix it, but not sure what became o=
f
> it.  Will try to dig it up.

Here it is.  It turns out I wrote it in May this year, but according to
gmane and my mailbox never sent it out.

 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index bc0657a2..b7b1a834 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -585,7 +585,7 @@ __git_list_porcelain_commands ()
 {
 	local i IFS=3D" "$'\n'
 	__git_compute_all_commands
-	for i in "help" $__git_all_commands
+	for i in $__git_all_commands
 	do
 		case $i in
 		*--*)             : helper pattern;;
--=20
1.8.0.128.g441b4b3
