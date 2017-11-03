Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 613D420281
	for <e@80x24.org>; Fri,  3 Nov 2017 02:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934746AbdKCC7H (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 22:59:07 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:54516 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbdKCC7G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 22:59:06 -0400
Received: by mail-pf0-f195.google.com with SMTP id n89so1173315pfk.11
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 19:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DvelL2UelBV7cctiy1S5eBvWt1OpaHvUb7R5NjSqP/w=;
        b=N+uAMjMDratA3FUYY3jLhpjBXvclstNyPHwzhX0/czF4thrpxHPXfyEx0PzrhQSkaW
         bOAe9ywYbBo4kB/gNAS43qzEAAkC90YhA7PYMTRtLGEn7trZ1bsASIpPLSzn6WSzCWu2
         S6i9JWRV7Uw3k4rLFGVY3enuVVLA1nubgTwcA7P4h/iHF1O7PlrGFLuKzD2kXgwb4s+K
         OE+X75KHNODfkC29kZy+6VAc2AoVluPcIFl/o9oTgzirNeZB9eswuDziifLs/eeWmtHj
         gXhdLqT/zu0qOooDMvZfqzbbTVVYMniLCpnMh6SlZTSqSWww4f71OrlCSgnY53YlI5k/
         HGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DvelL2UelBV7cctiy1S5eBvWt1OpaHvUb7R5NjSqP/w=;
        b=ftIao8BIFaSnm8IbSNPMNJ8eX/nqNkyQw4vrASDXl6b+Dz2hGSjjyBApNPmUMFSu4x
         eAUr0SasTQZ2ed3mxPxmKyvAWtG2FUJJ86CcgAVxQf8UyY9Xu6FDOmfNUTBX9P7RWfQY
         0YS+PeNXwE2gkaKgBYHtE8N9dnVKH+XTGyqNrCFT8Ge5rwM2Zp1KKbwkVjg9IJeO2uRj
         oOKV+FhKHJ4hP7E5oO5o+G2oyiKLMcB8w+g2nDTC3iSVguYEA4ALq78CePqtdceath5N
         2U4V1n3jT1YSnSJ1fPeInF5Rnrd8o5A6Qp0DwopwuMP7bSd4G+OzEzuwMQI/+uN/neUv
         jHvg==
X-Gm-Message-State: AMCzsaWvFMFHxcKnFQwkprSquE8bIC9R6jTakmzEB9vcqhSmO6S6RQYr
        9GTMiq3esJzjSyz/mrjJQK/d0fBw
X-Google-Smtp-Source: ABhQp+Q4wZKHevj3BPck0VGiSPuSlpuIrGZvPATDV2hca04HNrgbs4l8ExUoK6K78bog5JJ70Ovigg==
X-Received: by 10.99.123.94 with SMTP id k30mr5719710pgn.33.1509677945274;
        Thu, 02 Nov 2017 19:59:05 -0700 (PDT)
Received: from [192.168.43.71] ([117.249.180.49])
        by smtp.gmail.com with ESMTPSA id o22sm9262871pfi.85.2017.11.02.19.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Nov 2017 19:59:04 -0700 (PDT)
Subject: Re: [RFC PATCH v3 3/4] branch: introduce dont_fail parameter for
 branchname validation
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
 <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
 <20171102065407.25404-4-kaartic.sivaraam@gmail.com>
 <e8a600d4-880b-4fb8-6901-78acbd720261@gmail.com>
 <CAGZ79kY-1PLf2aOeNOkPz_MNSPtJHTtj=9eC-xdbbLq+WZbkwg@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <2aba29d1-3c6c-f04d-b284-991dbe15be54@gmail.com>
Date:   Fri, 3 Nov 2017 08:28:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kY-1PLf2aOeNOkPz_MNSPtJHTtj=9eC-xdbbLq+WZbkwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday 03 November 2017 12:12 AM, Stefan Beller wrote:
> On Thu, Nov 2, 2017 at 1:39 AM, Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>> On Thursday 02 November 2017 12:24 PM, Kaartic Sivaraam wrote:
>>>
>>> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
>>> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
>>
>>
>> I just now saw this small glitch as a consequence of recently
>> changing my email address. I would prefer to keep the second one
>> but as the other patches have the first one it's better to keep
>> the first one for now.
> 
> If you prefer one of them, you may have incentive to
> add an entry into .mailmap file, otherwise I'd kindly ask you
> to. :) (c.f. `git log --no-merges -- .mailmap`)
> 

Sure, I'll do that. My intuition says this doesn't remove the duplicated 
  sign-off line. Anyways, there's for sure a v4 that's going to update 
the connector string in [4/4] and another update. I'll be careful to 
address these issues in v4.

---
Kaartic

