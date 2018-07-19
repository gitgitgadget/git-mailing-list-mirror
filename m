Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 792461F597
	for <e@80x24.org>; Thu, 19 Jul 2018 19:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733071AbeGSTzl (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 15:55:41 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33020 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732791AbeGSTzk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 15:55:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id z6-v6so2486697wma.0
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 12:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UJ8ycuGcexnCyJv08gXy5eSkiyUhStyVnZY2aUzRxQ4=;
        b=r/h7TUEq3qMB3SevgA051kcGV1b9Ranfh2A4+/mAW2+6dglDNEb9H4uu/BMI76iBWP
         Hqgd2V8bs7CAKVMF+teNupC5WYXkVZTYf9KCGr/uhxa/PDi0JfdEfOr1n02xatT1+amb
         m4BSSoeIPaOZhqUk5ixHeN5yxSQeDIOlz7qYF/EgOJmve/xBntwGlRZiPVWzBAdT39fR
         qTfTMUaReIvLzuKkoGv1KafyZbEufP92eXx/ZswVp2bh2dNd9u/LpWfY0TV6WS7VMNYT
         0bfcu8KtbwYaSObumxa8lzMJHP8hz+CgZiqZDFSEfCUz5+rZ6tOMjA9R1jfALE73x2ix
         jhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UJ8ycuGcexnCyJv08gXy5eSkiyUhStyVnZY2aUzRxQ4=;
        b=cqSBWZizJweH8RrN0H6/BB3G/lnsHMlhYMKmtDoLCbjEXobfYMJZw3qK8VPmwsCaZ5
         iH9ydACIS1UPxgBmXokyLmEbewEfLuFDUAozW67YsgazWSedkO2vtIFc5jW28U1/xtHi
         pFhS7+TsiInKyoB2R+085toEsmHbSy9/unWXkxCogy29bw5nvmoJSD/ohvFK+KFgZOyV
         A6EMXER0TNKXKLA7l7mRfcRZ94UNTRiCGYr0qhK7DlEBBknaTh/oGYXsV7kFKdaNBZTV
         yOjjDp9L1vXvNUsMirrw3XCS7jmorX1vnl+M0F+0qWgpHHKHEuQPlL7aHvunTS3ucf2j
         LbrA==
X-Gm-Message-State: AOUpUlGOcVtuwuGQjSqvmFmizTbMJCrUj/MXvx8RPMYP9yUvQKd5a/u1
        3wJPttVtp0aupdQFUGHLeVA=
X-Google-Smtp-Source: AAOMgpcJ8+m4DnCOgUfFQ2L9EBydNWjBUXX7GVqID7U2sZgj/XSySuK39k8kb49iBo88vSzQdaTrlg==
X-Received: by 2002:a1c:d0ce:: with SMTP id h197-v6mr4827169wmg.97.1532027468933;
        Thu, 19 Jul 2018 12:11:08 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r1-v6sm7138845wrs.39.2018.07.19.12.11.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 12:11:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] add unbounded Multi-Producer-Multi-Consumer queue
References: <20180718204458.20936-1-benpeart@microsoft.com>
        <20180718204458.20936-2-benpeart@microsoft.com>
Date:   Thu, 19 Jul 2018 12:11:07 -0700
In-Reply-To: <20180718204458.20936-2-benpeart@microsoft.com> (Ben Peart's
        message of "Wed, 18 Jul 2018 20:45:15 +0000")
Message-ID: <xmqqsh4fdos4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <Ben.Peart@microsoft.com> writes:

> +/*
> + * struct mpmcq_entry is an opaque structure representing an entry in the
> + * queue.
> + */
> +struct mpmcq_entry {
> +	struct mpmcq_entry *next;
> +};
> +
> +/*
> + * struct mpmcq is the concurrent queue structure. Members should not be
> + * modified directly.
> + */
> +struct mpmcq {
> +	struct mpmcq_entry *head;
> +	pthread_mutex_t mutex;
> +	pthread_cond_t condition;
> +	int cancel;
> +};

This calls itself a queue, but a new element goes to the beginning
of a singly linked list, and the only way to take an element out is
from near the beinning of the linked list, so it looks more like a
LIFO stack to me.

I do not know how much it matters, as the name mpmcq is totally
opaque to readers so perhaps readers are not even aware of various
aspects of the service, e.g. how it works, what fairness it gives to
the calling code, etc.

