Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49A19203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 18:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932209AbdGXSDk (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 14:03:40 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:37143 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753142AbdGXSDR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 14:03:17 -0400
Received: by mail-pg0-f52.google.com with SMTP id y129so60181360pgy.4
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 11:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ay2mmWnpXpZCdRgrZzQWqa7DKnNHvhiOqL/vvh+8Zw=;
        b=X+Hi4GYbXP1qZCXudOOiIRZ6AJS5AZsw/+gihfkfUuJZ+O5iYAVzYOaftVaqa3vDWD
         LpgjSNsc9G+KrudRGMr+rNGWF+MqS7/tuPem9q7V7VmBUK2c/65lYYaQHrjhOtPLzxFV
         wpE4jkr1wU4nX/Ho+eeHT4EU+naXKguc8E1njrDErWvrkuzw6ONt/b+mQJCpvAAn/qPw
         5LX3BlYLz1pkzi08WHE7Yg+CQeM2GCFQdhYHaFoB/9pXvhUBcIRtau1Sk3rOitGnFp4L
         63+SRVdsmS7Inq/a7yeKVlC3fLGS86y+S233+Abcgr3A2M2At4kdhVjdhxvKvnAbe/UN
         iIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ay2mmWnpXpZCdRgrZzQWqa7DKnNHvhiOqL/vvh+8Zw=;
        b=P+aV1BpOqqCjyPqJT8OeRP+nLir7OBGwzUupWaRanetE+mtSXwLtwB1sCtLnZSolGc
         Fp/Ouka6pPveGIBVMtyQae0DXKt4/viCapbnT1ktLO3OpOr8JiG23mOGYJeSG4F+czJY
         PJGe+NRBAehuf15SrwjyDoJLNw6rf8obdwaYK5aD5PxU6PuvRRFVqMGrilo2ffQ/lsxC
         ld3SuYQsSPgZ55qePnoSdAVvrHYm+v/jWkiVWP1te3YohNTNULUbUXfOchaQQpERnlrp
         5vy2b9VOni6BnRb8Uu/C/pfFn353UeLafDxGbTkQSRzXQLaph+zglhMz8gMGSvuTPUKk
         qMNA==
X-Gm-Message-State: AIVw111FaunaVmnMKH79SJk/jEsVFA0cVOha8Dqoc1Nqd+9Pkm+21OJm
        xvQE/5N3uPu4LisjAwA=
X-Received: by 10.84.247.1 with SMTP id n1mr18594017pll.314.1500919396158;
        Mon, 24 Jul 2017 11:03:16 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:14ca:cb2b:befe:703a])
        by smtp.gmail.com with ESMTPSA id z15sm20327118pfl.125.2017.07.24.11.03.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 11:03:14 -0700 (PDT)
Date:   Mon, 24 Jul 2017 11:03:12 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] recursive submodules: detach HEAD from new state
Message-ID: <20170724180312.GE13924@aiede.mtv.corp.google.com>
References: <20170724173601.19921-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170724173601.19921-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> When a submodule is on a branch and in its superproject you run a
> recursive checkout, the branch of the submodule is updated to what the
> superproject checks out. This is very unexpected in the current model of
> Git as e.g. 'submodule update' always detaches the submodule HEAD.
>
> Despite having plans to have submodule HEADS not detached in the future,
> the current behavior is really bad as it doesn't match user expectations
> and it is not checking for loss of commits (only to be recovered via the
> reflog).

I think the corrected behavior doesn't match user expectations,
either.

Could this patch include some documentation to help users know what to
expect?

> Detach the HEAD unconditionally in the submodule when updating it.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> This is a resend of [1], which did not receive any attention.

Yikes.  Yes, this bug looks problematic.  Thanks for working on it.

> I improved the commit message laying out the current state of affairs,
> arguing that any future plan should not weigh in as much as the current
> possible data loss.

Can you elaborate on what you mean about data loss?  At first glance
it would seem to me that detaching HEAD could lead to data loss since
there isn't a branch to keep track of the user's work.  Are you saying
the current behavior of updating whatever branch HEAD is on (which,
don't get me wrong, is a wrong behavior that needs fixing) bypassed
the reflog?

Thanks,
Jonathan

> [1] https://public-inbox.org/git/20170630003851.17288-1-sbeller@google.com/
[...]
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1653,7 +1653,8 @@ int submodule_move_head(const char *path,
>  			cp.dir = path;
>  
>  			prepare_submodule_repo_env(&cp.env_array);
> -			argv_array_pushl(&cp.args, "update-ref", "HEAD", new, NULL);
> +			argv_array_pushl(&cp.args, "update-ref", "HEAD",
> +					 "--no-deref", new, NULL);
>  
>  			if (run_command(&cp)) {
>  				ret = -1;
