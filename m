From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v12 03/13] ref-filter: introduce the ref_formatting_state
 stack machinery
Date: Wed, 19 Aug 2015 21:24:00 +0530
Message-ID: <CAOLa=ZSzXyQZJksNqyroU6Td+LG7ZRTF_WNNryusAGZxTYTmDg@mail.gmail.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
 <1439923052-7373-4-git-send-email-Karthik.188@gmail.com> <vpqvbcb2uoi.fsf@anie.imag.fr>
 <CAOLa=ZTy8QO=H9g9g3SKU4HaG=qg71GidGuXKLXNgu7Su3FQ9A@mail.gmail.com> <vpqa8tn2sgy.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 19 17:54:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS5hC-0001ql-UA
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 17:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbbHSPyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 11:54:31 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34583 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbbHSPya (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 11:54:30 -0400
Received: by oiey141 with SMTP id y141so5632748oie.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 08:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZCJ3igf/vkLoYZQy44bNhofFGX82puir8+YFz3SyLOM=;
        b=gz9wf21VTY4WBZ0M0jjZ9Cr6KYbqJBOqEnnbfERuc+sFGz17rIHBz/CHbUTlkpkJJF
         1z5tcrGp2P14U4EC0x/XcQWrYHFd5GJuccIcQ4C3CwjIrm0B+i9mFwXii/lgSHEhrYQy
         OZ8RNjCdstwF580fhEX21XLCbfq/rGFf8GDP8OKBDdz8/GsOtjfncKLEI9HrrfQPqwwG
         gZhlFteiHuJodrfyNdZB7cU2EmovWbegFPpaHLv31VxF+nM3x52G/hIgDU48XoBedEcq
         fQHt3FS8RUltkg4FIezs1Asf+YIqmcdLfoKwbwd3x4r+d81n2SutcpfovL6ZeabIrf9/
         ZxiQ==
X-Received: by 10.202.92.65 with SMTP id q62mr4088599oib.11.1439999669626;
 Wed, 19 Aug 2015 08:54:29 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 19 Aug 2015 08:54:00 -0700 (PDT)
In-Reply-To: <vpqa8tn2sgy.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276201>

On Wed, Aug 19, 2015 at 9:14 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> --- a/ref-filter.c
>>> +++ b/ref-filter.c
>>> @@ -155,6 +155,8 @@ static void push_new_state(struct ref_formatting_state **stack)
>>>
>>>         strbuf_init(&s->output, 0);
>>>         s->prev = *stack;
>>> +       if (*stack)
>>> +               s->quote_style = (*stack)->quote_style;
>>>         *stack = s;
>>>  }
>>>
>>>
>>
>> This seems about right, why do you think it's a stupid fix?
>
> If you have a stack of N elemments, why replicate a field N times if all
> the N instances always have the same value?
>
> There's nothing to be pushed or poped with quote_style, so having it in
> the stack is confusing to the reader (one has to infer the property "all
> instances have the same value" by reading the code instead of having
> just one variable), and error-prone for the author: you already got
> it wrong once.

Thats also there, I'll guess it makes more sense to remove it from
ref_formatting_state.

-- 
Regards,
Karthik Nayak
