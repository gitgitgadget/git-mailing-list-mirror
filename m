Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9787EC0015E
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 19:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjGMTqD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 15:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjGMTqC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 15:46:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A94269D
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 12:46:01 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C34E15C012B;
        Thu, 13 Jul 2023 15:46:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Jul 2023 15:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imap.cc; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1689277560; x=1689363960; bh=mVVc8i4mAxlllUUdNrdLjY9eMLY7xXKVx6N
        SSBN/gVI=; b=DgQ4a61lm2AAJyVZgo63FtCdSqG+FwrTCcxpkJv7kqq0qgB9+ln
        my5b4HMHtpSeJLaXIzf4ipUGckaWzDQwg6jhYoLL8VFebCau0qafdIpU5RGLq63s
        +4MpJ57CxlAQm04werDfO7NmNEBgTZAmmhe4XH8KGzZblF13wThWQX1F1HUZdbDG
        KycgaPRqTrEneQV4JyseG0cZav4vFTXmn8qzcKSynLEMgYIikJ8ViwvDigWPmohX
        LWrlJScJoT14RdpQ9OewqtTFkVn7o8MdWNZ8Es3WmVxqmsRlVJ31e2lH3xkGnr/X
        jaIUZREFXN2zB7J2q7eFKTVmQn7Cmpu1hRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1689277560; x=1689363960; bh=mVVc8i4mAxlllUUdNrdLjY9eMLY7xXKVx6N
        SSBN/gVI=; b=gdazUJ9aeqaZPmJlxxfWBg/8ePVIIH4T7EcuIKtokb37Yru2nGY
        a5eqS2PqV0chHBOOx3RvxV8PKMtCBTru09VHSTxcirUhFE5SXmv5yiGrWhRoCoWt
        mlUr2OuAcrct9LhFEWI79/4+VCzlC58H+OilgdAnauzKsBygDz6WNnhvhaSNY5nH
        1tiJ/Et9Q/lejXCYt+SCxq2L+R0lSfVGecwKs9RD5ZaKFyLXCLAtmLVOHed3paIS
        6VRVLPGMCooMj/nPXHlKTq7nNPpwnDvabIOEbYb5GlVTm2rOS0678LRCUG1C/qwD
        S6SvGSM+3oyGfvww+kWbQF1YBa2g8Km0DBg==
X-ME-Sender: <xms:eFSwZGVCJ44DLvVJLpWnh8Zy_C63VXBsbcRjj89v2zJ5nf26zMR7VQ>
    <xme:eFSwZCkfcN-6hVB7i0fAnp8PiYLccWCixTQIfFrAmaTksOVwz2QE9ITbk3fKkkFlF
    ghT9e0lIUx-pKqDuQ>
X-ME-Received: <xmr:eFSwZKZy6B0e8hdqyj5VGot73zIh_MnRnDNssVyR-rmaP2m1AZvsiX92-d09v3lN8og06t1uazIdeK5c53VDkUU2o_v7xdp3OcGC45UzpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeeggddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfedtmdenogetfedtuddqtd
    duucdludehmdenucfjughrpefkffggfgfuvehfvffhjggtgfesthejredttdefjeenucfh
    rhhomheprfgvthgrrhcugghuthhovhcuoehpvhhuthhovhesihhmrghprdgttgeqnecugg
    ftrfgrthhtvghrnhepleehjeekhfeigfduhefftedtueduffejvdetvdekkeetieevgeeg
    leefleejudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepphhvuhhtohhvsehimhgrphdrtggt
X-ME-Proxy: <xmx:eFSwZNVg5Xw0gwDoWf_k0zn43kszes201Tg7DTKmA01wLoUZwxHqYw>
    <xmx:eFSwZAldSXniPBeHv08OMUx470qgd3KXFqYVEFdQ19Jvn5cHFG6gIA>
    <xmx:eFSwZCdPBaFVmLeTTPVIaBdBLyTiWwh84bVklhhCzUAXyatnZQQevA>
    <xmx:eFSwZHv-dg65cMTOF26PKpR8rW2i-KdZnaKhKcl7yCc8eWvIm7vNMw>
Feedback-ID: iccdf4031:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jul 2023 15:46:00 -0400 (EDT)
Message-ID: <a8bde495-57fc-6a70-e325-6e2a52f40552@imap.cc>
Date:   Thu, 13 Jul 2023 21:46:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/1] docs: highlight that .gitmodules does not support
 !command
Content-Language: en-US
Cc:     git@vger.kernel.org
References: <d775437e-7fa3-189b-a1c3-4fd358dd9768@imap.cc>
 <20230713193342.1053968-1-pvutov@imap.cc>
To:     pvutov@imap.cc
From:   Petar Vutov <pvutov@imap.cc>
In-Reply-To: <20230713193342.1053968-1-pvutov@imap.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oops, this was supposed to go under 
<7090349c-4485-d5c4-1f26-190974864f72@imap.cc>..

Side question in this side thread: I was tempted to change the mention 
of "configuration variable" with "git-config variable", to highlight the 
narrow meaning of the term. But I grepped and that term is used 
everywhere in the documentation. Changing it only in this section would 
be inconsistent.

If I were to go through all those mentions and figure out which 
"configuration variable" mentions refer exclusively to `git-config`, wis 
there interest in changing them to something like "git-config variable" 
in a potential future patch? Or do we like the term "configuration 
variable"?
