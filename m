From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 01/10] ref-filter: add %(refname:shortalign=X) option
Date: Tue, 14 Jul 2015 02:06:15 +0530
Message-ID: <CAOLa=ZRuCa=7QzS7K86eikApiGgYsGLeaP0mw5Ax=k5en72jxA@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com> <xmqqk2u8kmre.fsf@gitster.dls.corp.google.com>
 <CAOLa=ZTNGV=NAXDPB3HX=fanPMQaQQc4ZpFdDFeg+LJ8SFuVOQ@mail.gmail.com>
 <CACsJy8BsLnkPFX04WujMdnBiRGmXacF1QSQudb3T8nxGrZ_1Fg@mail.gmail.com>
 <CACsJy8BL0ccxNYLE0gqBx5KTpqTOt=Ut6-k3fauxXNt2wpxSEw@mail.gmail.com>
 <CAOLa=ZThDcmM79hL0TUh6+8=NkQBWOWK=Ti+-v+2PCysquw-1w@mail.gmail.com> <CACsJy8D6XOJbVb9LiDmmNuH9UWmyj9BRc0V5GYq-0wwi2uvN0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 13 22:36:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEkT4-00083a-3s
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 22:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbbGMUgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2015 16:36:46 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33050 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbbGMUgp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2015 16:36:45 -0400
Received: by obbgp5 with SMTP id gp5so124676139obb.0
        for <git@vger.kernel.org>; Mon, 13 Jul 2015 13:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SDrB9gvhCMkEsHVk6+SfkAZhF0nhpco9kuknTfx4XCY=;
        b=eki2PrAkl4A4w1Lc37clFvPtGXrssHRe+RGC6ebVm3kncWfrNOy8a5XhPtuqzwaxCt
         DH9qYL2SvO5nr+/Eiw4lNh5BKNmHsmR0+fW3XZqWczC8mnh2xI//POfB09++QevJiqwo
         E2wOMTxs5hMtb1aRm9lSdeguvv2vhlPX6OF9mdSvs+ikIMdke5PZi5z5nZRjiS4I3j4H
         Z5qFqUv/moe1alsBUXDBExTZkoZgWapm7GD4i84YfNGIwOj+VQX+TifdsSs6w+KojpZf
         0zcwHk6qnzfoVKJq1tOdLKV309S78ucN9DRQpyox+eReZCCvK/5qFdygzQ9aB9vKcRKU
         YxMw==
X-Received: by 10.60.177.195 with SMTP id cs3mr24925613oec.37.1436819804857;
 Mon, 13 Jul 2015 13:36:44 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 13 Jul 2015 13:36:15 -0700 (PDT)
In-Reply-To: <CACsJy8D6XOJbVb9LiDmmNuH9UWmyj9BRc0V5GYq-0wwi2uvN0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273926>

On Mon, Jul 13, 2015 at 4:21 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Jul 13, 2015 at 2:56 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Sun, Jul 12, 2015 at 7:17 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>
>>> I guess if you can have multiple arguments after ':' in an atom, then
>>> you have wiggle room for future. But it looks like you only accept one
>>> argument after ':'.. (I only checked the version on 'pu'). Having an
>>> "alignment atom" to augment the real one (like %< changes the behavior
>>> of the next placeholder), could also work, but it adds dependency
>>> between atoms, something I don't think ref-filter.c is ready for.
>>>
>>
>> I was thinking of something on the lines of having a function which right
>> before printing checks if any "align" option is given to the end of a given
>> item and aligns it accordingly, this ensures that any item which needs to
>> have such an option can easily do so.
>>
>> https://github.com/KarthikNayak/git/commit/0284320483d6442a6425fc665e740f9f975654a1
>>
>> This is what I came up with, you could have a look and let me know if
>> you have any
>> suggestions.
>
> Yeah, pretty close to what I described in the other mail. Now if you
> make "align" a separate atom, I think it would reduce clutter in
> populate_value() (my personal opinion is this function looks too messy
> already) and we can easily add more alignment options in future :)
> --
> Duy

Yeah, that seems like the way to go, eventually :)

-- 
Regards,
Karthik Nayak
