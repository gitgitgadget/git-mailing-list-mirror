Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A2BC77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 17:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238760AbjEKRmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 13:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbjEKRmE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 13:42:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2031FF7
        for <git@vger.kernel.org>; Thu, 11 May 2023 10:42:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a776a5eb2so19841668276.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 10:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683826921; x=1686418921;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DTLuAXMFY6wK7HFPGEMR5kZpxey7EgfezcDW/E+TlM4=;
        b=d9cBM+TEM5xgIHgJZrlssDXisda11hPdNiVcl4MLImFHIky6ttS2xH6j0Zo4sT8Ya0
         OkPHQtH/2yJisNHrIMcbFLSR/Vvz4itWuePqR+AKhF7ETVFUaAPP1q4IgqmWYgtX6s8k
         2YCLpA1XTlmVIiHNvg5yrcBle+uQmbk5Vh9EvikDRVC3REcc6iMXYQhrFXLmk0a025sh
         S9xF5EoaOayOTy/HvwmSP5X31UnYVtVcgtuA5+3KvANYO3/KosFcdd1f/BHH49TOFenU
         QP8NLBRrpu9wtFdgqOBWPrlvdR6LP8StiWgxTuUjeINiKyJYeSoAaIblGR8tt5VcMRLt
         CLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683826921; x=1686418921;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DTLuAXMFY6wK7HFPGEMR5kZpxey7EgfezcDW/E+TlM4=;
        b=HF3tivNAZwQKQwf4yV51W6mZa0nfFnjl1EoR4lSsNQbhuRnH3CFWtmW/718dnIEUg3
         KGDMjY51LkXFj7hQJ8X0qdnw1P1xW1t8rR+HUNrjS5njAEbRl+aNKl8khPX9GVXt3xFV
         vF2DTiECUcNvK1DSHZJY5aqhz6oX6mv3baNm+OS8WQoc/GiNDNG2+4pdCuRSXa4Ul4GP
         Vfgykz8DYWxLLU5rvdP+sexX/osKwrJlQNvzFspaEd2hKgPCLVkOW7jUdkJJ9RAi19Zr
         Jk/bTT4EVF7sVSmu3cUZPVurvSC1Ig9K7swqaiHzizVb1d0iQcwmorVBoju0qD5CZ9wO
         dgZQ==
X-Gm-Message-State: AC+VfDxgpDt1LaZE2IxMJp4EAODdQ86wcMdoGp3ys6deHvrY7Ab8wzWg
        42b2t7mbeWQACkuPAtq4rMgRYVwOyKyHpIGcNFUAH/FwD3yvlthFDd63ZwECUTV3S4LLPeqp/7z
        hWSmXz9/+ahbQc6pdvuCHvOesp+DE5hF5OdruwlZPtYARYgt9vmMbv9iyDTrr+I3UIg==
X-Google-Smtp-Source: ACHHUZ4+/E24vqNBlRBr/teEu/gLc/lrYfKh+aQCIoVmGPuey372vnBrBrsC+B6RQLCeTHfBYITbaeDq1qsSEgQ=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a5b:60a:0:b0:b9d:d623:1960 with SMTP id
 d10-20020a5b060a000000b00b9dd6231960mr10005960ybq.0.1683826921140; Thu, 11
 May 2023 10:42:01 -0700 (PDT)
Date:   Thu, 11 May 2023 17:41:58 +0000
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230511174158.939431-1-calvinwan@google.com>
Subject: Re: [PATCH 00/24] Header cleanups (final splitting of cache.h, and
 some splitting of other headers)
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This series continues to focus on splitting declarations from cache.h to
> separate headers, and also cleans up some other small header issues. By
> patch 16, cache.h is gone.

Congratulations on slaying the cache.h beast! Glad I was able to follow
the entire series to see how many headers cache.h eventually splits up
into.

Most of the patches in this series LGTM, but I do have a higher level
concern. A couple of patches in this series splits files from foo.h to
foo-ll.h and foo.h with the goal of having other files only include
foo-ll.h when needed and not foo.h which has other unnecessary includes.
While I believe that having less unnecessary includes clarifies which
files have what dependencies, I also believe that we are missing
documentation for how new functions should be added to either foo.h or
foo-ll.h. What criteria are we using to separate out those functions?
