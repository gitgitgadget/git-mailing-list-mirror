Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E37BC32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjARMYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjARMXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:23:09 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA026E99
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 03:44:29 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id mg12so10227060ejc.5
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 03:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jILLFE2mz/3dYzgRCSBO+BXS4m+P1RxQCH1QOS11Cbw=;
        b=g/j0ZsM1DzI0gLYghEPEpFLsKYkK782APQITsYQFLhjlGhq1v6QiFEtizusIJ13va4
         N4wz9nkGrVjn75d3TvFtnXnxmcH3s2/px2xylKiGrPrWAnQWV5hbvbKq4BkOUaqoACRa
         ZinuCMMWaT+DC6wcDJToCJQlBnnnu9kkZ7jNCP+9uJ0nJAnmErgrX3/m0qejO1pHXyZN
         m28nqgP+7X9pXaBqudkR1DTtFfMDkau39JBF27nJNX/qPE2ukGitchvVV255cnRwCz5L
         Gc76KiPhMlDyFrG1rRwx4l4qP+j1Wi/hqskKIWxaqbjCaKYEVuqS7TEqaJMONPQVtSvy
         Wc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jILLFE2mz/3dYzgRCSBO+BXS4m+P1RxQCH1QOS11Cbw=;
        b=X6/KTQBFJApe9IfM/hhGfmOx1g2rSch/2N/O4rYRpHf80etPwqEUnk9SsmncLHikby
         822Sv9K8fPM911kv+RxT2lJ+nyjPgjFA9K2XSu3BvbY3qJvuU3BEjf4YtxWI/HbakRZH
         M7o4s68ykA404LwHQQD1mAUbc215Hi3MeNBemHDOdTSI4FfB9O7xlX66DNP4rHbrnCJ/
         BT75JnQeqwbBJP78imzpXPoS7Vyo47DnC4JYPoga2YaWjNI+W9h18+7TL71Ib1s2gI42
         EceUsjw/iGLw1Lt2ceW3/1wU1RU4FnaXVyOJ/Ea//Z5sr1qnEUTGpIQPvJRzUr8Z68nc
         xmqA==
X-Gm-Message-State: AFqh2kreRwrTNChvX91/XyvNvDXcmbB22hUp8/9aVV3UDt0qn0XSj2K2
        956KEF2/pNzhfUjTRUYMIRWP1U8cGNs/oA==
X-Google-Smtp-Source: AMrXdXvno8T6CwqwJzeVkx3fXYvaLoJaDdl0yKCPU60KWqt1G2l2HF66y4eZNeTIwDWjbaREMalNhg==
X-Received: by 2002:a17:906:cb95:b0:86a:addf:880a with SMTP id mf21-20020a170906cb9500b0086aaddf880amr6561798ejb.65.1674042268051;
        Wed, 18 Jan 2023 03:44:28 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id tk22-20020a170907c29600b00870d3fdceb9sm3688913ejc.89.2023.01.18.03.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 03:44:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pI6ri-002odQ-32;
        Wed, 18 Jan 2023 12:44:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH v6 11/12] http: read HTTP WWW-Authenticate response headers
Date:   Wed, 18 Jan 2023 12:42:01 +0100
References: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <bc1ac8d3eb3ac6e1161f6b6b67343874c10cd14d.1674012618.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <bc1ac8d3eb3ac6e1161f6b6b67343874c10cd14d.1674012618.git.gitgitgadget@gmail.com>
Message-ID: <230118.86y1q0vzhh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 18 2023, Matthew John Cheetham via GitGitGadget wrote:

> From: Matthew John Cheetham <mjcheetham@outlook.com>

> +	strbuf_add(&buf, ptr, size);
> +
> +	/* Strip the CRLF that should be present at the end of each field */
> +	strbuf_trim_trailing_newline(&buf);
> +
> +	/* Start of a new WWW-Authenticate header */
> +	if (skip_iprefix(buf.buf, "www-authenticate:", &val)) {
> +		while (isspace(*val))
> +			val++;
> +
> +		strvec_push(values, val);
> +		http_auth.header_is_last_match = 1;
> +		goto exit;
> [...]
> +	if (http_auth.header_is_last_match && isspace(*buf.buf)) {
> +		/* Trim leading whitespace from this continuation hdr line. */
> +		strbuf_ltrim(&buf);


The mixture of this isspace() loop and then strbuf_ltrim() seems odd,
why not stick with the strbuf API?

I.e. after skip_iprefix() strbuf_splice() the start of the string away,
then use strbuf_ltrim() in the first "if" branch here?

Likewise this is open-coding the "isspace" in strbuf_ltrim() for the
second "if". Maybe run the strbuf_ltrim() unconditionally, save away the
length before, and then:

	if (http_auth.header_is_last_match && prev_len != buf.len) { ...

?
