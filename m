Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB38BE4C
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 01:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710292171; cv=none; b=AHparWpwcGg58Xso0B6FGnKUNr8I0pU2s9DtjPmSAKElwKk6WTcFyOc+Pk1ODu8mS6408uBxrb7+LJnmqCSRfPGxB+3e6FQLR/7JnsNGPJfE8DihFG1oBlaKRIw2W5Lm+mseO58sTLrDlS7J1GqAvQ722dcJTMw0kQdjl0kfM2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710292171; c=relaxed/simple;
	bh=Fo6TvnMcZJuqluOxviGgDB4XHOvEJpf7qnODsJusS7k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=OsN6z9E3igwoUEWS84GvcAaSa3sCU8SCEI8aAg2epHqUqiVAKVGvwhp9PxrLNd/4EHZqKExKvYWIJcaeAsW//0c0Gtl10VJRuL5W0mP8dTH38AwuksnP7o2gOOCUJeyxtecwtNY730NpN1oB6KWzxdtfF3IseTTxWpqZvkh3BAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=wLb1XgG9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qHGbkwTq; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="wLb1XgG9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qHGbkwTq"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2623911400F9;
	Tue, 12 Mar 2024 21:09:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 12 Mar 2024 21:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1710292168;
	 x=1710378568; bh=Fo6TvnMcZJuqluOxviGgDB4XHOvEJpf7qnODsJusS7k=; b=
	wLb1XgG9ME+ROHNTS9r72Rehd3n1WCyB9FmOTGiIi3xfuXKzHzdtuekfefxt2rAC
	Kt7elaGXb2BieHkazAmCN2AnUdc9nth0yRSQBug3Wnpx5fujJbmDDzEZb1ox9H2A
	s+oFlMa/yjhjtWavMKKDlIU4Tli0EaugWiR+dgvizGTBCdo9YIFCKxPd/+a96ita
	Oie0ZfZlB7iNaUWAEzh3xYTVbc8k4tkzGH/frI8nkgnDG9i5Ac8tdX5e2gwqsBZJ
	Q7R/ETmuWE7K8pQxp4r4oK5S5zRsWtg5o+K2ky1TUCd5hcXEJVyl1+Qub0KHNgXD
	srBWDC3Od8WWivAmim0TzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710292168; x=
	1710378568; bh=Fo6TvnMcZJuqluOxviGgDB4XHOvEJpf7qnODsJusS7k=; b=q
	HGbkwTqKH/Y2oOGHWaW6YinjSoEFw7tzceb+x3gX/1ayTbE9/Gw52qSSrooN1KmK
	1awASI3uQ8VUBW/Zv55W5WdJIRsax/fzBkiBm6twRkAElSmZOQd50jM9Z7fWQNoj
	72sbUCT3A5WRcfJ9HrQ4I9qjk6FRel/P5pKVDwHCIUnbTc2B3CKFrnaNAC4MSBvt
	qmTh3NHmu+zLiIvEtGwjY3MhFffHKpxumtNtokqsLvoWT7aLyc4adEAILwff19Rc
	n0fWX31usAAwUkq8XowFCHR0UM0PB+0JaG8a0+q4I6m5x/djA0gtlItkD0ACg8gi
	vpVuwyPYtdrdIwOiiFhRA==
X-ME-Sender: <xms:x_zwZXuthP4WNbm5kj5TPWqThYsHYnxRmAg-4uHggAT6hS3bXl1BLg>
    <xme:x_zwZYd7tHFU4M13QjnfRdb8I9vOsMaD1Kjx0M_Y0BsvkNTx4ELaU417HOW569qg3
    lM36YYCLPtNY_Hgqw>
X-ME-Received: <xmr:x_zwZaw6qHpjZgcNxj0_IxwLHgiC60NoeBnIEF11oI7B-kvymN3BHIQlD11FqOBmQlh1EYhTEo8gQeY-guT2F3WhgbS_lGlv4si8eBEd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeeggdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpegggfgtfffkuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedflfgrmhgv
    shcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurdhioheqnecuggftrfgrthhtvg
    hrnhephfetueehudeltedtjeekudelueeihfevheeugfehhedvieektedtvdevgeeileet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmh
    gvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:x_zwZWPvyuHEKDEkoKbJp2rLkr2LOwrWx8PPOCncnQS1AEMRadC7pQ>
    <xmx:x_zwZX-jAjwr1NC9eDf0qp5g5e36tcpyUXypBQFzfuqkazim_RMYYw>
    <xmx:x_zwZWVT_kcd0S1NjKUdl6-J9YJjzk8tSl0VXZG-69_7CVwPLMxxPw>
    <xmx:x_zwZYfR7w9AQGLbnwA6tZeammXM-R7oSGZT4iWwhaqlCguAtUph-w>
    <xmx:yPzwZabg1evOdSoqLunUUs_MN2gVVknwRf9-xcCJNiGfgJg2gXLpoQ>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Mar 2024 21:09:26 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Mar 2024 12:09:23 +1100
Message-Id: <CZS7Z199NZUG.2EM4STQ664P9W@jamesliu.io>
Subject: Re: [PATCH 3/7] reftable/record: avoid copying author info
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <cover.1709640322.git.ps@pks.im>
 <6f568e4ccb67a7af8279352153d052c5f9a88234.1709640322.git.ps@pks.im>
In-Reply-To: <6f568e4ccb67a7af8279352153d052c5f9a88234.1709640322.git.ps@pks.im>

On Tue Mar 5, 2024 at 11:11 PM AEDT, Patrick Steinhardt wrote:
> Each reflog entry contains information regarding the authorship of who
> has made the change. This authorship information is not the same as that
> of any of the commits that the reflog entry references, but instead
> corresponds to the local user that has executed the command. Thus, it is
> almost always the case that all reflog entries have the same author.

What are your thoughts on simplifying this explanation a little bit? I
gave it a try below:

Each reflog entry contains authorship information indicating who has made
the change. The author here corresponds to the local user who has executed
the command rather than the author of the referenced commits. Thus, it is
almost always the case that all reflog entries have the same author.


Cheers,
James
