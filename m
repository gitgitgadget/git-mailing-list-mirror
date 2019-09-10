Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 457361F463
	for <e@80x24.org>; Tue, 10 Sep 2019 12:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390679AbfIJMtZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 08:49:25 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:36825 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbfIJMtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 08:49:25 -0400
Received: by mail-wr1-f52.google.com with SMTP id y19so19983543wrd.3
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 05:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=11P8e2RiObt4FkBqY8RF2tnxbzJscTe5KsoA+qqRkdI=;
        b=WirklYeefmt/FOIDZ/ZSoT+qmIlltjY1nLKwLh4IQrsGCc6DGWF8SgPaeEFL9TKhuL
         iA6eMQYtDSLDMOdjFgEA7Xq9rHGYLQbi42cKc9rILV/h4CnSssCQE3Z2sfrTNAUtvK1R
         fLUgtJkivAVSJTFJ041ZUUJJaZK4n+EQfSnTtXFswlG7dz41IAbqyVmOEG6WEXJ3augh
         /eTBDlin1T0TBFUd22kEwXNKcPDEpWi6ff/IGh6IGbagykdgQ2yydnAuymJ8bgnrtwW0
         0JJU/+qfxAWWUDsMks17IyqQ33ZTbNo0MhLp+vbV8vECZMic10vT6uxgYnizascSqpaw
         tH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=11P8e2RiObt4FkBqY8RF2tnxbzJscTe5KsoA+qqRkdI=;
        b=QV9919YK6D5ZOYmXOYzdJIfCo/RXmq7N8RimME/b3hVQ2etMOkjlVDvGB2uB96UssK
         llxPxk2eWwoolUk8hlsbdJjUJO/DAGdgW4VaIr3DH4Mg3SbUn1rztfnene5bWNhzxxwU
         qaCxketADlXQ63qwOwXKbaUDesWq8P9YKXJ35+X3ttfe9ICp7zuQ4lsGAvSMH8X5KFYY
         VVlFtDgaQ3nyWJiJUiHD73mNFDTNVL7jeP/x36gD5vjxa5Vu+ySUsVuNZ469f7zf5vct
         yY3792zPkme8oAoW7NAajR9IC673fbLgQkres4r6Nv/FUeROk91Yvb6C1Atq7Rs1W/te
         Y8og==
X-Gm-Message-State: APjAAAWzqgTFFjZb1bqkTxWuTctAfNVBuqwXL+TrR+fMOEVVPp3F0TAx
        j/J/i2Ky0+FQsxbaShtKokI=
X-Google-Smtp-Source: APXvYqxvPvEJGnCH9GvQSUWi/dk2Le7u1YznWFT7IpkFBwMPp31HgHOV2A+ykUAQqRZXLJYvowBx3A==
X-Received: by 2002:adf:d4c5:: with SMTP id w5mr25709383wrk.280.1568119763190;
        Tue, 10 Sep 2019 05:49:23 -0700 (PDT)
Received: from szeder.dev (x4dbe1e6e.dyn.telefonica.de. [77.190.30.110])
        by smtp.gmail.com with ESMTPSA id e12sm6920278wrw.37.2019.09.10.05.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 05:49:22 -0700 (PDT)
Date:   Tue, 10 Sep 2019 14:49:20 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2] cache-tree: do not lazy-fetch merge tree
Message-ID: <20190910124920.GI32087@szeder.dev>
References: <20190903194247.217964-1-jonathantanmy@google.com>
 <20190909190130.146613-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190909190130.146613-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 09, 2019 at 12:01:30PM -0700, Jonathan Tan wrote:
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index 6415063980..3e434b6a81 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -492,6 +492,20 @@ test_expect_success 'gc stops traversal when a missing but promised object is re
>  	! grep "$TREE_HASH" out
>  '
>  
> +test_expect_success 'do not fetch when checking existence of tree we construct ourselves' '
> +	rm -rf repo &&
> +	test_create_repo repo &&
> +	test_commit -C repo base &&
> +	test_commit -C repo side1 &&
> +	git -C repo checkout base &&
> +	test_commit -C repo side2 &&
> +
> +	git -C repo config core.repositoryformatversion 1 &&
> +	git -C repo config extensions.partialclone "arbitrary string" &&
> +
> +	git -C repo cherry-pick side1
> +'
> +

Sidenote, just curious: did you originally intend to add this test
before the test script sources 'lib-httpd.sh', or you were about to
append it at the end as usual, but then noticed the warning comment
telling you not to do so?

>  . "$TEST_DIRECTORY"/lib-httpd.sh
>  start_httpd
