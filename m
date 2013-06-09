From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: What's cooking in git.git (Jun 2013, #03; Thu, 6)
Date: Sun, 9 Jun 2013 23:48:33 +0200
Message-ID: <20130609214833.GE2091@goldbirke>
References: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org>
 <20130607000006.GA25731@goldbirke>
 <CALkWK0=D7sHLgptWkFHma1FoS-zdifHqXnuuBKhkyuszgEJ0Xw@mail.gmail.com>
 <7v8v2lu5ks.fsf@alter.siamese.dyndns.org>
 <20130607191643.GA31625@goldbirke>
 <7vwqq5snzi.fsf@alter.siamese.dyndns.org>
 <20130607204430.GD31625@goldbirke>
 <7vk3m5si4h.fsf@alter.siamese.dyndns.org>
 <20130608001147.GA32350@goldbirke>
 <7v1u8bouam.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 23:48:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlnTs-0002PC-4M
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 23:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647Ab3FIVsj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 17:48:39 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:64299 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993Ab3FIVsj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 17:48:39 -0400
Received: from localhost6.localdomain6 (f051160074.adsl.alicedsl.de [78.51.160.74])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0MGz2I-1UZ69L3NvW-00DO4c; Sun, 09 Jun 2013 23:48:34 +0200
Content-Disposition: inline
In-Reply-To: <7v1u8bouam.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:NrSzgGZBsNqfeR82UCT399Zgv0cjMRnSODMmYsew8fC
 SQXkQuWd9jv7fyFTu1q83SzzDgnS+WynbKM+ajYEFgNdEIuJoG
 zhROML1IzZPUww54Re1QpTCo4jaTlVnUdI4pBLN/Mu8238ElD8
 fW6zLI7o5ZbJkN4AQQbeqLNlh7Wapg1QFp3rsu401Zk6CXunu8
 dAc1E1NM1DlDXyr5c5QFKjIc0ZBHdhlMlvTRfOVXjTJuaLxRQn
 YP7JUowTSVsrTFg1ytjIEKELqsy57ZGkWh8PQF55oWmOwDn/iI
 psds86GM4jMlXrpxCmgjznoLA5aBjCFUGak8yU3cKqn8lrc5h2
 A0tiYdWS1lpU3XrY9+l0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227173>

Hi,


On Sun, Jun 09, 2013 at 02:20:33PM -0700, Junio C Hamano wrote:
> Regarding that rr/complete-difftool topic, let's revert the tip 2
> commits (the "ls-tree, archive and show" one, and the follow-up
> resurrection of __git_complete_file) with this:
>=20
>     Revert 77c1305 and 3c3b46b
>    =20
>     As explained by SZEDER G=E1bor in $gmane/226272, git_complete_fil=
e
>     helper is about completing <tree-ish>, taking <commit> at the tip=
s
>     of refs and also understanding <tree-ish>:<path> notation, and
>     changing "archive" and "ls-tree" to use git_complete_revlist_file
>     that in addition is meant to expand A..B range notation was a
>     mistake.
>    =20
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>=20
> and then queue this on top of d8517cc6670d (completion: difftool
> takes both revs and files, 2013-06-02), so that the attached and
> d8517cc6670d will be the only two commits that graduate to 'master'
> from this topic.

That's fine with me, except ...

> -- >8 --
> From: Ramkumar Ramachandra <artagnon@gmail.com>
> Date: Sun, 2 Jun 2013 19:33:42 +0530
> Subject: [PATCH] completion: show can take both revlist and paths
>=20
> The 'git show' completion uses __git_complete_file (aliased to
> __git_complete_revlist_file), because accepts <tree-ish>:<path> as
> well as <commit-ish>.  But the command also accepts range of commits
> in A..B notation, so using __git_complete_revlist_file is more
> appropriate.
>=20
> There still remain two users of __git_complete_file, completions for
> "archive" and "ls-tree".  As these commands do not take range
> notation, and "git show" no longer uses __git_complete_file, the
> implementation of can be updated not to complete ranges, but that is

"the implementation of" what?  A word missing perhaps?  Or "the
implementation can be updated"?


Best,
G=E1bor

> a separate topic.
>=20
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 1b4b0f9..b9dfc3b 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2360,7 +2360,7 @@ _git_show ()
>  		return
>  		;;
>  	esac
> -	__git_complete_file
> +	__git_complete_revlist_file
>  }
> =20
>  _git_show_branch ()
> --=20
> 1.8.3-477-gc2fede3
