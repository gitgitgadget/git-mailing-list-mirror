Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4DA45016
	for <git@vger.kernel.org>; Sat,  2 Nov 2024 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730543384; cv=none; b=ihV6XEMP3iQTYe9ysvA34gdI9mkGXyw2ZhPx9XsZUenK508gJ2gg5Ke0ZvONsKC2NnjZOIA9RghVaEWxZ654EVgJ1zfdR07dWgnXru+KtwGcNP5WP83kYf3iPDFlXgPKrpEFLwrcSvEqb66NiIyJ0WanKL7/dN4umD5EROqco3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730543384; c=relaxed/simple;
	bh=NPuzA5KfMyiljx5Pad+oGBKsLMcIuornImyUUIPIOWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OVaFEchV6h1IvkSzZw7UzQnlw/9Zbeja66mbfGQ9xSdLj2tE56fpLyV7vDJOolWiDsjQFh36fp8sRfk548GlwxJQorE8dhKgNE3201CCUGayF14c0mTJFQogZ31cbsj3AqJOmA2fCn+KNMTaSBbTGT4lZ+Roi2BttSgcOokWreQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ic0hxdgW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DzblJ2VQ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ic0hxdgW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DzblJ2VQ"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F4AC138028F;
	Sat,  2 Nov 2024 06:29:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sat, 02 Nov 2024 06:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730543379; x=1730629779; bh=4hmf6ekizn
	npKFBE7KhCePL+elC3Lpxd6dAs0TmV4h0=; b=Ic0hxdgWCfCti33AU+34kFZDcb
	hEPou1d+5XduuRt+/AR4K5+GxeVpbHSJV06wsIakO0E3MyycBwSeyvI5eQhsQOzy
	C1xGMOlDxmaivyyTcT3q7fiCElragmI3+A+MlvLUdKQRjfNWe2MDFHRiCNM1p8DZ
	X/IQHejSwhz2nGYN+FYB+FGreP0fV912pzc1SVcYhGapN2FBqrsZeQ43ZvYR5CT5
	iuaGe/MJw9Grc8hU9VXWPoKILklwBNk8lMZR2WgJasde/8qIRzMTPnvE6D65Lj/e
	lWkL/64mbU3XLDPNPPcQUzEQmTX5Gmb4nzl0oP2kTw8JZsKNaHCeFB8UP9ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730543379; x=1730629779; bh=4hmf6ekiznnpKFBE7KhCePL+elC3Lpxd6dA
	s0TmV4h0=; b=DzblJ2VQ2JIQq4/qp7Bw3VFREtX7bMIzf6CyvOidJd9/AsiKBMt
	f6GZ5DhwEMTFNOcedazLwXzTmbHATVayYqGK31IhIeLmsTaI0IVypMUCNchm96l+
	L36B4JFPVWxQOhdIjaSVqEmuDn677II/P5KZzo6JKgoZ1TZHWMDOfZueuI+XisoV
	D2TqXhysxUs1NbR4BW0bQHyQOT4RjLPWg/DgcIqVJdIgILNpwafJYZK9OmqeXz/3
	FQznMlJEn6PjhTfQwt7kxs455iFWMKAM6RYrq0R1/tvIou9VPWP6/MFYNNwvSBL3
	YT4Sov4CZQgX2A4072f98i5b76lkt5AXayw==
X-ME-Sender: <xms:E_8lZ6GVmoi5hlukUUG0GPW1KZ-DhJozpBg9dtTHd1-Lp5DLKvZuuA>
    <xme:E_8lZ7V3ouLBUcN67wJiiQ_uN2oQS710A01B0wtbfn-Ty27aMWFCZdZqFuFJ2JenW
    Bez_j3tgJ-8lyk7RA>
X-ME-Received: <xmr:E_8lZ0Lu9b4WYxetavnozaMVvhTR0khpO6o0cZnkuMRfiw2uL9_r74Ie42Q8Y-mxg6bTMlA6DLfvJHgSM-i6WJWBMHJKhjFpxlEN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeluddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegrsghhihhjvggvthdrnhhkthesghhmrghilhdrtghomhdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepsh
    grnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:E_8lZ0EqgWg2VYSiNQITU04J7aRm6t8p_-IHDkoEDcUGcLVs4C8AXQ>
    <xmx:E_8lZwUoJRk-cJHdjbhnq3Wu7-Bcu1hBZYbf6jKI-LYjQVfa5csQ7g>
    <xmx:E_8lZ3MkSdKQ7DBDdGA_-3mIKaweTW4rs27ZJdNYmC959IGJaKAViA>
    <xmx:E_8lZ31ohQYk7dqGbm04Cwaar84IIFHYJxEJDZBsCfWmvG4DRrchyA>
    <xmx:E_8lZyKlzLyX-EFV64PT0LY7pIEIIRWjjLt00p3lIM4ANwVU0UKiJEOX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Nov 2024 06:29:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: me@ttaylorr.com,  git@vger.kernel.org,  ps@pks.im,
  sandals@crustytoothpaste.net
Subject: Re: [PATCH v4] show-index: fix uninitialized hash function
In-Reply-To: <20241101172800.21997-1-abhijeet.nkt@gmail.com> (Abhijeet Sonar's
	message of "Fri, 1 Nov 2024 22:58:00 +0530")
References: <Zx/NE/9HFNr9V2H7@nand.local>
	<20241101172800.21997-1-abhijeet.nkt@gmail.com>
Date: Sat, 02 Nov 2024 03:29:37 -0700
Message-ID: <xmqq1pzuylm6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:

> In c8aed5e8da (repository: stop setting SHA1 as the default object
> hash), we got rid of the default hash algorithm for the_repository.
> Due to this change, it is now the responsibility of the callers to set
> thier own default when this is not present.

"their own default".

> As stated in the docs, show-index should use SHA1 as the default hash
> algorithm when ran outsize of a repository. Make sure this promise is

"outside a repository".

> met by falling back to SHA1 when the_hash_algo is not present (i.e.
> when the command is ran outside of a repository). Also add a test that
> verifies this behaviour.
>
> Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
> ---
>  builtin/show-index.c   | 6 ++++++
>  rm                     | 3 +++

Huh?

>  t/t5300-pack-object.sh | 4 ++++
>  3 files changed, 13 insertions(+)
>  create mode 100755 rm
>
> diff --git a/builtin/show-index.c b/builtin/show-index.c
> index f164c01bbe..645c2548fb 100644
> --- a/builtin/show-index.c
> +++ b/builtin/show-index.c
> @@ -38,6 +38,12 @@ int cmd_show_index(int argc,
>  		repo_set_hash_algo(the_repository, hash_algo);
>  	}
>  
> +	// Fallback to SHA1 if we are running outside of a repository.
> +	// TODO: Figure out and implement a way to detect the hash algorithm in use by the
> +	//       the index file passed in and use that instead.

	/*
	 * A multi-line comment in our codebase looks
	 * like this; slash-asterisk and asterisk-slash
	 * are placed on their own lines.  We do not do
	 * double-slash comments.
	 */

> +	if (!the_hash_algo)
> +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);

OK.  This is in line with how the command is documented to behave.

Having said that, I am not sure if it was an omission by mistake
when 8e42eb0e (doc: sha256 is no longer experimental, 2023-07-31)
marked SHA-256 as non-experimental, or it was deliberate.  It would
have been an equally plausible, if not more sensible, position to
take to say that, since SHA-1 and SHA-256 are now on equal footing,
we won't "default" to SHA-1 anymore, when 8e42eb0e declared that
SHA-256 is no longer a second-class citizen.

In any case, we can further remedy that, if we really wanted to, by
tweaking the documentation to require the option outside a
repository without any default, for example, and then change this to
die().

Of course, we may want to use the hash that is used in the index
file we are reading, if we can, as your comment said.

These incremental improvements can be left outside the scope of this
change.

> diff --git a/rm b/rm
> new file mode 100755
> index 0000000000..2237506bf2
> --- /dev/null
> +++ b/rm
> @@ -0,0 +1,3 @@
> +#!/bin/sh
> +
> +echo rm $@

Please don't.

> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> index 3b9dae331a..51fed26cc4 100755
> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -523,6 +523,10 @@ test_expect_success 'index-pack --strict <pack> works in non-repo' '
>  	test_path_is_file foo.idx
>  '
>  
> +test_expect_success SHA1 'show-index works OK outside a repository' '
> +	nongit git show-index <foo.idx
> +'

If we are not using a hash that is not SHA-1, we should then be able
to do the same check with

    nongit git show-index --object-format=<hash> <foo.idx

i.e., with an explicit argument.  I do not think we have any hits
in the t/ directory from

    $ git grep -e 'show-index .*--object-format' t/

so such a test might be worth adding, either as a part of this
change or as a separate patch.
   
>  test_expect_success !PTHREADS,!FAIL_PREREQS \
>  	'index-pack --threads=N or pack.threads=N warns when no pthreads' '
>  	test_must_fail git index-pack --threads=2 2>err &&


Except for these minor nits, everything else looks great.

Thanks.
