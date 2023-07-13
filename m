Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4322FC001B0
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 19:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjGMTTt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 15:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjGMTTi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 15:19:38 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FCA2D54
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 12:19:24 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id F26585C0135;
        Thu, 13 Jul 2023 15:19:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 13 Jul 2023 15:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imap.cc; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1689275962; x=1689362362; bh=WeZx28kYIY3NUiVr78TnEjEWMdcdU51QAje
        I1JZWtD4=; b=xzUwFRqTCoJpiH7iCFgMdlotrJs/4sKuCbsxJbvYRm4Ksjc5qas
        NsWb5mqPMFAAjX8nmrRk+yafXd6mQFbeBBt8W2iRihmNWKLV50zMcq8u9v7OsJMT
        gzfqFxEwKjZjL/9NngMTWWENUDfAQ3Qhdoir4wqMDCZ491CAHg/M1jFmRW2RTY6W
        7yYijt22Z8miA4hrUteyURgRRd0Q+YjIZqF3+9o95M/urkOi/+lF+zAipQbJ2+T+
        JOJDDLgw432ONgM/V8WWjd/zYC1QiPw58qd3Dgw5fHVetYwZ7AkBte/l/KK7ON7t
        q6fD1MuLcf126Ja1V+4CEP2zMWlAwiR4zzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1689275962; x=1689362362; bh=WeZx28kYIY3NUiVr78TnEjEWMdcdU51QAje
        I1JZWtD4=; b=TOIr19WC3hktFYNV+nnNbBf3cATtZEMIjCiqDnCclqBHyUNA3D0
        t7LDWBpDlmkQ182Awa8Ont175OsDytBE2fK/SCdy5ZAPyNvBVrrKpXzj1XVpuDgy
        2QQ5pRTZzpsZLoW78+Ffucq3T26WGni4N4BosIMwrgmV6rHviwesy7MwhajgKIC7
        IzobA7gjKNfqpcjBShlWEbhNn2IzVXuH3DfLkSRiYULGja3fEgEooHQ3ierPObGS
        PiRYeq/8MslCqdZRkvC1HA1Fh0fqMcz1coGcpKLF3TOFRCBZaxB/2GQ6Bmvr4NsH
        uwvTH6VSteZ0Y352DBY/Ws2oMTFJ2yWtbZA==
X-ME-Sender: <xms:Ok6wZJCdrlwhDsaLIRLPrFi38NwaniEbKHJZBeZwHAAZ5Isz0Q5G7g>
    <xme:Ok6wZHiSnsDNLPkl902Wo6DctlbZTzSWbPCIpU4BvS9kwy9r3IGnJ2q7vy4frtHHi
    mJ2hNGQuXNivBmfaQ>
X-ME-Received: <xmr:Ok6wZEmFHIlCHl9URnOmo3F6CSCDextxNNoMTE8LwumxYVwzKtDB9j3voT7rQw4ITZvlZOJdhpITT946FRdPesfhHAFErdNV6SALbb4SQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeeggddufeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefkff
    ggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomheprfgvthgrrhcugghuthho
    vhcuoehpvhhuthhovhesihhmrghprdgttgeqnecuggftrfgrthhtvghrnhephefgueeftd
    eghfeljeegjeffffdvieevgfduudffjeehkeettdekkeeufeetleeunecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhvuhhtohhvsehimhgrph
    drtggt
X-ME-Proxy: <xmx:Ok6wZDzCE3M6UQIRFWF2_wysqX7if8Nl6i7T9IngboAKHuTPxz_EJA>
    <xmx:Ok6wZORffxOtXzVIDx4bZjTwv3zxPM6lbX3JcM87jepXwA6iU3IByw>
    <xmx:Ok6wZGZIeVxpfHfQKPKWvGEVixyHjNyeDRsJa04xygD-54hPqZAxig>
    <xmx:Ok6wZH6iTyZ9_w9p3KGNN823uK7M6JtxyIPKLIbHEcVGjLa-WmjY6g>
Feedback-ID: iccdf4031:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jul 2023 15:19:22 -0400 (EDT)
Message-ID: <7ce31744-8c9d-da75-126c-e92dfbb4cf16@imap.cc>
Date:   Thu, 13 Jul 2023 21:20:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] doc: remove mentions of .gitmodules !command syntax
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20230712160216.855054-1-pvutov@imap.cc>
 <xmqqleflt75z.fsf@gitster.g> <d775437e-7fa3-189b-a1c3-4fd358dd9768@imap.cc>
 <xmqqfs5tt3qz.fsf@gitster.g> <7090349c-4485-d5c4-1f26-190974864f72@imap.cc>
 <xmqqa5w0swcs.fsf@gitster.g>
From:   Petar Vutov <pvutov@imap.cc>
In-Reply-To: <xmqqa5w0swcs.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/12/23 22:33, Junio C Hamano wrote:
> 
>      Side note: but is there a useful use case to set it to 'none' in
>      ".gitmodules" in the first place?  If there is not, saying that
>      "'none' is only useful in the configuration files" is not quite
>      wrong per-se.

A twisted person might use it to commit a truly empty folder, without 
even a .gitkeep file. Whether that's a useful use case, I don't know.

> 
> Sounds good.  s/available/allowed/, perhaps.
> 
>>   	none;; the submodule is not updated.
>> ++
>> +The `none` update procedure is only available via the .gitmodules file
>> +or the `submodule.<name>.update` configuration variable.
> 
> This side we do not need "only" anywhere in the sentence, do we?
> 
> Thanks.

I will address both of those and include your bugfix blurb in v3. Still 
figuring out how to properly reference the previous patches using 
git-send-email..
