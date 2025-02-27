Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C5E1B4155
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 21:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740690936; cv=none; b=Ilwe3s0dLqQxMdFjI9hSTIMlc8RUraxiCxW1CZCd+WyrS+rMrlxFus4LmCLOD+zA3D5DA1YKkPvV0HL9gP8FV3MYo2Dg6zeNQM+oako93b+jdt7lKw4o2UsyHKvMJX5/hUYF2TI80jIhvaaSEk8yekldAkN2FbPUUlznZLO/n+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740690936; c=relaxed/simple;
	bh=okRnHEsotOu3cxdeBTUELHQe973fRyxBr5g9fKqjSHw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B0AMGCLe0Sa5rSLGhj8L48wCj+ChrFz8o/jW/vT6tPnwamJv9/Rr6jmNz+sTuf5A5FBo2jY0tQnzo8BIWOQ7qaK2K0zY/IwKbN6reL+LlpJ85SRPd4WN/iMPereg/fSZmt7NyfL5QG3hESCFxquczau0Io8cWAoucXSzn1JGtWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aSnd2Hwq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uf6fjBrK; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aSnd2Hwq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uf6fjBrK"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 933F42540170;
	Thu, 27 Feb 2025 16:15:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 27 Feb 2025 16:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740690933; x=1740777333; bh=5z2oIbVbOF
	kZUYMHt0qGEcoYh8hLuEljUI5IoBmfmOY=; b=aSnd2Hwq/6XH+xhYs9UhJqFaJh
	Jc9xkwSmL7HJ6AB32emk8nSYHBSZT7d3v3dfx0fI4zTRZ0pIwGrpcVbazFKJptQD
	ZJfQnhcb2HUmSwoVysgL2+T+gPgdMhRr7gjKF+McQZIcvhPTbpm+8a3AVOmWR8/J
	m3TiywKk94SaK7EUJ3WdVAqmw5q2D+uX0u0H3d4fdA3UYUKX/DGCw5Fq7xUKcfoL
	x7ADNHDxgqwLxPXRbU0QU4fwjJ3O7JU8oEAGwMCswDu69q66evOoMXQKe3kq22uq
	cYfIWPRkqvmxz/URZaB/7PO/nJQxy1yOs+UxnNQ88kwK9GOr+ez8t4AHNZYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740690933; x=1740777333; bh=5z2oIbVbOFkZUYMHt0qGEcoYh8hLuEljUI5
	IoBmfmOY=; b=uf6fjBrKskhHjpBavDyzXUS1zXO9wNoZ98P/eKlfecAxLaGMJ5e
	N8Li00BR7JELZmuIrFRqK4fLXANG5aAE/9DHQQzn63H11JbH8kyqRChkdXWeAd+W
	Qm1P6yQ3E0Km1RyyzRPGN3BlOHZVEAmN2NKMd270BoJyqzIYk3byubi/qGL9c6WE
	LOzqe/yEG3QmhEr4tgtljn0rySDRXHjYT8Lm2ViaJ1/nw6ZXIWb9j7/m23NPLpK5
	VlzH8Qt+LOPo+h1Zf3Dh+jG+4524g/BRJkCdJPe2a6HM7xPz1sGJMUIoYrhZOyyt
	5CwT/B63jLSdJrjEAqsxjIsDKfTByTU5owA==
X-ME-Sender: <xms:9dXAZ2u_dTGe78rRKOAkkLHIuvZBs9xQnJ9tbYEj-ARgfy15ymk0-Q>
    <xme:9dXAZ7e-tmFJMIrJHUdH6JR7A258wXQ69i0Kdk9bxBU5FnHrc8_AOCl8qV3saFH4H
    s66owRtmJHRKil_DA>
X-ME-Received: <xmr:9dXAZxz2O0Q0_sgq6S0Cql4iqq7NOwwsQupyyAWqzFoV7AuTM4Yworj6jVP83uzDGvxroNZBP96M9fa-DpIRikfdnjAeUJE8-CIh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9dXAZxNeWFvMbTv587SPQfJGlkFK7zvVhDTXeIcCOZ5OQb0nYitOUA>
    <xmx:9dXAZ2_k7Lhca6S4Ai8MvDG01xutu4GUZ0n2FYt0xvCNX0rcGMQETg>
    <xmx:9dXAZ5WZU-sWqDrotJKWvEOfhEoeMsEyPK76VzEXa6iWTINMLOnOoA>
    <xmx:9dXAZ_fTjYwpC3xKjjV6O6kcvEj6xnC0Qgw6ryBk2kysqetD_YvEtw>
    <xmx:9dXAZ6ZKk5XKTNWz90P9bjq_XCwtL4UjRgwgXNCl8XwGX94nStn0p706>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 16:15:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] ident: stop assuming that `gw_gecos` is writable
In-Reply-To: <045c11dc1d51690eed4dc07da26dcace612f786c.1740671049.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 27 Feb 2025
	15:44:08 +0000")
References: <pull.1867.git.1740671049.gitgitgadget@gmail.com>
	<045c11dc1d51690eed4dc07da26dcace612f786c.1740671049.git.gitgitgadget@gmail.com>
Date: Thu, 27 Feb 2025 13:15:31 -0800
Message-ID: <xmqqwmdb5bt8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 590e081dea7c (ident: add NO_GECOS_IN_PWENT for systems without
> pw_gecos in struct passwd, 2011-05-19), code was introduced to iterate
> over the `gw_gecos` field; The loop variable is of type `char *`, which
> assumes that `gw_gecos` is writable.
>
> However, it is not necessarily writable (and it is a bad idea to have it
> writable in the first place), so let's switch the loop variable type to
> `const char *`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  ident.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Can we have a bit more details here (not in the commit but after the
three-dash line, meant for context) why the change from 2011 needs a
"hotfix" today?  Has something in the build environment change?  An
updated header file has changed definition for "struct passwd", or
something silly like that?  Even though POSIX.1 does not define
gecos in its struct passwd in <pwd.h>, other string members like
pw_name and pw_dir are writable, which I found funny, and makes me
puzzled why this code from 2011 needs a hotfix all of the sudden.

> diff --git a/ident.c b/ident.c
> index caf41fb2a98..967895d8850 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -59,7 +59,7 @@ static struct passwd *xgetpwuid_self(int *is_bogus)
>  
>  static void copy_gecos(const struct passwd *w, struct strbuf *name)
>  {
> -	char *src;
> +	const char *src;
>  
>  	/* Traditionally GECOS field had office phone numbers etc, separated
>  	 * with commas.  Also & stands for capitalized form of the login name.

The patch text itself looks perfectly fine, so I am not opposed to
its eventual application.  Even though we do declare "src" as
non-const, we only use it to read from it, so declaring it as const
pointer is perfectly fine and more appropriate.

But I do not see any urgency relative to Git 2.48.0 (or Git 2.48.1
for that matter) to mark this as "hotfix" implying that it should be
included in 2.49-rc1 in either the patch or the proposed commit log
message.

Thanks.
