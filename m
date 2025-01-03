Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFCF18FDAB
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735892195; cv=none; b=V88ccdYKyPbLRXIno2wgZPiwkkhd7Q3PLei+uK64USXep4H4ccBdVRljT0XWH1hIgJ7yDLE1CX006QU5vyjIwUZqrBdaRveVoDT3ILH6+f917JjAdUqzhXFpravTg7QTPwL5YPs2cFAMuBLst3Z2jRr+wuoFBgr89a7dbh1VGRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735892195; c=relaxed/simple;
	bh=5L5vmLfbhNAvNM6eVXsLUbE0HM7idYxOOuohcp+zowg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcWs6i3xe7853I4XGnCkFt7z/y83pWJ1NeMJH/b3oDjdPKoIfN7SwTH02lyptXF8DZGsLqFQ43Qt9rgXyzTQtvEKq5ub+spgWzTtqN563+rEhgykkWoUMjhuX8obyRS0OujuA0hL9W6gozhbPejXEbnCmyru6YfqDihtuzDmaew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=npYqau3d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yjo4EzsG; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="npYqau3d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yjo4EzsG"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id DB2DC1380765;
	Fri,  3 Jan 2025 03:16:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 03 Jan 2025 03:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735892191; x=1735978591; bh=b+q2+m2JYY
	9qLaJeUiYHxJdUF1eS6mL9+pQ/P3h/IIk=; b=npYqau3dUzHrmQuRgmFpMfSn02
	hHBmUlaqtQRGr1/IJrF1qtkje/vO9GRmqoY/zPzOzPWejber/PWRRXS+bvpzN3fO
	rDn6oEUnX2HrodKms/wj9XvnlZOI2xajjHOIK/B9c0AlYJHsE9y8taesir+EQf8o
	n/xuyy4Bin8euoQ2UbNAtnG6ZNM8a5dVsT3BTl51mC0pZJbgOyEufQe5Zo4ylx1b
	GWL1Sahszv0QyRocvpdvJXaWu3n/zKxkKRoZjiEERA/AMUOr0XZsD7mIJKek7H7Z
	bMiKSTe53nTwtGxdhwtf7CoK8mPTdLl/WXc1TFfC9vuGp+k1zwzC4hAhLjUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735892191; x=1735978591; bh=b+q2+m2JYY9qLaJeUiYHxJdUF1eS6mL9+pQ
	/P3h/IIk=; b=yjo4EzsGdTDYBDVkxKnzj90cvE5XEKTwXhqyPpppkNghP36jDZp
	pOO7f6mU931d8oY2vdL0ZU8Cd5L8sfhmEGGLG4dUfUvSdOR/LBRsGlj2h+eWGUKf
	5yOkdDCq/hsukfgMqv00YsPqAyb7vkTUtO+WAEB3fh3rSE8wz1D57hnYvSYpeqQ5
	hfsKlCLkqR/eABEtR47pV69PJW0TSbiJWRSZd57FIeA9U6ozS/i0IP09mjyzBCw4
	muAzBLkDCuwzCfqTRFzKkHK85PjHPrxlBm9NTeacV//quqnJ/lVsltEqAazjS5Ou
	He6dLFfa6JswRb08k51bKao/NpxlxmISabg==
X-ME-Sender: <xms:35x3ZygEEUa9AmipDLfq6FA7w_kORjYKmHvOA--CI5Ubj6hz0iLHOg>
    <xme:35x3ZzDR0Ou7evJVWU7p8RuHlzwDJ-7osNBHnsbIyoY_5Rsi6iEG_nw2a4HbGNO-7
    g_PYPkqErY12gWPLg>
X-ME-Received: <xmr:35x3Z6GJenPoclf-G0I58_2pYp5RQ7VdUs1uj7fQTwvIivnQVLKpWvGfMuTJ7sfDNaDJfQVdkG4Wb0EC_J3wEykkRldBj-AnBY4hi-mHU9_4Xe0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeffedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:35x3Z7SrIgZWr-g47DoRSWKRdpIkcA4QkuvG4IdmN8MmJ95gZO8tzw>
    <xmx:35x3Z_yXOmFr_neCyA8Hyd_Lpqx-Ave3D5VqIDQd8SjobZdUzJ1osQ>
    <xmx:35x3Z566tS_yHzKnzJ-X7NPpeyHLZw8C8mE74aF0SiClUA7RU1kxXg>
    <xmx:35x3Z8z6TxbDEgxSs4A8qO-aEmL3-grGgx1YOkXUkl-4ivFFmblUkw>
    <xmx:35x3Z_-V0wVyaVs1olnNCojwtM4eYCKk0iN4Fl5jgcf8EcadrK4hfeXP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 03:16:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 413cd3c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jan 2025 08:16:28 +0000 (UTC)
Date: Fri, 3 Jan 2025 09:16:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] object-name: fix resolution of object names containing
 curly braces
Message-ID: <Z3ec0768O64j-JeJ@pks.im>
References: <pull.1844.git.1735699989371.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1844.git.1735699989371.gitgitgadget@gmail.com>

On Wed, Jan 01, 2025 at 02:53:09AM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Given a branch name of 'foo{bar', commands like
> 
>     git cat-file -p foo{bar:README.md
> 
> should succeed (assuming that branch had a README.md file, of course).
> However, the change in cce91a2caef9 (Change 'master@noon' syntax to
> 'master@{noon}'., 2006-05-19) presumed that curly braces would always
> come after an '@' and be paired, causing 'foo{bar:README.md' to
> entirely miss the ':' and assume there's no object being referenced.
> In short, git would report:
> 
>     fatal: Not a valid object name foo{bar:README.md
> 
> Change the parsing to only make the assumption of paired curly braces
> immediately after a '@' character appears.
> 
> Add tests for both this and 'foo@@{...}' cases, which an initial version
> of this patch broke.

Curious. I was kind of surprised to see that it's perfectly legal to
have branch names with curly braces in them in the first place. Even
something like `foo{bar}` is legal, even though it might be confusing
when one knows the above syntax. But sans your finding, this should be
fine given that curly braces are only interpreted specially when
preceded by '@', and the '@{' sequence is indeed disallowed by
`check_refname_compoment()`.

> diff --git a/object-name.c b/object-name.c
> index c892fbe80aa..e92f26b3256 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -2087,12 +2087,14 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
>  		return -1;
>  	}
>  	for (cp = name, bracket_depth = 0; *cp; cp++) {
> -		if (*cp == '{')
> +		if (*cp == '@' && *(cp+1) == '{') {
> +			cp++;
>  			bracket_depth++;
> -		else if (bracket_depth && *cp == '}')
> +		} else if (bracket_depth && *cp == '}') {
>  			bracket_depth--;
> -		else if (!bracket_depth && *cp == ':')
> +		} else if (!bracket_depth && *cp == ':') {
>  			break;
> +		}
>  	}
>  	if (*cp == ':') {
>  		struct object_id tree_oid;

Makes sense. Only the first hunk actually changes anything, the
remaining changes are only required to make us stick to our coding
style.

I wonder though: does this have any impact on '<rev>^{<type>}' and other
syntaxes where we use '^' instead of '@'?

> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index d36cd7c0863..252485dac78 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -603,6 +603,23 @@ test_expect_success FUNNYNAMES '--batch-check, -Z with newline in input' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success FUNNYNAMES 'setup with curly braches in input' '
> +	git branch "foo{bar" &&
> +	git branch "foo@"
> +'
> +
> +test_expect_success FUNNYNAMES 'object reference with curly brace' '
> +	git cat-file -p "foo{bar:hello" >actual &&
> +	git cat-file -p HEAD:hello >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success FUNNYNAMES 'object reference with at-sign' '
> +	git cat-file -p "foo@@{0}:hello" >actual &&
> +	git cat-file -p HEAD:hello >expect &&
> +	test_cmp expect actual
> +'

Do these really need the FUNNYNAMES prereq? The prereq seems to only be
about embedded quotes, tabs and newlines and is disallowed on MinGW. But
I think both '{' and '@' should work alright there, shouldn't they?

Thanks!

Patrick
