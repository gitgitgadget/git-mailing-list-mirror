Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FA7C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 13:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EFE260240
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 13:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbhGMNG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 09:06:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:56845 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236276AbhGMNG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 09:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626181404;
        bh=P4/Fsbo7ev4ujZVFVNlPobL9p9VyulYDjMw755o8LoI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=C/iQhXNGvUVsfsAcxIObwhpGYQgofn5u8XhbFP0P8yCMo2WqWRD3BfkfRS/zmZdZg
         olAACFStc4QgVaWhNLSGinJSub0gxAbmAr4FavNg9WKdxPt8h8Xa/9Ys4bEGoVzyN5
         7FOwccQQXsrIxGuAfiN+CXm9SH7fUu1lxHULwBTI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.219.153] ([89.1.215.141]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRTN9-1lonU11QGL-00NUwm; Tue, 13
 Jul 2021 15:03:24 +0200
Date:   Tue, 13 Jul 2021 15:03:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     randall.becker@nexbridge.ca
cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [Patch 1/3] config.c: add conditional include based on
 worktree.
In-Reply-To: <20210712223139.24409-2-randall.becker@nexbridge.ca>
Message-ID: <nycvar.QRO.7.76.6.2107131502360.76@tvgsbejvaqbjf.bet>
References: <20210712223139.24409-1-randall.becker@nexbridge.ca> <20210712223139.24409-2-randall.becker@nexbridge.ca>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2oDB1rQodAMS+g4bFmWQ7n/UTDaBQelJBcuKYoE0GoggZOo3f8V
 Z7RRaaxsDiuIqzHcq3T5YntRNr4J5KdJPsKhKt5b2Tr/ml+IScnbqQeM3I8kD9pPW19nFub
 6NQHf5QESJ3K+DrPqx4ufN5fjE7fbt3jv8Z96z+TDj56gJwToKGgONvpV4gvjUMgI8QYdS3
 SAqRQNZB/cH9fEBgkxkkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HCoCJnE6RuE=:90AQrMqWEkABUxvKxTfJnk
 /kvcezfmoKYVDV/z6bHP5bb0NfTUMYbL8fomY8FfoCRSW7ext+Vmov9FaNJKa4HLnBzlBadge
 /lP5JxhHopL1U9avu4Ytt1hgxlDZNn7wO9HFj0PHA91QderCvaacM+7SV7rhB97dOJQlY7AxE
 0OHP8y7gHcSasRq2IPzsImlyx+14su9cCyD7wlha1G36YXNsXlPgh4MtMIEzRoPSK+OQzl3YK
 DejuKxRvja8ddZguIxV8rQCU3IKc9WMmbNK6YHanriVYTQoJCvYZQs1+vrW0xf/G7JhcjHEID
 AP2sAgYqsRXFoOKIGp8SQiiPeCSqPi5ecxJa7u4yKJDNeq0anpIlVs4qtb/C9ut/3YVN8mRCc
 jFVX0iCLXAe7iWAfsz2iPanGbkCeKYdQGrtF7y/3TzH3R3xdtNx//uB4za1K7PAfaA0y88nWE
 7jkbo/YAgGMrs9LfsvjKZlsycr0SUw96tUvPlnudAY9fOGizV24XJPoQ7YIQLNBT1AuZaazcv
 2488isGdtAO5zEGJ9R1pMQkI7lOuqkQ6OYj1YhEDjv8jJFQzdD+Nw6E6ah/bfpHYQnDyiojdR
 BQi0fTVaX74x1hbAiWAneE03Y3GaMU89i6E8zC/OIYrIlfwH9ijhTXHEHtci24TwMFJYkWVP6
 hJvHyYZv43byyyV2/qi90Y0o+DrrscFtR8IPL121o6CwY08+ZaqEx+GE0vOaGI+W8aRzCgxGp
 9NRG5QZdoiosV0/1mRuJF2VXERcTlgGH2/25vAsaSkcSMssW/jxuuWXoMknChBnaYCLZ89ghA
 FLLFUIPGHYJW3VaoZNtXGvesSCQeTIBMojfJ6uc/x/3HGqvESWfOkVqY3rjeNOxnEWyxTZpDn
 33aMm1sEoG/JB16WZJCDOJ7DYrg9ggYnWWC8zoAXhDktn8sGQBkU7xwshbtQtezdvm6kPjQXB
 /Z7es+8VxYN3zI54/fnhqZC4N4x3xWiA0MfY2Gv4BVlCKF6QKBeTqo65funndTEswQv9XJxuq
 IjGnKnw2e6khcUxW5dewRFviYJJU3yMZhj/UtfqWT//C0ZJPmQ6+9F7rWVW8FwwCfu8OnNuAM
 v0D7BnR9pKSHjyF2CNgBoZh4xMB0KQxHl3jLYRqwhWwXVYFaX2bDa7jFg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall,

On Mon, 12 Jul 2021, randall.becker@nexbridge.ca wrote:

> @@ -300,6 +358,11 @@ static int include_condition_is_true(const struct c=
onfig_options *opts,
>  		return include_by_gitdir(opts, cond, cond_len, 0);
>  	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len=
))
>  		return include_by_gitdir(opts, cond, cond_len, 1);
> +	else if (skip_prefix_mem(cond, cond_len, "worktree:", &cond, &cond_len=
))
> +		return include_by_worktree(opts, cond, cond_len, 0);
> +	else if (skip_prefix_mem(cond, cond_len, "worktree/i:", &cond,
> +				 &cond_len))
> +		return include_by_worktree(opts, cond, cond_len, 1);

Thank you for not forgetting the `/i` case.

Ciao,
Dscho

>  	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len=
))
>  		return include_by_branch(cond, cond_len);
>
> --
> 2.32.0
>
>
