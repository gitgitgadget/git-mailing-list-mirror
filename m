Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB01A7AD0
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 06:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543134; cv=none; b=Bijh/asNx/g2CNiY9NcFAKJkiBHWQjsuC1gBfNEqOHW0pSYNZpwnctcvSmn2vU3lVN3OBcTqyxKMahEokQsBIoiQx9h2hHYqfn3qc71mUjvGWWvqw5GZfOKGWKtfpcO/AlQgmGlUrSzEgfRu+cb49AarKwoGwme7c7nLAsBqbNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543134; c=relaxed/simple;
	bh=fnKKFQryaAWImmBIDn3yiFXsMzeh25AzudcUZpKQnLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgWeOuXNbsGFktE/DXUvMpgr8E2qCHa17h4QbY93kj27LBIFK26czvO1hr0WoJKIQSmXD70o237UJK84QjQJGXIW5e3Z2GaTWDEztK58he55fI3qRysmdI0Z/kX5sfmnammpgrnYrkyo2E50Qs19V2xHLBJaLhKdUFMvXokdjEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AfMvUCes; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JKQcKy5L; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AfMvUCes";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JKQcKy5L"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 90D8011400DB;
	Thu, 10 Oct 2024 02:52:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 10 Oct 2024 02:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728543131; x=1728629531; bh=AKHrBNkk8i
	91lly6hSYd/mJBp77Juk7ZxNIIdz/jzFA=; b=AfMvUCesnxdBRCcTDnB5Qg59ej
	2THpxxsSZNfMkjkhpfl00gkun+Az5hcxmQoFkzzHCwmwpM17q9sPsIOeeQnSFbho
	ELUtL+WK+vyLVdu04F4xmrlXTEXc+hSK8f81R8bQGr7c84XB+SGwEONSBLscsEbP
	SOwuKcSSO+JpxUSL3usZt6ayUAbkCbn3E9UVQWhygyHvbW9fEBoLMNPzw8OzOSRf
	o6wi5oqF7tooOpgyKYq+rwW1k0hjbaBFvewSlPbxiYOMV0jf7U9avrAx4cFC9xIq
	LNCgySpww/Z2Yof+ESGq2cgoXcVgPhrsZRl4nw4tm7f5XtK//QIRLqVZ8tkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728543131; x=1728629531; bh=AKHrBNkk8i91lly6hSYd/mJBp77J
	uk7ZxNIIdz/jzFA=; b=JKQcKy5LjbNY/aNWeotcyMKMCxU5R1KqytR/0MqSrfQq
	bIsW+BNJc094v5HicrPY79MqMJFsYzPXE4ytuJv4nKfYiNCqmu59HB/WAyQGyw9X
	dWrml8hW6R1gciTlzEwKfiFhSOWrG33QAvi4rOeXYWobEEUwrFL4pzHEXErMxbSE
	1kyyUrw/7OVsZ8j/CRA+uGdclJv5S15zzIP91ClKpfxT4E6G3t5G3DdtL7sbINaS
	Na16g3ISJA8JPjUhHVmLqyr1DfFkZaC98UsAvso/yN/LkmSE4+dF6g2ylzS+NMo4
	xtXx9N01OmY3CUwCjHBZwUZh3XVa6wncioELGVO6AA==
X-ME-Sender: <xms:m3kHZzVfvRgmZR8B3zXFXIFrzStswcWCNFRDAZzZUzT3iu4LXKDAEg>
    <xme:m3kHZ7lD_a7tHqYtytjb7WSBaQZaySVmCWWRzdw2N7E-7SJuZAwJegDaoFN0-fxDi
    tIdPiwaybPs9HHOmQ>
X-ME-Received: <xmr:m3kHZ_ZjmuBDIWl_ZtPl9KbCxfiUtcPGhDelzsdGAjwwG9AriGtEr7QVdGIPIwm9sC0WII6zsZ4n5cpew3jCMUfHwJ1IYEHjPQsrR1JTDW-YJUqm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuoh
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:m3kHZ-X_Nhe_nzClPz7NnYQ9m8bmWwuJQp2y7pseXnt8Vse_kc3mYA>
    <xmx:m3kHZ9l2sgUZ0CGmPiup4LzkA2DcB5HB3bYAGsqZ5TZZhKzyzHU4Vg>
    <xmx:m3kHZ7cstgL85Zzj7bhmosM2DT22YxeXVSbu0uY5UwnSGsZKiace_A>
    <xmx:m3kHZ3EFDzHia0P13eu4Qv3SshYHheWxTia9CKgUsdmAGLIcK45BIQ>
    <xmx:m3kHZ2Bxl_QTMGKSuAfbTAc3KPsJxKFp9tYJ8NiGvB6hIOtwCf5rsCMu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 02:52:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5850e69d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Oct 2024 06:51:04 +0000 (UTC)
Date: Thu, 10 Oct 2024 08:52:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 3/9] ref: port git-fsck(1) regular refs check for
 files backend
Message-ID: <Zwd5kiZZME3ygM0K@pks.im>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-osCNDMrUQv83@ArchLinux>
 <CAOLa=ZQ3Gytt4Lsttxws3DWqbjteJS8mXvZSPzDwBJi_ALS03Q@mail.gmail.com>
 <ZwUkZuCtYu7niuFM@ArchLinux>
 <xmqq5xq232wa.fsf@gitster.g>
 <ZwY5O63OI01LZX1u@pks.im>
 <ZwZwGAxkbQtnozh9@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwZwGAxkbQtnozh9@ArchLinux>

On Wed, Oct 09, 2024 at 07:59:20PM +0800, shejialuo wrote:
> On Wed, Oct 09, 2024 at 10:05:19AM +0200, Patrick Steinhardt wrote:
> > > The fsck.c:report() function, which is the main function to report
> > > fsck's findings before fsck_report_ref() was introduced, did not
> > > have such a problem, as it allowed "const char *fmt, ..." at the
> > > end.  Is it too late to fix the fsck_report_ref()?
> > 
> > I don't think so, I think we should be able to refactor the code rather
> > easily to do so.
> > 
> 
> It's not hard to refactor the code. But this is not the problem. I am a
> little confused here. Because we already allowed "fsck_report_ref"
> having "const char *fmt, ..." at the end.

Ah, I didn't double check, but was operating on what I understood from
this thread. In that case I think that the current interface is okay.

Patrick
