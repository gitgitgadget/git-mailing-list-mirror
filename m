From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] Add fetch.recurseSubmoduleParallelism config option
Date: Tue, 13 Oct 2015 09:03:24 -0700
Message-ID: <CAGZ79kYZ+RyjvkgY8+aeRpnVtaCyqFxQqQ3wggjtef7y6MNLcA@mail.gmail.com>
References: <1444690350-6486-1-git-send-email-sbeller@google.com>
	<xmqqeggzbrx5.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZuZZivs8czV2P6uHWaU6ay1hG21k-_G9tgN5KbV6jW8w@mail.gmail.com>
	<xmqqzizn9qaf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 18:03:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm230-0004BI-Ah
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 18:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbbJMQD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 12:03:26 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:33606 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbbJMQDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 12:03:25 -0400
Received: by ykoo7 with SMTP id o7so21176923yko.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 09:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4Du61HNTMkYCkHZSi9MeIRHS6Ji3QDg/WYc2ofosV/U=;
        b=TeCKE0kR9tBygVdZ/I1a5c6CEn0SVSC1Ws+CBik2Q/Hmq4vXuQszJ/AxPQdLLbJXyP
         5PrOIw0ZgVdhNaO4mNFUbSre4eG3wsgvT5w4e3gGoeqMicPEvO/yPkPan07wZ1wxEkKg
         h1IXlTfup6uPzlvCo8E1VlYu8ezPxhIh50bvDLZ+qHm7VkicJEwBjAj/h01udO+gAmOu
         QoVdheAQW6sE2NmEY25zcqcBfFLI82vX0tqpVAebrVesKFYkDv/1MJyAp0RH6GSEC+ex
         Uxn62dbem0SYfZ0WdkkMvZxBw2IhyRlet5m1JtQbqNZ5tGBoSERFJxDsnpka25m+kme+
         y3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4Du61HNTMkYCkHZSi9MeIRHS6Ji3QDg/WYc2ofosV/U=;
        b=jsSqbY9Cr9Y6b8UFI3sClHFnKFM+lf+n6P+cG1TFT0v/buMUbgJHOvEm2gqHlQ5P3Z
         U33a5tvU9PKCoYISW+1KnyAvCx1KtyYeKtvs0fNoECAp8FQEBvYKtWdn4jsJlBWKl+m5
         UT/rTAV9CYR7zzqvmLfSq3ZY65FIZgFuc09aLZ/a55wD5JXKIKiHv9LLnCbahJ/FJcus
         ndN5s7Lb/j8scWbN97jGEMHiTS2U/hNKwajB0i/N7sDqLhkkdX4B1pNLsRlt79zKN8RJ
         vbPMrhIgLfL7OYNBgiM3jx7WSne/t2+/v05han3Znj8jFrkBC1+kJsAyPX1yxZU8C478
         P1IA==
X-Gm-Message-State: ALoCoQkaXcJBGT48/nuU+QHPa2YYBuJAepwZ0HLsa9EAe+px5PxUWL+UgXZjb56CbRO5vSj4rMci
X-Received: by 10.13.198.194 with SMTP id i185mr25046684ywd.68.1444752204214;
 Tue, 13 Oct 2015 09:03:24 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Tue, 13 Oct 2015 09:03:24 -0700 (PDT)
In-Reply-To: <xmqqzizn9qaf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279503>

On Tue, Oct 13, 2015 at 12:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> The parallel_process API could learn a new "verbose" feature that it
>>> by itself shows some messages like
>>>
>>>     "processing the 'frotz' job with N tasks"
>>>     "M tasks finished (N still running)"
>>
>> I know what to fill in for M and N, 'frotz' is a bit unclear to me.
>
> At least I don't know what M and N should be, and I'm curious how
> you'll define them.  See below.

I presumed the second school of thought. Another alternative there would
be to have 3 numbers:

    "M tasks finished (N still running, K pending output)"

>
>>> in the output stream from strategic places.  For example, the first
>>> message will come at the end of pp_init(), and the second message
>>> will be appended at the end of buffered output of a task that has
>>> just been finished.  Once you have something like that, you could
>>> check for them in a test in t/.
>>>
>>> Just a thought.
>>
>> I like that thought. :)
>
>
> A few more random thoughts:
>
>  * The only thing you could rely on if you were to use the above in
>    your tests is the one from pp_init() that declares how many
>    processes the machinery is going to use.  M/N will be unstable,
>    depending on the scheduling order (e.g. the foreground process
>    may take a lot of time to finish, while many other processes
>    finish first).
>
>  * Every time the foreground process (i.e. the one whose output is
>    tee-ed to the overall output from the machinery) finishes, you
>    can emit "M tasks finished (N still running)", but I am not sure
>    what M should be.  It is debatable how to account for background
>    processes that have already completed but whose output haven't
>    been shown.

Assuming we go with your second school of thought (N are the real
running processes, M including the finished but still pending output tasks),
we may have confusing output, as the output order may confuse the
reader:

    N=8 M=13 (output from live task)
    ...
    N=8 M=12 (output from buffered task)
    ...

Anyone who has no knowledge of the internals, wonders why
M goes *down* ?

>
>    One school of thought that is in line with the "pretend as if the
>    background tasks are started immediately after the foreground
>    task finishes, and they run at infinite speed and produce output
>    in no time" idea, on which the "queue output from the background
>    processes and emit at once in order to avoid intermixing" design
>    was based on, would be not to include them in M (i.e. finished
>    ones), because their output haven't been emitted and we are
>    pretending that they haven't even been started.  If you take this
>    approach, you however may have to include them in N (i.e. still
>    running), but that would likely bump N beyond the maximum number
>    of simultaneous processes.
>
>    The other school of thought would of course tell the truth and
>    include the number of finished background processes in M, as they
>    have finished already in the reality.  This will not risk showing
>    N that is beyond the maximum, but your first "progress" output
>    might say "3 tasks finished", which will make it look odd in a
>    different way.
>
