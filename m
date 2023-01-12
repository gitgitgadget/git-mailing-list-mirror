Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4F3C54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 15:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240142AbjALP3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 10:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjALP2h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 10:28:37 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF88DA196
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:21:19 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id bp44so16803209qtb.0
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpIcfpYVVOkl805LiQJBQ9+LtMi3VswEWiYkNffelSE=;
        b=XmIY0Scez5qWDSQsT9fPsZu3+r6XcM52qRIe8aNIIYj3piWBbSmlWM12lJ7yRCBpo4
         bcQLXYxyaaGYweqjvQ/7HFobMCz9rnK5UlcNj73jxk6uh6Ee0RGvrnCdoSl/AGT+t1n9
         pOsgTYKmz3Jitxads+4duvnpdrigzqrZ1HljscsIdv4wiCYrlXzGn19gAXnKvarS0tpo
         nw6FXxj5p5jcf5LwLKYHncWKUhMATBxwNsi7EDnlV696lkDOTM4K6hMv2fG7PY63DKNk
         LYEYyKwYfkEx5qv285y8p+WfgTVMdOvNhDUPRcYavRTvcHCQ+e4SCwCk7r0d+Nf1lHv8
         3jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qpIcfpYVVOkl805LiQJBQ9+LtMi3VswEWiYkNffelSE=;
        b=LUnDrlS20yVtBNxB1PaftfA1h6UaZjT6SmrYbz7mL2ppSyVSu/30BX2vRYzYpDcZzw
         YNbUJudH8ju1LO8XayiqB/LRGXMTazWx2K6ChwqOI/bALPSAMfXl8vSj5XAqigBtOK3e
         CKUZjm8gyVTSOj53iDy270yNtywGfyX5WF/410ofTBTcyzQN389bq6zfgpgnrfMfX/Ug
         8CKqcs2OA/ex3ZfeYj9NvD6A6tDGtIOHGs+rpNrSvm6Tmi8eErgcRNz94acVbGZW1iRX
         MGObcJRYNaMiG/seb80WPxQCY/R8fD7G7/wnBGQAO6sqnk9zmpacukDoGH7paH8614Fa
         Nz2g==
X-Gm-Message-State: AFqh2kp5w98/k0wLnAMkfHz0hYIaezsYdoo81Tcau+TYAKZQuBt0OqO3
        XFjtVtBEDVLYwmp68gng1TwmtuqdphV637Q=
X-Google-Smtp-Source: AMrXdXtTM+okhQ01W9cFGzmFJjosVcV2MQnt7LovEZBVkdHb5KtQp2TDT1f71ub6cgwM2mTPhCYvHw==
X-Received: by 2002:ac8:1203:0:b0:3ad:ccdb:97e with SMTP id x3-20020ac81203000000b003adccdb097emr16745028qti.51.1673536878855;
        Thu, 12 Jan 2023 07:21:18 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:58df:ae78:2cd7:f615? ([2600:1700:e72:80a0:58df:ae78:2cd7:f615])
        by smtp.gmail.com with ESMTPSA id d10-20020a05622a100a00b003a526675c07sm6950694qte.52.2023.01.12.07.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 07:21:18 -0800 (PST)
Message-ID: <270ef93c-cfdc-d119-5740-f704d7f2a029@github.com>
Date:   Thu, 12 Jan 2023 10:21:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 5/6] cache API: add a "INDEX_STATE_INIT"
 macro/function, add release_index()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com>
 <patch-v2-5.6-ae256efe94a-20230112T124842Z-avarab@gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-v2-5.6-ae256efe94a-20230112T124842Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/12/2023 7:55 AM, Ævar Arnfjörð Bjarmason wrote:
> As we'll see in a subsequent commit we'll get advantages from always
> initializing the "repo" member of the "struct index_state". To make
> that easier let's introduce an initialization macro & function.
> 
> The various ad-hoc initialization of the structure can then be changed
> over to it, and we can remove the various "0" assignments in
> discard_index() in favor of calling index_state_init() at the end.

> -	memset(&o->result, 0, sizeof(o->result));
> +	index_state_init(&o->result);
>  	o->result.initialized = 1;

It's interesting that 'struct index_state' has an 'initialized'
member that we aren't setting in index_state_init(). Perhaps it's
only being used in special cases like this, and means something
more specific than "index_state_init() was run"? Or maybe we
could add it to INDEX_STATE_INIT and drop this line?

Thanks,
-Stolee
