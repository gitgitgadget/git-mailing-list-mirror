From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/10] port branch.c to use ref-filter's printing options
Date: Mon, 12 Oct 2015 01:08:17 +0530
Message-ID: <CAOLa=ZSjGwTrS=bMSMtRTg=f5D_E-_xHCu4JYuZtqtDEMvUKVg@mail.gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
 <vpqr3l5zgst.fsf@grenoble-inp.fr> <CAOLa=ZQvB_S2-nw8hOABt7aQJOWJXvfK1U2zurpnZmaAgJNnGA@mail.gmail.com>
 <vpq8u7dp9qr.fsf@grenoble-inp.fr> <CAOLa=ZQOO9BjoTj1B-b=kUviL=617F7y46BeX1sOXpeHcatFVQ@mail.gmail.com>
 <xmqq4mi1rywu.fsf@gitster.mtv.corp.google.com> <vpqpp0ojvs6.fsf@grenoble-inp.fr>
 <xmqqfv1jq4jy.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQkjMFXVeJ==myQLjyRs6EcejnYnszYKJLyskFufjeqiA@mail.gmail.com>
 <vpq4mhx2x5z.fsf@grenoble-inp.fr> <CAOLa=ZTjuuO_TmdynQvJGVtQHZokwDpqZLUOWgCx-_UO=JKvvw@mail.gmail.com>
 <vpqlhb9yzeg.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Oct 11 21:39:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlMSX-0004vq-Vm
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 21:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbbJKTix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 15:38:53 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:36566 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbbJKTir (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 15:38:47 -0400
Received: by vkgc187 with SMTP id c187so12987475vkg.3
        for <git@vger.kernel.org>; Sun, 11 Oct 2015 12:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CnN2KsYW4U9PFuTcDEcqYRbaP77czjGnmotV0rlNjuw=;
        b=0E4QDhiGtg3aPWU78kQUki7llSCMNQCLswMDTsjlUKUYmllRTcqmAm7KCK/cybTEm3
         gfCJtouuZ5ViVoWadF4b9iVhnQf14XAlGlfAANR/KNbfSrIB/4s/LxRD3zNXbEgEnKpC
         kghkJk3gttxv0wfa/bmj5LwIHiaxnJZy1PREIWw4hnotLhL0ReJruLCrYjwZTbpZY0sb
         x41sjIloPIxDUhfJ47u2s1UBY9Cq2PKFj8Z+XeKauItBhkKIVnAGyb47IHsFVIpk7tYy
         zloJWsxf9/a8aBoLgvICgSNbieB/gke46sERfEfROtD6GIFsdct7t4e453RuEbase4i2
         +QEQ==
X-Received: by 10.31.178.198 with SMTP id b189mr13836764vkf.114.1444592326923;
 Sun, 11 Oct 2015 12:38:46 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Sun, 11 Oct 2015 12:38:17 -0700 (PDT)
In-Reply-To: <vpqlhb9yzeg.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279356>

On Mon, Oct 12, 2015 at 1:02 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Sun, Oct 11, 2015 at 9:51 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> Also does it make sense to integrate these changes here? Or would you like to
>>>> have another series on this?
>>>
>>> To me, the important in this series is to avoid introducing duplicated
>>> and inconsistent code, because it would make further refactoring harder.
>>>
>>
>> Would you suggest duplicating whats done with %(align) here?
>
> I think introducing a function to split according to commas and remove
> commas would make sense, but I won't insist on that. Mimicking what's
> done with %(align) is acceptable to me: we'll have several instances of
> the same pattern, not ideal but easy enough to refactor later.
> Especially if you actually plan to work on that :-).
>

I was planning on working on what Junio and you suggested after this ;-).
So I didn't see the need of " introducing a function to split
according to commas"
if we plan to rewrite the whole parsing part of ref-filter.

-- 
Regards,
Karthik Nayak
