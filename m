From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 07/11] ref-filter: add option to match literal pattern
Date: Mon, 27 Jul 2015 22:18:23 +0530
Message-ID: <CAOLa=ZS555Y31Lh70XDgumQv==JFk1rJKmpBWvrBO8CjPuY13g@mail.gmail.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
 <1437982035-6658-1-git-send-email-Karthik.188@gmail.com> <1437982035-6658-7-git-send-email-Karthik.188@gmail.com>
 <vpqtwsp92wf.fsf@anie.imag.fr> <CAOLa=ZSXD-pjgYCOt+ZcYS4uHS0p2uBYX8Rw80xpL+9pNUvm+w@mail.gmail.com>
 <CAOLa=ZT58Fai++91AUH2VcerH5OLkbC3thoGtqVYC70R8gSkaA@mail.gmail.com> <vpqd1zd4mbp.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 27 18:48:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJlaE-0001MJ-6s
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 18:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbbG0Qsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 12:48:53 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:35402 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbbG0Qsx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 12:48:53 -0400
Received: by obbop1 with SMTP id op1so63906334obb.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 09:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CcoEkZ0LK76fidvGfhbXWykJ8M8+SecsRRwsu4VQUmQ=;
        b=SwZr5fW6YXfSzzbEfbEYsaebVq2F1wXNJs/8q/+tmu9+dwQsK5spjNxm4EiocSEHMT
         cMNOeqIcPQ1/PlRCE/WvzlWA+7v/q69si+fdUZbCBudHZPhMAe+1nKqMiAeyxr6WHndh
         eoXBI1FNRmHYIB6jWN0pQ0SGNYnIFfzlnzrI7YJIjWOBseYCM4lAl63O6QZUpYUKfMpL
         QPgyFLCueu7JIC4V5QzzRBUmw9opBm9Yp4wjyxceh3nD+avfvJXL6SjG/6Hx/QVY+2H5
         X2GOgB+Vxi+ooRHZU4414s4qTlb99FcuJcB+gG5LkQVm2N3ACxGBfcwci8th/9Muf78u
         TBOg==
X-Received: by 10.60.41.138 with SMTP id f10mr28599018oel.84.1438015732705;
 Mon, 27 Jul 2015 09:48:52 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 27 Jul 2015 09:48:23 -0700 (PDT)
In-Reply-To: <vpqd1zd4mbp.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274690>

On Mon, Jul 27, 2015 at 9:36 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Mon, Jul 27, 2015 at 9:27 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> On Mon, Jul 27, 2015 at 6:24 PM, Matthieu Moy
>>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>>
>>>>> --- a/ref-filter.c
>>>>> +++ b/ref-filter.c
>>>>> @@ -946,6 +946,32 @@ static int commit_contains(struct ref_filter *filter, struct commit *commit)
>>>>
>>>>> +/*
>>>>> + * Return 1 if the refname matches one of the patterns, otherwise 0.
>>>>>   * A pattern can be path prefix (e.g. a refname "refs/heads/master"
>>>>>   * matches a pattern "refs/heads/") or a wildcard (e.g. the same ref
>>>>>   * matches "refs/heads/m*",too).
>>>>
>>>> Nit: you used to s/,too/, too/ in the comment in a previous version.
>>>>
>>>
>>> That's carried over from a previous patch, ill change it.
>>>
>>>> I think I already suggested saying explicitly "... matches a pattern
>>>> "refs/heads/" but not "refs/heads/m")", but I won't insist on that. Just
>>>> a reminder in case you missed it.
>>>>
>>>
>>> Sorry, I missed that out. Thanks for reminding.
>>>
>>
>> If I remember right, I didn't change that cause It didn't pertain to
>> this commit. I forgot to mention it in your previous mail.
>
> The "but not "refs/heads/m"" part makes sense in this patch to document
> explicitly the difference with the other function. But again, it's just
> a suggestion, you chose whether to apply it or not.
>

I think it's a valid add-on, will include it :)

-- 
Regards,
Karthik Nayak
