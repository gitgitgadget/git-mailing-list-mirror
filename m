Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FF92DA75B
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 09:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392041; cv=none; b=n+lGOgVpIL0xaVkoFPPssFXwaZp3wsc8Etr+t2T9ngp2UgXEwNsPDRKs02zdRIsE6i1LnasDAsDkwktTfYUwi4JK0p1SG+LRVV0ZWTqi+K7FP+n/iXsXdWbAoUOdGr/ryLeJBWVOAe7gpAVfEUksGWMyWS26cVQdEwaSxddWPKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392041; c=relaxed/simple;
	bh=SBE/dGfV664CkMucMy9gZ5OtDR5Ezea78L8zXMHBS+w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i0xkLJp48O+ZXizVTuCRKghMBmHSxg0rNjTjJSwssuF2JL4crk/YkGZ5qO0VOSZSBNAxxAYTNKbcBbRV6fctjZ+7guJmMqoyzZdQH3ZF4kSp/v17WtMJAJJ0JixaIJLvU9NqJgIKN9TqEbm9N1Obdab5Ug0djMv6xsEC+ezI1fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mi36I06y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XUAj6Kvp; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mi36I06y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XUAj6Kvp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C2B75EC06FE;
	Tue,  2 Jun 2026 05:20:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 05:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780392039; x=1780478439; bh=3bMeDKNr1a
	6msIXInQFMrvXxkGyNdmouFokgQ78+TZE=; b=Mi36I06y+88iYm/BwLp2mr7D02
	W3oGsAT5nyWMnGFNox3G3ZhOG3sd5f84XSgS1gtXqGm9T5tFDFsBkZMKhbYMG70T
	Mqzf6QK9NeIOSvrQedd1cvsZ8obT20+ZZo+14wYoegbV/D874E0CFhtCbqdHDsTz
	F25WExB+rye9IydRRSyvOgl81L0t9Gmbbur/AHYfisbOQktIW81mJtVFAL8wyJV4
	3GvV4sSLV5fzuaE7z5GpXE4ZA93gzQueF7o+00JtxmlrNTSH9seoXWyKgqJqe2CN
	QRkgPKPIz/pBKULVScTwZgSwIrqnJ5e9Zhmg2mnrCnibWymMlvOQiXBknPmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780392039; x=1780478439; bh=3bMeDKNr1a6msIXInQFMrvXxkGyNdmouFok
	gQ78+TZE=; b=XUAj6KvpC4xdRLsQ9scyzLNoqYzu0AXfBhlr7bILy4sEXerVCE4
	gQzQOTkCiPhSLPSbxrwGw7F4zzPg4Kg6UUt0FNrTFU7vgCGDOyw2hR3IpIfJf/Uc
	8+1zMix16JFnOTYEwk3r+K/PqC8gJ5fx0b88wWdTUgycKWJEEItFisVm05Ttm4Qr
	A1Gj9prvV3lI5xxVIkHaBJz4fkTQTJx7SWXWkuTXJIGYHmppa0uTHY5BREnixA1z
	3whSNLfmh2n05Ul2GU/nl8Qj7CY3AHEGYCGraU7okW1UPMsYASl5g7fz1w5rAXK6
	p8SDCdBNWRmRY1omYbKNC8r9JCDXcnmSZgQ==
X-ME-Sender: <xms:Z6AeahrFRShbVnLsJ-FLyVg8yLCU4x4N9VIgliJZl75VnW_69PckmQ>
    <xme:Z6AeaqoI8XevmXbT5S5Is3H1v0uqK_B3zJhK3QOTB43aetXGNZnQRTR-xMRMOFq7k
    Vic313KSp_Lf4-EcB-2Hv878ppt_SlnNhq3S5wiXXxGuE_m1xZy1A>
X-ME-Received: <xmr:Z6AeajN6C3a-qyQMuBPQf9Gzh_P-19jT15ZyZfPEbFmRW7q5PFd4gLbWjOzggTL0uR10463ZBDCVNhymjFcZ2qgEtFa_cnxaTLvY>
X-ME-Proxy-Cause: dmFkZTEZBULk3NFAbhQL8kJVkzdnXdfuZ1EW9gxHxdvcEwHGM65XfWPWdUW2sKYCWNery4
    4yiqaGKgmLEqnY/ojzPjy7vwWC19mPeHevBPgnXutO/FAIGBQYsiOCzoCDThxfe2RgC4HV
    BRlfIjVj7fT0WaxBoMm86DjFwUCS+3M9S3er5RQor1icKkd6loOgf+6G28HBb5myGT/0FD
    I8O0tjJLPLBj5YVKR8u7gwx1B4BSf8edsgTlhxjy83q5Av6WYfDral7X9Q2QAaPswU1aq8
    HL36+Dpr8sMx7R55sezX5XyWjDi6ziIez5SF5Yg7SmdIjjMpZnsYayf5a6CXeViYZrG7j6
    jgTNc9gMYveqvyEkxs7RdJmA8J7/9n9lG4apTq0reONV/9AKh9RWhuP3sMxogz0yq7XXiI
    NVXbLRx4c5WW/OVhjQrmVctdSj1GVtMHv2eciYehpodmrbcSgWWrRfXZ5pQHvkzQT3Z4mM
    mpb27RcMS7d8EaFPTj2iBeiNB6tvlYQ582rNhfpG18rGEJFuJi7pxBux2ECgm8aL0Am9Xx
    GECmC3NbfK+GHwZrq83xpEGZqI+REboL4cWFd+v95/rw9Qm1Z1OE5V6yZIINDK0tulKxfN
    BXxegHBGn6SGyJh9cGPnwxbqGpPiZLBIYGMBVRfpvlgGWGFhxL3vj0LM3q6A
X-ME-Proxy: <xmx:Z6Aearzn0EwSJULxLI37Uc3bBMQfoLRtgrxjVxKLfIemlK1eLQSEMw>
    <xmx:Z6AeasvItrtqnJuqNxxYOm090d7qFPfD21n6sI9iairdWZwTXGAZJw>
    <xmx:Z6Aeak4u9Jj8DJIWuiFmFdIVLjPY-96fylNfnlcxYbt0pzXMI830Ww>
    <xmx:Z6AearTeZF0vErXAuYSIeftEJU6wZipb7fOL_h3neTBVJHFEyCGLZg>
    <xmx:Z6AeahzUVl43-D9EMAlFpVmOrlMfwNpXtLwc_HuUNDdQr_0TuqEPlvTZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 05:20:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Luna Schwalbe <dev@luna.gl>,  git@vger.kernel.org
Subject: Re: [PATCH v2] doc: document and test `@` prefix for raw timestamps
In-Reply-To: <ah6X0X9EQdL6hn53@pks.im> (Patrick Steinhardt's message of "Tue,
	2 Jun 2026 10:44:01 +0200")
References: <20260602081924.673763-2-dev@luna.gl> <ah6X0X9EQdL6hn53@pks.im>
Date: Tue, 02 Jun 2026 18:20:38 +0900
Message-ID: <xmqqik81xpqx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> You can use a tool like b4, which can nowadays be configured exactly
> like this with `git config set b4.send-same-thread shallow`. b4 overall
> makes all of the mailing list wrangling a ton easier. Makes me wonder
> whether we should maybe highlight this tool more in our docs.

It would be a very much welcome change.

And "b4" also helps the receiving end, not just the sender.  With
"b4" finding the latest round automatically, getting updated round
once a topic is in my tree is a breeze, thanks to the amlog notes.
Essentially, I detach the HEAD at the previous base commit (often a
bit older 'master', but a few prerequisite topis merged into it),
give "b4 am -o-" a message-id of one of the patches I have queued to
download the latest and pipe that to "git am -s". That way, both
"git range-diff @{-1}..." and "git diff @{-1}" become very effective
ways to see what changes were made to the topic.
