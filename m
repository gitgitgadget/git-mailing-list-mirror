Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AADC53E28
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711734967; cv=none; b=mpeRlDrT5Na316qPa1rRZvAeskM8Y8DPJhjCxMM+PXtxcSznfWU4xitCwCnVSkuUJq4MnXbDf/akrHgttiMoWNr+uqDqpIwfBMhIku0sH/beNIUOhT/9zzvjFiW/B0O30DFgmzzHG5fYgXIRrsxNki51lmbh+SGfVv/XWMvWqdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711734967; c=relaxed/simple;
	bh=CPWXQ2mgKj57K4GDSrp9CKpjlHqt3UcQxVB2tyjb9Dc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oDeyobsBMv7Is7kTdLSIDuuQ9CqQwqKJMPmCkNdlxIJsm8fqPrYwQ7/voEKKGjb9Lw9v1bICfV+yCw0fPxkILztXR7aoJOky068FjGckhA1nWPZCQq7TyBIMI3OLhaoceV5zp7Y410tUonFqu9WEC4djoBjrcjimHbqkcgqJdYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LHETx1b0; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LHETx1b0"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A5B2D3064E;
	Fri, 29 Mar 2024 13:56:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CPWXQ2mgKj57
	K4GDSrp9CKpjlHqt3UcQxVB2tyjb9Dc=; b=LHETx1b0K4Qzz4e/4xIjneEv2v0Y
	wyI7XJKD9BYQnVK5qM1CeiZxHXLxurZv961s9rMdf+dq8AkmrzJn5YhIvd4qlRJo
	3pE6anEOAkUvyP5oWB3XkHMOo0l5yVf5swYD4AO0JmDquLIdysibasMdyhQBASKF
	MO6YjLM1xznXsTs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E72F3064D;
	Fri, 29 Mar 2024 13:56:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 224F030646;
	Fri, 29 Mar 2024 13:55:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] add: use advise_if_enabled for
 ADVICE_ADD_EMBEDDED_REPO
In-Reply-To: <0e38da05-efd6-451e-bd8a-b2b3457c0c75@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 29 Mar 2024 05:19:43 +0100")
References: <06c9b422-b22e-4310-ad5b-1686616ab860@gmail.com>
	<0e38da05-efd6-451e-bd8a-b2b3457c0c75@gmail.com>
Date: Fri, 29 Mar 2024 10:55:56 -0700
Message-ID: <xmqqcyrczzv7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 98CF5FB4-EDF5-11EE-AE2D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Use the newer advise_if_enabled() machinery to show the advice.

Common to the other two patches, but "Newer" is not a good enough
excuse if the existing code is working well for us and not being
maintenance burden.  The previous two patches were helped by use of
advise_if_enabled() in a concrete way (or perhaps two ways), and
that should be explained when selling them.

This one also needs a similar justification, but with a twist.

> We don't have a test for this.  Add one.
>
> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>  builtin/add.c  |  6 +++---
>  t/t3700-add.sh | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 289adaaecf..e97699d6b9 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -310,9 +310,9 @@ static void check_embedded_repo(const char *path)
>  	strbuf_strip_suffix(&name, "/");
> =20
>  	warning(_("adding embedded git repository: %s"), name.buf);
> -	if (!adviced_on_embedded_repo &&
> -	    advice_enabled(ADVICE_ADD_EMBEDDED_REPO)) {
> -		advise(embedded_advice, name.buf, name.buf);
> +	if (!adviced_on_embedded_repo) {
> +		advise_if_enabled(ADVICE_ADD_EMBEDDED_REPO,
> +				  embedded_advice, name.buf, name.buf);
>  		adviced_on_embedded_repo =3D 1;
>  	}

This uses a static variable "adviced_on_embedded_repo" to skip
giving the advice messages over and over.  The patch preserves
that feature of this code while updating it to use the "if_enabled"
variant.

> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index 681081e0d5..2b92f3eb5b 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -349,6 +349,38 @@ test_expect_success '"git add ." in empty repo' '
>  	)
>  '
> =20
> +test_expect_success '"git add" a nested repository' '

"nested" -> "embedded", as the warning, advice_type and the message
contents all use "embedded" consistently.

> +	rm -fr empty &&
> +	git init empty &&
> +	(
> +		cd empty &&
> +		git init empty &&
> +		(
> +			cd empty &&
> +			git commit --allow-empty -m "foo"
> +		) &&
> +		git add empty 2>actual &&

It is very good to add a test for a feature that we failed to cover
so far.  But the feature, as we seen above, is twofold.  We see an
advice, and we it see only once even when we have multiple.

So we should add two such embedded repositories for the test, no?
Also, the shell repository is not meant to stay empty as the user
will make a mistaken attempt to "add" something to it.

Perhaps the above part would become more like:

	rm -rf outer && git init outer &&
	(
		cd outer &&
		for i in 1 2
		do
			name=3Dinner$i &&
			git init $name &&
                        git -C $name --allow-empty -m $name ||
				return 1
		done &&
                git add . 2>actual &&

to use a more descriptive name that shows the point of the test (it
is not interesting that they are empty---they are in "outer contains
innner repositories" relationship and that is what the test wants to
make), and ensure "only once" part of the feature we are testing.

> +		cat >expect <<-EOF &&
> +		warning: adding embedded git repository: empty
> +		hint: You${SQ}ve added another git repository inside your current re=
pository.
> +		hint: Clones of the outer repository will not contain the contents o=
f
> +		hint: the embedded repository and will not know how to obtain it.
> +		hint: If you meant to add a submodule, use:
> +		hint:=20
> +		hint: 	git submodule add <url> empty
> +		hint:=20
> +		hint: If you added this path by mistake, you can remove it from the
> +		hint: index with:
> +		hint:=20
> +		hint: 	git rm --cached empty
> +		hint:=20
> +		hint: See "git help submodule" for more information.
> +		hint: Disable this message with "git config advice.addEmbeddedRepo f=
alse"
> +		EOF
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_expect_success 'error on a repository with no commits' '
>  	rm -fr empty &&
>  	git init empty &&
