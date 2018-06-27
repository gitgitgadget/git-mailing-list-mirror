Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 379DC1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 17:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965825AbeF0RiZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 13:38:25 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42119 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965312AbeF0RiX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 13:38:23 -0400
Received: by mail-wr0-f193.google.com with SMTP id p1-v6so2865178wrs.9
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 10:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xX9W1JUmhycUylSVMYBhSufIDgtCjYZ9HKqvq88PNME=;
        b=IpfomMT+iblJs99E3dlmnqB0Kr/bhO937nskkK0GSP72GrS/WucPj+xO73uhXIKaNA
         /0sS9JyQgCGGnHq9kPE59nDxsCeN9nnzDdsofQ+dcIQt7bp+LvogbWg3gzYIcOcMOobQ
         az0fkYRe4l62a3yxQ7uAbMYG0Qpq5t+eUFIp9nyBqWo6sXFyZ2pNbsyRMiftOZo2jw15
         QKNVh0vd11kdciG1Zg6aLE0azEUDWM3HNDu8vkqriN55zZSviec1nd4O7L0LhpzXpLa8
         +Ow4nt2K56kOvNpx1Dj3eVQMY4WsMj8oysHOPGY3Rw8cCPZa838t4zJTKXj24lZshASI
         3SNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xX9W1JUmhycUylSVMYBhSufIDgtCjYZ9HKqvq88PNME=;
        b=eieIHrQ5BgQGVEne1/kJ5cvsztkEYs5DyDct4bxoBm5G2aTVmJWJt0vrjM3xSAEirl
         3+fGaawNwyYVsYWDOZvN3pLnJ4rz5ymmcFM/+9g7kYBd27KkCenlRpeBI0DPT5JW7e31
         IffAZspycSWXI7j7dgsQ7aSFVPa3EwmLlWx2LC97b+YdFaW32dkp6Rg/xnR2aPPlBl8f
         ZWMKTKI2MioQbXZ6nQhtmfPDVRIPQTVQV7BxqA10hhXnv0pNjaAqW56XxWR6VvnnVQtp
         lGsbJoo3hYO4t2xloQnyFsTOy8bYZeW/bpSkKfDknZ2Wvl3DuiV1RWQuDkzlGumi8RKt
         44oA==
X-Gm-Message-State: APt69E1aenMvocwyrfoLrjQvClijXU9EDRpenLukicCxjbKd6drBATrp
        o/K0J/tYuh0PubilnqozaoskuMYs
X-Google-Smtp-Source: AAOMgpcDCXLfemSH7zmp+9CAuMFSbhQfJPXSlpI/DYxgx2xTOw6oUY4ClLAWldV83t9AuwWkKgwnZg==
X-Received: by 2002:adf:d181:: with SMTP id h1-v6mr5949389wri.198.1530121101887;
        Wed, 27 Jun 2018 10:38:21 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a184-v6sm6138227wmf.30.2018.06.27.10.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 10:38:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v7 01/22] t5318-commit-graph.sh: use core.commitGraph
References: <20180608135548.216405-1-dstolee@microsoft.com>
        <20180627132447.142473-1-dstolee@microsoft.com>
        <20180627132447.142473-2-dstolee@microsoft.com>
Date:   Wed, 27 Jun 2018 10:38:20 -0700
In-Reply-To: <20180627132447.142473-2-dstolee@microsoft.com> (Derrick Stolee's
        message of "Wed, 27 Jun 2018 09:24:26 -0400")
Message-ID: <xmqqa7rggmer.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> The commit-graph tests should be checking that normal Git operations
> succeed and have matching output with and without the commit-graph
> feature enabled. However, the test was toggling 'core.graph' instead
> of the correct 'core.commitGraph' variable.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>
> Junio,
>
> I sent this patch as a one-off a while ago, but it seems it was dropped.
> I'm adding it back here so we don't forget it.

Thanks, will queue.


>
> -Stolee
>
>  t/t5318-commit-graph.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 77d85aefe7..59d0be2877 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -28,8 +28,8 @@ test_expect_success 'create commits and repack' '
>  '
>  
>  graph_git_two_modes() {
> -	git -c core.graph=true $1 >output
> -	git -c core.graph=false $1 >expect
> +	git -c core.commitGraph=true $1 >output
> +	git -c core.commitGraph=false $1 >expect
>  	test_cmp output expect
>  }
