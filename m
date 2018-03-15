Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AEC01F404
	for <e@80x24.org>; Thu, 15 Mar 2018 20:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752831AbeCOU1N (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 16:27:13 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33541 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbeCOU1K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 16:27:10 -0400
Received: by mail-wm0-f53.google.com with SMTP id s206so24717153wme.0
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 13:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OEddSt1g9JgcSkGgw7tEH0zAy0JW4vHjsmQSG3Gd8w4=;
        b=ARVkUhR8uGlF4EOOhM8eV9Vk75Cbgdis7Fd1uHGNDKg4nyVlis23LVnMNgd1nguTt1
         Ptjh37rQ4f7BLHa1158vRjFaVvHtD/0Y6LE8XQD9dX8YsIh4gryuiW05jKnL6rweA08y
         TRsgVU0OcEMuQtW/ps8SVa3mRJItyPQzxWayVXyr1DFLJPUbyQoCBPWSjKyxRy74gMZh
         IvUV1UOKsFm3ZySu8kOwCjPsKdjN9Z/41MEaknkW1HTRIiCr/+o7+SqCIQ8uPx7eWRby
         8ooA+GUOYXP6iaoDiZCokgjq1olJGER4i/nyLN40oyTXcbDae5WZDtUEKIrBSBN0Js6B
         PGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OEddSt1g9JgcSkGgw7tEH0zAy0JW4vHjsmQSG3Gd8w4=;
        b=q6X73itIvWiA1Wjj4KI2c0qmEPFI0xPIN8XcObKRntrt/wqwB7bQ376nPopzktLXHb
         bJV1f1tF1DJHkQ7qaR1Y4RtkuUB5T/xrLPiHh5NFK82lcKaZqGqJax895eufl1ELJhGs
         et0F2xI5dO1ZQv6tapYFfMVfH5mFXc+Hg0NwY+4OHXcth0Pfv68WaXcsPKVv8ZyVDde0
         hDLSi1UosgO4Y0W4WrHVUBGqzXiYTCzo50jC2IQBgMcoolbHZbIUEEXbbzmS101LCmfH
         J3025zoS4yKsQM730t/pLpjRH1I2DJ5jmU5OAx/LzBi2EJZbbCV6oljkYyBzai6wmjlr
         J9cA==
X-Gm-Message-State: AElRT7EAy1QgMoOhoQSJ0V4UQ0JD4w4iNqdKmWz2srWBbhvxaHGdXa1+
        iDCFSGFYC+4UocZnDEEInqSPFblRg60=
X-Google-Smtp-Source: AG47ELthuFoLS0kJh5voZu8ZZq4rdGBnygvhwwwUcf7DrxEXXdAeNaRvhKhPsZvdLOEDai92xcgt3w==
X-Received: by 10.28.183.9 with SMTP id h9mr5309248wmf.99.1521145629104;
        Thu, 15 Mar 2018 13:27:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d4sm4799143wmh.42.2018.03.15.13.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 13:27:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/3] branch: introduce dont_fail parameter for branchname validation
References: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
        <20180310155416.21802-1-kaartic.sivaraam@gmail.com>
        <20180310155416.21802-2-kaartic.sivaraam@gmail.com>
Date:   Thu, 15 Mar 2018 13:27:07 -0700
In-Reply-To: <20180310155416.21802-2-kaartic.sivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Sat, 10 Mar 2018 21:24:14 +0530")
Message-ID: <xmqqpo453x0k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> This parameter allows the branchname validation functions to
> optionally return a flag specifying the reason for failure, when
> requested. This allows the caller to know why it was about to die.
> This allows more useful error messages to be given to the user when
> trying to rename a branch.
>
> The flags are specified in the form of an enum and values for success
> flags have been assigned explicitly to clearly express that certain
> callers rely on those values and they cannot be arbitrary.
>
> Only the logic has been added but no caller has been made to use
> it, yet. So, no functional changes.
>
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---

So... I am not finding dont_fail that was mentioned on the title
anywhere else in the patch.  Such lack of attention to detail is
a bit off-putting.

The change itself overall looks OK.  One minor thing that made me
wonder was this bit:

> +enum branch_validation_result {
> +	/* Flags that convey there are fatal errors */
> +	VALIDATION_FATAL_BRANCH_EXISTS_NO_FORCE = -3,
> +	VALIDATION_FATAL_CANNOT_FORCE_UPDATE_CURRENT_BRANCH,
> +	VALIDATION_FATAL_INVALID_BRANCH_NAME,
> +	/* Flags that convey there are no fatal errors */
> +	VALIDATION_PASS_BRANCH_DOESNT_EXIST = 0,
> +	VALIDATION_PASS_BRANCH_EXISTS = 1,
> +	VALIDATION_WARN_BRANCH_EXISTS = 2
> +};

where adding new error types will force us to touch _two_ lines
(i.e. either you add a new error before NO_FORCE with value -4 and
then remove the "= -3" from NO_FORCE, or you add a new error after
INVALID, and update NO_FORCE to -4), which can easily be screwed up
by a careless developer.  The current code is not wrong per-se, but
I wonder if it can be made less error prone.

