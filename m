Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7607F1F462
	for <e@80x24.org>; Fri,  7 Jun 2019 12:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfFGMhM (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 08:37:12 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38269 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbfFGMhM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 08:37:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id l3so1989448qtj.5
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 05:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GS7WTNpSnSAjJ/6/vbjl42xy3R810DovTfYvss6jDlc=;
        b=qqPxhHtOvcr+dYRRI3h0fUs54qL61wfDho1bL9ivlDevMReJD629yoOLBi6ErHqkUq
         4Qg/uf7uS4OxSg7jbxfaLfK4T1DPclqwLa9y3kt7MZPeAkpdFHyPKCjaf7nMpW5hpy0P
         Rg/l7kE3YdfiLTyWLd7yxbyQEps88t+GynIC0AYlOnQbX55xzqLyIC0RON1Kgqc7r4/q
         D41n6ps6O7khA+PEqQSj/DqnpPUQ3qziMRutvNrQQ1DZi2ReaCeo5HQvvsU4yRA9A0xI
         OrSaMRDN/MpUUo8NqJt7Ph0ifu/vZgVGoXa18Ss8R0fAAbL8oe7yqA1EG9YtLyadI5tR
         2DsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GS7WTNpSnSAjJ/6/vbjl42xy3R810DovTfYvss6jDlc=;
        b=Sf/4PAiyuDhUTaBBguJBK/2qpCUVsoq2frxRhOHfs+vYrVi/zxzRp9iRq1FIJ3sLIR
         i3+MC7a4Vu+Np7ggmeHBTzDvXoeU7PM7SXEgZwEwtdGcXoazdZMSEO6VLWc0Kc+59ZTG
         sbiIlQHA0WbGUoRLqNjRYnRm0YgWd+jcS3/tkfPm/+EoWI290Qrmgjr5f+h3RoTUzFnc
         gnxcUshiF/JA3PalpVTu+OIYBRVBOEA5+GVCbhW8QsUG/ZkLlEDjyWOeSO8ii+gTH887
         tenadh4zjfWRdqZVWpmK0yGdLbBvkFMQAPsBlgcJlGJWhGkan3KFcOwWk0NFWMsT23hr
         IL9w==
X-Gm-Message-State: APjAAAUcWmg8YhyHPS7bSGtt5ezPuiLkAk+ABDxFhmO/3AApV+EFijWY
        3IIlAH1oAWyZD5XtNZN0FwI=
X-Google-Smtp-Source: APXvYqxR8tO8n/8n+uVXaSI54LuTY4KRWXTBMvfvaX4hrSayjeMTNmSUG2Pqlzdhf6fqoLFz2cBmvg==
X-Received: by 2002:a0c:d4a2:: with SMTP id u31mr24401510qvh.218.1559911030976;
        Fri, 07 Jun 2019 05:37:10 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4daa:35d6:a381:1849? ([2001:4898:a800:1010:fedf:35d6:a381:1849])
        by smtp.gmail.com with ESMTPSA id y19sm1091348qty.43.2019.06.07.05.37.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 05:37:09 -0700 (PDT)
Subject: Re: [PATCH v4 00/14] Commit-graph: Write incremental files
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        git@jeffhostetler.com, jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de
References: <pull.184.v3.git.gitgitgadget@gmail.com>
 <pull.184.v4.git.gitgitgadget@gmail.com>
 <xmqqmuiur6qy.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9fb274a2-a618-201f-9a45-bf0245bdf67b@gmail.com>
Date:   Fri, 7 Jun 2019 08:37:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <xmqqmuiur6qy.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/6/2019 12:57 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:>
>>  t/t5323-split-commit-graph.sh                 | 240 ++++++
> 
> This breaks test-lint, as t5323 is already taken in 'pu' by another
> topic.  I tentatively moved it to 5234 for now.

Sorry for not noticing this. I've moved the file to 5234 in my local
copy, so the next version will not hit this problem.

Thanks,
-Stolee
