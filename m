From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 0/8] Expose the submodule parallelism to the user
Date: Thu, 29 Oct 2015 10:30:49 -0700
Message-ID: <CAGZ79kbUQUpCgHP8rKnijog77AwoMn4GunzfV25sgLwpTC-4ag@mail.gmail.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
	<1446074504-6014-1-git-send-email-sbeller@google.com>
	<56321CF4.60807@ramsayjones.plus.com>
	<CAGZ79kYXrOFDqs5c-OYG2vRO9GY_aoD_GU1=TkRtOMaGC_GowA@mail.gmail.com>
	<xmqqh9l9si57.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 18:30:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zrr2N-0005mR-9o
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 18:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757406AbbJ2Rav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 13:30:51 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:36645 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbbJ2Rau (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 13:30:50 -0400
Received: by ykba4 with SMTP id a4so49925035ykb.3
        for <git@vger.kernel.org>; Thu, 29 Oct 2015 10:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BOHwRuemEa4FhbrM1/vSl3HzxAa3wW26J13WrJflrN4=;
        b=im4SdCHae7dZTGBqaT4NVbD+PGefe1ntv8UarAwkGcBeDLei9nZ3yWDc8dlLcwYZYP
         YzTmi1Wo32Fa7A3ckvhU6N92Zs7l5YT+jBvnCSwH0VRE8n9rZu9AnRRKJBjPrOu+HGue
         HW6QMg2wb+vyQx5wkcFofNeSNeY48D7jFLtGcG5lQX0t/4XH3rd3DquJvn2l8Xr/ekc2
         0TQXRYCVq7A2jWxSi3wbbB2XRYiRhWKReXLpz8sL7lSDz077tgFQ9Z9XgnRJVoa0dEqm
         0CgAY36Mv6mNW3Vn0ndFnRuG9FlubKnYIz8IUIX0xeYkmwmAxJfEEjW+SAcE3mPlflai
         n7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=BOHwRuemEa4FhbrM1/vSl3HzxAa3wW26J13WrJflrN4=;
        b=hUlcLbIc+tRyDj9811J3vjzvkYPVX3SWfVjpGuzCx+n+NvzvuF0XYZPvCMi+q8tRrL
         DSf67ZZpcgNK+iqUhTYmgo0wHKBHKBYEEiPhmeLkaeExb1JXX5RNCGgatJrT135sNl9C
         vbki7np+27LIc4yJN3iskWm03CVjRxea2qzVLX5fbXs0eOnQaGvtrwsLll6hingUj5bY
         TjCrzdYLPthnccuJPMVCMo7xGwiyVKw8Q9rWqNJIjzqBf4xboaYNEjzoLo1AgQpTvjke
         kTIRfSeZiGnqttFKx2orGGM78BM1uX5f71XSc2kWf6DPdUUAimH6DiRiza03V+Q0tpAr
         7BaQ==
X-Gm-Message-State: ALoCoQlXpR0mX6QxvaBOnDaJjwQSjf3zGLT/AcHhGX3lWouWj4k1neSTgIcXLeE49f20P+Czl6bY
X-Received: by 10.13.254.69 with SMTP id o66mr2421327ywf.252.1446139849375;
 Thu, 29 Oct 2015 10:30:49 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Thu, 29 Oct 2015 10:30:49 -0700 (PDT)
In-Reply-To: <xmqqh9l9si57.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280448>

On Thu, Oct 29, 2015 at 10:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Thu, Oct 29, 2015 at 6:19 AM, Ramsay Jones
>> <ramsay@ramsayjones.plus.com> wrote:
>>
>>> Hmm, is there a way to _not_ fetch in parallel (override the
>>> config) from the command line for a given command?
>>>
>>> ATB,
>>> Ramsay Jones
>>
>> git config submodule.jobs 42
>> git <foo> --jobs 1 # should run just one task, despite having 42 configured
>>
>> It does use the parallel processing machinery though, but with a maximum of
>> one subcommand being spawned. Is that what you're asking?
>
> With this patch, do we still keep a separate machinery that bypasses
> the parallel thing altogether in the first place?

No.

>
> I was hoping that the underlying parallel machinery is polished
> enough that using it with max=1 parallelism would be equivalent to
> serial execution.

There is no special code path for jobs=1.

It should be pretty close, just with the overhead of the parallel engine
spawning it one after the other and being an intermediate for output piping.
The one subcommand would still output via a pipe to the parallel engine,
which then outputs it immediately.

> At least, that was my understanding of our goal,
> and back when we reviewed the previous "fetch --recurse-sub" series,
> my impression was we were already there.
>
> And in that ideal endgame world, your "Give '-j1' from the command
> line" would be perfectly an acceptable answer ;-).

ok. :)

>
> Thanks.
>
