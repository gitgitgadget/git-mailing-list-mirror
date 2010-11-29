From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@googlemail.com>
Subject: Re: [PATCH] git-gui: use --exclude-standard to check for untracked files
Date: Mon, 29 Nov 2010 14:33:39 +0100
Message-ID: <AANLkTinTemOzkg8h=eHfqucZK6=yL2WymVW7ff1G9+ee@mail.gmail.com>
References: <1290006804-9142-1-git-send-email-stefan.naewe@googlemail.com>
	<8739qxglfb.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Nov 29 14:33:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN3rX-0002uK-Lk
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 14:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854Ab0K2Ndl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Nov 2010 08:33:41 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52996 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825Ab0K2Ndk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Nov 2010 08:33:40 -0500
Received: by ywl5 with SMTP id 5so1985455ywl.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 05:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pUD4OJ+LRDj9YFDZWcmOw0/j/2Qi43OAtB4iiNDkNFw=;
        b=ckeIa6pZ1FqjhN2/JjoQ75BxY9yZcCbf1ky4zTKYTqJjCTyCSuHYHhDj05IacZ1BVo
         689LzJxPCSxBdvGgXkWBrG5I8OG8R71GO938at1GhLBytE9SmN/WoU14afSSoO8PgVvz
         MGVfdg/Mu68lYvvBXpIxdQugmw/bds0ttUYBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=phrbKLrkJlMAg2ZXiV8EF3nvruUdCDZFv0s4wY/WLquMh4dI4/AWDpczrK5YCFbcgB
         am/Ox9F0Xx4ZehMevrmcPylNjSP73TrVHUs8AzJstZ5T4uQDuxEbNoNGdvzPR0os78iw
         W0nDRq2umyrPsY1b0D5aqTfOdy8GxSWhXI9Wk=
Received: by 10.100.126.1 with SMTP id y1mr4259307anc.100.1291037619199; Mon,
 29 Nov 2010 05:33:39 -0800 (PST)
Received: by 10.101.131.13 with HTTP; Mon, 29 Nov 2010 05:33:39 -0800 (PST)
In-Reply-To: <8739qxglfb.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162386>

(Sorry for the late answer, I was away...)

2010/11/19 Pat Thoyts <patthoyts@users.sourceforge.net>:
> Stefan Naewe <stefan.naewe@googlemail.com> writes:
>
>>This fixes git gui failing to display untracked files if
>>core.excludesfile is set to '~/.gitexcludes'.
>>
>>Signed-off-by: Stefan Naewe <stefan.naewe@googlemail.com>
>>---
>> git-gui/git-gui.sh | =C2=A0 =C2=A09 +--------
>> 1 files changed, 1 insertions(+), 8 deletions(-)
> [..]
> Using --exclude-standard is a good plan. However, as far as I can tel=
l
> this option was added for git 1.6.3. git-gui currently supports 1.5.0=
 or
> above so rather than delete the old lines we can wrap them in a versi=
on
> check and use --exclude-standard if we have it.
>
> Also - I assume that the problem with core.excludesfile being set as =
you
> describe is that ~ is expanded by the shell. Here we are working in t=
cl
> which will take the literal string. Adding [file normalize] to the
> exclude value will expand the ~ to the users HOME path for us.
>
> The following should be cover everything and works for me:
>
>
> From 55e5893c08a52624846dbd9b61dcbccc6bbc5e12 Mon Sep 17 00:00:00 200=
1
> From: Stefan Naewe <stefan.naewe@googlemail.com>
> Date: Fri, 19 Nov 2010 19:28:25 +0000
> Subject: [PATCH] git-gui: use --exclude-standard to check for untrack=
ed files
>
> This fixes git-gui failing to display untracked files that are listed
> if core.excludefiles is set to ~/.gitexcludes
>
> [PT: added expansion of core.excludesfile value by tcl]
>
> Signed-off-by: Stefan Naewe <stefan.naewe@googlemail.com>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> ---
> =C2=A0git-gui.sh | =C2=A0 18 +++++++++++-------
> =C2=A01 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index d3acf0d..8c696c2 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1448,13 +1448,17 @@ proc rescan_stage2 {fd after} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close $fd
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 set ls_others [list --exclude-per-directory=3D=
=2Egitignore]
> - =C2=A0 =C2=A0 =C2=A0 if {[have_info_exclude]} {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lappend ls_others =
"--exclude-from=3D[gitdir info exclude]"
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 set user_exclude [get_config core.excludesfile=
]
> - =C2=A0 =C2=A0 =C2=A0 if {$user_exclude ne {} && [file readable $use=
r_exclude]} {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lappend ls_others =
"--exclude-from=3D$user_exclude"
> + =C2=A0 =C2=A0 =C2=A0 if {0 && [package vsatisfies $::_git_version 1=
=2E6.3]} {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set ls_others [lis=
t --exclude-standard]
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set ls_others [lis=
t --exclude-per-directory=3D.gitignore]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if {[have_info_exc=
lude]} {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 lappend ls_others "--exclude-from=3D[gitdir info exclude]"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set user_exclude [=
get_config core.excludesfile]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if {$user_exclude =
ne {} && [file readable $user_exclude]} {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 lappend ls_others "--exclude-from=3D[file normalize $user_exclu=
de]"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0set buf_rdi {}
> --
> 1.7.3.1.msysgit.0

Yes, works for me (on 1.7.3.2)

Thanks,
  Stefan
--=20
Stefan Naewe=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 stefan dot naewe at gmail dot com
Don't top-post=C2=A0 http://www.catb.org/~esr/jargon/html/T/top-post.ht=
ml
Plain text mails only, please=C2=A0 =C2=A0 =C2=A0 http://www.expita.com=
/nomime.html
