From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Makefile: don't include git version file on 'make clean'
Date: Sat, 24 Jul 2010 12:36:01 +0000
Message-ID: <AANLkTilYXdVI_fqG5ZvPEABTXt7fTps3ZbPiiWgVnDxS@mail.gmail.com>
References: <1279943627-11053-1-git-send-email-Lynn.Lin@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Lynn.Lin@emc.com
X-From: git-owner@vger.kernel.org Sat Jul 24 14:36:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocdxm-0005N3-HC
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 14:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755578Ab0GXMgF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 08:36:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40491 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755444Ab0GXMgD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jul 2010 08:36:03 -0400
Received: by iwn7 with SMTP id 7so1139190iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 05:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=S3THN2vFMc0AJLluefepEHuo2NqpRtwvlRISs7v3Nec=;
        b=sLWYphPEuQBS0Fb/BhfXM9Dz99O/bXq2ltSCRiVB326AUNvL5n3yVTh6yrr9fqaXxH
         7EnKoMrUlbb919e3l72sSAjKQz5w1+hMMU0WPJKlx0dfcaYOuaAZnKnhWpyKZcpu6dqw
         WxAN/wVaz7RFynhj5zvV49T/9yuOGpDTQ2hhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mf1M6lmTlzKLoe/61nbJKKx9RddVvRuC4sHX8TEvw+NfeEsl5DzroQawZh0CkjrXat
         nKpRbNZImXwlFDYgc+Jluebaz2kkCx2S6GcX+rfoGc2bSCHli2GHMEbYu/GZeWXK3Lel
         tErGTbJjjSyDk3krDt1jiNCw1zo5yxi94iKo0=
Received: by 10.231.146.196 with SMTP id i4mr4842649ibv.110.1279974961306; 
	Sat, 24 Jul 2010 05:36:01 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sat, 24 Jul 2010 05:36:01 -0700 (PDT)
In-Reply-To: <1279943627-11053-1-git-send-email-Lynn.Lin@emc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151626>

On Sat, Jul 24, 2010 at 03:53,  <Lynn.Lin@emc.com> wrote:
> From: Lynn Lin <Lynn.Lin@emc.com>
>
> ---
> =C2=A0Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A04 +++-
> =C2=A0git-gui/Makefile | =C2=A0 =C2=A04 +++-
> =C2=A02 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index bc3c570..eb28b98 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -238,7 +238,9 @@ all::
>
> =C2=A0GIT-VERSION-FILE: FORCE
> =C2=A0 =C2=A0 =C2=A0 =C2=A0@$(SHELL_PATH) ./GIT-VERSION-GEN
> --include GIT-VERSION-FILE
> +ifneq "$(MAKECMDGOALS)" "clean"
> + =C2=A0-include GIT-VERSION-FILE
> +endif
>
> =C2=A0uname_S :=3D $(shell sh -c 'uname -s 2>/dev/null || echo not')
> =C2=A0uname_M :=3D $(shell sh -c 'uname -m 2>/dev/null || echo not')
> diff --git a/git-gui/Makefile b/git-gui/Makefile
> index 197b55e..91e1ea5 100644
> --- a/git-gui/Makefile
> +++ b/git-gui/Makefile
> @@ -9,7 +9,9 @@ all::
>
> =C2=A0GIT-VERSION-FILE: FORCE
> =C2=A0 =C2=A0 =C2=A0 =C2=A0@$(SHELL_PATH) ./GIT-VERSION-GEN
> --include GIT-VERSION-FILE
> +ifneq "$(MAKECMDGOALS)" "clean"
> + =C2=A0-include GIT-VERSION-FILE
> +endif
>
> =C2=A0uname_S :=3D $(shell sh -c 'uname -s 2>/dev/null || echo not')
> =C2=A0uname_O :=3D $(shell sh -c 'uname -o 2>/dev/null || echo not')
> --
> 1.7.1

This patch needs a rationale, why was it needed? The "-include"
directive will simply ignore files that don't exist (as opposed to
"include"), so including GIT-VERSION-FILE during "make clean'
shouldn't be an issue.

Was it for you? And if so what version of make, what OS etc.
