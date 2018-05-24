Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5E311F51C
	for <e@80x24.org>; Thu, 24 May 2018 10:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031825AbeEXKLW (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 06:11:22 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:39332 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031578AbeEXKFW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 06:05:22 -0400
Received: by mail-wm0-f52.google.com with SMTP id f8-v6so3534894wmc.4
        for <git@vger.kernel.org>; Thu, 24 May 2018 03:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qx6KLTeEwFx1OvPpQZRUerV4DVOUr+3UtWtoiVUTMyw=;
        b=KYXN7qc9OMVVc3Rrsa7F0hbFlKAt3Evs6v9Idy1sVgRezqaQulVSGOxFzo5h2t9xYO
         sbr/PUgeKYQxXr9rOKlaOTLq8yTJi8p0JnytpioiBETB8Kbn85ixlPl8FYOXgFBbw0XX
         QcEVyWbP6bHtGhFcGGeGyDbg9CABrsovp0Z3vn6rRAOMGlDqTnYVKTuo70b57PXZ+Iio
         gStz9o9D5Zi1TXrcPNEPNTkXKGdQqnGaGz8beMmniN11a/XpWmB+sucnn8wOFfzEYa8f
         XXJZzf3jHsFQLuAgt/ncRCRX+dOAl4iat6Qcee2jMYngpVzCklXN1NgqbEFPoN/3M9KO
         k/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qx6KLTeEwFx1OvPpQZRUerV4DVOUr+3UtWtoiVUTMyw=;
        b=CKrx2SKDKlQqX3hZyQHiszq4c0n9kIZLXI6vcF5PsWNJcf1yWuiQ0ougRtyHVx9Ryj
         tx7NmWuqb+xKvypYVGhzoYstMuRuCK5WleqAJjIE/mwHCqRMs4xybSp+wmt6UcRxjwi1
         jSwmTAyZLZaXO5EVWOFAyOcSRl8TasNX7FfPwhOAL33mG8KnA11S7AgqgyreoAwAdTjY
         naR8ESlZdT7SnHHPWvO59dorXxu+BL2bKYuSpJV/Cpn61Ct/AkXYGO4q0T48zVyeOjaN
         ewq5I88rE5B3os55PU0FEyXvq79Cw2OnmWKfIVpn3uf6OaBDY8OoCaxKyfq00ilCZbVK
         aioA==
X-Gm-Message-State: ALKqPwfIgQ4ZvFoFgggy8YcxAz+4ghqrnmETVkC2/6MzUzgUTv8StWzk
        7hGhDFPm5J2GGim0dT6LigQ=
X-Google-Smtp-Source: AB8JxZr5FokucIoiChrzHxu2fJpKLnzt3c8g91QRdLsiveNlgOfVSEWFF8Nu3FZRipPPwY8Jh2WjYQ==
X-Received: by 2002:a1c:b807:: with SMTP id i7-v6mr6712662wmf.126.1527156320820;
        Thu, 24 May 2018 03:05:20 -0700 (PDT)
Received: from localhost.localdomain (x4db0e02e.dyn.telefonica.de. [77.176.224.46])
        by smtp.gmail.com with ESMTPSA id x16-v6sm5625291wrp.94.2018.05.24.03.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 May 2018 03:05:19 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/5] t6036, t6042: use test_line_count instead of wc -l
Date:   Thu, 24 May 2018 12:05:07 +0200
Message-Id: <20180524100507.32305-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.993.g55a0f0c723
In-Reply-To: <20180524070439.6367-3-newren@gmail.com>
References: <20180524070439.6367-1-newren@gmail.com> <20180524070439.6367-3-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t6036-recursive-corner-cases.sh    | 102 ++++++++++++++++++---------
>  t/t6042-merge-rename-corner-cases.sh |  99 +++++++++++++++++---------
>  2 files changed, 134 insertions(+), 67 deletions(-)
> 
> diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
> index cfe6a99771..3e659cff28 100755
> --- a/t/t6036-recursive-corner-cases.sh
> +++ b/t/t6036-recursive-corner-cases.sh
> @@ -65,9 +65,12 @@ test_expect_success 'merge simple rename+criss-cross with no modifications' '
>  
>  		test_must_fail git merge -s recursive R2^0 &&
>  
> -		test 2 = $(git ls-files -s | wc -l) &&
> -		test 2 = $(git ls-files -u | wc -l) &&
> -		test 2 = $(git ls-files -o | wc -l) &&

Here 'git ls-files -o' should have listed two untracked files ...

> +		git ls-files -s >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 3 out &&

... but now you expect it to list three.  I was about to point out the
typo, but then noticed that you expect it to list one more untracked
file than before in all subsequent tests...  now that can't be just a
typo, can it?

Please mention in the commit message that when using an intermediate
file to store the output, 'git ls-files -o' will list that file, too,
that's why the number of expected untracked files had to be adjusted;
so future readers won't have to figure this out themselves.

An alternative to consider would be to add a .gitignore file in the
initial commit to ignore 'out', then the number of untracked files
don't have to be adjusted.


[I have no further comments, but leave the rest of the patch below, so
anyone can readily check the increased number of untracked files in
subsequent tests.]


>  		test $(git rev-parse :2:three) = $(git rev-parse L2:three) &&
>  		test $(git rev-parse :3:three) = $(git rev-parse R2:three) &&
> @@ -135,9 +138,12 @@ test_expect_success 'merge criss-cross + rename merges with basic modification'
>  
>  		test_must_fail git merge -s recursive R2^0 &&
>  
> -		test 2 = $(git ls-files -s | wc -l) &&
> -		test 2 = $(git ls-files -u | wc -l) &&
> -		test 2 = $(git ls-files -o | wc -l) &&
> +		git ls-files -s >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 3 out &&
>  
>  		test $(git rev-parse :2:three) = $(git rev-parse L2:three) &&
>  		test $(git rev-parse :3:three) = $(git rev-parse R2:three) &&
> @@ -211,9 +217,12 @@ test_expect_success 'git detects differently handled merges conflict' '
>  
>  		test_must_fail git merge -s recursive E^0 &&
>  
> -		test 3 = $(git ls-files -s | wc -l) &&
> -		test 3 = $(git ls-files -u | wc -l) &&
> -		test 0 = $(git ls-files -o | wc -l) &&
> +		git ls-files -s >out &&
> +		test_line_count = 3 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 3 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 1 out &&
>  
>  		test $(git rev-parse :2:new_a) = $(git rev-parse D:new_a) &&
>  		test $(git rev-parse :3:new_a) = $(git rev-parse E:new_a) &&
> @@ -297,8 +306,10 @@ test_expect_success 'git detects conflict merging criss-cross+modify/delete' '
>  
>  		test_must_fail git merge -s recursive E^0 &&
>  
> -		test 2 -eq $(git ls-files -s | wc -l) &&
> -		test 2 -eq $(git ls-files -u | wc -l) &&
> +		git ls-files -s >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 2 out &&
>  
>  		test $(git rev-parse :1:file) = $(git rev-parse master:file) &&
>  		test $(git rev-parse :2:file) = $(git rev-parse B:file)
> @@ -314,8 +325,10 @@ test_expect_success 'git detects conflict merging criss-cross+modify/delete, rev
>  
>  		test_must_fail git merge -s recursive D^0 &&
>  
> -		test 2 -eq $(git ls-files -s | wc -l) &&
> -		test 2 -eq $(git ls-files -u | wc -l) &&
> +		git ls-files -s >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 2 out &&
>  
>  		test $(git rev-parse :1:file) = $(git rev-parse master:file) &&
>  		test $(git rev-parse :3:file) = $(git rev-parse B:file)
> @@ -423,9 +436,12 @@ test_expect_success 'merge of D & E1 fails but has appropriate contents' '
>  
>  		test_must_fail git merge -s recursive E1^0 &&
>  
> -		test 2 -eq $(git ls-files -s | wc -l) &&
> -		test 1 -eq $(git ls-files -u | wc -l) &&
> -		test 0 -eq $(git ls-files -o | wc -l) &&
> +		git ls-files -s >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 1 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 1 out &&
>  
>  		test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
>  		test $(git rev-parse :2:a) = $(git rev-parse B:a)
> @@ -440,9 +456,12 @@ test_expect_success 'merge of E1 & D fails but has appropriate contents' '
>  
>  		test_must_fail git merge -s recursive D^0 &&
>  
> -		test 2 -eq $(git ls-files -s | wc -l) &&
> -		test 1 -eq $(git ls-files -u | wc -l) &&
> -		test 0 -eq $(git ls-files -o | wc -l) &&
> +		git ls-files -s >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 1 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 1 out &&
>  
>  		test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
>  		test $(git rev-parse :3:a) = $(git rev-parse B:a)
> @@ -457,9 +476,12 @@ test_expect_success 'merge of D & E2 fails but has appropriate contents' '
>  
>  		test_must_fail git merge -s recursive E2^0 &&
>  
> -		test 4 -eq $(git ls-files -s | wc -l) &&
> -		test 3 -eq $(git ls-files -u | wc -l) &&
> -		test 1 -eq $(git ls-files -o | wc -l) &&
> +		git ls-files -s >out &&
> +		test_line_count = 4 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 3 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 2 out &&
>  
>  		test $(git rev-parse :2:a) = $(git rev-parse B:a) &&
>  		test $(git rev-parse :3:a/file) = $(git rev-parse E2:a/file) &&
> @@ -478,9 +500,12 @@ test_expect_success 'merge of E2 & D fails but has appropriate contents' '
>  
>  		test_must_fail git merge -s recursive D^0 &&
>  
> -		test 4 -eq $(git ls-files -s | wc -l) &&
> -		test 3 -eq $(git ls-files -u | wc -l) &&
> -		test 1 -eq $(git ls-files -o | wc -l) &&
> +		git ls-files -s >out &&
> +		test_line_count = 4 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 3 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 2 out &&
>  
>  		test $(git rev-parse :3:a) = $(git rev-parse B:a) &&
>  		test $(git rev-parse :2:a/file) = $(git rev-parse E2:a/file) &&
> @@ -574,9 +599,12 @@ test_expect_success 'handle rename/rename(1to2)/modify followed by what looks li
>  
>  		git merge -s recursive E^0 &&
>  
> -		test 1 -eq $(git ls-files -s | wc -l) &&
> -		test 0 -eq $(git ls-files -u | wc -l) &&
> -		test 0 -eq $(git ls-files -o | wc -l) &&
> +		git ls-files -s >out &&
> +		test_line_count = 1 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 0 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 1 out &&
>  
>  		test $(git rev-parse HEAD:newname) = $(git rev-parse E:newname)
>  	)
> @@ -653,9 +681,12 @@ test_expect_failure 'detect rename/rename/add-source for virtual merge-base' '
>  
>  		git merge -s recursive E^0 &&
>  
> -		test 3 -eq $(git ls-files -s | wc -l) &&
> -		test 0 -eq $(git ls-files -u | wc -l) &&
> -		test 0 -eq $(git ls-files -o | wc -l) &&
> +		git ls-files -s >out &&
> +		test_line_count = 3 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 0 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 1 out &&
>  
>  		test $(git rev-parse HEAD:b) = $(git rev-parse A:a) &&
>  		test $(git rev-parse HEAD:c) = $(git rev-parse A:a) &&
> @@ -727,9 +758,12 @@ test_expect_success 'virtual merge base handles rename/rename(1to2)/add-dest' '
>  
>  		git merge -s recursive E^0 &&
>  
> -		test 2 -eq $(git ls-files -s | wc -l) &&
> -		test 0 -eq $(git ls-files -u | wc -l) &&
> -		test 0 -eq $(git ls-files -o | wc -l) &&
> +		git ls-files -s >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 0 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 1 out &&
>  
>  		test $(git rev-parse HEAD:a) = $(git rev-parse A:a) &&
>  		test $(git rev-parse HEAD:c) = $(git rev-parse E:c)
> diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
> index bec0192c3b..b76da8fcdf 100755
> --- a/t/t6042-merge-rename-corner-cases.sh
> +++ b/t/t6042-merge-rename-corner-cases.sh
> @@ -116,9 +116,12 @@ test_expect_failure 'conflict caused if rename not detected' '
>  		git checkout -q C^0 &&
>  		git merge -s recursive B^0 &&
>  
> -		test 3 -eq $(git ls-files -s | wc -l) &&
> -		test 0 -eq $(git ls-files -u | wc -l) &&
> -		test 0 -eq $(git ls-files -o | wc -l) &&
> +		git ls-files -s >out &&
> +		test_line_count = 3 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 0 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 1 out &&
>  
>  		test_line_count = 6 c &&
>  		test $(git rev-parse HEAD:a) = $(git rev-parse B:a) &&
> @@ -203,9 +206,12 @@ test_expect_failure 'detect rename/add-source and preserve all data' '
>  
>  		git merge -s recursive C^0 &&
>  
> -		test 2 -eq $(git ls-files -s | wc -l) &&
> -		test 2 -eq $(git ls-files -u | wc -l) &&
> -		test 0 -eq $(git ls-files -o | wc -l) &&
> +		git ls-files -s >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 1 out &&
>  
>  		test -f a &&
>  		test -f b &&
> @@ -223,9 +229,12 @@ test_expect_failure 'detect rename/add-source and preserve all data, merge other
>  
>  		git merge -s recursive B^0 &&
>  
> -		test 2 -eq $(git ls-files -s | wc -l) &&
> -		test 2 -eq $(git ls-files -u | wc -l) &&
> -		test 0 -eq $(git ls-files -o | wc -l) &&
> +		git ls-files -s >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 1 out &&
>  
>  		test -f a &&
>  		test -f b &&
> @@ -279,9 +288,12 @@ test_expect_success 'rename/directory conflict + clean content merge' '
>  
>  		test_must_fail git merge -s recursive right^0 &&
>  
> -		test 2 -eq $(git ls-files -s | wc -l) &&
> -		test 1 -eq $(git ls-files -u | wc -l) &&
> -		test 1 -eq $(git ls-files -o | wc -l) &&
> +		git ls-files -s >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 1 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 2 out &&
>  
>  		echo 0 >expect &&
>  		git cat-file -p base:file >>expect &&
> @@ -307,9 +319,12 @@ test_expect_success 'rename/directory conflict + content merge conflict' '
>  
>  		test_must_fail git merge -s recursive right^0 &&
>  
> -		test 4 -eq $(git ls-files -s | wc -l) &&
> -		test 3 -eq $(git ls-files -u | wc -l) &&
> -		test 1 -eq $(git ls-files -o | wc -l) &&
> +		git ls-files -s >out &&
> +		test_line_count = 4 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 3 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 2 out &&
>  
>  		git cat-file -p left-conflict:newfile >left &&
>  		git cat-file -p base:file    >base &&
> @@ -367,9 +382,12 @@ test_expect_success 'disappearing dir in rename/directory conflict handled' '
>  
>  		git merge -s recursive right^0 &&
>  
> -		test 1 -eq $(git ls-files -s | wc -l) &&
> -		test 0 -eq $(git ls-files -u | wc -l) &&
> -		test 0 -eq $(git ls-files -o | wc -l) &&
> +		git ls-files -s >out &&
> +		test_line_count = 1 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 0 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 1 out &&
>  
>  		echo 0 >expect &&
>  		git cat-file -p base:sub/file >>expect &&
> @@ -426,10 +444,14 @@ test_expect_success 'handle rename/rename (2to1) conflict correctly' '
>  		test_must_fail git merge -s recursive C^0 >out &&
>  		test_i18ngrep "CONFLICT (rename/rename)" out &&
>  
> -		test 2 -eq $(git ls-files -s | wc -l) &&
> -		test 2 -eq $(git ls-files -u | wc -l) &&
> -		test 2 -eq $(git ls-files -u c | wc -l) &&
> -		test 3 -eq $(git ls-files -o | wc -l) &&
> +		git ls-files -s >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -u c >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 3 out &&
>  
>  		test ! -f a &&
>  		test ! -f b &&
> @@ -476,9 +498,12 @@ test_expect_success 'merge has correct working tree contents' '
>  
>  		test_must_fail git merge -s recursive B^0 &&
>  
> -		test 3 -eq $(git ls-files -s | wc -l) &&
> -		test 3 -eq $(git ls-files -u | wc -l) &&
> -		test 0 -eq $(git ls-files -o | wc -l) &&
> +		git ls-files -s >out &&
> +		test_line_count = 3 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 3 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 1 out &&
>  
>  		test $(git rev-parse :1:a) = $(git rev-parse A:a) &&
>  		test $(git rev-parse :3:b) = $(git rev-parse A:a) &&
> @@ -527,8 +552,10 @@ test_expect_failure 'detect conflict with rename/rename(1to2)/add-source merge'
>  
>  		test_must_fail git merge -s recursive C^0 &&
>  
> -		test 4 -eq $(git ls-files -s | wc -l) &&
> -		test 0 -eq $(git ls-files -o | wc -l) &&
> +		git ls-files -s >out &&
> +		test_line_count = 4 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 1 out &&
>  
>  		test $(git rev-parse 3:a) = $(git rev-parse C:a) &&
>  		test $(git rev-parse 1:a) = $(git rev-parse A:a) &&
> @@ -573,8 +600,10 @@ test_expect_failure 'rename/rename/add-source still tracks new a file' '
>  		git checkout C^0 &&
>  		git merge -s recursive B^0 &&
>  
> -		test 2 -eq $(git ls-files -s | wc -l) &&
> -		test 0 -eq $(git ls-files -o | wc -l) &&
> +		git ls-files -s >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 1 out &&
>  
>  		test $(git rev-parse HEAD:a) = $(git rev-parse C:a) &&
>  		test $(git rev-parse HEAD:b) = $(git rev-parse A:a)
> @@ -615,10 +644,14 @@ test_expect_success 'rename/rename/add-dest merge still knows about conflicting
>  		git checkout C^0 &&
>  		test_must_fail git merge -s recursive B^0 &&
>  
> -		test 5 -eq $(git ls-files -s | wc -l) &&
> -		test 2 -eq $(git ls-files -u b | wc -l) &&
> -		test 2 -eq $(git ls-files -u c | wc -l) &&
> -		test 4 -eq $(git ls-files -o | wc -l) &&
> +		git ls-files -s >out &&
> +		test_line_count = 5 out &&
> +		git ls-files -u b >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -u c >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 5 out &&
>  
>  		test $(git rev-parse :1:a) = $(git rev-parse A:a) &&
>  		test $(git rev-parse :2:b) = $(git rev-parse C:b) &&
> -- 
> 2.17.0.1.gda85003413
> 
> 
