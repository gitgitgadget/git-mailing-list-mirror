From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sun, 06 Jan 2013 06:48:15 -0500
Message-ID: <50E9647F.4090209@gmail.com>
References: <2491041.bQ51Qu8HcA@thunderbird> <1890551.8jTmplCF6O@thunderbird> <BB541ECCD3F04E479F06CA491DDB598D@black> <50E92675.4010907@web.de> <20130106093211.GB10956@elie.Belkin> <50E946EB.1000709@web.de> <20130106095757.GC10956@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Stephen & Linda Smith <ischis2@cox.net>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	Eric Blake <eblake@redhat.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 12:54:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Troo7-0008FS-DQ
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 12:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313Ab3AFLyH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 06:54:07 -0500
Received: from mail-qc0-f175.google.com ([209.85.216.175]:39093 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab3AFLyG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 06:54:06 -0500
Received: by mail-qc0-f175.google.com with SMTP id j3so10654183qcs.6
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 03:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=l11s7A0hIjDqNMeVrO6r77/GNmL70LeuJzTm+X9xZXo=;
        b=uSHLbPyGu2EE0V3JYmyv84y1QXqwAdPqVlDrat8nkiubXI6o+IJSi1wkYBoDIZdVjB
         lOnL8MN3lp689Slzc/21yPCeLF9L5o+apLRV+OVjCyxczG03ddA0/14P4gRg7F5BKbWu
         GtugQQSSFHywtPC/7bPXN3MgiheMHsKLx3ne8PS401j2XU25G3kX4UqA2tv5sX/mWyt8
         w4nEi+pEXAX4XBcDlqQJXms72oSr3wTKBXN3IXHhA2QggfgyLC1lV+CCVXcZNyu8t/Wk
         I1/NJwv0RKduGk4aUfb01jb0H599koyMkfpIy5/0zKHgkhGvAUcaDTVAMpmcN56MA6+o
         cJ5g==
X-Received: by 10.224.213.69 with SMTP id gv5mr39168064qab.91.1357472897868;
        Sun, 06 Jan 2013 03:48:17 -0800 (PST)
Received: from mark-laptop.lan (pool-173-79-102-236.washdc.fios.verizon.net. [173.79.102.236])
        by mx.google.com with ESMTPS id j17sm18897367qad.9.2013.01.06.03.48.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Jan 2013 03:48:17 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20130106095757.GC10956@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212794>

On 01/06/2013 04:57 AM, Jonathan Nieder wrote:
> Torsten B=C3=B6gershausen wrote:
>
>> The short version:
>> Cygwin versions  1.7.1 up to 1.7.16 use the same header files as cyg=
win 1.5
> [...]
>> I don't know if we want to improve the Makefile to enable
>> CYGWIN_V15_WIN32API =3D YesPlease
>> for cygwin versions 1.7.1 .. 1.7.16 (which are outdated)
>>

You are conflating the cygwin dll version with the win32 api version.=20
These are independent packages (just as the kernel and glibc packages=20
are independent on linux) and do not share a version number. However,=20
the newer win32api is provided only for the current cygwin release=20
series, which can be reliably identified by having dll version 1.7.x,=20
while the older frozen releases (dll versions 1.6.x from redhat, 1.5.x=20
open source) still have the older api as no updates are being made for=20
the legacy version(s).

Cygwin does not version the win32api in any useful way: the package=20
names changed completely, for instance, and there is no macro defined=20
from the header files to indicate a version number. Also, there is no=20
supported way to now install the older version: the only supported=20
configuration is with the *current* win32api: multiple packages depend=20
by name on the current win32api package, so the installer will insist=20
upon its installation.

So the solution is to update the cygwin installation. Really. If you=20
don't believe me, try asking on the cygwin mailing list. They only=20
support the current releases, not obsolete packages, and the older=20
win32api is explicitly obsolete.

Mark
