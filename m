Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFD63358B9
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959026; cv=none; b=pJGnpnSxUiqO0/gGlXyrT1PNxhrD90lUsDFfv2wBH6WdFUy37tk7/trj7Ecd2WTXJIcYAOOGgRtmFn6PCQ3vidV38UGLURsZvdRLc4MFCZNMcShsj6iUbeNjfmKD8Ah7LTB2G6BwN8WwCbYFfKFYbQUpWNWRjMb/nqiSnejLuv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959026; c=relaxed/simple;
	bh=8YiGvXvgUaxijEOIkDOIBr1FXRyH+9r0egXKSx3T9Jg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jmNbTQ6PhBaNUiD5S0k1L3L12PEjj45a/5XfNZJRSCzZPtiTSLuLtOdrR2+QXpX6a9Llx5sSXCdQxMasVNPlz8lC6bYnRlj69dzajBd0dn84GJ7oIWJG9P0gEkxYLKk1w7B9enlkbNP5/UxlJv7XArEU7G6zRvpletrsxyM5Coo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E2/7OG8b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AJt07zi/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E2/7OG8b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AJt07zi/"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 546171400124;
	Mon, 13 Jul 2026 12:10:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 13 Jul 2026 12:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783959022; x=1784045422; bh=YyL3TIREwV
	lT2lqkvBO0OgYG6VR1cYJwVrnyg/LWB8I=; b=E2/7OG8bllqzW3NxznXhdraYM4
	urckNhROm1KTk7itiqu4Gbe9rBx5+eZhpzbBNi5ra5o5Im9xsg45Zl5zbmfKDW+i
	pWh+3ImOkbf+hsUhkbWdUWlWa16DxlOpKYiJ7uT9gCfI7ROSuN3yF5PPKx5HFqCQ
	zei0ZeQNh69feoBQOrw0aWtZRYgUdt/1K0ydvex7zvhOYXUTXJH/jFIx+JV1VfmS
	6pJJ3VPo0vsI56RhZYLNJ352x5rPxJPe6rt6943kDBE8ooA2OPlWWKNVa9l5Xm0z
	NlZGSuz3HXTzDlUmbm/AflVOXD+TDKXi0IhFjBnaywJLQkAUSkCJeJ7tvSxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783959022; x=1784045422; bh=YyL3TIREwVlT2lqkvBO0OgYG6VR1cYJwVrn
	yg/LWB8I=; b=AJt07zi/HZDbC7Xg6V6u04EsRlH6tDZvpl0at2/tMKaSN/nlKpN
	wkqusJeRdOCxWvp/kSKUczADGQIJ9deGYieWFSYJdwo3bFMpoik7sEDctFcqpRVM
	mHJaJpZ2HDZM+iV45oL5Uq72J9Yrj4VI6oqE3ynbOpJ4x7j9RimnjDvJAW3Zaw/E
	PmfcVH/J7PO1fpsSYpQbt/xRSEdt9U5IdDeVM2gwL9GWnaGft/HRwG3/jpP5OeFr
	5w+LskCiANpX/ucSr3/pKBFlz49FwPQcM9ffxP0JJRlzQJtyZiuFDtalZhAT8ZBh
	uyqumVtY9ej+U8suboxnNxAGgxFVhd1QMmA==
X-ME-Sender: <xms:7g1Vav7Z8yDMgJv5fHurjyvqkXqQ8ij3YBY0NCB37IFBOCAVH8kt8Q>
    <xme:7g1VasX8pwkf315AkaVE2bimtdtVCQF2crm8ZHpVeRkYSmZn8TvbSX6jnsJfJI-dO
    Z6e0dmxKr-svxTO_58hqkunNvmsMa5eSKqLTVufCrQfdqiWmiBpyF0>
X-ME-Received: <xmr:7g1Vaj2muRlXTBWHqbOHI23UuzL8Ts0baGVe1D9ZxmfPPC6cp5tZ7JLLGXKATyNX1bNr0aNhHlLR7bMIlnPqEESBhU3iugo0euUMSIo>
X-ME-Proxy-Cause: dmFkZTGeqESt8olOyMWgbyT+EQ30aF34VQqACsJI5vNNzlEEAs+8jCYZoq7DwCOfeJkBUC
    bsd52oY4hOS5KovSeBw+p/cEeIgXkDL5pY0alHSlw7x/d6EGq+hMgiV4oEwJXgfh8lxa7R
    cFdWwd4ikVyBMSK5jmQNn6OYXLtmldHwx69v4DE6NTBEObeATxuuXuzwUVYRhveOCZxinC
    0DFvTUgI8g+Oe1w1ONYGROaglMLTMoO+5L1j1qxsHvtGIiyWiry6exFBCCIRK8+DGmW0I+
    Ws1foosr/Zf1qtzLgaf86w4a4XLlDSW4VlBFpZML6pzQXH4rGT6bd8ZPA/Wjs4oHPj9Vai
    4Bp48D8WShyn+a98WD5PPsP3AdWqt4NzF1FvGV9RE+erZPxYUt2kI32M1Z9vDHvWrxf2sk
    fDYKdJjmDqR2o3vCdWAmYH8RJza7lCHB8gwH+qxa8s6s5cJPoYLbOvo8cuUyQl42AOF7n6
    bK1FEZpwXdnIJhdn5a8nvmK7vjWLelSdIbXN2cLLhEUgQLWA8Zs26KkjYd7/zfCqy4gaoN
    ZFY9BfNC3OlKzhol7fS64qIAbr9/3h/a48066pi26JBUYPhtzquzK3cQlMHsg1YIphgFr1
    +C/h0H21pF8m2L8o4y8KNmdQekY71EoN9jPYYphMvX9biTeXMIeLrBX93Gig
X-ME-Proxy: <xmx:7g1Vap0Zbc7xAz5Ft7F_xLWvk__tXNBYVogfarwWe__PZrQuEsqoDQ>
    <xmx:7g1Vam9xlBbfkzocvn5QUTpv8ssLmIIJCpFcPcq_ziND-oQ5q5I_sw>
    <xmx:7g1Vam2HA9o3cZ31e8eCadmcN5uVnnyPLr-ZNGz5n1cRCfQbTHvZxQ>
    <xmx:7g1Vaj-he8uUroV2aeqxIWWwYzDp64drjfm7UjWY717rfzREe8kJDQ>
    <xmx:7g1VakVvAh2J8sQoJTgG7StDFfMYGk_ruY3Tc5Jndg3uP9T_iPxWU2bD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 12:10:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shlok Kulshreshtha <diy2903@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] t1100: move creation of expected output into setup
 test
In-Reply-To: <20260713140142.27898-3-diy2903@gmail.com> (Shlok Kulshreshtha's
	message of "Mon, 13 Jul 2026 19:31:41 +0530")
References: <20260713140142.27898-1-diy2903@gmail.com>
	<20260713140142.27898-3-diy2903@gmail.com>
Date: Mon, 13 Jul 2026 09:10:20 -0700
Message-ID: <xmqqfr1mzx8z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shlok Kulshreshtha <diy2903@gmail.com> writes:

> The "expected" file was created at the top level of the script, outside

Use the present tense to describe what the current code does.  For
example:

    The 'expected' file is created at the top-level of the script,
    outside ...

> of any test. Code that runs outside of a test is not protected by the
> test harness: a failure there is not reported as a test failure and is
> easy to miss.
>
> Move the here-doc that creates "expected" into the existing setup test
> ("test preparation: write empty tree"), using a "<<-" here-doc so its
> body can be indented along with the rest of the test.
>
> Signed-off-by: Shlok Kulshreshtha <diy2903@gmail.com>
> ---
>  t/t1100-commit-tree-options.sh | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

Trivially correct.

Thanks.

>
> diff --git a/t/t1100-commit-tree-options.sh b/t/t1100-commit-tree-options.sh
> index fabe5a97cb..b434d1848e 100755
> --- a/t/t1100-commit-tree-options.sh
> +++ b/t/t1100-commit-tree-options.sh
> @@ -14,15 +14,14 @@ Also make sure that command line parser understands the normal
>  
>  . ./test-lib.sh
>  
> -cat >expected <<EOF
> -tree $EMPTY_TREE
> -author Author Name <author@email> 1117148400 +0000
> -committer Committer Name <committer@email> 1117150200 +0000
> -
> -comment text
> -EOF
> -
>  test_expect_success 'test preparation: write empty tree' '
> +	cat >expected <<-EOF &&
> +	tree $EMPTY_TREE
> +	author Author Name <author@email> 1117148400 +0000
> +	committer Committer Name <committer@email> 1117150200 +0000
> +
> +	comment text
> +	EOF
>  	git write-tree >treeid
>  '
