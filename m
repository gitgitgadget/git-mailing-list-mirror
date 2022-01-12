Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB61DC433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 23:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbiALXnc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 18:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbiALXn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 18:43:28 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEB3C061748
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 15:43:28 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so15576488pjf.3
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 15:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=c7mlGbVOAVtNH1A+p78gQF2se/KjrelH8YFnlDQ/zJk=;
        b=ENNGdkLvl29h4C3fGHSPxoETTU2pJjY/Ps1UMrPLAP/dzgX6SEnXke7PoapuCmLuw+
         TEeaooN3wOwPK2RNcLnDI2Eur4CJpHOLYXANiKu8vucIH3jmZCvvLS0zxHEOYqjOJ0rw
         MKqWLijDDXHecN6AJu2L2ttbIW5VcMEsyPSc8GvwV7KmPCtF6Z1OryKlcIVgHARXLL0k
         nWazsDJhuH0wFCNjshdxQiUag46FYuCjOajr6xwtJplIHb6jIb7C8k06ptccr6zKzQga
         gLW9iMMGbU/ofiDHVnFiebyJn1s/XvTAdFitmQj3jjHR2WDcxeQ/ql0npTCXXGa4URN2
         5FVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c7mlGbVOAVtNH1A+p78gQF2se/KjrelH8YFnlDQ/zJk=;
        b=LLlJA6sysrjYawf0pjbuGctolKFWVVYahWI0mcRVcu+ZT89ydNWuuOue5h7se1Kq8Q
         zLfGjuXCSHGAywGk5Icrre259XROJI2Hu8WTYtjyhWyx83bdpZiB86yEOVcIpLVSc6oR
         ewnALRd9BPXDonmIVtkXZuZGolk9nlePSIqUaT9xiJUR8gdRYwfLBnASjZeLf8W6f0WZ
         v5CFRFfppEvJfJAMHf9bFbDUXyUWQLFOzZCO6wLas/TbtzQCEleQbVY7RivERrQohfkc
         12ENJ/zkGmcEiBxBrp639C6+hQYfrx2nIwI26FUUacBeA+NZcaviFM6R0ecVcpnGz44M
         KhXg==
X-Gm-Message-State: AOAM530UC7yaC/dvBhj0+uvQg3I+GKt8RNDZmDKgCBnytncniRCldwx+
        XVOIUXZHGEnjuEGVRzC/blw=
X-Google-Smtp-Source: ABdhPJxc3AEKaXya/hLfQEoCcj5cqO/5uC79vKyOIQMmKAiJ2X7oEYOKZLhTPFO+XAJCqYluq04cQQ==
X-Received: by 2002:a17:902:f54f:b0:14a:6ee7:681c with SMTP id h15-20020a170902f54f00b0014a6ee7681cmr1785808plf.58.1642031007913;
        Wed, 12 Jan 2022 15:43:27 -0800 (PST)
Received: from ?IPV6:2601:602:9e81:12c0:29c0:e427:4ddf:b329? ([2601:602:9e81:12c0:29c0:e427:4ddf:b329])
        by smtp.gmail.com with ESMTPSA id d4sm658161pfj.78.2022.01.12.15.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 15:43:27 -0800 (PST)
Message-ID: <0e4bb6f1-337e-38b3-75b2-fe11ff8d68b2@gmail.com>
Date:   Wed, 12 Jan 2022 15:43:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v3 3/3] sparse-checkout: limit tab completion to a single
 level
Content-Language: en-US
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, johannes.schindelin@gmail.com,
        Elijah Newren <newren@gmail.com>
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
 <aa9ea67180dd10ef8bdf17e8c23694da15828b21.1641841193.git.gitgitgadget@gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <aa9ea67180dd10ef8bdf17e8c23694da15828b21.1641841193.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +__gitcomp_directories ()
> +{
> +     local _tmp_dir _tmp_completions
> +
> +     # Get the directory of the current token; this differs from dirname
> +     # in that it keeps up to the final trailing slash.  If no slash found
> +     # that's fine too.
> +     [[ "$cur" =~ .*/ ]]
> +     _tmp_dir=$BASH_REMATCH
> +
> +     # Find possible directory completions, adding trailing '/' characters
> +     _tmp_completions="$(git ls-tree -d --name-only HEAD $_tmp_dir |
> +         sed -e s%$%/%)"
> +
I am admittedly unfamiliar with the use of this format in sed expressions
(I'm generally more accustomed to '/' instead of '%'). It's definitely
working as it should, I'm just not quite sure of how.
> +     if [[ -n "$_tmp_completions" ]]; then
> +         # There were some directory completions, so find ones that
> +         # start with "$cur", the current token, and put those in COMPREPLY
> +         local i=0 c IFS=$' \t\n'
Does c need to be declared before the loop?
> +         for c in $_tmp_completions; do
> +             if [[ $c == "$cur"* ]]; then
> +                 COMPREPLY+=("$c")
> +             fi
> +         done
> +     elif [[ "$cur" =~ /$ ]]; then
> +         # No possible further completions any deeper, so assume we're at
> +         # a leaf directory and just consider it complete
Thank you so much for the detailed comments on this change - it made it
really easy to parse.
> +         __gitcomp_direct_append "$cur "
What's the reason for the trailing space here?
> +     fi
> +}

Added my review as mentioned in [1].

[1]: 
https://lore.kernel.org/git/pull.1108.v2.git.1640892413.gitgitgadget@gmail.com/T/#md3da435452988b0366ab4c2ee4bc06df2d17cb36
