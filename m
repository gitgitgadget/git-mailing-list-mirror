Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 322421F516
	for <e@80x24.org>; Wed, 27 Jun 2018 18:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965856AbeF0S2P (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 14:28:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56081 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965837AbeF0S2M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 14:28:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id v16-v6so6909462wmv.5
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 11:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lCANlbRHlVaGb73Ca8bdxcHSoP3m+MC0FqDYMHw3U1I=;
        b=a+NeROSs6Y8abR0MjA79zvQ7SQY2MtBOYzbbW1F1SlFbWu/hB90pRKYlhzJTflP6t3
         8TXVoDqWFX2pkvfKA4aIha3QsFaBZ4xZZxrC3SJ5HpwQn7HeDopibEKhaGrvrOaTYfc0
         WY4xzxcBlVgGT0NUbCIN73xK5YF3cZVKig0VooFHcmXvMz0sAxCAT1DmcVxK8jMUWR/r
         JWN4yBMAEvdsb6emOxpf9Mbsz7ZADbGKlkVrISwukU1f4scJ1h/Uo+y7G/R9J7UYHVnn
         lUu76lWvpjFV/f9LGWrEkn/yFhtliWaapchdcwbjN/csV+gIE+zRX+uykOZaVLP4ju8w
         u4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lCANlbRHlVaGb73Ca8bdxcHSoP3m+MC0FqDYMHw3U1I=;
        b=bXyNRQu2TdY0jBsKM10oeo+z4snySDxnxQlMjOTQuzYjDOt/Rd0d3QzaHKjK11bHph
         fPphYAoIuHv1ol1awJ0Fr047SJ4bVdDKDc5RKiTmzsxh8t+725H5Karb0MIIcdKPfzB5
         f54rXEkDpPgHHSu4OLzFbGc4Xm5DW1uNXr7n7zR+CorIPnZl31mA93FRxccx9CScxGmO
         UbWmmbbHXIIg+Cexd9ISsvo1mwBOHsqSdOxtHstd37xdFWygOurjDr+pKpqiRyaGrX5b
         ie+vkgpV4Fc88UVq2p1yDt/DiQmHue+b+UFJ2VMqOm/9lc233MCR9QRwHur7T0DRi1EV
         llPA==
X-Gm-Message-State: APt69E3HHpoYxGMKByF6lHLDUOXXLT6BWYWNjzQ7BNwDi1dvE9Bu5Rid
        kGukmib9DiTsbFyHujMfUCg6LQ==
X-Google-Smtp-Source: AAOMgpffwE5+Bmtm0xNDwZ24ckZCg8pCgdoj6RrpiH8aLeAIwACD2EDa6fCwib5IIOYzYpAc083PGw==
X-Received: by 2002:a1c:9e8a:: with SMTP id h132-v6mr2863768wme.48.1530124091118;
        Wed, 27 Jun 2018 11:28:11 -0700 (PDT)
Received: from localhost.localdomain (x590e4475.dyn.telefonica.de. [89.14.68.117])
        by smtp.gmail.com with ESMTPSA id m185-v6sm5730056wma.36.2018.06.27.11.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jun 2018 11:28:10 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        gitster@pobox.com, git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com
Subject: Re: [PATCH v3 1/2] t3418: add testcase showing problems with rebase -i and strategy options
Date:   Wed, 27 Jun 2018 20:28:05 +0200
Message-Id: <20180627182805.28375-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.273.g57f1ecce9c
In-Reply-To: <20180627154804.3743-2-newren@gmail.com>
References: <20180627073623.31725-1-newren@gmail.com> <20180627154804.3743-1-newren@gmail.com> <20180627154804.3743-2-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index 03bf1b8a3b..11546d6e14 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -74,6 +74,38 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
>  	test -f funny.was.run
>  '
>  
> +test_expect_failure 'rebase -i --continue handles merge strategy and options' '
> +	rm -fr .git/rebase-* &&
> +	git reset --hard commit-new-file-F2-on-topic-branch &&
> +	test_commit "commit-new-file-F3-on-topic-branch-for-dash-i" F3 32 &&
> +	test_when_finished "rm -fr test-bin funny.was.run funny.args" &&
> +	mkdir test-bin &&
> +	cat >test-bin/git-merge-funny <<-EOF &&
> +	#!$SHELL_PATH
> +	echo "\$@" >>funny.args
> +	case "\$1" in --opt) ;; *) exit 2 ;; esac
> +	case "\$2" in --foo) ;; *) exit 2 ;; esac
> +	case "\$4" in --) ;; *) exit 2 ;; esac
> +	shift 2 &&
> +	>funny.was.run &&
> +	exec git merge-recursive "\$@"
> +	EOF
> +	chmod +x test-bin/git-merge-funny &&

You could use the 'write_script' helper function here.

> +	(
> +		PATH=./test-bin:$PATH &&
> +		test_must_fail git rebase -i -s funny -Xopt -Xfoo master topic
> +	) &&
> +	test -f funny.was.run &&
> +	rm funny.was.run &&
> +	echo "Resolved" >F2 &&
> +	git add F2 &&
> +	(
> +		PATH=./test-bin:$PATH &&
> +		git rebase --continue
> +	) &&
> +	test -f funny.was.run
> +'
> +
>  test_expect_success 'rebase passes merge strategy options correctly' '
>  	rm -fr .git/rebase-* &&
>  	git reset --hard commit-new-file-F3-on-topic-branch &&
> -- 
> 2.18.0.9.g431b2c36d5
> 
> 
