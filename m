Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E74D20281
	for <e@80x24.org>; Wed, 27 Sep 2017 00:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032869AbdI0Awx (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 20:52:53 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:57089 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030619AbdI0Aww (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 20:52:52 -0400
Received: by mail-pg0-f47.google.com with SMTP id 7so6830738pgd.13
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 17:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qBJAEzbU5GumSzjwd4U0OUsWjCmvHeTbdRE7I13RczI=;
        b=iDD7EamYGn3xOmpwX8WRSRR9Nxy5nfTmwt5z7YNZsQVVzASNkBPWhaWSNnLa7ycGBU
         z0YurZJ+WiNAb8qSkrMOSpZxqLFrbUQ6Xyfl60Y0gF8K9yAmYQDGgCa8YFnwa/gFUJTn
         EKI7AB4J/7Rq88CEdpzEY/ZQ4STRnLvjgRUOMR23ilTQObtIvCKL0GOkgEsewrwW05f9
         yAv4jvoNQzPY0cO//KaTZUq4snRSZepKNN2+qJksxsAYoGw1o4/+PbfP0T/Kd/3zIcD8
         ulGHprsNyMAWW5ZljR1GoF487fEev+PbYF8K5639wA3aULCfyYevFvMcr8SS910rSl5c
         u9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qBJAEzbU5GumSzjwd4U0OUsWjCmvHeTbdRE7I13RczI=;
        b=TGuaCQ2/YZlLjNTyfTaqCbP63HDpq3V1+wxfqs/lr7kyJRbAhsFbcFaeQ+l3Jfx4R2
         GWJyVMCHIVww1W04YDezIN6xCm0GYxI0WIhGCoBxQQ2b5BNwe4yiAp+IApYgnUESEPCH
         lfAAA0HtJEN30YF9mZxefWsaSho/h3CKPJQvflGtjJjvxMeB5BcyCHSmKtUivDy5jS2z
         TN9rAWSnosEDz3kI5R/Hwtg32palcUBsTiWdz6uejdmsHtzruLAe5EddQSVh0ijjoyYW
         gNR+ooVWNcqbt3Q5QfgmMczgrLNddS9asgFY+k8Ad3Kf18t07utxMRd2Ru82jQgI9Yn7
         R2rw==
X-Gm-Message-State: AHPjjUiZXzQBA0wAWVYzy20stm0udKeehPDnnfY7DDJmulj3ncsrPnVb
        /CsJ71sOMDHYg010CCcReOhzeRWo
X-Google-Smtp-Source: AOwi7QBNgO2uCZsVRFKTg3LLa4bFtZaf9l+F5g5i/Rlbtgj89Ko/cw2pMYxho8c46VOKG6cFeoUr8A==
X-Received: by 10.99.44.10 with SMTP id s10mr12161541pgs.381.1506473572260;
        Tue, 26 Sep 2017 17:52:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a541:226f:6d4c:7f7a])
        by smtp.gmail.com with ESMTPSA id e66sm17086916pfb.48.2017.09.26.17.52.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 17:52:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com
Subject: Re: [PATCH] submodule: correct error message for missing commits.
References: <20170926182756.13319-1-sbeller@google.com>
Date:   Wed, 27 Sep 2017 09:52:48 +0900
In-Reply-To: <20170926182756.13319-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 26 Sep 2017 11:27:56 -0700")
Message-ID: <xmqqlgl17yjj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When a submodule diff should be displayed we currently just add the
> submodule objects to the main object store and then e.g. walk the
> revision graph and create a summary for that submodule.
>
> It is possible that we are missing the submodule either completely or
> partially, which we currently differentiate with different error messages
> depending on whether (1) the whole submodule object store is missing or
> (2) just the needed for this particular diff. (1) is reported as
> "not initialized", and (2) is reported as "commits not present".
>
> If a submodule is deinit'ed its repository data is still around inside
> the superproject, such that the diff can still be produced. In that way
> the error message (1) is misleading as we can have a diff despite the
> submodule being not initialized.
>
> Downgrade the error message (1) to be the same as (2) and just say
> the commits are not present, as that is the true reason why the diff
> cannot be shown.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Sounds good.  Thanks for working on it.

