Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1676B2066F7
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752008349; cv=none; b=pZS4lAqZiRwzimR7OkSQKPzwcMo09rSDIjYsVz+TzzeNRvn5Bx15FLzcGF7l5OUKtfARRpFxvvykjf1N8JRNRMYE4B3cBAJsoKuacUzDinGL6PUTD7YtQW7ClzVnIFLh4FPZdRn6M5DOh+W9vR6UdXvhuTXztYUts0OgXtn7ji0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752008349; c=relaxed/simple;
	bh=iZJREtchUOfACWcOwy9MD/Prq5RCA+41jMdniH5lHR8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=STSalYZ5jJFI5RxR5lEwnPkcKfaMfWIPwseisKDYkunZPu9oPmfyddVshJ2WAUozyMa/z2CXfBNkn+OaS/IUKZSzAZVUEXPcT5COUBn/sJCYqZiHtg7X5jbVTmAPowCa3MePRIjCoLkGDZFya6OFdLxfprLBsluAUIkEm8H6BKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MfD3XNSX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UhyD4ldr; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MfD3XNSX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UhyD4ldr"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 34E0B1400240;
	Tue,  8 Jul 2025 16:59:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 08 Jul 2025 16:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752008346; x=1752094746; bh=RRkLEkmLIE
	0SJKONHajgXcP+tgOy1Wq0Zxi9PXbZqXo=; b=MfD3XNSXjje+qPJKCPoKXMyi7b
	jYXURr3/2yzd3YEPuKKknJk7aRx14+EFhukpHVgFvMY4SS6XOdFxkbLk7WnmIwp4
	PmVrASgUz63NqyFpWNqXrB61nKLE4o177tveotKJMSGKqwf/XgdSOp5jX1IWRhyw
	alruA6w48n2AZ1ad8xkBP1Sqn9W1EXQetjJZ9Rp7teH+AEsN27ZHf2F8VVocpiEQ
	QOOQz5mj0C4IzgA7Fs/q49s7cZgDc7IuBpkXumyfCJsHDK+NYGiq2eeB3Fyh01Xo
	A4PpqflKXsKkWZy1WjqAfNCimOja02Ek9+Amf7BLnLNrwJyi8uy9n1ncp1iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752008346; x=1752094746; bh=RRkLEkmLIE0SJKONHajgXcP+tgOy1Wq0Zxi
	9PXbZqXo=; b=UhyD4ldrWEcYd7ifTiQdaMkYBDb39ekv86jQqBuiyEgUoDioOno
	kAjbKVDbNRtWW0dwKHX/LDVhcBuKzSbE1ygUZUxUyfDEVywV7deKCBRTFgYuzTXu
	HccPQw5B5a65Q9Q6TleT0CWGDgxxUtSTNEEduCK6OdjHuWBAe62jD+9MC5wNYs7/
	sl4Q+koD+sVIAWjqBx4w9A8K03W0MmrLoDcsBpG1OQsQ8pLkUOGUSxAPwUwGFu69
	IWriXvI47yG2aa3W6LUFs+WmG2mqGDs5j4AFrTWkhQtl9SpV48cSDA9ZADRILXuC
	D2ZWuEqpi8Q9+N3vRJapFpTA336VZRkefyg==
X-ME-Sender: <xms:moZtaEn4AqyZUOCumoXonhN1rYY_Bg_ad7tzcXiIn_4MM5kNEBVW3w>
    <xme:moZtaPXfs7zKNMwHhLVP7z-cB9uNtC9_A-u0oYgtGCfT85NgdIJVTtOm74RkHglI4
    SgO30ngiWXCo2LM5w>
X-ME-Received: <xmr:moZtaJGjSWU2JYL54kGBjuLCwY3T9nuluJaGiLC8Rwf8eDDUkdS4P5A80FCQaNBwQO8m4fdy5tfEVmX8l5MC693r1ODt7HdwO2845R8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefheejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:moZtaLenEAagDff-bT7U9f3HwOFUoZnCCKYEKmMb_UPQrhTVBddhvw>
    <xmx:moZtaKIsdt6BIfCdt-odKuIbhvxh00BUmTHJWH_GnFdBkMxriAu_HA>
    <xmx:moZtaAHV-9vNpZas6NNvo_MyEYTGzlSkMnNRe8UPtI2PQP6elzpLyg>
    <xmx:moZtaNDY9R3dhjrTK2-tLE7BDmnULVr3g6kHoeR2jcuxmPZ3JbdJzQ>
    <xmx:moZtaO0TwmkLwSKSKYi9KmonITqjj3IogCmz42WRd2GJs6LQoYKyQaXD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 16:59:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  newren@gmail.com,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/3] sparse-checkout: remove use of the_repository
In-Reply-To: <3cdc44a9e8c8e6718b24bc25def291348a0b2613.1751973594.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Tue, 08 Jul 2025
	11:19:51 +0000")
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
	<3cdc44a9e8c8e6718b24bc25def291348a0b2613.1751973594.git.gitgitgadget@gmail.com>
Date: Tue, 08 Jul 2025 13:59:04 -0700
Message-ID: <xmqqikk2tn53.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> The logic for the 'git sparse-checkout' builtin uses the_repository all
> over the place, despite some use of a repository struct in different
> method parameters. Complete this removal of the_repository by using
> 'repo' when possible.
>
> In one place, there was already a local variable 'r' that was set to
> the_repository, so move that to a method parameter.
>
> We cannot remove the USE_THE_REPOSITORY_VARIABLE declaration as we are
> still using global constants for the state of the sparse-checkout.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  builtin/sparse-checkout.c | 119 ++++++++++++++++++++------------------
>  1 file changed, 63 insertions(+), 56 deletions(-)

OK.  The damage is not too bad for a partial update ;-).

As the file-scope static functions in builtin/sparse-checkout.c are
not going to be called by anybody else, it does not really matter if
they internally pass an extra parameter around or use the_repository
since the end result is the same.  But doing this may hopefully help
those that may want to move some of these functions to a more
library-ish part of the system outside builtin/ hierarchy.

> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 1bf01591b275..8b70d0c6a441 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -204,12 +204,12 @@ static void clean_tracked_sparse_directories(struct repository *r)
>  		ensure_full_index(r->index);
>  }
>  
> -static int update_working_directory(struct pattern_list *pl)
> +static int update_working_directory(struct repository *r,
> +				    struct pattern_list *pl)
>  {
>  	enum update_sparsity_result result;
>  	struct unpack_trees_options o;
>  	struct lock_file lock_file = LOCK_INIT;
> -	struct repository *r = the_repository;
>  	struct pattern_list *old_pl;

As this already used short-and-sweet 'r', we just follow suit to
minimize the damage, which is fine.

> @@ -327,7 +327,8 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
>  	string_list_clear(&sl, 0);
>  }
>  
> -static int write_patterns_and_update(struct pattern_list *pl)
> +static int write_patterns_and_update(struct repository *repo,
> +				     struct pattern_list *pl)
>  {
>  	char *sparse_filename;
>  	FILE *fp;
> @@ -336,15 +337,15 @@ static int write_patterns_and_update(struct pattern_list *pl)
>  
>  	sparse_filename = get_sparse_checkout_filename();
>  
> -	if (safe_create_leading_directories(the_repository, sparse_filename))
> +	if (safe_create_leading_directories(repo, sparse_filename))
>  		die(_("failed to create directory for sparse-checkout file"));
>  
>  	hold_lock_file_for_update(&lk, sparse_filename, LOCK_DIE_ON_ERROR);
>  
> -	result = update_working_directory(pl);
> +	result = update_working_directory(repo, pl);
>  	if (result) {
>  		rollback_lock_file(&lk);
> -		update_working_directory(NULL);
> +		update_working_directory(repo, NULL);
>  		goto out;
>  	}

But this introduces a new parameter.  Both of two instances of
repository struct used in the existing code in this function, other
than references to struct repository *UNUSED, use "r", and with this
patch, the name "repo" becomes more prevanent.

We would probably want to rename "r" to "repo" for consistency in
clean_tracked_sparse_repositories() and update_working_directory(),
but that is better done later after the dust settles and the code
around here becomes quiescent again, not as part of this topic as an
extra churn.

Looking good.  Thanks.  Will queue.
