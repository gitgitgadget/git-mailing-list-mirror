From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH v2 0/3] Make the Git tests emit TAP format
Date: Tue, 15 Jun 2010 18:42:59 +0200
Message-ID: <4C17AD93.1020402@op5.se>
References: <1276096943-32671-1-git-send-email-avarab@gmail.com>	<m3631lp9oe.fsf@localhost.localdomain>	<AANLkTinHrf_ZuuoMXlL8BFqm3UhRYxrV4t2Nmp5QNjrE@mail.gmail.com> <AANLkTimxE0mqmitRzlXjSAO6v7IOEg4guUnRlzJUyIF1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 18:43:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOZEH-0005Kh-IT
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 18:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757834Ab0FOQnI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 12:43:08 -0400
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:53380 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757808Ab0FOQnH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jun 2010 12:43:07 -0400
Received: from source ([209.85.214.43]) by na3sys009aob111.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTBetlqjT1xLS6jmYpIwMwjRQRhJe5oVc@postini.com; Tue, 15 Jun 2010 09:43:06 PDT
Received: by bwz19 with SMTP id 19so3014922bwz.16
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 09:43:02 -0700 (PDT)
Received: by 10.204.175.8 with SMTP id v8mr5608910bkz.196.1276620182033;
        Tue, 15 Jun 2010 09:43:02 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id v3sm25161022bkz.10.2010.06.15.09.43.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Jun 2010 09:43:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4 ThunderGit/0.1a
In-Reply-To: <AANLkTimxE0mqmitRzlXjSAO6v7IOEg4guUnRlzJUyIF1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149205>

On 06/15/2010 05:17 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
> On Mon, Jun 14, 2010 at 22:10, =C6var Arnfj=F6r=F0 Bjarmason<avarab@g=
mail.com>  wrote:
>> On Mon, Jun 14, 2010 at 21:49, Jakub Narebski<jnareb@gmail.com>  wro=
te:
>>> =C6var Arnfj=F6r=F0 Bjarmason<avarab@gmail.com>  writes:
>>>
>>>> All this series does is slightly adjust the raw text output of our
>>>> tests so that it conforms. to the TAP standard, i.e. instead of th=
is:
>>>>
>>>>     $ ./t0005-signals.sh
>>>>     *   ok 1: sigchain works
>>>>     * passed all 1 test(s)
>>>>
>>>> We get this:
>>>>
>>>>     $ ./t0005-signals.sh
>>>>     ok 1 - sigchain works
>>>>     # passed all 1 test(s)
>>>>     1..1
>>>>
>>>> Changing the output format like this gives us the ability to run t=
he
>>>> Git tests with any TAP tool (like prove(1)) at no extra cost. Ever=
y
>>>> other existing way of running the tests continues to work, it's ju=
st
>>>> easier for machines to read the output now.
>>
>> I'll re-submit a version of the patch with a better commit message
>> which addresses all of the below.
>>
>>> This doesn't tell us if the result of running test suite with
>>> '--verbose' and/or with '--debug' changes, and if changes how?  Is =
it
>>> compatibile with TAP format so that TAP parsers understand it?
>>
>> It just changes in that the lines that previously said e.g. "*   ok =
1:
>> sigchain works" now say "ok 1 - sigchain works".
>>
>> TAP parsers still understand it, since ignoring unknown garbage is
>> part of the TAP standard.
>=20
> Actually it doesn't work for all the tests. The following crops up on
> prove -j 10 ./t[0-9]*.sh :: --verbose:
>=20
>      ./t1007-hash-object.sh                             (Wstat: 0
> Tests: 19 Failed: 0)
>        Parse errors: Tests out of sequence.  Found (12) but expected =
(11)
>                      Tests out of sequence.  Found (13) but expected =
(12)
>                      Tests out of sequence.  Found (14) but expected =
(13)
>                      Tests out of sequence.  Found (15) but expected =
(14)
>                      Tests out of sequence.  Found (16) but expected =
(15)


Why are you using a plan at all? I absolutely detest using planned tap
series, and last I heard was that the majority of TAP-fanatics actually
agreed that using a plan to run tests was an extraordinarily lousy idea=
,
since it makes it harder to add tests properly.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
