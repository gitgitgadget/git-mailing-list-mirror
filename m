Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB50AC47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 17:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE50613AB
	for <git@archiver.kernel.org>; Thu, 27 May 2021 17:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbhE0R4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 13:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbhE0R4K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 13:56:10 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B59C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 10:54:36 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id h11-20020a0ceecb0000b0290211ed54e716so717444qvs.9
        for <git@vger.kernel.org>; Thu, 27 May 2021 10:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hgc04/v8kO7ps+bASjdwmnrzRyL0JWjCfUTc7kdarZQ=;
        b=n7aGEi0FlQklVQ2reobtOzBSP/eBKS1e/wIlMp5HUO71PfR/n83I7H486N/fDg/qjT
         25wRyTHm67pqHtuYL9NQUy8qgDnuHYld1BYCVw5Ak3TjBfioVRYG558eEULxdacdX5IF
         1oOoMwnHwHnPTyipZp+2tgcgfdl9gHUpH3xOt+IWQLdGvz4FJF9qYkIdxKAoMCDR6Hwb
         6Q1pD+TCq3NjlpwKyHdG9ZuxwskFZ5Cis8kh2gjnjb5rzL6Nmt9P+G7ywBQLoaGuswZx
         159qZKj38ULfgkxIJOitEfbKTq7tNJ0yxxdpFCFrjAuWozEPUY6x52k3/qLiSauRdr5f
         ZP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hgc04/v8kO7ps+bASjdwmnrzRyL0JWjCfUTc7kdarZQ=;
        b=YKm/swHxCd+fO8ImZypsZ1rRKDdAG2Y4lCs5Kz14184gFLjf05/bzmc+sQhHAWP21Z
         y8IqWR5wUO1rmvWo9gQ2nTUeiI30Y7y3bxSKo9BnnBiTo6fLZTUaqCjGUswVLUQnWNE9
         Guq/5hypXqgpkhUbxzBGNDIhdYkgnUG+LthC7Wty7t1xkXRpo5tkh0rbxi2a5bEIqk10
         GGTfaq1HD1yOjDViac0rmNNCxd+Dh20jk4DOWF/ZkhcnAwewxJdclFZZRYJHDo0GUBBr
         2rMlQFfcvsua9X1uZjtc2f3QrTOtqfrfNKDGdvjiqWsQCImFEWSm9hRlWa8f+3LcJIxC
         wKuw==
X-Gm-Message-State: AOAM532SbLGcPWcjn0v7bFvH/3DkykMz1RmfMMWR93fuxFVGrYS7LUxN
        V++YhTQeh7ifVDxKXhJl74nz54KrlhOAotJpZ2Ra
X-Google-Smtp-Source: ABdhPJxowx3Hxj8XY/+DqZfc4gmg2CdzaLmVzmYYVhA/WEn1RSxlC2eIHQAEWKmsOOD6pUXbXL+mN9H8pneE814PIG/X
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:c2d:: with SMTP id
 a13mr4462109qvd.37.1622138075899; Thu, 27 May 2021 10:54:35 -0700 (PDT)
Date:   Thu, 27 May 2021 10:54:33 -0700
In-Reply-To: <patch-12.17-77f2cd439c-20210520T111610Z-avarab@gmail.com>
Message-Id: <20210527175433.2673306-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <patch-12.17-77f2cd439c-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: Re: [PATCH v3 12/17] object-file.c: return -2 on "header too long" in unpack_loose_header()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        j6t@kdbg.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/object-store.h b/object-store.h
> index 740edcac30..9accb614fc 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -481,13 +481,15 @@ int for_each_packed_object(each_packed_object_fn, void *,
>   * unpack_loose_header() initializes the data stream needed to unpack
>   * a loose object header.
>   *
> - * Returns 0 on success. Returns negative values on error.
> + * Returns 0 on success. Returns negative values on error. If the
> + * header exceeds MAX_HEADER_LEN -2 will be returned.
>   *
>   * It will only parse up to MAX_HEADER_LEN bytes unless an optional
>   * "hdrbuf" argument is non-NULL. This is intended for use with
>   * OBJECT_INFO_ALLOW_UNKNOWN_TYPE to extract the bad type for (error)
>   * reporting. The full header will be extracted to "hdrbuf" for use
> - * with parse_loose_header().
> + * with parse_loose_header(), -2 will still be returned from this
> + * function to indicate that the header was too long.
>   */
>  int unpack_loose_header(git_zstream *stream, unsigned char *map,
>  			unsigned long mapsize, void *buffer,

Can the return type be an enum in this case?

> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index d3d3fd733a..f12b06150e 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -440,7 +440,7 @@ bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_t
>  
>  test_expect_success 'die on broken object with large type under -t and -s without --allow-unknown-type' '
>  	cat >err.expect <<-EOF &&
> -	error: unable to unpack $bogus_sha1 header
> +	error: header for $bogus_sha1 too long, exceeds 32 bytes
>  	fatal: git cat-file: could not get object info
>  	EOF

Ah, the error message is much more informative - thanks.
