From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI revamp
Date: Thu, 30 Oct 2008 14:24:53 +0100
Message-ID: <20081030132453.GB24098@artemis.corp>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="BwCQnh7xodEAoBMC";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Sam Vilain <samv@vilain.net>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 14:26:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvXXU-0003iz-WE
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 14:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754962AbYJ3NY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 09:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754938AbYJ3NY5
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 09:24:57 -0400
Received: from pan.madism.org ([88.191.52.104]:39169 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754865AbYJ3NY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 09:24:56 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 79864221;
	Thu, 30 Oct 2008 14:24:54 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 0B4D25EE23C; Thu, 30 Oct 2008 14:24:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1225338485-11046-1-git-send-email-sam@vilain.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99467>


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2008 at 03:48:05AM +0000, Sam Vilain wrote:
> +Add/rm/reset/checkout/revert
> +----------------------------
> +
> +Many find these confusing.
> +
> +  * 'git stage' would do what 'git add' does now.

  -> git stage -i/-p shall do what git add -i/-p does.

> +
> +  * 'git unstage' would do what 'git reset --' does now

  -> likely we need a git unstage -i/-p to interactively unstage some
     bits.

* 'git track' would do what git add -N does now.

* 'git untrack' would do what 'git rm --cached' does now.

> +  * 'git undo' would do what 'git checkout HEAD --' does now

I'm not really a fan of this one. Undo is too unspecific (I know at
least 2 people using that for git reset --hard HEAD~1 and 1 other for an
alias to git reset --hard HEAD@{1}).

I have no constructive proposal to replace it though, but I believe git
undo would cause lots of harm. Would it be for another command, it
wouldn't be a problem, but git undo *LOSES* information by design (the
local changes on a file), and it would override aliases that people
could have done on it. Choosing it has consequences.


> +Working with patches
> +--------------------
> +
> +  * 'git send-email' should prompt for all SMTP-related information
> +    about sending e-mail when it is running with no configuration.
> +    Because these days /usr/lib/sendmail is rarely configured
> +    correctly.

And when the user answer them, it should set them (a bit like zsh does
when it's run from the first time e.g.)

> +
> +  * other git send-email functionality which has bitten people -
> +    particularly building the recipient list - should prompt for
> +    confirmation until configured to be automatic.
> +

  * git-send-email should be either more interactive, or less: either
    just use the damn configuration, or propose a mode where it spawns
    an editor for each patch so that you can add further comments.

  * git-send-email should be able to format-patches by himself (IOW
    accept most of format-patch arguments and deal with the patch list
    by himself, which is usable if the previous point is implemented).

> +  * 'git am -3' the default; with global option to make it not the
> +    default for those that prefer the speed of -2
> +
> +
> +Submodules
> +----------
> +
> +  * submodules should be able to refer to symbolic ref names, svn
> +    style - in the .gitmodules file.  The actual commit used is still
> +    recorded in the index.
> +
> +  * when switching branches, if the checked out revision of a submodule
> +    changes, then it should be switched as well
> +
> +  * 'git submodule update' should be able to be triggered when
> +    switching branches (but not be the default behaviour)

Actually on this one, I'd say that a submodule is either non initialized
(in which case we don't care) or it is. If it is, switching branches
should probably trigger a submodule update if the switch isn't possible
(because the dereferenced sha1 doesn't exists). Or alternatively it
should make the whole branch switch fail.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkJtaQACgkQvGr7W6HudhwOuQCgjnsMRpaZyFkY+Lejoo0cuR9n
LskAn0OuB08kPHaMkYGhPWKkGWFKKGnq
=qVF9
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
