From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Bisect visualize: use "for-each-ref" to list all good refs.
Date: Thu, 15 Nov 2007 07:43:59 +0100
Message-ID: <200711150743.59716.chriscool@tuxfamily.org>
References: <20071114055036.2c5ae793.chriscool@tuxfamily.org> <7voddxkzzw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 07:37:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsYM6-0001Am-4V
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 07:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbXKOGhS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2007 01:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbXKOGhS
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 01:37:18 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:53986 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459AbXKOGhQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Nov 2007 01:37:16 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 318AF1AB2CA;
	Thu, 15 Nov 2007 07:37:15 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 192481AB2D1;
	Thu, 15 Nov 2007 07:37:15 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7voddxkzzw.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65069>

Le mercredi 14 novembre 2007, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > In bisect_visualize, "cd $GIT_DIR/refs && echo bisect/good-*" was
> > still used instead of "git for-each-ref". This patch fix it.
>
> Heh, it still uses
>
> 	echo "$rev" >"$GIT_DIR/refs/bisect/$tag"
>
> So we are still _very_ much tied to refs on the filesystem not
> in packed-refs.

Yes, but someone (guess who) started to modernize git-bisect by=20
using "for-each-ref":

http://git.kernel.org/?p=3Dgit/git.git;a=3Dcommitdiff;h=3D6fecf1915c5fd=
0b14e2ca2ec9e1a6b620abfb5c2
http://git.kernel.org/?p=3Dgit/git.git;a=3Dcommitdiff;h=3D0a5280a9f444c=
33b0e4ebf2f073df5899c112cf8

so I thought it would be fine to finish this modernization work.

> Even worse is that bisect_clean_state uses
>
> 	rm -fr "$GIT_DIR/refs/bisect"
>
> so if you ever pack your refs in the middle of bisection and
> then clean the state, you will still carry the old good set of
> commits that are somewhat hard to cull.

Thanks for reminding me of this problem. I just posted a patch that sho=
uld=20
fix it.

Best regards,
Christian.
