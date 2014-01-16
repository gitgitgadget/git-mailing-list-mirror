From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Potential bug: truncated diff output
Date: Thu, 16 Jan 2014 07:55:00 +0100
Message-ID: <52D78244.7020406@viscovery.net>
References: <CAAyYaWo7wtsVGGxUeE3wwG6UHZ_qc8wcPu4Dk6=DsF8JtyF6_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Misha Penkov <misha.penkov@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 16 07:55:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3gr8-0007ku-Rp
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 07:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbaAPGzH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jan 2014 01:55:07 -0500
Received: from so.liwest.at ([212.33.55.18]:50873 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976AbaAPGzF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 01:55:05 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1W3gqz-0002Sn-HF; Thu, 16 Jan 2014 07:55:01 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1E6D116613;
	Thu, 16 Jan 2014 07:55:00 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CAAyYaWo7wtsVGGxUeE3wwG6UHZ_qc8wcPu4Dk6=DsF8JtyF6_w@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240507>

Am 1/16/2014 7:19, schrieb Misha Penkov:
> I have a file in a git repo. It has changed during the last two
> commits. I want to see the changes made in these two commits. The
> following command should work:
>=20
>     git diff HEAD^^
>=20
> but that doesn't get me the expected results. Read on for details.
>=20
> Last commit: I changed some stuff towards the end of the file, for
> example, around line 3145. Here's the full diff (it's here for
> reference, don't bother reading all of it):
>=20
>     $git diff HEAD^ HEAD ieicej.cls
>     diff --git a/ieicej.cls b/ieicej.cls
>     index ecf8beb..01debd9 100644
>     ...
>     @@ -3145,11 +3145,11 @@
>        \kern 2.715\p@}
>=20
>      \def\@makefnmark{\hbox{$^{\mbox{\tiny \kern-.5zw
>     -  =EF=BC=88=E6=B3=A8\kern.1zw\@thefnmark{}=EF=BC=89\kern-.5zw}}$=
}}
>     +  =EF=BC=88\kern.1zw\@thefnmark{}=EF=BC=89\kern-.5zw}}$}}
>=20
>      \newcommand\@makefntext[1]{\parindent1zw
>       \noindent\hbox{\kern-.5zw
>     -  =EF=BC=88=E6=B3=A8\kern.1zw\@thefnmark{}=EF=BC=89\kern-.5zw\hb=
ox to 1zw{\hss =EF=BC=9A\hss}}#1}
>     +  =EF=BC=88\kern.1zw\@thefnmark{}=EF=BC=89\kern-.5zw\hbox to 1zw=
{\hss =EF=BC=9A\hss}}#1}
>=20
>      \def\thefootnote{\@arabic\c@footnote}
>      \def\thempfootnote{\@fnsymbol\c@mpfootnote}

Here, you revert the change...

> Here's the second-last commit. I changed some things around line 1714=
=2E
> Full commit diff (again, for reference only):
>=20
>     $git diff -p HEAD^^ HEAD^ ieicej.cls
>     diff --git a/ieicej.cls b/ieicej.cls
>     index 1c3b947..ecf8beb 100644
>     ...
>     @@ -3135,11 +3145,11 @@
>        \kern 2.715\p@}
>=20
>      \def\@makefnmark{\hbox{$^{\mbox{\tiny \kern-.5zw
>     -  =EF=BC=88\kern.1zw\@thefnmark{}=EF=BC=89\kern-.5zw}}$}}
>     +  =EF=BC=88=E6=B3=A8\kern.1zw\@thefnmark{}=EF=BC=89\kern-.5zw}}$=
}}
>=20
>      \newcommand\@makefntext[1]{\parindent1zw
>       \noindent\hbox{\kern-.5zw
>     -  =EF=BC=88\kern.1zw\@thefnmark{}=EF=BC=89\kern-.5zw\hbox to 1zw=
{\hss =EF=BC=9A\hss}}#1}
>     +  =EF=BC=88=E6=B3=A8\kern.1zw\@thefnmark{}=EF=BC=89\kern-.5zw\hb=
ox to 1zw{\hss =EF=BC=9A\hss}}#1}
>=20
>      \def\thefootnote{\@arabic\c@footnote}
>      \def\thempfootnote{\@fnsymbol\c@mpfootnote}

=2E.. that you made here.

Unsurprisingly, the net effect is no change in that area -- and git dif=
f
tells you exactly that.

-- Hannes
