From: Mathias Lafeldt <misfire@debugon.org>
Subject: Re: [PATCH] gitk: Take only numeric version components when computing
 $git_version
Date: Tue, 11 Jan 2011 14:46:38 +0100
Message-ID: <4D2C5F3E.2020007@debugon.org>
References: <4D231646.5080005@debugon.org> <1294360953.21006.2.camel@fixed-disk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Jan 11 14:47:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PceZg-0003LS-6y
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 14:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755824Ab1AKNro convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jan 2011 08:47:44 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:59462 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621Ab1AKNrn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 08:47:43 -0500
Received: from [172.20.2.23] (p54857A9C.dip.t-dialin.net [84.133.122.156])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MNvNj-1PfeIw1cEd-006vZd; Tue, 11 Jan 2011 14:46:45 +0100
User-Agent: Thunderbird 2.0.0.24 (X11/20101027)
In-Reply-To: <1294360953.21006.2.camel@fixed-disk>
X-Provags-ID: V02:K0:i8H9Kf649s+mz961SfBKz3HYjtpsp671vjpzB0JTbYb
 P3bwiI5aAbNt9x8mm6I5BHXof/FcupZNeLAmWCmJ4pjearqv0C
 6/cuZYOfkRoVscie67zGVHPdlSU+5I7H6seYiWm8qmBbMj9+5B
 80XMoCT31bXPyHcw7czrKU7MLa4cPtX3g3+ILiAZf2vT4sOG7B
 SI74xwWbarf7JG4rVKjDXHZ8wookAUDlcSc37XRM6U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164943>

Anders Kaseorg wrote:
> This fixes errors running with release candidate versions of Git:
>   Error in startup script: expected version number but got "1.7.4-rc0=
"
>=20
> Also, $git_version is no longer artificially limited to three
> components.  That limitation was added by commit
> 194bbf6cc8c2f3c14a920c841841d66b7667a848 to deal with msysGit version
> strings like =E2=80=9C1.6.4.msysgit.0=E2=80=9D, and we don=E2=80=99t =
need it now.  Hence as
> another side effect, this enables showing notes with git version
> 1.6.6.2 or 1.6.6.3, as originally intended by commit
> 7defefb134270b6e8ab3e422b343b41a4a383f5d.
>=20
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---
>  gitk-git/gitk |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index e82c6bf..9cbc09d 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -11581,7 +11581,7 @@ if {![info exists have_ttk]} {
>  set use_ttk [expr {$have_ttk && $want_ttk}]
>  set NS [expr {$use_ttk ? "ttk" : ""}]
> =20
> -set git_version [join [lrange [split [lindex [exec git version] end]=
 .] 0 2] .]
> +regexp {^git version ([\d.]*\d)} [exec git version] _ git_version
> =20
>  set show_notes {}
>  if {[package vcompare $git_version "1.6.6.2"] >=3D 0} {

Seems to work well.

However, an "Reported-by" would have been nice.

People don't seem to use gitk with the RC releases because nobody else
complains...

-Mathias
