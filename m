Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5A225B1CE
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751369741; cv=none; b=iyf9afFLgGTlIrrA1/IpEMhXKjbD0QcL+n5WLAv2h5YKvTC4BpiZoz+2sf9xzksrcomfmH707NLijbg4OLj8bR65iTS1TdZ8y7jZ55KtHpYOLVowmA+mRyanSaBG4ip6ukk7s0eVayiRuVvyzlBIzI+YOpzXvnpv1iQtWKujc4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751369741; c=relaxed/simple;
	bh=IQfx0ixFibpNbYOif5RLHfsARPLnsQBzCO4v15+kwWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8ubXVxHaiCNjrreAyUHwd5T1Q3Fwa4DbVXeqXlnLtB7ZeTn+yJTGmXz8g0zeOSyzjD4aLQQNxyZG5QysF1N0F7SBEkiwYBjmkWsAKyVY//G0Y/BveIiltPI89Yr2ZcUT+VezUNp3Frn8kXKXf3HVLWhuvYhd1UW/SthsFaKYa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DYapWRl6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a+foylt3; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DYapWRl6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a+foylt3"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A58971D0026F;
	Tue,  1 Jul 2025 07:35:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 01 Jul 2025 07:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751369738; x=1751456138; bh=0Cu6ZP/f2w
	ZH4tskdZFEyZBl+FzChEZEaP3ahMES7qI=; b=DYapWRl6QH6qXF74FoKnsP4UQM
	Gq2C1LvdI4glEsHKJbg0KNJOj4LZ703O9NLGEjMCGasBZhxHnTJnHk20kmbM4tyb
	fQ1Ah0wIVTKOEyolas2IkxvNwpoD4kkevJoqcq/CXGZ1I5gnWlGTBX0c+5+4necn
	Anz6sIZBE80ZghM62a7U9S5ZvPrO92+NJLhVtcekNPXBp82xwE8lPNjmd8zRNGRg
	mDlVxxaFI9lzMnIKHGek4k0KEIG7W1xI0Q4HcRZFsZmDuydspNDVBEnisHOGXwfw
	tHA1258ptOffBe276pAArfGz3g/p7/ykYxEngUK9MVZzD74czATmo49wDihA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751369738; x=1751456138; bh=0Cu6ZP/f2wZH4tskdZFEyZBl+FzChEZEaP3
	ahMES7qI=; b=a+foylt3Q42DaiTHbrPzHz07FUC45g+RrmX2r2IPjH2tmfpCR9u
	WUAriT1sNSmQ3rdF6U489QYYfSNEZfOy5SZySEeN+W4sO9ByLzelA+gpi13bf2WY
	zpARNZ3B+lhVBDzZ1UtSQ1CzE39iC714rduJFDfVrXhUF/ijCrT5uAhWMTtQ4Iy0
	q/A0SsJTduXzvnGqUTt3gOXUBtm+PGeNYVLyY2D5+ilChJGM3I2iJK5XQ18j8QzM
	xQdpjTP912KXa8WTViwWH/paAfpEVb3BJEt6Ri+yvn9Kpsqs5SV7JPeUx0TxZHfu
	bBOzM1k89tNNQA5pMeSpFHufSWrgTGRZIqQ==
X-ME-Sender: <xms:CshjaNdNyNEuRqy--Uz-Q6xcGe44dkY2h9FaxgesFRpWd-39D-RVcQ>
    <xme:CshjaLNqYsSUnVUIoRc2GZYe81IdnDwNH2YqZRECE0WTUEZKkrnaTIZPn5cR7zfd2
    qeS1PrNIiGwUahnKw>
X-ME-Received: <xmr:CshjaGiYKJjjrpaIcogWyM0NpobfwWB7k_X-Zp-w-WfCIGXTSnMvZtBu0_yn9P2bGjzG_kBPPqvpQd1JSMWAcztRMs654mIA1lGImMjQlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnh
    gvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:CshjaG_A-TZk8ZQrCg2-ODojA6XNsLiev_zO33Aqqj4i3LeH4pdSpg>
    <xmx:CshjaJtt0q-vV-sn7tT2-WSD8G3hTTOqmkZP1e_0vJ8e9IMbhrUPAQ>
    <xmx:CshjaFGJ3OCbkYqdOyLQ7VpW8xSch3sqnnru6IFIkTbUsG5GuHLRXA>
    <xmx:CshjaAPPjiiYYkyXp7OB9tnonZAyX8stNJ0c0ey8MMFj7ZWmZw8B1w>
    <xmx:CshjaMVJDMstFo-AK52VgcR8412o5jBXUtrrSsaAwdTn5hjjQ3UFPnYI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 07:35:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c01bc696 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 11:35:36 +0000 (UTC)
Date: Tue, 1 Jul 2025 13:35:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/10] builtin: use default hash when outside a repository
Message-ID: <aGPIBa-1xjqk8EEE@pks.im>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
 <20250620011943.586596-4-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620011943.586596-4-sandals@crustytoothpaste.net>

On Fri, Jun 20, 2025 at 01:19:35AM +0000, brian m. carlson wrote:
> We have some commands that can operate inside or outside a repository.
> If we're operating outside a repository, we clearly cannot use the
> repository's hash algorithm as a default since it doesn't exist, so
> instead, let's pick the default instead of specifically SHA-1.  Right
> now this results in no functional change since the default is SHA-1, but
> that may change in the future.

With the preceding commit in mind that introduced GIT_HASH_ORIGINAL you
could also argue that those callsites should be converted to use that
define instead. We always used to treat them as SHA1 repositories, and
we have no better way of telling otherwise, so we use the historical
value of SHA1 so that scripts aren't dependent on how exactly Git was
built.

Patrick
