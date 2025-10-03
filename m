Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8412D738B
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511119; cv=none; b=d/9nx0MynUGxax6c+UEddibUS2bDcsS6WENBzbUMnMQM8BiQPgzJepu42Zc61fBLWU3c9fIb+X3lILfX/xy4KF2QB6wBQ5NF/2CYu3BxrZXbn3ymA7w4if2e4aAYrF/crt0Y0KbZHqjZD6dSjqnIVF9Ctjbm2d9HVFiByI13RoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511119; c=relaxed/simple;
	bh=pJ7A3pGFqqXjYOIh+tfl64rxH1EaNPQICFssvFJeRyY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WSlXlXxPIMwiFgdsVoFQxTYVAFm6za++0nsPj+9jPPn5/HAEJ+vDG3RvQDstSRzwq5hDVCV4Iq7uvsSlEAadIeK/9NhNOXeIxiS3xsV34IIHbcccJETCtIy1RjVbFqlroOdY1+dIiNjt4hE4MFxjwdDaF1TQUDoxx69aAMhXMaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hO4hTBG9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eot/0QO8; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hO4hTBG9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eot/0QO8"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 692EEEC025F;
	Fri,  3 Oct 2025 13:05:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Fri, 03 Oct 2025 13:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759511114; x=1759597514; bh=ofE1+XmrSX
	veWrHwiiUQSgQ9R+aE/WKh7dM1fhTu9Pc=; b=hO4hTBG9PHFvSS7zeUQ3GrK0vo
	qos6VZnSVSl6ackKTgqzv+9JtL28MQA58VJvWhdZLHyMicIwTtK/YWOyHeYSEr4r
	bbGGLnEKIGuHxaCFWrndKBR6u2NLLe9EDNXZXaN/396M4LP+jDiHzqABx5G9cEPZ
	EIAL6Nl/2On6lvLttTuUSt427Ml/UHWNxlZNyNqddI9aehRW82CeuwfrKjcPnewy
	1FJbbVJ797wDqgAd8LKCBZLG7qHa/J5BZy+sWfvJ8Ztgy8vzpogyDzmWkS0IX08Y
	dfWh0AUfaIXXFzzEnFPLVHQFfTlupdlvj0+vtDRrdUxg+/CIk+I1T2Q/fJsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759511114; x=1759597514; bh=ofE1+XmrSXveWrHwiiUQSgQ9R+aE/WKh7dM
	1fhTu9Pc=; b=Eot/0QO8kFcpQUqnWE/AJwos/vqiOrwqKPZzR9Fxi94jQZqRmun
	PPphXRkGPsVmuxykAMNtDPO/fjXACIZhGcNz9hhJ/qF2E3eWba6PS0iAVdjMBRTZ
	p/BgyVNt0P24VW9A/uUKUTu0b9fduzo3ttoW8/Oconng7Mi7Bq9MfH6k5VkqiGYB
	CHksnriliebYfDfUmXxstVKGlGoAG+JjyFZTxx+o3vuxlurP7IJpwMUaKmyK74wF
	kxD/AUCnJuCJMWQxeNLKm0etWTnjquqyE9Pu3YWOccMIfVkyRskTyGM6mj+FRW7i
	CcGpmDCw6hAR63wVF7ONZbYO0Xw0i29aJFA==
X-ME-Sender: <xms:SQLgaEOg6atzSi4UyE-RbQdGJtKDbsKOwqG97e8d2YhLXNzeUWS05A>
    <xme:SQLgaB8vaFPCauwPxlI6uvU6LrAKd0vC6Y1L8AjkcdqfitI9Mp4nGeMmRJsaUqiil
    w3CZTga--R0NjtOQuUP9ydVrJCnfTrAxt3OxVG9BF6xJxjsgkCbBg>
X-ME-Received: <xmr:SQLgaAT4L94NbzL8ftp89suGKSg0ps3ygtMLuxUkFZrcgE2SnwOHi-_6-34jDi64MuzU1p0d0ny1VMaWuqrm8dc5D147h2ubQ6Zv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:SQLgaLk_EKgrUFtnRv2RBQy9qinPI8F0qvmE5VIwXOzZGEqxUXdgGQ>
    <xmx:SQLgaISN-AHhum97buk2ENv2wLXz-CXHh7_FlMG3oSi9u3W8ghmoqw>
    <xmx:SQLgaBMnP2L-iuitWXbkyvf6mrAOz4X31iRpF2_FkEwd38RpomBjNQ>
    <xmx:SQLgaJXIbZnhCqbI45mBlV2DWjtpFwGUvAMvgZcalZdAtI1q0is09w>
    <xmx:SgLgaAk-Rs8kKrYJ7k41mWpMMmBqN9f0YhvF1FeVeCwh2-I2hFQv8qtN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Oct 2025 13:05:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 5/9] docs: add documentation for loose objects
In-Reply-To: <20251002223855.1022847-6-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 2 Oct 2025 22:38:51 +0000")
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
	<20251002223855.1022847-1-sandals@crustytoothpaste.net>
	<20251002223855.1022847-6-sandals@crustytoothpaste.net>
Date: Fri, 03 Oct 2025 10:05:12 -0700
Message-ID: <xmqqzfa7ud9z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +DESCRIPTION
> +-----------
> +
> +Loose objects are how Git stores individual objects, where every object is
> +written as a separate file.
> +
> +Over the lifetime of a repository, objects are usually written as loose objects
> +initially.  Eventually, these loose objects will be compacted into packfiles
> +via repository maintenance to improve disk space usage and speed up the lookup
> +of these objects.

Much easier to follow relative to v1.  Very much appreciated.

> +== Loose objects
> +
> +Each loose object contains a prefix, followed immediately by the data of the
> +object.  The prefix contains `<type> <size>\0`.  `<type>` is one of `blob`,
> +`tree`, `commit`, or `tag` and `size` is the size of the data (without the
> +prefix) as a decimal integer expressed in ASCII.
> +
> +The entire contents, prefix and data concatenated, is then compressed with zlib
> +and the compressed data is stored in the file.  The object ID of the object is
> +the SHA-1 or SHA-256 (as appropriate) hash of the uncompressed data.
> +
> +The file for the loose object is stored under the `objects` directory, with the
> +first two hex characters of the object ID being the directory and the remaining
> +characters being the file name.  This is done to shard the data and avoid too
> +many files being in one directory, since some file systems perform poorly with
> +many items in a directory.

Additional explanation new in v2 look quite sensible.

> +As an example, the empty tree contains the data (when uncompressed) `tree 0\0`
> +and, in a SHA-256 repository, would have the object ID
> +`6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321` and would be
> +stored under
> +`$GIT_DIR/objects/6e/f19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321`.
> +
> +Similarly, a blob containing the contents `abc` would have the uncompressed
> +data of `blob 3\0abc`.
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/Documentation/meson.build b/Documentation/meson.build
> index 41f43e0336..64f70ac724 100644
> --- a/Documentation/meson.build
> +++ b/Documentation/meson.build
> @@ -172,6 +172,7 @@ manpages = {
>    'gitformat-chunk.adoc' : 5,
>    'gitformat-commit-graph.adoc' : 5,
>    'gitformat-index.adoc' : 5,
> +  'gitformat-loose.adoc' : 5,
>    'gitformat-pack.adoc' : 5,
>    'gitformat-signature.adoc' : 5,
>    'githooks.adoc' : 5,

