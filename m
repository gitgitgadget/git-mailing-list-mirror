Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33F1C3E8C5
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 10:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE3D2076C
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 10:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwQEUXV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgK2KVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 05:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgK2KV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 05:21:29 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB21C0613CF
        for <git@vger.kernel.org>; Sun, 29 Nov 2020 02:20:49 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id m16so11201895edr.3
        for <git@vger.kernel.org>; Sun, 29 Nov 2020 02:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=FgFvgIOjtwvRmXvl5TJEDrTCHT5+YjdEVbwW57mXijU=;
        b=AwQEUXV+5/QnK7Hi5ky5t74wmcFqG4P+xwkI/NByHnJaYizErwdpWUBqIb/NvnIP9L
         b0nYmmdpzO5jaM16lnwMBXtJAoLu0QKi/+wU4lhx8Tj0utWlG+6ilasid4z3DUmzEva9
         dCE5FhH1uIvov3KBdqj/+8p1LUPVamG6R6mfKhTyR/jfmuroPu85fWeHDnHmOhovfJF/
         0BwxcNASVdkDSI4tAe8xF9kQnJ0EhYKTqAJR6Lw92KZhRGU8z2cN3dKzIq7O0l8+W2/X
         uWndskjMpLbbyPYiDqtzSHn56VXQVBn1+eOWxVWvkFqBNZ7HasyTu8G1w/FjxSPI8rdP
         fsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=FgFvgIOjtwvRmXvl5TJEDrTCHT5+YjdEVbwW57mXijU=;
        b=rViFLRrYckKP4kwhwkgbVD9qQjWWcLkKvLOdpWhL0qNxPdkdxBL5yaCrQ875bQG9nz
         pf+3Gty+pvrRtPiVv040OkP3lDS8FB9d6P4kw4oGS3BcKKvFMLwOyIaETrEHKmg+LRI8
         3soOWqIJ5UT6mFwn2M67sKNupIrHgFVtNBXC/AMtL6L9VFDvNqarByZCwQbtbQY2xvl2
         wiMnjUXlenmQY3baag8VUAEalOJkOhsUh0+I4yLl2t6+hCv8pqsVJAGmc2qmTJgq429G
         KIiiXqu+kAn6ESiayQ6khaHQN7rOo19ZtkoIsC/rvGWaHgaaDQyZDD+8/Pw8llp9kEsw
         ZrZg==
X-Gm-Message-State: AOAM531xMjrugYK2eSQw2eadcHJKP+/kMjjt3sqFRCUihzufC7zniWt9
        bctZf8jpxGbjw6NgeVR3vTGOQ0B/nDVn3w==
X-Google-Smtp-Source: ABdhPJwkDHqwAOSwYE+we9AG/our2lCLIj+vO1gMOnKUlYV73qjOm43qZYnNOm7ZBATsmb5gHVbsVg==
X-Received: by 2002:aa7:c698:: with SMTP id n24mr5424961edq.277.1606645247951;
        Sun, 29 Nov 2020 02:20:47 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id i21sm7696335edt.92.2020.11.29.02.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 02:20:47 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 19/20] merge-ort: add implementation of record_conflicted_index_entries()
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com> <56b162c60993061e29c100ce4a27839d758033b8.1606635803.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <56b162c60993061e29c100ce4a27839d758033b8.1606635803.git.gitgitgadget@gmail.com>
Date:   Sun, 29 Nov 2020 11:20:46 +0100
Message-ID: <87lfekjwg1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 29 2020, Elijah Newren via GitGitGadget wrote:

> +		if (pos < 0) {
> +			if (ci->filemask == 1)
> +				cache_tree_invalidate_path(index, path);
> +			else
> +				BUG("Conflicted %s but nothing in basic working tree or index; this shouldn't happen", path);

Trivial style comment: elsewhere in the series you avoid indentation
with BUG(...). Would be better here as:

    if (x != 1)
        BUG(...)
    rest_of_code();
