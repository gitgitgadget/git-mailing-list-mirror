Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55387C4167B
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 18:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiLLSRc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 13:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiLLSQn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 13:16:43 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACA715FD8
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 10:14:42 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qk9so30270063ejc.3
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 10:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kZ4A5aJcqS9/eUh3SXY6AbfikzuUqOSHJdPFNmQ14s8=;
        b=JooAiZ4I4mtpinpoHzoTBrltEwanr3/KzUe/2Rwmvx2gqz21KapyH+Xz/j2YXztRX4
         jDP5pa6Asod8+hKzYbbibtaAKoojbytWtUHXo4+Xi504EB5fo1C74BkcagSx33VSSUjl
         uHW3e3tJeVKdcQC+5E+lOa1mEysz9fE2E/8ZQ9PDsasQ0v0E+KZknhws+j5w+iw2Yb8z
         KOVkInWNdd/w50dDtHfSpsCCAwKeYnJVW34eLJ+WGJO25vWO3QtOCsfdKfhq2u8d3cDz
         8oOn4qWf1MuL8V+JcPA9IACQYgrQKDipEfghlp8JyQLYA9AGHi722HCl/svRDSENnJGq
         ynoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZ4A5aJcqS9/eUh3SXY6AbfikzuUqOSHJdPFNmQ14s8=;
        b=ALfeH7bF/TJTa9aRbfCQY+5kvNxZKG+bTp8u0vEBw3tI9gneSJXnhI0cNVKRWKZK64
         5ehWRhC4bQUvFeXbQhuubWgELAo4kbz5aKxLUFNDtR+r6RVpHAw1M6pWI2JhUvPEpTay
         Dj9p84TJ4vGrpVnx27F6jxR/J38+Monm21nWx5kuoVQxnGzfPXxzZWZwMAQbnGXTyl3D
         Gxe7I0kdy3aawyPZLADCsFUQujTO0z0MeZKmJrsR/wLmvglRHXFoKx8IKtsH756VfC6p
         Ms4+E4xhq1v/5SFwKDpRy+vLe0xZ9pI3GjjMocu8T+unNvLv6EoGYqS0AXpiqYTfILUl
         XdlA==
X-Gm-Message-State: ANoB5pk1xQ8dwSrguvCJaMDR4XaeZluN5z/pQi9SwbTMwoYBmrYSwjRC
        mZwEnog981ZdcMsdAZl9xQk=
X-Google-Smtp-Source: AA0mqf4alOwvsioI1F239SJhW0jiiVhKLYnXQelaPgv4Db4PjDb7fiYhxZiwQt4RoVUdCCoQqFIUng==
X-Received: by 2002:a17:906:a59:b0:7ad:a797:5bb9 with SMTP id x25-20020a1709060a5900b007ada7975bb9mr18616062ejf.29.1670868881226;
        Mon, 12 Dec 2022 10:14:41 -0800 (PST)
Received: from localhost (94-21-23-153.pool.digikabel.hu. [94.21.23.153])
        by smtp.gmail.com with ESMTPSA id p13-20020a170906838d00b007c0d5b181absm3576104ejx.94.2022.12.12.10.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:14:40 -0800 (PST)
Date:   Mon, 12 Dec 2022 19:14:38 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        avarab@gmail.com, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 3/4] test-lib-functions: add helper for trailing hash
Message-ID: <20221212181438.GA3411@szeder.dev>
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
 <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>
 <813e81a058227bd373cec802e443fcd677042fb4.1670862677.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <813e81a058227bd373cec802e443fcd677042fb4.1670862677.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2022 at 04:31:16PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/t/t1600-index.sh b/t/t1600-index.sh
> index 45feb0fc5d8..55914bc3506 100755
> --- a/t/t1600-index.sh
> +++ b/t/t1600-index.sh
> @@ -68,6 +68,9 @@ test_expect_success 'out of bounds index.version issues warning' '
>  test_expect_success 'index.skipHash config option' '
>  	rm -f .git/index &&
>  	git -c index.skipHash=true add a &&
> +	test_trailing_hash .git/index >hash &&
> +	echo $(test_oid zero) >expect &&

Nit: test_oid zero >expect

> +	test_cmp expect hash &&
>  	git fsck
>  '
