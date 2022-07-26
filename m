Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35348C433EF
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 11:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbiGZL31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 07:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238725AbiGZL3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 07:29:25 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E30326CD
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 04:29:24 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id g1so10672564qki.7
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 04:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=36/y36YyHgR4fP0SRojFr6m12R2bT7em9Ad+tX10dZw=;
        b=RPjhnZHK8N2+OQGMW9M+/+KEFbTbBrmUUz8Im9kGlOkvzX1tBg7MThY908Ht8MbuLY
         nrIwvDgk1iAQ+cxm01bB9k4G5uX23n49YyGyjPNAhTli68OtggT8HBTiQ4KNiic0xm82
         rEQ74GsRWJMmByGPwhtWX9Nl9VgZAi3UnxH2Hen/2XVzjq1ti4hTESGGSJyfZrGs3G7N
         7FgB2NrmJV6ZjwE32tWjBNvdTUF4wbT+qNVR7pYIq9W7xx2u3A4avccPDUYP8Tyo9WgK
         obCytHiXNaVBdOFdHw8DoY43ztaKN1zC1y7+1jTWAEOeFvO48t28Y9KMa7hbFaDnPUHv
         ceDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=36/y36YyHgR4fP0SRojFr6m12R2bT7em9Ad+tX10dZw=;
        b=nWxQagU5JFFL5rKcVgT7T4lSV1HVKeE+Xn3ekCiQK/1AAAsVoUZT+my8vg2CbJoiJW
         fb8ba3+Ezk50BKgfGt8/O/QxsadQds8NOq88rFqoTxriPavEhL1e2dIV/ezwc3RuK+OK
         kvUHvGzRx98JqG7UupiQO2Jya1q0gv13MC2a3sDWkNUcr+fD3/zh/emw6Zp2XyLB+yQj
         Civ1yNsS4F32eU7vvAd97B1t/z9M9FwsZiMZtqbpaQRBqnjBsNbwijmfkxq9JvcXtioR
         3RFdpy38XaGtF0A4C3wMaNRHFnDmmq5N4t6EqVsACrlR/JbOZQoMlMJF2RkK3rbTtuPU
         KlHA==
X-Gm-Message-State: AJIora8ZrloER/ETCLCeBkJj0s64EFOqNOOKtiP+gIXyJ97zQdAJ9kYr
        JlzooFPCjyvZRk3lw4oOv1x+Q4i1sOBj
X-Google-Smtp-Source: AGRyM1uK5tSn6MFA0zHxHF5SwY4jV73wZyaUVUQV3EBR/9M2GuYa3iXPJTBWWVptMZYbFmHXJsYLWA==
X-Received: by 2002:a05:620a:19a8:b0:6b5:e407:494e with SMTP id bm40-20020a05620a19a800b006b5e407494emr12316809qkb.679.1658834963613;
        Tue, 26 Jul 2022 04:29:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:883d:f4f5:91dc:5fc6? ([2600:1700:e72:80a0:883d:f4f5:91dc:5fc6])
        by smtp.gmail.com with ESMTPSA id u22-20020a05620a431600b006af147d4876sm11213178qko.30.2022.07.26.04.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 04:29:23 -0700 (PDT)
Message-ID: <d1d460f6-e70f-b17f-73a5-e56d604dd9d5@github.com>
Date:   Tue, 26 Jul 2022 07:29:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: tb/commit-graph-genv2-upgrade-fix
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <junio@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqh738bq21.fsf@gitster.g> <Yt8RcDeSht56gU5v@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yt8RcDeSht56gU5v@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/25/22 5:56 PM, Taylor Blau wrote:
> On Fri, Jul 22, 2022 at 06:01:10PM -0700, Junio C Hamano wrote:
>> * tb/commit-graph-genv2-upgrade-fix (2022-07-15) 3 commits
>>  - commit-graph: fix corrupt upgrade from generation v1 to v2
>>  - commit-graph: introduce `repo_find_commit_pos_in_graph()`
>>  - t5318: demonstrate commit-graph generation v2 corruption
>>
>>  There was a bug in the codepath to upgrade generation information
>>  in commit-graph from v1 to v2 format, which has been corrected.
>>
>>  Will merge to 'next'?
>>  source: <cover.1657667404.git.me@ttaylorr.com>
> 
> Yeah, I think that this one is ready to go. It's the minimal fix I would
> consider acceptable for squashing this bug, but it should do what we
> need.
> 
> Stolee gave it a positive review, and I doubt he has any objections.

I agree that this is ready for 'next'.

Thanks,
-Stolee
