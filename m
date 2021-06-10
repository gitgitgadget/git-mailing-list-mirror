Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5B1C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58B57610E6
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhFJPAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 11:00:42 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:43931 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhFJPAm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 11:00:42 -0400
Received: by mail-oi1-f170.google.com with SMTP id x196so2398842oif.10
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=S4tPqn6QoYR40w+rrpxqKZQeNc77OAJpJmc1vFkWkcI=;
        b=Z/GcGHODTcxMWEujNd4n3hFmzJGKd15FSkHJEYVTMH7be3nMb5ZOjzMHsN08BsLtWG
         erDfUW9V4c0ijl2qw/umdrRAAd83jTq4EMMfttBUPpFaQgDGkYysaS3MWNyDgRofgFQc
         Bs3LY/KBp+XrB6lXd9TUMSK9IevV3GRLWilpoPsskR5C3olPHSDVg2/bWuvpOtqXXZIw
         RwxEu9e3Pna0c/3bJvGFhSarVjJzFeSLP9o+XhY9EfZXtZCX0s8DVGU6nnsgTBY4wEM8
         XNSvUpA705924MRpAR5uXMwK81lrqYBcMvUQ41U5QyxaNsq6xWRMiWwDHGnAJ7Ycpr3M
         i4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=S4tPqn6QoYR40w+rrpxqKZQeNc77OAJpJmc1vFkWkcI=;
        b=QdfEfqmiS9qEs03nEeQcBBAKcf6eiLw+mswli6T5qVPmJZWwFycb9AOGpHeTy9vGPN
         c+/+H73+sPFMI++0m60dujtzrBeqLIptMSgxcUvEzu3+WLgFwgjmL1X6nGJ5/p2qRwTv
         GXSDiI+8QPS4UGptBvk523nJl0PFg31fYQpL1qThOWlv2spM7EB+AFgnQcR7TGJBdoKi
         O62QiP+Dnd1ZOIMmZCWXcyJzlOFtUE1g6vfK4FYeXM1CMWYElqeOVjkpT7bnm5ILMwBd
         zHiF58phFsAJgkgoWB3psPjmKKlOwW7ytv6grd9reuzj34FNcQMtbucgi2x+UidTArqD
         16lw==
X-Gm-Message-State: AOAM530Td0pQ/C3ECFWaveJ9NIVaLBVAtrmdm7mCF4aG8ZB3lMje3EIE
        ZNsQaZAU+KBFK1C8BPY5CI0=
X-Google-Smtp-Source: ABdhPJzifHtZoVrkAa8cXWiRRo2gOAszmwl3Igi6DHZmJzCyOQR2uoPDfuburw7Pff5ZNEiGu9/lrA==
X-Received: by 2002:aca:618a:: with SMTP id v132mr10413401oib.144.1623337065833;
        Thu, 10 Jun 2021 07:57:45 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id h8sm591499oie.41.2021.06.10.07.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:57:45 -0700 (PDT)
Date:   Thu, 10 Jun 2021 09:57:39 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60c22863185f4_b25b1208e2@natae.notmuch>
In-Reply-To: <xmqqmtrydxye.fsf@gitster.g>
References: <xmqqmtrydxye.fsf@gitster.g>
Subject: RE: What's cooking in git.git (Jun 2021, #04; Thu, 10)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> * fc/completion-updates (2021-06-07) 4 commits
>  - completion: bash: add correct suffix in variables
>  - completion: bash: fix for multiple dash commands
>  - completion: bash: fix for suboptions with value
>  - completion: bash: fix prefix detection in branch.*
> 
>  Command line completion updates.
> 
>  Expecting a reroll.
>  cf. <60be6f7fa4435_db80d208f2@natae.notmuch>

The reroll is there already:

https://lore.kernel.org/git/60be6f7fa4435_db80d208f2@natae.notmuch/

It was sent hours later.

2021-06-07 19:11     ` Felipe Contreras [this message]
2021-06-08  6:00 ` [PATCH v3 " Felipe Contreras

> * fc/doc-build-cleanup (2021-05-24) 5 commits
>   (merged to 'next' on 2021-05-31 at af103e12f4)
>  + doc: avoid using rm directly
>  + doc: simplify Makefile using .DELETE_ON_ERROR
>  + doc: remove unnecessary rm instances
>  + doc: improve asciidoc dependencies
>  + doc: refactor common asciidoc dependencies
> 
>  Preparatory build procedure clean-up for documentation.
> 
>  Will merge to 'master'.

The next batch is right there:

https://lore.kernel.org/git/20210608090026.1737348-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
