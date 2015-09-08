From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v16 00/14] port tag.c to use ref-filter APIs
Date: Tue, 8 Sep 2015 11:13:51 +0530
Message-ID: <CAOLa=ZTwV3O9LVKqU3zXaqt=HoF1HxAGoMW2PLuj_y9iydRUwQ@mail.gmail.com>
References: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
 <xmqqh9n6agcf.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQFZRKY_hHEVQQ6CuYC9XNWHJFYg1CFZCGUr-68phDMHQ@mail.gmail.com>
 <vpqfv2qqq7y.fsf@scolette.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 08 07:44:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZBhj-000290-BU
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 07:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbbIHFoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 01:44:23 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34889 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbbIHFoV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 01:44:21 -0400
Received: by oiww128 with SMTP id w128so52801019oiw.2
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 22:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IhlXdpndV3nD9YCfghqjWA4ILjeSaem58YyIAh6k0wQ=;
        b=xTnHIzUECZHiHLIYmSX2/zoigDberavmxrbPqvx6S2qEkkXG+uQm+IiPswaU+U609V
         W1FEmSDHfJnV8cWqgVnAoDiysRnLJIwY6Hnxvz4qXzafoUQ0shQjgC//WqNxnXWROJse
         zew7F9DId/tE3JlNglE6cXJeUupaF7Zy0yx7OoNoKlPPTaMb/Wy+H/vjCKTEHUSHLySX
         FJmh4f+xGgJgYuyxBX0cS0VQgBrZo2jvhkhzj8vGxBSIIqBo8JjIGpsAKXkAk5A13oop
         JdW/izvvvxjZ4dEgUs1SyKMipoyyEH3UxtQAr7h5wCBbzerq/v4HowhUwjXrh7mTcYYD
         wk7Q==
X-Received: by 10.202.225.11 with SMTP id y11mr8396763oig.60.1441691061061;
 Mon, 07 Sep 2015 22:44:21 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 7 Sep 2015 22:43:51 -0700 (PDT)
In-Reply-To: <vpqfv2qqq7y.fsf@scolette.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277487>

On Mon, Sep 7, 2015 at 7:35 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Mon, Sep 7, 2015 at 12:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> diff --git a/builtin/tag.c b/builtin/tag.c
>>>> index 9fa1400..f55dfda 100644
>>>> --- a/builtin/tag.c
>>>> +++ b/builtin/tag.c
>>>> @@ -43,8 +43,8 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
>>>>
>>>>       if (!format) {
>>>>               if (filter->lines)
>>>> -                     format = to_free = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) %%(contents:lines=%d)",
>>>> -                                                filter->lines);
>>>> +                     format = to_free = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) "
>>>> +                                                "%%(contents:lines=%d)", filter->lines);
>>>
>>> This line still looks overlong.  Would it help to stop spelling this
>>> as a double "a = b = overlong expression" assignment?
>>>
>>
>> I'm not sure, I get what you mean.
>
> I guess
>
> format = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) %%(contents:lines=%d)",
>                  filter->lines);
> to_free = format;
>
> (still 83 columns + indentation, but that's a bit shorter than your
> version).

Also we could drop left, its default anyways.

-- 
Regards,
Karthik Nayak
