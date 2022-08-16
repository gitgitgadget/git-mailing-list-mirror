Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86FBC25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 21:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbiHPV5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 17:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237686AbiHPV5G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 17:57:06 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11AB883EF
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 14:57:04 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v4so6075689pgi.10
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 14:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=3ErVfhoWdThbA77zR5rGCnVsWArLQZOSYzdW/WgL7Ok=;
        b=eoa/KXr8b7Xx6RnXBCviwZTTt6QAFv1VG2Xn8UxPMPZyo59zSpyyczJjNfVL09gaOV
         1U3R76bGQ4dWZ310sp7UGOC6qqa1mN+fE/ye6vbwOyH7pbFhY7z6Zt8EFHCt9qL6F8Zd
         uAMLj/M5B9aybVtxB1t8eId40vfZu/ZfKD/M3yWEq3wBaD378U6UAL0p4CpkD3XvWTyr
         ab6yRka2MmzweJDDm88ZvStVcTVAITz56VfR9MzjslDgd4e/AIvXgDe4Qq0AN16qVq1e
         Cw8d1YNBaT/6wybzGxRUre+d8aLxN2eHRIRFKpaH7uQHioeAeGd2ySDbdCr7puhdA84+
         2R1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3ErVfhoWdThbA77zR5rGCnVsWArLQZOSYzdW/WgL7Ok=;
        b=LrTVZGHL0KIUenTOoahy0y/rEP6GEyQewlwBAG8c+xw2TVViBs+RrOObtSIMQyMMm0
         XDLjUkt0s4osLccqbUhd/+fVNvmrf6G/G4esBEsxvdQZc51Kzrco58phgWafsWZUfYLZ
         0q21H40/jNXzb/lWQMNExz+SZLrkM/WMtR1Z57bRarse5skcNk0XfH0h5DC/k7JlOFw4
         ioQrkkDE5W1dllw1mSdHPAwyAfuoW53BBBiEo7VkYmhaZQuwfdxyMkw3zhF0BMdO6PJc
         D4SiZV6aINCaqd4aylFucF3KloEiBbR4Dnz43iJh6xvMK55r1GbdOLzmUF9SqQXTpwQC
         sodg==
X-Gm-Message-State: ACgBeo0NV1816meXzTCozmiieW1WPbVknxJexE0v2kL/XdY3+uXyOrii
        q9zyNN656FzeoR7gBXhnWwo0
X-Google-Smtp-Source: AA6agR6bOjGYAXA9aedDgfzXmSB+rDR448lFt++ACkD5oa0YdCJpk4LFzL7FiL3qq7xIOoEhqBrf1g==
X-Received: by 2002:a63:87c7:0:b0:41d:dcc3:20ef with SMTP id i190-20020a6387c7000000b0041ddcc320efmr18997831pge.583.1660687024181;
        Tue, 16 Aug 2022 14:57:04 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902bf4a00b0016c16648213sm9556029pls.20.2022.08.16.14.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 14:57:03 -0700 (PDT)
Message-ID: <f766b31f-2f0c-316a-a445-407b8c5baddc@github.com>
Date:   Tue, 16 Aug 2022 14:57:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] scalar: enable built-in FSMonitor on `register`
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        mjcheetham@outlook.com
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
 <62682ccf6964d6eebb67491db4a9476dbab56671.1660673269.git.gitgitgadget@gmail.com>
 <xmqq4jybud6h.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqq4jybud6h.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
>> +static int start_fsmonitor_daemon(void)
>> +{
>> +	int res = 0;
>> +	if (fsmonitor_ipc__is_supported() &&
>> +	    fsmonitor_ipc__get_state() != IPC_STATE__LISTENING) {
>> +		struct strbuf err = STRBUF_INIT;
>> +		struct child_process cp = CHILD_PROCESS_INIT;
>> +
>> +		/* Try to start the FSMonitor daemon */
>> +		cp.git_cmd = 1;
>> +		strvec_pushl(&cp.args, "fsmonitor--daemon", "start", NULL);
>> +		if (!pipe_command(&cp, NULL, 0, NULL, 0, &err, 0)) {
>> +			/* Successfully started FSMonitor */
>> +			strbuf_release(&err);
>> +			return 0;
>> +		}
>> +
>> +		/* If FSMonitor really hasn't started, emit error */
>> +		if (fsmonitor_ipc__get_state() != IPC_STATE__LISTENING)
>> +			res = error(_("could not start the FSMonitor daemon: %s"),
>> +				    err.buf);
>> +
>> +		strbuf_release(&err);
>> +	}
>> +
>> +	return res;
>> +}
> 
> This somewhat curious code structure made me look, and made me
> notice that the behaviour is even more curious.  Even though
> pipe_command() fails, fsmonitor_ipc__get_state() can somehow become
> LISTENING, in which case we are OK?  If that is the case, a more natural
> way to write it would be:
> 
> 	int res = 0; /* assume success */
> 
> 	if (fsmonitor_ipc__is_supported() &&
>             fsmonitor_ipc__get_state() != IPC_STATE__LISTENING) {
> 		...
>                 /* 
>                  * if we fail to start it ourselves, and there is no
>                  * daemon listening to us, it is an error.
>                  */
> 		if (pipe_command(...) &&
> 		    fsmonitor_ipc__get_state() != IPC_STATE__LISTENING)
> 			res = error(...);
> 		strbuf_release(&err);
> 	}
> 	return res;
> 
> and that would utilize "res" consistently throughout the function.
> 
> Note that (I omitted unnecessary blank lines and added necessary
> ones in the above outline of the rewrite.
> 
> Stopping, stepping back a bit and rethinking, the above is not still
> exactly right.  If pipe_command() could lie and say "we failed to
> start" when we immediately after the failure can find a running
> daemon, what guarantees us that pipe_command() does not lie in the
> other direction?  So, in that sense, perhaps doing
> 
> 	/* we do not care if pipe_command() succeeds or not */
> 	(void) pipe_command(...);
> 
>         /*
>          * we check ourselves if we do have a usable daemon 
>          * and that is the authoritative answer.  we were asked
>          * to ensure that usable daemon exists, and we answer
>          * if we do or don't.
>          */
> 	if (fsmonitor_ipc__get_state() != IPC_STATE__LISTENING)
> 		res = error(...);
> 
> may be more true to the spirit of the code.

This is an unintentional artifact of some minor refactoring of the original
versions in 'microsoft/git'. Previously [1], there was no
'fsmonitor_ipc__get_state()' check before calling 'git fsmonitor--daemon
start', so we'd expect failures whenever FSMonitor was already running. To
avoid making that 'pipe_command()' call when FSMonitor was already running,
I added an earlier call to 'fsmonitor_ipc__get_state()'. But, because I
didn't remove the later check, the code now implies that 'pipe_command()'
may give us "false negatives" (that is, fail but still manage to start the
FSMonitor).

I left the extraneous check in to be overly cautious, but realistically I
don't actually expect 'git fsmonitor--daemon start' to give us any false
positives or negatives. The code should reflect that:

	int res = 0;
	if (fsmonitor_ipc__is_supported() &&
	    fsmonitor_ipc__get_state() != IPC_STATE__LISTENING) {
		struct strbuf err = STRBUF_INIT;
		struct child_process cp = CHILD_PROCESS_INIT;

		/* Try to start the FSMonitor daemon */
		cp.git_cmd = 1;
		strvec_pushl(&cp.args, "fsmonitor--daemon", "start", NULL);
		if (pipe_command(&cp, NULL, 0, NULL, 0, &err, 0))
			res = error(_("could not start the FSMonitor daemon: %s"),
				    err.buf);

		strbuf_release(&err);
	}

	return res;

I'll re-roll with this shortly.

[1] https://github.com/microsoft/git/commit/4f2e092d3c98

> 
> It also is slightly curious if the caller wants to see "success"
> when fsmonitor is not supported.  I would have expected the caller
> to check and refrain from calling start/stop when it is not
> supported (and if there is an end-user interface to force the scalar
> command to "start", complain by saying "not supported here").  But
> as long as we are consistent, I guess it is OK.

I don't mind moving the 'fsmonitor_ipc__is_supported()' checks into
'register_dir()' and 'unregister_dir()'; I can see how it makes more sense
with the existing function name. 

As a side note, though, while looking at where to move the condition I
noticed that 'unregister_dir()' doesn't handle positive, nonzero return
values properly. I'll fix this & move the 'fsmonitor_ipc__is_supported()'
check in the next version. Thanks!

> 
> The side that stops shares exactly the same two pieces of
> "curiosity" and may need to be updated exactly the same way.  It
> assumes that pipe_command() is unreliable and instead of reporting a
> possible failure, we sweep that under the rug, with a questionable
> "we do not care about pipe failing, as long as the daemon is
> listening, we do not care" attitude.  And the caller does not care
> "start" not stopping where it is not supported.
> 
> Thanks.

