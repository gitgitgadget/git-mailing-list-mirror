Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC423218AAB
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 23:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736551977; cv=none; b=cU5x/4V5wDVljTnuyfOOXUZtBJDKt191ONZmJ5VYjGhJg85smGPonrKPcEdKfMIDnW+ZJ6DOXVndbV1vePDEaL6tcgvKA1IW1mKwg5SY1sipeHAwIMSmaWyK8reCcRdvqv2LHlhs36lIXVEABTIceW36tDn/STgFv8H6+IS6Huo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736551977; c=relaxed/simple;
	bh=baYVeihHH6GqrXuhAVKb8dAaLUSdEWrHWkAExI4l1qU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SWKAqbVQd+tNnCKzhHX1sWViqiJamy6MU/U28OhhoJKAxG9H0BBp+uBSSYp0Uk7896780jG+sIdUxabJKr2c5qIRY/bV89g9OXOhdz1YUfMLdygmZSzEPoed21jQPNZF3uDisc34lh08V5QHCoWPM/IbSsflHIdP9MVyE9cgBwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vSlR+VX/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xTt3N/96; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vSlR+VX/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xTt3N/96"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id CA61011400BB;
	Fri, 10 Jan 2025 18:32:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 10 Jan 2025 18:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736551973; x=1736638373; bh=+JPyl8c+Mi
	bcC2JUJ7I8bmEiy/JcSe8Zl1O3Kul+97M=; b=vSlR+VX/ziSNrAyayjiPxgl8UG
	BnuEs/SLFtfRyFkMvydDiwKoISu+TkxiFviTI5nA3MFBjw05wbH05hpMymvtJPTc
	Iqn6bnP9rz1xHoRaLg3f6ioFrkT3FxGOakGWrUH72mqIBL4kJaf9AT77ctGPVY21
	Vjix/4u71zpeWlOllAhRxo7HFcc9OBCg7D2X8GB5MG8dx8eXEN0Y1ZoM5sppLfEh
	AfdKHusNIcoNqKlxEO+XSv/9nq0KOaGbAHj9CjUIQVAqxAUzswl9X3Q0aaqa/pvd
	sWAbGibygnalF83WbC46KkulCRTzNNUIlUX/l85D9O4yhtUhxlvmVye3+P9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736551973; x=1736638373; bh=+JPyl8c+MibcC2JUJ7I8bmEiy/JcSe8Zl1O
	3Kul+97M=; b=xTt3N/96y+UihOeWei7HFxc5RlNavi9GarK6Fgp5XAxD/6ZWK2w
	8HWfkkc+zApzBQ8Rc6msZXndOpjJqIXmnayEmxKEnd5s3mksp+5TL3zX/oO8R0Xn
	+DayVTAoAIKZfS1cpZU37wr/2SRnD0oBnbbWr45ZkQqDCVaYeH+aA0pdOUVaB91y
	NfVlsIUG9I5tcBB+lEwqrXUcoqlu7M02F+jRecH63fd1dUK+drlnZbyXbjzgkHFf
	tVUJDup393tFASpd/8m18TC9R28NMMdwbjX9LPHH1P6NwAlbCCQmK/26Tk5BMUkY
	Vgb1pYE0ACXA7X2AiQsZgjhvZdT7/AmnQog==
X-ME-Sender: <xms:Ja6BZxd4CWs05KGrFL-ySUbocH_T4MMRLeA_noRyb8FMh8N4AVnsog>
    <xme:Ja6BZ_PnFgQ1_j0eUldwWW65sExFBavn9z8ptjuMTnsIGUT3Jngdws7fF61V0MC3u
    SNLqk5OliRi_OolaQ>
X-ME-Received: <xmr:Ja6BZ6hsideqCHpCzUJtp_jIvHHNae5YPJvMBZKrdv1GnNFlZ3lYzEy7j6K-DcZcsjxRoDR5J9x1b8tsmDtCFBp_s_1wNlbL7P2R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegledgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvggtshhksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrrhhtihdriihirhhksehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Ja6BZ6-f5Vzb3ZZjU0E6Hqcy2BLZpc8gnrKjhxN4SZJOgI3rV3pq_w>
    <xmx:Ja6BZ9v70w4ZFKH3RTHvmIUgSUXZgzNMfh1IX8jAnMhvc845gBzrEQ>
    <xmx:Ja6BZ5GaU13VrWQ3Befn7yUC6n72RPD9QOm79b5OSHaoWGVwUzvHOQ>
    <xmx:Ja6BZ0OnwIdzmokPbVSltMzhsN6rHb1RGLqwyynvBurDAmEmjfe67w>
    <xmx:Ja6BZ3K7WEZz8sIuf_BmtQr77rhGOLhsvcGhcz_gkajezM9VTVue2Gt2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 18:32:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Alecs King <alecsk@gmail.com>
Cc: git@vger.kernel.org,  Arti Zirk <arti.zirk@gmail.com>
Subject: Re: [PATCH] instaweb: fix ip binding for the python http.server
In-Reply-To: <20250110101346.30416-1-alecsk@gmail.com> (Alecs King's message
	of "Fri, 10 Jan 2025 18:13:46 +0800")
References: <20250110101346.30416-1-alecsk@gmail.com>
Date: Fri, 10 Jan 2025 15:32:51 -0800
Message-ID: <xmqq5xmm5joc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alecs King <alecsk@gmail.com> writes:

> `git instaweb -d python` should bind the server to 0.0.0.0
> `git instaweb -d python -l` should bind the server to 127.0.0.1

That is a correct statement of the fact.  What makes this patch
worthwhile is that the current code gets it the other way around
since its inception at 2eb14bb2 (git-instaweb: add Python builtin
http.server support, 2019-01-28).

Well spotted.

There seem to be some backends that simply ignore the "--local"
option.  Should they be somehow "fixed" (or at least making it a
documented bug)?  It is not within the scope of this patch, but
since the script has our attention...

Thanks, will queue.

>
> Signed-off-by: Alecs King <alecsk@gmail.com>
> ---
>  git-instaweb.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index 5ad50160bb..7b44f70789 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -694,9 +694,9 @@ class GitWebRequestHandler(CGIHTTPRequestHandler):
>  		return result
>  
>  
> -bind = "127.0.0.1"
> +bind = "0.0.0.0"
>  if "$local" == "true":
> -	bind = "0.0.0.0"
> +	bind = "127.0.0.1"
>  
>  # Set our http root directory
>  # This is a work around for a missing directory argument in older Python versions
