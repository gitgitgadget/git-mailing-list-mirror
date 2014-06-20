From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [msysGit] Re: The different EOL behavior between libgit2-based
 software and official Git
Date: Fri, 20 Jun 2014 12:33:16 +0200
Message-ID: <53A40DEC.4050902@web.de>
References: <1403146778624-7613670.post@n2.nabble.com>	<53A285A1.3090804@web.de>	<53A3DB01.7090904@web.de> <CAO_ghTLq-a3dJGXvmspaCYS19RhTJzT0teWO5XSfVSiRUN7rrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Yue Lin Ho <yuelinho777@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 20 12:33:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxw8K-0006lC-TC
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 12:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966344AbaFTKdU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jun 2014 06:33:20 -0400
Received: from mout.web.de ([212.227.15.14]:64108 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965650AbaFTKdT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 06:33:19 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MhDYL-1XKILE1sQr-00MPDB; Fri, 20 Jun 2014 12:33:17
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CAO_ghTLq-a3dJGXvmspaCYS19RhTJzT0teWO5XSfVSiRUN7rrQ@mail.gmail.com>
X-Provags-ID: V03:K0:4VoTHFo9lmgAnRfcOsErMDvrjkdyjdtU1KGeodzCKv9t9YhnuWW
 DKAf9iaFYVu/T/50AferqDC0E6OrBhisPmrJzPJhOKMS3oiiDNFEdrdMWiHe3RM6TB1yNXb
 36D1dwrBqyNDVk4SpxtJDycmwpg75A9jXWnEGD6IPk29tCLgkOTHW8Sl8r4gX2JQfib/R4m
 07uRFVBRb0ukMeXifPXcg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252223>


> =E2=80=8BWow!
>=20
> P.S.
> libgit2 just has a PR that try to be identical with official git.
> See https://github.com/libgit2/libgit2/pull/2432
>=20
> Yue Lin Ho=20
>=20

I am not sure how much problems Git/libgit2 have with files contains mi=
xed LF-CRLF,
as I have the same problem with the LF.txt

The handling, according to my understandig, is:
When core.eol is CRLF (or native under Windows) and core.autocrlf is tr=
ue, and a file
is checked out:
  If a file has CRLF in one line in the repo, nothing is changed.
  If a file has LF in one line in the repo, LF is converted into CRLF i=
n the workspace.

But here at my systems this doesn't seem to work as expected either for=
 LF.txt:

tb@mac:~/EOL_Test/TestAutoCrlf>  t=3DLF.txt  &&  rm -f $t &&  git -c co=
re.eol=3DCRLF checkout $t  && od -c  $t
0000000    L   i   n   e       1  \r  \n   l   i   n   e       (   2   =
)
0000020   \r  \n   l   i   n   e       3   .  \r  \n   t   h   i   s   =
=20
0000040    i   s       l   i   n   e       4  \r  \n   l       i       =
n
0000060        e       N   o   .       5  \r  \n   L   i   n   e       =
N
0000100    u   m   b   e   r       6  \r  \n  \r  \n                   =
=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
tb@Linux:~/EOL_Test/TestAutoCrlf$ t=3DLF.txt  &&  rm -f $t &&  git -c c=
ore.eol=3DCRLF checkout $t  && od -c  $t
0000000   L   i   n   e       1  \n   l   i   n   e       (   2   )  \n
0000020   l   i   n   e       3   .  \n   t   h   i   s       i   s   =20
0000040   l   i   n   e       4  \n   l       i       n       e       N
0000060   o   .       5  \n   L   i   n   e       N   u   m   b   e   r
0000100       6  \n  \n
