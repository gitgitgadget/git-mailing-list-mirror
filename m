Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AD2C64ED6
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 17:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjB0R5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 12:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjB0R5g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 12:57:36 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7BF23D8E
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 09:57:35 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id z6so7693554qtv.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 09:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xXxvCaBn87YyV/IjQzyBxPWSdgozNhgA3QLEON3VZlM=;
        b=YzMq/QR+2E5QqOCih7NPyQJz+G1aFPoyPof2vi/K1sJnmPIBnUNCOFsiQY8n90q1ys
         3SO3a0KZUIz2ogkydLH2nXq8ovmb3pKFdzi4MQuNK0a4gAgpeAi7vYVehY8JR53XOxtk
         MSHLyLCofO4RN/kGTKYhu3MP9d31W6M55iuZ8eHTDQxVAmcX7M+YmarYmHrzxSRUUjXB
         xAv9dX7rX6X7Wsmz8thDDdUwLYzUW5WWy4BkHb0UUPzvVX5lXI9S+ZhxYsPPsD2oyXTk
         ZAfOTWs3QMg6MFUqb98hdZy4ouEm11Inb5/NpkjtF2lm3bnMlCZNswcPCmMWxPquWK1q
         IA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXxvCaBn87YyV/IjQzyBxPWSdgozNhgA3QLEON3VZlM=;
        b=gVKqZdKWuZU524SpyKs6sqNV4+SOvJ/stmH9zbIDaobU62J38M2VMAAlzHs+l4/XML
         cKthKIjxuNV3P6XRYK1Ym8YRpsoZ+gkpYb/Gr8tTQhH6+O5Rkiyh2tCmf3G9MS2VuanU
         0Xr9CvCUohMTSZu41gAuLNsaeM+77MXwrpIhH32FBArH2EQcmpiZFzTGbrz77WnvBCM9
         Nt073Pnv3Sx+ySER2ywi8R9zStZcnY9viciiTx+GSe/NxF7ONgbaC26sd6zxvQ5jkixK
         V1CgTu81OUoIZiSkgR4V8LEcCp+MoxnHCrAfICHoNF6At13NEcwKf5XUN21vfBka1hfJ
         zQCg==
X-Gm-Message-State: AO0yUKWOctrPvCUxxPntgChKrSFXtbhFoHUe5aVOk0mxbMo+NAPPKTiJ
        oVurW2Uw0ZB7EoLbWKS0ZYi4VEkZsQaMcyU=
X-Google-Smtp-Source: AK7set89vB94vvlaEfv08ETcGnHyjvRp2w8zTnRFXpoE9SdxZMHjtpRb9iUOEYB23Q5pDiwO0xt+9Q==
X-Received: by 2002:a05:622a:138b:b0:3bd:efe:9a09 with SMTP id o11-20020a05622a138b00b003bd0efe9a09mr17020114qtk.28.1677520654384;
        Mon, 27 Feb 2023 09:57:34 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:c838:390d:932c:3ee6? ([2600:1700:e72:80a0:c838:390d:932c:3ee6])
        by smtp.gmail.com with ESMTPSA id q27-20020a05620a025b00b0073b575f3603sm5224606qkn.101.2023.02.27.09.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 09:57:33 -0800 (PST)
Message-ID: <cd7b9a2f-4f52-9da8-19c3-2c5cda7b8160@github.com>
Date:   Mon, 27 Feb 2023 12:57:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 1/1] check-attr: integrate with sparse-index
To:     Victoria Dye <vdye@github.com>, Shuqi Liang <cheskaqiqi@gmail.com>,
        git@vger.kernel.org
References: <20230227050543.218294-1-cheskaqiqi@gmail.com>
 <20230227050543.218294-2-cheskaqiqi@gmail.com>
 <315e70e0-ac1f-2f19-f1cc-6b8b24ffb1fc@github.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <315e70e0-ac1f-2f19-f1cc-6b8b24ffb1fc@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/27/2023 12:18 PM, Victoria Dye wrote:
> Shuqi Liang wrote:

>> +	prepare_repo_settings(the_repository);
>> +	the_repository->settings.command_requires_full_index = 0;
> 
> The test below doesn't do anything special related to the sparse index, so
> this change is unnecessary (and, as far as I can tell, will break in some
> usage of 'git check-attr'). If you're only looking for feedback on testing,
> it'd better to leave this out.

This change is part of the performance improvements given by sparse index,
but the correctness test you've added only ensures that the end result is
correct, not fast.

It's possible that even with this change we hit an ensure_full_index() call
somewhere in the call stack. To test that the sparse-index stays sparse
throughout the process lifetime (when possible) create a test that uses the
ensure_not_expanded helper. There are several examples in t1092 to use as
a starting point.

Victoria is right that it is helpful to first establish test coverage of
the builtin for correctness reasons before making this change. It helps to
add tests for cases that would require expanding the sparse index, such as
checking the attributes for paths outside of the sparse-checkout cone.

Once the correctness tests are in place, you can then make this change to
the builtin and add the tests that check ensure_not_expanded, since the
change at that point is _only_ that we are allowing the builtin to
operate upon the sparse index without expanding it immediately after read.

A good example of this "final step" is [1], which updates the builtin for
'git diff' as well as adding _only_ the ensure_not_expanded tests.

[1] https://lore.kernel.org/git/897611682af64ba6bd0d2dfcfeae56cfe953c45e.1638806161.git.gitgitgadget@gmail.com/
    [PATCH v6 6/7] diff: enable and test the sparse index

You can look at the surrounding patches for other ideas, but it should be
noted that both 'git diff' and 'git blame' in that series had previous
correctness tests in t1092 that only needed _edits_, instead of being
created from scratch.

Thanks,
-Stolee
