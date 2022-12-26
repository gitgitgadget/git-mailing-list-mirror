Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621EDC4167B
	for <git@archiver.kernel.org>; Mon, 26 Dec 2022 01:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiLZBc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Dec 2022 20:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLZBcz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2022 20:32:55 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F9D26F9
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 17:32:54 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v23so9563991pju.3
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 17:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mq9/xGibAAQx6OL1E87aXX+bd/Gb98xQScQDSrYQ57w=;
        b=ILL6rG32jwGqSRJ+zgNZpiEd3Fzdb95Z9ZySXcuQsihE3x03eg75Ig/qczmiq8gwZW
         3H+ILva1486i7vejF6UUjcXSm8rGICEixp+fqrVBneApq0f6IlSiuahEglQmYsqobFcK
         MTpHrZku10vJByLOWXgHR0tw1k8W2mI3a90uiIxarbwZ/5YsV6CRT8fKqjzooFckTf5W
         OwrA5JC3L6M73/zyz2endwEkWmiuIOJrsUAnmXMWkJvvTYHY8dXUYLVA9uX/oRECDaaS
         FouNnOw8Pan8ZQGuLC+Jn0gxwt1sEJEKVTfGOP0VFfKjLkvFQv9p07ONU3h7gvgs9Y2A
         YLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mq9/xGibAAQx6OL1E87aXX+bd/Gb98xQScQDSrYQ57w=;
        b=gT6J4l7XbENPTa3PUhM1H9y9j9EkIo3O7t1nKd8tCQobf0EGvbovIkchIg/giOxds+
         eEMkxhM9Kgt53KM2gYbGM0KyBXGLHDPUzwf0VVZkD5lQTCxz1MGkzSksW/DW+cryUifz
         LCXPcaOMxG6eQL9wQ49shIdsTO0OY1uFqbg/RDlFTAmRjVRSW6TCcsm7ugXAsORi87jh
         AgwD4V/oZEmbSdiwnofPmaMXk0vSeXYZ/PcMHq5BjL00GWhRTNVXJTZ3O9+FlYpfexLD
         kP68G4uZO23PB/txybH7w8HPc1Pz0DTwI68oeONzgyCeTrmZ+5/7lzcFx/Ix8N0G0Uls
         RApg==
X-Gm-Message-State: AFqh2koYXtrO9I1TneaCpK+LAVbg4dJnpMoJfGvctCGzld/DN8EcI+tr
        GGEDvUjMbzrNOcZVUT2VfsoeXDYGmsg3Bg==
X-Google-Smtp-Source: AMrXdXuuMy/xttU3kH8CflmawxDv5uBHbY5i8Qc4U7ntysmCliiupuQ18PvTEGa9Bg6QishKPHOMDA==
X-Received: by 2002:a05:6a21:6d88:b0:af:8ff3:fc80 with SMTP id wl8-20020a056a216d8800b000af8ff3fc80mr29252545pzb.20.1672018373963;
        Sun, 25 Dec 2022 17:32:53 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q1-20020aa79821000000b005747b59fc54sm5937891pfl.172.2022.12.25.17.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 17:32:53 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH v12 1/2] win32-pthread: prepare pthread.c for change by
 formatting
References: <pull.1406.v11.git.git.1671823177.gitgitgadget@gmail.com>
        <pull.1406.v12.git.git.1671932405.gitgitgadget@gmail.com>
        <e0cc43efc6c498706559ae4fc71c597a6481f64c.1671932405.git.gitgitgadget@gmail.com>
Date:   Mon, 26 Dec 2022 10:32:53 +0900
In-Reply-To: <e0cc43efc6c498706559ae4fc71c597a6481f64c.1671932405.git.gitgitgadget@gmail.com>
        (Seija Kijin via GitGitGadget's message of "Sun, 25 Dec 2022 01:40:04
        +0000")
Message-ID: <xmqqmt7blzju.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  int pthread_create(pthread_t *thread, const void *unused,
> -		   void *(*start_routine)(void*), void *arg)
> +		   void *(*start_routine)(void *), void *arg)

Good.

>  {
>  	thread->arg = arg;
>  	thread->start_routine = start_routine;
> -	thread->handle = (HANDLE)
> -		_beginthreadex(NULL, 0, win32_start_routine, thread, 0, NULL);
> +	thread->handle = (HANDLE)_beginthreadex(NULL, 0, win32_start_routine,
> +						thread, 0, NULL);

I would say this is good either way---preimage may slightly be
easier to read, but it is not worth a patch churn.

> -	DWORD result = WaitForSingleObject(thread->handle, INFINITE);
> -	switch (result) {
> -		case WAIT_OBJECT_0:
> -			if (value_ptr)
> -				*value_ptr = thread->arg;
> -			return 0;
> -		case WAIT_ABANDONED:
> -			return EINVAL;
> -		default:
> -			return err_win_to_posix(GetLastError());
> +	switch (WaitForSingleObject(thread->handle, INFINITE)) {
> +	case WAIT_OBJECT_0:
> +		if (value_ptr)
> +			*value_ptr = thread->arg;
> +		return 0;
> +	case WAIT_ABANDONED:
> +		return EINVAL;
> +	default:
> +		return err_win_to_posix(GetLastError());
>  	}
>  }

Loss of a single-use variable is, strictly speaking, a "while at it"
change that has nothing to do with "reformatting", but otherwise the
result of the hunk looks good.

Will queue.

Thanks.



P.S.  An address that is designed to bounce or sent to black hole
appears on the CC: of the original e-mail message.  Can you stop
doing that (or is that what GGG does without user's control)?

  Rose <83477269+AtariDreams@users.noreply.github.com>
