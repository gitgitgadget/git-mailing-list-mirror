Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B10C433FE
	for <git@archiver.kernel.org>; Tue, 17 May 2022 13:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346544AbiEQNXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 09:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343851AbiEQNXd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 09:23:33 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755AF42A02
        for <git@vger.kernel.org>; Tue, 17 May 2022 06:23:31 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id bs17so14560120qkb.0
        for <git@vger.kernel.org>; Tue, 17 May 2022 06:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OBWWMBa1+yAyI4omNSctaGCAAF7BEcBHfgzlqWc1iQk=;
        b=Zyep/aRvdfhS+GGCAtZr4CXzO9V9g2tmTJeI73+U+MxYkkCJFPNSfIPs8LBNWMTMPA
         JbYoCP4mRLbGguxg5CgYL4bXLRA8kh50R2v1spp5VeNaIKQ1y/K0KyV6WrfTHtW8JWRJ
         uDw50WlZMX4rI90OTUoLOBylz9zlcGtV8ge8n8b5xfjxECtG5NZAfpUKhQpTvX9AEeQ+
         IjcNBdiMhyMLnzlk0ey8/Z81IkIOaB8a29ee5XlpPuSEJIEvBxt92PS+cZS5l8V0vRF5
         3HGE9RW1C+GhZ7cfDBp1MPIQNoY8n3FzZ3WBIrtf2L+fMHrIbk7tYSl9b525YH1ahU9h
         n99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OBWWMBa1+yAyI4omNSctaGCAAF7BEcBHfgzlqWc1iQk=;
        b=6SL5sHBnccq7O7s7xyGCCyAtfI7dm/glF8VvWHi4qeZCBEvziuxwKzbuPS0aB8Kdt3
         WLV0S4r8oz997UJh/kf0m1O+G1+b0FkgbQlfnkLlxh1SITPP8It/oksGzdrXZN8834cd
         ussIN1ORxzkQzElZzHRY0UozuoeBvRj1L5O58XrsNkd0g+3vuWXCNktZcwNh2+KgviAy
         fysMBjlmKtcQ/tkEafFmCpPHpJtqScL/J69BJksiRbLcITE2BpnQJbiyy7KkH1qP+Tdw
         Z5SI6njcSWJtxiCTPeAkwwKD/nU6bjGjEEGCiLou6OzAOyWbTXWsEUcEodkd25TTZS/+
         jYZg==
X-Gm-Message-State: AOAM5335iBgZ0iPOU1ejX84UgA122m0a93ndl0Ed28bW7Mm0WNbH/O9j
        q9LN8OAvrfQ4x1wdfasrQPbx
X-Google-Smtp-Source: ABdhPJxLINcE815nf/z7+3uDf+hzwvNA8KErS0phXUMM8T/VONOfDhEhJxZuQKNZmnY+KDsCzEmqew==
X-Received: by 2002:a37:7c8:0:b0:69f:c5f8:85a2 with SMTP id 191-20020a3707c8000000b0069fc5f885a2mr16564388qkh.662.1652793810579;
        Tue, 17 May 2022 06:23:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d51:acba:6df0:5bea? ([2600:1700:e72:80a0:d51:acba:6df0:5bea])
        by smtp.gmail.com with ESMTPSA id u190-20020a3792c7000000b0069fca79fa3asm7743617qkd.62.2022.05.17.06.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 06:23:30 -0700 (PDT)
Message-ID: <f756a125-2d88-3a32-1ae1-652932c663b2@github.com>
Date:   Tue, 17 May 2022 09:23:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 6/8] sparse-index: complete partial expansion
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
 <eba63cc12af4f60320b34a54eef691b9f59d86bc.1652724693.git.gitgitgadget@gmail.com>
 <ac3869a5-3592-5408-587a-178afde3f7e9@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ac3869a5-3592-5408-587a-178afde3f7e9@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/16/2022 4:38 PM, Victoria Dye wrote:
> Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>

>> +
>> +		/* We now have a sparse directory entry. Should we expand? */
>> +		if (pl &&
>> +		    path_matches_pattern_list(ce->name, ce->ce_namelen,
>> +					      NULL, &dtype,
>> +					      pl, istate) <= 0) {
> 
> If I'm reading this correctly, what this is doing is:
> 
> - if we have a sparse directory entry
> - ...and we're expanding only what matches the pattern list (i.e., not
>   'ensure_full_index')
> - ...and that sparse directory path is either *not matching* or *undecided
>   whether it matches* the pattern list
> - ...then we add the sparse directory to the result index and continue. 
> 
> The part that's confusing me is the "<= 0", which means a return value of
> 'UNDECIDED' from 'path_matches_pattern_list' adds the sparse directory
> as-is. At the moment, it looks like 'UNDECIDED' is only returned if not
> using cone patterns (so it shouldn't make a functional difference at this
> point), but wouldn't that return value indicate that the pattern *may or may
> not* match the path, so we should continue on to 'read_tree_at()'?
> 
> All that to say, should the condition be:
> 
> 		/* We now have a sparse directory entry. Should we expand? */
> 		if (pl &&
> 		    path_matches_pattern_list(ce->name, ce->ce_namelen,
> 					      NULL, &dtype,
> 					      pl, istate) == NOT_MATCHED) {
> 
> to reflect that a sparse directory should only be added to the index if we
> *know* it isn't matched?
> 
> To be clear, this is ultimately a non-functional nit - my question is mostly
> to make sure I understand the intent of the code.

You are 100% correct, and using "== NOT_MATCHED" makes the intention clear,
as well as being more robust to a breakage in path_matches_pattern_list().

Thanks,
-Stolee

