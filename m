From: Stefan Beller <sbeller@google.com>
Subject: Re: Rebase performance
Date: Wed, 24 Feb 2016 16:22:47 -0800
Message-ID: <CAGZ79kauMxxXcRu97CZ=uyau-fpNpZ-8q8vM5fDRmUmuLaMLPw@mail.gmail.com>
References: <CAP8UFD0p1kvk2B0kkc-M9dm+H-Bmam=OrE99VwQx=KCETFEjcw@mail.gmail.com>
	<CA+P7+xpC+gZijkcxcp8uFCmYjQf7-0xbBf7FWSsFnMXB1b7G+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 01:23:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYjhs-0003wF-5E
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 01:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759068AbcBYAWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 19:22:50 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38755 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759063AbcBYAWs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 19:22:48 -0500
Received: by mail-ig0-f178.google.com with SMTP id y8so2847033igp.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 16:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=tynCaKF7SGQSf1HmxH2wXe19wgBydrDgKCIpspsen/Q=;
        b=Yykf52SP2nLcA5AArJI8fRACLj/jTkD6Q3rTE7CejOwt8UHr+0Scwiko/cNmc7c84J
         JDhOHK42TKp7xep5tRf+bCEuQbtu6svULg9AOxti5M8qOpFOudyQXMSO16By3v83ug12
         tnHcyaCptuetn8ULrpuIOAcM22qxxUEkWwech/hdw1QSe8pMpa+k+oNJ9i4mG2wy/I22
         DUnlikpz/gedSEEHp+32Edf0jVMyUxscfe0vxzcEJsMTBF+9027qqhDcXZEfjCUzGyOP
         xQEeqoVnaAcCvqakHmpRd12+/ZECGZIFP9M6W3tpWFKnygZPXZWl294BVlJZKCuT2oou
         yeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=tynCaKF7SGQSf1HmxH2wXe19wgBydrDgKCIpspsen/Q=;
        b=MyL1f8bNE3NI9OtOoCZvVvffxUXSyIR289rJB3Q8nedWiqZDk12N9dqGrbFaVHwI3m
         HqiUhWIqPJW9TuRMic69KEa5ZvIQOQGntuStRXFpBmXsf8UGqWy7b+uGhC94UuUZiebP
         MOMKcNijJHpQP2selPnY7riVa7LIhWyqdI5wBgKgUJvqFF6Ms1bBrDgI2SK1Ib+WzyKt
         pbNYF3H4CZzGIGn1mX586WhX8kq6q3hDVQYSgCbK+5+sWacaqPscdN7M46Ggz+9YTMnK
         ULKMvE/uFAle2JzXVEUUmNfOAoqbRlECVSpLzocEKeqD2Zo8fwixBBO0trDZEDy+iP8+
         ZEiA==
X-Gm-Message-State: AG10YOShJ8CvkqybYreSZCaII0ZF2p8AyK6c4sjzdx35ImR8FXsLKP202mbySJrF+oBU1fJzExYtg6D0P0olhld7
X-Received: by 10.50.112.10 with SMTP id im10mr304898igb.93.1456359767780;
 Wed, 24 Feb 2016 16:22:47 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Wed, 24 Feb 2016 16:22:47 -0800 (PST)
In-Reply-To: <CA+P7+xpC+gZijkcxcp8uFCmYjQf7-0xbBf7FWSsFnMXB1b7G+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287293>

On Wed, Feb 24, 2016 at 4:15 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Wed, Feb 24, 2016 at 2:09 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Hi,
>> Another possibility would be to libify the "git apply" functionality
>> and then to use the libified "git apply" in run_apply() instead of
>> launching a separate "git apply" process. One benefit from this is
>> that we could probably get rid of the read_cache_from() call at the
>> end of run_apply() and this would likely further speed up things. Also
>> avoiding to launch separate processes might be a win especially on
>> Windows.
>>
>
> This is the route I would go, since the addition of a taskset option
> seems pretty difficult to get correct, and may not be portable. This
> above solution likely improves more in general, and is more portable.
> Not exactly sure how easy it would be to "libify" the required bits of
> apply, however.. it may be that this is already available as well but
> we just didn't go that route during the port of git-am into C code.
>
> Regards,
> Jake

IIRC Junio started libifying am after Paul Tan rewrote it in C,
See origin/jc/am-mailinfo-direct (tip at 4b98bae2cbc6b).

That part however only libifyies the mailinfo which is used
by apply (one layer below), so I am not sure if the run_apply
has been attempted to libify.

I would also encourage to rather try to not call out to a child
(libifying) instead of adding the taskset hack for servers.

Thanks,
Stefan

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
