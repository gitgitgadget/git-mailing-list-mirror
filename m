Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2005E1F461
	for <e@80x24.org>; Wed, 21 Aug 2019 18:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfHUSMl (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 14:12:41 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44037 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfHUSMk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 14:12:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id 44so4138652qtg.11
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 11:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SVZTERedTyAyxbzMFH1aQGkEO1WvCNs1eKmRyT5j/+o=;
        b=RvmTDwrU9gToZRt8L+1HpH6qi3jTsBeLLAsgiwhBLSa09iSMatI6Gq5NecbsiZsRiy
         cX2ZN0ZpraGUatb6CA6M2eiTAqHcjOqFdVegVGvBEp62XWIczt7AN+SekDTq8d76SLOc
         Cfn15auCxp1x1XUE83rGvBEurWD5tf6qpPHKk/D7vUaev+9hTmAUFmWHKtM2lUdneymb
         Aywx+jmtVkDZcl5jxxmQOOLtKkzcZitcVMa4d70YEWYjpMR0XnxuwOfCuXHpB1Gb6Kqu
         Sad7Fv6Glwmznc9uUjLOFOAdUrd8XT+VV1nzuURMNKf4cOH1DPsnCGRws6Zr3wTSG7e3
         RZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SVZTERedTyAyxbzMFH1aQGkEO1WvCNs1eKmRyT5j/+o=;
        b=Hepm84ASOqms6QFYDqUbt8OPl0muCVyjVYFoNdfs/WMJC4S5ZuRAZTxsxeH4t665DX
         5cpFJYqAWpucyI/XZyWDe4T5AuHxUn9bhRO5t05sSLhW2I31pOTNTqwA/nUiEbgZC/q/
         CRR15BMUhDJoJT5fEMKqT7aIupLMOMvRfhgjncLgrDgWbO54KV3pFuiTz4thFwvt/qXK
         BnDshENXyZ97BtO3pqM2qRV8MKfGVYEsVshvv+mGlqLVcVzIMsVyPSCJWq3WfItvepm9
         iY2fGr90zVYqhp0cpbn7Qili58v1zsKoaw2k4vqukVDNO4rLoZFcn39TA4xLKMIhtlfA
         mweg==
X-Gm-Message-State: APjAAAXmt6akhkLWdqz8ZV8U4CNxflDPnlfxYXvwo+Mus3/rqanH0+op
        RK/dT+GftJPftE73Dx7u8cY=
X-Google-Smtp-Source: APXvYqzNgCo3innoRsuILB6n8KPI6/RZsmEZweA3NaM9AmsPC8hYkjpVADdo47ZlJ4VWGSn6AU7D9A==
X-Received: by 2002:ad4:4a92:: with SMTP id h18mr16898214qvx.235.1566411159539;
        Wed, 21 Aug 2019 11:12:39 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id u28sm13221417qtu.22.2019.08.21.11.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2019 11:12:38 -0700 (PDT)
Subject: Re: [PATCH 2/2] line-log: avoid unnecessary full tree diffs
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
References: <20190821110424.18184-1-szeder.dev@gmail.com>
 <20190821110424.18184-3-szeder.dev@gmail.com>
 <e52e867b-af17-d239-11b5-e0c6353acc2f@gmail.com>
 <20190821173515.GY20404@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <284c3d2a-860a-fc46-bb1a-56c6707de724@gmail.com>
Date:   Wed, 21 Aug 2019 14:12:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190821173515.GY20404@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/21/2019 1:35 PM, SZEDER Gábor wrote:
> On Wed, Aug 21, 2019 at 11:53:28AM -0400, Derrick Stolee wrote:
>> On 8/21/2019 7:04 AM, SZEDER Gábor wrote:
>>> With rename detection enabled the line-level log is able to trace the
>>> evolution of line ranges across whole-file renames [1].  Alas, to
>>> achieve that it uses the diff machinery very inefficiently, making the
>>> operation very slow [2].  And since rename detection is enabled by
>>> default, the line-level log is very slow by default.
>>>
>>> When the line-level log processes a commit with rename detection
>>> enabled, it currently does the following (see queue_diffs()):
>>>
>>>   1. Computes a full tree diff between the commit and (one of) its
>>>      parent(s), i.e. invokes diff_tree_oid() with an empty
>>>      'diffopt->pathspec'.
>>>   2. Checks whether any paths in the line ranges were modified.
>>>   3. Checks whether any modified paths in the line ranges are missing
>>>      in the parent commit's tree.
>>>   4. If there is such a missing path, then calls diffcore_std() to
>>>      figure out whether the path was indeed renamed based on the
>>>      previously computed full tree diff.
>>>   5. Continues doing stuff that are unrelated to the slowness.
>>>
>>> So basically the line-level log computes a full tree diff for each
>>> commit-parent pair in step (1) to be used for rename detection in step
>>> (4) in the off chance that an interesting path is missing from the
>>> parent.
>>>
>>> Avoid these expensive and mostly unnecessary full tree diffs by
>>> limiting the diffs to paths in the line ranges.  This is much cheaper,
>>> and makes step (2) unnecessary.  If it turns out that an interesting
>>> path is missing from the parent, then fall back and compute a full
>>> tree diff, so the rename detection will still work.
>>
>> I applied your patches and tried them on our VFS-enabled version of Git
>> (see [1]). Unfortunately, the new logic is still triggering rename
>> detection, as measured by the number of objects being downloaded.
> 
> Well, the goal of this patch was to avoid full tree diffs if possible,
> not to avoid rename detection :)
> 
> Anyway, I wonder how does 'git log -L1:your-evil-path --no-renames'
> fare as a baseline?

Yeah, adding --no-renames does really well, comparatively. Perhaps I'll
just recommend to users to use that flag for now.

Thanks,
-Stolee

