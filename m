From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC PATCH] Makefile: new prove target for running the tests
 with TAP
Date: Thu, 14 Oct 2010 11:21:27 +0200
Message-ID: <4CB6CB97.7040009@drmicha.warpmail.net>
References: <5c46df95f93b56aa2fce56c7efe7b2be80642c8b.1287045908.git.git@drmicha.warpmail.net> <AANLkTimuoanpbFbyv9C8qUbut22me1gMhH02eLqg0Nyd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 11:21:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6K0J-0000ZV-UU
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 11:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980Ab0JNJVL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 05:21:11 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60944 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754826Ab0JNJVK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 05:21:10 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 64BD566F;
	Thu, 14 Oct 2010 05:21:10 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 14 Oct 2010 05:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=4d6JQ7gyV1bM3f9EyHO5sV+joMs=; b=XepDBeCO0NH9BDr920tYOECWI4eEWJdDrsy08HO2xA3NKBL17xA9pSnbt5zjDgjHAitmabedrjTPnHktmB5jrz4fYT0a3XPiXiLBajI3igHkLznaASnljuK1YwxPpYmjwHO7QvaJ04d/6ZKvFQ+c+1+OSr+SGk0St8WDifSTVPQ=
X-Sasl-enc: 82+kXAqz3Tw9Mna2A4lJEjGzhUTKW3QLoIzUNfxNQDTu 1287048070
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C56915E5634;
	Thu, 14 Oct 2010 05:21:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <AANLkTimuoanpbFbyv9C8qUbut22me1gMhH02eLqg0Nyd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159034>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 14.10.2010 1=
1:05:
> On Thu, Oct 14, 2010 at 08:53, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Introduce a new make target "prove" which runs the tests via "prove"=
 (or
>> $(PROVE) if set) so that one does not have to cd around any more. On=
e
>> can simply use "make prove" for "make test" or go wild as in:
>>
>> GIT_SKIP_TESTS=3D't[0-4]??? t91?? t9200.8' GIT_PROVE_OPTS=3D"-j9 -v"=
 GIT_TEST_OPTS=3D"--verbose --debug" make prove
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> RFC also because of lack of doc, and:
>>
>> Currently, one can do
>>
>> make -C t t6010-merge-base.sh
>>
>> or even
>>
>> make -C t t601*
>>
>> which is cool but undocumented. If we want this with prove it requir=
es more
>> effort, or shoving prove into the $(T) target rule which is doable, =
of course.
>> I'm just wondering whether it's accepted to introduce a specific rul=
e for prove
>> at all.
>=20
> I like the rationale behind this, but fwiw. I already had a patch tha=
t
> was ejected for this:
>=20
>     http://article.gmane.org/gmane.comp.version-control.git/146566
>=20
> Quoth Junio:
>=20
>     "Besides, "make -j15 test" from the toplevel already runs the
>     tests in parallel.  I don't see much point in this change."
>=20

Sorry for the kind of dupe then. Though I can understand that the fixed
options back then didn't find Junio's approval. Maybe it's different
now, when it's completely interchangeable with make test?

> But I'd like to have it so that I could `make && make test_harness`
> and get readable test output.
>=20
> But we should probably be using t/harness to run them, not
> prove(1). Then we would make the test_harness target respect the
> HARNESS_OPTIONS variable, which I e.g. have set to HARNESS_OPTIONS=3D=
j9
> on my system.

Didn't know about that one either. What does t/harness
differently/better from/than prove? Does it take the same options? Is
t/harness respecting the SHELL_PATH for the tests? Running a test under
make test and make prove/harness needs to be completely equivalent.

Michael
