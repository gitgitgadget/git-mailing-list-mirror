Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6E23E022F
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914144; cv=none; b=RHLtsqIVBDCoENCKbHMiMc8xbdKwIFMeQkvHIFmnyq06oySq1tkig26hsCYH5DGEmetrdQAr+8sY7K7YsSJmXRkxLVB8SIvnpJsYsd+twFJBJGn6t8AGXnHtwmzR190aM8b9nzeNjjIBwye38B4tNl4DN0JrcWCiiducdJgM4aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914144; c=relaxed/simple;
	bh=899arcLcPC4XTICs0cWH7WoRE1YhDizKynO9Saq9h7I=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=mZfVZBiyvlUZRVfaxz5bAJ2xLD1O6Ex3rwnp2nOp7ufCtPTTdGQbvzb/nMwOxlnbAqJOLeXgm57ZdsRZY60vVotLN7ecMe5C62EYuAllAEumraUtQYdqG0iJVgnyTOOlD83GTOof+KYcpj5M1T0uBRZP9VUULCDkButgIwVOmbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl; spf=pass smtp.mailfrom=whynothugo.nl; dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b=P4NVMGRO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SxPRDn87; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whynothugo.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b="P4NVMGRO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SxPRDn87"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id ABE14EC0325
	for <git@vger.kernel.org>; Mon,  4 May 2026 13:02:21 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Mon, 04 May 2026 13:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whynothugo.nl;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1777914141; x=1778000541; bh=2X
	UTx52B43DC1mbdlgonlr42eU8lg0QS2lTSCHlFack=; b=P4NVMGROpvL7yLOIJA
	TtpUmxQ2pXNd3hhs8hD4BpeDjEF8dJTCc40cf80haP5suw4Hl9jwpNHDUUisTm14
	N6HqNodlVH2EeJxlgMnm3H4qmfoBeLMBY+b9h6IXRkw2GTO9qkRdZVWDL+QkcPpp
	i7L2RO392IOligTHy92P/bPdob/I33ykgbc4awQ9snURJpwQOheQj+K9HcLSeR04
	ThmEZoF90j2z8W1k3HdPOyZTujfplybpB9gwAmxPT2DcYLOFrMRD/GUebGv5GfId
	cotyqNR5FPCZ6wgJvftikns9vv35xGNQRpQ2dDdaG5dhtiiXBHeIE2cZcaptwzHu
	Y2ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777914141; x=1778000541; bh=2XUTx52B43DC1mbdlgonlr42eU8lg0QS2lT
	SCHlFack=; b=SxPRDn874kO606RLZWwYH23IRgg5saMXe38aYlC/4OJcpV3QFsg
	3BQgZL/uojvD9PMDwcDlz8+nFdlyJV2XeaVvM5rpS3/su8IpI06QO17iUtCPdH08
	o1IYPiRT2Pw8BuMbwz+wBSwmsYS9j6i6vguA4ao4B+HbODvfjdTIewbDWWksnvGy
	uVeJw6aVMAiZeN0fsGFSEQ/a9wvPRkKCHWJWoqAenwH9qHLjBYDVOMM2xZRH1i72
	adpKZ7MjLlo6ufd7zkLQlqdGcQXGlQ3KoZOUpu59hP9DMLwfljpnu3iZVOvfHW+g
	31oe8/ONs5Gv1xiotJJz1GnOh8A/p/thxKw==
X-ME-Sender: <xms:HdH4ad1J6_EdEO4zQ_H4TGj6WpH3xHastvyCk7H0oa_qRyWXCXaHpg>
    <xme:HdH4aZC20zDCKuMXOXlfOrYVKLJSpNBc4tPYEz5xcUXCfvFo9l5fcfMYVIGi6LHon
    Y7Dx0Tp-DMGMNVr5uvxqc6hX0ZKrsFCIV7AbRNsWYDGCIwAlMeivg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelleeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkufgtgfesthejredtredttd
    enucfhrhhomhepfdfjuhhgohcuqfhsvhgrlhguohcuuegrrhhrvghrrgdfuceohhhughho
    seifhhihnhhothhhuhhgohdrnhhlqeenucggtffrrghtthgvrhhnpeelfeejffdvgeegge
    efueettdetleelleetveduleeljedvfeefueeihfelfeefveenucffohhmrghinheprghl
    phhinhgvlhhinhhugidrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehhuhhgohesfihhhihnohhthhhughhordhnlhdpnhgspghrtghp
    thhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:HdH4aQfY9hy9npwk-oIHo0n_x5HwJWtrFQRqhZKywp0z5NJJY7TxdQ>
    <xmx:HdH4aaZVFhZgJqdTGy51fAf3WAY_URHc_SxmOqjBrrn3tLXJq0UzcQ>
    <xmx:HdH4adFd-Or2E_6SanN9fOW93kzbdAqk0rQCBmQKeL1A0WY2lfZTVQ>
    <xmx:HdH4aQk-Lk0iJ0o2Br5mgFTdm1i6cpx6QngE3UAGMs6OXRqq3zHdJw>
    <xmx:HdH4aVuhTGdSfA81RlaAG1HIHEz8iMIVPZG871kIV8vRT4ecBNf1dQha>
Feedback-ID: ib8c04050:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 776AF18C0067; Mon,  4 May 2026 13:02:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 04 May 2026 19:01:50 +0200
From: "Hugo Osvaldo Barrera" <hugo@whynothugo.nl>
To: git@vger.kernel.org
Message-Id: <2d3f5504-f5dd-4171-96e8-b5633b6a1f5e@app.fastmail.com>
Subject: Git trims the last character of content from remotes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,

When I push content to GitLab, the remote server sends back some text which git
then prints to stderr:

  remote:
  remote: To create a merge request for zk, visit:
  remote:   https://gitlab.alpinelinux.org/WhyNotHugo/aports/-/merge_requests/new?merge_request%5Bsource_branch%5D=zk
  remote:

When the width of a whole line is the same as my terminal width, the last digit
gets trimmed off. E.g.: if I resize my terminal for the above to fix exactly,
and re-run the same command, git prints:

  remote:   https://gitlab.alpinelinux.org/WhyNotHugo/aports/-/merge_requests/new?merge_request%5Bsource_branch%5D=z

From what I can tell, sideband.c prints ANSI_SUFFIX = "\033[K", this escape
sequence being "clear the line from the current position until the end of the
line", and this is the root cause of the issue.

When piping to cat or to a file, this sequence is not printed, so the output is
fine.

Is this a bug?

Thanks,

PS: please CC me, as I am not subscribed to the list.

-- 
Hugo
