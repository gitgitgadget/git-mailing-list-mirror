Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E201CDB47E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 08:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbjJLIrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 04:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjJLIrp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 04:47:45 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F64690
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 01:47:43 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BCAEF5C047B;
        Thu, 12 Oct 2023 04:47:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 12 Oct 2023 04:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1697100459; x=1697186859; bh=UjvlY8yU73sMFwiYSFEDF68FtdIMM/4Do6a
        csfZG9ZQ=; b=CgXXekCgB0tw4N/xkYLBQEMIXsJ4mqcebRthpBika987s4GuomA
        IyZD4V+eEnz5EU++8nbwVrftpz1YJo8FAw4Xif8aZPBQJdl1At/W1rcTIHSXfuYJ
        /wHtibH0UJvMFPS4LPYh3O3r/nEq2m8NEPtXYcKCJQp5MxE/AkW9ZkcEL39xmHAC
        /rXwn4YA3azcKLEK6vOdhIiSDAd1hmNi4qGGooKjYYLaPQnJwvnNGOtT+GuZ2eNo
        XsFb0wlCDT1F4SVxJzvob2SsacB6P5c4CUoptKjINRed8brkhdc1ViPXXi9ByCJj
        23nikvafN2PFSEG4Tj6dxvnmjBpjmXIOy2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1697100459; x=1697186859; bh=UjvlY8yU73sMF
        wiYSFEDF68FtdIMM/4Do6acsfZG9ZQ=; b=OtkbNWKU6iMBUbPi9eTbz4hZGCI98
        mHifxgSpvGrU2RAW5TICWtbG8JbU4It9xlkRaTpPku4B2UaigMzMfImZJ/wpLoHc
        oeNaqYg6YbK/82gQtpz5bZKXA0T/WDVSRgY3YLTv8SKq/ThpB+xroijrTvPyPRar
        sp2yFuqJ45/fuqVK2Aqpb8rhMl0ibTl8VcXVPP6TOE6O0hfoHlqkZUG89RxBOwto
        7dw1ps4GTsKZMXUcP4cNWaFw2sXS44NVG8IIpx8OYTCqwpfsLzibBqcgl60JUPpL
        6sGDK9rOabI/c+93KbC58PfdrWs7PTb98dm0Y/CcfZmmEnKVWrjy2w6Qg==
X-ME-Sender: <xms:q7InZT4DE5xLau_Jj9jfbbR9KfQVtXk9NCto_4XeLKNXvl-NaCzNPQ>
    <xme:q7InZY4xIJJnwgR-FA6HFfoyKyycMsCsKrpMPkHdFYUfx_k5oDqm1gMZa2QjyKhS3
    djVybt0OV4G8tHnPFQ>
X-ME-Received: <xmr:q7InZacFg-4dgtiTl_ZgMgYbDaCPooTYBcshSbd7OeybvjFlXyiNZ7X2DYMjlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedriedtgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflohhshhcu
    vfhrihhplhgvthhtuceojhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudeigeehieejuedvtedufeevtdejfeegueefgffhkefgleefteet
    ledvtdfftefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgh
X-ME-Proxy: <xmx:q7InZULetJGX417lxFqJFOECXO7MqshhNmmq_FxaFAiXsX5gp_2ceg>
    <xmx:q7InZXKyzeZSpE2jCMAmKGrZx5A5wqxHVZCcLeFvEvfKxFofW3Y1jA>
    <xmx:q7InZdwC5vElG40SSlsVUWpWegr7sDpEJLWJpDxZWOGlDXF_TKuW6Q>
    <xmx:q7InZeXbndcgwqapk_VGE7aVkjGUkpNkjns9c3lofX4nO5Kc_7cNDQ>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Oct 2023 04:47:36 -0400 (EDT)
Date:   Thu, 12 Oct 2023 16:47:25 +0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Sebastian Thiel <sebastian.thiel@icloud.com>,
        git@vger.kernel.org
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
Message-ID: <ZSeynS5Vz_IQomp4@localhost>
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
 <98387b86-1732-42bc-9ac5-d64a6617b2db@app.fastmail.com>
 <ZSVbUSRUQlNy0bj-@localhost>
 <xmqqo7h6tnib.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo7h6tnib.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2023 at 10:07:08AM -0700, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > While I'd love for it to default to that and require an extra option to
> > clean away precious files, I'd expect that that would break people's
> > workflows and finger memory. If someone expects `git clean -x -d -f` to
> > clean away everything, including `.config`, and then it leaves some
> > files in place, that seems likely to cause problems. (Leaving aside that
> > it might break scripted workflows.)
> 
> I thought the point of introducing the new "precious" class of
> paths, in addition to the current "tracked", "ignored, untracked,
> and expendable", "not ignored and untracked", is so that people can
> do "git clean -x -d -f" and expect the ".config" that is marked as
> "precious" to stay.  Before their Git learned the precious class, if
> they marked ".config" as "ignored, untracked, and expendable", then
> such an invocation of "clean" would have removed it, but if they add
> it to the new "precious" class, their expectation ought to be that
> precious ones are not removed, no?  Otherwise I am not quite sure
> what the point of adding such a new protection is.

I'd expect a lot of projects to move things *from* the current "ignored"
state to "precious", once "precious" exists. Linux `.config`, for
instance.

That said, I do agree that the ideal behavior is for clean to preserve
precious files by default, and require an extra option to remove
precious files. If you think that doesn't have backwards-compatibility
considerations, then it certainly seems much easier to jump directly to
that behavior.

- Josh Triplett
