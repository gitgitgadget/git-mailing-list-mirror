From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 01/11] ref-filter: use string_list_split over strbuf_split
Date: Thu, 18 Feb 2016 19:49:28 +0530
Message-ID: <CAOLa=ZR3XRuYBG4Pm0okS6TG3k9tEGwc-EvKq1As0CLCU4i3rQ@mail.gmail.com>
References: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
 <1455732379-22479-2-git-send-email-Karthik.188@gmail.com> <CAPig+cRTtXPjvCL3a-2Y+sKBPY1fKNO39VYnzFQ7Ed3dJn+w8w@mail.gmail.com>
 <20160217221430.GA24899@sigill.intra.peff.net> <xmqq1t8bhtdw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 15:20:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWPR6-0002x6-3J
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 15:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946250AbcBROUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 09:20:00 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35276 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946181AbcBROT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 09:19:59 -0500
Received: by mail-vk0-f47.google.com with SMTP id e6so45262631vkh.2
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 06:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HbceDd2tinLI0r8uYjssW3tPFBLL4SKx3xKpmSniuns=;
        b=H9ufkv+WBLCHkOLoejzX2jRvOmCz6Av2HmCuZqXHUfRVD7FYXV62Pjff+Fp+5afx6x
         C9m5J3BV27pdwsVXG+Kx/EszXAAwwnGp7F6sbo5wU3r5fGnzBZZqaobQFnp2RlqEoqgR
         6a/MPyDkTPKAJ2UkltcXXDkQyIQxB0FIHwM9haBFMCcIP61YlBs+1yvDg7L3vMmrhnSS
         Ae0epKHoIVLdS6ZhRJy8GxAhFPDaHsJ79tq6YRxKcP4xJAEpYffFQ7b2LZ8OZi8zr88K
         5lQ7fx+S/D9/B3Eso0UFd3dLxj27hbIeotM+bdM2tWsprll0p9eoHFXqB9r46rJYdziz
         k15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=HbceDd2tinLI0r8uYjssW3tPFBLL4SKx3xKpmSniuns=;
        b=RcwoM3E2S1eAsTgvn4gWr0eCpiRkjNfg4u6TlgQMoLnGxVVnnTLKohtMhCe1w8xv/C
         ZYgkX7q4By9gL+4fUQeshMnqJGycsx107EnRPw1H9HnXPla/DzCn5hxS8YOnWid0EQTg
         sUeSYIpr/F6ihy6TUeThLftgUZRAftKvG0TbpeSEgL3qZBm4kTu67+DIhAs5uWpCNiid
         xU+p4GmIwfGWUKgTQszu9fgG4WRKZMW1UVrm5hi0ShfkVRkd8hQ1sXukf73DDQfrQ3cw
         ZvXEcX20n9NdRWbBVcEC2FtRaZ6aMbMhj0mDc0XTZ20h0jmJf0pew1JKCEjiXMZyBIFJ
         SrDA==
X-Gm-Message-State: AG10YOT9Pu6ZYOIGotaUSSZrc6w2Wxw18Bkj5zJViEvJ7PxAU/v+T8Q+ZZN6TlZsI8QCQKvAaCiq9iH3G6IFSA==
X-Received: by 10.31.54.75 with SMTP id d72mr6100701vka.30.1455805198157; Thu,
 18 Feb 2016 06:19:58 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Thu, 18 Feb 2016 06:19:28 -0800 (PST)
In-Reply-To: <xmqq1t8bhtdw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286608>

On Thu, Feb 18, 2016 at 3:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Wed, Feb 17, 2016 at 05:11:50PM -0500, Eric Sunshine wrote:
>>
>>> On Wed, Feb 17, 2016 at 1:06 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> > From: Jeff King <peff@peff.net>
>>> >
>>> > We don't do any post-processing on the resulting strbufs, so it is
>>> > simpler to just use string_list_split, which takes care of removing
>>> > the delimiter for us.
>>> >
>>> > Written-by: Jeff King <peff@peff.net>
>>>
>>> Perhaps Peff can give his sign-off...
>>
>> Ah, right. I usually sign-off when sending to the list, so the version
>> he pulled from GitHub didn't have it.
>>
>> Definitely:
>>
>>   Signed-off-by: Jeff King <peff@peff.net>
>>
>> And I don't think "Written-by" was doing much here, anyway; I am already
>> the author by the From header at the top. :)
>
> ;-).
>
> So, is everybody happy with this round?
>
> With another series on top for the "conditional" stuff, I guess we
> are ready to do the formatting for "git branch --list", which would
> be a big step forward.
>
> Thanks.

Yes, I'll be sending that soon :D

> Yes, v6 looks good to me and is:
>
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

> I have not looked with nearly as close an eye as Eric, but I did not see
> anything objectionable (and I trust the reviews that have led us up to
> v6 in the first place).
>
> Thanks, Karthik, for your continued work on this (and to reviewers, of
> course :) ).
>
> -Peff

Thanks to everyone who helped, especially reviewers for going through such
long patch series.

-- 
Regards,
Karthik Nayak
