From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t/README: clarify test_must_fail description
Date: Tue, 20 Jul 2010 16:12:35 -0500
Message-ID: <8HvhdiflWJtex2eC6n_6Q38YcvRRYhnh0scnq4s56M4wdwT_YlAiOw@cipher.nrlssc.navy.mil>
References: <20100720163822.GA8492@localhost.localdomain> <0JXkybOAPrkw1RCkgKLY0ocfkmfqHFq_bWFMVWrzymAet2VX-veTSoZP1hBzIyN5JSrPw-IZjfI@cipher.nrlssc.navy.mil> <7veieym3sh.fsf@alter.siamese.dyndns.org> <AANLkTinLOLzmA9XSDYKsKwxV1Byvp-hd82JbjuSTNWb3@mail.gmail.com> <7v1vaym27n.fsf@alter.siamese.dyndns.org> <AANLkTil5eq2radUKvle7Ez48CDRfb8dvWcEobXzGaKNA@mail.gmail.com> <20100720191655.GA1705@burratino> <AANLkTimjTxbw0FCujPNbkzuFAbdXZBgWMmDTQeAegvNq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, jaredhance@gmail.com,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 23:13:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObK7i-0002zq-Tu
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 23:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669Ab0GTVNG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 17:13:06 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41080 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932356Ab0GTVND (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 17:13:03 -0400
Received: by mail.nrlssc.navy.mil id o6KLCaqA011454; Tue, 20 Jul 2010 16:12:36 -0500
In-Reply-To: <AANLkTimjTxbw0FCujPNbkzuFAbdXZBgWMmDTQeAegvNq@mail.gmail.com>
X-OriginalArrivalTime: 20 Jul 2010 21:12:36.0091 (UTC) FILETIME=[46D2DCB0:01CB2850]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151367>

On 07/20/2010 03:49 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, Jul 20, 2010 at 19:16, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason wrote:
>>
>>> That's what we seem to be doing in the tests so far, i.e. test_must=
_fail
>>> is reserved for git commands only.
>> test_must_fail relies on conventions for return value that cannot
>> necessarily be relied on from outside utilities.
>=20
> Right, someone should send a patch for these:
>=20
>     ack 'test_must_fail (?!git)' *sh
>=20
> :)

You joke, but thanks to your prodding, I discovered these broken
tests that should definitely all be fixed:

   $ perl -ne 'm/test_must_fail +[^ ]+=3D/ && print' *sh

        test_must_fail PAGER=3D git reflog show delta &&
        test_must_fail PAGER=3D git reflog show epsilon &&
        test_must_fail PAGER=3D git reflog show epsilon
        test_must_fail PAGER=3D git reflog show zeta &&
        test_must_fail PAGER=3D git reflog show eta &&
        test_must_fail PAGER=3D git reflog show eta
        test_must_fail PAGER=3D git reflog show beta
        test_must_fail MSG=3D"yet another note" git notes add -c deadbe=
ef &&

one-shot variable assignment does not work with test_must_fail.

See e2007832552ccea9befed9003580c494f09e666e for an explanation.

-brandon
