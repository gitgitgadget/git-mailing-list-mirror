From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [RFC] i18n.pathencoding
Date: Tue, 04 Sep 2012 21:51:24 +0200
Message-ID: <50465BBC.30203@web.de>
References: <201209010811.33994.tboegi@web.de> <CACsJy8A1GnhTeMzwXwA1C96pp0ERskxZC=SO+QE2__pfwmChow@mail.gmail.com> <7vvcftbt8o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZQ==?= =?UTF-8?B?cnNoYXVzZW4=?= 
	<tboegi@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 21:51:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8z9s-0001BQ-5O
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 21:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757745Ab2IDTv3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Sep 2012 15:51:29 -0400
Received: from mout.web.de ([212.227.15.4]:62585 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757689Ab2IDTv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 15:51:28 -0400
Received: from birne.lan ([195.67.191.22]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0LyDph-1Td2z20job-015OhP; Tue, 04 Sep 2012 21:51:25 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:15.0) Gecko/20120824 Thunderbird/15.0
In-Reply-To: <7vvcftbt8o.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:q0GQcOqZ2wlCAroO89BuJLMhrJ3a02byIigm32jdaTv
 zRT90mcE4r9bH1Tk/6bguUL+3TZ787vD177tklr5E71PMqFPIe
 UTLXU5Z1fLyauRmBfTrAey9eF3cLLpdRdGfx5hYO7qFR/eKPRf
 XgKHV8LbEQPH+NJ8r81RKTRTvRlJLid0W4e5U6ZAM6y3AliKlE
 IZXmVfeDZhSHiXTKG1LYA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204780>

On 04.09.12 19:19, Junio C Hamano wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>=20
>> On Sat, Sep 1, 2012 at 1:11 PM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>>> diff --git a/parse-options.c b/parse-options.c
>>> index c1c66bd..5840c18 100644
>>> --- a/parse-options.c
>>> +++ b/parse-options.c
>>> @@ -476,7 +476,7 @@ int parse_options(int argc, const char **argv, =
const char *prefix,
>>>                 usage_with_options(usagestr, options);
>>>         }
>>>
>>> -       precompose_argv(argc, argv);
>>> +       reencode_argv(argc, argv);
>>>         return parse_options_end(&ctx);
>>>  }
>>
>> If you have to re-encode command line arguments, what about paths
>> coming --stdin or a file?
>=20
> That problem is inherited from the MacOS precompose topic this one
> builds on.  Not that it is unimportant to fix, though.

Thanks for the comments,=20
(actually the precompose feature started as "fully" reencode,
and was downsized to only do the readdir() and argv[] conversion)

This leads to 2 questions:
a) Do we want the reencode feature in git, so that I continue to work o=
n it?
   From a performance point of view that would probably OK:
   The "git status" on a linux tree was slightly slower on my PC when m=
easured with time.
   From the user experience there was not a difference.
b) If yes,
   I have to admit that I don't use paths from --stdin or file so much,
   except "git am" or "git format-patch"
   Which commands are affected?
  =20
