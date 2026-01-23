Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B4A33C1B9
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 07:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769152986; cv=none; b=Gw0PdyZPVme6ENXBND7W9xxC8ssgd+5lIW1G7FpDcxucQj1wnRCsKTUvxPqSLmFv4ZVBkJfGzDHXMf8pQ76vs8BCo7SFSGruSLlNu+Xzwm7HT6SA6PSmw0QNh24ne1cVQORgLvklwXSGCdvPXJ6psI2TIPRAFQ8t9ZYz+h3wEPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769152986; c=relaxed/simple;
	bh=LJJ4NZn9I/PejrHt7+fiKtLcoGAZbySl8qbY2fpfz3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAInuMCxDZ6JQhVxY7jwthQMJXw9t0JR+0r7lZAiUWeRYJW+sgD0c0TGNCGV2DD5RT0TpMl0S1zpSYfvDt+ifgDzqodZmhut+0iNNUuuHwNoexzq+JPbpfueEOnKiVZ8RCsUA0uCWWySf72oJUJSVC6WUGt+O+PmQ4WS+ql0Cqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YFKg5h/C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oa18zqZx; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YFKg5h/C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oa18zqZx"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A59BB7A0128;
	Fri, 23 Jan 2026 02:23:03 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 23 Jan 2026 02:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769152983;
	 x=1769239383; bh=D4kG2H+9qmJ33/kztw589XzH0pmk2bWS7PmZIvN/J84=; b=
	YFKg5h/Cu6G8//OwlRWThEL03TYvccQx4Bgha36Gr7pqNBGLTj6iu+CGfNiwEj1v
	X6vbwK29U7BdT+sDLh7nhqE4nsjOZkr9ghDKvCIiZYp+6YKQcoapxA29F7JJ2irN
	9wd/VC4sxygIH32dnVICBBapXlwoY20OEnih0KyvLym6bn9CxyIuC12LbWjEWe0V
	P0Am5/O6xM/LAb9KqrBSIKqeH9pDMZRFoqMya3kGQ5I6oTz9gSRocfbbad4dZCrA
	p7wZ1rpfgxthkT575hqGAn0/fkVRGJDWpvaOOweeGJPbQA322vo+fffcjwQXCJ2x
	xANlrZXB/jp4C9trfGmvUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769152983; x=
	1769239383; bh=D4kG2H+9qmJ33/kztw589XzH0pmk2bWS7PmZIvN/J84=; b=o
	a18zqZx6U4EWsOX9AyzdYOPrIYVVPiSxC57IRITzb9PXGxpsZYse78IfQpfSTGrm
	xWe7OGCACRb5G9Ql0kjUgjZqMsQrPX/qBLp1BhDAbxCnniS3jUZW46sN9bzRTYbl
	BMVzSD1J9mlRHGp6F1MGNcXuKO/caciMJLW6AbzlR9aMU9rcWYizwyYjhvHwvzFW
	qKiV12qBCYhmLS19P4QpAYW/aoLBp6Yq6DeAkhyfoxxprFAp49bsof58job0YH4o
	1b46uzc3mUHkzFAPmDaFcpC3dA5O51KzFCuHkcnBczcgwEr2V8eyEd50avnhoaj6
	Hfr8DFMb1pwdlM4vJa+8w==
X-ME-Sender: <xms:1yFzaeRm83TYuXwfvUcBIkVOPhxHZv1t5e-EXrBvffApNHF2f8ZcZA>
    <xme:1yFzabOeFb7ZCBzluYuA--16rxh2aWGbn_eFriovvk-puFwtfTcxmFQLHflXgKK3B
    eA92VYKkokyi3hu0wH7ZeGTE3X1qNmoxSCDFJx5L0J6lZuVWZGCdg>
X-ME-Received: <xmr:1yFzaZNsSxeQY8FniP9Wrhpnw0_9S5Z1Bmmm6QJZGvJn9gSA_jorrJbJw3jREilp9rM_iyj0w8rYMfy-KvP3NUfQK7GgPSL3V0BeelBH0bd3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeekgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvhe
    ekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhrhgvhigrnhhshhhprghlihifrghl
    tghmshhmnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1yFzaTvQ9yjbkcG_83hemj-gynHvCtsniMytyLDuf46lp_AKcKRlPw>
    <xmx:1yFzabUmXqENfqfZxS-gNGaEgauzVYlImWXCnLzQCutpFLtGllLTIA>
    <xmx:1yFzaTuaSvtTb8-43d8t3g3WY2B9jdYeXC_QhYsnG47lD_7kfkcqLQ>
    <xmx:1yFzafW2i8vANBJnhITF6d-7jrx7ZmJv7SQnsJctmgfjSHiPKhSYBg>
    <xmx:1yFzabOGZpPQ8k-qc_6SxlqL_tbfnASqJ53Ki_k7BwxzUreHp_JFxa_U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 02:23:02 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bd52efbb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Jan 2026 07:23:01 +0000 (UTC)
Date: Fri, 23 Jan 2026 08:22:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 1/3] show-index: implement automatic hash detection
Message-ID: <aXMh0pYw2ZrptCNj@pks.im>
References: <aXCJp_rGPetsXE8J@pks.im>
 <20260121103431.793004-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260121103431.793004-1-shreyanshpaliwalcmsmn@gmail.com>

On Wed, Jan 21, 2026 at 04:01:47PM +0530, Shreyansh Paliwal wrote:
> > On Tue, Jan 20, 2026 at 10:07:42AM -0800, Junio C Hamano wrote:
> > > Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
> > > > @@ -71,6 +60,40 @@ int cmd_show_index(int argc,
> > [snip]
> > > By the way, what happens if we find SHA-256 also broken and end up
> > > choosing another hash function that is 256-bit wide in the next hash
> > > revamp?
> > 
> > Yeah, agreed. The index unfortunately does not carry sufficient info to
> > clearly identify the hash function that is in use, and second-guessing
> > via the hash length doesn't really seem like a sensible solution to me.
> > If we cannot tell for sure what the hash is, then we should rather ask
> > the user to specify the object format. And in fact we already do that,
> > as we have the `--object-format=` option for git-show-index(1).
> 
> Yes this is exactly why I was peculiar about this patch and the
> TODO comment, also why I sent it out as an RFC.
> 
> I initially assumed that in the near future we’re unlikely to move away
> from SHA-256 to another hash, but I agree that relying
> on hash length is still a heuristic that won't be a good approach
> in the long term as well as it creates ambiguity in the large files
> containing 64-bit offsets.
> 
> So should we drop this thought entirely and just make sure
> that if git show-index is run outside a repo,
> it should throw an error asking the the user
> to use --object-format option rather than silently
> falling back to SHA-1 which is the current approach.

That would be a regression for users that currently _can_ run
git-show-index(1) outside of a repository with a SHA-1 based index. It's
not going to be a common use case, but I wouldn't be surprised if there
was at least one user out there that we'd break with such a change.

Patrick
