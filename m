Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C848C77B7A
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 22:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjFAWRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 18:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjFAWRp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 18:17:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A790189
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 15:17:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba82ed6e450so1851456276.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 15:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685657863; x=1688249863;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=51PWPY6BMWoDg45MlG9I1qZfsIaUCeI0YrMX7qE5Pw8=;
        b=p/kE9Gg97TCYGYtg3EBw2VYVyGwT+ORz/QNnDv0SpxKTqyJH0mWm8eq04pbzgRIJso
         hj7bBUwqfVqxQzwNK99RI7RHBYHM8Hw1KPjj6Y3AkrLNBIStOvA3CHuomeu0kWdsrx4D
         KLSzOqot5GF2isxWgrfoJ6PZgBVk8mBvWWfolkI5Jf0O0Ufn/1cRnGNk5ke2Rxudw4H8
         m8by2o6+/HBBHNXsHdI99YFpHtoBNYvp/QPy/vH+ScR/MExXU/Mfs5d5G+2UH1Hxs892
         FzGVweQAdpxtMsqVFlX9dfcLFcfgysFlezBrw7CpySCkF5ZVEVwQVzEwJuMhSVQiZ8YE
         NEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685657863; x=1688249863;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51PWPY6BMWoDg45MlG9I1qZfsIaUCeI0YrMX7qE5Pw8=;
        b=eD2HWmu+3Rci0ZbZMAMP19gnLWSJ6Xm6bZ1rTNGSgaKJaEPGY9FHeWYWWiQF7+SEVL
         81mygbej5DINKGOTIzY0P7nQUG91AK4iy44FsJN5zfNWi+aOhxxyOjB8fDgHPzZvYtOk
         Ex6+iCM+U3mcM1MXVRDWhl4+E7Pt1tl0VJXekCbcUgouyK84CoNQq9rBl35L0rO78fTN
         ME1hECxrAteEQjVKpRmr0yQLN6rnr6+V9NkYBbcxjHTYcg78zoYpB3X5w9Cq1zQDgZYG
         1v2e78T0BpUZga6JngYs8w8+kKNJKxKLnq71yz4YT1J0vfE5NRgYDM+F/zmAlO/DPlik
         saBw==
X-Gm-Message-State: AC+VfDwO9Kczxzn+vP4er+nd6MK3pHaUxdq3pZJnCNDMs8xmjg7BbVrg
        x7xLZQS8RwNskD69lSbjA8fqiv2zfHWdKT7H+RpV
X-Google-Smtp-Source: ACHHUZ75Jjxez2fX0Ji8LUknD5INbgCFFSL+ONUxcQYPLsmdk0xOx+qNNyf4OVpFlNtpqmWb2uGJthRWT0u0WoOmra7g
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:9bd:7d22:5bbe:5b1c])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:120a:b0:ba7:5bec:7772 with
 SMTP id s10-20020a056902120a00b00ba75bec7772mr606468ybu.5.1685657863747; Thu,
 01 Jun 2023 15:17:43 -0700 (PDT)
Date:   Thu,  1 Jun 2023 15:17:41 -0700
In-Reply-To: <f363b16025996f6cf16a683f5e2b3fe3721f4d93.1685472133.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601221741.420194-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 05/14] (RFC-only) config: finish config_fn_t refactor
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
> 
> Here's an exhaustive list of all of the changes:

Up to here the changes are all mechanical, and look good.
