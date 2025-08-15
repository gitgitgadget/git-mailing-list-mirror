Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E114221282
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 19:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755286621; cv=none; b=QVAugu+ajALG7TqWg9gm0vcTkD5bfd86MgEHfpkpmZqK7KjY28elZkgHeCiwPiPlHhAlVQvZntfZaW426B5uszcRw5BUgGsBJC012QUo0XVQUBPrAyJdugpEOl7/KYDsh5TwdNuDxbOPizaURnD1Fur/A/bxHWZH7lFTXI36XxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755286621; c=relaxed/simple;
	bh=y3SYsOic/G318gW6+Nadb2KHUTN7oOCJ4BDM82g0WPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dsc+Spe9bu1EJHW+ZnSOhj2BByOkg6zgb0aoxXsyclUqbXcpKd1YNxfuwqKZzouq77Q84LxLIABJqJ3RQHai0TRpQY65uhlI04ms5wGK7Rjuqd5Au7Rf9S9bqD5EnqHrpXQihvs3HumtJbgF2Um18hyv6wCWhD9IIppsshiYF6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MENuWmmH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Icwu9ymw; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MENuWmmH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Icwu9ymw"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8EFCD1400078;
	Fri, 15 Aug 2025 15:36:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 15 Aug 2025 15:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755286618; x=1755373018; bh=EMzgZAqtCW
	QXf/YuLhif3z0kxUf/xgjoc8toENFOP/M=; b=MENuWmmH6QNAK3EjlDMW5ISuWz
	mwEV8kAESghLRq+P5T1LU8S46GevdrJBUKq55Kz5AUK7oH/eUO7zlEn0Xnl9+rvk
	g5x/jYyH19kMDNmwZ9RlGIO4BcvwMHlV/rPIs1yHA4oQgK6rhDG80qdEOZARPG4Q
	yDJDBrO62mHEcSu6LGhB9Aioc+PdSeNq9B++5dr/KLFbnQ8P5gohxxpieHF26PLl
	SyN2hywEFwbu4vIMR+SLjpjtkt/9oMfpkgvdTynExShcHzAjzfpVL79Y2gglNzsB
	h3ulMJvd2f51rNh0sMg2yCJJruzklKB2rPZthpOnt1ZncPYTUkbpzABkzqaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755286618; x=1755373018; bh=EMzgZAqtCWQXf/YuLhif3z0kxUf/xgjoc8t
	oENFOP/M=; b=Icwu9ymw1OVbyo6W2yuE+JGXesqIMIrfjtlM9Y9OotAhUiGsw5Y
	pBic6bx7sO79Me1vIAxFCuSiLykgfDLazIqE0a5t5itkuVAsBUFSfRjckamhym0v
	RIJasUFeDijYldX3S2YTEgFAKuuWh6xydr30xAtWmSFDrBpOT03vPywUD76BBapP
	rpkMUOY0ULqRh/lvsbENiytCnd1w2IcuxFHBeIBRYLPYg0zhk/hBE8lmRR6pXDOa
	Ph8d8+kSHfRnrOEAcc6m/94kLIqxacjTimItwz7XpBKdBUutRflAnEh3fd5JssC/
	B6XRlGztEqF4QbByJWY5b1YdirDMMKqE+mQ==
X-ME-Sender: <xms:WYyfaFkCQyuwfc8Xd_D1JJsYoSJUV67PTMk1gGT0TWEqsuR5czuRag>
    <xme:WYyfaJc5_u6RqfVqKF0OVJ3jyMDYGqR-AbmIvIfyK0GqhwoZ5a_ycyTnWD9883YYa
    1_j3fwOFs45PJIJ0Q>
X-ME-Received: <xmr:WYyfaDECFSqga16OeCEnjXaReUGg0b2h3zLUm4c6r0sY9-D9lp645Vq12TNV1zI0vipCcFUjd5igGwmSNRJUH-NmA15_puI23UftQMM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjnh
    drrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:WYyfaPgP4R0lJ3dbaEZ00CgWkyugfHT1uEiQ9Awy3uDm3_4MHoY3ZA>
    <xmx:WYyfaH0H_nJwkiaHScl40FqazYvTQjqkFi-jxRhS6cvioLUTx1nVqg>
    <xmx:WYyfaKe3cEZYn2HJswfuVDSSQi-3Lx4GpjVByL5WkPKZVG2cTt5c4g>
    <xmx:WYyfaFx5oJXyOnW9YGGqBh4OyLa_1MqUdWx8NZ8W5UyyQjVXssqAeQ>
    <xmx:WoyfaNT97dePp4K3xqYoTmzN_ezaKikycc_43oKvPgGI7XzUKsirB7Fe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 15:36:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  oswald.buddenhagen@gmx.de,  ps@pks.im,
  karthik.188@gmail.com,  ben.knoble@gmail.com,
  phillip.wood@dunelm.org.uk,  jltobler@gmail.com,  jn.avila@free.fr,
  sunshine@sunshineco.com
Subject: Re: [GSoC PATCH v10 4/5] repo: add the field layout.shallow
In-Reply-To: <20250815135521.44044-5-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Fri, 15 Aug 2025 10:55:20 -0300")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250815135521.44044-1-lucasseikioshiro@gmail.com>
	<20250815135521.44044-5-lucasseikioshiro@gmail.com>
Date: Fri, 15 Aug 2025 12:36:55 -0700
Message-ID: <xmqqzfc0peaw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> @@ -41,6 +41,9 @@ values that they return:
>  `layout.bare`::
>  `true` if this is a bare repository, otherwise `false`.
>  
> +`layout.shallow`::
> +`true` if this is a shallow repository, otherwise `false`.
> +
>  `references.format`::
>  The reference storage format. The valid values are:
>  +

Common to all three patches that adds each of these three, but I
think we want to see these definition list like so:

	`layout.bare`::
		`true` if this is a bare...

	`layout.shallow`::
		'true` if this is a shallow...

	`reference.format`::
		The reference storage format.

It should not make any difference in the rendered result.  The
existing documentation pages follow this style because it makes the
layout of the text in the source file resemble the formatted output
more closely.

Also, I wonder if it makes the document structure (from the point of
view of mark-up) more apparent if we make the listing of two
possible values for the "--format=" option a nested definition list,
inside the definition list with a single element "info" in it.

Something like the following on top of your series, that is.

The first hunk does make the result rendered differently; the second
hunk should produce the identical rendition as your version.

Thanks.

 Documentation/git-repo.adoc | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git c/Documentation/git-repo.adoc w/Documentation/git-repo.adoc
index cb22f7ef65..5424deea69 100644
--- c/Documentation/git-repo.adoc
+++ w/Documentation/git-repo.adoc
@@ -29,15 +29,17 @@ requested.
 The output format can be chosen through the flag `--format`. Two formats are
 supported:
 +
-* `keyvalue`: output key-value pairs one per line using the `=` character as
-the delimiter between the key and the value. Values containing "unusual"
-characters are quoted as explained for the configuration variable
-`core.quotePath` (see linkgit:git-config[1]). This is the default.
+`keyvalue`;;
+	output key-value pairs one per line using the `=` character as
+	the delimiter between the key and the value. Values containing "unusual"
+	characters are quoted as explained for the configuration variable
+	`core.quotePath` (see linkgit:git-config[1]). This is the default.
 
-* `nul`: similar to `keyvalue`, but using a newline character as the delimiter
-between the key and the value and using a null character after each value.
-This format is better suited for being parsed by another applications than
-`keyvalue`. Unlike in the `keyvalue` format, the values are never quoted.
+`nul`;;
+	similar to `keyvalue`, but using a newline character as the delimiter
+	between the key and the value and using a null character after each value.
+	This format is better suited for being parsed by another applications than
+	`keyvalue`. Unlike in the `keyvalue` format, the values are never quoted.
 
 INFO KEYS
 ---------
@@ -46,13 +48,13 @@ the keys that identify them. Here's a list of the available keys and the
 values that they return:
 
 `layout.bare`::
-`true` if this is a bare repository, otherwise `false`.
+	`true` if this is a bare repository, otherwise `false`.
 
 `layout.shallow`::
-`true` if this is a shallow repository, otherwise `false`.
+	`true` if this is a shallow repository, otherwise `false`.
 
 `references.format`::
-The reference storage format. The valid values are:
+	The reference storage format. The valid values are:
 +
 include::ref-storage-format.adoc[]
 
