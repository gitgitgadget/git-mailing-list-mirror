Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E74C19F2A
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 14:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiHGOqT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 10:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiHGOqS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 10:46:18 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA84462FC
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 07:46:16 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 29B625C004D;
        Sun,  7 Aug 2022 10:46:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 07 Aug 2022 10:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659883573; x=1659969973; bh=6GcL02b8oU
        /8v6+wXw4UbBElNkfMY89UJPg7sbvOlB0=; b=KbIHwOeoA0foOv4fqDDZgLbcS7
        oNwT87gbwos6GgvlewSOSFhNqqy0N4hR9HB5XiM5GYLE5Jxx8Iq2Cx4TVc/eDWSr
        Z1j50hKZ/y+eUJsNL4VtFS9GaS0Z0Ua3fdU2M3qzpHUCZezSNN1dH1bzgN2zcj8y
        RntISA5egMes1dHGJ7kbmYzsDW57kFWCNFYvfFDdOkvQKseFFMakPWCVkSIMm915
        2Ta4uegH5ewwdu3gntT0hbKK3WagSEQPBkpdaZKHT1zuYEfrCb1CnclmCsPfAhrp
        hRN3fu8BDeQneU/ta3LhgAV1UMZqKwJhJyw+qbGuZGdu8STqiQN7mbEWDjFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1659883573; x=1659969973; bh=6GcL02b8oU/8v6+wXw4UbBElNkfM
        Y89UJPg7sbvOlB0=; b=eDIos4mgezl/QdDfYe6idDnGLWBmbJ4yxTTlj654d7lr
        XDevXu7ufj9ITt4Js1A89CZzpPbgBfzfPMTqOfawfEE06U7AbgzV2VfIC96NVDqW
        ge+CZ6c5uVzKAFoa03JTzgeI4eunf64+jh0tCCxGMnbdl7U0MS0AezRocukf+tX8
        PHmTpwnVcMDPIBeRpIRX4CFyB4SwRwUlTc75+MCIdI61AsXneNdWVF1t6RnZVGlm
        e1aRP4oUOJGerzNhiY6h8yzIuP+k8rcpkwPDTzEdRjbQ6wKbzsyNejt1BMOX1zIf
        rv2c1pq2zV560MBDX1ZODvZ+Sm8ub0X7k5kqQ+wpRA==
X-ME-Sender: <xms:NNDvYuWRyKxOaBVETOBnSG7Xs3vOMAT9iEo8I90AjQ8jHBl_vIV-eA>
    <xme:NNDvYqn4iyE6WEtFlppDP0QeGsT2S6M6C1h-gMQCVF9of7w01pT4OjphUBQ43UJQd
    Pc0PN6hKpq5gjHOzQ>
X-ME-Received: <xmr:NNDvYiYOLctrm-seZFFvH8EUoQcEcjDbcnYvdyfmsfvEeiU2smGrtuf8JukiYQ8RHlxv1Ft_uZ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefiedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhephfgvrhhn
    rghnughoucftrghmohhsuceoghhrvggvnhhfohhosehuledvrdgvuheqnecuggftrfgrth
    htvghrnhepffehveetfeejveeikeehueejieevgfeuvdeifeelueeigfdttdelleehveel
    vdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:NdDvYlWW0EDU0dkHtCrEGRGcTJI3gkAlAjmY4m3pY1A_lGounxW0Gw>
    <xmx:NdDvYokkgIhkU0eubIZvOktefDqcVj7Dd131BtPFpRGmkPM64h2hhg>
    <xmx:NdDvYqdAlTyy2vHYftd_WbWao0SZL7GbJyKwme7wJ4R3cnOjgMJ6vA>
    <xmx:NdDvYvuJY_qnaFJooHBqCzaC9WXcTXkqDwnUmTuOIWvdO13i6pfdQw>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Aug 2022 10:46:10 -0400 (EDT)
Date:   Sun, 7 Aug 2022 16:46:04 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 9/9] mergetools: vimdiff: use vimdiff for vimdiff3
Message-ID: <Yu/QLJg516n3gJXF@zacax395.localdomain>
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
 <20220807024941.222018-10-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220807024941.222018-10-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/08/06 09:49PM, Felipe Contreras wrote:
> 
> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
> index 34373ad92c..daeb3cf1d0 100644
> --- a/mergetools/vimdiff
> +++ b/mergetools/vimdiff
> @@ -325,7 +325,7 @@ gen_cmd () {
>  	if ! echo "$LAYOUT" | grep ",\|/" >/dev/null
>  	then
>  		buf=$(get_buf "$LAYOUT")
> -		FINAL_CMD="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | ${buf}b\""
> +		FINAL_CMD="-d -c \"set hidden diffopt-=hiddenoff diffopt-=closeoff | ${buf}b | only\""
>  		return
>  	fi

I found something strange while testing this:

This is the final command that is generated now:

    vim -d -c "set hidden diffopt-=hiddenoff diffopt-=closeoff | 4b | only" LOCAL BASE REMOTE MERGED 

Turns out that now colors "kind of work", but not completely:

    - The buffer that is shown by default ("MERGED") contains colors.
    - If you switch to the "LOCAL" buffer (":buffer 1") it also contains colors.
    - *But* if you switch to any of the other buffers ("BASE" with ":buffer 2"
      or "REMOTE" with ":buffer 3"), there are no colors.

For some reason, the command that was generated by my patch to v1, does work (?)
and all buffers contain diff colors:

    vimdiff -c "echo | silent 4b | set hidden | let tmp=bufnr('%') | silent bufdo diffthis | exe 'buffer '.tmp" LOCAL BASE REMOTE MERGED

