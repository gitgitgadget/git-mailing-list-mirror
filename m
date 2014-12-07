From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: Accept-language test fails on Mac OS
Date: Sun, 7 Dec 2014 15:54:39 +0900
Message-ID: <CAFT+Tg_OQLj7oWfOJ8ATKHo36Jv3+JcSYWEc-trKsAtjv7wskg@mail.gmail.com>
References: <CAO2U3QgoSmYkDYbvFnChxPMrTCEboUbk1NWjv+9Us60EfozN_w@mail.gmail.com>
	<xmqqppbxogli.fsf@gitster.dls.corp.google.com>
	<CAO2U3QikrHRC0PncO2vxFMv88HMnJHYa1AiPak+Lp0OU1u6dZA@mail.gmail.com>
	<5482D180.9010002@web.de>
	<CAFT+Tg_4EJ15CmujDtcubfw+0rr2J=pbjccqSSs9tmj-rz6+eQ@mail.gmail.com>
	<54836F46.9080009@web.de>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Blume <blume.mike@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Dec 07 07:54:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxVk1-0004W2-P2
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 07:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbaLGGyn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Dec 2014 01:54:43 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:35023 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447AbaLGGyl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Dec 2014 01:54:41 -0500
Received: by mail-qg0-f51.google.com with SMTP id e89so1139592qgf.24
        for <git@vger.kernel.org>; Sat, 06 Dec 2014 22:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=8GeE+GmnMKu0MDjjSqdP3utKU0A4Q0t5aVQSu4IvN2U=;
        b=ZenX0nSTsMeGLo0cXD9EovMzuzKbpEx+tjs/VGaj4jRRE/cnktYEaTz6ZkXteqGqHA
         LU/X+T+/C320ayNGKO0KbBPJs0wZKNsppf2magBbJyS+8LqZauqY/4Km2Sf8m0V3A3WP
         gdFr8MMCXVZLdUES1wet6dr3pftTnDI8Vl8qhHmPbxa9JBaCqL5/K9YdGlemIza+xyTQ
         UGewVq+8KhmFY/5PAZnnbO9M6/tuvW+wVu/qHPg2PRRgMEsUDW+yeRrbhdv+MvYXgd0P
         5p5a3Q1MQYECWQ50lbwE1l7Ah2gpxD1PoehTjljD8aZWi6X03DqpUozEehhx9i7KMA63
         RO0Q==
X-Received: by 10.224.51.131 with SMTP id d3mr41619739qag.94.1417935279711;
 Sat, 06 Dec 2014 22:54:39 -0800 (PST)
Received: by 10.140.86.163 with HTTP; Sat, 6 Dec 2014 22:54:39 -0800 (PST)
In-Reply-To: <54836F46.9080009@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260973>

Thank you for providing useful information to fix the failures.

On Sun, Dec 7, 2014 at 6:04 AM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> On 2014-12-06 20.44, Yi, EungJun wrote:
>> Could you tell me your locale information from executing 'locale'
>> command and the verbose message you can get by accessing any git
>> repository via HTTP protocol? (e.g. GIT_CURL_VERBOSE=3D1 git clone
>> http://github.com/foo/bar )
> locale -a
> C
> C.UTF-8
> en_US.utf8
> icelandic
> is_IS
> is_IS.iso88591
> is_IS.utf8
> POSIX

I'm sorry for bothering you, but could you tell me the result of
"locale" command without "-a" option? What I want to know is locale
environment variables and its values, so I want to reproduce the test
failures on my laptop.

>
> -----------------------------
> After patching like this:
> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> index fc6e7fc..1e42b42 100755
> --- a/t/t5550-http-fetch-dumb.sh
> +++ b/t/t5550-http-fetch-dumb.sh
> @@ -205,8 +205,8 @@ check_language () {
>         LANG=3D$5 \
>         git ls-remote "$HTTPD_URL/dumb/repo.git" 2>&1 |
>         tr -d '\015' |
> -       sort -u >stderr &&
> -       grep -i ^Accept-Language: stderr >actual &&
> +       sort -u >stderr
> +       grep -i ^Accept-Language: stderr >actual
>         test_cmp expect actual
>  }
> -----------
> I get this:
>
>
> expecting success:
>         check_language "ko-KR, *;q=3D0.1" ko_KR.UTF-8 de_DE.UTF-8 ja_=
JP.UTF-8 en_US.UTF-8 &&
>         check_language "de-DE, *;q=3D0.1" ""          de_DE.UTF-8 ja_=
JP.UTF-8 en_US.UTF-8 &&
>         check_language "ja-JP, *;q=3D0.1" ""          ""          ja_=
JP.UTF-8 en_US.UTF-8 &&
>         check_language "en-US, *;q=3D0.1" ""          ""          "" =
         en_US.UTF-8
>
> --- expect      2014-12-06 21:00:59.000000000 +0000
> +++ actual      2014-12-06 21:00:59.000000000 +0000
> @@ -1 +0,0 @@
> -Accept-Language: de-DE, *;q=3D0.1
> not ok 25 - git client sends Accept-Language based on LANGUAGE, LC_AL=
L, LC_MESSAGES and LANG
> #
> #               check_language "ko-KR, *;q=3D0.1" ko_KR.UTF-8 de_DE.U=
TF-8 ja_JP.UTF-8 en_US.UTF-8 &&
> #               check_language "de-DE, *;q=3D0.1" ""          de_DE.U=
TF-8 ja_JP.UTF-8 en_US.UTF-8 &&
> #               check_language "ja-JP, *;q=3D0.1" ""          ""     =
     ja_JP.UTF-8 en_US.UTF-8 &&
> #               check_language "en-US, *;q=3D0.1" ""          ""     =
     ""          en_US.UTF-8
> #
>
>

The test seems to fail if LANGUAGE=3D"". I will dig it. Thanks.
