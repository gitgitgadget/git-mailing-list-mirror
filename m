Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1F4D1FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 19:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753694AbdFVTx6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 15:53:58 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36729 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbdFVTx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 15:53:57 -0400
Received: by mail-pf0-f195.google.com with SMTP id y7so4409431pfd.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 12:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VIfCw6Px371X5+dZShl/wLoPPRk5a3k1H2Qul9UT8xA=;
        b=QhURDdcafk7kKvQlI2nIU6Gvv9kJzFtEXv5yznTWDogIxLUZDMvv8+oJvoqRRzZ/7e
         XVBXlEzkSuo/lsqwi+qPy+qqzG702/PsE1RaDKfE1oPUsVWB82N/7Vhhjmrt7PrV4l+j
         2K/DCxJCaantxe+t3vC7cs6xb7Mjhlchyn7eg7Wqeqce1qubDTIYf85hxQW/soZZbeZh
         5IcGthLroin7Oq8HVpjRlCcafiuPx8crxkP8yqoimkN3b+z6OfosznR/FPU6WqShBcTr
         9foYKJywsLD89xXqPqZ1Z+h5WV48W/O9OZHXS81w9BAFKU6kyhZvXqyes/VgEW/OKE/g
         zqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VIfCw6Px371X5+dZShl/wLoPPRk5a3k1H2Qul9UT8xA=;
        b=iv8F/BmZajJ/5kljUvUc7/gvHklj4csuj/QWoNFTCB89hHCC8PkKcktEsAeY8vAbAi
         VWnTyys/msScQTkd5tryrfKlOef9KR56xaJ556tU9I8X8D5/x5XpO9pPjpVpvMBTwkjt
         jmBbLczjkns1ILEr2jarc+TbwEjXxz3qP4k+ApHehVJ+nTPpdQyx/z8f5o8vBiLXSxas
         95BtWGYr3mSMVLyOpfu4qOdr56xcgTWWsGVyUtDGrYXnMDnHcS9vee2w4XDa3fewQbZS
         ngzL2voOYQ8V1X0e9dJNuuuM39KGmr6HMmgz8NxjPZxK9Sxy3kRPbGFf0lU3uRoqxcRN
         D2Iw==
X-Gm-Message-State: AKS2vOy3m2oKwkyY0zah2cEg+ZuKZRQk4r8z8AZH5F/STDvYjC+ejx3v
        bk5n4jRZcS1LR0wX30c=
X-Received: by 10.99.99.193 with SMTP id x184mr4238791pgb.13.1498161236465;
        Thu, 22 Jun 2017 12:53:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id c75sm6170026pga.38.2017.06.22.12.53.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 12:53:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] t1700: make sure split-index respects core.sharedrepository
References: <20170622190158.13265-1-chriscool@tuxfamily.org>
        <20170622190158.13265-3-chriscool@tuxfamily.org>
Date:   Thu, 22 Jun 2017 12:53:55 -0700
In-Reply-To: <20170622190158.13265-3-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 22 Jun 2017 21:01:58 +0200")
Message-ID: <xmqqzicziyss.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Add a test to check that both the split-index file and the
> shared-index file are created using the right permissions
> when core.sharedrepository is set.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/t1700-split-index.sh | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index af3ec0da5a..a52b92e82b 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -370,4 +370,16 @@ test_expect_success 'check splitIndex.sharedIndexExpire set to "never" and "now"
>  	test $(ls .git/sharedindex.* | wc -l) -le 2
>  '
>  
> +test_expect_success POSIXPERM 'split index respects core.sharedrepository' '
> +	git config core.sharedrepository 0666 &&
> +	: >seventeen &&
> +	git update-index --add seventeen &&
> +	echo "-rw-rw-rw-" >expect &&
> +	test_modebits .git/index >actual &&
> +	test_cmp expect actual &&
> +	newest_shared_index=$(ls -t .git/sharedindex.* | head -1) &&

Hmph.  Don't you want to make sure all of them, not just the latest
one, have the expected mode bits?

> +	test_modebits "$newest_shared_index" >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
