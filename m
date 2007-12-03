From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/3] git-help: add -i|--info option to display info page.
Date: Mon, 3 Dec 2007 06:53:14 +0100
Message-ID: <200712030653.15694.chriscool@tuxfamily.org>
References: <20071202060740.269e54ad.chriscool@tuxfamily.org> <475272CF.40602@obry.net> <7vodd9zbvt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pascal Obry <pascal@obry.net>, git@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 06:47:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz49F-0002YE-PT
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 06:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbXLCFqv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Dec 2007 00:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbXLCFqv
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 00:46:51 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:56932 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338AbXLCFqu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Dec 2007 00:46:50 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id CD8BD1AB2C1;
	Mon,  3 Dec 2007 06:46:47 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 650341AB2B6;
	Mon,  3 Dec 2007 06:46:47 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7vodd9zbvt.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66868>

Le dimanche 2 d=C3=A9cembre 2007, Junio C Hamano a =C3=A9crit :
> Pascal Obry <pascal@obry.net> writes:
> >
> > If would be nice if this could be more generic. For example I'd lik=
e to
> > use Emacs woman mode instead of info. Can't we have something like
> >
> >    $ git help --ext XXX
> >
> > "ext" standing for external and calling whatever command recorded i=
nto
> > .gitconfig for example ?
>
> There is a bit of conflict here.  We could do that and make the
> implementation of "ext" command responsible to transform "commit" in
>
> 	$ git help --ext commit
>
> to the location of manual page (or formatted HTML page, or node in th=
e
> info documentation).  git itself does not need to know much about whe=
re
> the help material is in such an implementation.
>
> But Christian's series is about making such "ext" thing easier to wri=
te.
> No matter what kind of web browser is used, it needs to be told where
> the preformatted HTML page for git-commit command is (and it does not
> care where git-commit.1 manpage is found or what the node is called i=
n
> git.info document).  It makes it a bit too limiting by defining -w (w=
eb)
> and -i (info) upfront without offering -x (ext), but we need to start
> somewhere.

Yeah, I think that the user should be able to choose both the format an=
d the=20
tool used for help pages. And that we should start to make more popular=
=20
formats and tools work well first. That means HTML with web browser fir=
st.
(And yeah, my first patch is about "info", but it was a very low hangin=
g=20
fruit.)

In the end we may want to support many other tools and format. For exam=
ple:

"git help --format=3Dman --tool=3Dkonqueror log" or
"git help -m --tool=3Dkonqueror log"

would launch something like: "konqueror 'man:git-log(1)'"

But of course, to be able to do that, we have to know how each tool is=20
working, because the syntax has a good chance to be different in each c=
ase.

If we provide a -x|--ext upfront and we don't check if we know about th=
e=20
tool the user wants to use, then we will not get information about how =
to=20
properly use the tool and we may break without any meaningfull error fo=
r=20
many of them.

So if someone has information about how "woman" or other web or man or =
info=20
browser can be used, I will be glad to collect it and eventually use it=
 to=20
try to make "git help" work for the tool (though I don't promise to tes=
t=20
them on platform other than Linux), but I will focus on web formats and=
=20
tools first. Patches are welcome too.=20

Thanks in advance,
Christian.
