From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Display line numbers in gitk?
Date: Tue, 11 Oct 2011 16:16:41 +0200
Message-ID: <CAHGBnuNPUMq+bCEcqTMpov6mG4ar4vCi4iV64fG2=jbC-xSpaQ@mail.gmail.com>
References: <4E904FA7.2060606@gmail.com>
	<CABNJ2GLaquXK7o_V_6KmOtnbcCGXMgbupbVJzXU_yK=2a=wKSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 16:16:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDd8W-00075P-P9
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 16:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805Ab1JKOQn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Oct 2011 10:16:43 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43971 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496Ab1JKOQm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2011 10:16:42 -0400
Received: by vws1 with SMTP id 1so5562831vws.19
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 07:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=idQtVOqNr23C3A/247w7GfzeBtFF5g6dBXLMRRoQvSo=;
        b=YWKj3NQaBmZqGsrPuMITOplQLPpLVFLvG3TrXgdY66iKBueqd0hBZlwZQ0ajTbeaOg
         Lc032NDetYOl1kuCWgZEi/hW8yMdxxa/nad2xucWiiMFFmoMAZX4/pyZmlLxeTQyoDCB
         iXMUdqjYFd07BpXL3iqRHJblzZPAi4v0NNMCY=
Received: by 10.52.31.102 with SMTP id z6mr18485812vdh.110.1318342601632; Tue,
 11 Oct 2011 07:16:41 -0700 (PDT)
Received: by 10.220.188.69 with HTTP; Tue, 11 Oct 2011 07:16:41 -0700 (PDT)
In-Reply-To: <CABNJ2GLaquXK7o_V_6KmOtnbcCGXMgbupbVJzXU_yK=2a=wKSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183297>

On Tue, Oct 11, 2011 at 16:00, Pat Thoyts <patthoyts@gmail.com> wrote:

(putting the list back on CC)

> Not currently possible. It can be done though. Is this just for the
> file view or patch view as well?
> The following seems to work reasonably well for just the file view.

Thanks, from my tests it seems to work indeed very well. Although I
was initially thinking about the patch view.

A downside of line numbers in the file view could be that they'll be
copied to the clipboard, too, if you copy and paste code from there,
so they should probably be implemented as an option.

> From 0e18a9a2789838925f2ed50b05ce9d7e6c3a9a38 Mon Sep 17 00:00:00 200=
1
> From: Pat Thoyts <patthoyts@users.sourceforge.net>
> Date: Tue, 11 Oct 2011 14:57:24 +0100
> Subject: [PATCH] gitk: display line numbers for file view
>
> Suggested-by: Sebastian Schuberth <sschuberth@gmail.com>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> ---
> =C2=A0gitk | =C2=A0 =C2=A05 ++++-
> =C2=A01 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/gitk b/gitk
> index 4cde0c4..70d8f57 100755
> --- a/gitk
> +++ b/gitk
> @@ -2277,6 +2277,9 @@ proc makewindow {} {
> =C2=A0 =C2=A0 if {$have_tk85} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ctext conf -tabstyle wordprocessor
> =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0catch {eval font create linenofont [font configure tex=
tfont] \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-size [expr {[font =
configure textfont -size] - 2}]}
> + =C2=A0 =C2=A0$ctext tag configure lineno -foreground #808080 -font =
linenofont
> =C2=A0 =C2=A0 ${NS}::scrollbar .bleft.bottom.sb -command "$ctext yvie=
w"
> =C2=A0 =C2=A0 ${NS}::scrollbar .bleft.bottom.sbhorizontal -command "$=
ctext
> xview" -orient h
> =C2=A0 =C2=A0 pack .bleft.top -side top -fill x
> @@ -7316,7 +7319,7 @@ proc getblobline {bf id} {
> =C2=A0 =C2=A0 $ctext config -state normal
> =C2=A0 =C2=A0 set nl 0
> =C2=A0 =C2=A0 while {[incr nl] <=3D 1000 && [gets $bf line] >=3D 0} {
> - =C2=A0 =C2=A0 =C2=A0 $ctext insert end "$line\n"
> + =C2=A0 =C2=A0 =C2=A0 $ctext insert end $nl lineno "\t" {} "$line\n"
> =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 if {[eof $bf]} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0global jump_to_here ctext_file_names comme=
ntend
> --
> 1.7.7.1.gbba15
