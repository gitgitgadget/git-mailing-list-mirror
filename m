Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5577C3B19AA
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 22:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790288434; cv=none; b=NkOt2D4iuv+tWV6E5WB8cvgtBG76hG6NwvOTUUt0aa8M/9OcfflqL7hQuKm8WMGqN4giw2UbYGeayd8A9gJyOea/sQxUJp18zXxw60dk8XTFTpQClpvuY4gjdO0F4L5ySaCO3KD0XIZGvDMq0szeOiScdcoX7xTBdUDPEas60D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790288434; c=relaxed/simple;
	bh=m1IZf8p31c2ae3zjGu7ENzCpeO2kIDmYDTkYwKOz84E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q3fqyXUcK8T4CDYgcIoXGvpvAbMEbLK5useHXY+Z6QfJAFyaSfj7ENlbnWCRC5h/rb6Bsoe6ifP7xoZ4skVRpwMaYWRu8sKChpTqIDBzoWQ7ySpLGBZofu2QUJxrVKugn9aFuPwCvqUW5WET9klYIgVdXJaQkASIofUqakUTsxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DsBTaeDK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J7feJW+u; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DsBTaeDK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J7feJW+u"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6AC1CEC00C5;
	Thu, 24 Sep 2026 18:20:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 24 Sep 2026 18:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790288432; x=1790374832; bh=6l+LmjdnAe
	IZxVBPIncNHLOTtGfaZLYHUDKcx78HCOI=; b=DsBTaeDKaSQKgWGFLL4+31NxCt
	365uEw4Mjqa+IXuZ/S1HN+ya6PtHmJYqD0cMp0WvdV0XadyjMxYylnKgv1kMLehl
	VQ/ey8YxzTATtNykpViobm4dk/jU1ApaARUyYatawEcJaWewmtJ0AfQWXpIp2C7p
	ha4WaeNvt6ffgVBuxKZyBB5reGz4CkZbEngWbmMzYQ4HpcbgD1xJT+YXfCSla04B
	AZhZVH58PdStxwBKYJqgwdkOgM5MXbdsg6Nzh6TLkBNE8Igu2eBL4MaG3RJV2YKX
	DPgI5bBlrnpUG/mua1YZwbR29rOnYrtxW8IZqB9cNY+Kk0eR+l7tnv+D8BYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790288432; x=1790374832; bh=6l+LmjdnAeIZxVBPIncNHLOTtGfaZLYHUDK
	cx78HCOI=; b=J7feJW+u5Bd2YqGVBDGNxFuW3zKfJb7etTZpql15V+9p+IlpCel
	kzP0xq4WJdc3hW9U11KtQeFm6C0vLCzZPdX7wpy9F4Gm2kuwGcWUQj0URMNmnp4X
	VPefeQH82P9XNoel3d0oUKZUnoYr6iEkkKhzQZSFJdH3ftcNYhW+J19pxfpUqSUH
	uWtoTsILhMaZaIw9VPgtKfBF3W9DiBYbX1AAiI43uViriDrbczN1es3kzr7A0SVC
	ibhjyX6d1C9hGjblBE5TkR7nBOVpaoTPmFA0XmuVBKAzVA9Xn88+vRfeI7KZ7mYj
	Wp1+0zcXhZrk77TJdffHgL+Gb7rXy2hYZZA==
X-ME-Sender: <xms:MKK1agd3byQnr9SyfWC35I9sm-FoI_3V_qT2mMuRNCA01d-7gbZjIQ>
    <xme:MKK1apHeBpA7t0V9O8Rx2Y6I-3fZofhI-4DwR5b698QKH4STRmHFCzxxDdmk8N96E
    1Sz-XiKODvNruAZ2ZTiSXctkclxOBj5KMlWMCOqfxeBEMIeEus5uLzt>
X-ME-Received: <xmr:MKK1ap2coQ1fh6p28XtZMOcJ7HqBn24X5ho0tReaBZAVBDuZ1yx-x7LLqU-EHgzMtomaeNLp2XzOFj6Z7Mwdhr2de7qnM0sjUNXL>
X-ME-Proxy-Cause: dmFkZTGPK0LIi6xX0GYiUUku0ALwo4ax6o2LV1f1t+d8O9zJYequwvILX4T0c1mCWvfqsW
    jlc/1V9Gm0pLu5WNB+YSOeWL9mKxGVDYxE7UOAaOeLe6ZMVzU7pYg40zHIEowX46WeafXq
    9pyi363/v8vLa/6NVEA9cR//uuLgcUa9l09kZahKwuN97IlTO8xZ5k/Bpo3TOZu3Enn9qd
    4XehNfDKbMOa3W5ZBCGOysJDli/RCgJiW1M74jwB76xAIWGub3ieTX8NUcWw49E0y9AsCK
    9xFQdGuQ0dekgoaeo+xNTint1ezO4/AClEf/cITA/FaTmnxsBuoI3KSY/FAxKEm0YboyRp
    uPkWKkaTbhlMgEIybb8207WPhdgu9d1mgN3e0fjJUP5pdTsbW2dqbhs6FWMEUegAax+Z8v
    EUYjWUdHBQB4C/tcWLYD7c6F2QkxsN5PhpBblSa4FBZg3IngTkYPR95AFAHqfaPduLUe+q
    z9U/PnFYQJS0IPvrqeRZHoBFSY6WU1yxYDP7Id9qSDC58bWDtcLFblzK0LTrEfEngQf+ks
    EbwN5XOdl0aI5Yskk6sKEq/iRUuHRrKzs/gNx6iGmlrkgrN3kpa/FSSXd1wB/33gSZjaeO
    jqhLeYh6GzUWSvXABSxKZCpFEfj8CRAtX1I3iOMnRn5cFFxTpqwPIi3yXpig
X-ME-Proxy: <xmx:MKK1ahnn4QwC4clMd4CXnDq7qyWQTkvhftRH4wKS8aJHR3iWxt9u8w>
    <xmx:MKK1ap-Y8V9Uo3Uvpf_-w4nU5611qtuGnW8VYTVJYcCfxnRGUP9kcA>
    <xmx:MKK1amovjYHljTgAio6CecbzZ6SYem6LsopziH3lcdzWMuHa7M8ceA>
    <xmx:MKK1aim0p_m2CYT76f0rCbEm7QgnAsjgQiT5pAVn4H0PrVoZV4nYOQ>
    <xmx:MKK1ao3CBRZV6gkEPl5yvrYCtQ5InWVH_GuwGmzTmFl3mNHE-N5ndWbn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 18:20:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 0/7] [doc] Add new page on merge conflicts
In-Reply-To: <pull.2237.git.1790261062.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Thu, 24 Sep 2026 14:44:15 +0000")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
Date: Thu, 24 Sep 2026 15:20:30 -0700
Message-ID: <xmqq33uyz3yp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Julia Evans (7):
>   [doc] Add new gitmergeconflicts man page
>   [doc] git-merge: link to new merge conflicts guide
>   [doc] git-rebase: link to new merge conflicts guide
>   [doc] git-revert: link to new merge conflicts guide
>   [doc] git-cherry-pick: link to new merge conflicts guide
>   [doc] git-pull: link to new merge conflicts guide
>   [doc] ignore conflict markers in gitmergeconflicts.adoc

With this merged, 'seen' seems to fail

	$ make check-docs

with these lines at the end

            ...
            MKDIR -p .build/lint-docs/doc-style/includes
            LINT DOCSTYLE includes/cmd-config-section-all.adoc
            LINT DOCSTYLE includes/cmd-config-section-rest.adoc
            GEN lint-docs-manpages
        no link: gitmergeconflicts

Thanks.
