From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a remote helper to interact with mediawiki, pull &
 clone handled
Date: Mon, 06 Jun 2011 12:28:34 -0700
Message-ID: <7vmxhu92u5.fsf@alter.siamese.dyndns.org>
References: <1307355635-5580-1-git-send-email-jeremie.nikaes@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Sylvain =?utf-8?Q?Boulm=C3=A9?= <sylvain.boulme@imag.fr>
To: Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 06 21:29:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTfU2-00085D-Gm
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 21:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757321Ab1FFT25 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2011 15:28:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49134 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712Ab1FFT24 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2011 15:28:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 03C8C5539;
	Mon,  6 Jun 2011 15:31:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=laTgeBgO+Uc6
	NUrBuSYaqhMUxw8=; b=uRkpunqnoJM0ZpSLfQ4Nax6qj4yYBryHeuBa8ddT8xpQ
	Q4/ABpQjB7P9jy4ccDRW2Nu3+MjUeOSjVYmoOnMvbezpiT2yh5WKh241/+OOQ1FE
	68vDssKEVyU07oPMQW3gMOxVLCZl64lfdpMEp1gpmr+qlkPuXRAMTeMi5ebzBCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hONT5r
	v7+59fEss4iDDEu1gJPa9ZCUkzqf4kC1ewppB2pn1HlLYVq6TKHODGf03sBRq4JN
	1BMGvadHzW+XlEg3pn2HMc2jJ/1K/38uMPMNcVKeT0Tq5MpPHgdOaQbtie0sVm6g
	/oDc4f+KCUL3ylAuI8rObNT2zKj0GNyf6wvtU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5A741552A;
	Mon,  6 Jun 2011 15:30:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AC8905525; Mon,  6 Jun 2011
 15:30:46 -0400 (EDT)
In-Reply-To: <1307355635-5580-1-git-send-email-jeremie.nikaes@ensimag.imag.fr> (Jeremie
 Nikaes's message of "Mon, 6 Jun 2011 12:20:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8082885C-9073-11E0-9FA5-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175151>

Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr> writes:

> Implement a gate between git and mediawiki, allowing git users to
> ...
> For now, the whole wiki is cloned, but it will be possible to clone o=
nly
> some pages: the clone is based on a list of pages which is now all
> pages.
>
> Code clarified & improved with the help of Jeff King and Junio C Hama=
no.
>
> We were not able to reproduce the empty timestamp bug noticed by Jeff
> King, thus needing some further testing. A placeholder is still
> implemented in case.
>
> Signed-off-by: J=C3=A9r=C3=A9mie Nikaes <jeremie.nikaes@ensimag.imag.=
fr>
> Signed-off-by: Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>
> Signed-off-by: Claire Fousse <claire.fousse@ensimag.imag.fr>
> Signed-off-by: David Amouyal <david.amouyal@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Sylvain Boulm=C3=A9 <sylvain.boulme@imag.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki     |  306 ++++++++++++++++++=
++++++++++
>  contrib/mw-to-git/git-remote-mediawiki.txt |    7 +
>  2 files changed, 313 insertions(+), 0 deletions(-)

This seems to have grown a bit.

I won't repeat issues I pointed out in the earlier round but not update=
d
in this patch to save time.

> +########################## Functions ##############################
> +
> +sub get_last_local_revision {
> +	# Get last commit sha1
> +	my $commit_sha1 =3D `git rev-parse refs/mediawiki/$remotename/maste=
r 2>/dev/null`;
> +
> +	# Get note regarding that commit
> +	chomp($commit_sha1);
> +	my $note =3D `git log --notes=3Dmediawiki 2>/dev/null | grep "media=
wiki_revision: " | sed -n 1p`;

Two and half issues:

 - You are writing Perl no?  Don't call grep/sed from it.  Your
   environment is much richer and more flexible ;-).

 - You grab $commit_sha1 but never use it. Did you mean to throw it at =
the
   "git log" above?

 - Is there a reason you use "git log" to traverse the history all the =
way
   down to the root commit?  Wouldn't

	git notes --ref=3Dmediawiki show $commit_sha1

   or even better yet, just doing

	git notes --ref=3Dmediawiki show refs/mediawiki/$remotename/master

   without the first rev-parse sufficient?

   Are you protecting against the case where some commits in the histor=
y
   leading to mediawiki/$remotename/master may not have the "mediawiki"
   note, and falling back to the latest commit that has note? You may f=
ind
   such a commit, but that may be different from the commit at the tip =
of
   mediawiki/$remotename/master branch. Is that a correct thing to do?
   IOW, does _any_ previous version do for the purpose of this function=
?
   (This paragraph is not a rhetorical question).

> +sub mw_capabilities {
> +	# Revisions are imported to the private namespace
> +	# refs/mediawiki/$remotename/ by the helper and fetched into
> +	# refs/remotes/$remotename later by fetch.
> +	print STDOUT "refspec refs/heads/*:refs/mediawiki/$remotename/*\n";
> +	print STDOUT "import\n";
> +	print STDOUT "list\n";
> +	print STDOUT "option\n";
> +	print STDOUT "push\n";
> +	print STDOUT "\n";

There are many explicit references to STDOUT like this, and also many
unqualified "print" that spits out to the default which is STDOUT in th=
e
codepath to feed fast-import. Is that intentional, or is it just coming
from difference in style of people who worked on different parts of the
code?

If there is no reason to use two styles, please pick one and stick to
it. If there _is_ reason, please document what are the criteria to choo=
se
which one in each codepath.  Otherwise you would waste time of your
reviewers who have to wonder which one is correct in which codepath.
