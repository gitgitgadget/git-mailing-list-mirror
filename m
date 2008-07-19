From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Sat, 19 Jul 2008 15:27:50 -0700
Message-ID: <7vy73xy0ex.fsf@gitster.siamese.dyndns.org>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com>
 <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx>
 <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness>
 <20080716012619.GM8185@mit.edu> <7viqv5r637.fsf@gitster.siamese.dyndns.org>
 <4882350B.6020003@free.fr> <7v3am5zfea.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Stephan Beyer <s-beyer@gmx.net>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Sun Jul 20 00:29:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKKvL-0006k5-2q
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 00:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273AbYGSW2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 18:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753137AbYGSW2F
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 18:28:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45711 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbYGSW2D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 18:28:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 728763820E;
	Sat, 19 Jul 2008 18:28:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8E0013820B; Sat, 19 Jul 2008 18:27:52 -0400 (EDT)
In-Reply-To: <7v3am5zfea.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 19 Jul 2008 15:18:53 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F30ADFC0-55E1-11DD-9BD5-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89139>

Junio C Hamano <gitster@pobox.com> writes:

> I'm happy with the documentation and help-text parts of your patch, but
> probably this, on top of 1a6f6bb (git am --abort, 2008-07-16), is more
> appropriate?
>
> --- 
>  git-am.sh           |    6 +++---
>  t/t4151-am-abort.sh |   46 +++++++++++++++++++++++++++-------------------
>  2 files changed, 30 insertions(+), 22 deletions(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index a44bd7a..5cbf8f4 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -203,9 +203,9 @@ then
>  
>  	case "$abort" in
>  	t)
> -		rm -fr "$dotest" &&
> -		git read-tree -m -u ORIG_HEAD &&
> -		git reset ORIG_HEAD && :
> +		git rerere clear
> +		git read-tree --reset -u HEAD ORIG_HEAD
> +		rm -fr "$dotest"

We still need "git reset ORIG_HEAD" after the read-tree.  Sorry about the
noise.

>  		exit ;;
>  	esac
>  else
