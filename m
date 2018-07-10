Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC9BD1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 20:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732464AbeGJUkN (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 16:40:13 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39198 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732366AbeGJUkN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 16:40:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id w14-v6so17533211eds.6
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 13:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=egIbkj+rfhvjsq1S3t0O+Jsu3o0aXrae9GAKJvdweAg=;
        b=jdBmY0wUAY9ezsqQT/sssFfzryCEF0uQjJy9ZbLoMQvtl4JjIfImhgyBUUbo1kdi7P
         j4NX2o7V05ByDesV7i4XWpX/rVDN9SCnWUBRgnUABXLYtu/eCQqrn2cmpUFn2DAChN1n
         YbRqy1UnRkwsXufrnjd49F3paK44w9eU95Uw0kbnim7WfXWakJeifgVpTtfesaH/XQ5s
         5nUNU/T0ploc0RVER1JbraoYX5pBZ4VaGEovoIw6kRskdP3eLcUMLBpMGBEQ94PSBw6S
         vaU2fGqyOH5K5OgnGIeX0qslCQ0vfV7+C85ZHbMx5PNOdcyQ0l5zkw9FGAbDiEVP0nbE
         HoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=egIbkj+rfhvjsq1S3t0O+Jsu3o0aXrae9GAKJvdweAg=;
        b=n1aaf8hxEq33QtYUfrgRgyzEKaA7rDbOvch3xR6AVRuicGRTZMYziq9GlqnF+tvCI0
         QMg1uK5ATQ+eWST1A8kPI394upoI9Lb1CV5p28iM37Z1XU3ylDFMdVGOQkw5ANOLANBE
         yrZHTJ3IReMR+rMSAfOfhFozZuV9L4IpgC4LsG6f5Xhd9eOkXFLssUB9P0CW0pXQKwmn
         o2psqHwyMUXre+HFHZavgM/SI/ZHWrjDt4NUqWmGrJJfyv5SPjByITGiEdFOCcIjm2Ki
         RMHA7UDsBwJz7Vz4Myw/Mqep6sLYIeI7L17HrC+jKGg7cjnoNuVNyi+AcjJKpQiwmuo7
         K0yA==
X-Gm-Message-State: APt69E2L2XOYr388wZ4IfioqZY7COz4ZMe/DxHOmC65kKiDlpYH4RHVE
        4Dr+MZw2lv0KS66QtWWkDU4=
X-Google-Smtp-Source: AAOMgpfYtjDVSACoTzvNLVp7Fc0ocLg3nUCCwiYZwp/hCiyQQXvJuOskY5zEEXPF7Wbus+hUjgdTlw==
X-Received: by 2002:a50:8cd1:: with SMTP id r17-v6mr28259454edr.113.1531255167362;
        Tue, 10 Jul 2018 13:39:27 -0700 (PDT)
Received: from localhost.localdomain (x4db10d5d.dyn.telefonica.de. [77.177.13.93])
        by smtp.gmail.com with ESMTPSA id f22-v6sm7398397edr.22.2018.07.10.13.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 13:39:26 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
Subject: Re: [PATCH v2 4/9] t6044: add a testcase for index matching head, when head doesn't match HEAD
Date:   Tue, 10 Jul 2018 22:39:22 +0200
Message-Id: <20180710203922.26367-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.273.g57f1ecce9c
In-Reply-To: <20180701012503.14382-5-newren@gmail.com>
References: <20180603065810.23841-1-newren@gmail.com> <20180701012503.14382-1-newren@gmail.com> <20180701012503.14382-5-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
> index f9c2f8179..92ec55255 100755
> --- a/t/t6044-merge-unrelated-index-changes.sh
> +++ b/t/t6044-merge-unrelated-index-changes.sh
> @@ -126,6 +126,17 @@ test_expect_failure 'recursive, when merge branch matches merge base' '
>  	test_path_is_missing .git/MERGE_HEAD
>  '
>  
> +test_expect_failure 'merge-recursive, when index==head but head!=HEAD' '
> +	git reset --hard &&
> +	git checkout C^0 &&
> +
> +	# Make index match B
> +	git diff C B | git apply --cached &&

Branch 'C' contains the file 'c', which creates ambiguity on
case-insensitive file systems and makes the test fail:

  ++git reset --hard
  HEAD is now at ed5d5a6 B
  ++git checkout 'C^0'
  Previous HEAD position was ed5d5a6 B
  HEAD is now at 4fa59ce C
  ++git diff C B
  ++git apply --cached
  fatal: ambiguous argument 'C': both revision and filename
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'
  error: unrecognized input
  error: last command exited with $?=128
  not ok 8 - merge-recursive, when index==head but head!=HEAD

> +	# Merge B & F, with B as "head"
> +	git merge-recursive A -- B F > out &&
> +	test_i18ngrep "Already up to date" out
> +'
> +
>  test_expect_success 'octopus, unrelated file touched' '
>  	git reset --hard &&
>  	git checkout B^0 &&
> -- 
> 2.18.0.137.g2a11d05a6.dirty
> 
> 
