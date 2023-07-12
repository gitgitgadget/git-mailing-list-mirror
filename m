Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E2FEB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 17:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjGLRaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 13:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjGLRaB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 13:30:01 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C1410C7
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 10:30:00 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 29A4B5C0121;
        Wed, 12 Jul 2023 13:29:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 12 Jul 2023 13:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imap.cc; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1689182996; x=1689269396; bh=PaI8fUfrPPnN8ugM4D6CSJH1JBe8wbu8FnS
        ommDL0sk=; b=c7ZMjTUINzU11WI0aH5Apf2SzIF6s708WdzsEUFJdr4PCq0/4Ig
        pmaSsLH4pT4sKKX3VVJH/ZjbzLN7FhqDcAZBZbmJkNPrEhcPCkuqjr7F7vEHqBmj
        GgJkIjv6S5//hprqsuw948tudUnNUEuBKYkl7cx76tYZf/qvF1qTKptJ1YQdPh9H
        3/n5wr5slzKBplcz+O8WjxLo3G15YnzTsCdBGbmaJDrUfwe6aimzfEJ0kaZO2rT4
        Ic1TvhuylprvkFAZz6VOXWGz6r86p6yrpw+W2SIkAXMXm6GnEMYwKIFp0DVAcp0d
        Mp66j/JEfaAuU7mck2GZCYdVofziPGpRITA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1689182996; x=1689269396; bh=PaI8fUfrPPnN8ugM4D6CSJH1JBe8wbu8FnS
        ommDL0sk=; b=ghYeFMdm+E+S0iqa/7PRVpnOG1qA7/GOTxpAHIyR8Eu7rk6YsA+
        lX7o2SaiLQZbQTEoCIif24mQXwMG4no4ApAcd3epffVzEslHvC9tElZ6Cl3o03Wn
        dIBHlNHkJZROX5xr1SJAXGjbNq+QIXTUgeEFNEzRiwpzBJvYN221nwcN3mvkemlO
        lpezawpdMC/saBsH6qi97gC9yLHPfTyplLUESX2GMFYedsP/14JMF8fMSZoKLrVg
        9zDXvGClFT16v8MBKkS8b0UFLPR4ku14T1kHsXoD/JaLEjQgyoHMmFTc1ZbnEiwJ
        inIRJtyWVKP9qKOydjl8sHFcP4cwkhL7yAw==
X-ME-Sender: <xms:E-OuZHUB3-WgOXEjeNzpPdmy-uy2ji4Uh-OI0UWZc6iXRSYCxGTD5Q>
    <xme:E-OuZPnYFFFZ4BA4epYW92mbK5RMq9CgS2K8vMVa_7YJ8Ua2hDevOSUkLCE0LCf9g
    aU8FJ3wqsvcXiidTA>
X-ME-Received: <xmr:E-OuZDZwvCtrAwwQSu2ninwlcyS6z3Wgm1INYePDPsambOyGwyc_qYl72bBoUSY8Ku-vBbjjiFf60K3mHGAbenZsGcNjaesQkUbszdUf3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedvgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefkff
    ggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomheprfgvthgrrhcugghuthho
    vhcuoehpvhhuthhovhesihhmrghprdgttgeqnecuggftrfgrthhtvghrnhephefgueeftd
    eghfeljeegjeffffdvieevgfduudffjeehkeettdekkeeufeetleeunecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhvuhhtohhvsehimhgrph
    drtggt
X-ME-Proxy: <xmx:FOOuZCW3t3aAgs7kjMFlxAHc34aBkcNjbNXQGKBHCXsca7awk65aDQ>
    <xmx:FOOuZBn9I8MbIMBK_B0zKFgdghLDZbjLsldv1M7vw_hebnawtwfrGw>
    <xmx:FOOuZPfVqe3_Ko0FQPVerOvWaEgjPBPrcEgF9DPcBcnv7YLVkELARA>
    <xmx:FOOuZAseF5fIixr2u4KE3-blQt6lkTaPWC-bQ1Vu4t0OG4NSsS0yqQ>
Feedback-ID: iccdf4031:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jul 2023 13:29:55 -0400 (EDT)
Message-ID: <d775437e-7fa3-189b-a1c3-4fd358dd9768@imap.cc>
Date:   Wed, 12 Jul 2023 19:30:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] doc: remove mentions of .gitmodules !command syntax
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20230712160216.855054-1-pvutov@imap.cc>
 <xmqqleflt75z.fsf@gitster.g>
From:   Petar Vutov <pvutov@imap.cc>
In-Reply-To: <xmqqleflt75z.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/12/23 18:40, Junio C Hamano wrote:
> pvutov@imap.cc writes:
> 
>> From: Petar Vutov <pvutov@imap.cc>
>>
>> To mitigate CVE-2019-19604, the capability to configure
>> `git submodule update` to execute custom commands was
>> removed in v2.20.2.
>>
>> The git-submodule documentation still mentions the now-unsupported
>> syntax, which is misleading.
>>
>> Remove the leftover documentation.
> 
> The change during v2.20.2 timeperiod you have in mind may be
> e904deb8 (submodule: reject submodule.update = !command in
> .gitmodules, 2019-12-05).  The key phrase is "in .gitmodules"
> as it did not forbid writing update command in the configuration.
> 
> The pre-context lines of your patch (see below) say that the 'custom
> command' option and 'none' option are only available via the
> `submodule.<name>.update` configuration variable.  IOW, this part of
> the documentation does not talk about the .gitmodules file---it
> talks about what you can say in the configuration file (which is
> under your local control).
> 
> I think the existing text that came from fc01a5d2 (submodule update
> documentation: don't repeat ourselves, 2016-12-27) may be
> misleading, and may has room for improvement, but I do not think it
> is wrong per-se.  If we remove it, there is nowhere else that teaches
> users !cmd can be set in their configuration files, or is there?
> 
> Thanks.

Thanks for the review. I was not aware of the .gitconfig use case.
I hit that paragraph while trying to enforce sparse-checkout
via .gitmodules. Yet the gitmodules doc is clear enough:

"See description of update command in git-submodule[1] for their 
meaning. For security reasons, the !command form is not accepted here."

Clearly I followed the link in the first sentence without reading the 
second :)

Perhaps the term "configuration variable" in

"The following update procedures are only available via the 
submodule.<name>.update configuration variable:"

is more specific and technical than immediately obvious - I would have 
expected the contents of .gitmodules to be a form of (repository) 
configuration. But that is just bikeshedding.

> 
>> Signed-off-by: Petar Vutov <pvutov@imap.cc>
>> ---
>>   Documentation/git-submodule.txt | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
>> index 4d3ab6b9f9..b40ac72f75 100644
>> --- a/Documentation/git-submodule.txt
>> +++ b/Documentation/git-submodule.txt
>> @@ -163,12 +163,6 @@ checked out in the submodule.
>>   The following 'update' procedures are only available via the
>>   `submodule.<name>.update` configuration variable:
>>   
>> -	custom command;; arbitrary shell command that takes a single
>> -	    argument (the sha1 of the commit recorded in the
>> -	    superproject) is executed. When `submodule.<name>.update`
>> -	    is set to '!command', the remainder after the exclamation mark
>> -	    is the custom command.
>> -
>>   	none;; the submodule is not updated.
>>   
>>   If the submodule is not yet initialized, and you just want to use the
