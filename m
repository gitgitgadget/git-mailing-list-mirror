Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 402AC1F6A9
	for <e@80x24.org>; Wed,  2 Jan 2019 23:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfABXCD (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 18:02:03 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32862 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfABXCD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 18:02:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so33676078wmh.0
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 15:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5h5Qamk1up+lmujMJz8iC7eUbypYHOzB81udbe1CEko=;
        b=ENz35gUbY32tH17cLjmAMbzfijLXdDySOerPnn/deLZLqsyXX4w8VNKqk6XNE915Nv
         PJpWJT4r/yxiAYZGRO2RAxby6ImrKnPKT49iJjd7t9WxjT+B4UOrcBCrIIt4/hz/ctz0
         M+EgrWW7nc6MikMAMNpIFjKS2IboGhAFCcVYyfI1wB5tT05p8tKyb4oH/tl4hn7rxJ2D
         pyYpkNHn04wEj+0mDu9xiFIPdFI0RHvJ2Wy/1I14KSib4dIvi0/3yu9O2zW/6VY0lDWf
         3HPJPFu244A22nJ1yJ1zNLU53j5S/bPGko03gxYpzKy0emHv+4a9zspsvqKhsIAoxEDu
         HPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5h5Qamk1up+lmujMJz8iC7eUbypYHOzB81udbe1CEko=;
        b=jzcYmRjX9FvaTFFxJZVtCBJDx9UUqf2Dz0u258/V7N6BnaM/1ulKbSnxVNIjF26JwI
         YBPrbhj+0mT3UGAuTK6lkuG9hsENXnQwluVIVBUkVCNgKmYGP53hoE3paYKZsdeGW4tu
         e/OSDf06VGWYUjiHZQAxlf0dLNKABndaMT3RjFNdcs+pdZ9qKR1E+ln0AIBqukD3XxDR
         +zkT6nYjq9i6ypXE/af2n3bBjxxS1K8shizpX+NfxSc/XbjNnYfwl9iesvDwcfWSZ+40
         LJOKRa0gEFZlUr/hn8FtcnjemC1nO4mHzlS2+bRFD4HG8PJWgUA19FYcMiB5D4Qfoc4H
         UNMw==
X-Gm-Message-State: AJcUukfWdxpx6Gcmzvs48sujfeokOuZQBi5kK8E8I3DZy15GwWdzDRLE
        koleLqXGnQxIpNv8n9Sp9xc=
X-Google-Smtp-Source: AFSGD/UFMbs+WMAX3AEtuaRyS6MVBxtD/gr8rHT9DgvL0c8HjzGHHrnFwsuDyOVQc4I1pAQUeDc9Iw==
X-Received: by 2002:a1c:6489:: with SMTP id y131mr35687375wmb.34.1546470120869;
        Wed, 02 Jan 2019 15:02:00 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 200sm40042984wmw.31.2019.01.02.15.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 15:02:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] commit-graph: writing missing parents is a BUG
References: <pull.102.git.gitgitgadget@gmail.com>
        <907a24d2c45acec17607971b577782798c4adcbc.1545250444.git.gitgitgadget@gmail.com>
Date:   Wed, 02 Jan 2019 15:01:59 -0800
In-Reply-To: <907a24d2c45acec17607971b577782798c4adcbc.1545250444.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 19 Dec 2018
        12:14:07 -0800 (PST)")
Message-ID: <xmqqwonmiryw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> When writing a commit-graph, we write GRAPH_MISSING_PARENT if the
> parent's object id does not appear in the list of commits to be
> written into the commit-graph. This was done as the initial design
> allowed commits to have missing parents, but the final version
> requires the commit-graph to be closed under reachability. Thus,
> this GRAPH_MISSING_PARENT value should never be written.
>
> However, there are reasons why it could be written! These range
> from a bug in the reachable-closure code to a memory error causing
> the binary search into the list of object ids to fail. In either
> case, we should fail fast and avoid writing the commit-graph file
> with bad data.
>
> Remove the GRAPH_MISSING_PARENT constant in favor of the constant
> GRAPH_EDGE_LAST_MASK, which has the same value.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---

Thanks, will queue.
