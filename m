Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2502926FA5A
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775668579; cv=none; b=FY6CvkpoGo10EH/L26nnB1N0kjaGoqGr5p4DGVjucVOxnNHG5uDbRMLxXVwyMoOP/tWgd5wIbB3QwKEJvwIUGoZwCoVhhyfStsVYmbAh5AdCr/YpIgMlmrrHZddd601gYsfXcWNir7PTgIRlWWr61Vt46afqGvvsWTgsc3193eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775668579; c=relaxed/simple;
	bh=adKXmv9U/ZvzmLe9TIKanQ8qoIScQmVp8DxlzSmn+SY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=meCjtfkccBP0HnMIyKk9cC+dpX08TT972p9y9rrfJVNPCT8dJf9Zj6kEaGtC/fjdlBLKK8wivz3C3yAbJGTKiM1DEuTeX5P9yxQzEipnm7NXH1MkBtm/ECvGniIYzL30XhMRmS20rzW94pNNQkpLJ+xWmU3fMakFJcQZBbREV5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mc8zOV11; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Le6XfZW1; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mc8zOV11";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Le6XfZW1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 63E65EC01D1;
	Wed,  8 Apr 2026 13:16:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 08 Apr 2026 13:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775668577;
	 x=1775754977; bh=yFzTq/GAkLYea7c0+4gRbHoDJVHGGkVgzVFVYopiqUI=; b=
	Mc8zOV11vNFQ+p6V7GRRxcGoxyshPM5DV6XKC4/1/6YTUx0COVx0aNKIpjgJi//H
	kLh87rEam28lsfT0WGhZfoJtBKH10gnVbK6hRDiRTzIj1IZAKw1LCpdbY7/afeV1
	As9P+/mqW5HNDm3cdu18ejdzkgh8B7Tk2H8PkYGY712QiwhGB2CZCSEwCu1VG1Ti
	zb6PobHpu9QyBvHQJfrs7aryK+zBuaLVP3OmCglhXQE4vQtbju20eMPWKTAQlFq8
	xPb5up+WrGxZUOJZeMO/bhg8F8FVkGVqd1QuBHzHoGkZt/7c32x9yACVa7mSZNwH
	6c7ZhOJdagvJ7m6CirzNJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775668577; x=
	1775754977; bh=yFzTq/GAkLYea7c0+4gRbHoDJVHGGkVgzVFVYopiqUI=; b=L
	e6XfZW1LQ2fmnSRWlYvfmeUZoXlgC6QogimI+sa/wECR8eq1UBYYiiuHyKllxIcp
	qskYpT+efJWZFxPJUGFFSE1/Sl4WUx+51XsbVZY536mPDMzrFVjnsjR20m32U/Dl
	y42rEr4sEKkLPKSrcmrap19mtus64w/h6cvPZ+D8GWathAeiPvF9BHLBTEWZXmz2
	RjyCIOvbFgnOWh6dKfU16l+N8bYRijZHEi5q7TAto68jguVe4zUOl5NF/1PU9EpG
	Cq7obydWEKQivKiug/Z8fupqxYgWZryA6FEJRgvi5NdGjl/7blAMuaTa+dz7simg
	MkIB5nVaN5OrW+ylVVhTw==
X-ME-Sender: <xms:YY3Wab6ijENSxtsSK_0GLgX5csFpTX_k2bbbAeNCiOR0r_vyn4hzgQ>
    <xme:YY3WaX6_bktq31uJv-QWJIFx-Grva8Uft-JRCcF7gcjti8feywtMNiCE3IrhOHpYF
    smXHCUUXXy4ZDNEmr-xcWpI_xQYzYzLFUedVyncOEDyxjIgDWyKNw>
X-ME-Received: <xmr:YY3WaXfKRNh2XOYPa98iSFB3_EM08ucGZctvwswU7klM_v4k2znkDzif9a0GULNeYo1Ft3uF0ABCdvxjagWPFObe1Va7CjV9rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgeduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgeeghfdufeekgeeuiefgjefhjedvjeevtdehgeeuudekgfeileefueetjeei
    ueelnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrug
    hrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshiivgguvghrrdguvghvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YY3WabAsBZRCQ-2Kiig-ULPy75U0t5W1ycuRcAYkVUVRalGuNazICw>
    <xmx:YY3Waa9c2ytqvkfhei3u6JEECNnko1Glf-PAv66UD5Wi33T5d17bsQ>
    <xmx:YY3WaWL-lUPYMkCHOWDyFay2uiBPfCQIFK9dQk17V8yNy0U0pe8KQw>
    <xmx:YY3WaThvrI9fc7RcB7bY6WcfK-1723oaP1Ds6-bVXVq7IjuYDzlLug>
    <xmx:YY3WaXtNa46zmGxBde5ROkeCwOB_n-QGT3TqvlIm08gPdefJDFPycPPZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 13:16:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Subject: Re: [PATCH] t1800: add &&-chains to test helper functions
In-Reply-To: <20260408161148.2064854-1-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Wed, 8 Apr 2026 19:11:48 +0300")
References: <20260408161148.2064854-1-adrian.ratiu@collabora.com>
Date: Wed, 08 Apr 2026 10:16:15 -0700
Message-ID: <xmqqpl49z82o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Add the missing &&'s so we properly propagate failures
> between commands in the hook helper functions.
>
> Also add a missing mkdir -p arg (found by adding the &&).
>
> Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
> This is a small fix reported by Szeder, based on the master branch

Thanks, both of you.  Will directly apply on 'master'.

> GitHub branch: https://github.com/10ne1/git/tree/refs/heads/dev/aratiu/tests-add-missing-and-chains
> Clean CI run: https://github.com/10ne1/git/actions/runs/24137982261

> ---
>  t/t1800-hook.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> index 96749fc06d..33decc66c0 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -6,16 +6,16 @@ test_description='git-hook command and config-managed multihooks'
>  . "$TEST_DIRECTORY"/lib-terminal.sh
>  
>  setup_hooks () {
> -	test_config hook.ghi.command "/path/ghi"
> -	test_config hook.ghi.event pre-commit --add
> -	test_config hook.ghi.event test-hook --add
> -	test_config_global hook.def.command "/path/def"
> +	test_config hook.ghi.command "/path/ghi" &&
> +	test_config hook.ghi.event pre-commit --add &&
> +	test_config hook.ghi.event test-hook --add &&
> +	test_config_global hook.def.command "/path/def" &&
>  	test_config_global hook.def.event pre-commit --add
>  }
>  
>  setup_hookdir () {
> -	mkdir .git/hooks
> -	write_script .git/hooks/pre-commit <<-EOF
> +	mkdir -p .git/hooks &&
> +	write_script .git/hooks/pre-commit <<-EOF &&
>  	echo \"Legacy Hook\"
>  	EOF
>  	test_when_finished rm -rf .git/hooks
