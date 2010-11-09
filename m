From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH 1/5] gettext: fix bug in git-sh-i18n's eval_gettext()
 by using envsubst(1)
Date: Tue, 09 Nov 2010 10:47:23 +0100
Message-ID: <4CD918AB.6060206@viscovery.net>
References: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>	<1288524860-538-2-git-send-email-avarab@gmail.com>	<4CCFCCC8.7080603@viscovery.net>	<AANLkTimjRwSxkemMffASvHCxK009b1fnvNRs05_T_1DF@mail.gmail.com>	<4CD8F965.6050402@viscovery.net> <AANLkTinKYJtaDjwEk0OqebBnL6+wvVO4wfWg7G-VYh7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 10:47:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFkne-0003V1-96
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 10:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000Ab0KIJr3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 04:47:29 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:65259 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753779Ab0KIJr2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 04:47:28 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PFknU-0005Es-Bh; Tue, 09 Nov 2010 10:47:24 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1A6891660F;
	Tue,  9 Nov 2010 10:47:24 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <AANLkTinKYJtaDjwEk0OqebBnL6+wvVO4wfWg7G-VYh7d@mail.gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161027>

Am 11/9/2010 10:35, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> On Tue, Nov 9, 2010 at 08:33, Johannes Sixt <j.sixt@viscovery.net> wr=
ote:
>> Am 11/8/2010 23:39, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>     eval_gettext () {
>>>       gettext "$1" | (export PATH `envsubst --variables "$1"`; envs=
ubst "$1")
>>>     }
>>
>> So, for every message printed, you have at least 3 fork()s (usually =
even
>> more)! I'm not happy about that. You *must* avoid this at least for
>> NO_GETTEXT builds, but if you can reduce them even for no-NO_GETTEXT
>> builds, it would be great.
>=20
> Why is that a "*must*"?
=2E..
> But maybe you have reason to think otherwise? I haven't noticed any
> noticable slowdowns from doing it this way, but maybe I've been
> looking at the wrong thing.

You didn't do your timings in Windows, did you? Every fork() that you c=
an
avoid is a win.

-- Hannes
