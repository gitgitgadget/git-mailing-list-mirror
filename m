From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Oct 2013, #07; Mon, 28)
Date: Wed, 30 Oct 2013 18:14:15 +0100
Message-ID: <52713E67.3000202@web.de>
References: <xmqqr4b5dwke.fsf@gitster.dls.corp.google.com> <5271392E.8020003@web.de> <CAFFjANT=-mQoKUU2KsPHo3Hcq7RAuyM1t4kvJu4OfiNeHrA+Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: =?UTF-8?B?VmljZW50IE1hcnTDrQ==?= <tanoku@gmail.com>,
	=?UTF-8?B?VG9yc3Q=?= =?UTF-8?B?ZW4gQsO2Z2Vyc2hhdXNlbg==?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 30 18:14:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbZLb-0005fO-LV
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 18:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555Ab3J3ROU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Oct 2013 13:14:20 -0400
Received: from mout.web.de ([212.227.15.14]:51722 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882Ab3J3ROT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 13:14:19 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MOAjQ-1VYFQq3hZ6-005bGV for <git@vger.kernel.org>;
 Wed, 30 Oct 2013 18:14:18 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CAFFjANT=-mQoKUU2KsPHo3Hcq7RAuyM1t4kvJu4OfiNeHrA+Ng@mail.gmail.com>
X-Provags-ID: V03:K0:/82yNovXwScm2Yk+JmHDNP0QGCN6RgvEn7jpDkW6BFlD/mMo7nk
 nBbgH9gmJyrfMClrRTgaq9wtkn1C2vD60eyp//vKQXQp4CHmAbbodWn104IxXWGC7CfgPNN
 yX/21LNL0l1KwD1nNd0GAeMRQj6v2XFGoUtsWLnD7cPZKMY4uksDhXGR5LzPVXxkL2qJxVc
 RHKM4QJ4jyzXHlB3OlMHw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237039>

On 2013-10-30 18.01, Vicent Mart=C3=AD wrote:
> On Wed, Oct 30, 2013 at 5:51 PM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>> There is a name clash under cygwin 1.7 (1.5 is OK)
>> The following "first aid hot fix" works for me:
>> /Torsten
>=20
> If Cygwin declares its own bswap_64, wouldn't it be better to use it
> instead of overwriting it with our own?
Yes,
this will be part of a longer patch.
I found that some systems have something like this:

#define htobe64(x) bswap_64(x)
And bswap_64 is a function, so we can not detect it by "asking"
#ifdef bswap_64
=2E.
#endif


But we can use
#ifdef htobe64
=2E..
#endif
and this will be part of a bigger patch.

And, in general, we should avoid to introduce functions which may have =
a
name clash.
Using the git_ prefix for function names is a good practice.
So in order to unbrake the compilation error under cygwin 17,
the "hotfix" can be used.
/Torsten
