From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 1/7] reset: do not accept a mixed reset in a .git dir
Date: Wed, 16 Dec 2009 07:36:46 +0100
Message-ID: <200912160736.46826.chriscool@tuxfamily.org>
References: <20091212042042.3930.54783.chriscool@tuxfamily.org> <200912152041.36194.chriscool@tuxfamily.org> <7vskbcyot5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 07:34:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKnSq-0007go-KX
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 07:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761652AbZLPGeT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Dec 2009 01:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761631AbZLPGeT
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 01:34:19 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:54657 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756661AbZLPGeS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2009 01:34:18 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 91834818068;
	Wed, 16 Dec 2009 07:34:07 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 5B4F6818089;
	Wed, 16 Dec 2009 07:34:04 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vskbcyot5.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135323>

On mardi 15 d=E9cembre 2009, Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> >     While at it, instead of disallowing "git reset --option" outsid=
e
> >     a work tree only when option is "hard" or "merge", we now disal=
low
> >     it except when option is "soft" or "mixed", as it is safer if w=
e
> >     ever add options to "git reset".
>
> I fail to see any sane logic behind this reasoning; you cannot decide=
 if
> you need to allow or disallow the new --option with unspecified seman=
tics
> until you have that --option, and you are saying
>
> Hmm, "reset --option" that does not work when it should work is a bug=
,
> just like "reset --option" that does not refuse to work when it shoul=
d
> refuse is, and you cannot decide if you should allow a new --option u=
ntil
> you have it.  Your "disallowing everything the code does not know abo=
ut
> by default" doesn't particularly sound safer to me.  I'd suggest drop=
ping
> it from this patch.

Ok, I will drop it.

> It is perfectly fine to have a change like that, if it makes the logi=
c
> easier to follow with the updated repertoire when a new --option is
> added, but not before.

Ok.

[...]

> By "after the next patch, it will not fail in a bare repository",
> did you mean "if the next patch blindly replaced an external call to
> read-tree with an internal call to unpack_trees(), it will change the
> behaviour, and we will end up allowing '--mixed in bare'.  To prevent=
 it
> from happening, cmd_reset() should check that condition upfront"?

Yes, that's what I meant.

> Then you were not trying to hide regressions (which makes me happier)=
=2E
> But then doesn't the change belong to the next patch, not this one?

I can put it in the patch that calls unpack_trees() directly, but on th=
e=20
other hand it can also be seen as an improvement that could be applied=20
to "maint" as it improves the error message.

Best regards,
Christian.
