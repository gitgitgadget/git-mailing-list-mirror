From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] i18n: disable i18n for shell scripts if NO_GETTEXT defined
Date: Thu, 19 Jan 2012 10:13:20 +0100
Message-ID: <CALxABCbaBmP6k5TYrYLCYm8oiv=9cF=N7_opSTKUnbkz5b-cwg@mail.gmail.com>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
 <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com> <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 10:14:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rno4J-0004KO-Gb
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 10:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977Ab2ASJOA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jan 2012 04:14:00 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:59719 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755701Ab2ASJNl convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 04:13:41 -0500
Received: by obcva7 with SMTP id va7so8393449obc.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 01:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=kfVHM+ZqmQuqi8RpUXATBRl9+nz9gCzpKq9g4DS4Kdw=;
        b=Sunk5o0rHbP6SuKNz6OmR2Ag7sX9N6C89dRezXx14F99q+wrMh5rQokekWPFFol7hn
         BeN6Wr46Hdsm4to4UfN2JRAnZ40NOEUHRq2bMbd6t5259TYJi9jsVKIuB/t9sf5P41f/
         NM9gBlwx2oYxztzs95z7ac3QWflF4dt8OII0E=
Received: by 10.182.38.70 with SMTP id e6mr3133874obk.13.1326964421173; Thu,
 19 Jan 2012 01:13:41 -0800 (PST)
Received: by 10.182.226.41 with HTTP; Thu, 19 Jan 2012 01:13:20 -0800 (PST)
In-Reply-To: <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188796>

On Thu, Jan 19, 2012 at 00:18, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> On Wed, Jan 18, 2012 at 19:57, Alex Riesen <raa.lkml@gmail.com> wrote=
:
>>
>> Well, if I say NO_GETTEXT, I kind of want none of local gettext,
>> whether it works, or not.
>
> That's not what NO_GETTEXT means, and not what it *should* mean. It
> means that your output won't be translated, but we might still make
> use of a locally installed library to provide the gettext() and
> eval_gettext() functions.

I would never guess all that by its name: NO_GETTEXT. I wanted to
say: there is no gettext in this installation, don't even try it.

> This approach has worked everywhere so far (Linux, OSX, *BSD etc.),
> and you want to change *everywhere* because you have some completely
> broken Cygwin install.

Just as I said.

> How did you even get that install? Is it a known issue? Some ancient
> now-fixed bug?

It is very likely. Or probably just a one installation problem: the
problem is not consistently everywhere here. Some installations
work (if slow).

> What version of Cygwin / gettext etc.

No idea. The person or persons who did this to me have no idea either.

> Now I'm not saying that we shouldn't fix this, I just don't think tha=
t
> this is the right way to go about it.

And I agree.

> But in summary: We shouldn't be *always* using fallback functions
> whether they're the C stuff in compat/* or the gettext fallbacks in
> git-sh-i18n.sh just because there's some version out there of the
> system-supplied functions that's broken.
>
> It makes sense to prefer the system functions by default in both
> cases, but when the OS one can be broken or lacking we can just add
> probes or Makefile options like we do for fnmatch() with the
> NO_FNMATCH_CASEFOLD switch.

Yes, and I personally shall welcome a chance to insult the local IT
by suggesting BROKEN_SH_GETTEXT. Not that they get the point...
