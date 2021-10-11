Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAFBC433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 08:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E1F660EBB
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 08:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbhJKIcB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 04:32:01 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60499 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234910AbhJKIcA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Oct 2021 04:32:00 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 66E415C0117;
        Mon, 11 Oct 2021 04:30:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 11 Oct 2021 04:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=mHlZMl/kuWUYmAqly+o64djEwXD91C4OwZzgGBI7b
        H4=; b=M8739TyF+83nF4gqKmLpBKzwXsqCR4rqdzZJfllMuCNdPsriqmTGE4gr3
        AMgrIU9aTB0hd0VzM/2jDYd/26qlRKddiGOhRoaFhL/ORYeWjXtJ0Z1zAfP1N8Yn
        +oQSFrSQAUNJYI8eg1cNNc+Pe5uunf8HTP+gW7dRAuymcdGAGTxR/RHGKi3vjwwn
        LBvzkQD5u0Ol4L3pDcTdl5g8xo9xwf+TbZwNixTD6DabEm6cFzgmA4Qt2lVs9hKX
        NtNKvUO/ajB/VPgVwZD5ppujkarZgUhVcmhNKguINqJcFW/EjEd4DZGMXiFyy+r+
        T1hM2u5ZC3iq/mxgXuYg8kYJGl4cA==
X-ME-Sender: <xms:CPZjYeUU51aXfTzVMYWvrsLw94NwI59C7FDvjf7HhVa4Z0PB3UMvbQ>
    <xme:CPZjYam_O76t8c4c5rlA9CDeNKPLQkQh42PLMpUiTuDov2JvX5zMkfygMLBUu-VEB
    q-8D3-904tyz3qNC64>
X-ME-Received: <xmr:CPZjYSbJzuLyH7W_tzHenDFx7c1-VUmhNR7xS12OmpO3PjH5rBCB8VYgX20lOVoebFK9ec9g8q46aSKZRYrgjrZlXR9RRVkE0SesslcoBNYmO0-Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtiecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgjfhgtfggggfesthejredttd
    erjeenucfhrhhomhepuegvnhhjrghmihhnucfmihhrtghhvghruceosghkihhrtghhvghr
    sedtgigruggurdguvgeqnecuggftrfgrthhtvghrnhepleefvdffuefgkeffleeujeethf
    fgkeffieffjeffheelveekheekkeffgfduhfejnecuffhomhgrihhnpehgihhthhhusgdr
    tghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gskhhirhgthhgvrhestdigrgguugdruggv
X-ME-Proxy: <xmx:CPZjYVU1rwK_FmTPbrnQfUFdL8ymJ6HJ--R_v5f1ZWIGv_MtbFBDuQ>
    <xmx:CPZjYYnXI6sRF1ahjk_57RjIb24mnxuBxZhmOQrT6KzSD6BIyDsq_w>
    <xmx:CPZjYad3GhOoKC5jCIV1x4hFQxNOJlCG_8lsLWDP6XSlTffAEhWFRA>
    <xmx:CPZjYfukYYA4-hvHHeL1KHN-JicfxA6H754NyTeiwiY6thjqxWhkAg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Oct 2021 04:29:59 -0400 (EDT)
Message-ID: <39ac5fe17bdf0f486cb8ffd4b8dec6d60acc9244.camel@0xadd.de>
Subject: Re: git log with %(describe) placeholder does not find most recent
 tag
From:   Benjamin Kircher <bkircher@0xadd.de>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Date:   Mon, 11 Oct 2021 10:29:56 +0200
In-Reply-To: <732e64ad-0ca0-d384-a09b-55c74479e254@gmail.com>
References: <61d28b8e9dd906eba821ecc9ee81bd4ac2374494.camel@0xadd.de>
         <732e64ad-0ca0-d384-a09b-55c74479e254@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2021-10-11 at 15:23 +0700, Bagas Sanjaya wrote:
> Both results (git log and git describe) are same.

Yes. Good one. Absolutely correct. I wasn't able to reproduce that with
Linux repository, too.

Problem is observed only in some repositories while others seem fine.

I was able to reproduce it with a freshly cloned version of:

  https://github.com/gridscale/gscloud.git

BK


