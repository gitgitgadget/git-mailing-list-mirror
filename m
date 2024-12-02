Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F36171C9
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 01:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733104149; cv=none; b=E8XpKv2w4AEBUb7cNMnGA1bE6BuhHZ5SSdGeKtjvkhrBZSge5c4vUD92JkpmPkkeVNEfjAHFlr8fS9IXWtXyVRJM/oXP7s5IH7O6eMVXs+WM+BAOo1nNbme0VThVMg5TPl1b0ajk8k4g5FXRoFfum9xMnsVLhP5QFtZ1Mjm0CqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733104149; c=relaxed/simple;
	bh=czzu4orItV4nF9In+l1g7TzDsNIei84zFaZAjOVZYnc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=no4RszGaFCP5HyW2q5LgBYU75r93W/djM1DHXIPnvHhFWhRnIKfFhnwC+qtLtqVn71X9QcJGT9e59Xj5pKPGcTPIF0iTkca0kO935y6oUK5UuJsmu3k9trRQyRgfy54/EjElNOZFHDI77rj70Wv/Vdrv1GIzeCYIAN3nbDtDOJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ql96GEzh; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ql96GEzh"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E87092540103;
	Sun,  1 Dec 2024 20:49:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 01 Dec 2024 20:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733104145; x=
	1733190545; bh=oZIJMdk+4uhC0s3e9elPy/Kzk7vQtMfzOmRrIqTAj5Y=; b=Q
	l96GEzhwfAk/xLmIyQ+Yv0wAShAUWwn/kdEaFpWA2AHVWa7CYB+dDFjblpRDkMoF
	fTz1cFL7C4wbT4ay2UEAp4ZbHXdEqUZiUIOZgOLh8C101VP+O6Ry7R3Aqk1o3Xff
	y7L0GMSagWYRnCVzHtHwFejsycHo/e6SRMfBMHXP2EGqxqg9/R8ulj4Abzv1Ze32
	EW1EgUPOPgxCYcGb1VeUQUKS2jKXjwsODdRO/zi1RGUl3k8ItZ1YMVQV6xBDoftf
	Os/uLKjShtLmivM89/Iaj/5DmVclWVzRULuQZRDXUCbNeWTmGA/BYcGDoTUYv/BK
	IVMX3pMupMHO8OmA1/qxw==
X-ME-Sender: <xms:ERJNZwxJjS-1yssURNfiFSyF1MnOncAwELPcF1wizOiGdG0zo6qN2g>
    <xme:ERJNZ0T-zjW1BRgSO7rIGVgPKlec4f3KTuuFKTgLKk0BoKzQBhSWVc61Mle6z4isu
    vziRCu4OYUI5NWF0Q>
X-ME-Received: <xmr:ERJNZyWzozdPedMtMas1mtwf5UL2L5ZIsh8Gm7Poq9NryFr9NOcEO51p_moDDxeSn91D6rFlNaDwu9idWWdRc0HlQWzRGGi4WaHKzbU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheekgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhephfetvdejheduheegleehfeeivedtgeelfedv
    ffdtvedtudffieekieeijedvlefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehrjhhushhtohesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ERJNZ-jwpUSmETdP9WUkFvQ0DQ3-swKddH4qfeT4Fwj67fmXPJ7b2A>
    <xmx:ERJNZyDHO9OKQHIch7sahcNwlY-hFw4MMzjLZbr54VanqNsEO-mAmw>
    <xmx:ERJNZ_IkwXfGK5uMWobY7FDqHgZkFPv0U61jAg4fxsa84NofIaVx5Q>
    <xmx:ERJNZ5C4I-L0QL_wq5NIDNJPO_Th2BfWtdI4vUUtSwk055Fb1P62MA>
    <xmx:ERJNZ1_J_ccIRBCshS0B0yZSHoYovGC0WJRMPg2HEVNG5AWueN2EgSnm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Dec 2024 20:49:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] strvec: `strvec_splice()` to a statically initialized
 vector
In-Reply-To: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 29 Nov 2024 18:23:45 +0100")
References: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com>
Date: Mon, 02 Dec 2024 10:49:03 +0900
Message-ID: <xmqqiks2kg6o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Rubén Justo <rjusto@gmail.com> writes:

> Let's avoid an invalid pointer error in case a client of
> `strvec_splice()` ends up with something similar to:
>
>        struct strvec arr = STRVEC_INIT;
>        const char *rep[] = { "foo" };
>
>        strvec_splice(&arr, 0, 0, rep, ARRAY_SIZE(rep));

Well spotted, but the explanation can be a bit more helpful to
casual readers.  If there were a few paragraphs like below

    An empty strvec does not represent the array part of the
    structure with a NULL pointer, but with a singleton empty array,
    to help read-only applications.  This is similar to how an empty
    strbuf uses a singleton empty string.

    This approach requires us to be careful when adding elements to
    an empty instance.  The strvec_splice() API function we recently
    introduced however forgot to special case an empty strvec, and
    ended up applying realloc() to the singleton.
    
before your proposed commit log message, I wouldn't have needed to
go read the implementation of STRVEC_INIT to understand what the fix
is about.  From the fix by itself, it is a bit hard to see why
empty_strvec needs to be special cased, until you re-read the
implementation of STRVEC_INIT.

Thanks.

> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
>
> I've had some time to review the new iteration of the series where
> `strvec_splice()` was introduced and perhaps we want to consider cases
> where we end up using `strvec_splice()` with a statically initialized
> `struct strvec`, i.e:
>
>        struct strvec value = STRVEC_INIT;
>        int s = 0, e = 0;
>
>        ... nothing added to `value` and "s == e == 0" ...
>
>        const char *rep[] = { "foo" };
>        strvec_splice(&arr, s, e, rep, ARRAY_SIZE(rep));
>
>        ... realloc(): invalid pointer
>
> Sorry for getting back to this so late.  This slipped through in my
> review.
>
> I know the series is already in `next`.  To avoid adding noise to the
> series I'm not responding to the conversation, but here is a link to
> it:
>
>   https://lore.kernel.org/git/20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im/
>
>  strvec.c              | 10 ++++++----
>  t/unit-tests/strvec.c | 10 ++++++++++
>  2 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/strvec.c b/strvec.c
> index d1cf4e2496..64750e35e3 100644
> --- a/strvec.c
> +++ b/strvec.c
> @@ -61,16 +61,18 @@ void strvec_splice(struct strvec *array, size_t idx, size_t len,
>  {
>  	if (idx + len > array->nr)
>  		BUG("range outside of array boundary");
> -	if (replacement_len > len)
> +	if (replacement_len > len) {
> +		if (array->v == empty_strvec)
> +			array->v = NULL;
>  		ALLOC_GROW(array->v, array->nr + (replacement_len - len) + 1,
>  			   array->alloc);
> +	}
>  	for (size_t i = 0; i < len; i++)
>  		free((char *)array->v[idx + i]);
> -	if (replacement_len != len) {
> +	if ((replacement_len != len) && array->nr)
>  		memmove(array->v + idx + replacement_len, array->v + idx + len,
>  			(array->nr - idx - len + 1) * sizeof(char *));
> -		array->nr += (replacement_len - len);
> -	}
> +	array->nr += (replacement_len - len);
>  	for (size_t i = 0; i < replacement_len; i++)
>  		array->v[idx + i] = xstrdup(replacement[i]);
>  }
> diff --git a/t/unit-tests/strvec.c b/t/unit-tests/strvec.c
> index 855b602337..e66b7bbfae 100644
> --- a/t/unit-tests/strvec.c
> +++ b/t/unit-tests/strvec.c
> @@ -88,6 +88,16 @@ void test_strvec__pushv(void)
>  	strvec_clear(&vec);
>  }
>  
> +void test_strvec__splice_just_initialized_strvec(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	const char *replacement[] = { "foo" };
> +
> +	strvec_splice(&vec, 0, 0, replacement, ARRAY_SIZE(replacement));
> +	check_strvec(&vec, "foo", NULL);
> +	strvec_clear(&vec);
> +}
> +
>  void test_strvec__splice_with_same_size_replacement(void)
>  {
>  	struct strvec vec = STRVEC_INIT;
