Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5685C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 18:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237715AbhLTSdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 13:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbhLTSdh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 13:33:37 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43718C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 10:33:37 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bj13so17091767oib.4
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 10:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RwptB7bMD7uCa4a2t6n0jSmy9JkiVsNdnH/KHvtRqgk=;
        b=Ts0rQv80Tjpp8qJN6fh1EDhHbByaMEU3Gu8vD+3CfM/bUJGi4bfujf8u8nzVcBUKbw
         Ycd/SaDC8+81lU9G7bHUEIFCgTWPnePxYYGfrJgJnTxGwCzdcXqfhXSWs98ibW6TZV3K
         rXm/pBtWpZLPifEBB+JnJdiIHCODFRT0+9AvL7ZChM0T7NJcIEIKjguJ9dSvAanntLw7
         wxDGy2ayqf1tEW44glEXp3kGxBEl9h5eTZFTO+AGNtNB5llDfyslgtiZ9CWD3nBY1MIp
         7fOTMS50kGKN0DLt4NROh1AAXtkGbBALKAc+yZ8SO7m4fes4nibXSoX+NuuTmqCwvcrR
         gQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RwptB7bMD7uCa4a2t6n0jSmy9JkiVsNdnH/KHvtRqgk=;
        b=ExSlU+9gOImtx01S7kS1CgWZ4yKBqcoZedTdjI6I1jzPuRGF3ckli+vasJrpVVr9rA
         go9mLbaKd7pGtxTAmaCQfvxlhEQcIKZOxHdoB2ePJQgcB/2OgmtTLCPBV4f7luTxdfmD
         uP1NW91P2Mjz9ZgLk5sy3s2KRB2y27gDNkOoZEm5Z7fPP9Af+zQW8c5A3PMp6H9yAscW
         rl30mPVxYUszrvfqlTiifemZqBM3jnFGj1y3Yr3NulrnC4GJqUDqDM1Utkc6N3l13DJx
         mG9t5kPb2DNNbOsC9GN9Rvsg93rLTPQ0868VtHHY8FlWTxyQ2vdrwJv1Z1zcokvhOhxd
         x8ng==
X-Gm-Message-State: AOAM532WZ+UxX5E6iouiitONGFvp1GEKqWQSgZhmQqRvgL8yWnIe9F9f
        Sevo1TdHVLHZaCwQKDN6qgzTRiCL4P4=
X-Google-Smtp-Source: ABdhPJwRxao0RNtEzFWMMHKkHtSj/iaB5deRc5zDQ5T8hxghKI5nIPjR3cOawscO1nxCnCzyNk06hA==
X-Received: by 2002:aca:a941:: with SMTP id s62mr206087oie.87.1640025216472;
        Mon, 20 Dec 2021 10:33:36 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1dd9:8fb3:37da:4055? ([2600:1700:e72:80a0:1dd9:8fb3:37da:4055])
        by smtp.gmail.com with ESMTPSA id m23sm3319584otj.39.2021.12.20.10.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 10:33:36 -0800 (PST)
Message-ID: <dbc75e29-aceb-051a-8235-e5c912172aed@gmail.com>
Date:   Mon, 20 Dec 2021 13:33:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 5/8] t5326: extract `test_rev_exists`
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1639446906.git.me@ttaylorr.com>
 <73faab9f429221b7be88ea88ce59bc47afb57348.1639446906.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <73faab9f429221b7be88ea88ce59bc47afb57348.1639446906.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/13/2021 8:55 PM, Taylor Blau wrote:
> To determine which source of data is used for the MIDX's reverse index
> cache, introduce a helper which forces loading the reverse index, and
> then looks for the special trace2 event introduced in a previous commit.
> 
> For now, this helper just looks for when the legacy MIDX .rev file was
> loaded, but in a subsequent commit will become parameterized over the
> the reverse index's source.
> 
> This function replaces checking for the existence of the .rev file. We
> could write a similar helper to ensure that the .rev file is cleaned up
> after repacking, but it will make subsequent tests more difficult to
> write, and provides marginal value since we already check that the MIDX
> .bitmap file is removed.

...

> +test_rev_exists () {
> +	commit="$1"
> +
> +	test_expect_success 'reverse index exists' '
> +		GIT_TRACE2_EVENT_NESTING=10 \

Very recently, b8de3d6 (test-lib.sh: set GIT_TRACE2_EVENT_NESTING,
2021-11-29) made it to master and sets this to 100 across the test
suite, so you don't need this line.

> +		GIT_TRACE2_EVENT=$(pwd)/event.trace \
> +			git rev-list --test-bitmap "$commit" &&

This use of $commit has me worried. Do the tests become too flaky
to changes in how we choose commits for the bitmaps? Does that
require callers to be too aware of the refstate when creating the
bitmaps?

Perhaps just `git rev-list --use-bitmap-index [--objects] HEAD`
would suffice to generate the trace event?

> +		test_path_is_file $midx-$(midx_checksum $objdir).rev &&
> +		grep "\"category\":\"load_midx_revindex\",\"key\":\"source\",\"value\":\"rev\"" event.trace
> +	'
> +}
> +
>  setup_bitmap_history
>  
>  test_expect_success 'create single-pack midx with bitmaps' '
>  	git repack -ad &&
>  	git multi-pack-index write --bitmap &&
>  	test_path_is_file $midx &&
> -	test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
> -	test_path_is_file $midx-$(midx_checksum $objdir).rev
> +	test_path_is_file $midx-$(midx_checksum $objdir).bitmap
>  '
>  
> +test_rev_exists HEAD
> +

Perhaps this helper would be more appropriate as a helper method
within a test, rather than creating a test of its own? I think
it looks better to include it next to the setup lines, something
like

test_expect_success 'create single-pack midx with bitmaps' '
	git repack -ad &&
	git multi-pack-index write --bitmap &&
	test_path_is_file $midx &&
	test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
	test_rev_exists HEAD
'

This would lead to a failure within 'create single-pack midx
with bitmaps' which is easier to find in the file.

Thanks,
-Stolee
