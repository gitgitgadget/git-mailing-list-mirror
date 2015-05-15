From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2] mergetools: add winmerge as a builtin tool
Date: Fri, 15 May 2015 07:46:23 +0200
Message-ID: <CAHGBnuN-sw8Q_boB2SSNKTQP6M4jifiketFWJ23bknAdCVw_Uw@mail.gmail.com>
References: <5553B61D.7050204@gmail.com>
	<1431640110-8484-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, Phil Susi <phillsusi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri May 15 07:46:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt8S5-000663-8A
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 07:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbbEOFqZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2015 01:46:25 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:32930 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbbEOFqY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2015 01:46:24 -0400
Received: by iebgx4 with SMTP id gx4so92374892ieb.0
        for <git@vger.kernel.org>; Thu, 14 May 2015 22:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=O4K9BVunEJDu/+pTkHrvje1s8sJcAdsLuOLhaeiAtmg=;
        b=l/is24VCTmompz8GZqY30u3K/Y8eMiGcKGiwYimF8ZB5b8kf5MqiF7fH1dWnuNOnRQ
         fjO0xdzETHotJPuerBFIzR2k2JxmoUlFctb2F7uihv4rG67W3ss9YbNllLn4mVoHAG0g
         t5QV2Ct5I6NQPUDwQsQILU3GATYhMGfKOfEWA0o1Xlcln4mbqWESktc7UoR2pVkMszc2
         PWZ9Xbn2oaYqCngaCcFogtOTqeChVbJZbHRBArzQfixsVQftax2yqR1LvM1cBnZFN2Ii
         VHCpCcxQuPnPQJrOphI97S4o0PBONVRe+rWM1ws5xXIjdzlV5UhSo4j66fcbKXZPTlFb
         +n0w==
X-Received: by 10.50.30.9 with SMTP id o9mr22507174igh.23.1431668783688; Thu,
 14 May 2015 22:46:23 -0700 (PDT)
Received: by 10.107.29.149 with HTTP; Thu, 14 May 2015 22:46:23 -0700 (PDT)
In-Reply-To: <1431640110-8484-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269126>

On Thu, May 14, 2015 at 11:48 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:

>> for directory in "$(env | grep -E '^PROGRAM(FILES(\(X86\))?|W6432)=3D=
' | cut -d '=3D' -f 2 | sort -u)"
>> do
>>      test -n "$directory" &&
>>      test -x "$directory/$winmerge_exe" &&
>>      echo "$directory/$winmerge_exe" &&
>>      break
>> done
>
> This ain't gonna work, because the output of the pipe won't be split
> because of the quotes around the command substitution, so $directory =
will
> hold everything.  Simply loosing those quotes is not good either, bec=
ause

That's what I thought at first, too, but simply trying it out proved
me wrong (again, in both MSYS1/2):

$ for d in "$(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=3D' | cut
-d '=3D' -f 2- | sort -u)"; do echo "$d"; done
C:\Program Files
C:\Program Files (x86)

Note that the path, although they are containing spaces, are on separat=
e lines.

--=20
Sebastian Schuberth
