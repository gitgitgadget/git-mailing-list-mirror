From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] relative_path should honor dos_drive_prefix
Date: Thu, 12 Sep 2013 19:22:01 +0200
Message-ID: <5231F839.3080208@kdbg.org>
References: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com> <0688d5a5bd194ff5808c555e8e75132e2c687368.1378977052.git.worldhello.net@gmail.com> <5231CBFA.3070806@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Tvangeste <i.4m.l33t@yandex.ru>,
	Karsten Blees <karsten.blees@gmail.com>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 12 19:23:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKAaz-0006iF-PG
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 19:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366Ab3ILRWI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Sep 2013 13:22:08 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:32034 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754130Ab3ILRWH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 13:22:07 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id ABBEEA7EC2;
	Thu, 12 Sep 2013 19:22:02 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2D89019F601;
	Thu, 12 Sep 2013 19:22:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <5231CBFA.3070806@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234661>

Am 12.09.2013 16:13, schrieb Torsten B=F6gershausen:
> On 2013-09-12 11.12, Jiang Xin wrote:
>> +static int have_same_root(const char *path1, const char *path2)
>> +{
>> +	int is_abs1, is_abs2;
>> +
>> +	is_abs1 =3D is_absolute_path(path1);
>> +	is_abs2 =3D is_absolute_path(path2);
>> +	return (is_abs1 && is_abs2 && !strncasecmp(path1, path2, 1)) ||
>                                        ^^^^^^^^^^^
> I wonder: should strncasecmp() be replaced with strncmp_icase() ?

I don't think so: On POSIX, it is irrelevant, because the call will onl=
y
compare a slash to a slash. On Windows, it compares the drive letters
(or a slash); it is *always* case-insensitive, even if the volume
mounted is NTFS with case-sensitivity enabled and core.ignorecase is fa=
lse.

> See dir.c:=20
> int strncmp_icase(const char *a, const char *b, size_t count)
> {
> 	return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count)=
;
> }

-- Hannes
