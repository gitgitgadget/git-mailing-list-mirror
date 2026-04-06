Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CCE345751
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491215; cv=none; b=VrNEgiQUn0uSfjzCCYmczp8itGfxNJBSbroUyRev+F/k0JKDNpz7bOEk/JrWC9MP5+YEq7radA5cP+7nnIRWPcgqccyrs+vbJlRNsq9TnnFCnVXwrz65PdeD2U08eN8NWGsIKsFb3uqElTKVAfOQCjANcvXi93ak2o4qQSsUyis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491215; c=relaxed/simple;
	bh=Q3gE7fCrRKg8BhfFAJPwZHpS7I2xewKPUqtr7H0PozQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X6SDrfgLMkDC1TMSjyzvSEmIm4v4i8cAN4HYZW7YejGExQedINl4f1TbApFC+v3R2SugP6Uh9kTEJ+GTPLURzMYIDrDc7pQR/zw/1V8ORgJSBf7odo/0LFmgODPjWUNH6eK2r5xoTHZeM32hxC5vkIKDsflqMmRSHKPce+Ny1/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GfFb79Bm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EWkOVGqv; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GfFb79Bm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EWkOVGqv"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 503011D001C7;
	Mon,  6 Apr 2026 12:00:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 06 Apr 2026 12:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775491212; x=1775577612; bh=nJmE6DdaRr
	h1YZMvQEU2hY3kt93BWadJBX92f2cWBco=; b=GfFb79BmiAPqv7NNM901hOV/tI
	qnoZ2TKujZY8MuLE2AVUT5rojH5pxd1Gk7jpn4yBdXgOZYDRAVZ4s5seKeLKrkiO
	A+uHMT+wlKLa5EXHwfLzOuaXwGjSeF4xhWdlkl7E2fqv/XSj/RIcbrDKDQkcg2Sn
	PfbyuWiWbjjTCUpnJUY20RyYltjscRgVS1VnNQ8xH/2D9uuZuzKIbK3owPMGc+rq
	b7TAU85MCeR6rKYz79ZosPrs386KcOcfIOoda29h2c6OKJMuBhseoCB8+QGehhfD
	XroRDAiHDdFpBJWmhJ2UqjbqQVx5Qfc/x5pf5J0MsVYcAkygG8272JNHg+BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775491212; x=1775577612; bh=nJmE6DdaRrh1YZMvQEU2hY3kt93BWadJBX9
	2f2cWBco=; b=EWkOVGqvnFllGYwiMjXqHJSEHFHGrH8M4zE5yi5lOFkovivHj1w
	8XwBqB0IwlVPGMTAGUr4+b+ImI6ViFC5Evn+pDMnix/Y4UBd5rcJZhG4k498kX80
	voBiLAK2r4/OR6zRXy56x338IZ4yMwoEL6ElMOBm9KqCrBxCeFUWaB1spvmrUXHo
	uKinYDd4bjgalVUKS/yoxg6JNBM+MJcaP5Xcy5QPOvkdMG7qOfXMAjMwncgkskJE
	XrINQ9ZclgWoYMQzeMBOaFcFTpuRc65g1frPJtv8be6GPJDLBfNQJtRbClSSwqgC
	aN7EgENy43fU6X+st0nQRYKH03+tHIauJ+Q==
X-ME-Sender: <xms:i9jTae_R-KELKoIUgz3fT3wywQRnPm0rBFL8VtVPYGn1MQnwUQjUaA>
    <xme:i9jTaVvdELHwVfJDIQo0Fzhj789I7q6M7jyybCJeFR1LyouR-Lmd8vZKbFb7hYi2Z
    VuJN7Z2lg60NtmkhENJprzEIOcCUFvYfnfQ5nJEQ1tC5fnCxZys>
X-ME-Received: <xmr:i9jTaZAP3PIeAZiqRbb-IwjUv8bgqteBkptEIZKE3Nd9JGH-7V9Nxx08MhLxyS3TD84SIEYrSrPiI5dVkLl-juNoM4jDt8pm_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukeduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:i9jTaVUOji_Syh5DQ_MlXahMjuXYTNHQbSFx5g1l2llcuFQaqxjSNQ>
    <xmx:i9jTafCt-Xn9IlwmMTm6AUDKUs398-XmYRP5lyhsVlClEnfGSWXo4w>
    <xmx:i9jTaQ_9agnFSQ2vmb84m9z3Ul8DGdi6rMW3Wt7No81KbeppoFgldQ>
    <xmx:i9jTaeFMqPVNn9pKwWKGq_T-9ZdkXmEYRYe_-JHchh2PAoVfw-7trQ>
    <xmx:jNjTaWbm1oYNYuNz3omXqChjxKMlZ2-oeB0g7fBr6XoViKX3a-0hX8sU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 12:00:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 01/17] t0001: allow implicit bare repo discovery for
 aliased-command test
In-Reply-To: <a1cdbd58f0af27be689230b7d8009d93bc34abca.1775332197.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Sat, 04 Apr 2026
	19:49:41 +0000")
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
	<pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
	<a1cdbd58f0af27be689230b7d8009d93bc34abca.1775332197.git.gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 09:00:10 -0700
Message-ID: <xmqqse98cc51.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> 8d1a7448206e (setup.c: create `safe.bareRepository`, 2022-07-14)
> introduced a setting to restrict implicit bare repository discovery,
> mitigating a social-engineering attack where an embedded bare repo's
> hooks get executed unknowingly. To allow for that default to change at
> some stage in the future, the tests need to be prepared.
>
> This commit adjusts a test accordingly that runs `git aliasedinit`
> from inside a bare repo to verify that aliased commands work there.
> The test is about alias resolution, not bare repo discovery, so add
> `test_config_global safe.bareRepository all` to opt in explicitly.

Yes, I think most of the tests we run things in a bare repository is
not about bare repository discovery but how individual commands
behave in a bare repository, and these commands must be kept working
even after a future version of Git starts to tighten the rules.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t0001-init.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index e4d32bb4d2..6bd0a15dac 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -77,6 +77,7 @@ test_expect_success 'plain nested through aliased command' '
>  '
>  
>  test_expect_success 'plain nested in bare through aliased command' '
> +	test_config_global safe.bareRepository all &&
>  	(
>  		git init --bare bare-ancestor-aliased.git &&
>  		cd bare-ancestor-aliased.git &&

So I very much recommend the use of "safe.bareRepository all" in
these tests, not in individual test but upfront, just like many
tests freeze use of 'main' as the default initial branch name.

I also have to wonder if this alternative patch shouldn't be a
better starting point?  The idea is that most of the tests that
validates how individual operations work in a bare repository are
*not* interested in the fact that bare repository access will become
opt-in in future version of Git, but they are interested in ensuring
that the commands they are testing will keep working as expected
when accesses to bare repositories are allowed.  So we'll run all
existing tests with this in the global config after we set up $HOME
for testing.  We'll need to write a very few *new* tests to prepare
for the default change, and I expect them to explicitly remove the
setting from the global config, and checks if the default truly
allows or forbids access to a bare repositories.  But I am hoping
that most of the existing tests shouldn't need changes sprinkled all
over.

Thanks.

 t/test-lib.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git c/t/test-lib.sh w/t/test-lib.sh
index 70fd3e9baf..fe85a0bf89 100644
--- c/t/test-lib.sh
+++ w/t/test-lib.sh
@@ -1563,6 +1563,11 @@ HOME="$TRASH_DIRECTORY"
 GNUPGHOME="$HOME/gnupg-home-not-used"
 export HOME GNUPGHOME USER_HOME
 
+if test -n "$WITH_BREAKING_CHANGES"
+then
+	git config --global safe.bareRepository all
+fi
+
 # "rm -rf" existing trash directory, even if a previous run left it
 # with bad permissions.
 remove_trash_directory () {
