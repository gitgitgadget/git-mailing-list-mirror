From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] tagsize < 8kb restriction
Date: Wed, 24 May 2006 12:39:32 -0700
Message-ID: <7v1wuj6wln.fsf@assigned-by-dhcp.cox.net>
References: <4471CF23.1070807@gmx.de>
	<7vac99c1hv.fsf@assigned-by-dhcp.cox.net> <44737353.20904@gmx.de>
	<7vzmh81gfa.fsf@assigned-by-dhcp.cox.net> <4474B10A.1020704@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 21:39:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FizCj-0003CT-PN
	for gcvg-git@gmane.org; Wed, 24 May 2006 21:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWEXTje convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 24 May 2006 15:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWEXTje
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 15:39:34 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:41111 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751180AbWEXTje convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 15:39:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060524193933.TBSI19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 24 May 2006 15:39:33 -0400
To: =?iso-8859-1?Q?Bj=F6rn?= Engelmann <BjEngelmann@gmx.de>
In-Reply-To: <4474B10A.1020704@gmx.de> (=?iso-8859-1?Q?Bj=F6rn?= Engelmann's
 message of "Wed, 24
	May 2006 21:16:26 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20703>

Bj=F6rn Engelmann <BjEngelmann@gmx.de> writes:

> That is why I said, all input should be validated by default. All I
> proposed was
> a) unify the tools in order to have less duplicate code
> (git-mktag, git-mktree & git-hash-object do merely the same
> except for the validating part)
> b) remove the possibility to introduce unchecked objects of arbitrary
> type (or only allow it with the -f =3D "force, use with caution"-opti=
on)
> maybe I should have written "blob, tag, tree or commit" instead of
> "arbitrary". I did not mean really arbitrary like it is implemented
> right now in git-hash-object.

Sorry, I forgot all about hash-objects X-<.  It was a convenient
way to try out new things such as 'gitlink'.  Thanks for the
clarification.

As to unification, I am not sure if there are a lot to unify.
Everybody starts with type, length and a LF, but after that each
type has its own format constraints.  A grand unified command
that knows about format constraints of every type under the sun
does not sound like a good approach.  While we have only handful
types (and I expect things will stay that way) it is not a big
deal either way, though.

And the common part is already shared (write_sha1_file_prepare()
and write_sha1_file() from sha1_file.c).
