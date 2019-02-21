Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A4321F453
	for <e@80x24.org>; Thu, 21 Feb 2019 17:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbfBURxW (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 12:53:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39782 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfBURxW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 12:53:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id z84so10134623wmg.4
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 09:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eEZiRjKfpGHXfUzOAqCqANR2Bk0LFsAwE3FM5zzy11E=;
        b=Wtrzj3lv5FLxymCHi4Csg9D4mTgDLREB/uRDTynU2OY4VCJ3A8joS/dNtcDV54Wysh
         Y7b9jG/jhxMIhD5a0j/93zEk1EOAAJhGBC9cJVl5ld9kXDYFZkVbt8KZtWfBqt/qWWTs
         AM1QMP7s6836/VQhJC4b+ohms8SASUI35gJh5f74KmUlq8uLVhlR3Ir07+unDBqp3L3x
         zfMOyoGVZqDo/XViH9vfyyOcG0eZRoc6dfLLf2YxE9APLeXIo5b4JLr4UIrnoJwIuMGa
         daVY1t4tJDzV0tYSzRtsAp5Y2myTK8fnBlqfiAhPXtIN0odhzUxqqFy1mkgCc0raAYdt
         6iRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=eEZiRjKfpGHXfUzOAqCqANR2Bk0LFsAwE3FM5zzy11E=;
        b=t5wrDJ7zLH44tmJxcnFwiXqGNlnR0F8UavG4NFMyjhHiTcoiKcwzcZcaKurB2LlsVF
         hr+PDkSiKQ7oNd1ZyNbpfnhiL0jwvQGiOxR8fwq2i9qtq8QK9QfDuSd7Za80+gYjHRdc
         7p91Qal8oQ0qLXp3ayxO0lc9WlKdhDXU8IGlGZlFOGk3DNqFjGlG8wmyACnWD13sCj6E
         jHvcxy/dDV/9OvsbXf+gXue1bhgXWLBk6HQpKlYDOzjkM7lQugdoRS5PjSgUdGHvV6Nc
         tgpj2MT89v4WT8/OyHIa07f1OAwWEAI2EYxq/MwAScYZnGYMqKF45mRIot5uONwgbVrz
         MmEQ==
X-Gm-Message-State: AHQUAuYjgdl/Ii5Gz2ormndG6zl22Jfem56FGrFTyYA9uS3t1bc8AeR0
        dYvJ5//zjnvQKL5dKPH0kWUJSMqK
X-Google-Smtp-Source: AHgI3IZy7MVdMPTGcs3AdV7jq9yWomgoJKM1yueDZysfN4qh9vDm4mNUIBaezSi7hULMO49lzBfXRQ==
X-Received: by 2002:a1c:f613:: with SMTP id w19mr11265884wmc.0.1550771599919;
        Thu, 21 Feb 2019 09:53:19 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a9sm7404050wmm.10.2019.02.21.09.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 09:53:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Daniel Ferreira <bnmvco@gmail.com>,
        Slavica Djukic <slawica92@hotmail.com>
Subject: Re: [PATCH v5 01/10] diff: export diffstat interface
References: <pull.103.v4.git.gitgitgadget@gmail.com>
        <pull.103.v5.git.gitgitgadget@gmail.com>
        <d839f0c082ece5298647f8dfbfd0566d59c58172.1550662887.git.gitgitgadget@gmail.com>
Date:   Thu, 21 Feb 2019 09:53:18 -0800
In-Reply-To: <d839f0c082ece5298647f8dfbfd0566d59c58172.1550662887.git.gitgitgadget@gmail.com>
        (Daniel Ferreira via GitGitGadget's message of "Wed, 20 Feb 2019
        03:41:29 -0800 (PST)")
Message-ID: <xmqq4l8xuiy9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -6001,12 +5985,7 @@ void diff_flush(struct diff_options *options)
>  	    dirstat_by_line) {
>  		struct diffstat_t diffstat;
>  
> -		memset(&diffstat, 0, sizeof(struct diffstat_t));
> -		for (i = 0; i < q->nr; i++) {
> -			struct diff_filepair *p = q->queue[i];
> -			if (check_pair_status(p))
> -				diff_flush_stat(p, options, &diffstat);
> -		}
> +		compute_diffstat(options, &diffstat);
>  		if (output_format & DIFF_FORMAT_NUMSTAT)
>  			show_numstat(&diffstat, options);
>  		if (output_format & DIFF_FORMAT_DIFFSTAT)

In the post-context of this hunk there are series of "if we are
showing this kind of diffstat, pass &diffstat to a helper that shows
it" calls, and this piece of code itself is guarded by "if we are
showing any of these kinds of diffstat, enter this block".  So a
helper function that computes necessary data in &diffstat upfront
does make sense and makes the code readable quite a lot.

But...


> +void compute_diffstat(struct diff_options *options, struct diffstat_t *diffstat)
> +{
> +	int i;
> +	struct diff_queue_struct *q = &diff_queued_diff;

... as a reusable helper, it would make a saner API if you did not
to hardcode the dependency to the singleton diff_queued_diff
(i.e. instead, pass a pointer to struct diff_queue_struct as a
parameter---the caller has it as 'q' at the callsite).

Other than that, makes sense to me; thanks.

Here is a meta question, which is mostly meant to those who use
gitgitgadget@.  The person who wanted to send this copy of the patch
this time (i.e. Slavica, not Daniel) is not shown anywhere on the
header of the e-mail, so the response to the message will not go to
Slavica at all, even though it probably is visible by monitoring
where gitgitgadget@ delivers (i.e. the PR comments).

Is that desirable as a reviewee?  I manually added Slavica's address
taken from the S-o-b: line to this response just in case, but if it
is not desirable, I'll stop doing so.

Thanks.



