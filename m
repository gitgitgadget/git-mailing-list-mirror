Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC028C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 14:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351764AbiE0OsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 10:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239311AbiE0OsI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 10:48:08 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A6113C4DF
        for <git@vger.kernel.org>; Fri, 27 May 2022 07:48:07 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id t2so4943272qkb.12
        for <git@vger.kernel.org>; Fri, 27 May 2022 07:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GtTNsioTXQ2XYUzBxbTV7OWMTxr9e3nDeDfquhz0CwA=;
        b=eZSNLt1Lnt8Q7El5FNDMLnMc6BM9Lh+fsSpcq2ryKtb2dqXHfFpWlJFuddJuEel3bq
         2uRmUi9dTIb0ShgYqQCUkQ/NwQaAJgXEdKna9iKEabmljgAn4ue30e6qgNN8gUJebkby
         57JHp93u+QU674gBpS3/kLtmltSgJ2Afef70ZfX37o561+ehlFXIaEMcnLUpmowu3WqV
         bVK92YgLSAU2VE00YW6F7n9ipRs2SOqld7kVaOEVVtIBHMBlsnl1TE4rpcNwSM+0+Kfm
         Cu+hE84io0XL5BedEOHl5uWI4Es2Rbq1+fZuP708ecoc4NHkuNoqZvdnmRd2MjHWPxZ9
         OqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GtTNsioTXQ2XYUzBxbTV7OWMTxr9e3nDeDfquhz0CwA=;
        b=jqrYGwRzxEs1PEuhkUvJyzzZhqqLI5EZw1K1n34krfyyIol5J/ls7/2TIYRYXDPYkG
         PpzWtQ0lc9W17urgM93O8ANeS0Sh/b3kjvW6PEGDmZu4RhNpdC6vUvZT26kLNBszXDU0
         MQD6ryYSN8jYwe04rttOHIdT6IiWH6ZTiP0/hIcL/agYkmYYV1NphEhhnWOTLGHwI4zk
         xRjMeNiLuCbU3AOoe1d7y3460oig+sKf7ou/vcZcBSlLDtVuN/oLDaiiTC0jEslQkZdj
         mCEjf2nYqjn1FXwCqO3Su3Ac4GSjIAZtd8ie/Jp4x4000+mDbyD/eDWq01ofMjJxG7qE
         YfVA==
X-Gm-Message-State: AOAM530cqTuqO1ho3V8yyd7mJNNJZ2IaPXtAS4MDAkQJ7jHUs/eY/E8P
        N/O6wYWlgcfN8/QMtjRWJi6HflveZ1XO
X-Google-Smtp-Source: ABdhPJz0DS1V4QH4R+pEVBvHJu4az7M4Ir54cNOTrAsKK7jPdD572J29t+j5iee1QxA1LKUx4LorvA==
X-Received: by 2002:a05:620a:2697:b0:699:cca7:f8b2 with SMTP id c23-20020a05620a269700b00699cca7f8b2mr28472433qkp.738.1653662886866;
        Fri, 27 May 2022 07:48:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9d56:33a:55eb:168? ([2600:1700:e72:80a0:9d56:33a:55eb:168])
        by smtp.gmail.com with ESMTPSA id l8-20020ac87248000000b002f90c73ad8csm2597196qtp.7.2022.05.27.07.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 07:48:06 -0700 (PDT)
Message-ID: <8ced7008-5d52-01a6-4ebc-467343a2f11d@github.com>
Date:   Fri, 27 May 2022 10:48:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [WIP v2 1/5] t7002: add tests for moving out-of-cone
 file/directory
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com, newren@gmail.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-2-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220527100804.209890-2-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/27/2022 6:08 AM, Shaoxuan Yuan wrote:
> Add corresponding tests to test following situations:
> 
> * 'refuse to move out-of-cone directory without --sparse'
> * 'can move out-of-cone directory with --sparse'
> * 'refuse to move out-of-cone file without --sparse'
> * 'can move out-of-cone file with --sparse'
> * 'refuse to move sparse file to existing destination'
> * 'move sparse file to existing destination with --force and --sparse'

Style nit: bulleted lists like this don't add too much value
on top of reading the patch. You can use prose to describe how
you decided that these tests are the ones to write. Something
like:

  We do not have sufficient coverage of moving files outside
  of a sparse-checkout cone. Create new tests covering this
  behavior, keeping in mind that the user can include --sparse
  (or not), move a file or directory, and the destination can
  already exist in the index.

Thanks,
-Stolee
