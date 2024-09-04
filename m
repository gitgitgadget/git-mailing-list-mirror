Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3404E1E0088
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467761; cv=none; b=MVcUpvofyEYK8FIXJmtOzR6LLi9tKgsJ+jsDKCWL3gpNUB10tuTdgIEFyb5qXIWVeeu/eTzusLp8r8qlDmQx06nLCBpOFP0vJZcjZI9JxZCZQMLRes5khJkIMJ60cE+K6o2YwPNSlEtzt/Lh6wnzAC2vjvbrzQ1go0WFAhSlsBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467761; c=relaxed/simple;
	bh=GLEgMDviEcdo6rc4xD1pI8GNGkV4TnUIO/M5FebqLRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ryqZwo/bNbOp179oi3vspsO1F9Q/MFFL4475301M1ttufJvUfalC7pv28nI+gl1th5Zy+4n40vFMTQU9eKNHyv3D2AMUrkioRojWXqlH/NP9FvKJw1U8QK7n/BAhA7O0ftHM3kaBfc80HsSScel6qeLI1ninqlpBEVYs1Zo5ZZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ufxL6OHV; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ufxL6OHV"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A1AA36347;
	Wed,  4 Sep 2024 12:35:59 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GLEgMDviEcdo6rc4xD1pI8GNGkV4TnUIO/M5Fe
	bqLRI=; b=ufxL6OHVcMnP3NzXTFgDvezTDSLxr2ubSeoqAbGajNFNgtMxN/IMMv
	54w3XgJzl7gh+43MTkRfsD6ay4QGmAOx4r+7BMwUrsmjKwINWTnSoX2gyibYnLAk
	WfrDoQDa0C8TPbZ/VU98RegXB1nPD2ZdWlcpqhRwDH0CFt8x4THz0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 31B2B36346;
	Wed,  4 Sep 2024 12:35:59 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A4B336345;
	Wed,  4 Sep 2024 12:35:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kevin Lyles via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Kevin Lyles
 <klyles+github@epic.com>
Subject: Re: [PATCH v4 2/2] builtin/cat-file: mark 'git cat-file'
 sparse-index compatible
In-Reply-To: <ac913257309960d86a9c11e825c76621c6ac405c.1725401207.git.gitgitgadget@gmail.com>
	(Kevin Lyles via GitGitGadget's message of "Tue, 03 Sep 2024 22:06:47
	+0000")
References: <pull.1770.v3.git.git.1725386044.gitgitgadget@gmail.com>
	<pull.1770.v4.git.git.1725401207.gitgitgadget@gmail.com>
	<ac913257309960d86a9c11e825c76621c6ac405c.1725401207.git.gitgitgadget@gmail.com>
Date: Wed, 04 Sep 2024 09:35:57 -0700
Message-ID: <xmqqcyljbclu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C3C28120-6ADB-11EF-8946-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"Kevin Lyles via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kevin Lyles <klyles+github@epic.com>
>
> This change affects how 'git cat-file' works with the index when
> specifying an object with the ":<path>" syntax (which will give file
> contents from the index).

The above is not as suitable as the first paragraph as the one that
comes next, which describes the status quo and highlights what the
problem is.  With the few paragraphs below, that talk about the
interaction among ":<path>" syntax, get_oid_with_context(), and
the sparse-index, I think we can just remove it.

> 'git cat-file' expands a sparse index to a full index any time contents
> are requested from the index by specifying an object with the ":<path>"
> syntax. This is true even when the requested file is part of the sparse
> index, and results in much slower 'git cat-file' operations when working
> within the sparse index.
>
> Mark 'git cat-file' as not needing a full index, so that you only pay
> the cost of expanding the sparse index to a full index when you request
> a file outside of the sparse index.
>
> Add tests to ensure both that:
> - 'git cat-file' returns the correct file contents whether or not the
>   file is in the sparse index
> - 'git cat-file' expands to the full index any time you request
>   something outside of the sparse index
>
> Signed-off-by: Kevin Lyles <klyles+github@epic.com>
> ---

Nicely explained.

> @@ -1047,6 +1047,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>  	if (batch.buffer_output < 0)
>  		batch.buffer_output = batch.all_objects;
>  
> +	prepare_repo_settings(the_repository);
> +	the_repository->settings.command_requires_full_index = 0;
> +

OK.  This command does not start parsing the command line arguments
before this point, and this is really a good place to toggle the bit
off.

> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 4cbe9b1465d..eb32da2a7f2 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2358,4 +2358,40 @@ test_expect_success 'advice.sparseIndexExpanded' '
>  	grep "The sparse index is expanding to a full index" err
>  '
>  
> +test_expect_success 'cat-file -p' '
> +	init_repos &&
> +	echo "new content" >>full-checkout/deep/a &&
> +	echo "new content" >>sparse-checkout/deep/a &&
> +	echo "new content" >>sparse-index/deep/a &&
> +	run_on_all git add deep/a &&
> +
> +	test_all_match git cat-file -p :deep/a &&
> +	ensure_not_expanded cat-file -p :deep/a &&
> +	test_all_match git cat-file -p :folder1/a &&
> +	ensure_expanded cat-file -p :folder1/a
> +'

OK.  These are about the object names given from the command line.

> +test_expect_success 'cat-file --batch' '
> +	init_repos &&
> +	echo "new content" >>full-checkout/deep/a &&
> +	echo "new content" >>sparse-checkout/deep/a &&
> +	echo "new content" >>sparse-index/deep/a &&
> +	run_on_all git add deep/a &&
> +
> +	echo ":deep/a" >in &&
> +	test_all_match git cat-file --batch <in &&
> +	ensure_not_expanded cat-file --batch <in &&
> +
> +	echo ":folder1/a" >in &&
> +	test_all_match git cat-file --batch <in &&
> +	ensure_expanded cat-file --batch <in &&
> +
> +	cat >in <<-\EOF &&
> +	:deep/a
> +	:folder1/a
> +	EOF
> +	test_all_match git cat-file --batch <in &&
> +	ensure_expanded cat-file --batch <in
> +'

And these are about the object names fed via the --batch mechanism.

Looking good.

Will queue.  Thanks.
