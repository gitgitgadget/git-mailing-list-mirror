From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 1/3] remote-helpers: fix the run of all tests
Date: Wed, 03 Apr 2013 07:53:41 +0200
Message-ID: <515BC3E5.2020501@web.de>
References: <1364850872-21135-1-git-send-email-felipe.contreras@gmail.com> <1364850872-21135-2-git-send-email-felipe.contreras@gmail.com> <CALWbr2wAqudzbfiSHmD1uAVQX3mtbf5vgr2JXbXEg7yzaKXJcw@mail.gmail.com> <20130401234016.GC30935@sigill.intra.peff.net> <515B0D08.4020405@web.de> <20130402173652.GC24698@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>, sunshine@sunshineco.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 03 07:54:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNGeF-0000KE-PP
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 07:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762452Ab3DCFxr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Apr 2013 01:53:47 -0400
Received: from mout.web.de ([212.227.17.11]:64173 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760718Ab3DCFxq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 01:53:46 -0400
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0Lpw63-1UsDk923N9-00f1Dk; Wed, 03 Apr 2013 07:53:43 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <20130402173652.GC24698@sigill.intra.peff.net>
X-Provags-ID: V02:K0:9RhH+1dIYsjbxwuogXc28Vzo9pN0XvEBnynaR1h3zSA
 emts/f6HH0EvOjNue8lSU64G/hSr5JZ5RMDgcvaNAdXlTb//5y
 HxRc0U8t5kJeBHwwJPsdQ4RZffVTTvMRjne8NVeI93hTbMAtz9
 sMQOItJgp5yKkgwkdkPMwSVRMVS5V6pL/9JoWG/EZEBNSNEYnM
 8F4QCzjXcx2WEk2dGoL6w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219917>

On 02.04.13 19:36, Jeff King wrote:
> On Tue, Apr 02, 2013 at 06:53:28PM +0200, Torsten B=C3=B6gershausen w=
rote:
>=20
>>> I think the check for duplicate-numbers is the only one that does n=
ot
>>> make sense.=20
>> []
>> Not sure about that, I send a suggestion of a patch in a minute.
>> Highlights:
>> 1) - rename the contrib test cases and assigns real TC numbers
>> 2) - Forward the numbers into the main "test Makefile"
>=20
> I'm not sure if this is a good idea or not. It puts the
> contrib/remote-helpers into the same "number namespace" as the rest o=
f
> the test scripts, and enforces uniqueness with test-lint-duplicates,
> when "make test" is run from contrib/remote-helpers. But people worki=
ng
> on the main test scripts would not get any such check, and would happ=
ily
> break contrib/remote-helpers by adding duplicate test numbers.
>=20
> It makes sense to me to either:
>=20
>   1. Have the contrib/remote-helpers test live in their own test
>      namespace completely, with their own numbers and test-results, a=
nd
>      pull in relevant bits from the main test harness. We do this
>      already with contrib/subtree.  I suggested this when the tests
>      first appeared, but there was some argument, and I don't remembe=
r
>      the details.
>=20
>   2. Just integrate contrib test scripts into the main repository, bu=
t
>      leave them off by default. For example, add:
>=20
>        if test -z "$GIT_TEST_REMOTE_HELPERS"; then
>               skip_all=3D"Remote helper tests disabled (define GIT_TE=
ST_REMOTE_HELPERS)"
>               test_done
>        fi
>=20
>      to the top of the scripts, and then set GIT_TEST_REMOTE_HELPERS
>      in contrib/remote-helpers/Makefile before chaining to the test
>      Makefile.
>=20
> -Peff

I think I do my homework, and start with 3), just check duplicates on n=
umbered
test cases.

http://comments.gmane.org/gmane.comp.version-control.git/214194
I send a patch in a minute (thanks Eric for reading)
