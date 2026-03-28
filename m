Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D42776026
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774718986; cv=none; b=QFjsmkuFVpGVgBFGx4vH3pgR48FTmzv5PNZkSTaY5K6OyjbdyaV/zd33BEplQKpoIz90dRAocgMCrkMLc8WsCr4rCDeF6LdmQjUYmtFp7LAHfinrEO5OCo3JciCpBwa3zSHRr50pqUOZ5ciJSeHi5ZMaAFnmKucPgeAwi5iXHUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774718986; c=relaxed/simple;
	bh=NXU0+wGR5pcuwPPlLnNiEvkH70EkzIBY1An5n2OjdiQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=N2adMTKKUcb9GNq1I4JGGFznvFhueFMTCFTDAOF4VenhrHod0+NztIONrnS6QypVCIkBGJ6uYdlFZ39RIpwO1kBtlW4NCi0C/GK5lY5Ry/gF/dNUqJlLICETBfk+Ua/sNXoI4+Rf/60WZRfz5hZKmAZwccxkSnFkPkrzF8nw/6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WuZgq8D0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=niYjIPD4; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WuZgq8D0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="niYjIPD4"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id E87561D0007E;
	Sat, 28 Mar 2026 13:29:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Sat, 28 Mar 2026 13:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774718983; x=1774805383; bh=5q9GiRzE7j
	bkQCSW0JvOUb60/TvzvadkIdeT0PvMr+A=; b=WuZgq8D00gxXJaV8VL5oGVg2l9
	WxXb1PeC+lVcqJpLdPeoIyZASMj4IqLQWZ05pv7N/L1+f2qSLa154H0hLNlj+gqi
	pbDPK42/YORzo5se59CrbmFssdkOQr9lmBHgqgZUO4TxqgV29+8cSM5FQEVuIzE7
	gTmOyd0X0VtFRoEhR61r1GXyBC4q2Te0rprWdvl6qrAfZAeb3TMQaPkFDLxSE5Mv
	CIlDoWJnoB416NyyAyzWWBlLA51/Xz6ZTTxyfgLnZ0HnUBcPU43pkl6IU25MRTQ2
	uZnX73sCCDNBo30F7u6mhHXnejjAJ0SKY8TcZKQpIQYu0NNUhBZDKAnT7onw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774718983; x=1774805383; bh=5q9GiRzE7jbkQCSW0JvOUb60/TvzvadkIde
	T0PvMr+A=; b=niYjIPD4vS6QyvMaRagw4Aefe5GMK7iHdVJY+1ucK6VsM8RNYXt
	4ZAnKvsyHwLtcllGPH0Hn85nBFy2p/chiLeNHJfY1Qt/sEKLabg0Yh523iZwAhZH
	O5NRzKUeV4M2PujswMbCzbSvwMWlg94tfwS37+ihR8smjkJjMG/gPw1oAi4nBi86
	y6kVEx/h8NYwOAMUiIGbJruILSSyOGvsFCiU8xtpF7a3zm1VX5InrLHKL56LGtpQ
	YirPylBE/4vaDEJaLfpXJWqzs/XDOIj54KUH6wqxlPHfhsCpdsVlJpWUEitqA5II
	mhq4sn7IUdp+jcCHuVyoEm4I3GtoKfLG5nA==
X-ME-Sender: <xms:BxDIaeyiyCyV42eM1YbdpsgsUcnz1E1Zppuf8Eh1Iu8TfDj0gWuRAQ>
    <xme:BxDIaRJNikgPpzK-wOs1j_SkcbL2M0DbuuTOZpwon8MghOU38rVYWphPHtzRzarD3
    TWlohASmgL5wFoP38ykc2a4tLqvgbiZOLHYrO-3wJ8rGsqJ6Fitmw>
X-ME-Received: <xmr:BxDIaYqPy2_uUn0tK7lvvU6jwgdshfC1ip8e-9OPmoetvLHCNuaR5o6unLo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeefjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufhffjgfkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteevteehgfevhfdthfduhfetgeefjeekhfelleetueevuedttddthfdvieej
    teelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgvtghrohhsphhrvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BxDIaQJEewFMgNKUwMWYHWEHBB9taEcA6HPFgYjOEQVoPWFxqFNatw>
    <xmx:BxDIadR9gwO3pFnjmJyH9LKpjHvELATuIMADRTfhiuCQfKsm9PgikA>
    <xmx:BxDIaftkdX3aqTfhIlTwmecGRjHfLiqWdeYABQ-3qwyOkR_WeWo_cg>
    <xmx:BxDIaebIUvuH4HPA0qjrNKYkFwYHKn1nCFWrL5ZG7DS2d1yferTQug>
    <xmx:BxDIabb8k6RmU9Rn58rZrO4ZMaK8ixTxMZscO9rQbnObFsCgjLpNBhyj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Mar 2026 13:29:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Noman <necrospre@gmail.com>
Cc: git@vger.kernel.org,  karthik nayak <karthik.188@gmail.com>,
  jltobler@gmail.com
Subject: Re: [GSoC][PATCH] doc: fix doubled words in gitdiffcore documentation
References: <CA+TqWtWiYR+aEsQPOsOwOonc2hinjfXW0oy5mLuDOPx4Xu9mwA@mail.gmail.com>
Date: Sat, 28 Mar 2026 10:29:39 -0700
In-Reply-To: <CA+TqWtWiYR+aEsQPOsOwOonc2hinjfXW0oy5mLuDOPx4Xu9mwA@mail.gmail.com>
	(Noman's message of "Sat, 28 Mar 2026 11:11:29 +0530")
Message-ID: <87bjg7g8vw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Noman <necrospre@gmail.com> writes:

> diff --git a/Documentation/gitdiffcore.adoc b/Documentation/gitdiffcore.adoc
> index 642c51227b..2b3fd5a259 100644
> --- a/Documentation/gitdiffcore.adoc
> +++ b/Documentation/gitdiffcore.adoc
> @@ -133,7 +133,7 @@ input contained these filepairs:
>  :000000 100644 0000000... 0123456... A file0
>  ------------------------------------------------
>
> -and the contents of the deleted file fileX is similar enough to
> +and the contents of the deleted file X is similar enough to
>  the contents of the created file file0, then rename detection
>  merges these filepairs and creates:

Please pay attention to the line just before the pre-context of the
above hunk, which says

    :100644 000000 0123456... 0000000... D fileX

and "the deleted file fileX" is a reference to it.

It indeed results in an awkward-sounding sentence, and I agree that
it would have been better if we used sample filenames that sounded
distinctly different from "file" 20 years ago when we wrote the
first edition of this document, but that water under the bridge has
poured out to the ocean long ago ;-)

In principle, I would not mind an update that consistently moves us
away from file0, file1, ... to something else both in examples and
explanations, but the cost of doing such a change and the cost of
reviewing such a change to make sure no unintended mistakes sneak
in, feels rather high, relative to the benefit.  So, I dunno.

> @@ -145,7 +145,7 @@ When the "-C" option is used, the original
> contents of modified files,
>  and deleted files (and also unmodified files, if the
>  "--find-copies-harder" option is used) are considered as candidates
>  of the source files in rename/copy operation.  If the input were like
> -these filepairs, that talk about a modified file fileY and a newly
> +these filepairs, that talk about a modified file Y and a newly
>  created file file0:
>
>  ------------------------------------------------
> --
> 2.45.1.windows.1
