From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 0/8] port the filtering part of branch.c to use
 ref-filter APIs
Date: Mon, 21 Sep 2015 15:45:42 +0530
Message-ID: <CAOLa=ZQjO9z_wDpN6dqpu+VAUG91ROsWrdE6O=28tOjKiNEqYg@mail.gmail.com>
References: <1442772627-25421-1-git-send-email-Karthik.188@gmail.com>
 <vpqwpvkgblz.fsf@anie.imag.fr> <CAOLa=ZSyMV04wjhdM11RK9z8fz5tHM4PzPBxrN8_VA_Cacw82g@mail.gmail.com>
 <vpqfv28e1ex.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 21 12:16:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zdy8u-0005O3-Gd
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 12:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756549AbbIUKQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 06:16:13 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:36060 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539AbbIUKQM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 06:16:12 -0400
Received: by vkfp126 with SMTP id p126so61536194vkf.3
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 03:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qStFxDYlSDPyERFtEGUU83PdPnoSnLqDPBB4HjvfSzw=;
        b=e87n9W6vYGPws1M0H1fnc7/eyqVDvYor3xCsL425eD9HUpySmsGbd7uW8pYnrPlIC2
         kz/eOGP66WfFoJlBvqsqv2SutltIEHteaSUNwZWWOuK6JHVJqQx/sqdOzG2rA41aczq5
         3f99HmCChi6BM6IQdzb1Ow+I8GrMX+8lihadYm9ecRWsOdVX5aHJvIwggz1KJndclO8m
         17gvTSaAj90/2i+cSfkM+6ejx6bxpgEidi/zQ0gs9u9RzpxbfkIJdyyWlIhgkw4WK0T3
         MbBy0tasqwTMn4VHNXu/iZQDsVUNBr8KBOplYKDKk4AdeRU1Ak7F5sa7cago1bNZpoyY
         lw/w==
X-Received: by 10.31.21.149 with SMTP id 143mr12385200vkv.79.1442830571441;
 Mon, 21 Sep 2015 03:16:11 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Mon, 21 Sep 2015 03:15:42 -0700 (PDT)
In-Reply-To: <vpqfv28e1ex.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278298>

On Mon, Sep 21, 2015 at 11:53 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Mon, Sep 21, 2015 at 12:30 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> --- a/t/t3203-branch-output.sh
>>>> +++ b/t/t3203-branch-output.sh
>>>> @@ -145,8 +145,8 @@ EOF
>>>>
>>>>  test_expect_success 'git branch `--sort` option' '
>>>>       cat >expect <<-\EOF &&
>>>> -     * (HEAD detached from fromtag)
>>>>         branch-two
>>>> +     * (HEAD detached from fromtag)
>>>>         branch-one
>>>>         master
>>>>       EOF
>>>
>>> I thought this was obviously wrong, but this tests uses
>>> --sort=objectsize, so it's OK. Indeed, HEAD and branch-one have
>>> objectsize=215, and branch-two has objectsize=167.
>>>
>>> So, the previous code was hardcoding "detached HEAD always comes first",
>>> but we now sort the whole list, including detached HEAD, so branch-two
>>> comes first.
>>>
>>
>> Yeah! Even Junio said this was better, and even I think this is what
>> the user would expect.
>
> Yes, that was not an objection, just me thinking aloud during my review.
>

I know, I was just stating it, for others.

-- 
Regards,
Karthik Nayak
