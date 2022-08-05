Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A8DC00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 17:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241363AbiHER7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241566AbiHER7U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 13:59:20 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE59785B2
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 10:59:05 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-10ea7d8fbf7so3704381fac.7
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=/ZOr894KNl5lL+23rNo9IMWzLlvvDaMyNF4WMDUorbw=;
        b=amoZzuRyIV4WeBrfQ0nbSvKNu4W+HuN0lPu7SrmmZ88Ae5fm4NNBPxJOiDrD4C8jEM
         f9zwWnWTQdPyjF/LTDvQSe4hFJ+vdw956OU/XDtgYue8udNfrucgWCO+r9myH8e8QqTd
         xq9lYSLDSJZGJYCQHahCFgRaSyqhnO4UvSiWsZqYjNoj/MN13xbMSjtBQJk+nvQSIwJf
         3pgEL4PbYwA0EBK2MvPUAE2RBkGTiQnIi7RY6WXBYr77RLoAdDcSllzhro9j/jgMRDRu
         T/LD4tI8ouOhUWGi/a1Z7gzycHyIzOpqfeiAjknHuhMXgI77UxN3pWYV0pipf9dFLBRK
         N6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=/ZOr894KNl5lL+23rNo9IMWzLlvvDaMyNF4WMDUorbw=;
        b=6NV3uynYcVmIMehDcRMP2b0zTeWPgVC/jYtyRnB31uGyXbyAIrCrMWepBqS5mPq0nV
         YfayvYMcMfCtOJodK2D552hCuy6rRObSoNehvDPzTZUN+bJ7X8SE8iU23Qd8N6SEh4tF
         WfggdNhZQY9xFEWysMHq1KNfwXSNXcNEahzvJ5iiolu8mLiXvbWgKspIU97Gdo3Wrcg8
         s1tg8a3WYSHvfG1mNFWrHZGt2wbdmrB0EMg941YOTT4evXWY1Z5eDRtUWj/N+ABlFIP+
         LDZ8dWKbfUoHn+1sK5DiF05c2+LhdEuwhaiiEiq+OiV7LxJ0HHgrRTWcc7ud7PPKUiEC
         767w==
X-Gm-Message-State: ACgBeo0vtUEkembBk+xUUlB+gLPWyegrreTPcujg7T/cBx4ZJxC4MzkO
        zkTTA2mm2CXfYRUfrazkqnmhKpOWU59s
X-Google-Smtp-Source: AA6agR5ts0j5/exNhcrqmUe2PmBhdoDwgZXHO4J7hjDlW1MNS96afq5eeJeUo++oPw7uz+FGiohkmw==
X-Received: by 2002:a05:6870:ac10:b0:10e:c520:7aba with SMTP id kw16-20020a056870ac1000b0010ec5207abamr7040806oab.280.1659722344189;
        Fri, 05 Aug 2022 10:59:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3928:8f07:23c6:89bf? ([2600:1700:e72:80a0:3928:8f07:23c6:89bf])
        by smtp.gmail.com with ESMTPSA id z62-20020a4a4941000000b004358b15cfe8sm813862ooa.13.2022.08.05.10.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 10:59:03 -0700 (PDT)
Message-ID: <c93dc6d7-ab49-667f-ef4e-544a764fb737@github.com>
Date:   Fri, 5 Aug 2022 13:59:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/4] checkout: fix nested sparse directory diff in sparse
 index
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     shaoxuan.yuan02@gmail.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
References: <pull.1312.git.1659645967.gitgitgadget@gmail.com>
 <255318f4dc61daef3e892a4dd5c571463985f340.1659645967.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <255318f4dc61daef3e892a4dd5c571463985f340.1659645967.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2022 4:46 PM, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> Add the 'recursive' diff flag to the local changes reporting done by 'git
> checkout' in 'show_local_changes()'. Without the flag enabled, unexpanded
> sparse directories will not be recursed into to report the diff of each
> file's contents, resulting in the reported local changes including
> "modified" sparse directories.

Nice find!

> +	rev.diffopt.flags.recursive = 1;

Simple fix.

> +test_expect_success 'checkout with modified sparse directory' '
> +	init_repos &&
> +
> +	test_all_match git checkout rename-in-to-out -- . &&
> +	test_sparse_match git sparse-checkout reapply &&
> +	test_all_match git checkout base
> +'

Simple test.

Excellent.
-Stolee
