Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31D14C92
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 06:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742796022; cv=none; b=YovYJhzKJB/gANBWe8TTcCJF4gD4bFg3H2Pr5G4iQOECko0HypP4CAlkjF0W12fwFPDlX5RgMj/uCgYnRiKliWB4ofcaa/QGO4YHFu8wSp1AH9Rv/7yksUcEngshex0X33g3J8yNsF2+ZHmDiMSffsUHNab6XqAHyGEm137ikug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742796022; c=relaxed/simple;
	bh=2HM07Ro2ktp7KoosvNAo58aPeEcj7SWCMEswu3uWh8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LWSOaSY6T2imsrS9yfIpiwL4VY0rc/PgeGUF0IiUH3PNIhOlHK1kuIhD9dmFieihmOisoyR2Lq3sAeUKKkW6vjCNvURDSWYCAQqtSPqWCbjsOz2dH5BwdYnpJXylRC6hBT63TXI/vk61Ey5agXnh8d7Z6A7iCk9AM2S8GLcMKXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Cj6m49ur; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YFPJcKTx; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cj6m49ur";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YFPJcKTx"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A480425401A8;
	Mon, 24 Mar 2025 02:00:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 24 Mar 2025 02:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742796017; x=1742882417; bh=bOMpJ7JEEp
	U/f1iX8TL7j0iAatq+q5mm14lK97KhiA8=; b=Cj6m49ur0UpNhURQiEqzu7LtBI
	eawLKkaatqMLwOlCUPURlPoWlaBDc7rQdMQzs6RvcpeKBy3pUJHU1xMLEPRgKwyl
	x8uD1xLpIELhpuWK5EXEFqd8vl6gH/HQj+8A2TSFQufguJV9oQrnNnhOapOXgoq6
	4Nu+pPDyFH+l9qzHf7P7+8z4/LOr4sFRJXvjDOBGeZK5kPenaHt6qIl1yXqYFns2
	Y+ocWgtZx91i3mxaUSPI5IjAak84Rpb2+97bWon9L0P8DrgRqDDlR5nLVbPXZ+Ea
	N9XxFaGNb9EIb06mlcBNcAdYcL5dIjTaYn/y5WQkezFVd9N8nhcl3de4NNSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742796017; x=1742882417; bh=bOMpJ7JEEpU/f1iX8TL7j0iAatq+q5mm14l
	K97KhiA8=; b=YFPJcKTxTQU1TRszA8Bs0brilhunZInW7EGJF+e07mxXANn4rPc
	x6BjRFk5ykKDDbheEMFwJpzMBIgg/8UepjABZgBtRa/vhHRJVq1iuucq5win4sUb
	nczUdg0h/s/UkLnk1JnVyvISLG6CLwnMdDvrQv1kJ001ptivMFt9z5tDPVY5FO2g
	6oPs9vi2L5hQTFnMbTsxaGCVYZ7mNUI/LcWtgjwxffyDe4t71kx59v5FQ2+BRAjW
	JSBNGNgSJizkSGaJWekvrqOr/56shlX+/dURBonIe8JNVht3nyf4IU5qMLU9qVgC
	C8+WKII7P4jn4OW8AHIapPGI6pnmNOSE/KQ==
X-ME-Sender: <xms:8fTgZ0PdYrHLYQZbCQpD4mT_nM3uL7zTqf_23jGwuo2ShtiK7TDQzA>
    <xme:8fTgZ6-DnLXmMlhL7ALq-qWiOuXXkbN9M2_g7LwnPVee4zRD_xwfzzGDOAwjtNWFt
    sKvl-feVxH4qv4Rlg>
X-ME-Received: <xmr:8fTgZ7SjpxDGA8-35oaRKHxcaNok8oCUADgLPzeZM9y3uAWKczPnes72F7DpAoTUbJOUWmBYAGbgSgQMIizS-Njsg0tc9jZPxjbqUbo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheekleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dviedvffelffehvdeghfeihfeggfegveeufeeufeeugfegvddtudefheehheetfeenucff
    ohhmrghinheprhhftgdqvgguihhtohhrrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptdehii
    ihtheftdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepmhgvvghtshhonhhifedtudejsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8fTgZ8vXR_u6qHH0jj0PKOe11tWJiM1da-h0o_cpXw-EjbrTAhlwsQ>
    <xmx:8fTgZ8cH374BeEd0dHAYd7cRlbSfk9C9sSz0YR0AyVIzCojU3lQqfw>
    <xmx:8fTgZw22TeQaZRZnMVuPNrAC00MeksB6wG2va7R0zlNA2IeTILRebg>
    <xmx:8fTgZw_DP5PfMqlnxcXOCgz89rZPidBWoyLl06C0woibKAo-Zv4CNQ>
    <xmx:8fTgZ74Ee2w2VpiimeMD-nsdtQAFGUfAVllm1jHtvB_mLtaZkZchBCob>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 02:00:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Zheng Yuting <05zyt30@gmail.com>
Cc: git@vger.kernel.org,  meetsoni3017@gmail.com
Subject: Re: [GSoC PATCH v7 2/2] send-email: finer-grained SMTP error handling
In-Reply-To: <20250323022111.20226-3-05ZYT30@gmail.com> (Zheng Yuting's
	message of "Sun, 23 Mar 2025 10:21:11 +0800")
References: <20250321025128.68463-1-05ZYT30@gmail.com>
	<20250323022111.20226-1-05ZYT30@gmail.com>
	<20250323022111.20226-3-05ZYT30@gmail.com>
Date: Sun, 23 Mar 2025 23:00:15 -0700
Message-ID: <xmqqh63jotn4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zheng Yuting <05zyt30@gmail.com> writes:

> +		if ($error) {

This block is full of overly long lines.  Would it make sense to
turn it into a helper sub and do just this here in the block

			return handle_smtp_error($error);

And then the remainder of the block would become a single helper
function that is called only from here, losing 2 levels of
indentation.

> +			# check if an error was captured
> +			# parse SMTP status code from error message in:
> +			# https://www.rfc-editor.org/rfc/rfc5321.html
> +			if ($error =~ /\b(\d{3})\b/) {
> +				my $status_code = $1;
> +				if ($status_code =~ /^4/) {
> +					# 4yz: Transient Negative Completion reply
> +					warn "SMTP temporary error (status code $status_code): $error";
> +					return 1;
> +				} elsif ($status_code =~ /^5/) {
> +					# 5yz: Permanent Negative Completion reply
> +					warn "SMTP permanent error (status code $status_code): $error";
> +					return 0;
> +				} else {
> +					# if no recognized status code is found, treat as transient error
> +					warn "SMTP unknown error: $error. Treating as permanent failure.";

The comment and warning message say different things.  I suspect
that the warning message is wrong, as the branch returns 1 to signal
the caller to do the same thing a the 4yz transient case?

> +					return 1;
> +				}
> +			} else {
> +				# if no status code is found, treat as transient error
> +				warn "SMTP generic error: $error";
> +				return 1;
> +			}
> +		} elsif (!defined $result) {
> +			# if no error and no result is returned, treat as transient error
> +			warn "SMTP no result error: $error";
> +		    return 1; 
> +		}
> +		else {
> +			return $result ? 1 : 0;
> +		}
>  	});
>  
>  	return $auth;
