Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36ECC54EBC
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 14:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjAJO7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 09:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbjAJO6y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 09:58:54 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23CB59317
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 06:58:53 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id qb7so8715579qvb.5
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 06:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nn3+f8JWYyMODPqy3xkRbKq4XaKYScPYNJTvyEXLdVQ=;
        b=ZYU16E4DrOAtU5VPT13Tau2/D+D3Hm5f/0spNN34p1Dh1d3Bq0WrWMLWTPKb+WJPsf
         fXAi0vQz3uVMJCQDgTa6YmllhZTF+OzApnBUwccYbNRKjgYwXBiEcKuU5neMcoaraRLf
         UDLvdmACT3vOdaBC8/S8DylEr2GyFnr2P+GTy23B+pnei6Z0+Z6Qg2G8RW2u5rMOD62A
         LhquV9fKAgtgTiF75pu756BaCGEjV5GkwI8+8pG4smZHyTVgxC1sNpvID5KwSqa6Tf+p
         b4BVtBoqIB1lFThg1B2i6tNV8CHzVuAAZvPKzjbLyLhysAtJwx2q3kzzCmSFycRsSR3M
         HmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nn3+f8JWYyMODPqy3xkRbKq4XaKYScPYNJTvyEXLdVQ=;
        b=oajGnf/d+lxl+qa0mVpBLsEhnB1FJAHgl8nYasEYvsr+dbOpgJIseWiuzxfmxa3/ZX
         I+SqOUTtgjpKKIE53BmeUIbGS5eWYKwKspu+AKahVIoW5D5dMUbY/kqSqcKuSMRF/rd8
         YQTawQGIsHBe//vxw6M2njiMRXa/4rgCyFve1WndMwTscMH7ZRmeNorzpmexK4pDQY4r
         Qa+8icySbcJ4WVWhYOppWQURzUNj7/4pORXVtIyCiE5Sfzh//XmdntCeHDBEWrkvKfE8
         WnrFuGBsbhDy++QoC9IYB7euixUBfMWs8tXEBc5b2WWvEgaFTOIS85tejGBf8xAmL5V3
         KGbQ==
X-Gm-Message-State: AFqh2kq1KY2FxkQ1sCEdkgkCpQpt8CPnUnLy6lbqY4GqTZNnvvwmYEdW
        Wgj8Ug4rhqvr48Bcxwckj18N
X-Google-Smtp-Source: AMrXdXtbZIA/YX42f5Rfb/qiCiJ7kydEC4UR1S6FMtxAf2fVqSGgnKw6XmMKYx+3Bltg+aWrN7R9TA==
X-Received: by 2002:a05:6214:5f86:b0:532:1fca:6bdb with SMTP id ls6-20020a0562145f8600b005321fca6bdbmr23094344qvb.33.1673362732833;
        Tue, 10 Jan 2023 06:58:52 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:3590:f4a:dde:5efd? ([2600:1700:e72:80a0:3590:f4a:dde:5efd])
        by smtp.gmail.com with ESMTPSA id y15-20020a05620a0e0f00b006f7ee901674sm7261433qkm.2.2023.01.10.06.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 06:58:52 -0800 (PST)
Message-ID: <14271f92-0ee4-906c-2e12-954ce74fd3ef@github.com>
Date:   Tue, 10 Jan 2023 09:58:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/5] sparse-index API: fix TODO, BUG() out on NULL
 ensure_full_index()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
 <patch-3.5-d96388acef6-20230110T060340Z-avarab@gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-3.5-d96388acef6-20230110T060340Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/10/2023 1:17 AM, Ævar Arnfjörð Bjarmason wrote: 
> The only reason it needed to be this lax was due to interaction with
> repo_index_has_changes(). See the addition of that code in . This
> fixes one of the TODO comments added in 0c18c059a15, the other one was
> already removed in [3].

> 2. 0c18c059a15 (read-cache: ensure full index, 2021-04-01)
> 3. d76723ee531 (status: use sparse-index throughout, 2021-07-14).

> -	} else {
> -		/* TODO: audit for interaction with sparse-index. */

Please don't drop this comment. It was inserted on purpose before the
"ensure_full_index(istate)" as an indicator that the following loop
has not been checked to see if it could be run on a sparse index.

Removing the comment is like saying "this loop was checked and we
_must_ use a full index here". The case of the TODO being removed in
[3] was because the loop was audited as being safe on a sparse index
(and the ensure_full_index() call was removed). I don't believe that
is what you have done here.

> +	} else if (istate) {
>  		ensure_full_index(istate);
>  		for (i = 0; sb && i < istate->cache_nr; i++) {
>  			if (i)

Further, this block has all sorts of direct uses of 'istate'
that would cause a segfault if 'istate' was NULL. Why do we need
to check for non-NULL now?

Looking earlier in the function, 'istate' is initialized to
'repo->index', so the function already assumed the repository had
an initialized index (or "tree || !get_oid_tree("HEAD", &cmp)"
was satisfied, which doesn't seem connected to a NULL index).

So, I'm thinking that we don't actually need any change to
repo_index_has_changes() unless it's being called in new ways
further down in the series.

Thanks,
-Stolee
