Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B77C433FE
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 16:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348222AbiCHQLp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 11:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348224AbiCHQLn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 11:11:43 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D36D50B13
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 08:10:44 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id x26-20020a4a621a000000b00320d7d4af22so9426887ooc.4
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 08:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GJ5KCfyEusL61woCcFtZ/JW6qeM8dvw+9zs5s/xED/M=;
        b=Dqg4MXKUEp2sR81DK/HNE8eF1feQuMJL5U9Ll5fDhVYbJsSy5DtQCv1hGknzCtsVg7
         rujOO+76n1i/lcy+J2KDRJ6uhcOo8yHdhHtP1RpVVFNLNZM6GwdLaPuJiSsiN8H7bq8i
         PSqr1Ef5SkHQtVS2FFe91LWIjK1vMUEH29Ulyh0O7CYkspP52CJGdmyKrgYkEQXEz0uj
         J5Cy8QKuwIKwnVYOYM1xdUqBxcG85n97ZYM0opxovI0Eipf9U8X/rMvastGpn4YnBsbW
         ZcLUHBdmOJLJ1Eg9s4IJn/wCM34r5WVd2H4FZHwRxH9QPHcL5sronBvHJBnV3OSjCvne
         y/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GJ5KCfyEusL61woCcFtZ/JW6qeM8dvw+9zs5s/xED/M=;
        b=ajL1fiJ5HFROTW+ppm5lKt0lfIaYNE1E4y4PAMWcD/tBc1Cnz2vl1pQpL+Fm/IEB/n
         vJmmzkWP6W/kXkVwDwDOmY8tgpW4lYRJ32Avk/DOLk/6v6uLIhUv/YTPNAl8WNkYoxLA
         +08cxnCZIrc5rEEdXdEnHFQGWxfBTso60jdvq3go93nT1sbWiGte1tRfT5+Zq2iD8p45
         XA6ikhERIW5G7WUkbEnwUQKJ1HeTCBw6T0wGDBCUoRGU9OnaqT55eSfucKWfcRtH8U/4
         Dhf0Ks+b+k1ML22MkIEQmzMOk9KFjtdCdDz4Rc3460wlWdF/WtK0cql92EVrzvijorCK
         SumA==
X-Gm-Message-State: AOAM531lDNADl0ym03zOjPPrtypCez2Pm5B4/l1FzfS8ic+lQc4DCX8F
        Z41kg38cISjjhJgmbNwXCAVLNeLKUeYk
X-Google-Smtp-Source: ABdhPJyL2r4fBDdvoaC4VfQQtSCjSBraI7ZFE2W230tsY4br+dYPJJoiuo6UqlHQ3n7Fuptz9cv4Ig==
X-Received: by 2002:a05:6870:350f:b0:da:b3f:323c with SMTP id k15-20020a056870350f00b000da0b3f323cmr2785384oah.236.1646755843914;
        Tue, 08 Mar 2022 08:10:43 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id m17-20020a0568080f1100b002d71e151e51sm8675038oiw.0.2022.03.08.08.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 08:10:43 -0800 (PST)
Message-ID: <d9e6e3bb-b2ef-dbf4-6969-620b58727115@github.com>
Date:   Tue, 8 Mar 2022 11:10:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 12/12] clone: fail gracefully when cloning filtered
 bundle
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>
References: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
 <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
 <805e1d1172210c6a39b33edcb2cd6d21b754f821.1646750359.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <805e1d1172210c6a39b33edcb2cd6d21b754f821.1646750359.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/8/2022 9:39 AM, Derrick Stolee via GitGitGadget wrote:

> +	if (is_bundle) {
> +		struct bundle_header header = { 0 };
> +		int fd = read_bundle_header(path, &header);
> +		int has_filter = header.filter.choice != LOFC_DISABLED;

Of course, as I was sending an email replying to What's Cooking, I
realized that I missed one of the suggestions, which is fixed with
this diff:

--- >8 ---

diff --git a/builtin/clone.c b/builtin/clone.c
index 623a5040b1..e57504c2aa 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1140,7 +1140,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	transport->cloning = 1;
 
 	if (is_bundle) {
-		struct bundle_header header = { 0 };
+		struct bundle_header header = BUNDLE_HEADER_INIT;
 		int fd = read_bundle_header(path, &header);
 		int has_filter = header.filter.choice != LOFC_DISABLED;
 

