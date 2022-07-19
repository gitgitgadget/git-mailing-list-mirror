Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A57BC433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 17:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237975AbiGSRgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 13:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237496AbiGSRgt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 13:36:49 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92455A895
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 10:36:48 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h145so12398111iof.9
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 10:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=m44iTO+bloGD6HEpUKTiOIHBeAm2fp103TXCnaMpJeo=;
        b=dG43MPQmue6K+lQHKIksT71cyWJXqTg4wDyd3SJJzA2ZVXe+0/+QCJxCGCwEw7N1tz
         +vyRYcwdh7xzwvP+5F02iwyUWs/aTusDV04dQYTVf1m4gTSUgdIcEmbFYwqBK28oBZKe
         PrRVuDjWO+d56VxIzpIx7tinjPMUA+FR0Ggpi6g22o2r9LCvQ/1hqx1wx5+Rgn/30zVx
         4aUJ/SuAdBieMN7GECWVM7WxIoySPgf7UanIx8k9sOLMnopyW59eUkEWQX1mTP2ChIOM
         W56W1geflSeJTz0nCP+heKZWFCGFNb7QS7jPyaFdC7lZaWJIF/L1cNkLRU0IqS+ln7HM
         B8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m44iTO+bloGD6HEpUKTiOIHBeAm2fp103TXCnaMpJeo=;
        b=zxWsWNLnXwqA2ARiOdmcCwG4Tp+5eEAgBNXMmbSZXEr3t87BQ3RZ5MfH63KFbusCEX
         83mur7bRAa9GmZ0NUsUSiGD/JaiZL0D6+Jx433ujZwuHA+NnloEsxI9hqdcp1J0cdq1J
         r1CRwgCNlM+3n7XppRlx3p8mqpptjGoWjBL9R3OdifqMz8ufZDOR170wF4EA4Tyzq99Q
         70XJm5wzOMKE2Pps2ME7MmQ/fq8HSWWuYHCuixqena8K+O84euydbnBPhTRRY4x5BFB9
         C9vRB3gQpj8syPv7whnRnzAgXi59oPq7t3Cg4O8q4Q3rYz562DPqn02KODm7Ohe+5vdO
         mKDQ==
X-Gm-Message-State: AJIora8UItixzwex+Xo5nbmliOYGJK/kscIaenoHhaKlMvTnUs67+1DD
        lpWpdN8ZcJZhUtopgNNuoXIu
X-Google-Smtp-Source: AGRyM1tlbrV1+m7XumuWADPzLlLJ3/NaqVUNwNexqzynWuFyPEZgHMxMRW3N/XAOubqg2Lby6b4OIw==
X-Received: by 2002:a05:6638:3d0a:b0:33f:5368:a95f with SMTP id cl10-20020a0566383d0a00b0033f5368a95fmr17712570jab.123.1658252208324;
        Tue, 19 Jul 2022 10:36:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3950:7a99:4a4a:8622? ([2600:1700:e72:80a0:3950:7a99:4a4a:8622])
        by smtp.gmail.com with ESMTPSA id s10-20020a056602168a00b0067c01e5300fsm4003890iow.35.2022.07.19.10.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 10:36:47 -0700 (PDT)
Message-ID: <d914bd30-0f53-864e-b640-0173d168bcb5@github.com>
Date:   Tue, 19 Jul 2022 13:36:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/7] t7002: add tests for moving from in-cone to
 out-of-cone
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, gitster@pobox.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220719132809.409247-2-shaoxuan.yuan02@gmail.com>
 <220719.86pmi1up9d.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220719.86pmi1up9d.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/19/2022 10:52 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Jul 19 2022, Shaoxuan Yuan wrote:
> 
>> +	! grep -x "H sub/d" actual &&
>> +	grep -x "S folder1/d" actual
> 
> This *might* be a portability problem, but probably not. It's listed in
> POSIX:
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html
> 
> But it appears we have no "grep" use of the "-x" option in-tree, at
> least from what I found with grepping..

It is helpful to recommend a working alternative when pointing out
an issue like this.

Here, the '-x' option means to match the entire line.

Would using ^ and $ help here?

	! grep "^H sub/d\$" actual &&
	grep "^S folder1/d\$" actual

I haven't tested this, but hopefully the idea is sound. If not,
then you could make the names be sufficiently unique that
whole-lines are the only way they could match. We do have some
expectation about what lines are possible in this index, since
we constructed the example repo from scratch.

Thanks,
-Stolee
