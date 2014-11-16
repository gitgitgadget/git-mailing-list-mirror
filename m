From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] create_default_files(): don't set u+x bit on $GIT_DIR/config
Date: Sun, 16 Nov 2014 06:23:57 +0100
Message-ID: <546834ED.6050403@alum.mit.edu>
References: <1416036379-4994-1-git-send-email-mhagger@alum.mit.edu> <1416036379-4994-2-git-send-email-mhagger@alum.mit.edu> <546741AC.9030107@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>, git@vger.kernel.org
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 06:25:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpsKn-0007Pf-IN
	for gcvg-git-2@plane.gmane.org; Sun, 16 Nov 2014 06:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbaKPFYO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Nov 2014 00:24:14 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:61405 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750825AbaKPFYN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Nov 2014 00:24:13 -0500
X-AuditID: 1207440c-f798a6d000000bdc-83-546834f0ff0a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id D6.6F.03036.0F438645; Sun, 16 Nov 2014 00:24:00 -0500 (EST)
Received: from [192.168.69.130] (p4FC97A4A.dip0.t-ipconnect.de [79.201.122.74])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAG5NwoV030557
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 16 Nov 2014 00:23:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <546741AC.9030107@web.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqPvBJCPEoGe1pUXXlW4mi4beK8wW
	C/8dZbfY35Rk0dnxldGB1WPnrLvsHhcvKXt83iTncfvZNhaP5innWQNYo7htkhJLyoIz0/P0
	7RK4Mxr2dbEXfOSt+HrvG1sDYx93FyMnh4SAicScn7/ZIWwxiQv31rN1MXJxCAlcZpRovrCH
	EcI5zySxuu0VE0gVr4C2xJ/3Z1hBbBYBVYljx56xgdhsAroSi3qawWpEBYIkTu65zg5RLyhx
	cuYTFhBbRCBL4tunL2C9zAI5Eg8+fgCrERYIlbg6cyPUsqmMEscXHwcbxCmgJtH+5D0zRIOe
	xI7rv6Ca5SWat85mnsAoMAvJjllIymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdQ
	LzezRC81pXQTIyTIeXYwflsnc4hRgINRiYf3wqS0ECHWxLLiytxDjJIcTEqivAJn00OE+JLy
	UyozEosz4otKc1KLDzFKcDArifBG62WECPGmJFZWpRblw6SkOViUxHlVl6j7CQmkJ5akZqem
	FqQWwWRlODiUJHgXGQM1ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIOiNb4YGK8g
	KR6gvZImIHuLCxJzgaIQracYFaXEeX+CzBUASWSU5sGNhaWuV4ziQF8K8z4DqeIBpj247ldA
	g5mABjMeSwUZXJKIkJJqYJRbVylgv/RmtOHnH/skXtuIWOZ5MwlU39Pb+MHIKGFX9mvOKU9v
	u9U0bFvW0mn4jfEYd0LtkzVXFQUmtPJ+Z7jjq1J0of2SBq9/f+r9y8x69YskT4hJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/15/2014 01:06 PM, Torsten B=F6gershausen wrote:
> On 2014-11-15 08.26, Michael Haggerty wrote:
> The whole thing looks good to me, some minor comments below
>> git_config_set() copies the permissions from the old config file to
>> the new one. This is a good change in and of itself, but it interact=
s
>> badly with create_default_files()'s sloppiness, causing "git init" t=
o
>> leave the executable bit set on $GIT_DIR/config.
>>
>> So change create_default_files() to reset the permissions on
> s/permissions/executable bit/ ?
>> $GIT_DIR/config after its test.

The code literally resets all of the permissions to their values before
the test, so I think the existing text is more accurate (even though
your version would have been fine, too).

>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  builtin/init-db.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/builtin/init-db.c b/builtin/init-db.c
>> index 56f85e2..95ca5e4 100644
>> --- a/builtin/init-db.c
>> +++ b/builtin/init-db.c
>> @@ -255,6 +255,7 @@ static int create_default_files(const char *temp=
late_path)
>>  		filemode =3D (!chmod(path, st1.st_mode ^ S_IXUSR) &&
>>  				!lstat(path, &st2) &&
>>  				st1.st_mode !=3D st2.st_mode);
>> +		chmod(path, st1.st_mode);
> A "blind" chmod() is good, but I think checking the return code is be=
tter.
>=20
>                 filemode &=3D (!chmod(path, st1.st_mode));

I guess it is better to include this test, even though it is mostly
redundant with what was already determined by the previous line. I
suppose the only alternative would be to

    die("Your chmod() support is bonkers")

I will change this in v2.

Thanks for your comments!

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
