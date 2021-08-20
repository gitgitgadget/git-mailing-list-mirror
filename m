Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC2BC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85691610E5
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbhHTAvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 20:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbhHTAvI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 20:51:08 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D128C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:50:31 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id a10so366942qka.12
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kah1/mrIb3x3DmckV0jdY29tS4RVGAk3HefFTkyMW8w=;
        b=V7Je2AltjClysHsIBelNG+gCkWfthgf8drJzQ9CI2dLaeMpu1Y3+rBAIowMgOYIaut
         GeDH6KxHszhMV8m2UlDtAVRagOF3lBM855Xrw8PlsVFi8iaS90WnDMDLrPTg7q6sCM0S
         jQO6bsI+pxTRLbNVPq96LHWkPVj7v6N6KZjpoJpapCn/Kx0VI0itG0RASvSMbLg74/RR
         xuHDUmMH4ibkuC3DRU0HOUUaW83ly6isSw8T6oCXP742nFMTk6jeJ0JOPBtBIiroACIv
         pFlz5zt5wdTGdjUAkRFGR/4iXnQnfvMMe++Hz/vsxDAOdpz9fdB7RCmfRaGYdXnitwMV
         8hEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kah1/mrIb3x3DmckV0jdY29tS4RVGAk3HefFTkyMW8w=;
        b=pKrxtLuqJBIjSWxmgZ2IcKa5T+calgrQYeysEfDj6TS4rDnppjVRdl1zzknuV692sl
         RNM26qDPcnKJvK1WhcMc16M7ZqRDxTQye533ANd5Ye9jP+KKDI4aGbvMtjFF54Ajs0kS
         tQta3vMzJ29XHH+qlnXvoFz1RkChBPjE3NfKUdWImE5hDkPUqtOxSXjpqR1rjvJcY9xO
         O7lPCScvpuaIuICBkcxsh2PuOq+lDb5+RARdtAFE5tA0wtEOt+ZE0QcXz43p7LKw7l6r
         KbmE4/DLOjiRvZ2EVInDXdtBu0965aPDZdsN/rNqoqYrO9XAW19Y5OGN2fi8bX/FhIKK
         o1bw==
X-Gm-Message-State: AOAM532F3kj3TOXc50J+LLs/8B6jrNtN5UXhccWegmiNvk1JzyqoH+ZF
        EwWq7mmAFm6P0KVYWpFu7qRJ/XvhQIRzdg==
X-Google-Smtp-Source: ABdhPJzwxb9lniYowpqGG0cwSpoyM9LBfizNE1EVXyPfjWLsxLgIissJAVuNce6pQMM+p0frE0xzdw==
X-Received: by 2002:a37:8183:: with SMTP id c125mr6280416qkd.134.1629420629936;
        Thu, 19 Aug 2021 17:50:29 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:2127:20ac:7d67:3e01? ([2600:1700:e72:80a0:2127:20ac:7d67:3e01])
        by smtp.gmail.com with ESMTPSA id 14sm1932600qtp.19.2021.08.19.17.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 17:50:29 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] submodule: record superproject gitdir during
 absorbgitdirs
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20210819200953.2105230-1-emilyshaffer@google.com>
 <20210819200953.2105230-4-emilyshaffer@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ecc6c43d-1415-125c-af53-31274a86f656@gmail.com>
Date:   Thu, 19 Aug 2021 20:50:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210819200953.2105230-4-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/2021 4:09 PM, Emily Shaffer wrote:
> +	/* cache pointer to superproject's gitdir */
> +	/* NEEDSWORK: this may differ if experimental.worktreeConfig is enabled */
> +	strbuf_addf(&config_path, "%s/config", real_new_git_dir);

Regarding this NEEDSWORK: you are specifying the config file that
covers every worktree of this submodule, which seems to make sense
to me. The submodule shouldn't have worktrees to itself, right? It
might become a worktree if its superproject has a worktree.

But also: it's still correct to write to the local, non-worktree
config file even if experimental.worktreeConfig is set. That
config just means "we need to read the worktree config as well
as the local config".

Or, am I misunderstanding something?

(I'm advocating for the removal of the NEEDSWORK, in case that
wasn't clear.)

> +	git_config_set_in_file(config_path.buf, "submodule.superprojectGitdir",
> +			       relative_path(get_super_prefix_or_empty(),
> +					     path, &sb));

Thanks,
-Stolee

