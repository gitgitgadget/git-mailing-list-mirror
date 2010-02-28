From: Pat Thoyts <patthoyts@googlemail.com>
Subject: Re: [msysGit] [PATCH 2/3] git-gui: fix PATH environment for mingw 
	development environment
Date: Sun, 28 Feb 2010 00:57:14 +0000
Message-ID: <a5b261831002271657n41ab0f37sc0af50d3a768bfd1@mail.gmail.com>
References: <20100223224955.GB11271@book.hvoigt.net>
	 <cb7bb73a1002231454j4720b28ei20c10de37e929fde@mail.gmail.com>
	 <20100223230238.GD11271@book.hvoigt.net>
	 <cb7bb73a1002242353h739786bdlb2c57df3438f5b7f@mail.gmail.com>
	 <20100227204108.GA33000@book.hvoigt.net>
	 <20100227204549.GB33000@book.hvoigt.net>
	 <20100227204741.GC33000@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Feb 28 01:57:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlXTQ-0003bz-1N
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 01:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031006Ab0B1A5R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2010 19:57:17 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:35309 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031003Ab0B1A5Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Feb 2010 19:57:16 -0500
Received: by wwa36 with SMTP id 36so719625wwa.19
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 16:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=M5fGHB2/LXvIHi4qvuVpguwArcmGQcrLz0p7A7qPzss=;
        b=qdgS5mP4MAz+JirU+0q1uNZSJs/iovlIFehxPedYvu482+Pzj9WCr2hYAMglMtujzd
         At/X1TxQLBZzbYV9XwcuQkwzWVSXnj8ttrZDUm/G5k4y2wPLftLhaKNymAf9QV38oLum
         W95wBUB9iW+s64hKDee32rU+HfPsl35eQDcB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OKCX7ITKqsz7kxP+wCwRxb6MPvppCUjkInR6erf1MsHsGdA/GrybRVqkUd6Dt1hRbk
         E8TdFGmZujSOb6bzQxrJpu8FMnbDp88sZ1lnDY+fliUJdTuNyVxjpC4SQcRJinNXCAvT
         8I3+TSdUC/LwKB5KRTOTqBgS7EsMa5D9GYIL4=
Received: by 10.216.172.70 with SMTP id s48mr1830420wel.114.1267318635006; 
	Sat, 27 Feb 2010 16:57:15 -0800 (PST)
In-Reply-To: <20100227204741.GC33000@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141239>

On 27 February 2010 20:47, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> When creating a desktop shortcut from the gui the shortcut directly
> starts wish with the git-gui script. In the msysgit development
> environment some dll's reside in the mingw/bin directory which causes
> that git can not start because libiconv2.dll is not found.
>
> When using such a link the error is even more cryptic stating:
> "child killed: unknown signal"
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
> I am not sure whether this is the most elegant solution, but making t=
his
> work would definitely ease the development workflow.
>
> =C2=A0git-gui/windows/git-gui.sh | =C2=A0 =C2=A05 +++--
> =C2=A01 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/git-gui/windows/git-gui.sh b/git-gui/windows/git-gui.sh
> index 66bbb2f..b1845c5 100644
> --- a/git-gui/windows/git-gui.sh
> +++ b/git-gui/windows/git-gui.sh
> @@ -13,10 +13,11 @@ if { $argc >=3D2 && [lindex $argv 0] =3D=3D "--wo=
rking-dir" } {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0incr argc -2
> =C2=A0}
>
> -set bindir [file dirname \
> +set basedir [file dirname \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [file dirname \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[file dirname [info s=
cript]]]]
> -set bindir [file join $bindir bin]
> +set bindir [file join $basedir bin]
> +set bindir "$bindir;[file join $basedir mingw bin]"
> =C2=A0regsub -all ";" $bindir "\\;" bindir
> =C2=A0set env(PATH) "$bindir;$env(PATH)"
> =C2=A0unset bindir
> --
> 1.7.0.m5.rc3.5.g38df2

I have not tried to test this - I use cmd shell all the time so I
always run this using 'git gui' which runs the git.cmd script in
ProgramFiles\Git\cmd or in the development environment in
msysgit\cmd\. It makes me wonder if the Windows shortcut shouldn;t be
pointing to the cmd script rather than to a tcl script like this as
the cmd script does some quite extensive environment setup. It assigns
HOME if it is not set, extends the PATH to include the git
installation locations, sets the PLINK_PROTOCOL and the codepages for
the console. Probably only the PATH and HOME fixups are necessary for
git-gui and in fact tcl's configuration of "~" in the path as HOME
probably deals with that too.
This is just for the development setup right? An installation of
msysGit doesn't have a mingw\bin directory.
Pat Thoyts
