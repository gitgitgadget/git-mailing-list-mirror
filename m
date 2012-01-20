From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] i18n: disable i18n for shell scripts if NO_GETTEXT defined
Date: Fri, 20 Jan 2012 20:45:37 +0100
Message-ID: <CALxABCYSH4KOtss96dtu8tw0SQd4yFuCaX+XajAY4Fbrdez+7Q@mail.gmail.com>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
 <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
 <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
 <7vfwfclf4v.fsf@alter.siamese.dyndns.org> <4F17C294.6010004@viscovery.net>
 <7vhazrk0jx.fsf@alter.siamese.dyndns.org> <CACBZZX7iiF2um11FvD+MBz=rZb7RrHtCJp3PqexLnSp3-Cbqug@mail.gmail.com>
 <CALxABCZWBtgX736Acoy-CCAz8RJb0EKnHf+7g72dOdVS+BOhSw@mail.gmail.com> <7vsjjadv5g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 20:46:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoKPr-0005CZ-CS
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 20:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192Ab2ATTqK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jan 2012 14:46:10 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:47571 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755597Ab2ATTp6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 14:45:58 -0500
Received: by obcva7 with SMTP id va7so1102530obc.19
        for <git@vger.kernel.org>; Fri, 20 Jan 2012 11:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=SIObwCRIS+dfgMRAewhkvPvOcLbNIm5T05FY4r1b5rI=;
        b=HNWxPd/0tF6ebLjl0VfTNfdC1F1ZsAtkoB/z9/yvVdKcP5VLoZ50I/5xVvu7n6ukYK
         nReP1FRROS5up4s39oLu0OCTDB5SzwyPN3iq+nN2CqsQM4bw1ply4p7eb6yU8tpTjtkW
         DvEB5hGFgq5nSyYKt7SpWVmuVRGdX/EI5quoo=
Received: by 10.182.117.8 with SMTP id ka8mr27753225obb.73.1327088758215; Fri,
 20 Jan 2012 11:45:58 -0800 (PST)
Received: by 10.182.226.41 with HTTP; Fri, 20 Jan 2012 11:45:37 -0800 (PST)
In-Reply-To: <7vsjjadv5g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188897>

On Fri, Jan 20, 2012 at 20:35, Junio C Hamano <gitster@pobox.com> wrote=
:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>>> And then a --version for whatever programs that function uses,
>>> e.g. here:
>>>
>>> =C2=A0 =C2=A0$ envsubst --version
>>
>> Nothing. Exit code 127.
>
> Interesting.
>
> =C2=A0 =C2=A0$ wonbsubst --version; echo $?
> =C2=A0 =C2=A0bash: wonbsubst: command not found
> =C2=A0 =C2=A0127
>
> Perhaps your distro lacks a necessary package dependencies between ge=
ttext
> and envsubst?
>
>> I believe gettext (the binary) just doesn't start at all here. Maybe
>> some Cygwin library wrong or missing library. Happens all the time
>> here,...
>
> Aha.
>
> I guess we either leave it broken for broken installation or add an e=
xtra
> "MY_GETTEXT_IS_BROKEN" option; in either way, it does not sound like =
a
> serious enough issue that is widespread to be urgently fixed during t=
he
> feature freeze.

=C3=86var already posted a very cute little fix for this, which looks
pretty minimal and is very obvious.

P.S. Sorry for html mail before (tried to use the Android Gmail client)=
=2E
