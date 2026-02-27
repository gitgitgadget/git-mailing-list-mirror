Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F40038F237
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232529; cv=none; b=eEiu9M2m/CHJskMW9ZxsCTwfY4fqVWbOMDbWVX+UpSnlu6OfCo0zBqRYk/x7ETAF087U8mc8oF3cSPWW5+1W2OH3R36ga0YB7NMjVj7vziocWckd6u33/MRrrSiJxSDdCHD99ZUfnvBy0mcR0wCXHWmSh9WNsJ+2ukehcytaSA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232529; c=relaxed/simple;
	bh=IZZZxvpuzSXUDbwAXv4zvMiX4ABbnOooOUInl75c6J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbfCC/Ry5ijt7sVIjewzj3tBrR3w2004pFsGT6r6jxXn36pA8fGf4efwq50TYjqGqY7zA3dDQ2pMo/no38eFlf3fWXLliQprrPEuUoctMN9cShTPr0kJthlHVeBLXF/X9taISLRlVmKphvp0rIQG17luYVSCJE4O4hPKKTrkJ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=a09UPhhC; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="a09UPhhC"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772232525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FyWV69giYONhlPmUT4gVV1QDfklT57WoneUIrxmUFX0=;
	b=a09UPhhC3pcqOG4h39f+du2Jf/Oem1EgcRGmd1D3jmaeKHlNMu+Fq0HRtW3yQOHK8xw3p4
	xqGO/bMzznIiV7a8TR8kRKEyckt37i+qFbxWT3q5TLMhhrd51QcHsZThK0wK8z+3eBkN/X
	D4wdw+X5JUsIO1vcwm+Xkgwxj6GTzifMzDKCD5gIUIgxHQ4vwppB9g4MkzPZYaZUo8tvHw
	znS3bdQntjKYAeWJ08AWZKTVRToavBANVEG4CENwtTPXbvehChuqFG0uLarLxPUsGx4ajA
	9/Q6zj6OM/RokSIoiPU0d20AdJxle3h6lQv3iIhhW1MLyjEvb8YbTJXK9jksgQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v5 0/5] format-patch: add cover-letter-format option
Date: Fri, 27 Feb 2026 23:48:10 +0100
Message-ID: <cover.1772232373.git.mroik@delayed.space>
In-Reply-To: <cover.1772196510.git.mroik@delayed.space>
References: <cover.1772196510.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

I've reconciled the formats between the command line option and the
configuration variable. Changes are reflected in the documentation and
the tests.

Thank you for the review

[1/5] pretty.c: add %(count) and %(total) placeholders (Mirko Faina)
[2/5] format-patch: move cover letter summary generation (Mirko Faina)
[3/5] format-patch: add ability to use alt cover format (Mirko Faina)
[4/5] format-patch: add commitListFormat config (Mirko Faina)
[5/5] docs: add usage for the cover-letter fmt feature (Mirko Faina)

 Documentation/config/format.adoc    |   7 ++
 Documentation/git-format-patch.adoc |  11 +++
 builtin/log.c                       |  91 +++++++++++++++++++++----
 pretty.c                            |  15 +++++
 t/t4014-format-patch.sh             | 101 ++++++++++++++++++++++++++++
 t/t9902-completion.sh               |   1 +
 6 files changed, 212 insertions(+), 14 deletions(-)

-- 
2.53.0.5.ga216069370

