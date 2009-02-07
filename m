From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Article about "git bisect run" on LWN
Date: Sat, 7 Feb 2009 19:09:14 +0100
Message-ID: <200902071909.14752.chriscool@tuxfamily.org>
References: <200902050747.50100.chriscool@tuxfamily.org> <200902070541.29955.chriscool@tuxfamily.org> <ee77f5c20902070455h360d8476re76294735673b4ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>, Jeff Garzik <jeff@garzik.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bill Lear <rael@zopyra.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 19:11:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVreD-0004FK-D3
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 19:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbZBGSJ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Feb 2009 13:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbZBGSJz
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 13:09:55 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:58132 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200AbZBGSJy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Feb 2009 13:09:54 -0500
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 913674C8189;
	Sat,  7 Feb 2009 19:09:41 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id CCCF34C80CD;
	Sat,  7 Feb 2009 19:09:38 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <ee77f5c20902070455h360d8476re76294735673b4ca@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108871>

Le samedi 7 f=E9vrier 2009, David Symonds a =E9crit :
> On Sat, Feb 7, 2009 at 3:41 PM, Christian Couder
>
> <chriscool@tuxfamily.org> wrote:
> > It might be useful to have a list of always good commits too, and u=
se
> > it like this:
> >
> > $ git bisect start <bad> <good> $(cat always_good.txt)
> > $ git bisect skip $(cat always_skipped.txt)
> > $ git bisect run ./my_test_script.sh
>
> Your test script could just do this at its start instead:
>
>   if cat always_good.txt | grep $(rev-parse HEAD); then
>     exit 0

This won't work, because when you give one good rev, you say that all t=
he=20
ancestors of this rev are good (not just that the rev you give is good)=
=2E

>   elif cat always_skipped.txt | grep $(rev-parse HEAD); then
>     exit 125
>   fi

If you have a range like v1..v2 in "always_skipped.txt" this won't work=
=2E
And anyway it may be less efficient because it may perform many useless=
=20
checkouts.

Regards,
Christian.
