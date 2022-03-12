Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFA1C433EF
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 14:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiCLOXG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Mar 2022 09:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiCLOWj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Mar 2022 09:22:39 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644C48D6B7
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 06:21:30 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 6C5D25C0106;
        Sat, 12 Mar 2022 09:21:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 12 Mar 2022 09:21:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mcclimon.org; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=P3GbB0NfOY39T5pSYNx9RUDV/peSIAA8zxI0bs
        a0aBA=; b=exF/QMtRX/REXpvw8c4ouL5MH3F2NdIbjUOYP2vWNQw1D1IFp0Qatt
        h/BV0TBLsmK4najuykbnA1VtfgbpYRrQlhfESqZH3I8deiZvaUGZLQgWB28QZ5Yo
        bFwzyWlO51J8Jl4C5stZs9zSoxdbrfLd/Mi3GY2QCWi7fhuZAIdHl0ywmrpqVTdN
        Vdd1KRt87oPR0G0QzXfA0jgRU9/lpzG1ZvyrcBWtONLzuu9o9olY/6UwUVvaYUh4
        w1nZ0PwQCdQnz0rpWoQfQ65GX39otfhm62Lb+iz4lMhaBh+6/tlZZ/f+R/0mm9E1
        FK6+AC7+WdgsJRgjseDjS/9bxeQnGXrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=P3GbB0NfOY39T5pSY
        Nx9RUDV/peSIAA8zxI0bsa0aBA=; b=UIWloDy9C7wcIwZNo7rtZliL/QoZpYCoh
        4KqK1pgwK7cCTWrVMLbClU+lHpgZUwQMkF3+aMAQwtvNHwNi4SQUJ9OK1z2DQPz6
        slmcRknGN/rnPAymda/CYHUHcHlte7rM22Fd1qk9Xg/DMNj6ndD/07gF9ZJLoclJ
        3ffRdhvg3j5SvSCNfhq1EfYNE7oUzYpdfT7XZtkD3qHjNUzIXLdpBVi0jjqID3Ur
        V5wqLt1BxV/yHw9d37PwUxTk9Z4flcaYJrwyN59GSKCjZFT9pKVvVOireIdSOYBq
        dK3MCaRKTKWL4iDsOSop5157cVrMJSBYiaYfsl7sJgyMk3yIxd5Xw==
X-ME-Sender: <xms:aKwsYsLKPsvRBTkX5RUcwE-vuXEcXfrXlgxfYQkMKPkpOJXUAA1cMA>
    <xme:aKwsYsK8tGI6yNVtAlc5aia5frXQRg2AqdQ5IFhJ2S_61u9JeWdybkJtaYTfJUk8h
    OVvYjZn_vA5RbkDoQU>
X-ME-Received: <xmr:aKwsYssCw57pwJKkpPKuxTe4tfwRFukJipT25z62j80A7SIGoE_s48PSK6I5onU9agiHIkt2-vGx7cz4G7F8qLypA_crSH7AVQSHG09GP19X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvgedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefoihgthhgr
    vghlucfotgevlhhimhhonhcuoehmihgthhgrvghlsehmtggtlhhimhhonhdrohhrgheqne
    cuggftrfgrthhtvghrnhepteettdevieelgfetjeegtddtjeeftdfgtdejudehheduvdfh
    feeglefftdfhffegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmihgthhgrvghlsehmtggt
    lhhimhhonhdrohhrgh
X-ME-Proxy: <xmx:aKwsYpb-ka84j4Rt9XNu7_fvDxW5BDe6rSXikMnng7TjPmnz68RGqQ>
    <xmx:aKwsYjbub-6b9xtI4IdnOENN77YeMyWigoxtZg_LjP82WMtjyYkX3g>
    <xmx:aKwsYlCNWwSsEUtUvttL4eIHYf9IFZKqO7Eqh1FmANnHpgaqrv423g>
    <xmx:aKwsYkCOgzorqDSmuZ18mkW2_AqYXHglUowbnzdmWWIsSQusVZ34Rg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Mar 2022 09:21:28 -0500 (EST)
Date:   Sat, 12 Mar 2022 09:21:26 -0500
From:   Michael McClimon <michael@mcclimon.org>
To:     John Cai <johncai86@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug with rebase and commit hashes
Message-ID: <YiysZtW/vRqIYHXp@newk>
References: <YiokTm3GxIZQQUow@newk>
 <C92B297B-0634-40CC-B1C6-B2A7325BF7DA@gmail.com>
 <036EAEE4-D957-41F2-8B17-3AD7B2E49611@gmail.com>
 <YiwPJD39+/hnu36j@newk>
 <B91AE306-6836-47C1-AC99-B06A50BAF61A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B91AE306-6836-47C1-AC99-B06A50BAF61A@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Thanks for looking into this yourself! I actually have a patch out already [1],
> which is pretty similar to what you suggested.
>
> 1. https://lore.kernel.org/git/pull.1226.v2.git.git.1647019492.gitgitgadget@gmail.com/

Oh hey, I missed this when I was skimming the list archives.  Thanks for the
fix, and I'm pleased that I was mostly on the right track!

-- 
Michael McClimon
michael@mcclimon.org
