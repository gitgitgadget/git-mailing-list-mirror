Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B3AC43462
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 22:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1156143F
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 22:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhD1WXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 18:23:10 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45801 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232200AbhD1WXH (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Apr 2021 18:23:07 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E91DC5C00E4
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 18:22:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 28 Apr 2021 18:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=date:from:to:subject:message-id
        :mime-version:content-type; s=fm3; bh=Z14ohGZgxx3XcCVvj862f58n5D
        KijR+jbRk5HN/bn3I=; b=UhVgmhFM95BJaK2nBbnLejnzadgjMHaCKwjRxEIY8D
        5spyvugQyDJgjAlfm+S4XoBZ+kRip7kMguL5e1Mld2BJp0FymmSpgJL7FJpNKhIt
        uFvNRkKMowqIun3YjBifXHWRyCsKpTa9yavxdcZoUOgRFB0JnsERXiNyWB3UjXTo
        LQ0p9UVZt3NCr9mMN2+h8+rJHpmTZZGFHBtAiveVAtnbcB8bIel2T14tVw6DIIkL
        00HbF1rfO+lAbPSmahUonzEXi5XICy0ZUjD4gOkIPFc0ZD02ANMbvqXldNEoOI/L
        /JY9M7n4NvU4UHc9OIdnKdgsI1RRSwdM0DMTk3V7sDMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=Z14ohGZgxx3XcCVvj862f58n5DKij
        R+jbRk5HN/bn3I=; b=HbiQj9+VUrWNaNQzTbuTi4rnxOeN6gVirNf8eED20SZI5
        lgLx59qHGZlbMLpa0FckirHdIJf+QO5pZq1Fd4AUgsgeTCjRj915sNKcHcXgPgsU
        Wy0lgRYRksgYZqQdWEZMqxIE0laWSpnwOasDn6LyOnOPdqzQe8PES0rZHPVKzQwQ
        Wfc/zcO7/1oeGOh5Meo4I4P8VlxOvTljbKpT/jCtJq80mA08+jiSKGqv2Yybrc6L
        yBX8qGqumuV6iPpn4p2v70cBPhKbW+wUe2fnK6jgIgsk4Np1spkD0gOWsMDjR4qa
        S6rFVNYTuLtzq1yy76WSSxyMUR8SQgaExIcEhbnsw==
X-ME-Sender: <xms:HeCJYJpMRF64xFnu5yGv12Up-G8sQz9PCoogV0XEKYHM3OfXe2TtpQ>
    <xme:HeCJYLoV1fHoxrDj9gzGCBdqhKMiwm4wLsNwEXbLIUe0qtp4NXgzA1tXhWqCJDjD3
    6kWfwSY5k_6KWf9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvfedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtuggfsehttdertd
    dtreejnecuhfhrohhmpegufihhsehlihhnuhigphhrohhgrhgrmhhmvghrrdhorhhgnecu
    ggftrfgrthhtvghrnhepueffleehfeetieeghfffhfekveekudeggeegffevteduhefgke
    eikeduhfetudeknecukfhppedujeegrdehvddrudehrdefjeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegufihhsehlihhnuhigphhrohhgrh
    grmhhmvghrrdhorhhg
X-ME-Proxy: <xmx:HeCJYGO0F7R65qytLcjUXLKaIkdR_V6hTGCR3MXzzmJ-HUX_ZLq2Dg>
    <xmx:HeCJYE4sUGTweL1p9FGNFFapexmPFlQXDIQJpodhLn20cfEgItnakA>
    <xmx:HeCJYI61HHb76EpCD0b2xSbc9qv2V6Mb_W_-PSxuZ_kQPXMmM2KazA>
    <xmx:HeCJYPKNWFTe-maZ_1x0m9ZwLBnd4eBU_uWla_tvPqvbVBpEqCcRlg>
Received: from localhost (c-174-52-15-37.hsd1.ut.comcast.net [174.52.15.37])
        by mail.messagingengine.com (Postfix) with ESMTPA
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 18:22:21 -0400 (EDT)
Date:   Wed, 28 Apr 2021 15:22:19 -0700
From:   dwh@linuxprogrammer.org
To:     git@vger.kernel.org
Subject: pkt-line and LF terminated lines of data
Message-ID: <20210428222219.GA982@localhost>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was just reading the Documentation/technical/protocol-common.txt
description of the pkt-line format. One detail that is left out is how a
receiver of pkt-line encoded data determines if a line is binary data or
contains non-binary data.

The documentation says:

> A non-binary line SHOULD BE terminated by an LF, which if present MUST
> be included in the total length. Receivers MUST treat pkt-lines with
> non-binary data the same whether or not they contain the trailing LF
> (stripping the LF if present, and not complaining when it is missing).

It seems like a pkt-line with binary data could easily end with 0x0a
(LF) and a receiver would strip it off even though that is a legitimate
byte in the binary stream. I don't think receivers should be trying to
determine if the pkt-line is binary or non-binary and never strip off
any 0x0a bytes at the end of a pkt-line.

The client code that relies on the pkt-line receiver is where the logic
should reside that figures out what to do with strings that end with LF.
The pkt-line receiver just parses the pkg-line length, reads the correct
number of bytes and passes them along for further processing.

What am I missing? What should be added to this documentation that gives
more detail on when/why/how a pkt-line would be determined to be
non-binary and the LF stripping would occur?

Cheers!
Dave
