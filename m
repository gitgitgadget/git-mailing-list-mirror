Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F86B208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 15:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732971AbeHFR6C (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 13:58:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37656 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbeHFR6C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 13:58:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id b10-v6so5378855eds.4
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 08:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M5uFPbqVgL2HonXVAvLl7sPbuwGjGVFxUF8RuB2q8fk=;
        b=vRqL7nWISkj/PxNebvWXoJkkYUh5RbzLUXJq1OQYIC6kyWHkw9lV9SBP1+8teqsPFj
         WVOiH75gvWRNFszbjrOMCIvYsU2e1Y0OVVKh5gXC+rkDpjUzwStGiSgBPvelTeSnt5nq
         yiHWT9GQrpxmvRMuTABO5EGMjvrzoNOMAUhN3dODbTIlghDiviDvYNTQaHbP5N6ARaV8
         slOU0MM4iIOY5RRQW8KrzEeJkmMMVvqT+lMRwXeu3KEZCmOriEeb15HeDTfgRNWyYTjM
         SkyGBOq3jdnhCekiR1Y/8EZcHBGdlo4dnkMY88H1BRBVv3xY4n+q07XCPb+m1Z2q3gK/
         eRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M5uFPbqVgL2HonXVAvLl7sPbuwGjGVFxUF8RuB2q8fk=;
        b=sYaPdoYCQkBa0dljUESDnzmNjJ8u1bw3zCzskiI+auQkaB1iKaD/lxAWF8CtZpLtYK
         g2QufExYtv0dFqYdcnm2wRdNVCKHOHy4+3dWQi+9ZAEZZ5XV8BX0aDU3ZajUkew8UbV6
         eEvFMvXCMLN2g7TwbBCptmt8KN10LfpBSZqnxAgCwD4ByDBhbxHDs4LXY9hZ0p1bfC6v
         OaEqSNJi/HmMMdsFZT//OKSbqv2ALyPAz/2R2FNLJmydKYXD75sQfTW2tPQZU+4nP+WS
         btamaFwNStWYTeQ3G8qbc5mhMzNqJjOnDPxS1Kt5Qc0ttGlDNpAIWk9u8L0vr+mQvc8h
         wYTQ==
X-Gm-Message-State: AOUpUlHmBL3KOs4syneJVP81uKKAZ/upy3kYSMS4y9Xw52WZ169XrCcp
        rnk9d26U9qrqkxGmwx2+jpqs6nDh
X-Google-Smtp-Source: AAOMgpfz2P11q0L5kO2eou0ppAPlh16wucQbvr6evdQg2AyyveBPVtyaPwWGtgmCGjgtAucZGdWX9w==
X-Received: by 2002:aa7:c6c2:: with SMTP id b2-v6mr18320837eds.302.1533570499921;
        Mon, 06 Aug 2018 08:48:19 -0700 (PDT)
Received: from localhost.localdomain (x4db27253.dyn.telefonica.de. [77.178.114.83])
        by smtp.gmail.com with ESMTPSA id h34-v6sm7096287eda.58.2018.08.06.08.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Aug 2018 08:48:19 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
Subject: Re: [PATCH 2/3] t7406: avoid having git commands upstream of a pipe
Date:   Mon,  6 Aug 2018 17:48:14 +0200
Message-Id: <20180806154814.24585-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
In-Reply-To: <20180806152524.27516-3-newren@gmail.com>
References: <20180803231407.10662-1-newren@gmail.com> <20180806152524.27516-1-newren@gmail.com> <20180806152524.27516-3-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> When a git command is on the left side of a pipe, the pipe will swallow
> its exit status, preventing us from detecting failures in said commands.
> Restructure the tests to put the output in a temporary file to avoid
> this problem.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t7406-submodule-update.sh | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index e2405c96b5..c8971abd07 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh

> @@ -922,7 +928,7 @@ test_expect_success 'submodule update clone shallow submodule' '
>  		sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
>  		mv -f .gitmodules.tmp .gitmodules &&
>  		git submodule update --init --depth=$commit_count &&
> -		test 1 = $(git -C submodule log --oneline | wc -l)
> +		test 1 = $(git -C submodule rev-list --count HEAD)
>  	)
>  '
> 
> @@ -938,7 +944,7 @@ test_expect_success 'submodule update clone shallow submodule outside of depth'
>  		test_i18ngrep "Direct fetching of that commit failed." actual &&
>  		git -C ../submodule config uploadpack.allowReachableSHA1InWant true &&
>  		git submodule update --init --depth=1 >actual &&
> -		test 1 = $(git -C submodule log --oneline | wc -l)
> +		test 1 = $(git -C submodule rev-list --count HEAD)
>  	)
>  '

These two hunks don't have the desired effect, because command
substitutions used like this will hide the exit code anyway.  I'd
suggest

  git -C submodule log --oneline >out &&
  test_line_count = 1 out

instead, with the additional benefit of a nice error message on
failure.


