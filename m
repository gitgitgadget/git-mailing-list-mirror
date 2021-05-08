Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED171C433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 02:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2B7060FD9
	for <git@archiver.kernel.org>; Sat,  8 May 2021 02:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhEHCX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 22:23:28 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52255 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229775AbhEHCX2 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 May 2021 22:23:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3A59D5C00E4
        for <git@vger.kernel.org>; Fri,  7 May 2021 22:22:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 07 May 2021 22:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=date:from:to:subject:message-id
        :mime-version:content-type; s=fm3; bh=3u0yPobrqXivAMCF56nYc3+QLC
        xYpmzSh7gFbJ1G+vQ=; b=rFRKIF5hf7ZuNdGrIjKsm6xwykyf5P6ROyNpEAhs8m
        4OBv06DEXWEkBr1O+hm1k+n4xF6osDCHJdn1d9D/L+lwN97E+ktarEGx6yKS9mbo
        v0Bidx0Yv/uCDXqiUhIiIciZoyfRBYsFKVMgyoCdGPKeXF9VEqKYggZI+LOIsk4R
        /HGb4Rrvdt+MjelK/yG1UnQEjfkLK0pDi0u/uTF4/YIbh1u7IlCB4aBH9sTruMni
        jE4ysQ8E5KRamiKm7zNrauBn5dUixWQC8FaQdYYCR59jNFJiPEcPvEEyW5omIO7u
        juaYz34+uH2rkLahGb7LNo12GDjvWS1ZQf9ynA2FxxCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=3u0yPobrqXivAMCF56nYc3+QLCxYp
        mzSh7gFbJ1G+vQ=; b=QzdHRF+vSfUZ4zzENtSIkpj3tEhno3FsBxAQAGg6MG4e6
        harN2wzWkMoPat1654KtCxfCS09EZhJUwvKDkYc4m5dtrWosPU6CSYBBgEg/EQEG
        bUsc3EaZGpxTXkvtRemNZ+Dl9a8qj3iCJS/FcxSBcsq3jQFjSnpvv3deyluWnWr/
        DBeF3x/lxSfnWm1EhD01iqcCzB5yqgKGnylh2OxGa3A9dHwT5CYFSsL/7adX3urY
        pHok/k+tHFCfPN3L1jkUPtk7MPbEldJZepexOZYftoNY+SvU94Zx9/O/732yVC5m
        01so6GJzwa6z7+BVeOVy16gfTCyiwgH1YSzMDab6g==
X-ME-Sender: <xms:4vWVYKTyefL_HXX1ubrzEGA6--kJDysB-N1tamivcnB8qLvLL545pA>
    <xme:4vWVYPzDEf1DHTBNoobNdNTMDq8r4H2MdORQKdvXzulKB53v5a509BLkub_WmaPbu
    8Y5PxKepyQJVESg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegfedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtuggfsehttdertd
    dtreejnecuhfhrohhmpegufihhsehlihhnuhigphhrohhgrhgrmhhmvghrrdhorhhgnecu
    ggftrfgrthhtvghrnhepueffleehfeetieeghfffhfekveekudeggeegffevteduhefgke
    eikeduhfetudeknecukfhppeeikedrvddvgedrieekrdehnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugifhheslhhinhhugihprhhoghhrrg
    hmmhgvrhdrohhrgh
X-ME-Proxy: <xmx:4_WVYH0yVeKXtGcfe4ikySOyCKU7HvFEphyavcJeoisKMsgr90wnNA>
    <xmx:4_WVYGA5wh_04Bziw214QgjDOncpaZOLG0XgyUWzdXOMkKCJzT4Acg>
    <xmx:4_WVYDhyAmb4SnPXQfGzUn9bS0KuzrVvO3oRgNm47dfDJYgKPRJtJQ>
    <xmx:4_WVYCQa3bbzM0_2rwVMON9AGB5T00KS6KoiGi82KErLRPfcF-UM2Q>
Received: from localhost (ip68-224-68-5.lv.lv.cox.net [68.224.68.5])
        by mail.messagingengine.com (Postfix) with ESMTPA
        for <git@vger.kernel.org>; Fri,  7 May 2021 22:22:26 -0400 (EDT)
Date:   Fri, 7 May 2021 19:22:25 -0700
From:   dwh@linuxprogrammer.org
To:     git@vger.kernel.org
Subject: Preserving the ability to have both SHA1 and SHA256 signatures
Message-ID: <20210508022225.GH3986@localhost>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everybody,

I was reading through the
Documentation/technical/hash-function-transition.txt doc and realized
that the plan is to support allowing BOTH SHA1 and SHA256 signatures to
exist in a single object:

> Signed Commits
> 1. using SHA-1 only, as in existing signed commit objects
> 2. using both SHA-1 and SHA-256, by using both gpgsig-sha256 and gpgsig
>   fields.
> 3. using only SHA-256, by only using the gpgsig-sha256 field.
>
> Signed Tags
> 1. using SHA-1 only, as in existing signed tag objects
> 2. using both SHA-1 and SHA-256, by using gpgsig-sha256 and an in-body
>   signature.
> 3. using only SHA-256, by only using the gpgsig-sha256 field.

The design that I'm working on only supports a single signature that
uses a combination of fields: one 'signtype', zero or more 'signoption'
and one 'sign' in objects. I am thinking that the best thing to do is
replace the gpgsig-sha256 fields in objects and allow old gpgsig (commits)
and in-body (tags) signatures to co-exist along side to give the same
functionality.

That not only paves the way forward but preserves the full backward
compatibility that is one of my top requirements.

Thoughts?

Cheers!
Dave
