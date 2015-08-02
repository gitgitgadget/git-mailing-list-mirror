From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 07/11] branch: move 'current' check down to the
 presentation layer
Date: Sun, 2 Aug 2015 18:29:08 +0530
Message-ID: <CAOLa=ZREZ2M_txEQR9jPET5_+MXx0D6cfW0X7SS4-TP9MShVrA@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-7-git-send-email-Karthik.188@gmail.com>
 <vpqbnewxwcx.fsf@anie.imag.fr> <CAOLa=ZTy+KX4K_inpDoMy+thzFdF2RF93yMEHJUExzT4OvjPww@mail.gmail.com>
 <vpqk2tjmgeg.fsf@anie.imag.fr> <CAOLa=ZRUnF12gO=AKg3E373XETqoykqOXSkPvr7DHCVrOeggAA@mail.gmail.com>
 <vpq4mkmejsh.fsf@anie.imag.fr> <CAOLa=ZRq7zowwse7OGeU_AwJe_Z0WDn1qoYaH_A6AD5g92e_GQ@mail.gmail.com>
 <CAPig+cTyK=xDbtsK+q0eL=wmZ87xWue8SMJm=DQOzX22R1AOtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 02 14:59:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLsrf-0008GX-8P
	for gcvg-git-2@plane.gmane.org; Sun, 02 Aug 2015 14:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbbHBM7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 08:59:39 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:35050 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbbHBM7i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2015 08:59:38 -0400
Received: by obbop1 with SMTP id op1so82592125obb.2
        for <git@vger.kernel.org>; Sun, 02 Aug 2015 05:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vlOocZ29VwfHR8elH4IZo1tivJy3R4sJyrkbH2IPIqY=;
        b=UsgncspZ6ZZYY2AnyDfvlLH/h1+UnoYNaUZacTQPu6AmK9E6s1G4neSd/UeitSPEaR
         bFcPjEW5NCWXFIXkUf43azgJgsUL6xc/aaGuvM2r6AtuihVBF6nJIlq+MZXz0rbdiwM3
         qU1pIf9pp5BpyrQgPI1k3yP2OMWxfBp025aRO6GeV4/4XLYTKLwCu6Nz4vySw7RPeA81
         PLVJ3YoE89oZ+RguQJQ45T6gvt3sBMkfG2jjmodB15S3dBGwm+ltWrgixQmZbWoejAKr
         DNYgKLoktU/owp5i/HNSzv72ogpXkznFF6fEXEzd7lrZ3r15vnsNIU0pEY+ihVdsaZgt
         KVOg==
X-Received: by 10.182.60.130 with SMTP id h2mr11950429obr.42.1438520377607;
 Sun, 02 Aug 2015 05:59:37 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Sun, 2 Aug 2015 05:59:08 -0700 (PDT)
In-Reply-To: <CAPig+cTyK=xDbtsK+q0eL=wmZ87xWue8SMJm=DQOzX22R1AOtQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275138>

On Sat, Aug 1, 2015 at 2:33 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Aug 1, 2015 at 2:48 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Thu, Jul 30, 2015 at 2:57 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Good point! I just was wondering if we need another atom just to print a star.
>> But your points certainly are valid. I'll implement this. Thanks :)
>>
>>>> This would remove the need of making the printing of the "*" to be
>>>> needed by ref-filter. As this is only needed in branch.c
>>>>
>>>> If going on what you're saying we could have a "%(starifcurrent)" atom or
>>>> something, but I don't see a general use for this.
>>>
>>> To have a really customizeable format, you would want to allow e.g.
>>>
>>>   git branch --format '%(starifcurrent) %(objectname) %(refname)'
>>>
>>> if the user wants to get the sha1 before the refname, and still have the
>>> star in front. It's a bit frustrating to have a hardcoded format that
>>> the user can't reproduce with the --format option, since it means you
>>> can't easily make a small variation on it.
>>
>> Agreed. will have a "starifcurrent" atom :)
>
> Please don't. It's better to avoid these highly specialized solutions
> and instead seek general purpose ones. For instance, utilizing the
> %(if:) atom suggested elsewhere, you might add an %(iscurrentbranch)
> which would allow a format like this:
>
>     %(if:iscurrentbranch)*%(endif)
>
> Even more generic would be an %(ifeq:x:y) conditional and a
> %(currentbranch) atom:
>
>     %(ifeq:refname:currentbranch)*%(endif)
>
> Those are just a couple ideas. Other variations are possible and
> likely preferable to the specialized %(starifcurrent).

This makes sense, thanks. But implementing something like
"%(if:<atom>)" seems to not be as easy as I thought it would be.

First we need to parse that inner atom, but the used_atom_cnt is based
on how many atoms there are initially, which doesn't count this inner atom.

Although we could have a way around that, we'd need to again call populate_value
from itself to get that inner atom's value. This causes more problems.
Either ways
I'm looking at ways around this.
A simple solution would be to do :

%(if)%(atom)%(then).....%(endif)

or just

%(if)%(atom).....%(endif)

-- 
Regards,
Karthik Nayak
