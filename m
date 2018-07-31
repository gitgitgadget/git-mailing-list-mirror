Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9BBD1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 15:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbeGaREX (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 13:04:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37072 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeGaREX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 13:04:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id n11-v6so3594214wmc.2
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 08:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lCh+vfgpR1Gqkv1F6SM9q45CQrVu5eOwwZxvfWmJQ4w=;
        b=JvhSj4oB/fDr+KBn3fonyYdPSZvaUM+xA1sRcvRVMo9JQhZ7ZczKHNOhHQnEQPbTVU
         y5Aom2ARPB1qR790G72HkBrABAT2BCdasTuI2IxGzXAch7nWz1mdGTcMcmuz4k4dpWt8
         oqpQsy77QIwNgF71hMeNqOMTZo40uUM1yMdl0KRIZwj8yQd8LX35RYCXu7J/LzjHltEI
         YEVekPW7l1NUv61ZDMrhgNU3cvSv3TjmbIflaZpWDTWWHdjhpv5Xl6cifIf/dnNotHGN
         V1jJL0a1jIdB2Z1O6cgZyb29NqSc5MjWN525BrPcqsbMMajTJEi6AC5DHINClC+Ta4bP
         21Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=lCh+vfgpR1Gqkv1F6SM9q45CQrVu5eOwwZxvfWmJQ4w=;
        b=Tv/XXiOvIuNdlwtJzWh0uSqFBfYNovQ7lYdKIjBs4FL+iJFqT43gdKqHnMvCmOaRMk
         CZ0iwuadc4cUJEYViKLPRYVI001euey0UcpNZoUT54jWJ2qoGNK2F/CbkBCfDB8SldsG
         LrYJhS4/LABAEHM34IHdkEnl/tmIdAIirVufGwvsSNBV3Hf+GIXgoDt5JN6tLPThnQkj
         DhtHbChoYF2X+s2rFVHjg7fSd832nzbf6AQs1QXM/UUqgiXeACXF0hTrMRaJd5jPugyW
         b27qgMaWjlyx7t7RcAmfUJSMQsaT+QSEfzdQdNwJAUg5SDWOJ/YPIRFnPi3FGyXPiFYw
         o3Ew==
X-Gm-Message-State: AOUpUlHDi732ArfPm0d9UyCEjfy9q/rleKZXpzlXyA/vC1wA49LH+5zQ
        BQjpeDsXkOCQIi0s+vMyukU=
X-Google-Smtp-Source: AAOMgpeiZbOlM7S6GHtE5euYBc9x++IDD25XXnsupjHixbdec9ifXVM11/EPiUOo/BYYPiwDBCdHPw==
X-Received: by 2002:a1c:6709:: with SMTP id b9-v6mr116005wmc.68.1533050613034;
        Tue, 31 Jul 2018 08:23:33 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v23-v6sm13350111wrd.11.2018.07.31.08.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 08:23:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [GSoC][PATCH v4] fixup! rebase -i: rewrite write_basic_state() in C
References: <20180730182516.32644-1-szeder.dev@gmail.com>
        <20180731121115.12296-1-alban.gruin@gmail.com>
Date:   Tue, 31 Jul 2018 08:23:31 -0700
In-Reply-To: <20180731121115.12296-1-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 31 Jul 2018 14:11:15 +0200")
Message-ID: <xmqqy3drctu4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> As pointed out by SZEDER Gábor, git-rebase.sh wrote to to 'quiet' with
> an `echo`:
>
>     echo "$GIT_QUIET" > "$state_dir/quiet"
>
> This mean that even if $GIT_QUIET is empty, a newline is written to
> quiet.  The rewrite of write_basic_state() changed this behaviour, which
> could lead to problems.  This patch changes the rewritten version to
> behave like the shell version.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
> Hi Junio, could you apply this patch on top of ag/rebase-i-in-c, please?

Hmph, from reading your other message

  https://public-inbox.org/git/dce8c99b-51e9-4ed1-8ae4-28049cb6e7ec@gmail.com/

I got an impression that a rerolled version is coming anyway.  Is
this fix so urgent that it needs tobe squashed in in the meantime
and cannot wait?

>
>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index d257903db0..0d41e82953 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2332,7 +2332,7 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
>  	if (quiet)
>  		write_file(rebase_path_quiet(), "%s\n", quiet);
>  	else
> -		write_file(rebase_path_quiet(), "");
> +		write_file(rebase_path_quiet(), "\n");
>  
>  	if (opts->verbose)
>  		write_file(rebase_path_verbose(), "");
