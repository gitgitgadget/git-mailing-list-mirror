Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E875DC7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 22:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjFAWlL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 18:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjFAWlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 18:41:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D421A4
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 15:41:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8337ade1cso1905613276.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 15:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685659265; x=1688251265;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zBjILZMMrt+d7GjMIo1Hi9drIqSsZ5+LtYN/Tx7SwcU=;
        b=U8HRypJZQp3HxDDci2xKlup1LgyohJ4FT3Idu63YJk6ISiX9ppU0MvsqIBLht62qbS
         bWbOIgzJk0IxwMLHi0DsLmXqBKXuihj2Gi/HTM8Pms2F9qIgbMSgiv5KUCSGntm0rGv4
         kz5DcH5faNi/AMgOJGJyguiYx5CSs6G29IwnfHLkB83z8BBzmZs8Ni0u3T12vDxdXfSn
         WU3pV7KF/4s+E/TUgtGs/f2cFMcAusgNLBctedLx97MOwHVEJOUC1NG2VItd/egStuMe
         z8HacleDU5iR8YyH5FWNXtz5qSkRhTdCQKKxpuGhqkDgXTLwrbJRfrDICEl4hF3t/VFO
         Drsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685659265; x=1688251265;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBjILZMMrt+d7GjMIo1Hi9drIqSsZ5+LtYN/Tx7SwcU=;
        b=R899Vw2ng7MXE9SR2BXFX4IJ3WuIB5SpYfCX7Gp9tbArURgzBRpZOmHByYU/oPypRP
         utppVET4DMvYxmGQb3WSDNOvQMuUv2Xel3rEpnkgwyzJc2ynsvwbqf3UH4fX+9uO0HCg
         beo1M4rsbBqPj0g/8ZaVRGypoC9OLnzMjRBQFYxYJa3RsTsK5QyBI0Dm0S1w9XStiEWp
         6adWYGwbgvc70FbOpDLAeZvSw0ty69dPbvyp4FSCtX0YAzxREYbBMM1vpf//2Rhlt4O/
         4bHDvtkcFz6o552aPkNm5aN0qqxlCW7Zt+qhyrLjjgq3ol2aau+6LQS3vBj30HGc5hoA
         tYyA==
X-Gm-Message-State: AC+VfDxRqgJ/kYjob5fFPttsHjLDIl1xo9TNBQIVrK8lRC+V5R4qloxC
        v2a00h86UnAwl38aLU1TJThXvwyNHdZ0f/nVTldb
X-Google-Smtp-Source: ACHHUZ7wBUS4QSamHMg64tnE9Kzk7lq/Yd2QLdPmAlELVCq3a10zmmhH+VD6jdx6hFN3wowDLcfXkVYVAR0aiglZJM+x
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:9bd:7d22:5bbe:5b1c])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:1101:b0:ba8:3401:a466 with
 SMTP id o1-20020a056902110100b00ba83401a466mr633809ybu.6.1685659264824; Thu,
 01 Jun 2023 15:41:04 -0700 (PDT)
Date:   Thu,  1 Jun 2023 15:41:02 -0700
In-Reply-To: <641a56f0b40a88b0127819989ed1f81f844a090e.1685472133.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601224102.423442-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 07/14] config: provide kvi with config files
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Glen Choo <chooglen@google.com>

For some reason, I was having difficulty understanding the commit
message, so I looked at the code and I think I could reason out the
purpose of this patch. It is 2-fold:

 - teach git_config_from_file_with_options() to supply information to
   its callbacks through a kvi argument
 - its kvi argument requires a scope; get it not through
   current_config_scope() but through an argument

And as a corollary of the latter point, the scope is UNKNOWN when no
global scope is set by the surrounding code (if a scope is set by the
surrounding code, use that instead).

Unlike the previous patch, since no callers were changed, the only
way we can see that this has happened is through reading the code of
git_config_from_file_with_options(), but I've read it and it looks good.
(Again, as long as current_config_* is all gone at the end of the patch
set, then things are fine.)

> Refactor out the configset logic that caches "struct config_source" and
> "enum config_scope" as a "struct key_value_info", and use it to pass the
> "kvi" arg to config callbacks when parsing config files. Get the "enum
> config_scope" value by plumbing an additional arg through
> git_config_from_file_with_options() and the underlying machinery.
> 
> We do not exercise the "kvi" arg yet because the remaining
> current_config_*() callers may be used with config_with_options(), which
> may read config from parameters, but parameters don't pass "kvi" yet.
> 
> Signed-off-by: Glen Choo <chooglen@google.com>

Now that I reread this, I can see that it hit all the points that I
wrote at the top. So I think no change is needed in the commit message,
unless another reviewer also found it unclear.

The code itself looks good.
 
