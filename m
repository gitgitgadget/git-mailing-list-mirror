From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH 1/3] git-instaweb: Fix custom apache log placement
Date: Thu, 22 Jul 2010 13:01:02 -0500
Message-ID: <AANLkTiknXtteX77h8Uy1JuWmGLWSSRkAGkS3INMOHBoJ@mail.gmail.com>
References: <1277865900-25044-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 22 20:01:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc05J-0003QL-Qj
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 20:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759208Ab0GVSBI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jul 2010 14:01:08 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59048 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759242Ab0GVSBF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jul 2010 14:01:05 -0400
Received: by wwj40 with SMTP id 40so3741215wwj.1
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 11:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5jh74oob9GXcTUS6mpXhe0XZ074lTYKCvrp+viA/Yb4=;
        b=rymRva1zlSp3TKtCDMOM86pdYrsPM5O41g/8dTiHGFrSkkpngyAp3yRWiDtCqunhaJ
         06CdSJ82R4HXBOHRnLRZRKKhtI+jeqW760yjFrbJYghJsKiSKFbtVwssJdplzBqz5ZZ2
         LZpdda5nitcSwSzYdw6GPC0662BGS6HrNFyWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C8Kq3HaI/gGWqvWAW+omBFBdmsrCtyGuzFI5O41N5T6AvsLOWNKjJUsHl7K5euQYcJ
         ud3BJQikXd3792D5lQfRHgd3v3Jb0hbh13ypv2G4+GJG+5aqAi0CGQkEl6xDjyK0P6iP
         AZg1MJtM4tG9syIQXAxKh8LzcuBOPsMVR2xa8=
Received: by 10.216.185.72 with SMTP id t50mr2231839wem.77.1279821662880; Thu, 
	22 Jul 2010 11:01:02 -0700 (PDT)
Received: by 10.216.177.209 with HTTP; Thu, 22 Jul 2010 11:01:02 -0700 (PDT)
In-Reply-To: <1277865900-25044-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151465>

On Tue, Jun 29, 2010 at 9:44 PM, Dan McGee <dpmcgee@gmail.com> wrote:
> 'CustomLog' is provided by mod_log_config so we need to include the m=
odule
> in our generated config. This was added in d94775e1f9a.
>
> Signed-off-by: Dan McGee <dpmcgee@gmail.com>

I noticed this set of patches didn't go anywhere...at least the first
two were more bug fixes than improvements so I would have expected
them to get into 1.7.2. Did they get lost in the shuffle?

1: http://marc.info/?l=3Dgit&m=3D127786592330110&w=3D2
2: http://marc.info/?l=3Dgit&m=3D127786592030105&w=3D2
3: http://marc.info/?l=3Dgit&m=3D127791591706076&w=3D2

-Dan

> ---
> =C2=A0git-instaweb.sh | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index 6635fbe..a01476a 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -314,7 +314,7 @@ PidFile "$fqgitdir/pid"
> =C2=A0Listen $bind$port
> =C2=A0EOF
>
> - =C2=A0 =C2=A0 =C2=A0 for mod in mime dir; do
> + =C2=A0 =C2=A0 =C2=A0 for mod in mime dir log_config; do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test -e $mo=
dule_path/mod_${mod}.so; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0echo "LoadModule ${mod}_module " \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "$module_path/mod_${mod}.so" >> "$conf"
> --
> 1.7.1
>
>
