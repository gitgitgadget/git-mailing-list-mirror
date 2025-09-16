Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAFD2EAE3
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 05:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758000836; cv=none; b=NL4UZ4DG3B3LgLYTORsym/OhHLxb01lCDyrvgxZ0teeTgbLriN1dR/LQVG+TcuIfoMaTLrPSWd1IDdbauEjyISeLenmILVgzm6NMw11pPINmVazGfJM2Q28fPq+G0jbTv2RdYhO2GUJrL2x9bF5EabfZq8dksUjSP9k7F+8MeEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758000836; c=relaxed/simple;
	bh=2aJQ0CoGy3iQ9OUROKQPYD9nfyDx/YeT0S+KWSe5Jx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F9mtRSHxYHHhWmHS1W3ezvrq0ht2WRSWbmLRZUzAkB9p1QBPBtG01RGKLKKGgvi3T8AId1bWOotBfr+o/QkqbHDX4OJuHIGe+tFjeVby8B+pNaKqbIxrDg3snABhRo7vsrlTBFQXRHftOIwzc/C5zHusLW385lCmOpAEek/4gpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=viDZXlbj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bFUuC3S0; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="viDZXlbj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bFUuC3S0"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6DF9A7A01C6;
	Tue, 16 Sep 2025 01:33:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 16 Sep 2025 01:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758000833; x=1758087233; bh=BKRIM7dw2L
	8Ko2Sfeoi2cavLl7ncAFpl+U8FJTxy3NI=; b=viDZXlbjHAieKNPKN7h/S6/ioz
	EjTZowLvl/n/ndc9/0o5rfHUMlEEFq3OWgwgPVpb4KetBaYX4PgTVv5eCIbFFL5q
	U7aHeW7gkd1i63UD5q+2z7UalZZOWk25wJA6Dw2jMTd9JUck46sQxF839vxiNpDw
	ImViiJFSx9SJ+XGdXl7zE4PwCjp6y7SDTwTF7RpLBQR8jofMA4FhsCszfpbLNCqP
	+0wwms6OETbq9A1xRBUgmufwBtnAHbmU+Fc5CUEUvETX8Bgd+QAsuMSgS1i7tQ7Q
	RhJ5GocXkZV5+SYyV37IupOj5vyJn/tJojpVSRSDaiUOISc9kov5uOKWW9tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758000833; x=1758087233; bh=BKRIM7dw2L8Ko2Sfeoi2cavLl7ncAFpl+U8
	FJTxy3NI=; b=bFUuC3S0fCAzf6XkW6bjI5vi4mcH8lmfThWjVKntS7+j6qmxs31
	nomj5kJY1ZKhXboiTaGhVFXoyObHOp6FUUsMQ87/jnQkZg9f+HLuJAuDU3noA0hE
	VIBnRPsrSBSb5w6J6CnYtBH6w2lKwxFWJu8DpzNM2+fIk4hVbaOCk49/x4FZyWq7
	fXANEwBuIv1mgaCkZsVZNyTM/Ph1QXaFubrNYcxr0dJv5XriYefeBkxzgCwz2SMJ
	dqFhT0wbfO8e9NKayX3vRMLPQT/iUXyJf6QRGLOKWJDBDPjOfDruRfwwaoNYOZQc
	s70nk64vjMpvMIKDccU64mTufYKzLPsHx+A==
X-ME-Sender: <xms:wfbIaLKyfykVcArs5-9ofMNbs2aKqQIHL4l8CXBNnVah8R0TgQGL0g>
    <xme:wfbIaHlcxsYrX2vQGfhcbawsSSb4m6lF7MuLeBkuWtBTtgdUAzRmd2ZHJ9la8VnEm
    GswKQfuQ4teL89BGg>
X-ME-Received: <xmr:wfbIaEKFA-se3ccNGabLdcOaC7Meky5AQ8VEZTNnB07LFx0BrlHU9qLmAV_BwJKdfAZVq8ow5GHGn9UGSiHYwuKt0CcUyOmJ0PLYf-o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefleejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffieetueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieej
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomhdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wfbIaE7YhrVbzRk7SbCN5MolQat9sZkaXQgUo42Z4dvYKoqvNKwFZA>
    <xmx:wfbIaA1M2AvBCVsWPLEFTJAFqpH66Z-vSAcaNfVO8yqajz_i8eND2A>
    <xmx:wfbIaCeGcM8CP6iiN09dxkWNDbB39Lw9GMm3yEI0QQTW-QXTZhUdTA>
    <xmx:wfbIaOcsMujlvFCXRJ57vW4ypF0AokJnYpSunL18O8-h3RqY5A31XQ>
    <xmx:wfbIaHvy-jMDY4IqP0wiLZsVsbwejqrrbcUjXsBn58iG6cYd9izCLilJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 01:33:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v2 2/4] doc: add an UPSTREAM BRANCHES section to
 pull/push/fetch
In-Reply-To: <xmqqzfavarz4.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	15 Sep 2025 22:25:51 -0700")
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
	<pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
	<0ec629d4037bf5d1ccc248ca1bbd87ccc08119a3.1757703309.git.gitgitgadget@gmail.com>
	<xmqqzfavarz4.fsf@gitster.g>
Date: Mon, 15 Sep 2025 22:33:51 -0700
Message-ID: <xmqqqzw7arls.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> +```
>> +[branch "main"]
>> +   remote = origin
>> +   merge = refs/heads/main
>> +```
>
> When running with AsciiDoc, this makes the build fail with
>
>         ASCIIDOC git-fetch.html
>     asciidoc: ERROR: urls-remotes-upstreams.adoc: line 111: illegal style name: branch "main"
>     gmake: *** [Makefile:356: git-fetch.html] Error 1
>
> The line #111 is the one that has [branch "main"] on it.
>
> Curiously, USE_ASCIIDOCTOR=YesPlease would not suffer from the
> issue.
>
> cf. https://github.com/git/git/actions/runs/17743739238/job/50423820029#step:4:1395

For now I'd locally patch it with the attached, which does not seem
to change the output at all when formatted with Asciidoctor, and
does not break the build when AsciiDoctor is used.

Thanks.

diff --git a/Documentation/urls-remotes-upstreams.adoc b/Documentation/urls-remotes-upstreams.adoc
index 1e9c56dc5f..f40db15b20 100644
--- a/Documentation/urls-remotes-upstreams.adoc
+++ b/Documentation/urls-remotes-upstreams.adoc
@@ -107,11 +107,9 @@ Git defaults to using the upstream branch for remote operations, for example:
 The upstream is stored in `.git/config`, in the "remote" and "merge"
 fields. For example, if `main`'s upstream is `origin/main`:
 
-```
-[branch "main"]
-   remote = origin
-   merge = refs/heads/main
-```
+	[branch "main"]
+	   remote = origin
+	   merge = refs/heads/main
 
 You can set an upstream branch explicitly with
 `git push --set-upstream <remote> <branch>` or `git branch --track`,


