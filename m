Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0EDC6FA82
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 18:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiIWSJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 14:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbiIWSIl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 14:08:41 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DA26264
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:07:51 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id y9so545480ily.11
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8S6irmTGjD6OuOp1/+kwqFGtk/3BdpbOg3GggiIDGUg=;
        b=Pm61OW39QVMAKIzvzbqTpdm3VgHPo4gkfD2bCl4Dw4CfFfQmoH2wJWT+OO6T7EmqMH
         gbXa5+71AIxgvrFrXKx0LdAGypyBiGQYf/4VGjL0Q5NF58NdCtIo7/caNtLGKu/KooGE
         c+XsDJ+eG4OY6GlsmX7UF9Bm711omi0b/O3NkI7az15heqgwG7kS0JZJYZPU7gqxc3G7
         AoxOEXg+bdFbeh22fqoVqH9ZdGNk4BAPKpcJkpFSWJiDUbBEqVyvUZXqQrqx8YKlXwFc
         0ygvcyK3F8Dv01YlvJam/5p3nWwCFdaK6aCl1eYQfT08jvXENhufBONFOh4Te5DTBlQ2
         pbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8S6irmTGjD6OuOp1/+kwqFGtk/3BdpbOg3GggiIDGUg=;
        b=x9yfMTR6UdG7i+fNQRxOxduQELQx3EYUrQLa39TCpsn7Nu447wQrvt80uViExx2wXp
         D7sLtkXJ+86vRBTWKdr8jShSN0d1IaV5JeOXCRTHgmvISoPimDtsQpW4fWGb2EBXNAcj
         5lKEL/KOkZh5FSsijLNfdnHo6I9o54WjFC0DMjAj2RHMwN2oikGWHaRvXQPMt3LhJRwn
         e7CnFWKaeU4mt9mROfnm/FEYn8hVSppWn4zCAU7mdaMcqkiAAmaTXnJB6xK6JEgs80Fr
         Ny0Vqmdy4BZyuNDyyVH5Mf1FJ6ZBphQyOP17OYlXVCfEG78kZF2okIBKM5PHd4A04trx
         tG6g==
X-Gm-Message-State: ACrzQf05DSoipXyI5lec+uaQF0Psp5UQBtQe3V+Exha7uji7B9AT7wA5
        xPuXNLbp6/a0Q2Pu9DZHfin4
X-Google-Smtp-Source: AMsMyM4eNjDEdRBlyRWea0IMjG5CumqSe2+GKVXLnwjexlAa8xCBA9vcxbIAzN3abXDIqUyDzhOdDA==
X-Received: by 2002:a05:6e02:1e09:b0:2ed:578:8eb1 with SMTP id g9-20020a056e021e0900b002ed05788eb1mr4638851ila.126.1663956470961;
        Fri, 23 Sep 2022 11:07:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f43f:f355:a5bb:115a? ([2600:1700:e72:80a0:f43f:f355:a5bb:115a])
        by smtp.gmail.com with ESMTPSA id h3-20020a05660208c300b0067b75781af9sm3834377ioz.37.2022.09.23.11.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 11:07:49 -0700 (PDT)
Message-ID: <edf25c5d-06f4-0b91-6773-f4fe7705c2f8@github.com>
Date:   Fri, 23 Sep 2022 14:07:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] pack-bitmap: remove trace2 region from hot path
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, me@ttaylorr.com,
        chakrabortyabhradeep79@gmail.com
References: <pull.1365.git.1663938034607.gitgitgadget@gmail.com>
 <xmqq7d1uuh5f.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq7d1uuh5f.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/23/2022 1:36 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>     I noticed this while trying to backport the Abhradeep's lookup table
>>     work into GitHub's fork. Something went wrong in that process, causing
>>     this region to significantly slow down. It turns out that slow down does
>>     not reproduce on current 'master', which is good. I must have missed
>>     something while I was backporting.
>>     
>>     Regardless, the use of trace2_region_enter() here should be removed or
>>     replaced. For the sake of 2.38.0, this simple removal is safe enough.
> 
> Well, not doing this removal is even safer, if we know that it is
> not hurting in the -rc code.  It would be better than breaking our
> tests without knowing ;-)  I am not upset that the patch broke the
> test, by the way.  Compared to things silently breaking without
> surfacing, a loud breakage in tests is a much easier thing to
> handle.
> 
> My test run with the attached just finished, so that's what I am
> going to queue tentatively on top.

Whoops! I'm very sorry for not noticing that there was a test checking
for this trace. Your modification makes sense and I'll try to do a more
careful replacement of that test, if possible.

Thanks,
-Stolee
