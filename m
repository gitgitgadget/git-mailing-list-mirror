Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBDEC25B0D
	for <git@archiver.kernel.org>; Sat,  6 Aug 2022 21:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbiHFVXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 17:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiHFVXc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 17:23:32 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671EFF5A4
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 14:23:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E6B2032004AE;
        Sat,  6 Aug 2022 17:23:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 06 Aug 2022 17:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659821005; x=1659907405; bh=k2KRVBqzzb
        xW7BDjMBbN1X57uiFsyJS4husg5lmqNuQ=; b=MZpM0+9q96s/9EALrUch/uPJxY
        s+GGvucXVWmYa8K8Tsi/jbJAaugbu6YWD91CCR2zyJzC/r4e8UKLycpbP32P1R5s
        cIpcevXgSC6UdiYwg/G9jfJR/2ggJkF4ks7SGDZBJ778vkYPOuQtoNsPwtRl70E3
        kTMgT1Wrl6ftVFX+7tSPIHJXDpmF4qRqxJs4zBrjE1wkldpbmbEnpZk7EGG7Ax4I
        nogEwfX3anj6QojELmQh/JqYZ/hM1OgNCuQ2OpPfPmJWVtINaK6LO8brhlnn3yVS
        PFFmJtMcQL/pp5qvvvF+1hQ/xYcNfB7fIj2LKooPgJil08hs308p0x5ciBqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1659821005; x=1659907405; bh=k2KRVBqzzbxW7BDjMBbN1X57uiFs
        yJS4husg5lmqNuQ=; b=wQHjYiRi6jZ04qv53HNVfIkI6M1GhN3b0RqOmrtV0jhk
        hQWUeraY9N18Kn6ZvpYPFeDhzQGbHwbfcCZpl1w9nipiWJCCCYUW3T8PQjBRg/LQ
        2uF3emCQwf2ji8C1a5K948p90q0V1HFdoCqJTWZca1RLKSsuIqpsQEdvB+XGCk0l
        0d+Yvfgwvn1RQSepDsgXvT476dCeSJW2jRkM9QPx/9/6FY3CbOZMQXr8Uh/N0sty
        LfoKo2EoLUpYFR8xESJmWZ4b+ZHV8AtlN4yDA1XrkSqR/FB31QmdlG4xON9ZHpZa
        YT9IdAbPWY58fhJOftRxiQVIMjTJubZpVVGvkxW+dg==
X-ME-Sender: <xms:zdvuYuYGmsfJqsV7PbY4fUON0LFrlYZNQIfe95sr0VJQzRstvFuYFQ>
    <xme:zdvuYhawxXY7exvXZh9AVcLloxKCejumBPPyYlhLEx-Ylm0dco7W81Sg3mJ7EKxus
    yKszc-iJ8dXnIwhIA>
X-ME-Received: <xmr:zdvuYo8VCI5D60_KniyAXye9B73hR3PJfMXCNR3RYUgrbJiVObtGYqJP33O1Y0GD64gkEMD75o0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeffedgudeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefhvghr
    nhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrg
    htthgvrhhnpeffheevteefjeevieekheeujeeivefguedvieefleeuiefgtddtleelheev
    ledvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:zdvuYgoUh-OPoO8ofp_EC7bQf6SY0JT8R4t98JcDUBSdIbt5MFSKjA>
    <xmx:zdvuYppIAJ7QMsU4M5y8pyeVfvaPHfxcva6wTGpL8f5DFMXCFA49OQ>
    <xmx:zdvuYuThN4IqWuIOP7fPPLUNoGwGxVGLDl4rVIICSEJPSvch9yyc6A>
    <xmx:zdvuYoS1ZmuSY8MIOtUusfBvFnylysYxF8Wq3mq2wSNJ-uyf3MMDyA>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Aug 2022 17:23:23 -0400 (EDT)
Date:   Sat, 6 Aug 2022 23:23:21 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] mergetools: vimdiff3: fix regression
Message-ID: <Yu7byRmn4VtSpyWd@zacax395.localdomain>
References: <20220802214134.681300-1-felipe.contreras@gmail.com>
 <Yu6V4cIajhoMhB3t@zacax395.localdomain>
 <CAMP44s1uPFGYVJ7dzf1pFXENnUjTTwxHye2iT_HPNiMcmPjD9A@mail.gmail.com>
 <Yu6zEiknXKFMJUVn@zacax395.localdomain>
 <CAMP44s3-RG5k4ZkhAFG_9JtbxcyDhkUmeBh0jCH9+Xwyumyu9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s3-RG5k4ZkhAFG_9JtbxcyDhkUmeBh0jCH9+Xwyumyu9w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/08/06 02:17PM, Felipe Contreras wrote:
> 
> I don't know why anyone would want to do that, but the code interprets
> that as the user wanting '1b', which is completely ignored.
> 
> If we are not going to care about these cases, we can just remove all this code:
> 
> ...
> 

Ah! I see now. You are completely right: it wouldn't make sense for anyone to
specify "layout=LOCAL" (or REMOTE or BASE), but if he did *it wouldn't work*
(only works with "layout=MERGED").

That should be fixed. I'll update the patch with a new version to generate this
command string:

     echo | silent 4b | set hidden | let tmp=bufnr('%') | silent bufdo diffthis | exe 'buffer '.tmp
                                     ^^^^^^^^^^^^^^^^^^                           ^^^^^^^^^^^^^^^^^
                                     NEW                                          NEW

Notes:

  - This is "easier" than moving "silent 4b" to the end, due to the way the
    code is structured.

  - I agree that this is absurdly complex for what we want to achieve with
    "vimdiff3" but let's put it this way: now everything can be achieved with
    the "layout" configuration option, even "useless" things such as setting it
    to "LOCAL".


> I understand the need if you want a complex layout, like
> "MERGED+LOCAL,BASE,REMOTE", that's very nice, but if you just want
> "MERGED", most of the code does nothing, 

With the fix above that shouldn't be a problem anymore: even if someone
specifies "LOCAL" it will work, in an absurd way, but it will work :)


> the extra -c "tabfirst" isn't needed either.

Good catch. I'm also removing it.


