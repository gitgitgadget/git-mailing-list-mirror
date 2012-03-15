From: John Szakmeister <john@szakmeister.net>
Subject: Re: [GUILT] [PATCH] Fix fatal "guilt graph" error in sha1sum invocation.
Date: Thu, 15 Mar 2012 05:56:58 -0400
Message-ID: <CAEBDL5XHZ-ca+wX91GrYu5T_rZ76pyrtPuzjWtVRtXg-MWSygQ@mail.gmail.com>
References: <87399bpaq9.fsf@opera.com>
	<m2k42nmf5g.fsf@igel.home>
	<4F61AB63.5040304@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Jeff Sipek <jeffpc@josefsipek.net>, git@vger.kernel.org,
	ceder@lysator.liu.se
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 10:57:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S87Ql-0008VY-Mp
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 10:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761029Ab2COJ5A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Mar 2012 05:57:00 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55576 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760599Ab2COJ47 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Mar 2012 05:56:59 -0400
Received: by iagz16 with SMTP id z16so3675289iag.19
        for <git@vger.kernel.org>; Thu, 15 Mar 2012 02:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cLzdFZEi+WAAiTf15EM4aoclSW1tv4Ic47xTKniZcMI=;
        b=VK6rAx/Y9FVeCSfhV+z+73jL11Zr5Q+VkCHRh284WRWMyLQHfAInFAdAXCvT21dsZI
         v/AyjBgNJDx03UxIW/My/wGct3NB/JpPkug9DmLea6+3yITlwY44er/TdwdgFcE419Un
         Ta+ZaMIw17O8XspIYsYxKkowSLaAgphvLYNmhDB9vYwcd3r/ORe1EfOFIOTEwxl3OiLu
         jfmbDrB73XBk7+AwoVhLq5sbQag7RK4D7efaqxAxR/bc3Wx9gLGDz5LjubIDDQ9L0eCE
         3p1Tm27120oiTfy/+yUjH2u05mtvEVzwA+KY+c/D0cpd6+8mMGa7AdFn8CNAaAXOegCs
         DNBQ==
Received: by 10.50.100.202 with SMTP id fa10mr8756961igb.10.1331805418986;
 Thu, 15 Mar 2012 02:56:58 -0700 (PDT)
Received: by 10.50.132.68 with HTTP; Thu, 15 Mar 2012 02:56:58 -0700 (PDT)
In-Reply-To: <4F61AB63.5040304@opera.com>
X-Google-Sender-Auth: auh7QdPo4pehFcxN9RXheWPKs-g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193206>

On Thu, Mar 15, 2012 at 4:42 AM, Per Cederqvist <cederp@opera.com> wrot=
e:
> On 03/14/2012 03:27 PM, Andreas Schwab wrote:
>
>> Per Cederqvist<cederp@opera.com> =C2=A0writes:
>>
>>> - =C2=A0 =C2=A0 =C2=A0 openssl dgst -sha1 "$1" | sed "s,SHA1.\(.*\)=
=2E=3D \(.*\),\2 =C2=A0\1,"
>>> + =C2=A0 =C2=A0 =C2=A0 if [ $# =3D 1 ]
>>> + =C2=A0 =C2=A0 =C2=A0 then
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 openssl dgst -sh=
a1 "$1" | sed "s,SHA1.\(.*\).=3D \(.*\),\2
>>> =C2=A0\1,"
>>> + =C2=A0 =C2=A0 =C2=A0 else
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 openssl dgst -sh=
a1 | sed 's,$, =C2=A0-,'
>>
>>
>> $ openssl dgst -sha1</dev/null
>> (stdin)=3D da39a3ee5e6b4b0d3255bfef95601890afd80709
>
>
> Was that on a Darwin?

Here's the output from my Mac (running Snow Leopard):

$ openssl dgst -sha1</dev/null
(stdin)=3D da39a3ee5e6b4b0d3255bfef95601890afd80709
$ openssl version
OpenSSL 1.0.0d 8 Feb 2011

-John
