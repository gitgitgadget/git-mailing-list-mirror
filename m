From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] Pull request for msysGit patches
Date: Tue, 28 Sep 2010 23:13:48 +0200
Message-ID: <201009282313.48278.j6t@kdbg.org>
References: <87ocbitd33.fsf@fox.patthoyts.tk> <201009282252.25688.j6t@kdbg.org> <AANLkTikSxpXJkeneWbJQ_2g32w1bV-CEdyk2_5G2Xd+u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 28 23:13:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0hUq-0000hH-Mi
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 23:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222Ab0I1VNv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 17:13:51 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:11401 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941Ab0I1VNv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 17:13:51 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 8C4C5CDF83;
	Tue, 28 Sep 2010 23:13:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 589C319F5C4;
	Tue, 28 Sep 2010 23:13:48 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTikSxpXJkeneWbJQ_2g32w1bV-CEdyk2_5G2Xd+u@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157475>

On Dienstag, 28. September 2010, Erik Faye-Lund wrote:
> On Tue, Sep 28, 2010 at 10:52 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> >> =A0 =A0 =A0 mingw: do not crash on open(NULL, ...)
> >
> > This one is bogus, and as it stands, it must have my Ack removed. :=
)
> > Needs the same fix in mingw_fopen as mingw_freopen. (There remains =
an
> > unprotected dereference of filename.)
>
> I believe the version in for-junio already has this fix squashed in.
> The following hunk, taken from
> http://repo.or.cz/w/git/mingw/4msysgit.git/blobdiff/4e93566b07dcf47ec=
b6484d
>225418c04c1eedee6..b18500977d88b13803ecc60cf383538139ec09d8:/compat/mi=
ngw.c
> shows that it is... Or are you thinking of something else?
>
> @@ -346,7 +346,7 @@ FILE *mingw_fopen (const char *filename, const ch=
ar
>	if (hide_dotfiles =3D=3D HIDE_DOTFILES_TRUE &&
>  	basename((char*)filename)[0] =3D=3D '.')
                        ^^^^^^^^
This can crash, too.

>  		hide =3D access(filename, F_OK);
> -	if (!strcmp(filename, "/dev/null"))
> +	if (filename && !strcmp(filename, "/dev/null"))
>  		filename =3D "nul";
>  	file =3D fopen(filename, otype);
>  	if (file && hide && make_hidden(filename))

-- Hannes
