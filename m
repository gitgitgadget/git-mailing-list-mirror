From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v15 05/13] ref-filter: implement an `align` atom
Date: Thu, 3 Sep 2015 19:00:18 +0530
Message-ID: <CAOLa=ZQCDjo8_h7G1GpUOCs_9X8=phQqxXN-s=XjhBK-DLJVVg@mail.gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
 <1441131994-13508-6-git-send-email-Karthik.188@gmail.com> <xmqqegihrg6t.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZQ0nyaQmvE3suT6hh0jO3s_iYxFLjSuLUY4STneMFJf9Q@mail.gmail.com>
 <xmqqd1y0q30g.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQLG_HB0trodXPCb9n4x2FuH7h7-+KJYLEdNZSpd0PHsg@mail.gmail.com>
 <xmqqy4goomdk.fsf@gitster.mtv.corp.google.com> <vpqio7slpbd.fsf@anie.imag.fr> <xmqqfv2wohly.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 15:30:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXUbO-00061L-Ky
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 15:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832AbbICNau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 09:30:50 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:36115 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbbICNat (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 09:30:49 -0400
Received: by obqa2 with SMTP id a2so32157918obq.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 06:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0jSODkG3JPRlnSiPOapKDMHCCBOHLYu1QMrwro8dmSM=;
        b=iVPmK03Elf5HWvIIqu/7w2tYqRK6FFa+idACWClXRf28NWHIJl6R9wGXV1kCcWiRsW
         k8OpIWtMx6rJPjcRmfSq4nO/UMQVtw509cl6gmw6do+UxHXM0jarP81AfR6kWFMmk2KL
         66ZjpkjQw9rwf6PB79HrUvicrCYVPFKpSET5/NheSgdE6784oyK/loVOQ10DmTDl8ESu
         hKSNjKQ6Mf2L9E5XtEsQ+UGrgTiTdcoIdW1dHDkDHgTBd2Q4/FGhHMoG1w++GIPN3s9V
         LizlrjIO9C5ZaBh3/D5CVYg2Ttjps5kBGWF6S02plExuSzbCfz3BtHflFnwRDys3mUF7
         oZCA==
X-Received: by 10.182.81.98 with SMTP id z2mr25576102obx.70.1441287048345;
 Thu, 03 Sep 2015 06:30:48 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Thu, 3 Sep 2015 06:30:18 -0700 (PDT)
In-Reply-To: <xmqqfv2wohly.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277200>

On Wed, Sep 2, 2015 at 10:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> On Wed, Sep 2, 2015 at 8:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>>>
>>>>>>>> +             die(_("format: `end` atom used without a supporting atom"));
>>>>>>>
>>>>>>> Not a show-stopper, but we may need some wordsmithing for "a
>>>>>>> supporting atom" here; an end-user would not know what it is.
>>>>>>
>>>>>> Probably something like "format: `end` atom should only be
>>>>>> used with modifier atoms".
>>>>>
>>>>> Between "supporting" and "modifier" I do not see much difference,
>>>>> though.
>>>>
>>>> I don't see how we could provide a better message, as %(end) atom
>>>> would be common to various atoms eventually.
>>>
>>> I said "not a show-stopper" without giving a suggestion exactly
>>> because I didn't (and I still don't) think either you or I can come
>>> up with a good wording ;-).  That is why the message was Cc'ed to
>>> the list for others to comment.
>>
>> I don't really have a better proposal either. What we really mean is
>> "%(end) requires an atom that requires to be paired with %(end)", but
>> that wouldn't really help. I prefer "supporting" to "modifier":
>> To me, %(color:red) can be called a "modifier" by I wouldn't call %(if)
>> a modifier. "Supporting" is vague, but less misleading to me.
>>
>> Perhaps "corresponding"? (not convinced myself ...)
>
> Yeah, it is like an open and a close parentheses that form a
> matching pair.  "%(end) without a corresponding atom" (implying
> "that opened the environment the %(end) attempts to close")?
>
> We'd need to define what an atom is (or "supporting atom" for that
> matter) and explain how nesting works in the documentation anyway,
> and I'd expect we would gain definitions of a few terms we can use
> in this error message.
>

Then I'll just change it to corresponding for now, and probably go back to it
after the series? Maybe work on some documentation at the end of the series.

-- 
Regards,
Karthik Nayak
