From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v4 00/12] Wildmatch v4
Date: Fri, 12 Oct 2012 18:44:15 +0200
Message-ID: <507848DF.6060301@web.de>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com> <7vd30panxo.fsf@alter.siamese.dyndns.org> <7v1uh5aar7.fsf@alter.siamese.dyndns.org> <CACsJy8B2JJmUbjAauMwbg95fCvPdUYqy4CKZp3ac44XHoh1NLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 18:44:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMiLt-000687-Gt
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 18:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759924Ab2JLQo3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Oct 2012 12:44:29 -0400
Received: from mout.web.de ([212.227.15.4]:50123 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759822Ab2JLQo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 12:44:27 -0400
Received: from birne.lan ([195.67.191.22]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0LxOQ2-1TPZqP3C3e-016N6F; Fri, 12 Oct 2012 18:44:18 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <CACsJy8B2JJmUbjAauMwbg95fCvPdUYqy4CKZp3ac44XHoh1NLQ@mail.gmail.com>
X-Provags-ID: V02:K0:sAC5XEIkFgFuk8KcHKtvYWuT4EXTudKVwMY3Y2rARFx
 Nrcy9gp2mZx5kSYdrP4ehVOeCjIHOhYuRyslkzBAwlLsomnmA1
 iSSfIfyYGwYsSlQy69SofaivGApomJWoltUMpm2FMkklPaiIcv
 WodTIN6Zq5S9GQuzuqvFPC6z9ztwjSd9L+v0v5Ewk/uesJ+fIC
 Z4Igw3MKp0+J/Mwd3KbVg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207554>

On 11.10.12 13:56, Nguyen Thai Ngoc Duy wrote:
> On Thu, Oct 11, 2012 at 11:33 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writ=
es:
>>>
>>>> Really small updates. I did not want to resend it this soon but th=
is
>>>> may fix the compile errors for Junio.
>>
>> t3070 seems to break TAP,
>>
>>     *** prove ***
>>     t3070-wildmatch.sh .. Failed 1/151 subtests
>>
>>     Test Summary Report
>>     -------------------
>>     t3070-wildmatch.sh (Wstat: 0 Tests: 150 Failed: 0)
>>       Parse errors: Tests out of sequence.  Found (76) but expected =
(75)
>>                     Tests out of sequence.  Found (77) but expected =
(76)
>>                     Tests out of sequence.  Found (78) but expected =
(77)
>>                     Tests out of sequence.  Found (79) but expected =
(78)
>>                     Tests out of sequence.  Found (80) but expected =
(79)
>>     Displayed the first 5 of 77 TAP syntax errors.
>>
>> This probably is due to this part of the output:
>>
>>     ok 72 - wildmatch 1 1 [ab] [\[:]ab]
>>     ok 73 - wildmatch 1 1 ?a?b \??\?b
>>     ok 74 - wildmatch 1 1 abc ^G^Hok 75 - wildmatch 0 0 foo
>>     ok 76 - wildmatch 1 0 foo/bar/baz/to **/t[o]
>>     ok 77 - wildmatch 1 1 a1B [[:alpha:]][[:digit:]][[:upper:]]
>>
>=20
> It seems to prove fine here with perl 5.12.3, Test-Harness-3.230,
> bash-4.0_p38. What version do you use?
>=20
Some problems even here (Mac OS) commit 2aeb6d4d7884f4c4425

not ok 61 - wildmatch 0 0 \ \
not ok 62 - wildmatch 0 0 /\ */\
not ok 69 - wildmatch 1 1 [ab] [[:]ab]
not ok 71 - wildmatch 1 1 [ab] [[:digit]ab]
not ok 80 - wildmatch 1 0 1 [[:digit:][:upper:][:space:]]
not ok 81 - wildmatch 0 0 1 [[:digit:][:upper:][:spaci:]]
not ok 88 - wildmatch 1 0 _ [[:alnum:][:alpha:][:blank:][:cntrl:][:digi=
t:][:graph:][:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]
not ok 89 - wildmatch 1 0 _ [[:alnum:][:alpha:][:blank:][:cntrl:][:digi=
t:][:graph:][:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]
not ok 93 - wildmatch 1 1 y [a-c[:digit:]x-z]

I have 2 perls, I'm not sure which versin is used by git these days.

 which perl
/opt/local/bin/perl
tb@birne:~/projects/git/git.pu/t> perl --version

This is perl, v5.8.9 built for darwin-2level

----------------
/usr/bin/perl --version

This is perl, v5.10.0 built for darwin-thread-multi-2level
(with 2 registered patches, see perl -V for more detail)
----------

If I can do more debugging/testing please let me know
/Torsten
