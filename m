Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2313C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 00:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C95D61356
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 00:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbhHWAf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 20:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbhHWAf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Aug 2021 20:35:28 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062E1C061575
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 17:34:46 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso20613508ots.5
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 17:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X9rMfjMKU9gbC3oJHZAwWvVrKbtw2G7ogsXZ7XfHKcI=;
        b=sykivvmKqORhdNt267gXZihrDwEpRul9QE59BcxYeyeaAudOl7sA3k2puXnV2bz+kc
         SvcBDtTb/T57kwHx3T2YnjQE98M/0Bppuk95purzODlS76ZCPmtKsAO0u1YGyCWI6weu
         /8PHscf7LJddYN4I9+UivF5j/+e35Yb3MorOQemYWAXLYk+83x6cD6JKRZb5UHxvfH4+
         +1dUtu0ENlsFK4gZLEK3oXCTZ5QRmBBJhfsKaVoCUyIR1TQn1r3huIZVFc8xRbihv7A6
         4zHC3sIBXqVEEaBZorE9M8knRBg5ErCsRknehXeHyAZ01lbTlGwFC87o1IqzxncCxgaK
         2gYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X9rMfjMKU9gbC3oJHZAwWvVrKbtw2G7ogsXZ7XfHKcI=;
        b=ZBpQOdRp9LHdXUhm8MlBQlsjpAgkA2hIf6nDewY3UoBIXpdHcF75Nxjfu9QQkZzP5Y
         1Se7afpMH7QimFsrNaxUEUrwW7KdHn43abwLYcgfCfWMACb3OSSMWOgJBIhW5o5v92vn
         1bXnDX/MjOPFlvmlvQJUw92GxI+Ck9DMLrVfNrebQsnUDsd2YZ4KlSj18cJkUR/OZpDY
         m6HUsvotqKuomgq1O6VOjT+S+I1+mGH1rb8H1taXIOkZBptgPLuhDpJeMLxX9EYOBiJv
         Dbkf7aAlbafbP3se1ZxialgzkI9HEtBqyBR0lXefYxmYnP1a/oNfNxF9QIOLQe17sJqV
         qIeA==
X-Gm-Message-State: AOAM533cfxdL2RI1b0wuVacKt9oy8Eh3gLmC/i5xoPGZCX1fLUbYDTN+
        qso83baom6y3KicorMvgYgw=
X-Google-Smtp-Source: ABdhPJxEtph8JoPxpEjbtFhMShTDmqSEoGZlx1zLCjTbBq9p3ltQIT3enOkRTQQggVmkQpAf1EoQlQ==
X-Received: by 2002:a9d:6359:: with SMTP id y25mr25960354otk.274.1629678886257;
        Sun, 22 Aug 2021 17:34:46 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:48bd:24c0:4055:3255? ([2600:1700:e72:80a0:48bd:24c0:4055:3255])
        by smtp.gmail.com with ESMTPSA id f17sm2095594otl.24.2021.08.22.17.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 17:34:45 -0700 (PDT)
Subject: Re: [RFC PATCH] multi-pack-index: allow operating without pack files
To:     Johannes Berg <johannes@sipsolutions.net>, git@vger.kernel.org
Cc:     bup-list@googlegroups.com
References: <20210820195558.44275-1-johannes@sipsolutions.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <edb9c412-70c8-4fc6-04ab-417eca05ee15@gmail.com>
Date:   Sun, 22 Aug 2021 20:34:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210820195558.44275-1-johannes@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/20/2021 3:55 PM, Johannes Berg wrote:
> Technically, multi-pack-index doesn't need pack files to exist,
> but add_packed_git() today checks whether it exists or not.

Having a multi-pack-index is supposed to indicate that we have
these objects in the objects/pack directory within the specified
pack-files.

I understand your goal to relax a condition of the multi-pack-index
file, but it's triggered by a flag during write and that choice
isn't persisted into the file. There is no way for a later Git
process to understand that the multi-pack-index doesn't actually
guarantee object existence.

And in a completely other side: one would think that including
a pack-file in the multi-pack-index would allow deleting the .idx
file, but there are a few reasons why we do not (including
interactions with third-party tools).

So, I'm not necessarily on board with this change unless
something is added to the multi-pack-index file (such as a new
version 2 and an optional chunk understood by that version) that
tells future Git processes that the .pack files might not exist.
I'm still not sure what Git should do about that other than stop
reading the multi-pack-index and ignore its contents.

> -struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
> +struct packed_git *_add_packed_git(const char *path, size_t path_len, int local,
> +				   int require_pack)

The only obvious thing that I noticed in the code is that we
typically use <function name>_1() as a way to create a static
version that is called by the global version.

>  struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
> +struct packed_git *_add_packed_git(const char *path, size_t path_len, int local,
> +				   int require_pack);

...oh, but that's not what you're doing. What you could do
instead is convert the 'local' parameter into a 'flags' parameter
(I think we have started to prefer 'enum's recently) and create
MIDX_FLAG_LOCAL and MIDX_FLAG_PACKS_OPTIONAL flag values. That
avoids multiple methods and minimizes the change to existing
callers.

Thanks,
-Stolee
