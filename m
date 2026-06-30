Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4924312CDBE
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782842432; cv=none; b=oj5PepF8YiLmwdan64C9CEGItZ0UTf5P0aOQg9gzWyfXP4eqrd1IQvkru53p351yb2FEjwRjvoJfYS8TckPWrjsCggLjSRn/RCIatGxH1gugiif2bL54+bdjwjjpDElflYGmpTWHP3JUJdxfT+EuAqSbXZjFFiuKtwjLep1Ssa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782842432; c=relaxed/simple;
	bh=viwW/SAcKnhBdyXJk0C4ilsr4ZXkcoFL8ts/l/O2IU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m4qOlKA0q4re4MinUvqEX5UO7Perf+fCnJuS36q1NedtixiSgeWMTnpMexdjIxCW4Fo0u5e0R18yeVc5lJQqRvz54ZXhTV//nkdwEP98relUUl+huahY8BLLnr5/7ZFGhhBCRrzL85rr8zpSmixsmKN8c7QJDHmNWXCEPIjefAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E5IM2boF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cdHAMC3Q; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E5IM2boF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cdHAMC3Q"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87EEE140013C;
	Tue, 30 Jun 2026 14:00:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 30 Jun 2026 14:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782842430; x=1782928830; bh=N7+SBmbxCR
	FDM35ys03RMYqmHf1QFO67OpTf92GXEpo=; b=E5IM2boFu9THkLv6i3RJp1jEMe
	gcyQiCHiKoe121YiRgsEOlrlfZA6ltOUxHI5ZjRe35hkSscrpSAyyMSLdxx7CXvX
	+C09jzGk3XwNFAcv3jDG3AB0kJgl/cH3dOflyGi60QPztdIcA0IekxbKzRoTOj9C
	w8quLG/dkil2rhBqnh+OakNyS2AlFd+mA1xB/gi+TIW2LzMJeXAn26Inpb9JQ4R7
	JmzWuIn31wHOaITUVIgn8/LZj9lqQiB8+uZuKwhbdnx9yEJbfsedMOFsifbu4Va/
	LlxTlp0nEyspjCJNpmoU5LldldZq/JsSlCIX+kjhAZvEJDTAbeheTWktxVjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782842430; x=1782928830; bh=N7+SBmbxCRFDM35ys03RMYqmHf1QFO67OpT
	f92GXEpo=; b=cdHAMC3QjI3RJO+s/eeZTVSUNHcqHu3fmnJBlh5JC2Cr8UydRcc
	ceyOspM59h8ZwtCowKVt4ZTbkdFrJg48V/UjJWo55R14bXFG2XUipWNCceJPeMNJ
	nDJrPWDkN4JKrlouepp+0FxXDaq4lkSgx+07set3B7GG2joiFOHPW7I7NeuMrwx5
	FC408EX3R2T7geAz5249bgF4RVy7kcqt56Nz/eyHftplIdm7c0yfyq4ZtRIZHWLn
	zi4OvJ6OpHpfMHRUaEU4ZH1yn7eyfwa8oUPPLmCe3IxUoo29ktE1Dhw8GVnDvQxD
	c8/oCCCkR/nq9azQRjRZ6FsLDusykcAqxzA==
X-ME-Sender: <xms:PgREaifGmp095LrtZgDPytauf5ofxK1rhNxQE2eGm1CReZODg2Iypw>
    <xme:PgREajFPDsLGVBepAyK-Tg50VEEB-YF5ol4zpoFrw5tWb2zJgfRIB8JL2zUm9lenP
    k6Ekr8bbV8X1OtWiZpNU6s16sPSdI8OTzxfmW7wxOjN9PcD3sBI>
X-ME-Received: <xmr:PgREar1QfJ0VBjzXSlJu77r5Y-msXI13wxUKIk3815GcYVXdFR6cpxJU1DTYwnHsV6CJwhUQDYyYG7EFWFA5wEtVjjZy6qUwtP4yhj8>
X-ME-Proxy-Cause: dmFkZTEZQLmIh82eAD6y4RYlVrY33E/guUySAorq78UOFo3skWSGp7TZ90VxkO9Dh1eI4o
    +hDjw1BNq5sGIpoa8ddp9+IteQ01JCtlg4fYKFvVvE493DVcSzDnHUWP/iWGlAlgM1ubG6
    2rSZ4lzN6yHv8Cax+qrN4hlZYrWPH44+DvHlBhmQaZyyjS9qGth2JoTtUqNsSEZgoxgufg
    Ad2N9NmyucGLcNaCIlOnIANNuLqN4rDLarsmG8bM9igbTGWyA3zbMj+acSmw8GBGbIu64G
    5gG6qkfBBfTa2a1mOotZpJDlawQr/KRtIcBBVbtdznzW/CK+sZLiFHzPQvmIKpn9OHJCSn
    8rDOfhDdeeoBObScdtGvt6drYj+Zhl1k9TSeNG2gSQ+/Nyu3Jr4jZKaFdv0qxmSdpXCu0+
    i1Kmr5cssiZsN8j2wEWD5ASKffGtrOXVjEUgbrcV74NL6/fFL7JBjgtnzKNRiW1DbultMA
    22bA160oGD1e0mgbrSrMwMP4YvMQhUwciq4IKVf2ENkRL2Ll3+SwNGdEl3Gc9YWq5MUXzu
    tS23Zl7MdEaC0mzt+TA71fztPIumzy0pD4KK9HGxXzFEPdAMvcHomBbEvCSr7UUXRUBslp
    CBTkkALPZJ5JWFou7spXQsdlbKyn5/RZrR85M33Eh1HwXHuMjZ2MdtQSJ4rA
X-ME-Proxy: <xmx:PgREarlYVZilsnPMQh7GMDa--ZJ6nFZfcIlZBlAx4VvTIVZ0FUJ8Gg>
    <xmx:PgREar-5rvdyfbTte1T59Yo3d4ztlHzCY4XBkhpBDej0WKXkYLU5Jg>
    <xmx:PgREagoKV1K5O6n74xawo0R_HGR4yiRaHOmqdprNG1g9GJQuu8KDew>
    <xmx:PgREakmKhYVtHwldExQlKRgkNfxAEvY1qT7X7ojyvIEFqpWxPIr6sg>
    <xmx:PgREaoFwmtILfNgf6Wrl1M2RdHcrYRQTgyOFGUOYRflHq-EqTb2ndveB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 14:00:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Bryan B. Lima" <bblima@usp.br>
Cc: git@vger.kernel.org,  gustavoscorrea@usp.br,  =?utf-8?B?w4Z2YXIgQXJu?=
 =?utf-8?B?ZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH] submodule absorbgitdirs tests: use test_* helper functions
In-Reply-To: <20260630020220.1559190-1-bblima@usp.br> (Bryan B. Lima's message
	of "Mon, 29 Jun 2026 23:02:20 -0300")
References: <20260630020220.1559190-1-bblima@usp.br>
Date: Tue, 30 Jun 2026 11:00:28 -0700
Message-ID: <xmqqmrwbsybn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Bryan B. Lima" <bblima@usp.br> writes:

> Use modern helper functions from test-lib-functions.sh to provide nice error messages.
>
> Signed-off-by: Bryan B. Lima <bblima@usp.br>
> Co-authored-by: Gustavo S. Correa <gustavoscorrea@usp.br>
> Signed-off-by: Gustavo S. Correa <gustavoscorrea@usp.br>
> ---
>  t/t7412-submodule-absorbgitdirs.sh | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Welcome to the Git development community.

It is rare, but it happens from time to time, that we see a patch by
somebody we haven't seen on this list, and the patch looks perfect.
Very delighted.

Will queue.  Thanks.

> diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
> index 0490499573..bd1c684480 100755
> --- a/t/t7412-submodule-absorbgitdirs.sh
> +++ b/t/t7412-submodule-absorbgitdirs.sh
> @@ -34,8 +34,8 @@ test_expect_success 'absorb the git dir' '
>  	git submodule absorbgitdirs 2>actual &&
>  	test_cmp expect actual &&
>  	git fsck &&
> -	test -f sub1/.git &&
> -	test -d .git/modules/sub1 &&
> +	test_path_is_file sub1/.git &&
> +	test_path_is_dir .git/modules/sub1 &&
>  	git status >actual.1 &&
>  	git -C sub1 rev-parse HEAD >actual.2 &&
>  	test_cmp expect.1 actual.1 &&
> @@ -47,9 +47,9 @@ test_expect_success 'absorbing does not fail for deinitialized submodules' '
>  	git submodule deinit --all &&
>  	git submodule absorbgitdirs 2>err &&
>  	test_must_be_empty err &&
> -	test -d .git/modules/sub1 &&
> -	test -d sub1 &&
> -	! test -e sub1/.git
> +	test_path_is_dir .git/modules/sub1 &&
> +	test_path_is_dir sub1 &&
> +	test_path_is_missing sub1/.git
>  '
>  
>  test_expect_success 'setup nested submodule' '
> @@ -72,8 +72,8 @@ test_expect_success 'absorb the git dir in a nested submodule' '
>  	EOF
>  	git submodule absorbgitdirs 2>actual &&
>  	test_cmp expect actual &&
> -	test -f sub1/nested/.git &&
> -	test -d .git/modules/sub1/modules/nested &&
> +	test_path_is_file sub1/nested/.git &&
> +	test_path_is_dir .git/modules/sub1/modules/nested &&
>  	git status >actual.1 &&
>  	git -C sub1/nested rev-parse HEAD >actual.2 &&
>  	test_cmp expect.1 actual.1 &&
> @@ -109,9 +109,9 @@ test_expect_success 'absorb the git dir in a nested submodule' '
>  	EOF
>  	git submodule absorbgitdirs 2>actual &&
>  	test_cmp expect actual &&
> -	test -f sub1/.git &&
> -	test -f sub1/nested/.git &&
> -	test -d .git/modules/sub1/modules/nested &&
> +	test_path_is_file sub1/.git &&
> +	test_path_is_file sub1/nested/.git &&
> +	test_path_is_dir .git/modules/sub1/modules/nested &&
>  	git status >actual.1 &&
>  	git -C sub1/nested rev-parse HEAD >actual.2 &&
>  	test_cmp expect.1 actual.1 &&
> @@ -155,7 +155,7 @@ test_expect_success 'absorbing the git dir fails for incomplete submodules' '
>  	test_must_fail git submodule absorbgitdirs 2>actual &&
>  	test_cmp expect actual &&
>  	git -C sub2 fsck &&
> -	test -d sub2/.git &&
> +	test_path_is_dir sub2/.git &&
>  	git status >actual &&
>  	git -C sub2 rev-parse HEAD >actual.2 &&
>  	test_cmp expect.1 actual.1 &&
>
> base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
