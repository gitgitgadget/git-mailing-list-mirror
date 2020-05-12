Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976B9C47255
	for <git@archiver.kernel.org>; Tue, 12 May 2020 01:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD85206DD
	for <git@archiver.kernel.org>; Tue, 12 May 2020 01:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sigkill.com header.i=@sigkill.com header.b="Pf5dwdBO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qSLljtXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgELBHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 21:07:55 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:46021 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726106AbgELBHy (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 21:07:54 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E3CEA646
        for <git@vger.kernel.org>; Mon, 11 May 2020 21:07:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 11 May 2020 21:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigkill.com; h=
        date:from:to:subject:message-id:mime-version:content-type; s=
        fm2; bh=nyaJ9eSG5Q8mBt30+fjpI8W94T1vyVOMu8lS/SE2+vs=; b=Pf5dwdBO
        nzAhNiayp5Dy7aer4aJhmVf+e7y1E9Is3XlC+7OkQeW4GDx4J8KrHw0rsOdEqk0R
        9JgV57OjCG8QhYrXkGmwFPwmlIllzymeGeOhYJt/0X0cem3g6BWxOloq1XFdxADx
        2JTuaxXFkePaYOYwzc/qucds3Aw38oCcSpceSNrXTsv9UUq8dokPxSlFXAfgla0I
        bVCnmlcc2EvSSJmCnSA19H8GVsnN1awntKmgtergLTFPBicj+WZAwTS8N9QdZKdF
        HmhhHylobG9+rcjN60f+KCSBQ6pOrwJB3Whxud2xu8iwzZC9YD+5ykTtc3lNhlYl
        Gn3K65QVgUpybA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=nyaJ9eSG5Q8mBt30+fjpI8W94T1vy
        VOMu8lS/SE2+vs=; b=qSLljtXO+mpcE+5y6NihhFqVseqzAR5ez81RJ82g+/E4X
        pOt/pBZ/BnihFqlhNiYbuFD0DzDv516aFTtcvxlSg6rxTcfjKsmCbDqc1D5jQqb7
        E9TBwJuPBnAy3YaiSWQjH45Y5GY0JAGIFKpnS/S29zBFkVFuX5356E4owP3Flutq
        cPQykYmseUN/FgSRK/G/wefGv2SOqpO3kx2RcOFTQslXbGMc9TfqudhxRIShaNiF
        /q/Aj0yz3VYGx38fkLNlQO4Kh8RtQ6Qk0CP4osd7o5z1LtDGBmMzsEnkGCw9C7Lb
        W6B+FjmIPc0r/TFSeu861O+OybG8LDX/5PmtgOpyw==
X-ME-Sender: <xms:6Pa5Xp_Qc1dhamn6JIW1G3zUdvt1VeJEVwK6saf-IxgkYI_cfadEEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrledugdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggufgesthdtredttd
    ervdenucfhrhhomhepfdflrdcurfgruhhlucftvggvugdfuceophhrvggvugesshhighhk
    ihhllhdrtghomheqnecuggftrfgrthhtvghrnhepffetjefftdeiveeihfdvfeevfefhje
    ffleffgfetfefgieefheekudduveetveffnecuffhomhgrihhnpehgihhthhhusgdrtgho
    mhdpjhhprghulhhrvggvugdrtghomhenucfkphepieelrddukedurdefgedrvdefgeenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprhgvvggu
    sehsihhgkhhilhhlrdgtohhm
X-ME-Proxy: <xmx:6Pa5Xq7iAlJpBKFGSoqrgRZuUUjz7J9bQKXh6WincLzImC-HSTv4Xg>
    <xmx:6Pa5XvklTvRkpux7Kpv9sycvj3-ofsj4m4fz4-tVgesvCrZCgHmv0g>
    <xmx:6Pa5XtF-K-XUFUbYWmemoS3FK_UzQ7UC37HZJcnSKYlLuJ1OEBh2Rg>
    <xmx:6fa5XrLEokECK7yB3pMZqKidYUGeLfjV3RQNKnGP6DYI-amcVQmENQ>
Received: from sigkill.com (c-69-181-34-234.hsd1.ca.comcast.net [69.181.34.234])
        by mail.messagingengine.com (Postfix) with ESMTPA id A3EFB3066266
        for <git@vger.kernel.org>; Mon, 11 May 2020 21:07:52 -0400 (EDT)
Date:   Mon, 11 May 2020 18:07:50 -0700
From:   "J. Paul Reed" <preed@sigkill.com>
To:     git@vger.kernel.org
Subject: git-gui patch staging errors
Message-ID: <20200512010750.GA7127@sigkill.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.13.5 (2020-03-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hey all,

I ran into an interesting problem this week where git gui was erroring out
on staging partial patches in a particular file I was working on.

I worked around it with "git add -i," which worked like a champ.

I later realized the source file has some special characters (Unicode,
probably) in it to print emojis (or colors or whatever fun animations the
kids want on their terminals these days).

Interestingly, lines/hunks before the first Unicode character will
partial-stage appropriately, but attempting to stage any hunks/lines after
the characters produces a "Failed to stage selected line. error: patch
failed ... error: ... patch does not apply" error dialog.

This can be reproduced by cloning
https://github.com/debek/aws-glacier-multipart-upload.git and editing
glacierupload.sh; the special characters are in echo statements on lines
60, 74, and 97.

Removing these control characters seems to calm git gui's indigestion on
this file.

[preed@underworld ~]$ git --version
git version 2.26.2
[preed@underworld ~]$ git gui --version
git-gui version 0.21.0.66.ga5728

best,
preed
-- 
J. Paul Reed
https://jpaulreed.com
PGP: 0xDF8708F8

