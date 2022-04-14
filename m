Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF26C433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 18:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244745AbiDNSkB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 14:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiDNSkA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 14:40:00 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB62A4FC7C
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 11:37:34 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t4so5517445pgc.1
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 11:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=H2Paec4y9kAwWl7y5fvt4lAMi056jAfZeAdY9PXQg0A=;
        b=Co/O3FyKs9dzDGlXwKoDBf/pBNQ4w5osWCy8VTdMO8ZbS3VzzTdRr7h6TJHSZuqdWa
         BP1us99t/neJAnQikGJnDuQ49Q4qcm0RQYe11NwmhcTSRqb8AZ6kzPohi57/pATupzjd
         X6goc8yN6pK7pJh+2CVoYfx4OpEj15x8X1Vd9FxhUflDHpIyLbXCaMedTxfUW+SYRKNC
         PC0gYtKBl32/pP8+ppdmJu/27fiQ1JukraVEK6mWweHJQady/i1kXn7bQdKBb48WUu8q
         5o6kTrqTJtxVeG8v0YFWa7yCPKG8eqKNwAD0IYW8LoMu3WceNWF//oVs4TI7+0Dtsa+Q
         wJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=H2Paec4y9kAwWl7y5fvt4lAMi056jAfZeAdY9PXQg0A=;
        b=03pt6YcSKoTcVXNeDTX7wIWuUaeBFNVfjQpvLXTwNWTRDgz5QPSecBAzJSUWRtqO73
         o3E3nn/qnAre5V7O7bq2/pQ6Y0vhYkIcMtj6FoqpkU28JyunyV9gYEMXrDkvPVop22In
         OSSJfgoo5p3Sd6vtzztGflsZZjTGtOoCHE1lM52QzBzHmVS9KqMNEUQwVRVWanTe6yoj
         hdjvXOJg2p7c1IOr4/i0xQxeAxyFoHe2z0VzpiNLvoAseF7zT7SSwY1gVXpc7iACtAuL
         W6vtHkAR+Czmux5P2jeP6kSPYPjj4nO3eOGSKd9p3WQUvFwFXgYQsj2IH9v+cI27pqqo
         7D7A==
X-Gm-Message-State: AOAM530JwAEk2Np0mo2Iyz/XHm7KeAgUzReaCx0ovryYrcgRqqZjgcfX
        Iq80bW3c5RRAbQqDOw6zADm9zw==
X-Google-Smtp-Source: ABdhPJz52nUTSFbM8aJLJi2ic3GdbXcHv0JcxuMHj95dmIo3+8lqGweymUzFJwZzdUajH2pvoGSuQw==
X-Received: by 2002:aa7:9019:0:b0:4fa:7532:9551 with SMTP id m25-20020aa79019000000b004fa75329551mr5342892pfo.26.1649961454029;
        Thu, 14 Apr 2022 11:37:34 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:c26e:8dc1:2f6e:26bc])
        by smtp.gmail.com with ESMTPSA id l13-20020a056a00140d00b004e13da93eaasm569742pfu.62.2022.04.14.11.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 11:37:33 -0700 (PDT)
Date:   Thu, 14 Apr 2022 11:37:26 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/4] t1092: add compatibility tests for 'git show'
Message-ID: <Ylhp5ubNco+oATOD@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
 <8c2fdb5a4fc3317c05324da54692036e36fc15f3.1649349442.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c2fdb5a4fc3317c05324da54692036e36fc15f3.1649349442.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.04.07 16:37, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 236ab530284..74792b5ebbc 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1151,6 +1151,22 @@ test_expect_success 'clean' '
>  	test_sparse_match test_path_is_dir folder1
>  '
>  
> +test_expect_success 'show (cached blobs/trees)' '
> +	init_repos &&
> +
> +	test_all_match git show :a &&
> +	test_all_match git show :deep/a &&
> +	test_sparse_match git show :folder1/a &&
> +
> +	# Asking "git show" for directories in the index
> +	# does not work as implemented. The error message is
> +	# different for a full checkout and a sparse checkout
> +	# when the directory is outside of the cone.
> +	test_all_match test_must_fail git show :deep/ &&
> +	test_must_fail git -C full-checkout show :folder1/ &&
> +	test_sparse_match test_must_fail git show :folder1/
> +'

A reminder that directories are not present in a non-sparse index would
help those of us unfamiliar with the differences between
sparse/non-sparse indexes to understand why the full-checkout cases fail
here. Initially I was confused why any of these lookups would fail
because my mental model was "a sparse-index is a proper subset of the
non-sparse index".

> +
>  test_expect_success 'submodule handling' '
>  	init_repos &&
>  
> -- 
> gitgitgadget
> 
