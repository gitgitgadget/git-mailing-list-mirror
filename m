Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A1B8208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 09:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbeHGLVI (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 07:21:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32915 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbeHGLVI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 07:21:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id x5-v6so6562209edr.0
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 02:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JiFtTfpF6kLmaly66cvRxlbY0uYg7Gd73cShcrI7t/4=;
        b=lqQ0F+VWuIh/Tkjmv/LV0+71Agdec5XP7EBXEk0y2CXQUJDIBaEehkIDKWls9p0Hpp
         tZZLJkVbim14WCXGwOVyK3QZr5Eoa5lcxQ5fuPW40yFjo1orCy1HH6QURwGJDDUZumzZ
         gMKVrdCLKs40jVOAxWYQ784r468o538bL/1N7m6XfezClcuWFK+E5bnbjNosK4QKBSzx
         WWl4UCMg1HcoTzbjKxwYGQZLKFnHhPDtf+vD6h6HU+7I156dbLVRa+Wfv9GBXJaNwgGs
         YdawpWSSfQ7YcDG7SWeFg3Wk4crgsyL2hMI853VynRvRxyAe8h9T3kZjnsCI6K9TPciO
         Fn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JiFtTfpF6kLmaly66cvRxlbY0uYg7Gd73cShcrI7t/4=;
        b=Gf9zqbst+DPkcAuUhOkP0LrJPkm7ofmHg/5neeiJlEHRvGaOw77QVmCef4pwfx84MQ
         m72iJXGAr8jKbJkDylUnLctwKnin9e4VbJ8e+YsXnKi/3Z39a2usqWEesS1rbSX8cuX0
         sZFdGjCyGxjKDFfUEy/us4W4Qy16coAbq5lRTfIuS/xVhtk2g4/FsOS4phcRZSzLTIiU
         1iXNit25Idtp0hPAl4wDjaP3TBGqK5RTgJPtvN3FeCJyiBO1jTfKw++gE1ehj/WQmsfX
         yMSXfEddgFaELu791MsuhOOmma5oDM3H3wpnHIQbCFxnIM+jIpo4UrFGsB0nIZrpyH+V
         2NbA==
X-Gm-Message-State: AOUpUlHFxWbZXIQZKtBIcFCUb0A1/FvRlzzOyTZY6KrO5q/127YN5d49
        GTZyMUvLcu2LUyoQ/QMJkz8=
X-Google-Smtp-Source: AAOMgpfh5g2hffrzvverpWKtEYAHgG/w8L6gCn7U9C1Ctsk6+rmDJRHnPIb5bkwulqyFbfVstiIvWw==
X-Received: by 2002:a50:f390:: with SMTP id g16-v6mr21947150edm.226.1533632865973;
        Tue, 07 Aug 2018 02:07:45 -0700 (PDT)
Received: from localhost.localdomain (x4db121d1.dyn.telefonica.de. [77.177.33.209])
        by smtp.gmail.com with ESMTPSA id k17-v6sm668343edb.0.2018.08.07.02.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Aug 2018 02:07:45 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
Subject: Re: [PATCH 3/3] t7406: make a test_must_fail call fail for the right reason
Date:   Tue,  7 Aug 2018 11:07:39 +0200
Message-Id: <20180807090739.5829-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
In-Reply-To: <20180806152524.27516-4-newren@gmail.com>
References: <20180803231407.10662-1-newren@gmail.com> <20180806152524.27516-1-newren@gmail.com> <20180806152524.27516-4-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> A test making use of test_must_fail was failing like this:
>   fatal: ambiguous argument '|': unknown revision or path not in the working tree.
> when the intent was to verify that a specific string was not found
> in the output of the git diff command, i.e. that grep returned
> non-zero.  Fix the test to do that.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t7406-submodule-update.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index c8971abd07..f65049ec73 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -603,7 +603,8 @@ test_expect_success 'submodule update - update=none in .git/config but --checkou
>  	 git diff --name-only >out &&
>  	 grep submodule out &&
>  	 git submodule update --checkout &&
> -	 test_must_fail git diff --name-only \| grep submodule &&
> +	 git diff --name-only >out &&
> +	 ! grep submodule out &&
>  	 (cd submodule &&
>  	  test_must_fail compare_head

May I suggest a while-at-it cleanup? :)
Here 'test_must_fail' is used in front of a shell function, which
should be written as '! compare_head', and indeed in all other places
in this test script it's written that way.

>  	 ) &&
> --
> 2.18.0.548.gd57a518419
> 
> 
