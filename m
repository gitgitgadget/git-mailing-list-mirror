From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2 21/22] mingw32: add uname()
Date: Sun, 09 Nov 2014 12:46:21 +0100
Message-ID: <545F540D.8010207@web.de>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com> <1415439595-469-1-git-send-email-pclouds@gmail.com> <1415439595-469-22-git-send-email-pclouds@gmail.com> <CAPig+cS2FzL6kXTvoG6cTX1yUjmGUkEm5mAHNxmtU5-=ngcoFg@mail.gmail.com> <CACsJy8CRzngC5U3VY9Bi1uRmdRfEWQWOCokRLLWNKRNUjyJrrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 12:46:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnQx2-0004a5-4Q
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 12:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbaKILqb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2014 06:46:31 -0500
Received: from mout.web.de ([212.227.15.4]:60172 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbaKILqa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 06:46:30 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MXHcb-1XYnyx3MLV-00WIul; Sun, 09 Nov 2014 12:46:26
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <CACsJy8CRzngC5U3VY9Bi1uRmdRfEWQWOCokRLLWNKRNUjyJrrw@mail.gmail.com>
X-Provags-ID: V03:K0:QQ94uBC2JevRwez7x02rRrOgA1ZhLmLrZ5bod3f9Njy6rm5lV+P
 r1F3eSIHMrABvqRcZzvP0N/TDSxZwRVfiytWKv1/cN3Kb7BUJhInxeZxxkTKXWn7F1UxaYp
 +yro/wmGC6Gq3Aw71xzzfhjQ5DN0fymrtsWpSxo56o7+i2GtvnFZu8quqvUo1JaAJD2n2DG
 ZF5UZs/tGJHhMv4oCR0mQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2014-11-09 09.36, Duy Nguyen wrote:
> On Sun, Nov 9, 2014 at 10:32 AM, Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>> On Sat, Nov 8, 2014 at 4:39 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> ---
>>> diff --git a/compat/mingw.c b/compat/mingw.c
>>> index c5c37e5..b817678 100644
>>> --- a/compat/mingw.c
>>> +++ b/compat/mingw.c
>>> @@ -2128,3 +2128,14 @@ void mingw_startup()
>>>         /* initialize Unicode console */
>>>         winansi_init();
>>>  }
>>> +
>>> +int uname(struct utsname *buf)
>>> +{
>>> +       DWORD v =3D GetVersion();
>>> +       memset(buf, 0, sizeof(*buf));
>>> +       sprintf(buf->sysname, "Windows");
>>
>> strcpy() maybe?
>=20
> It was originally strcpy, then I wanted to get fancy and show Win3.1,
> Win95... but it got complicated (couldn't just do it based on the las=
t
> bit of 'v'). Will revert.
>=20
Why not use strlcpy() ?
(This feels little like an overkill, but on the other hand it is safe t=
o use regardless
how long the buf is, and it is a good example how to avoid "overrunning=
" code)
