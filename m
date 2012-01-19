From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] i18n: disable i18n for shell scripts if NO_GETTEXT defined
Date: Thu, 19 Jan 2012 08:13:24 +0100
Message-ID: <4F17C294.6010004@viscovery.net>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com> <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com> <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com> <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com> <7vfwfclf4v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 08:13:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnmBj-0007TS-Rn
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 08:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384Ab2ASHNb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jan 2012 02:13:31 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:48489 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750709Ab2ASHNa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2012 02:13:30 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RnmBZ-0003hx-H3; Thu, 19 Jan 2012 08:13:25 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 25C6E1660F;
	Thu, 19 Jan 2012 08:13:25 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <7vfwfclf4v.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188791>

Am 1/19/2012 1:17, schrieb Junio C Hamano:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>=20
>> On Wed, Jan 18, 2012 at 19:57, Alex Riesen <raa.lkml@gmail.com> wrot=
e:
>> ...
>>> Well, if I say NO_GETTEXT, I kind of want none of local gettext,
>>> whether it works, or not.
>>
>> That's not what NO_GETTEXT means, and not what it *should* mean. It
>> means that your output won't be translated, but we might still make
>> use of a locally installed library to provide the gettext() and
>> eval_gettext() functions.
>=20
> You are right.

Sorry to disagree: We have, e.g., NO_MMAP, and I can set it to request
that some alternative is used, even if I have a working mmap(). The opt=
ion
name "NO_GETTEXT" is in exactly the same spirit.

> In the current approach we take for shell scripts, we cannot have "No=
 i18n
> whatsoever and messages are emit with printf and echo". We always hav=
e to
> go through gettext/eval_gettext even though they may be an implementa=
tion
> that does not do i18n at all.

Just like we go through _() in C code, even though there may be an
implementation that does not do i18n at all, right?

gettext/eval_gettext annotations are the shell equivalent of _()
annotations in C code, aren't they? Neither go away just by defining
NO_GETTEXT. It is just a quality-of-implementation issue that those
annotations have as little overhead as possible if NO_GETTEXT is define=
d.
In C, it is easy, in shell code it may be more involved.

-- Hannes
