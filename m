From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] Documentation/remote-helpers: Add invocation and
 see also sections
Date: Mon, 29 Mar 2010 00:06:00 -0500
Message-ID: <20100329050600.GA9238@progeny.tock>
References: <f3271551003282104v384d2dc7qe0d3c092c01bc505@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 07:06:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw7BD-0005E5-Kq
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 07:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777Ab0C2FGI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 01:06:08 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:38361 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669Ab0C2FGG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 01:06:06 -0400
Received: by ywh36 with SMTP id 36so3150988ywh.4
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 22:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=frbEEocNXf/sxL35ZPtuxyKBZIYFE05x/wwxpInUMwA=;
        b=uxwVGwNZQlmW5JwslU4nPq0+A/j1Nhf5o2/pDNSLiFv3sJAnD8kY0LBkqlm/TIfPnP
         ITE7wHrSY1V9rATyPy0E1mLOIxSsHGVVhg5xgIBLA2W4ia7jahRBiJF6UeXfHOulXDNy
         XO2+eFreVpEwjd1GqIEAl1IA7yXFrGY3l935o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ep9xvNOcTZr/oxzGkvhrKiZBs3esGY9FfnlUn++zdC2o/2REQKJnb1fxEX3htw3tB7
         0PjTQLBtDjEHkCFvZ4jA08ouiHl8yAZPof6XI+q4XwTyAa9mHL/iylmah8atkQyBKBz7
         ARp6o2Dz9xGiLPoUITubOaI2+TOC4e2JaMQRs=
Received: by 10.101.146.3 with SMTP id y3mr7491051ann.133.1269839164148;
        Sun, 28 Mar 2010 22:06:04 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm3651509iwn.4.2010.03.28.22.06.02
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 28 Mar 2010 22:06:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f3271551003282104v384d2dc7qe0d3c092c01bc505@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143437>

Hi,

I know almost nothing about the transport machinery, so please take
anything I say with a grain of salt.

Ramkumar Ramachandra wrote:

> --- a/Documentation/git-remote-helpers.txt
> +++ b/Documentation/git-remote-helpers.txt
> @@ -38,6 +38,54 @@ Git comes with a "curl" family of remote helpers, =
specifically
>  'git-remote-ftps'. They implement the capabilities 'fetch', 'option'=
,
>  and 'push'.
>=20
> +INVOCATION
> +----------
> +
> +These programs can always be invoked as 'git remote-<transport>' by
> +the end user. However, the following are five situations in which
> +these programs are automatically invoked by git in decreasing order =
of
> +priority.

It took a moment for me to figure out what =E2=80=9Cdecreasing order of=
 priority=E2=80=9D
means here.  Maybe it would be clearer to make the cases mutually
exclusive so it is not needed.

That is:

 These programs can be used directly as =E2=80=98git remote-<transport>=
=E2=80=99 by
 users and third-party scripts.  However, in the more usual case,
 they will be used transparently by the transport machinery (i.e., by
 commands such as git ls-remote, git send-pack, and git archive --remot=
e).

 The =E2=80=9Cremote name=E2=80=9D and URL passed to the remote helper =
depend on how
 the repository is specified to git.

> +1. URL using <transport>::<string> syntax is used directly on comman=
d
> +   line.
> ++
> +The helper is invoked with <transport>::<string> as the first argume=
nt
> +and <string> as the second argument.

 <transport>::<address>
 ~~~~~~~~~~~~~~~~~~~~~~
 A URL of the form <transport>::<address> can be used to name a
 repository on the git command line, with <address> an arbitrary string=
=2E

 The 'git remote-<transport>' helper will be invoked with the full
 <transport>::<address> URL as the first argument and <address> as the
 second argument.
=20
> ++
> +<name> can only contain alphanumeric characters 0-9, A-Z and a-z.
> +
> +2. remote.<name>.url is unset, but remote.<name>.vcs is set to
> +   <transport>.
> ++
> +The helper is invoked with a single argument, <name>.
> +

 <nickname> with vcs set
 ~~~~~~~~~~~~~~~~~~~~~~~
 A remote nickname (see git-remote(1)) can be configured to use the
 =E2=80=98git remote-<transport>=E2=80=99 helper by setting the vcs var=
iable to
 <transport> in the [remote "<nickname>"] section of a configuration fi=
le.
 The url variable in such a section is optional and can be set to an
 arbitrary string <address>.

 If the url variable is set, the helper will be invoked with <nickname>
 as the first argument and <address> as the second argument.
 Otherwise, the helper will be invoked with a single argument, <nicknam=
e>.

> +4. remote.<name>.url is set to a value using the
> +   <transport>://<rest-of-URL> syntax.
> ++
> +The helper is invoked with <name> as the first argument and
> +<helper>://<rest-of-URL> as the second argument.
> ++
> +<transport> cannot be equal to any of builtin protocols 'rsync',
> +'file', 'git', 'ssh', 'git+ssh' and 'ssh+git'
> +

 <nickname> with vcs unset
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 If the [remote "<nickname>"] configuration does not include a vcs
 setting, a remote helper can be specified by a url setting with a
 value of the form "<transport>://<rest-of-URL>".

 The =E2=80=98git remote-<transport>=E2=80=99 helper will be invoked wi=
th
 the <nickname> as first argument and <transport>://<rest-of-URL>
 as the second argument.

 Exception: the built-in 'rsync', 'file', 'git', 'ssh', 'git+ssh',
 and 'ssh+git' transports are not handled using remote helpers.

> +5. URL using <transport>://<rest-of-URL> syntax is used directly on
> +   command line.
> ++
> +The helper is invoked with two arguments, both equal to
> +<transport>://<rest-of-URL>.
> ++
> +<transport> cannot be equal to any of builtin protocols 'rsync',
> +'file', 'git', 'ssh', 'git+ssh' and 'ssh+git'
> +

 <transport>://<rest-of-URL>
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 A URL of the form <transport>://<rest-of-URL> can be used to name a
 repository on the git command line, with <rest-of-URL> an arbitrary
 string.

 If 'transport' is not one of the built-in protocols listed above,
 the 'git remote-<transport>' helper will be invoked with two
 arguments, both equal to the full <transport>://<rest-of-URL>
 URL.

>  COMMANDS
>  --------
>=20
> @@ -206,6 +254,10 @@ OPTIONS
>  	must not rely on this option being set before
>  	connect request occurs.
>=20
> +SEE ALSO
> +--------
> +linkgit:git-config[1]

linkgit:git-remote[1], too.

HTH,
Jonathan
