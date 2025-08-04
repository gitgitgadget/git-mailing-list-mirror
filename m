Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE5723AB87
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754294209; cv=none; b=LsuJYdyVzx+SwEGrT6WzzlsKGLzK0z9inZeGQa/+eo5s3ERrw6ZCaBS1mLiLLt+ePnNcngcJn5YCi0wInZIVU5y7pUdBp+K/ZOT2RqcCyCXZmIkIrHwlHRVKqrYSQnr+lZycfmQu5Rt4+XAVGkm6JSd4mWJ1jdcUE+1X8KdoLdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754294209; c=relaxed/simple;
	bh=4IIKBfjON0bu+Z3iH/c8/I3u9BoWfIyuQU5sDMVFY/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+SPzBkf2+Yc038vC9P5dWfeJaKNFxR6I+D0316JSIGEkkUP/1vgwcxuUB/wd+0rBtjr/jPMIwayc/jJdsnTRZ3ERZp0sK1t2XlmtP6cs90UXd64Tdn/f8luCQUQ5Yxe42mItzE8FDWuZqZuPmW4NMRSFXGrr+s6PN6AZKT5cFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=da2M86c0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fYYZlJBe; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="da2M86c0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fYYZlJBe"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C252E7A008F;
	Mon,  4 Aug 2025 03:56:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 04 Aug 2025 03:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754294206; x=1754380606; bh=zJNwf7PBIk
	+JKmdQgnAuWU78ptrEgO0mhkPKf2HBgV8=; b=da2M86c08Z2nSLMkPCDEKTJ134
	8rTYeEE2giCn28+COmp9fIiPhfs9x5p/x31sZvv+E028TkOyoSvxnzQGG251u89B
	FFZ5ggqKWCnbIyhALkGyHHjAdhrA4/TpDWJFG96PFKjrRML0pwptQfJFnXtJb+cU
	aS+uD1wp//XjimXNnNaaYPnQGwrkAGxQZ+ZL7BAfjrDMQQGtHhZjkxLhjVxKBCwb
	U03t3gVAfmJxv/eEml8bg01N+lB48fmWVQ8pW1m/4Ww1+0fd4iC2gyg1Ra+do9Ej
	NHRuUYqwxN98gU7fkCsGEt+08EVMk0v2fMem/UuJDCnSvSQ27AUmlk/3WBfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754294206; x=1754380606; bh=zJNwf7PBIk+JKmdQgnAuWU78ptrEgO0mhkP
	Kf2HBgV8=; b=fYYZlJBeWeyU7JCoR3d2RNLF3Y5pegGtb81E/NMUyWL50R7Ocx6
	okxlrehVH1LoqL/LhlGm4adwO4d2e+RCe4liUNiJYnrbEbyoYZR6yq4lDRLjcDMS
	tAyDyclBuF+3hc6Wzc9mruuC9EAtbv5Aas7pNslMVXxAURyKg5H53GClWEbPmWmW
	1+5tj0/02CoMdaT3rumwY5n5jdNUhLhbgIfmTqe7+aGurOV1H3B3JuPzyLEIZw0h
	IuRW7Ehymwmls68f7WuqYCXtOymP/kEWUnPvOII4OQFEkKsQcyHewA/HARQVJvPA
	0jZn3nH6lYsUGsFLb6VZYkWS3k/1k4hN6gA==
X-ME-Sender: <xms:vmeQaH9b7DdKILxUkFb5zMWLXpdTd6lJtWNOCjGzgRnb9U8McyWniA>
    <xme:vmeQaD4FNNnKwK3Z8K9lG7DhNmS3cwbABC-e8sJNP8-mQ7yXpy4X3ACarOm7gfbc-
    5ahlsTbliPi1HbdRw>
X-ME-Received: <xmr:vmeQaG043vjcMQod5PQt3jeQgTpO5wHhT7_lrjKvkZt8uDK0oL64EhV5CFBnm4D5ETA3Rhgjdpvv9rPHm1TPzT_sn-0uqww-4e0FdXzu4Qs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddujeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vmeQaCBykhFz6ezLq9RnblVqxSPBmJtmZxx9przF7Eplqbs8MyhsuQ>
    <xmx:vmeQaA1D-6A8qBbpZj3SD7mlRHjR-CEnXBKiTgm1kY-5-L6m8hJBlg>
    <xmx:vmeQaEvtyTrjXy0zGm7qz87wS7F4DdY6qDSJWdUvAUeNzSxbVroisQ>
    <xmx:vmeQaI5iIfA4FhZAzJA56m5RBrZOYNRq0gbRdnZAM7uZFPKC8rAejw>
    <xmx:vmeQaKgChJ1gEKe1tYGbkHJbqQqWiyejU41dJLBnJrOcRpX0tGW75PEn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 03:56:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 27d42ebf (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 07:56:44 +0000 (UTC)
Date: Mon, 4 Aug 2025 09:56:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t0450: fix test for out-of-tree builds
Message-ID: <aJBnuOcQQ1AY6hR4@pks.im>
References: <20250804073002.1586332-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804073002.1586332-1-toon@iotcl.com>

On Mon, Aug 04, 2025 at 09:30:02AM +0200, Toon Claes wrote:
> When using Meson, builds are out-of-tree and $GIT_BUILD_DIR gets set to
> the path where the build output is landing. To locate the Documentation
> sources, test 't0450' was using that path.
> 
> Modify test 't0450' to use `$GIT_SOURCE_DIR/Documentation` to find the
> documentation sources.
> 
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  t/t0450-txt-doc-vs-help.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
> index 2f7504ae7e..da2d0af5b0 100755
> --- a/t/t0450-txt-doc-vs-help.sh
> +++ b/t/t0450-txt-doc-vs-help.sh
> @@ -41,7 +41,7 @@ help_to_synopsis () {
>  }
>  
>  builtin_to_adoc () {
> -       echo "$GIT_BUILD_DIR/Documentation/git-$1.adoc"
> +       echo "$GIT_SOURCE_DIR/Documentation/git-$1.adoc"
>  }

Ok, the change itself looks reasonable to me. One question that the
commit message doesn't answer though is why this didn't cause the test
to fail. I think the answer is that we have the following loop:

	while read builtin
	do
		...

		adoc="$(builtin_to_adoc "$builtin")" &&
		preq="$(echo BUILTIN_ADOC_$builtin | tr '[:lower:]-' '[:upper:]_')" &&

		if test -f "$adoc"
		then
			test_set_prereq "$preq"
		fi &&

		...
	done <builtins

So we explicitly check wether the ".adoc" file exists, and if it doesn't
we don't have its prereq. All subsequent tests then use that prereq, so
we skip all of those tests with Meson entirely.

Which indicates that this prereq is overly loose: ideally we should not
skip such tests, but rather print an error that something is fishy. I
suspect that we have the prereq in place because there are some builtins
that don't have a corresponding manpage though.

Maybe this is something we could explore: what breaks if we remove the
prereq entirely? And if this breakage is limited to a small number of
builtins we can maybe use an explicit skip-list like we already do with
"t/t0450/adoc-help-mismatches".

Thanks!

Patrick
