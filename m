From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: t5801-remote-helpers.sh fails
Date: Sat, 10 Nov 2012 23:05:20 +0100
Message-ID: <CAMP44s2yenQKSgdUXfZP+yDJJ+bdveyms=SQ+3ptPvpT6D0hsg@mail.gmail.com>
References: <509E5B27.5080808@web.de>
	<CAMP44s0HtMRaQ91z95cZS73W7tnqYwyKV_2guWJ6u6UP4p5JNw@mail.gmail.com>
	<509EA8EE.1030908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Nov 10 23:05:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXJBY-0006sF-4l
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 23:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720Ab2KJWFV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 17:05:21 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:56752 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679Ab2KJWFV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 17:05:21 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5172957oag.19
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 14:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=xnq6vfBoGUUI0LqQZ1tAfNiLeuWV1xxMOFUjZRrELYc=;
        b=ZYH1I7jELG5jsu+Sxke+b/hLgnJI87vVuRqFAlCJumzpOQyqwMCKUVagOqnnm5ev/K
         8ClWMz0KoEPRNFI1yhCYEoFpocvZjDfTiYpfr1gvS+JjVV91JFtEB4zpNnU034Ag0hRe
         DlTXWS74odlDlQEWDkde3gGeslUi4SLXgvEQJMW2MlLV5bW0ZlVWuiwwwIknP/yAJvzZ
         KSZ33yUfMXKZ2KWYYYA3Pun7saXhDeLsutcp5TBqzjWA5CVNnMsstl2fQoclcmGibGyY
         WZmR2kFcGUlj2jXL60PqCiwmm/1olXak5jw1BQ5UZBNxcrocdNxN6vnXjYaCSp1Y8x3g
         gfFQ==
Received: by 10.60.32.19 with SMTP id e19mr11444878oei.9.1352585120161; Sat,
 10 Nov 2012 14:05:20 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sat, 10 Nov 2012 14:05:20 -0800 (PST)
In-Reply-To: <509EA8EE.1030908@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209309>

On Sat, Nov 10, 2012 at 8:20 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 11/10/2012 08:15 PM, Felipe Contreras wrote:
>>
>> Hi,
>>
>> On Sat, Nov 10, 2012 at 2:48 PM, Torsten B=C3=B6gershausen <tboegi@w=
eb.de>
>> wrote:
>>
>>> on peff/pu t5801 fails, the error is in git-remote-testgit, please =
see
>>> below.
>>>
>>> That's on my Mac OS X box.
>>>
>>> I haven't digged further into the test case, but it looks as if
>>> "[-+]A  make NAMEs associative arrays"
>>> is not supported on this version of bash.
>>> /Torsten
>>>
>>>
>>> /Users/tb/projects/git/git.peff/git-remote-testgit: line 64: declar=
e: -A:
>>> invalid option
>>> declare: usage: declare [-afFirtx] [-p] [name[=3Dvalue] ...]
>>> /Users/tb/projects/git/git.peff/git-remote-testgit: line 66:
>>> refs/heads/master: division by 0 (error token is "/master")
>>> error: fast-export died of signal 13
>>> fatal: Error while running fast-export
>>
>>
>> What is your bash --version?
>>
>  bash --version
> GNU bash, version 3.2.48(1)-release (x86_64-apple-darwin10.0)
> Copyright (C) 2007 Free Software Foundation, Inc.

I see, that version indeed doesn't have associative arrays.

> On the other hand, Documentation/CodingGuidelines says:
>   - No shell arrays.

Yeah, for shell code I guess, but this is bash code.

> Could we use perl to have arrays?

I think the code in perl would be harder to follow, and this is meant
not only as a test, but also as a reference.

I'm not exactly sure what we should do here:

a) remove the code (would not be so good as a reference)
b) enable the code conditionally based on the version of bash (harder t=
o read)
c) replace the code without associative arrays (will be much more
complicated and ugly)
d) add a check for the bash version to the top of the test in t/

I'm leaning towards d), followed by b).

If only there was a clean way to do this, so c) would not be so ugly.

After investigating different optins this seems to be the best:

	join -e empty -o '0 1.2 2.2' -a 2 <(echo "$before") <(echo "$after")
| while read e a b; do
		test "$a" =3D=3D "$b" && continue
		echo "changed $e"
	done

But to me seems a bit harder to grasp. Not sure.

Cheers.

--=20
=46elipe Contreras
