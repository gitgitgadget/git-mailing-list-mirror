Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13612379EC6
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772477206; cv=none; b=WresztXhDS+zDeNg0FGzLisaGtVbHN+CkD69bN2R5+Wc9/9N54+RoBoGIQA5oIvnEevA7E1fCNrw4qPug5bPgDcsy2WwIDM/ULoAZj6oYZbtMR/J3cTwBuwfiXQ4PW+ENWMfuLi1Nyeimf9D6Gg3j5B8QWsmC6ZwztXVEiwLFOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772477206; c=relaxed/simple;
	bh=oYvLgNI5/zCinfBJyy7ByR4DyFKDzTabezvfPoYyqys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KlKaTUlZ5w0aBbw8PylAG5oHkzTD0yyv82xiJQ8eJv3FR9IL1d4Va4+sWpPUfHj3uIMo4gmb5SQG9qmegVnehBEKjRJvdZItkseTZTCVUcj0wSulJY5+xeyHplgDOAjbbJkimeTVovsN45xr9ml/qCyxQ24HQzTp8A6ECjqt0jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TfXFgHa8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y3vQj+k1; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TfXFgHa8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y3vQj+k1"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 440381400173;
	Mon,  2 Mar 2026 13:46:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 02 Mar 2026 13:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772477191; x=1772563591; bh=P2v/lLz7h4
	dnmFTkvxkTpCFi4+qtLMV+S09IXxp2iZg=; b=TfXFgHa848VyfucSk7Rh4cSKDP
	XxZjLSv+7bk9i4vDu0FaAHJVrvH1b6q+40jxVT2ERinek8ZAy9fxEA+KXO67wxgo
	dKgb3us0dvKkOAYDAeggjVaEWVhfEafqCq63JDcXTsi6vpovvRYA+Ym+AUgciN6D
	9YiLSyb5uP9Tds2vWdIktAgDjVqBkm2Lt5noo+mDSOJYEhSt5i1Vc+4tlUx4KKlA
	+tR9Y0VC2xYdDjFi22eTCKRnanz3P6mkwAxvrK+XjdZfMliNQXAz5vp9vWIJWBYX
	is3qrBUNtLcO4aXppw0vGV0id8L3fHuAnnD5Scj+/JQ7OiYGv+hYq09tHwNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772477191; x=1772563591; bh=P2v/lLz7h4dnmFTkvxkTpCFi4+qtLMV+S09
	IXxp2iZg=; b=Y3vQj+k1gTkt86AbPctzNU45+0xNsOJwYOhw+ho6OSbiTPwXCQ+
	DrIF2vFi7I2QiL8yY3Fldx9C+zGkaNbw4/GIXDHmSBbyFyTxPJnlENryyZ6vnzwF
	T8QCt0H1EEaWelWTUDeCrhIf9MTcdM3eJ/EBmG2l53M+t6+dkQ2ysx5/ThO1ru6t
	tAVuFQngiPYU0oQ9qnYrG85JHVbh3e1WM84PrwGtJYKbIUwnv1gra/uQYXh7Milk
	7SXd1nM9TQjm99pVJNAfL2n2ExGZOHZmeT+9jSQ1iUdgKCggI+KSVVbWhauRE7VP
	KdMt2Suijltlk4vdiMEUHrHLKKcajGOGtEw==
X-ME-Sender: <xms:B9ulaVeLOm0fkqRxNjrzxRv2WKW6XLakFDcII0YEo38hX2vX_PHsxw>
    <xme:B9ulaaFkfhwdX3g_TeFQAS5Rls2GLw5xLqeA9t357UWwJUnC2BosdcVq4700j8Vij
    L1uN_SZ1-JyoQYmSJRHUCl2Tds8cx09u0CQoMXpM6C9B8iQgQJnHw>
X-ME-Received: <xmr:B9ulaW0RuLUncCSj_PoKcLlqiDaN9tSnEEEkqZWuHUS2LpLfrwmyXtRFbPdnebUr4Nz5IN_mOQu3f5l9ZdpejmcTCZDNNffyMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhdrshhiugguhhgrrhhthhdrshhhrhhimhgrlhhise
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrlhhgohhnvghllhesghhmrghilhdrtghomhdprhgtphhtthhope
    hjvghffhhhohhsthesmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:B9ulaamDJNskhP7I0mPGm9JSt7K3ayK1hUjJCEyVjVJ8CNJjZMmZ8Q>
    <xmx:B9ulae-htz_4CqR0Q8TmXTxeIOivEqlCrXm6Q6hFsveR3m42LWLL2g>
    <xmx:B9ulaXoG_aqfjsbK085KbnqgWL856-fia6g5bDdrW1wurxPgVSTzvA>
    <xmx:B9ulafmlPjwXJDKxto7S4q3mc73Dr-T4TJrOYLoAXz2GizZTcKwa2g>
    <xmx:B9ulaeh-_yc1DbAOlPCHc6vqqheULh7nQ9lLWAq7tvfkBLNwwJudDAym>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:46:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  algonell@gmail.com,  jeffhost@microsoft.com
Subject: Re: [PATCH] t: fix "that that" typos in test comments
In-Reply-To: <20260302164521.79148-1-r.siddharth.shrimali@gmail.com>
	(Siddharth Shrimali's message of "Mon, 2 Mar 2026 22:15:21 +0530")
References: <20260302164521.79148-1-r.siddharth.shrimali@gmail.com>
Date: Mon, 02 Mar 2026 10:46:29 -0800
Message-ID: <xmqqfr6i133u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> diff --git a/t/lib-unicode-nfc-nfd.sh b/t/lib-unicode-nfc-nfd.sh
> index aed0a4dd44..201ab9b24c 100755
> --- a/t/lib-unicode-nfc-nfd.sh
> +++ b/t/lib-unicode-nfc-nfd.sh
> @@ -75,7 +75,7 @@ test_lazy_prereq UNICODE_NFD_PRESERVED '
>  #
>  # Note that I've used the canonical ordering of the
>  # combining characters.  It is also possible to
> -# swap them.  My testing shows that that non-standard
> +# swap them.  My testing shows that non-standard
>  # ordering also causes a collision in mkdir.  However,

While the original in this hunk clearly has unwanted "that" there
and removing it is unambiguously the single right thing to do here,
...

>  # As a sanity check, ask Perl to parse our generated JSON and recursively
> -# dump the resulting data in sorted order.  Confirm that that matches our
> +# dump the resulting data in sorted order.  Confirm that it matches our
>  # expectations.

... this does not fall into the same category, does it?  The
phrasing may be a bit awkward, but it is not factually or
gramatically wrong per-se.

I think the next one also falls into the same category as this one.
In fact, referring to that one arbitrary path chosen in the previous
step as "that arbitrary path" (i.e., the original) may convey the
intent more cleanly than the updated one "the arbitrary path".

> diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
> index ed20de8ea2..63de0fc6cb 100755
> --- a/t/t6416-recursive-corner-cases.sh
> +++ b/t/t6416-recursive-corner-cases.sh
> @@ -775,7 +775,7 @@ test_expect_failure 'merge of D2 & E4 merges a2s & reports conflict for a/file'
>  # it feels sound to say "B and C do not agree what the final pathname
>  # should be, but we know this content was derived from the common A:a so we
>  # use one path whose name is arbitrary in the virtual merge base X between
> -# D and E" and then further let the rename detection to notice that that
> +# D and E" and then further let the rename detection to notice that the
>  # arbitrary path gets renamed between X-D to "newname" and X-E also to
>  # "newname" to resolve it as both sides renaming it to the same new
>  # name. It is akin to what we do at the content level, i.e. "B and C do not
