From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Article about "git bisect run" on LWN
Date: Tue, 10 Feb 2009 07:12:31 +0100
Message-ID: <200902100712.31820.chriscool@tuxfamily.org>
References: <200902050747.50100.chriscool@tuxfamily.org> <alpine.DEB.1.00.0902091414310.10279@pacific.mpi-cbg.de> <ee77f5c20902091303v1d268761ufdc85e2364097d84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ingo Molnar <mingo@elte.hu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Ericsson <ae@op5.se>, Jeff Garzik <jeff@garzik.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bill Lear <rael@zopyra.com>,
	Jon Seymour <jon.seymour@gmail.com>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 07:14:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWltP-0007Bw-NF
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 07:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbZBJGNS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Feb 2009 01:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbZBJGNR
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 01:13:17 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:55802 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075AbZBJGNR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Feb 2009 01:13:17 -0500
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id DC6C34C8090;
	Tue, 10 Feb 2009 07:13:04 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 66D994C80D5;
	Tue, 10 Feb 2009 07:13:00 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <ee77f5c20902091303v1d268761ufdc85e2364097d84@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109182>

Le lundi 9 f=E9vrier 2009, David Symonds a =E9crit :
> On Tue, Feb 10, 2009 at 12:15 AM, Johannes Schindelin
>
> <Johannes.Schindelin@gmx.de> wrote:
> > I think Junio meant using '< $file' type redirection, to avoid an
> > unnecessary fork().  (Good habit, avoiding fork()s...)
>
> Yes, I usually pass filenames to grep; this time I was
> copy-and-pasting parts of the original script. But my point still
> remains: it seems it would be cleaner to do this kind of
> always-good-filtering in the test script rather than make git-bisect
> more complex.

But it's not so easy and not efficient to do this kind of filtering in =
the=20
test script.

Maybe something cleaner could be to have "always good" and "always skip=
ped"=20
refs that are automatically used each time you bisect.

=46or example, "git bisect good --always" and "git bisect skip --always=
" could=20
add refs in "refs/bisect/always/" even when you are not bisecting, and=20
these refs would not be removed on reset.

But in the end, I think this does not really fix the problem. If you ne=
ed=20
such hacks, it means that your commit DAG is not easily bisectable. For=
=20
example if you must skip too many commits, then too often bisection wil=
l=20
not be able to point to a first bad commit because it won't be able to =
tell=20
between many skipped commits.

That's why I think the proper fix is to have a way to bisect on a fixed=
 up=20
commit DAG where you can just get rid of old annoying bugs and of histo=
ry=20
parts that are not relevant.

Regards,
Christian.
