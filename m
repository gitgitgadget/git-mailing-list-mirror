From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] remote-helpers: build in platform independent directory
Date: Fri, 17 Sep 2010 18:31:53 +0200
Message-ID: <AANLkTimzM+HQ6mvrkCL2mKK9jfOKe0FA6rv=AOfgwJF_@mail.gmail.com>
References: <36e03068ded278b5145fdf82658c3270a25c2762.1284740217.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 18:32:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwdrP-00036Q-GG
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 18:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab0IQQcO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Sep 2010 12:32:14 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45710 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693Ab0IQQcN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Sep 2010 12:32:13 -0400
Received: by ywh1 with SMTP id 1so790453ywh.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 09:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=uYH/EUkKFgGPSNxB9EIxUm1e0C6aY2KUQhFnJKcirLg=;
        b=Vd/w7cVd4lI4cc3gknCaRdgYjO2Zo7Qtb8frf1uPrm+6gI7zvimIfXBFdR3P44ZtQx
         YFwpFblBGg22rR9FHeJ0RuwKanS//xusG0BAnFYCrOKLWAIODRk63+DPCjXOHEOaKrKN
         o8fudxvNwJdry+WweWe5GV3GhDKGx2oxZMe2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tUPRHAbo9E6FaepwV1VP+zHR3xFsKhmlDdaF+Z2dFrkobS1GWE9cdPtldcIy8ixeSv
         vWU6RZDTk5OkHGEpftJ727HysShAOQVVHykoLBFViEULi+q7JufAQWblouhffaoooQJn
         qAKJAEHAhxqq+sC1V0j98JQcChWRg8yz4aguA=
Received: by 10.150.215.21 with SMTP id n21mr1761200ybg.298.1284741133131;
 Fri, 17 Sep 2010 09:32:13 -0700 (PDT)
Received: by 10.151.82.3 with HTTP; Fri, 17 Sep 2010 09:31:53 -0700 (PDT)
In-Reply-To: <36e03068ded278b5145fdf82658c3270a25c2762.1284740217.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156396>

Heya,

[+Jonathan]

On Fri, Sep 17, 2010 at 18:17, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> The build directory which is used by distutils depends on the platfor=
m
> (e.g. build/lib on Fedora 13, build/lib.linux-i686-2.6 on Ubuntu 9.04=
).
> But test-lib.sh expects to find the build in build/lib which can caus=
e
> t5800-remote-helpers.sh to fail early.
>
> Override distutils' choice so that the build is always in build/lib.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> =C2=A0git_remote_helpers/Makefile | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git_remote_helpers/Makefile b/git_remote_helpers/Makefil=
e
> index 74b05dc..e8172d3 100644
> --- a/git_remote_helpers/Makefile
> +++ b/git_remote_helpers/Makefile
> @@ -26,7 +26,7 @@ PYLIBDIR=3D$(shell $(PYTHON_PATH) -c \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 print 'lib/python%i.%i/site-packages' % s=
ys.version_info[:2]")
>
> =C2=A0all: $(pysetupfile)
> - =C2=A0 =C2=A0 =C2=A0 $(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETS=
ETUP) build
> + =C2=A0 =C2=A0 =C2=A0 $(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETS=
ETUP) build --build-purelib=3Dbuild/lib --build-platlib=3Dbuild/lib
>
> =C2=A0install: $(pysetupfile)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(PYTHON_PATH) $(pysetupfile) install --pr=
efix $(DESTDIR_SQ)$(prefix)

I don't know if this works on all platforms etc, Jonathan?

--=20
Cheers,

Sverre Rabbelier
