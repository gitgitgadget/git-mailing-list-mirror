Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA5D62055E
	for <e@80x24.org>; Fri,  3 Nov 2017 09:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754141AbdKCJXp (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 05:23:45 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:51537 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbdKCJXn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 05:23:43 -0400
Received: by mail-io0-f193.google.com with SMTP id b186so4870492iof.8
        for <git@vger.kernel.org>; Fri, 03 Nov 2017 02:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tj348eB+7K2yU1q14K+Lymyx9yxvKaVAkWNUAhJCoj4=;
        b=bHrSbyzY0wS+98wvqVqmhN65/RGrWJz/jSeZNllf4jUTV77SJLmdSBzU6Onb8JDlot
         feibsmvSrlKVEmZU84vyVyb1+l+YIbOV0VadPAH0sdtoxzI6T3PvIFxyDzfVJReUB/TJ
         AOc6LZMiQZsmNj8CDlw7VcT0tczluvQwWlXgqcTgwsq1RzSk3OuTUszXW2RIHzEmbb1/
         9e0Ns0LYEqRR21NbhGT2o+1CO7OxFmTFLiAS6Fx3aswJmDshlV4gUsa85IalFUc6hE6c
         kv6EeYGLx2ZevkXwYltqcxTZTg+8JMrr4UyJHoUGn5OMHLTF64JTfKePd10gL5FK0rww
         nPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tj348eB+7K2yU1q14K+Lymyx9yxvKaVAkWNUAhJCoj4=;
        b=OxBciYN69g0JmmS8MA8rVdcxUn/zq/8ArRPQtzDN8KczX2i1fYa9eEChfbPiPeFjeq
         8plw/SWvDjgKUaQXopc8Mn5u7z6FcChEd6iEaz/dsb8qGtPaQ5DcGgG10YTzIQaIlDSK
         WiYNMHYRupc0MSfe3LKHsrIKF4DHbr+vKdiNK8klvv8S5RcAWo+wQxVIPz5k2Fe7MU9f
         RkzvqEcZfPJzTBesLzOPE+jHHxWuBr/izEswrZVLncvAIBCKLQ/19awuHQsfCaEe7E1n
         WoywkX28KeFwUtzRMeHF9U4igpaKWJDxWRMSvI/TOtfX70kRGWh6SUPFDGKsbSnXYJwc
         oQqQ==
X-Gm-Message-State: AMCzsaV0R6dyP4PgjOQQ+xkhO5ukgM/C+R/JYvWZ7csjdVI1K+5giHXP
        cuV8uP8ptJTNAjqrFuH7zL3fXgeN
X-Google-Smtp-Source: ABhQp+TtURyhKmVx0uL6Fey+aF9f14WIXkUvFxV2RQDte5xuXoD9r3k9ImfO7sCiF9zQa0G9o9mg4A==
X-Received: by 10.36.163.140 with SMTP id p134mr6475762ite.46.1509701022752;
        Fri, 03 Nov 2017 02:23:42 -0700 (PDT)
Received: from [192.168.42.176] ([117.251.239.143])
        by smtp.gmail.com with ESMTPSA id j63sm2566858ioe.25.2017.11.03.02.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Nov 2017 02:23:42 -0700 (PDT)
Subject: Re: [BUG] Incosistent repository state when trying to rename HEAD in
 the middle of a rebase
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <1509209933.2256.4.camel@gmail.com>
 <1509600814.9254.6.camel@gmail.com>
 <xmqqd151qft5.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <49563f7c-354e-334e-03a6-c3a40884b6d0@gmail.com>
Date:   Fri, 3 Nov 2017 14:53:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqd151qft5.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 02 November 2017 01:21 PM, Junio C Hamano wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
> 
>> I was able to spare some time to dig into this and found a few things.
>>
>> First, it seems that the issue is more generic and the BUG kicks in
>> whenever HEAD is not a symbolic ref.
> 
> Interesting.
>

Let me detail a little more about my observations just for the sake of 
completeness. The change that forbid refs/heads/HEAD caused issues only 
when HEAD wasn't a symbolic link because of the following reasons,

1) The change resulted in 'strbuf_check_branch_ref' returning with 
failure when the name it received (sb) was HEAD *without* interpreting 
it as "refs/heads/HEAD" into 'ref'. This resulted in the violation of 
the expectation of it's callers that it would have interpret 'ref' which 
was the major cause of the issue.

It wouldn't have been an issue if we had checked for the existence of a 
"branch" (refs/heads/) rather than checking for the existence of a "ref" 
(which allowed HEAD to pass the test).


2) This did not cause issues when HEAD was a symbolic ref because there 
was a check for attempting to rename in a symbolic ref in 
'files_copy_or_rename_ref'. The check throws an error when trying to 
rename a symbolic ref which resulted in suspicious error message I got.

So, IIUC the issue doesn't occur when 'ref' is intrepreted before the 
check for 'HEAD'. That's possibly why the diff patch I sent in the 
previous mail fixed the issue.

Also, it would be nice if we check for the existence of a "branch" when 
we want to know whether a branch exists rather than simply doing a 
'ref_exists' on the interpreted ref.


> Shortly we'll be rewinding the tip of 'next', and it is a good
> opportunity to kick any not-so-well-cooked topic back to 'pu',
> so let's figure out what is going on after that happens (at which
> point let's eject the "branch name sanity" topic out of 'next').

Does the above explanation give an idea about what's happening?


---
Kaartic
