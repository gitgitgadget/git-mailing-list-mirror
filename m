Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD63C1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 18:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfAVSd1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 13:33:27 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45381 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfAVSd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 13:33:27 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so28509504wrr.12
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 10:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1czVPqRjsiv8cw7vnDuBbXLjwZRfX8hUxORj2LKzHwg=;
        b=qzdub/n7BdkS0HThsPTshyWBOGSovohK/tFB5zbucnZwMPu5lmrm8AFStM/OyvmEgm
         QktCDuYmf2eMzx04DR6wJXdhowHK1xy0LwqS5D414PTjxQuVO8St1dT7hHR31PjqJQ8J
         9IYjpSeLcsQb2yiLiRJ1oZb1vqKPEgZtY7hUkSsS9XCdTboSOq0oqubtVEImojhxIwse
         U052xUkl3pV7xYIgnKUvPVLIk5TD+6tn7UYlpKSJ1sxxOVfiJYR7nlcAqfYwsKixoXmt
         cmuJyOiPs6T1cEyOnn6GpFwNIFJW/Ezxyyqw58sLJUi73gx0qp8Eo5ABlZ9pfpbPRhI9
         jq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1czVPqRjsiv8cw7vnDuBbXLjwZRfX8hUxORj2LKzHwg=;
        b=lCmLwZrS5vXo1oFFmOb82jucR5Cg6WEw2fB9hnha1fC8HU0JUBL8cDCNGwmr46VrIM
         bw2ziiCLPipI3ZCS7fXNa6uRth+7w7uKHEw1q2pgR0/SR3QGmST+4eJIM12L8x8t1chr
         IVfu3wEHTXUnf05aUWVpBpS2oI+5UVpuedj7Y2lo2YY9V0t4gj3MswNWzNXp47hUiyTt
         nQwspBIalOv8kJFxEKc34rq4AT7dXDJCZsg505rZMIqJgkmVx8hCq3bdgBuuXkXRgLGY
         uC2qC4olk+3dy9WBCZRK8g3dGCG544s6YkcJJ7gvygqS2RLbcfhLQ0vqQNt92gOFcBgq
         elmw==
X-Gm-Message-State: AJcUukdxQJrnImUxRza70HrqQB/d5ebV4G+tjA6jm8E8JaLkk5QIAp3g
        rZr+udIYZRNuOPe9oZqkVrQ=
X-Google-Smtp-Source: ALg8bN4G3mSD6zUIM8/VXyxleFLo6TECcEsc7J+fWymv44v5odUHXWK8wAI+OMTlAi7+OyfFDkUcWg==
X-Received: by 2002:adf:8068:: with SMTP id 95mr34621437wrk.181.1548182005259;
        Tue, 22 Jan 2019 10:33:25 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g16sm87408210wru.41.2019.01.22.10.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 10:33:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matthew Kraai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [PATCH 1/1] stash: fix segmentation fault when files were added with intent
References: <pull.110.git.gitgitgadget@gmail.com>
        <b5bbc7793c50991c7cb5a5188f53ccc3a14b23f6.1547805015.git.gitgitgadget@gmail.com>
        <xmqq5zulk88e.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1901211556150.41@tvgsbejvaqbjf.bet>
Date:   Tue, 22 Jan 2019 10:33:24 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1901211556150.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 21 Jan 2019 16:14:52 +0100 (STD)")
Message-ID: <xmqqd0ooh79n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> when I want to see whether a given branch is buggy and when I cannot
> simply `git cherry-pick <commit-demonstrating-a-bug>`:
>
> 	git cherry-pick <commit-fixing-the-bug-and-adding-a-test>
> 	git checkout HEAD^ -- :^/t/

Yup.  It is easy to just apply the t/ part to grab the test update
to see breakage (which I already said when I told you to have a fix
and test protecting the future breakage of the fix in a single patch
long time ago).

