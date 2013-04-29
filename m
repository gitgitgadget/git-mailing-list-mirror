From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 6/6] sparse: Fix mingw_main() argument number/type errors
Date: Mon, 29 Apr 2013 18:10:48 +0200
Message-ID: <517E9B88.1040807@lsrfire.ath.cx>
References: <517C24D3.8080802@ramsay1.demon.co.uk> <517C6DEF.2050305@lsrfire.ath.cx> <7v38uaqwow.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 18:11:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWqfM-0003RS-LL
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 18:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756984Ab3D2QK4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Apr 2013 12:10:56 -0400
Received: from india601.server4you.de ([85.25.151.105]:49462 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756865Ab3D2QKz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 12:10:55 -0400
Received: from [192.168.2.105] (p579BE67F.dip0.t-ipconnect.de [87.155.230.127])
	by india601.server4you.de (Postfix) with ESMTPSA id ADDC8209;
	Mon, 29 Apr 2013 18:10:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7v38uaqwow.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222805>

Am 28.04.2013 21:31, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>
>> Why not take the opposite direction with a patch like this?
>> ...
>> diff --git a/compat/mingw.h b/compat/mingw.h
>> index 389ae01..74e7b87 100644
>> --- a/compat/mingw.h
>> +++ b/compat/mingw.h
>> @@ -452,11 +452,11 @@ int xwcstoutf(char *utf, const wchar_t *wcs, s=
ize_t utflen);
>>
>>   void mingw_startup();
>>   #define main(c,v) dummy_decl_mingw_main(); \
>> -static int mingw_main(); \
>> +static int mingw_main(int, const char **); \
>>   int main(int argc, const char **argv) \
>
> But traditionally main is declared like
>
> 	int main(int argc, char *argv[]);
>
> without const, no?

Yes, http://c-faq.com/ansi/maindecl.html and basically everybody else=20
agree.  Now that I actually think about it, the only benefit of=20
declaring argv constant I can find is that the const'ness could easily=20
spread to other variables and function arguments where it may actually=20
matter.  So please ignore my interjection.  Or perhaps it might be wort=
h=20
mentioning in the commit message that removal of that "const" improves=20
the code's standard compliance.

Ren=C3=A9
