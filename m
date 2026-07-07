Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699E62BE630
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783459838; cv=none; b=jldT8EjjTb5WOLsZerCkyK9lN3HIx2S1P5Z3dmLyqluQfhwhKduz2mZL4yVnhVgJ/G72mCJ35MjW9m4NfQQQ+rmQJO/k8jinU46decRRHtz64ho8a0YDEuHZcqkCBIU7zoofG5PPac4j0cWujUA83X3Pxf5TANzRIat+QBuSjR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783459838; c=relaxed/simple;
	bh=90PmE/lYuNSwqJgB3xzB1vXxSUEfJA/slTcvUDsoLLk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tmn/KSR+PSDMiLWfILXYvQfcRRrf0fFVjIuoL4NqYXlQpYQZlEFIDFsMZQA/IEkweejyM5omlyLUB9iEVjVjs3GZ4kxiLInMGBAijSWAkjpo7ttAUP7DKWJ0c+S1fMjD7g+fAD5UH4WYvxv0TkwQFzgf6R+h+y9P0tKwvbHRZ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OmOPkDgb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=COKNZTd9; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OmOPkDgb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="COKNZTd9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9DFA61400103;
	Tue,  7 Jul 2026 17:30:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 07 Jul 2026 17:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783459835; x=1783546235; bh=Hgou+HapeZ
	x9WTIOhjf8tAZOYxXdQA5gjCg6gm0/+FA=; b=OmOPkDgbNX+Bf8ZeiO5WbiV3d5
	3vPJJXd/zSRbokSzkEPWL49MJn1TzrOzgoRjqRIGthL6x/eXnmmDj0ItyblkLls1
	zoyJNo9B/efdtWEFS5d2acSTYHq+/FZrz+7jfc9UibJdvA96NGwsC5uUrKtUKrzE
	ldLpEjOKv5pImLUQDDr6WZlDEEDAhIskwVUXZj+vSoIxp3yYY/1LyveT6b0YjJCT
	5jduEL3gC7gEJl4KgQYY+/Nzl46iAtzVydExHf9c/iZ4Lzi0QRTYRE+LBrVEnFFX
	qIFkLyLeMKH1wKpd+HdU+79fggrAxe87+Bt9m27gOw4d5E5bHuM86j+nR26w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783459835; x=1783546235; bh=Hgou+HapeZx9WTIOhjf8tAZOYxXdQA5gjCg
	6gm0/+FA=; b=COKNZTd9Q6yJR6eM+S5I1sXlmLqzotU+oiHBSX9XK0ES5NXb31I
	SntVkyYkQJStn/JvtVRXdqLfQD8XG4oq5nW5HchYxrUAJYgweQ3b0ewCWGsXR3mi
	EOLqPs9IUJ9W1W0wCuAVNgzNAfXzSLmVTWkD3rQglAx8bBS54jOQqQ/3az3+zX1+
	WILnfgc8VW4scLoaDvylOlujgQwA85QDmnXEE1N7wEN4TgKV/9tGBnVGUKF2G4F7
	8PJFWQD8Uf4i0djmpXqpYCwUkNRMetPn/KZmKpOrWfFsVeqgpZ9SMc//Z0i3p7c0
	hbYWm6yFewpuF7/WgzcNsYuaslGZUCHMaFQ==
X-ME-Sender: <xms:-29NagrmH3RDcDq8eCQe2INWdi-qVYKRM-7zqmg_WRHZF-ZCQGMR6A>
    <xme:-29NatquqDoav41zrlirqeRII2t5SQiWmDV0cb8UI6HyXoRVFb3rHwq0jUypn3sTu
    6S2TkiKJUiMq_0KAL5UTXmKd7fCaUeGqbEB8DLQVQ6_wOiEbuKC>
X-ME-Received: <xmr:-29NaqNczDG5o0XX3VwNeIipuC6oEBpMtxeqK8JAo4-IGPjeEobXYPDFZioWdrADh2T0fAMo2PWhX_q8XUxizDfTGsMBvk--EieiFx0>
X-ME-Proxy-Cause: dmFkZTFeFUaGka4zHCfj6LTiXX0DmIqhRKctQXI2HgNx4l3mNc7HbLzGSd5ZgDwrQRasvG
    iAvAt4IVmHxmuVjZW5GAhLfgbTf4dEnijBTOQyxF0yTD9V9Eb1UqTnNvLIYS7/RNYvjfYN
    ASKlm+Mqqi/hN8Kmac1awmRaFV0ggUmV4tmYuv0UnCFRoajNvIMwqfDdMd7os0bbFcOVmc
    eeP38stKIS19oVJVl3hEoM5ubIRe9K5XHPyZWpLILL8iqQ4iPWn/ufkDX2YO+KQVWZ/8wK
    hdnta6fsJ2RNxEISrLvVsBIaRxbQ4bcaT53ttFaBaFDZRripf3h/k4jgROP+fzpKpq+GG0
    no5REYT9WyEXQAcFq/683gYTFXp+7KRBeXKwI4zFBEE0eBssuR2F5qFD9Qe1ZG5De/VhlV
    /0knPobjnvpm4kxljfwnnUKIn1louNAcsp1jsGhr0WtfWUc1EneeLQGZepF9/BhqUGr45c
    a9htU4NEeny0R5GCtiU+onrN62V4WUU3vWr7MGeVjHkmntKKy9D4SJcNYCEqkh8h2X0HAD
    M/gflvTmjcW7S0GAXFno4ZAAyKdbT878PvZPCvaFt6RSlF/vpmRCeoIDo3FT2MMYgpkGRn
    lHsSiYEuxwbHtIX2oKusxdLpBP3VAmsT5qe13FugovJIX3zEF037aEKnoggw
X-ME-Proxy: <xmx:-29NamzxoWgEHvyK-PhYJP8MZXHzI5rNRBdrlb5rcF3JsPXo03QKMQ>
    <xmx:-29NarsIrPDSVWmqrtqMNK1_JMe63qUsm2-3VbJSxUOIvmWw_tAHwQ>
    <xmx:-29Nan4HEo5F12RgLZso_v5JheXATnnDnejNETQuKQXtEoKVwej8xg>
    <xmx:-29NaiR4e2T_qYWrM4PRaMS4OKU43tkW0H_NRbUVw4NZ7IIPAma9QA>
    <xmx:-29Nat5XjXR1F0hxO7ySV-gtQOfcYisByraJFEeaHEn5x2ECgt6qRMca>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 17:30:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Henrique Ferreiro via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Henrique Ferreiro <hferreiro@igalia.com>
Subject: Re: [PATCH] unpack-trees: avoid quadratic index scan in
 next_cache_entry()
In-Reply-To: <pull.2353.git.git.1783458106037.gitgitgadget@gmail.com>
	(Henrique Ferreiro via GitGitGadget's message of "Tue, 07 Jul 2026
	21:01:45 +0000")
References: <pull.2353.git.git.1783458106037.gitgitgadget@gmail.com>
Date: Tue, 07 Jul 2026 14:30:33 -0700
Message-ID: <xmqqv7aqzdvq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Henrique Ferreiro via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/unpack-trees.c b/unpack-trees.c
> index b42020f16b..ed9fef453a 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -671,8 +671,10 @@ static struct cache_entry *next_cache_entry(struct unpack_trees_options *o)
>  
>  	while (pos < index->cache_nr) {
>  		struct cache_entry *ce = index->cache[pos];
> -		if (!(ce->ce_flags & CE_UNPACKED))
> +		if (!(ce->ce_flags & CE_UNPACKED)) {
> +			o->internal.cache_bottom = pos;
>  			return ce;
> +		}
>  		pos++;

Nice spotting.

Does this trick work correctly even when a path's sorting order
differs between the index and tree objects, which is precisely why
.cache_bottom was introduced, to allow backward scanning while
bounding the lookback distance?

>  	}
>  	return NULL;


> diff --git a/t/perf/p0009-diff-pathspec.sh b/t/perf/p0009-diff-pathspec.sh
> new file mode 100755
> index 0000000000..0f1dccfbb4
> --- /dev/null
> +++ b/t/perf/p0009-diff-pathspec.sh
> @@ -0,0 +1,27 @@
> +#!/bin/sh
> +
> +test_description='Tests performance of diffing the working tree with a pathspec'
> +
> +. ./perf-lib.sh
> +
> +test_perf_fresh_repo
> +
> +# The entries exist only in the index, which is enough to
> +# exercise the index scan.
> +test_expect_success 'setup' '
> +	count=100000 &&

You will probably want to mimic how t/perf/p4209-pickaxe.sh helps
testers by adjusting the count based on how the EXPENSIVE
prerequisite is configured.

> +	blob=$(echo content | git hash-object -w --stdin) &&
> +	{
> +		printf "100644 $blob\taaa/file\n" &&
> +		printf "100644 $blob\tf%s\n" $(test_seq $count)
> +	} | git update-index --index-info &&
> +	git commit -q -m initial &&
> +	mkdir -p aaa &&
> +	echo content >aaa/file
> +'
> +
> +test_perf 'diff pathspec subtree' '
> +	git diff HEAD -- aaa/file
> +'
> +
> +test_done

Thanks.
