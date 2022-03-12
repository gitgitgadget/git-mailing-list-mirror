Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA45C433F5
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 03:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiCLDQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 22:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiCLDQz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 22:16:55 -0500
X-Greylist: delayed 317 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 19:15:50 PST
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE724A93C
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 19:15:50 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 213823201D2F;
        Fri, 11 Mar 2022 22:10:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 11 Mar 2022 22:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mcclimon.org; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=VzMimLGyCa7BA9il2Pw2lDdBBbIcPBfsy5f+oL
        z2JHo=; b=icn26eoQFMdGlByuxUonIXpC9HaEUb0FLUAg8NAg2mUeJAIyhjhSIL
        BlVlAQCP72Fmf4E4pfzC3jBwT/Q1Ylk2WwB0MX1eWXDUR7FDv78U3rDnOnXNyZel
        lTIBOB6p4pSEV4JWTMzZcDttYQivAy+Bm2NbGhyNGFIySGTLesBXoeWu9FZnmdZw
        xKbeIchT/+A56qKrzBBRH5VFdRZkGpQb7WENm9gHO1ahRnOFP7kz6bgdbGU3ZZn6
        C4NlACrEjvnQsnBT7gsg8ot/yP6A7FxfiOiMZ8C2RWcVRe2VMP6/qebThY7/Y924
        ietZo9EReypVPThg4IaGl4Zrpl9nvHag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=VzMimLGyCa7BA9il2
        Pw2lDdBBbIcPBfsy5f+oLz2JHo=; b=Wdy0Li1siAfPAD91ySzQIbIc8PNK4TMF1
        wfwf7CnP9cBajXbpRdh+vkKdeAsy6OnblM1Cn8DQ4CSlvo8Tjgq3Vs5KbFPF+x+i
        XTICbi5L9s7Bh/zW8OoVusNjfCF2WW9nFceVBHUcqldE992TD7moe75FfTn4T3TG
        48YRMjgqbL+hPHu3G1rYJ46PQw318AGBukgtn747/U+dZ0BFyX+jIBQ2F2uwq/pE
        hFE4VW0OmSbqtpinG5rK1Uc0JrJma6/Ojgx16XjJrwYTVQxXhQs9TwovPhULvFKS
        7wG0DPgTuFBHFIm4RFT1UZR/FX25kRUEgHyImn54FTQCMqr+uWCVQ==
X-ME-Sender: <xms:JQ8sYh-p1Tr7PRArZWY7G9RmGyMI_smkxncCNXTi_qofrp31neTjrw>
    <xme:JQ8sYlv4dBXLYZcF8DWQVtFO40Y_sie6Yp3MQ9T6a-UgMEA-xXWBvDvcCYikrU_H0
    sad3mEgdXQbhhYdyDQ>
X-ME-Received: <xmr:JQ8sYvDYMw9ZFatK-0fltW5cyDbaF3Qci9BEEbIFk35BELPAmE8ItV_bVkGNByabrk9M4j9if27pLPYcMOmIOo-eipFGZJACjtZ3RUHVmZko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvfedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefoihgthhgr
    vghlucfotgevlhhimhhonhcuoehmihgthhgrvghlsehmtggtlhhimhhonhdrohhrgheqne
    cuggftrfgrthhtvghrnhepkeekleefhfffteeuleekkeethfehffelgedukefgkeffuddu
    iedufeelgefhheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepmhhitghhrggvlhesmhgttghlihhmohhnrdhorhhg
X-ME-Proxy: <xmx:JQ8sYldqHnBA6Ld4FkUcoayMjzG-dO2aHYsYwva0BJYqf9nWhwRjtA>
    <xmx:JQ8sYmM19cbcGZnlfrV9VwP9Iexi_wHlGRqEkWlei4n9YjGR4i7UMA>
    <xmx:JQ8sYnlJiZY9pSqN3Jfz7RS4vDpf6nfqjTo2LjU1gczQRli_XinPrA>
    <xmx:JQ8sYgUkabxehvVkVBkqs8Ngqy3xEMdFtTsJFBR9t5-k6ZT2Kg868w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Mar 2022 22:10:29 -0500 (EST)
Date:   Fri, 11 Mar 2022 22:10:28 -0500
From:   Michael McClimon <michael@mcclimon.org>
To:     John Cai <johncai86@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug with rebase and commit hashes
Message-ID: <YiwPJD39+/hnu36j@newk>
References: <YiokTm3GxIZQQUow@newk>
 <C92B297B-0634-40CC-B1C6-B2A7325BF7DA@gmail.com>
 <036EAEE4-D957-41F2-8B17-3AD7B2E49611@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <036EAEE4-D957-41F2-8B17-3AD7B2E49611@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks both! I had a look at this on the couch this evening, and with the
caveat that I am not at all a C programmer, I think have a patch that fixes
it:

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b29ad2b6..82fb5e2c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -829,6 +829,8 @@ static int checkout_up_to_date(struct rebase_options *options)
        ropts.oid = &options->orig_head;
        ropts.branch = options->head_name;
        ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+       if (!ropts.branch)
+               ropts.flags |= RESET_HEAD_DETACH;
        ropts.head_msg = buf.buf;
        if (reset_head(the_repository, &ropts) < 0)
                ret = error(_("could not switch to %s"), options->switch_to);


I haven't yet run the entire test suite, but I did run all the t*-rebase*
tests, which passed, including Junio's up-thread here. If this seems not
totally off-base, then I'll actually read the "my first contribution" docs and
send in a proper patch and whatnot.

-- 
Michael McClimon
michael@mcclimon.org
