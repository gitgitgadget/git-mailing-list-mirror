From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] t9001: set TERM=dumb to prevent ANSI output
Date: Fri, 7 Mar 2008 05:41:15 +0100
Message-ID: <200803070541.15793.chriscool@tuxfamily.org>
References: <alpine.LSU.1.00.0803061752340.3941@racer.site> <7vmypb8muj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 05:36:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXUJY-000873-CW
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 05:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760251AbYCGEfd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 23:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760187AbYCGEfd
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 23:35:33 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:47782 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759223AbYCGEfc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2008 23:35:32 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 5E2901AB2BB;
	Fri,  7 Mar 2008 05:35:30 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id F24F21AB2B1;
	Fri,  7 Mar 2008 05:35:29 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7vmypb8muj.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76460>

Le vendredi 7 mars 2008, Junio C Hamano a =E9crit :
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > At least on one of my machines, Term::ReadLine tries to be clever a=
nd
> > sends \x1b\x5b1034h at the end of the script when TERM is set to
> > 'xterm'.
> >
> > To prevent that, force TERM=3Ddumb just for the test.
>
> We try to set up a pretty vanilla environment for test repeatability =
in
> t/test-lib.sh, and I suspect we would simply want to do this over the=
re.
>
> Wouldn't this make more sense?
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 87a5ea4..7f6331a 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -7,8 +7,9 @@
>  LANG=3DC
>  LC_ALL=3DC
>  PAGER=3Dcat
> +TERM=3Ddumb
>  TZ=3DUTC
> -export LANG LC_ALL PAGER TZ
> +export LANG LC_ALL PAGER TERM TZ
>  EDITOR=3D:
>  VISUAL=3D:
>  unset GIT_EDITOR

This may not work well with colored output.
In test-lib.sh line 62 there is :

[ "x$TERM" !=3D "xdumb" ] &&
	[ -t 1 ] &&
	tput bold >/dev/null 2>&1 &&
	tput setaf 1 >/dev/null 2>&1 &&
	tput sgr0 >/dev/null 2>&1 &&
	color=3Dt

Thanks,
Christian.
