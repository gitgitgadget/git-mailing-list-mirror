From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/5] Header includes cleanup
Date: Tue, 31 Mar 2009 07:53:11 +0200
Message-ID: <200903310753.11595.chriscool@tuxfamily.org>
References: <1238406925-15907-1-git-send-email-nathaniel.dawson@gmail.com> <49D0A3DF.4000203@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nathaniel P Dawson <nathaniel.dawson@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 07:55:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoWwv-0001lJ-AJ
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 07:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756207AbZCaFyQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 01:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756182AbZCaFyQ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 01:54:16 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:59070 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755788AbZCaFyP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 01:54:15 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id AD0674C80F6;
	Tue, 31 Mar 2009 07:54:07 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id C086C4C8018;
	Tue, 31 Mar 2009 07:54:04 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <49D0A3DF.4000203@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115222>

Le lundi 30 mars 2009, Johannes Sixt a =E9crit :
> Please wrap your lines at ca. 75 columns.
>
> Nathaniel P Dawson schrieb:
> > This is just the beginning for this project. I'm slowly cleaning up
> > the header includes one chunk at a time. I hope my patches aren't t=
oo
> > messy, I've learned how to better utilize git to make patches and
> > organize my commits logically so I'll submit neater chunks hencefor=
th.
> > You can expect patches from me nightly until I've finished this
> > project.
>
> You have removed includes that are implied by other includes, i.e. if
> foo.h includes bar.h, then you removed #include "bar.h" from *.c if t=
here
> is #include "foo.h".
>
> IMO, this is not a good guiding principle to reduce includes. A bette=
r
> principle is to keep #include "bar.h" in a source or header file iff =
a
> feature that is declared or defined in bar.h is *used* *directly* in =
that
> source or header file, regardless of whether bar.h is included in foo=
=2Eh
> that is itself included in that source or header file.

In theory, it's perhaps the best way to do it. But we don't do that for=
=20
system header includes. And I think it makes it very difficult to clean=
up=20
header includes, because you have to check what is needed for each feat=
ure=20
in a file. So I think we have to choose between basically no header inc=
lude=20
cleanup or a cleanup like the one Nathaniel started.

> If this latter principle is obeyed, then the build won't break by
> removing the include of foo.h (for the reason that nothing of foo.h i=
s
> *use* *directly* anymore).

I think it's more likely that we will add features rather than remove s=
ome.
And it's not very difficult if we remove some, to remove "foo.h" and=20
add "bar.h" at the same time.

=46or example, many files include "cache.h", does it really make sense =
to try=20
to remove these #include because we could replace them by only includes=
=20
of "git-compat-util.h" and "hash.h"? I don't think so.

Best regards,
Christian.
