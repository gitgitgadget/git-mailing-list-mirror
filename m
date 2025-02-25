Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF174154449
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502768; cv=none; b=BMwYE9NMe96/+QsXQfcS5KLmwGjzznZfWP4ijV9RVeaLlid3j24xYxjx68aaTz6b2bTX8wKHHKvuDtcjDIXDskt7IaZFAMNm4Rn6MVyipVi3o4zUBF4I333z+d8hvtDvLm7DBOGXKiDKA4gF3FlnjCjncvRm4maRsqNm4j+6lBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502768; c=relaxed/simple;
	bh=EiqulZOwJ+jYtX9KBWQj1CF/qEHyPg9C4Cwe1qfN6Jw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h/EyY0LbNTtfohNVCR17Gmaq0Lg4DK3Too4TUCrACrNEmJnU90NMHsvYiyfhwaibUKMYFZgxqgEKIXjTd+GLjQqZ9fSNQFFLkZMbGGvMOr0IxJkoWloPy1amJCjLABqyPZ3QArxYqy7w4XUnQfQeGC0fDKZ8NsxQvT1Xux8+Kc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BTyiOa79; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VZqEqQ3o; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BTyiOa79";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VZqEqQ3o"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id D918811400E8;
	Tue, 25 Feb 2025 11:59:25 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Tue, 25 Feb 2025 11:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740502765; x=1740589165; bh=GMHx9g7xQH
	4c0hjpSmlVKIRSksF2riKRVkXF7Tt5AnY=; b=BTyiOa79dQJUIg8tfRKjnZa3D2
	AcH5kUjT3a/XkDoFH3tAbr10DyzBlsFgnC9I+ZlwCC70V2DfDr0iy6ZpuhPxzp7k
	jvdSZWn4b7LNfjyojRXeVeTvkiGUuNYvvKNZaipnS2Wzi6j95YqIkMprSz4wHbu0
	6QpegVxmnv7B4jcYECkbqI5mY49VeROutW5xdEqQaK1qx7xR4ffBN4nDPi7iE2wV
	jd6J3UhWkJjHx9rYyyPpp1j5s/k0oCPYgB2EeoCmt9CRnf3pfLs7sy7hMDHEjzyJ
	8WBkqqyxRq1Z1dY+0l4Jc3QR4kvEGEtxUDMGKPcDdaSocDC58MuPpPBOR/Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740502765; x=1740589165; bh=GMHx9g7xQH4c0hjpSmlVKIRSksF2riKRVkX
	F7Tt5AnY=; b=VZqEqQ3ovlt4PnU/y1IzdGIYleKUxUry54XfESG/ssYlPArnF4K
	Sl4wfPL3IfGtx+0KUzqwiD3aYE+V0j2pGGob+VCcZ7ctptvV0DjFKtB8J9vN8fPp
	K92I4u6n3Ncd/8Wys1/wihS+wZhCsgGaRncm1rz1baMoQrwihS/N9uUzP/m4YxY5
	6nBM5Ji/kJUlLfrocTZqOWkcNowkEQ7FMHOUA9z56ygylO7fbkuP61FVN2W5kHub
	C8rafw9/Mnj8PGoHUtM4tcizJuoJLmwXV3WBl52acDuMN30eiZ7Y9yyQHxwmpZuy
	QbvSv/tk8QbdoZrhCPpGIVprXAK4tiRIjbw==
X-ME-Sender: <xms:7fa9ZxOk_PISu8PyNLcJM3Bw3Au5Bbui5F9MuY65MBVm0Pol7fBplA>
    <xme:7fa9Zz8KdXTwh3f1oriy8LqtXSFKeQ4Sk4qFoJOgikgcOeSuAmgfaM5UOJdYPLjnc
    W_aF_Kksy5xdUkTcA>
X-ME-Received: <xmr:7fa9ZwRPfsh0JQrZsB-SfSMdw_Lo5OSKIJtbzK1PEtCGvAZQ4NX8Waj5RZ6fGhded-JUhkTIGoiVbIuAla1p7yBL38eugQgbYOD6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:7fa9Z9uoWG0aZqYtMjUkV-lfq79X70VU-UGRznnNpjgKTUKAvabI-g>
    <xmx:7fa9Z5drnAaV7yEVjmf2_CxzIm0r_qu3x0w0kD6H_YCjstBozSjYEg>
    <xmx:7fa9Z50VXvuI2BNrE4MOg_NKferoro4Nl43bStJ4rF3rxI7ScATeGQ>
    <xmx:7fa9Z1_T0xN81DlDtva3f-6_NHvo8bhoqlIUFtNMpjIOx9Lrlgr8zw>
    <xmx:7fa9Zw7PQgGGxRAQuNFCE5wHIrWuQJ6D4VCp8PcgBTqyPiF9SFqPG26->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 11:59:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: [PATCH 6/9] pack-bitmap: expose function to iterate over
 bitmapped objects
In-Reply-To: <Z71qQvlqtoOwDabu@pks.im> (Patrick Steinhardt's message of "Tue,
	25 Feb 2025 07:59:14 +0100")
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
	<20250221-pks-cat-file-object-type-filter-v1-6-0852530888e2@pks.im>
	<xmqqseo35ic8.fsf@gitster.g> <Z71qQvlqtoOwDabu@pks.im>
Date: Tue, 25 Feb 2025 08:59:23 -0800
Message-ID: <xmqqeczmkljo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I see that Taylor's series has been sitting in an unreviewed state for a
> couple months already. I can review it with the hope of moving it
> forward and can then pull it in as a dependency of this series. But I'll
> wait for him to chime in first to see whether anything changed about its
> current state.

Thanks.  Making sure that one hand knows what other hand's doing
would be a good idea.
