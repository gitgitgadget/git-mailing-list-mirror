Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904A5C433EF
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 22:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7276260FDA
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 22:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhJSWPH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 18:15:07 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46043 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229533AbhJSWPG (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Oct 2021 18:15:06 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 00D9F5C0105;
        Tue, 19 Oct 2021 18:12:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 19 Oct 2021 18:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Mge9q+EACER4eOk60jlYCJWI/3n
        B+jqCYS7ssMQpzfM=; b=asvadKbwqmWQNT7Af9TiRahL8TLGxe/UluJi5OHHWQH
        gFH5mQqBqzaWfaRyOhymSqIQVsuHf7egymU/J2jCRtFkPhwbOH9cebIm2xM71c6r
        1dSdQ6W/SGXogyCALT7KlUuogW1RpOrJeKs4yc1deFx+cxPlauQeX/PenTzWrIc9
        yhW8rj1DAgc1j8JHih9DpXG3yVwGFbxgnzuJFOXfGQ2bHYKThuHqY3iQY7iyIIVR
        k9wFQgaOfL2LtTthgkvLfoZHBtepVocYXA818z11IDdI3ZIpskd+oRawF/0u6z9A
        qWN1xl+ZA3G+R84yDoVqqXmo6SHewkQgS++jpEgVTSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Mge9q+
        EACER4eOk60jlYCJWI/3nB+jqCYS7ssMQpzfM=; b=WbJ3QpgC6oZgRpCBzvgeeg
        zBOQpWYyX3ubS3V6sqgxhtNLvd4uBeixJiPZkU715DGXKO/8NDt561Q0UuwRW8RL
        LD5I0ihZC/tSPt8QUFp75BmSCR+W3ZsPupb+vRo7PVOhXYhKe9d2Gq1DrhQufJJJ
        3yuun1J3l/hfiyxik4Zx97zp8wqIdux5Xx4atD891y7PDFYslNKuGlyIECdxs+8k
        b/vMvR4XoZFjxDU9XyuzNyJhjyi82iNZjT8k0d/z8ccJGXQNeh3cIiYg54r32vXg
        3OrzSlDtNUdFVFfQdOol2szxfGWINW8ejxh7GuTyR+KK91hAX6KTofRcUWMh9l9Q
        ==
X-ME-Sender: <xms:5EJvYdiqnNu40ImiVPtOCk9MqRLPpASvSu_tpKB_Ijnt-YvMxfb6NQ>
    <xme:5EJvYSDqSFobMGFvw6WSB1GnWdpf7RTXAaH7vrZrktH-_o_z3hxtcIAXjoBTjvPAy
    BqhVE0xPinw4A41oA>
X-ME-Received: <xmr:5EJvYdHHRIAjGL4ZX0rTmr7oG04RLxTBZWj2z_YZ9YUcXn7XC2HROAeqCao3rnu-SsS6_TfB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvfedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtjeenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhfohho
    sehuledvrdgvuheqnecuggftrfgrthhtvghrnhepvdejieeflefhteeihffhtdfhfeekhf
    fhuedttedvgfevgfevfeehfffgkeejfeehnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:5EJvYSRGXiB5MeSr7Uci3dkDdtlgvonmWnfHnbjIUSwcGR01tMQPNQ>
    <xmx:5EJvYaz5m5h-gqdi7vgTJ1xZsf0C0-CEacq-FrYqrr0UpWWytu_ILg>
    <xmx:5EJvYY5yMPD7-QmfMhkV_VtPNRoGLAPZ38rqLTEzmXxPUbM3qjEk3g>
    <xmx:5EJvYe9bk7O5RTfMAEz6PPVzIxnpFsTAiRyOH0SRf8NsyNmSl8rRLw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Oct 2021 18:12:51 -0400 (EDT)
Date:   Wed, 20 Oct 2021 00:12:48 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: Re: [RFC PATCH] mergetools/vimdiff: add vimdiff4 merge tool variant
Message-ID: <YW9C4KvsXSQOCX/w@zacax395.localdomain>
References: <20211019212020.25385-1-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211019212020.25385-1-greenfoo@u92.eu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/10/19 11:20PM, Fernando Ramos wrote:
> This new vimdiff4 variant of the merge-tool opens three tabs...
> 

One reason why this RFC should *not* be merged is that the same functionality
can be achieved right now by simply adding these two lines to
"~/.config/git/config":

  [mergetool "vimdiff4"]
  	cmd = vim -f -d -c \"4wincmd w | wincmd J | tabnew | edit $LOCAL | vertical diffsplit $BASE | tabnew | edit $REMOTE | vertical diffsplit $BASE | 2tabprevious\" \"$LOCAL\" \"$BASE\" \"$REMOTE\" \"$MERGED\"
  	trustExitCode = true

On the other hand, one reason to merge it is that this new windows/tabs
arrangement is so useful when solving complex merges, that it would be nice to
have it available by default for easier discoverablility.

Let me know what you think :)
