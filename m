Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 818831F462
	for <e@80x24.org>; Tue, 11 Jun 2019 23:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437000AbfFKXDC (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 19:03:02 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:44383 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436837AbfFKXDC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 19:03:02 -0400
Received: by mail-pf1-f201.google.com with SMTP id 5so10609068pff.11
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 16:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/2EsORUQ9j4j8979v9BXj94LxZTF9xgguzrPa/Xk7Hw=;
        b=qzx5iPwV4Hr9ez83Oh04OV8lwezfMMEpe2bETNTga6kRWfVbhnwS/xsItuTbCC0gqj
         APbqLP6kGEDo6yHUJYxdaGx+gJ1uDHMTnOaeCrMWCox+Vk6vJg1kdtAHNnYgylOaoUyp
         pb3kGrB6Br7riSIu/2nJLzq36FZJV1piksTGoGZPT/t9pROySlVqG5eIklkTFFN0kMzz
         lrs9zzoL5DkKDeviRw4ki/SINPwjOZ/ptkBlKHvckniSTjSohQByiuEg89oWRq4Sicgg
         fmr5lOGaYG4bJcGcOmCeerrCCmA5xa452gmnvVzRWxQhiD+ph7CEIKHPAEZCHZUfaVTl
         0Gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/2EsORUQ9j4j8979v9BXj94LxZTF9xgguzrPa/Xk7Hw=;
        b=rwVPWawpAaY3+Z2Iop3pvPjjbdVKuZBGL6LL0HTxAg+SSFIR6nPjueuWLb5X9I666f
         OML5zcLYKiQ+rSJl95+FAUMklxXtV1cZ85TgbNW7gcAjGlpBHU31CLiPpuQ7NDvdpxhb
         BhW0byNw5RAN0u35epLk6Pj5sVUprVy1NT6Co+PYd3OIUMVUa+zBQ9pvQiOSgRJ+obxp
         lKfVKWoL2xlMrWLvovx7T3cVbiIrTu08GiDMuit99GfioxZD7H/OIa/05fASZnfciQi1
         R6E4W4+oanizjaIfiL/+COwKMdw5k9nQSFFvpmUSiWgSVjH/1SmSTnQ3JwstYRINhnmb
         b42w==
X-Gm-Message-State: APjAAAVukwLhy5+kFOKoz+5Megz4gy8ev1LDpeV2CI0mKqomOiBc7FSD
        BCiZ5h007RYyftG53pJe6XODH/CELoPbj6wIPGqL
X-Google-Smtp-Source: APXvYqx58xG6nCeu9Q7zhTk/UuH35l1SgoDy6ZpedKUGAFt4ao6hq7z2S/YikhvCau+n7ti59dJ5gzu2+Wfc7oEtIgt0
X-Received: by 2002:a65:4806:: with SMTP id h6mr21524518pgs.299.1560294181192;
 Tue, 11 Jun 2019 16:03:01 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:02:55 -0700
In-Reply-To: <20190609224400.41557-4-sandals@crustytoothpaste.net>
Message-Id: <20190611230255.146381-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190609224400.41557-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: Re: [PATCH 03/10] t1450: make hash size independent
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sandals@crustytoothpaste.net
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -84,7 +86,7 @@ test_expect_success 'branch pointing to non-commit' '
>  test_expect_success 'HEAD link pointing at a funny object' '
>  	test_when_finished "mv .git/SAVED_HEAD .git/HEAD" &&
>  	mv .git/HEAD .git/SAVED_HEAD &&
> -	echo 0000000000000000000000000000000000000000 >.git/HEAD &&
> +	echo $ZERO_OID >.git/HEAD &&
>  	# avoid corrupt/broken HEAD from interfering with repo discovery
>  	test_must_fail env GIT_DIR=.git git fsck 2>out &&
>  	cat out &&

ZERO_OID doesn't seem redefined to the SHA256 variant when being tested
under SHA256. Maybe you need a test_oid invocation here.

I couldn't verify this, though - do you know if there is a way for me to
run the tests with SHA256 instead of SHA1?

> @@ -417,13 +426,12 @@ test_expect_success 'force fsck to ignore double author' '
>  '
>  
>  _bz='\0'
> -_bz5="$_bz$_bz$_bz$_bz$_bz"
> -_bz20="$_bz5$_bz5$_bz5$_bz5"
> +_bzoid=$(printf $ZERO_OID | sed -e 's/00/\\0/g')

Same comment here.

> @@ -631,10 +639,12 @@ test_expect_success 'fsck --name-objects' '
>  
>  test_expect_success 'alternate objects are correctly blamed' '
>  	test_when_finished "rm -rf alt.git .git/objects/info/alternates" &&
> +	path=$(test_oid numeric) &&
> +	path=$(test_oid_to_path "$path") &&

Double assignment to path?
