Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31F4C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 10:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D2F12072C
	for <git@archiver.kernel.org>; Thu, 21 May 2020 10:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvukE+7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgEUKVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 06:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgEUKU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 06:20:58 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C926DC061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 03:20:56 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id p4so2790203qvr.10
        for <git@vger.kernel.org>; Thu, 21 May 2020 03:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hdHNBcHREa7fGowvPR+4FWA8J0RGJBRTl0W5/CxtHEQ=;
        b=HvukE+7VfFanC1vdL7S3sbavybTuHTNjAF7wjvAxi5Fa1BXna1meWxUqY7UAY4Z52P
         0NgJEY3ICMiXN7NFyJ7CXuYDW6If2L17R9OEA6M8qPcNoJ7R0uofPoduURghw+5L61qQ
         CJhGXFDtsQk6/WmUn5+imyLC/j/MplAJo9CdNVvfmXYx6KwgnS3VNRCdVDxlBz1dS4yM
         zs/ICIj+XJT7mMsaInZ9YfQHLb8Zz4888QVhZxLTGuf4RjZrKY3ux9Yk61JH948SLviw
         Zhw4nTaL6C8IfAkAQm6fzO+GRRy9c1XaZk8vW/YN2VRQLU44Cuql55nQiBx4d5m2jsNX
         Eizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hdHNBcHREa7fGowvPR+4FWA8J0RGJBRTl0W5/CxtHEQ=;
        b=H3M3eynVjtCl5gdVqse+9BgKv3Txb0faEDoiEspqZGlNFlU0GJHhA79cjJ1cStVU0G
         bUrAvBs7p3PywJ4pThpUZTv+jzY5RmJF2wX22SeZBX1w+tv8LW9yYt3o6d4uOsKnswwC
         3MJTvrmtbPk8xroXvxXbS6kOAc0GuGSbAdcypoamzV/jFETh8VUaYb9an7OG9zwIPTu6
         GMM6g8vij2HjyAQmY+ykkh9uBwQrXMAsnJ7SGlpfaiMTXUjXrwtmTzAJT5qabPpdgLc9
         tvIQrm1WtcUUihx1LRsMlcPTntZLzRZ8rxa2ZtyKT4wGbajGMytvDoWE6NeIZmfv0Yyt
         sFhw==
X-Gm-Message-State: AOAM533xM3QYT585BgB/ec8MRYK/wpB8dFwSRvXlcKq38/txHmjuYq2E
        yzXIM77GNxnupDn/Of1/cFxQXMgq
X-Google-Smtp-Source: ABdhPJxLHZ2lW2n22A5Tt1C03a/AT0kuWMpmWiU57m0+MXd52aB7YHpO76EbdVR1R92yiCx+LPV8Cg==
X-Received: by 2002:ad4:580b:: with SMTP id dd11mr9315202qvb.145.1590056456016;
        Thu, 21 May 2020 03:20:56 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id q10sm5241023qtk.54.2020.05.21.03.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 03:20:55 -0700 (PDT)
Date:   Thu, 21 May 2020 06:20:53 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] t1450: increase test coverage of in-tree d/f
 detection
Message-ID: <20200521102053.GA578930@generichostname>
References: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
 <d963242a-72f3-7f42-7c95-ea5148f74804@web.de>
 <xmqqpnbduiec.fsf@gitster.c.googlers.com>
 <938f0818-7e57-b883-009f-01db88ef8f65@web.de>
 <xmqqh7wovoop.fsf@gitster.c.googlers.com>
 <aab9512b-a70a-0f5b-5cdc-5d40acd343d0@web.de>
 <2937d635-52a9-5e69-b3d2-fbde415b7315@web.de>
 <xmqq4ksmsaks.fsf@gitster.c.googlers.com>
 <106c58e1-9c74-46e3-c83a-88eee114d9d6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <106c58e1-9c74-46e3-c83a-88eee114d9d6@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René,

On Thu, May 21, 2020 at 11:52:28AM +0200, René Scharfe wrote:
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 91a6e34f38..9640ac8ff2 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -257,21 +257,33 @@ test_expect_success 'tree object with duplicate entries' '
>  	test_i18ngrep "error in tree .*contains duplicate file entries" out
>  '
> 
> -test_expect_success 'tree object with dublicate names' '
> -	test_when_finished "remove_object \$blob" &&
> -	test_when_finished "remove_object \$tree" &&
> -	test_when_finished "remove_object \$badtree" &&
> -	blob=$(echo blob | git hash-object -w --stdin) &&
> -	printf "100644 blob %s\t%s\n" $blob x.2 >tree &&
> -	tree=$(git mktree <tree) &&
> -	printf "100644 blob %s\t%s\n" $blob x.1 >badtree &&
> -	printf "100644 blob %s\t%s\n" $blob x >>badtree &&
> -	printf "040000 tree %s\t%s\n" $tree x >>badtree &&
> -	badtree=$(git mktree <badtree) &&
> -	test_must_fail git fsck 2>out &&
> -	test_i18ngrep "$badtree" out &&
> -	test_i18ngrep "error in tree .*contains duplicate file entries" out
> -'
> +check_duplicate_names () {
> +	expect=$1 &&
> +	shift &&
> +	names=$@ &&

It doesn't really make sense to use $@ here since we're not using the
argument list behaviour of $@; we're just expanding it normally. I would
replace this with $* instead.

> +	test_expect_$expect "tree object with duplicate names: $names" '
> +		test_when_finished "remove_object \$blob" &&
> +		test_when_finished "remove_object \$tree" &&
> +		test_when_finished "remove_object \$badtree" &&
> +		blob=$(echo blob | git hash-object -w --stdin) &&
> +		printf "100644 blob %s\t%s\n" $blob x.2 >tree &&
> +		tree=$(git mktree <tree) &&
> +		for name in $names
> +		do
> +			case "$name" in
> +			*/) printf "040000 tree %s\t%s\n" $tree "${name%/}" ;;
> +			*)  printf "100644 blob %s\t%s\n" $blob "$name" ;;
> +			esac
> +		done >badtree &&
> +		badtree=$(git mktree <badtree) &&
> +		test_must_fail git fsck 2>out &&
> +		test_i18ngrep "$badtree" out &&
> +		test_i18ngrep "error in tree .*contains duplicate file entries" out
> +	'
> +}
> +
> +check_duplicate_names success x x.1 x/
> +check_duplicate_names success x x.1.2 x.1/ x/
> 
>  test_expect_success 'unparseable tree object' '
>  	test_oid_cache <<-\EOF &&
> --
> 2.26.2
