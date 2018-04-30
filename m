Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 113F221841
	for <e@80x24.org>; Mon, 30 Apr 2018 11:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752080AbeD3Lii (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 07:38:38 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37855 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbeD3Lih (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 07:38:37 -0400
Received: by mail-qt0-f196.google.com with SMTP id q13-v6so9655401qtp.4
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 04:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dZF7KELy6h7ylM4nZ2fMP+oO0Ococy1BO8bnse4fGuc=;
        b=Fysqm3doGxReyKJWfxxW7AwcJiHYzazIzxdafekVunPpxiB6NAEgZJlSbvbEEgVuvS
         OrbMymOm8o3wHDxgG5VGWZvA1YJ0mpgZ+IweWaaXhzvSuR3flCFwNlv4VQp9YKKQXdgL
         YSlBS3WeVZplg72SKpVzGCMAtyFX/gFSQuqy0aOFdmFk6CArQnbTvFwkFn0QNfIGv53C
         DUW0EeoE1QK3XMB+XQ5JcNq8sXjWVI4mWFHEEMECR7W1IiiWgXOeyxsn0vJ0SeaCXBkt
         GZ3AGFDZVjjFPm/IAKFR4YYTvZtU0XmA2N4FudF542oluLgkY9HqrochlO18aj5/+w2K
         +8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dZF7KELy6h7ylM4nZ2fMP+oO0Ococy1BO8bnse4fGuc=;
        b=Hb46rD0NHrjEhdteG4FzYbj49YI1wV5kbHnueWehVahSK7XqqJyNx+h56EVSkkbD/f
         bm5IV5T8lqm+vphlizt5cBXqrhlKtRnIbZBnGW24xpEHsy7MOvLK3xWGovl4IreoZrKx
         jj6lyBwhv7PSuxWGltFCmyh+xBwM0TD0cFo8L8YX8k6cOStGnyZZ3mixPQSqHB/Vn1jM
         61O+Bck9C3bn3l9pbY+a/2vjT56d0hz3CC630iLewn3EXziI/i5PQZxEtL/YMi787vp1
         zBuT0sHIoqOeKnIeN1Lz/KzduSGDlctq8jtiZl4BU563sBaO7oJuhlEYYPk+98V/Azmc
         AukQ==
X-Gm-Message-State: ALQs6tAfUTfURpNNW3e7Bc44ZvEseVp4KmbF10zlPA2tToADn4fAzBJG
        xJcXJDydbQKBZOI0jQXxvIzZDyvz
X-Google-Smtp-Source: AB8JxZqvauDyRSfKC8i6f9GBxVMdCVJVsDix5CskoPnBrHM2h7mVxQ7Y954Vu1AEEMDX5CS3ZN5SzA==
X-Received: by 2002:a0c:ab45:: with SMTP id i5-v6mr10922423qvb.188.1525088316052;
        Mon, 30 Apr 2018 04:38:36 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id x127sm5233268qke.87.2018.04.30.04.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 04:38:35 -0700 (PDT)
Subject: Re: [PATCH] coccinelle: avoid wrong transformation suggestions from
 commit.cocci
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
References: <20180430093153.13040-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <82a385c3-62fe-e471-73ae-0c0448640f3b@gmail.com>
Date:   Mon, 30 Apr 2018 07:38:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430093153.13040-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/30/2018 5:31 AM, SZEDER Gábor wrote:
> The semantic patch 'contrib/coccinelle/commit.cocci' added in
> 2e27bd7731 (treewide: replace maybe_tree with accessor methods,
> 2018-04-06) is supposed to "ensure that all references to the
> 'maybe_tree' member of struct commit are either mutations or accesses
> through get_commit_tree()".  So get_commit_tree() clearly must be able
> to directly access the 'maybe_tree' member, and 'commit.cocci' has a
> bit of a roundabout workaround to ensure that get_commit_tree()'s
> direct access in its return statement is not transformed: after all
> references to 'maybe_tree' have been transformed to a call to
> get_commit_tree(), including the reference in get_commit_tree()
> itself, the last rule transforms back a 'return get_commit_tree()'
> statement, back then found only in get_commit_tree() itself, to a
> direct access.
>
> Unfortunately, already the very next commit shows that this workaround
> is insufficient: 7b8a21dba1 (commit-graph: lazy-load trees for
> commits, 2018-04-06) extends get_commit_tree() with a condition
> directly accessing the 'maybe_tree' member, and Coccinelle with
> 'commit.cocci' promptly detects it and suggests a transformation to
> avoid it.  This transformation is clearly wrong, because calling
> get_commit_tree() to access 'maybe_tree' _in_ get_commit_tree() would
> obviously lead to recursion.  Furthermore, the same commit added
> another, more specialized getter function get_commit_tree_in_graph(),
> whose legitimate direct access to 'maybe_tree' triggers a similar
> wrong transformation suggestion.

Thanks for catching this, Szeder. Sorry for the noise.

> Exclude both of these getter functions from the general rule in
> 'commit.cocci' that matches their direct accesses to 'maybe_tree'.
> Also exclude load_tree_for_commit(), which, as static helper funcion
> of get_commit_tree_in_graph(), has legitimate direct access to
> 'maybe_tree' as well.

This is an interesting feature of Coccinelle. Happy to learn it.

> The last rule transforming back 'return get_commit_tree()' statements
> to direct accesses thus became unnecessary, remove it.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>

I applied this locally on 'next' and ran the check. I succeeded with no 
changes.

Thanks!

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>


> ---
>   contrib/coccinelle/commit.cocci | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit.cocci
> index ac38525941..a7e9215ffc 100644
> --- a/contrib/coccinelle/commit.cocci
> +++ b/contrib/coccinelle/commit.cocci
> @@ -10,11 +10,15 @@ expression c;
>   - c->maybe_tree->object.oid.hash
>   + get_commit_tree_oid(c)->hash
>   
> +// These excluded functions must access c->maybe_tree direcly.
>   @@
> +identifier f !~ "^(get_commit_tree|get_commit_tree_in_graph|load_tree_for_commit)$";
>   expression c;
>   @@
> +  f(...) {...
>   - c->maybe_tree
>   + get_commit_tree(c)
> +  ...}
>   
>   @@
>   expression c;
> @@ -22,9 +26,3 @@ expression s;
>   @@
>   - get_commit_tree(c) = s
>   + c->maybe_tree = s
> -
> -@@
> -expression c;
> -@@
> -- return get_commit_tree(c);
> -+ return c->maybe_tree;

