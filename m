From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [BUG] having 'plink' anywhere in the GIT_SSH environment variables
 sets putty = true
Date: Thu, 23 Apr 2015 07:08:01 +0200
Message-ID: <55387E31.5010100@web.de>
References: <2A6FFC1D-5479-4DCA-A5E5-FF92DE0AA552@gmail.com> <6c2a6b53e8e6e019b145dddc67a9d2ca@www.dscho.org> <F1AB6016-DA88-446C-84E9-1BD42436843D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	sandals@crustytoothpaste.net, peff@peff.net,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	msysGit <msysgit@googlegroups.com>
To: Patrick Sharp <jakanapes@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 23 07:09:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl9OF-0006tX-3R
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 07:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbbDWFJU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2015 01:09:20 -0400
Received: from mout.web.de ([212.227.17.12]:58697 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbbDWFJT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 01:09:19 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Leca2-1Z6fcM15iA-00qQ1Q; Thu, 23 Apr 2015 07:09:04
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <F1AB6016-DA88-446C-84E9-1BD42436843D@gmail.com>
X-Provags-ID: V03:K0:o4eXXKBf1X3Li8ykZUNCLaiwnB/HH3sNadAzOXm8RV3G/wpwWoz
 sTFU9TGX7QP6AjW058OHaICvPY9NmnJWlf8yevgtYdHTgorvN1yNSbZCfCYsxcjW0n9dFSR
 CbhQ3m8aVHWsxviTDOu3XojaD8q+QmiaEEV6f0EIiUCTPtWudlIkyyNTlgKTJJLkSuSW349
 1IlEL1FH5uIVoJS+S8uRA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267675>

On 04/22/2015 09:12 PM, Patrick Sharp wrote:
> Johannes,
>
> You=E2=80=99re correct, looking back over it, I was pretty vague.
>
> In truth, we are not using Windows OR putty at all.  Running git on a=
n Ubuntu system, but we are setting the GIT_SSH environment variable to=
 point to a shell script to use.
>
> Upon attempting to run git ls-remote, the system was spitting out get=
addrinfo errors for =E2=80=98atch=E2=80=99 .
>
> Setting GIT_TRACE=3D2 showed that -batch was being added to the git c=
ommand.
>
> This was seen on several different servers with git versions 1.8.5.2,=
 1.9.1 and 2.3.5
>
> After a bit we realized that it was the string =E2=80=98uplink=E2=80=99=
 in the GIT_SSH variable that was linked to the extra -batch flag.
>
> Finally, after searching the git source, we narrowed it down to the =E2=
=80=98plink=E2=80=99 portion of the string.
>
> https://github.com/git/git/blob/7c597ef345aed345576de616c51f27e6f4b34=
2b3/connect.c#L747-L7
Brian, I got your patch,
but can't see it in the list yet
  1/2 looks good, thanks.
(And add msygit)

My feeling is that  patch 2/2 may break things for an unknown
amount of users which e.g. use "myplink".

Patrick,
did you ever tell us, what you put into $GIT_SSH ?

Can your use case be covered by using $GIT_SSH_COMMAND ?
