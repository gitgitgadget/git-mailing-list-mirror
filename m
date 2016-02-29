From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv19 00/11] Expose submodule parallelism to the user
Date: Mon, 29 Feb 2016 13:06:53 -0800
Message-ID: <CAGZ79kY5nxDQ_o0L_MOYFOx4FPH1apW-TuB88UypuwDaLuKGNQ@mail.gmail.com>
References: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
	<1456444119-6934-1-git-send-email-sbeller@google.com>
	<56D4AE8A.2050403@kdbg.org>
	<xmqq1t7v9qou.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 22:07:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaV1v-0000jJ-SW
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 22:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbcB2VGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 16:06:55 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:36650 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbcB2VGy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 16:06:54 -0500
Received: by mail-io0-f178.google.com with SMTP id l127so200646687iof.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 13:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=deDYsmq1OwT5+hWn/OS32IEOYiJC9oDIvMHiT5PZSkU=;
        b=ntv2HSVebeM9ZcaxiG/BD/9RKVjfoJsSg88XQ10WKuN2CR0AIvdjqBFHqlIY82xx2K
         qY1yjQDSzL+cCAOFAe/ugN7RN6mON9VwTOtst95N3COzALhnMefGaOiv5BQpg7HyD3Mf
         7Y6Qul1Aocn7BARTObv1tojonVwzyvT1sMfJktRHVsLs1GFGkrxCcJPkvMGMSW9MRvJr
         Es76LP5zhezSEY42coNfLFowfPSpNbLBCf+vHQeNfPpSgHYNnHdLR1u9H1R+1jjPvy8C
         eATdzyALpnEBpaGewZmk7VfBjjaSCJwku8FICQ+cz4tlWPSZgTh0Km8Y/Jw6j9XZNsZ3
         F0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=deDYsmq1OwT5+hWn/OS32IEOYiJC9oDIvMHiT5PZSkU=;
        b=XDN+gAIfDcLxc7HwkjvFnm8xwm3L4pAAS9gcm58OB9UtRh156PneJJtqPm8DnX5qs3
         re/xQhMJ2B6m0XsKWCizzXsyWZ+lN9OyO3nt1hCK4O9K91+lWxfjfS76s/mNSpBmKz15
         4saH2Ot+JQrZGKwIxEgxsrHYxft0UwisTJJahHt3gVbx6uDLXXkMn8Om3kbu7LIFFoP6
         ao9KktiDXWDDmi7GB3AxETlxLeO2XR0L4go+bfa7urZJWdsTKr9V4OXTac33XNgXBV+2
         ndpOGh+J9jN9YT+bvpnXn1yIeuXnAGQh3O2yhzPbqdNSmDl2cnw4cQSrqBOSon/AtiQF
         omYg==
X-Gm-Message-State: AG10YOQTsvApfww5r+uqgSG632APf5D+pU6nRBmi6HU62Jv/RYZwsBOxjC4q34X8p6nhErrGpW6K8tmB0oeoZ0hv
X-Received: by 10.107.158.138 with SMTP id h132mr20539288ioe.174.1456780013652;
 Mon, 29 Feb 2016 13:06:53 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Mon, 29 Feb 2016 13:06:53 -0800 (PST)
In-Reply-To: <xmqq1t7v9qou.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287902>

On Mon, Feb 29, 2016 at 1:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> The culprit seems to be default_task_finished(), which accesses argv[]
>> of the struct child_process after finish_command has released it,
>> provided the child exited with an error, for example:
>
> Thanks for a report.
>
>> ==3395== Invalid read of size 8
>> ==3395==    at 0x54F991: default_task_finished (run-command.c:932)
>
> That one and also start_failure() do run after child_process_clear()
> has cleaned things up, so they shouldn't be looking at argv[] (or
> anything in that structure for that matter).

I am undecided if easy access to the child process struct
is a benefit or not for the callback. It makes error reporting
easy, but maybe hacky as you poke around with the argv.

Maybe we want to remove the struct child_process from the
function signature of the callbacks and callbacks need to rely on
the data provided solely thru the pointer as passed around for
callback purposes, which the user is free to use for any kind
of data.

As a rather quickfix for 2.8 (and 2.7) we could however just
breakup the finish_command function and call child_process_clear
after the callbacks have run.

>
>
>
>> ==3395==    by 0x49158F: update_clone_task_finished (submodule--helper.c:421)
>> ==3395==    by 0x5504A2: pp_collect_finished (run-command.c:1122)
>> ==3395==    by 0x5507C7: run_processes_parallel (run-command.c:1194)
>> ==3395==    by 0x4918EB: update_clone (submodule--helper.c:483)
>> ==3395==    by 0x4919D8: cmd_submodule__helper (submodule--helper.c:527)
>> ==3395==    by 0x405CBE: run_builtin (git.c:353)
>> ==3395==    by 0x405EAA: handle_builtin (git.c:540)
>> ==3395==    by 0x405FCC: run_argv (git.c:594)
>> ==3395==    by 0x4061BF: main (git.c:701)
>> ==3395==  Address 0x5e49370 is 0 bytes inside a block of size 192 free'd
>> ==3395==    at 0x4C2A37C: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
>> ==3395==    by 0x4A26EE: argv_array_clear (argv-array.c:73)
>> ==3395==    by 0x54DFC4: child_process_clear (run-command.c:18)
>> ==3395==    by 0x54EFA7: finish_command (run-command.c:539)
>> ==3395==    by 0x550413: pp_collect_finished (run-command.c:1120)
>> ==3395==    by 0x5507C7: run_processes_parallel (run-command.c:1194)
>> ==3395==    by 0x4918EB: update_clone (submodule--helper.c:483)
>> ==3395==    by 0x4919D8: cmd_submodule__helper (submodule--helper.c:527)
>> ==3395==    by 0x405CBE: run_builtin (git.c:353)
>> ==3395==    by 0x405EAA: handle_builtin (git.c:540)
>> ==3395==    by 0x405FCC: run_argv (git.c:594)
>> ==3395==    by 0x4061BF: main (git.c:701)
>>
>> I haven't thought about a solution, yet. Perhaps you have ideas.
>>
>> -- Hannes
