From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] git-prompt.sh: show the upstream abbrev name
Date: Tue, 15 Oct 2013 14:21:11 +0200
Message-ID: <20131015122111.GT19704@goldbirke>
References: <1381411933-20600-1-git-send-email-jcarsique@nuxeo.com>
 <20131010135813.GF19704@goldbirke> <5256BD0A.30706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>,
	"Eduardo R . D'Avila" <erdavila@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Julien Carsique <julien.carsique@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 15 14:21:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VW3cl-0002dl-Sg
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 14:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758799Ab3JOMVQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Oct 2013 08:21:16 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:61817 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab3JOMVP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 08:21:15 -0400
Received: from localhost6.localdomain6 (g226140223.adsl.alicedsl.de [92.226.140.223])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0MTxaL-1VN1572OP3-00Qo6x; Tue, 15 Oct 2013 14:21:12 +0200
Content-Disposition: inline
In-Reply-To: <5256BD0A.30706@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:eSfCO52lliaz71n8duES63jOvm85KmYaNYaPx979/m7
 JjXI8en/Xbo21qu4JDVNAXCTe7I7xSS5D/+nF3xxz0ASpVjlht
 uuwfUwDPHVZrbxf8ZbwBb02t3NIU5nj9fQVcdsrh5dInFAUD4H
 IaRNgzZjvPiJa8rKgTJJMshwUTnlKPn5NVWyi7x4R+8EMiH18y
 6EbfHtyfbqnBMsfpaIj6yhYrBooXYXysR63p83hbWjBxm2LYIx
 f1pxlo1nbeY8pTLUoR6kI5La/LX0R8t2+KSRmQL9C9yXFhON1E
 /4Bae6r9k/ILyfZdKUC2JZVNkXFleCz+soQKODX10kfRgazO47
 vu5Z9lCOBy+OP4S30Rx5oiaH9N2F0yCf6DVn59C5y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236179>

On Thu, Oct 10, 2013 at 04:43:22PM +0200, Julien Carsique wrote:
> It's fixed.

Thanks, the updated patch looks good to me.

> Note '+=3D' was already used line 114:
>=20
>             svn_url_pattern+=3D"\\|$value"

I guess noone has tried to use the upstream status indicator with an
SVN upstream and an ancient Bash version yet, thanks for pointing it
out.

-- >8 --
Subject: [PATCH] bash prompt: don't use '+=3D' operator in show upstrea=
m code path

The '+=3D' operator is not supported by old Bash versions (3.0) we stil=
l
care about.

Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
---
 contrib/completion/git-prompt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index 202e2e520f..7b732d2aeb 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -111,7 +111,7 @@ __git_ps1_show_upstream ()
 			;;
 		svn-remote.*.url)
 			svn_remote[$((${#svn_remote[@]} + 1))]=3D"$value"
-			svn_url_pattern+=3D"\\|$value"
+			svn_url_pattern=3D"$svn_url_pattern\\|$value"
 			upstream=3Dsvn+git # default upstream is SVN if available, else git
 			;;
 		esac
--=20
1.8.4.1.495.gd8d272e
