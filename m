Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A137FC2BA19
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 18:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6831320732
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 18:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ItLqWxw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgDKSNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Apr 2020 14:13:01 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:38127 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgDKSNB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Apr 2020 14:13:01 -0400
Received: by mail-pf1-f201.google.com with SMTP id f14so4705579pfk.5
        for <git@vger.kernel.org>; Sat, 11 Apr 2020 11:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DG5vRNBAgVHMJks5ZhJTEKjAVGfAqoGKkPD3oKKRWSg=;
        b=ItLqWxw061KS96RLiefumkevR4wk+6ppVnB69v2e6OKavEdskBJuBytxHDfPH90l0t
         F9Gz7gJVy3ruhpY924ra6ldrGJ7+ZYlY7mf4mht1y1xmkhulkXig3XiQsKIG3V65Uqr0
         vWLiT/1DVYm6zEMROdYZXMjPFPfWePubp8zao8hPZxQJhQhyVyTngU77UJyRA00a13Uw
         w6PtLcrzbIB5zsLNGrEF1g08EfodtrljuqpkHsOL+MLWGJT+xmQHeV8wbisa1GYDilOJ
         Zy00e0up2zr+9Da2BV9JVUXjt31UupJ8kkO6Ptktm9JyVY8U2z3JlieAoW5LP4Y/dbqb
         C4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DG5vRNBAgVHMJks5ZhJTEKjAVGfAqoGKkPD3oKKRWSg=;
        b=speBKOvkUMzyRxYQjulv3hcgVp0He7gNO0Rs39EdQHB0wpbdWsXnTBt5Oah44jS2MX
         77zSSgOUUZGQ0Y3Q7OmhMkv8LQsl0eIx9LY4XiwIlDrKE3Rwv87R76AngMCEapZAQWQz
         bDk90kQ9adHnZ9LowaylqgGq2uUjsFe6tnVhUFNugoB+dVp2xjRt+2u6DJMauLBsUC+T
         3xNfwIclsfXQ7bdvQgHfzcAEOTSWoalGS7NmoSby8zCi+Q2EbiSAaAqMsUAWjyQ+2AKi
         F4QKTaImMsd8Na+/HPzhPHf/RHx+6WYdfsdjB1PmWc9HxEWr5i0/Ep2TSbVKrdfG2u0m
         zPgg==
X-Gm-Message-State: AGi0PubmUD44IxrPF9hay1KHhP6Vp5Yh5oAkjbEg5255djQWC7c/dtvh
        Tn20uLcnx+pPn6yN+roLjswp89I83hmv7M1aA5qj
X-Google-Smtp-Source: APiQypK7lSDqGaTBQGPz/4J54A5TVtS37qOrAyrklsOCZU4UztgwmOnFzxNyCbuMD0BLPUDBv6WQBw1eQz5MEiAvxATb
X-Received: by 2002:a17:90a:be18:: with SMTP id a24mr11618887pjs.92.1586628780642;
 Sat, 11 Apr 2020 11:13:00 -0700 (PDT)
Date:   Sat, 11 Apr 2020 11:12:58 -0700
In-Reply-To: <20d3a50f5a4bf91223c1b849d91e790683d70d66.1586573068.git.gitgitgadget@gmail.com>
Message-Id: <20200411181258.5907-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20d3a50f5a4bf91223c1b849d91e790683d70d66.1586573068.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: Re: [PATCH v3 4/4] rebase --merge: optionally skip upstreamed commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        bturner@atlassian.com, sami@boukortt.com, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -601,6 +620,7 @@ are incompatible with the following options:
>   * --exec
>   * --no-keep-empty
>   * --empty=
> + * --reapply-cherry-picks
>   * --edit-todo
>   * --root when used in combination with --onto

[snip]

> @@ -1825,6 +1829,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	if (options.empty != EMPTY_UNSPECIFIED)
>  		imply_merge(&options, "--empty");
>  
> +	if (options.reapply_cherry_picks)
> +		imply_merge(&options, "--reapply-cherry-picks");
> +
>  	if (gpg_sign) {
>  		free(options.gpg_sign_opt);
>  		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);

Thanks - these definitely look cleaner than what I had, and the rest of
the patch looks good too.
