From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] run-command: Remove set_nonblocking
Date: Thu, 5 Nov 2015 11:22:29 -0800
Message-ID: <CAGZ79kZgEtKoYqxa8+wj0PCJedW140CQAPX6XwEYib1W3fPhXw@mail.gmail.com>
References: <1446747439-30349-1-git-send-email-sbeller@google.com>
	<1446747439-30349-2-git-send-email-sbeller@google.com>
	<xmqqpozo5lqg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 20:22:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuQ7J-0005t5-Ci
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 20:22:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbbKETWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 14:22:31 -0500
Received: from mail-yk0-f173.google.com ([209.85.160.173]:34219 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbbKETWa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 14:22:30 -0500
Received: by ykdr3 with SMTP id r3so149147433ykd.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2015 11:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vavjKoo6ok4sSlj0AWtSV93ZIXMarRmtPo7cQn3fueg=;
        b=CWLCJuhqcDdmbnKxpf1ok0aRATlgRDMfZ6pQbs8+JoehM2JXk385apUI3/h0e1hWeg
         VCeK02wvACZBPYbfWNyvZYayuAxAtFf/t/JZYjSaFTwkKAFjKSXUuo4EtIR7n2edeqTX
         KtuDpty8dK8T9okYdGurHDHZcA4GfjR06C7G/g1IR5UcC0UfXKOChapss9ls0LdFhrVX
         1dc50mIMfMRoQEZ9wSapE13t2m8kZm4lImOEktgeOzsj3LGIxT3xo65nDFqyOwoUHG1d
         x+zt+0VIFDNQ52yK454LHO2A3LESsjpUTVA7BtkrbiiNQFFkvnyoy/RxQMikeMPpUpXi
         Cr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vavjKoo6ok4sSlj0AWtSV93ZIXMarRmtPo7cQn3fueg=;
        b=VV94iiZiT3WlDcs4FrmRqcEj6Za10aW2HzM4nyu0hIZZW8r8nJd0UlXYXWjGPwSkQh
         fTDkoiiQAEm9Pbhrv2RRhIaXxJt+u4LkzelaKFxT3JQRWi4P8DYt/anl7jEO9ikFZyR6
         TJoA0XTFO1sSVVMZaR9vn2thKgf0fBLXbE+FJIUosXStpInMWDqN4jrwPFWqC0MWg+f6
         0q6Vak4iMWnDQoJjfzg5w7ykjE9hLLCKCmtqhr+RlJW6b0nEd62aEreSClGoLtquG6I7
         lDqNuCbKkn2D3C1Vv+lKsYQZhCd6IeblzxKM/aSjBrc12SWLPdJWh41K4OWsJO3wsuTq
         FZpA==
X-Gm-Message-State: ALoCoQlSFIO/AmSKYE5e4xl1wngV+hPkdKHbq138VSbdo9qrVdxrOkBSYGE8c3FxRzQMeiRc87yx
X-Received: by 10.13.254.69 with SMTP id o66mr7486244ywf.252.1446751349296;
 Thu, 05 Nov 2015 11:22:29 -0800 (PST)
Received: by 10.37.29.213 with HTTP; Thu, 5 Nov 2015 11:22:29 -0800 (PST)
In-Reply-To: <xmqqpozo5lqg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280935>

On Thu, Nov 5, 2015 at 10:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> strbuf_read_once can also operate on blocking file descriptors if we are
>> sure they are ready. The poll (2) command however makes sure this is the
>> case.
>>
>> Reading the manual for poll (2), there may be spurious returns indicating
>> readiness but that is for network sockets only. Pipes should be unaffected.
>
> Given the presence of "for example" in that bug section, I wouldn't
> say "only" or "should be unaffected".

Reading the documentation we are in agreement, that we expect
no spurious returns, no?

>
>> By having this patch, we rely on the correctness of poll to return
>> only pipes ready to read.
>
> We rely on two things.  One is for poll to return only pipes that are
> non-empty.  The other is for read from a non-empty pipe not to block.

That's what I meant with 'pipe being ready'.

>
>>
>> This fixes compilation in Windows.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> Thanks.  Let's apply these fixes on sb/submodule-parallel-fetch,
> merge the result to 'next' and have people play with it.

Maybe the commit message was weakly crafted. Do you want me to resend?

>
>>  run-command.c | 13 -------------
>>  1 file changed, 13 deletions(-)
>>
>> diff --git a/run-command.c b/run-command.c
>> index 0a3c24e..51d078c 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -1006,17 +1006,6 @@ static void pp_cleanup(struct parallel_processes *pp)
>>       sigchain_pop_common();
>>  }
>>
>> -static void set_nonblocking(int fd)
>> -{
>> -     int flags = fcntl(fd, F_GETFL);
>> -     if (flags < 0)
>> -             warning("Could not get file status flags, "
>> -                     "output will be degraded");
>> -     else if (fcntl(fd, F_SETFL, flags | O_NONBLOCK))
>> -             warning("Could not set file status flags, "
>> -                     "output will be degraded");
>> -}
>> -
>>  /* returns
>>   *  0 if a new task was started.
>>   *  1 if no new jobs was started (get_next_task ran out of work, non critical
>> @@ -1052,8 +1041,6 @@ static int pp_start_one(struct parallel_processes *pp)
>>               return code ? -1 : 1;
>>       }
>>
>> -     set_nonblocking(pp->children[i].process.err);
>> -
>>       pp->nr_processes++;
>>       pp->children[i].in_use = 1;
>>       pp->pfd[i].fd = pp->children[i].process.err;
