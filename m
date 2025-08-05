Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9CD2741C9
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398248; cv=none; b=ENU+VclvnMjteH8nzGMkzTAmPi+CSLbgyQX1Z58cmHKOzCIXnwyXkTs8Xssh6KL2LZhzFtwMYApttTbhcRPnfOcTZ/YPVORnM8GYZocWA07veVN2PZIVC/vB8XULzmfywIWauNKlH5G7V4bQDEwcQtaX+NWT7JMINeXlTIW+h70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398248; c=relaxed/simple;
	bh=u2/rLG41+EwBrR94Ud6v9p9v/0AsXlIh++aQFuKVrz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDylj/U5rzIsXZXZmEU2P1/aNzanBJVp3+eBl4wWeRvlvcf7GlXCw8zE513WYhzVmPUrzN5TREsDmQlaB2FDjEacOnD+t2r5A9SjBCfyhO3Te4skd4khwJyP2AAY9ld/6LelP024FrOv6qNocHEVtiby1ocfof3US3XxHovsQfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hedc0oQk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P1GGCCp6; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hedc0oQk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P1GGCCp6"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C3D921400226;
	Tue,  5 Aug 2025 08:50:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 05 Aug 2025 08:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754398245; x=1754484645; bh=jSpTqAuiMN
	ypP15u5moWlZKPU2ucjQ/gOGZZLaP/wLs=; b=Hedc0oQkxKpg+RCxYDkajCzU4o
	2KeXuAvf16J/cBiTDxS8IOXYSdh1jHdXwcxV9/nkKmOV5ymIQ1JvoLGL75WOh7e1
	k6tB89pB694hYZ/ykkiiuuDl7h2bfbjkuMxlSU+/nXpIXL3gvNgukAOxBD8EW2bw
	R0LDJKmT8HyuOGDBnFX2AnwcF7aRT4QBZsvtWxYzUsq+6qZeeYRvp4uOLm2wh2wG
	NqvjJpqilqFbjJTxgSbjI2v9YkC11+yLeneyFZXmrwcR/OSb02CZanowuWP+lN84
	CeFHd8I/yeexo/R7VKoMCWGjWIscixQFPb4nwWZBfpOfBDHJvvyRczz6nLAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754398245; x=1754484645; bh=jSpTqAuiMNypP15u5moWlZKPU2ucjQ/gOGZ
	ZLaP/wLs=; b=P1GGCCp6WS5fq3vi7DPw7NldX5vDyJ4/fP9nOjrj/r4g2jfLpWF
	4SE2Q8Tg8m87gK059h9vpAtvN8V2Onxrr8qVPoLz3tPiuYIgQQR8gTMRtW2JA4Ya
	9BciBzS6INc7TvFjzjGX4RtW9ukJ+YWIfMIElBmDWzufYaE0lzZZuna0KIdwcuqp
	sP57go5UbBP7gHgafKyB34vB906iseCQnwyS3016ChEYbpqZpZ+nhI84bQv/RXhu
	FAzFG/NrFzz2XnYoNTVnvWB6GIAZ51bIEU6GX8P2b5NJereJdKtuFQevtUQHO8V1
	1ytvxxBVmz3PnA6OIzT2sJ+usaGUijLcX3Q==
X-ME-Sender: <xms:Jf6RaI50ndoaYwtYm_7zK3Z2wVUNWq6YwMKPPkNesu7XImNOpYiUWw>
    <xme:Jf6RaHQMyH44M1Tn6Ov6iX6p5O_3tQ6ffWDi4iTj4oqMpj7c29YPRelxkhz9N0cCX
    sEw9vd9py3TCe1zWw>
X-ME-Received: <xmr:Jf6RaOz8T6JFKE8eyPSgdCRsMpfYCNnMGumA_20LgQD3jdmE_R7GEKLOFDMpxeCnAfJjIx2AzDwVd8BqBJ0qACqu7o9jyZ98tni9ghSXPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhsfigrlhgurdgsuhguuggv
    nhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopegsvghnrdhknhhosghl
    vgesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinh
    gvtghordgtohhm
X-ME-Proxy: <xmx:Jf6RaHohm17UTjjGZ97I4ES_PwxgEcduORUk5jGniVgCsKCLSAZihA>
    <xmx:Jf6RaJ3tChOhtvkui90Yy52FdzRsUtfNX6cgtp4JqqRICLmOCf5yeA>
    <xmx:Jf6RaPz7WKnHrA6hGqQXEOrtUUFsGqINcymDPq56rRHc3m4ehEuJtg>
    <xmx:Jf6RaFg4EETEisQGwZ9Gu6yY202GcYiAVGPSEOW1-tYqpJVdOhSXZA>
    <xmx:Jf6RaEKf70wg3yxpqkI1LjK43eqlP9h2jWq19zvnmjbACwu8tMrHkhNl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 08:50:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eaff83dc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 5 Aug 2025 12:50:43 +0000 (UTC)
Date: Tue, 5 Aug 2025 14:50:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, karthik.188@gmail.com,
	ben.knoble@gmail.com, gitster@pobox.com, phillip.wood@dunelm.org.uk,
	jltobler@gmail.com, jn.avila@free.fr, sunshine@sunshineco.com
Subject: Re: [GSoC PATCH v7 0/5] repo: add new command for retrieving
 repository info
Message-ID: <aJH-IBe7w4mwGa2_@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250801131111.8115-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801131111.8115-1-lucasseikioshiro@gmail.com>

On Fri, Aug 01, 2025 at 10:11:05AM -0300, Lucas Seiki Oshiro wrote:
> Hi!
> 
> These are the changes of this 7th version of `git repo`:
> 
> - The tests were refactored (thanks Eric for your careful revision!)
> 
> - The documentation has been improved: now it is a little more
>   descriptive about the keys. I'm also including more information about
>   the values
> 
> - The documentation now contains examples
> 
> - If an invalid key is requested, the command fails, however, now it
>   returns all the valid fields that were requested
> 
> - Now, I'm using `quote_c_style` in the key=value format
> 
> Thanks!

I think this series should be almost ready. I expect another final
reroll to address the nits, but once those are addressed it should be
ready to go.

Thanks!

Patrick
