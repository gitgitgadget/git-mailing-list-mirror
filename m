From: Patrick Sharp <jakanapes@gmail.com>
Subject: Re: [BUG] having 'plink' anywhere in the GIT_SSH environment variables sets putty = true
Date: Thu, 23 Apr 2015 08:15:39 -0500
Message-ID: <317B332E-CA9A-4B6B-A0C4-7202CBF5C1AA@gmail.com>
References: <2A6FFC1D-5479-4DCA-A5E5-FF92DE0AA552@gmail.com> <6c2a6b53e8e6e019b145dddc67a9d2ca@www.dscho.org> <F1AB6016-DA88-446C-84E9-1BD42436843D@gmail.com> <55387E31.5010100@web.de>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	sandals@crustytoothpaste.net, peff@peff.net,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	msysGit <msysgit@googlegroups.com>
To: =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 23 15:15:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlGyq-0005zG-L7
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 15:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965962AbbDWNPo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2015 09:15:44 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:36690 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933249AbbDWNPn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2015 09:15:43 -0400
Received: by yhrr66 with SMTP id r66so2374905yhr.3
        for <git@vger.kernel.org>; Thu, 23 Apr 2015 06:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MFLc5jq0VP3gXImvNK2gD8wgsBxGWwHhbsbBarbA+SQ=;
        b=ixwnbiBUUdcdOS6KJR38+ExELHFSFGSe3wfaeuYxuks/dZHNd0U/vNhoIvsnNc3mKT
         iIXF3F4YeXGojP1LqO6sddhxjl9oeSm5WDhYybvrKOms4DQp6ZX/4CcWCnyG1psTOej6
         i0zcDsO4/ft7Lfw6PhvYEQM3G+TCZAIxGDmyge0ReaRwAi+QDx0F/ZJAAVqD+89wz4Mg
         U6TycabyxTA8eenuzCNh2CT1Zdl9gpN0Gx9RrsJNyGI4r6Q9/q7lmkgkgPhCqC/jzjLx
         fTUnJadCu9iwvMXzRfk5xvlsiINCXOHbzl4iXrWAAbP00zAzSENUClJXA8QZolwEXtqi
         CffA==
X-Received: by 10.236.228.101 with SMTP id e95mr2185491yhq.33.1429794942630;
        Thu, 23 Apr 2015 06:15:42 -0700 (PDT)
Received: from [192.168.1.16] (pool-71-97-88-64.dfw.dsl-w.verizon.net. [71.97.88.64])
        by mx.google.com with ESMTPSA id f47sm6390532yho.52.2015.04.23.06.15.40
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 23 Apr 2015 06:15:41 -0700 (PDT)
In-Reply-To: <55387E31.5010100@web.de>
X-Mailer: Apple Mail (2.2098)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267690>

Torsten,

The relevant part of the path in GIT_SSH was =E2=80=98/uplink_deploy/=E2=
=80=98.

I did begin to use GIT_SSH_COMMAND as a workaround, but regardless this=
 still feels like an overly broad way to determine the value of the put=
ty flag.

I was kind of surprised to find it being inferred from the value of GIT=
_SSH instead of being explicitly set by some additional variable.  GIT_=
USE_PUTTY or some such, though I can understand there may be some reluc=
tance to put the onus of that on the end user.

Part of the issue stemmed from not being able to find any documentation=
 on this.  After I discovered what was happening I found plenty of inst=
ructions that indicated to enable putty support set GIT_SSH to /path/to=
/plink.exe, but I didn=E2=80=99t find it stated anywhere that if =E2=80=
=98plink=E2=80=99 was found in GIT_SSH, then git will add the -batch op=
tion to the command args.  In other words, I was able to find instructi=
ons on what to do if we had been using putty, but not instructions on u=
nexpected behavior if using GIT_SHH while NOT using putty.


> On Apr 23, 2015, at 12:08 AM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
>=20
> On 04/22/2015 09:12 PM, Patrick Sharp wrote:
>> Johannes,
>>=20
>> You=E2=80=99re correct, looking back over it, I was pretty vague.
>>=20
>> In truth, we are not using Windows OR putty at all.  Running git on =
an Ubuntu system, but we are setting the GIT_SSH environment variable t=
o point to a shell script to use.
>>=20
>> Upon attempting to run git ls-remote, the system was spitting out ge=
taddrinfo errors for =E2=80=98atch=E2=80=99 .
>>=20
>> Setting GIT_TRACE=3D2 showed that -batch was being added to the git =
command.
>>=20
>> This was seen on several different servers with git versions 1.8.5.2=
, 1.9.1 and 2.3.5
>>=20
>> After a bit we realized that it was the string =E2=80=98uplink=E2=80=
=99 in the GIT_SSH variable that was linked to the extra -batch flag.
>>=20
>> Finally, after searching the git source, we narrowed it down to the =
=E2=80=98plink=E2=80=99 portion of the string.
>>=20
>> https://github.com/git/git/blob/7c597ef345aed345576de616c51f27e6f4b3=
42b3/connect.c#L747-L7
> Brian, I got your patch,
> but can't see it in the list yet
> 1/2 looks good, thanks.
> (And add msygit)
>=20
> My feeling is that  patch 2/2 may break things for an unknown
> amount of users which e.g. use "myplink".
>=20
> Patrick,
> did you ever tell us, what you put into $GIT_SSH ?
>=20
> Can your use case be covered by using $GIT_SSH_COMMAND ?
>=20
>=20
>=20
>=20
>=20
