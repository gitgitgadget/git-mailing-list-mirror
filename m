From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 06/13] run-command: add an asynchronous parallel child processor
Date: Tue, 22 Sep 2015 14:54:16 -0700
Message-ID: <CAGZ79kZFoTUugFdOuikOBUbg0DG+TJ3tNTuZaCs7WSaa2r7=Bg@mail.gmail.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-7-git-send-email-sbeller@google.com>
	<xmqqfv276z1q.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbUkUSAP+muhYxTwHZdD+ojJYXjogZfRXs0PemEdcqfbA@mail.gmail.com>
	<xmqqtwqm2puk.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYwMrpU-gW6FsbH1W4TRPisZH9GJoyZ6hoimXdxz4HCYQ@mail.gmail.com>
	<xmqqh9mm1690.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 23:54:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeVW2-0003Hd-Ja
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 23:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759667AbbIVVyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 17:54:18 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36780 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759654AbbIVVyR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 17:54:17 -0400
Received: by ykdt18 with SMTP id t18so24096887ykd.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 14:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lbEB7KfLkpoBprAe8l4eMR01SIAmQGppU9crumkYy94=;
        b=T6n27bArh985m2oP2UJ2MK8g5wnq1kLuE8RM8be+Lj+sug5bzeo8NpXDokr5o+/g81
         lQwXEec/zqjYJ2DSwCD8RjEi+V6QBeEyUg0DBdMm0vkmSJt5e01zwzG+nMkUCG+pM1FS
         eMDG0yg+KMNAFQcHbf/Y8ALyDU6PsW6wr6Olb+y7gMVt4Mqdzs2Rn2f/asRs+olUAIoq
         u9IeKk3MX205XxRwsk9oX2Tkijh9IHiyNTH1MBUIXvL3Mvjl64u4sK6RjCxqOoF6bI1t
         t5hp6+dNBea5UW4KM7WDScMrJDQXG+GhIliq6SSPiMFLW2pk+dBN/kNi1BexmSptvi5E
         KIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=lbEB7KfLkpoBprAe8l4eMR01SIAmQGppU9crumkYy94=;
        b=CfbSSp4r0VO1ts9Gy8/W5GvzQzjInPZk8qiN/sGh3DS64gT5Xw2MDKGRhkoKBN7Y6O
         3Gx5Y9voou+nB9ACATVjZRLcu49CR/hqu14Mrb72C0+7wHW91zFcPQL1CvnrkT1d+Kow
         BdjFmlwoP2VOGu6+kzzl2vIl1l/FVnr7jCcqQGGPK2IAuU5ED/uO9vMeFE3JvjXPoWrK
         lj6RQpUTF2Z1r6GwXB3Abq8WX2m9/jTNDuhr281+9cBGnTFi1QKeGMaSGy+2tE1zZCwI
         cxk9muiLBNzs3V33jRINxY9zPvS4SKP7HL/rTQtrGvQ+88+ijQYiCa0wWyeJnqgEfn9q
         Dong==
X-Gm-Message-State: ALoCoQl3NJmHGgzV6fw4BFDwKubTdE4W8yWT3Ud0wFgFZ94wKZ7AQeaCd9u/fdPAD30QP6C9cZis
X-Received: by 10.170.190.133 with SMTP id h127mr23501437yke.115.1442958856365;
 Tue, 22 Sep 2015 14:54:16 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Tue, 22 Sep 2015 14:54:16 -0700 (PDT)
In-Reply-To: <xmqqh9mm1690.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278443>

On Tue, Sep 22, 2015 at 2:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Tue, Sep 22, 2015 at 12:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>> So how would you find out when we are done?
>>>
>>>         while (1) {
>>>                 if (we have available slot)
>>>                         ask to start a new one;
>>>                 if (nobody is running anymore)
>>>                         break;
>>>                 collect the output from running ones;
>>>                 drain the output from the foreground one;
>>>                 cull the finished process;
>>>         }
>>>
>>
>> Personally I do not like the break; in the middle of
>> the loop, but that's personal preference, I'd guess.
>> I'll also move the condition for (we have available slot)
>> back inside the called function.
>>
>> So I am thinking about using this in the reroll instead:
>>
>>     run_processes_parallel_start_as_needed(&pp);
>>     while (pp.nr_processes > 0) {
>>         run_processes_parallel_buffer_stderr(&pp);
>>         run_processes_parallel_output(&pp);
>>         run_processes_parallel_collect_finished(&pp);
>>         run_processes_parallel_start_as_needed(&pp);
>>     }
>
> If you truly think the latter is easier to follow its logic (with
> the duplicated call to the same function only to avoid break that
> makes it clear why we are quitting the loop,

I dislike having the call twice, too.

> and without the
> explicit "start only if we can afford to"), then I have to say that
> our design tastes are fundamentally incompatible.

Well the "start only if we can afford to" is not as easy as just

>                 if (we have available slot)
>                         ask to start a new one;

because that's only half the condition. If we don't start a new one
as the callback get_next_task returned without a new task.
So it becomes

    while (pp.nr_processes > 0) {
        while (pp->nr_processes < pp->max_processes &&
                start_one_process(&pp))
                        ; /* nothing */
        if (!pp.nr_processes)
            break;
        buffer(..);
        output_live_child(..);
        cull_finished(..);
    }

I'll think about that.
