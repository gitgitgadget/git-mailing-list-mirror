Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3AF21B9D6
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 06:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957270; cv=none; b=CUWsdJP8L9tlCHfmzhak41X4BmZW1iOghGPDurJcB8p7PfXmQR23sQaD0Dvh3KpiMomQT+/cVBkRDYMXSlRlyDXNdqSM9/+ww+rWkV4G4vL+IwVTvMTS71a1Ehlkf1ZGScxlAFBJwn68qRP13Muqyk7js2CFp058VrJYMuQG0fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957270; c=relaxed/simple;
	bh=IyoICV20HpPIZGGSiBbrOmCQ0q32ELaq0Y+mhpwQiJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urSXD5NCPftiB9Qpdwp+4CWn0WoXzq0giRF1MUsn+bHNaWD+jXISoq72hmk+SM3pdJk9mS9+HPuqKxObex66pFC/T8AwwVklCcRFksYWFeaUv0hr68zLbMj+dbx+WZiA1Q+qkDmFi8/v2PmKl8yJOxcBzttzo9QwjMnRZ8uoVfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y3krrCIv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EI3y/Zs8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y3krrCIv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EI3y/Zs8"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 64FC8EC0B39;
	Tue,  8 Jul 2025 02:47:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 08 Jul 2025 02:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751957267; x=1752043667; bh=SpaMXFB7EM
	Fy3MBdw7FEHZxoUc980cb3UNfQUo98UUM=; b=Y3krrCIvpYC9TczIAeFXNpZ9iC
	DsCSQbrsfKmglYFCWJW62UtZuIzK1A/tad3hYOufdLqDoiKCh/4nyL6Z8xe/Rt0J
	Vb8U7xzPQ4/29/G7N5+nVVZZ3qFN7S2m8v4ZABEUPWdvmxeutj9b8Kuw9sQwpwgY
	rCHyGYDDtwnU6I5unGaEf9KTfOme7clL9uyC8tgQCht67Dcc4CB+8x/46Wetk/m4
	ls838ZjwXWLEIYz88eUgAVUg2298XGxMR/rUfkDUTgIs9ldtMlcHiXYvLhOo7aib
	o7Ws4S8UzPh+iNQgkDMPhEThqo05I/52kb7FDsfjxOz36S2LyohYAysuATow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751957267; x=1752043667; bh=SpaMXFB7EMFy3MBdw7FEHZxoUc980cb3UNf
	QUo98UUM=; b=EI3y/Zs884vA4FMiOc086/m5y2Cb6XSvGNfQ5r1R3Q44PvDCsIy
	EbM11sCHKUTXdJOyjDvpjwO8IpnD+smrQq62w/j6i2nH+7zYKFn31Ij+Nk0OuhsK
	6utckAa1pV2Lg1i0P+XFewm3f2CXUCrHDgRiVIu3SaMGzCMhgjezqSjU59u8vRuF
	Pza0/qpYrdYMbHQFe9UdkuRRzMswCXwowdfBDcoZTsqWD1RCZYYgmKQkFLYo8XmL
	4EIzYsNC6FqGowMlg5Zrzf/URNt9M5y0vK0gTwR+f2Xhe76Q8RMV5iJHDbEYIyBu
	ZEyzgVMnGUduD6w1nDBfwOUJCEfCdNFSDww==
X-ME-Sender: <xms:Er9saEx-MggZAI9rk2ZVhgt4MDzdldulfKYQmokAD4AQYKm6BtcX1Q>
    <xme:Er9saNecRllXOtJBXDDpYHCSiVNtLSgeLSZrVkLTgGpQqGeue5V1qzJpPiLANkMjl
    FbPecBQZMSMwxceBg>
X-ME-Received: <xmr:Er9saHPv5Vz2bbzkG9m3-G7G_Zv4zN9xE0VFKP8TpDET_W2Cm9qyDrvy1D_c84ZuyXn4XMKCeeJCTMzyhfUSKV0LfzvLWi8cObhHRp09-hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehfshesghhighgrtghouggvshdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgvughoshhtvges
    rhgvughoshhtvgdrgiihiidprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:Er9saIuWzx0bvqC4QStCTvQ8VqMxjYn157V67R45tjpme37oELJ8wQ>
    <xmx:Er9saIDbe7duYMITFFzMKyxFSbsIrhmeh6Yy7dWbIkbtII08raxB9g>
    <xmx:Er9saHZKD0gwr9cMHT3pg1Ce4KhZ4UnTsv59Zw_VPH5YyaZ2fCUwiQ>
    <xmx:Er9saLVtvXH9gA1Gu8_2SAXTy-6PSkDKzwGHqMWc_MFiG75LagxEdw>
    <xmx:E79saK_r8zavgvr-Gb2UKqT3ohtRFtr8FV1_6MdiOX1INbhWngwc_5PN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 02:47:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1d8b63b4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 8 Jul 2025 06:47:44 +0000 (UTC)
Date: Tue, 8 Jul 2025 08:47:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: redoste <redoste@redoste.xyz>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Elijah Newren <newren@gmail.com>, Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH v3] ssh signing: don't detach the filename strbuf from
 key_file tempfile
Message-ID: <aGy_DEehFgw4A6va@pks.im>
References: <20250704230829.29696-1-redoste@redoste.xyz>
 <20250707184852.16010-1-redoste@redoste.xyz>
 <xmqq4ivn4t30.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ivn4t30.fsf@gitster.g>

On Mon, Jul 07, 2025 at 01:57:39PM -0700, Junio C Hamano wrote:
> redoste <redoste@redoste.xyz> writes:
> 
> > v2->v3:
> >  * merge the test with the previous ssh-agent test
> >  * export TMPDIR in a subshell to prevent the environment variable from
> >    leaking in the next tests
> >  * use test_must_be_empty instead of test_line_count
> 
> These sound all good.  Will queue.

Yup, the patch looks good to me. Thanks!

Patrick
