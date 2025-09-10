Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BB41E9915
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757528480; cv=none; b=lcsuespDfNkbTZRlMHESSHIiT4h8PBCPgClCyowBacC8MVySVaTRMHx2Y71AOgv87rskaDbkt8vag8pY3cfKT+2YFjqrn9CRS6gQe+AHeHhn2BeXxvdqlzZH0WBK+296gA3+Ck6SkLFE8CmHu6dY/ecpjEUqJf9CUJFQ2GgrKiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757528480; c=relaxed/simple;
	bh=5ZpEHlqXYB5FlD3gKTZpCnaPuZtmoPDUQOirMMih4Lw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=flOokOK+k9buQ+o8rzD7FrVOIMZFWAVnzDktfdy01034sXNw2E2GZjQfjrYgjU5JBhNP9aN0nt/Y4kFCdMAj1cOFRiHU52mpXJNDQtmPVz+dJAl35Ax7YTmgrRfNcaTi3zsDyRzdU/gvc6VE/US//tif05yzS86Zlj9xknh0OfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gyJiHbOH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E784ubB6; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gyJiHbOH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E784ubB6"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6CC69EC0179;
	Wed, 10 Sep 2025 14:21:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 10 Sep 2025 14:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757528474; x=1757614874; bh=aq3TJ7mkMx
	GnRuqQwbTJCES1JVUHRuWwku84iam+3+o=; b=gyJiHbOHBcwAtRkqSFJZ1NMiO8
	4WG2n6JUOtmlNoiUh/8js5cGfcAcxdlNCwOyyXjgct23SxlvjOO600P/iPgACjSJ
	lSaqaBdcueboHr7P9iQ+LPXAQ+KQzXq6Ntt6nDoM9AlnhJnKxuXpqFLZLUfKGpmX
	hagMutN5tAflcTf98jtcGjRPJfO0AIiJIPc82cSmytW7ikhkDXbVC9gOfnJNFoUz
	+SHdcchwa0igk9nKalZSnOUgnm7Qf7q6qdpvsmPpHBPxkDbXRBgP6RHieZ+WnC7c
	q36WYv+4A5dsCmWr4vuRGu0mQ3rYaUvYiZ3MxqFJOM93QxsyOxYxSa9TtkWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757528474; x=1757614874; bh=aq3TJ7mkMxGnRuqQwbTJCES1JVUHRuWwku8
	4iam+3+o=; b=E784ubB6E3yCxZDV9wmz+zPLVTOtI40PdmMarzF1I311fDH3beE
	2wwChiTJtfaSpWuOxX110xIy+RwNJVBR21zk+vZzuQJG7+HJcrA4Ij77juyE6VRH
	GfOdyINXc9DuXVTjz8gXWnHKpv2I7P6h0sSpNGPMeyyZnMqF2lxE4HK9vfKlLY0Q
	DZdzIjBXnmcD1v71rdus7GlFvkOaSrlWhsqa6VqUFTAfmeYyhfTl4d5CNTGl5xUx
	aaa/zbKVMBC31xofm5uMylEj01wyvetvRHCBr3aygvVBn9J1dkNH444nsfVWUHYd
	gYp3ZadaJI/4Bf41c4+ES9WXccUBhiZq84g==
X-ME-Sender: <xms:mcHBaEBEEPwWN--B17nPyzF2uXYzh87yOY0pgStjbsjKmK7xjpc4QA>
    <xme:mcHBaDZkXOKgvqdwdbh5V1vlKPVzhAMLmZBOdpfAJwgqJXZdoCS0wN2b-11ar33Ji
    rqc1T-ddpdhr0NcPg>
X-ME-Received: <xmr:mcHBaHXks6Yg1pv9wy7DFaFUFsiEXQb6-H779QbQZjJsx6ZH7W4adOD9XsE8QEF5jw8aF4q-JCmm-wsvY6WSpNkxy8ThFrs69JXNBNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghhrhhi
    shgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mcHBaKOTNS3QpmyDE8cSgez2lTPXuG0VGZa7j8jC_i7LlEEWLtXEmw>
    <xmx:mcHBaJYEWuiXExgHoVRiS2CuBCFYkXZ-pXDZ18XnOJzxO_wEa5grGg>
    <xmx:mcHBaB-0weWhfnVMknU6VZkXXBzsyPACacyGbwgNBFfJKhVbLzKvlg>
    <xmx:mcHBaCRyrUFLE9zNJwlD8lveyfPGAGBgZuJZGvrc94KUuwr2kjC4Fg>
    <xmx:msHBaI19u7_-HVJQERP4w9LiVbWWXQKC4AJ1wDb934QuTmLb1zqodNYE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 14:21:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] fast-import: add '--signed-commits=<mode>' option
In-Reply-To: <20250910080839.2142651-3-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 10 Sep 2025 10:08:39 +0200")
References: <20250910080839.2142651-1-christian.couder@gmail.com>
	<20250910080839.2142651-3-christian.couder@gmail.com>
Date: Wed, 10 Sep 2025 11:21:11 -0700
Message-ID: <xmqqms72rwx4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> A '--signed-commits=<mode>' option is already available when using
> `git fast-export` to decide what should be done at export time about
> commit signatures. At import time though, there is no option, or
> other way, in `git fast-import` to decide about commit signatures.
>
> To remediate that, let's add a '--signed-commits=<mode>' option to
> `git fast-import` too.
>
> For now the supported <mode>s are the same as those supported by
> `git fast-export`.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-fast-import.adoc |   5 ++
>  builtin/fast-import.c              |  55 +++++++++++----
>  t/meson.build                      |   1 +
>  t/t9305-fast-import-signatures.sh  | 108 +++++++++++++++++++++++++++++
>  4 files changed, 157 insertions(+), 12 deletions(-)
>  create mode 100755 t/t9305-fast-import-signatures.sh
>
> diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
> index 3144ffcdb6..90f242d058 100644
> --- a/Documentation/git-fast-import.adoc
> +++ b/Documentation/git-fast-import.adoc
> @@ -66,6 +66,11 @@ OPTIONS
>  	remote-helpers that use the `import` capability, as they are
>  	already trusted to run their own code.
>  
> +--signed-commits=(verbatim|warn-verbatim|warn-strip|strip|abort)::
> +	Specify how to handle signed commits.  Behaves in the same way
> +	as the same option in linkgit:git-fast-export[1], except that
> +	default is 'verbatim' (instead of 'abort').

I forgot one thing.  Earlier in 1/2 we saw

    The definition of 'enum sign_mode' as well as its parsing code are in
    "builtin/fast-export.c". This was fine because `git fast-export` was the
    only command with '--signed-tags=<mode>' or '--signed-commits=<mode>'
    options.

    In a following commit, we are going to add such options to `git
    fast-import`, which will be simpler, easier and cleaner if we can reuse
    the 'enum sign_mode' defintion and parsing code.

and I was implicitly expecting that both commits and tags would be
supported on the import side, but this only deals with the commits?

Is patch [3/2] missing from the archive?

Thanks.
