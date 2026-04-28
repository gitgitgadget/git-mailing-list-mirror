Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF75134CF
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 01:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777340737; cv=none; b=JQTpp+8avTsgWebMMmo0g+XoZDYAUg8v2DrAj6yE9eTTWf+kk0xu9dqHUpyBfhnxPUor0rDi3mrdlX6i1i5zrW1v7T8Na+s53Y0KLnleT+D3DUYT/oJ41fvw/B+BycOQ1jGd615L/QaDCcPX8lYfzoVy2MSwViRO17N0gzy5OBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777340737; c=relaxed/simple;
	bh=z71MSooVeL2n1pqCu9OgnYvkFd8baqTnuoyotf5mapI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qqgsos19TsJhEcQkrBxWHuu2adH3FmvEvlGmg7XW2jtBkywzLdfhsxa/UDQKJey/lwZyoYXdVsvKoAJ3ptSeUDvlQ+B6AowOt+RUgSw57rJZFKmi3ivrKJVUKWcj54EPOjfw3+jvKHxvkmUU0Iah4vbpcESUpZjXzfOjNc731W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ARVgliRq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HbiwMJqm; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ARVgliRq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HbiwMJqm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 25F781D00238;
	Mon, 27 Apr 2026 21:45:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 27 Apr 2026 21:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1777340733; x=1777427133; bh=ZcGLwYfek1
	du+eskoPcGUmrNyveyLVBG4ApVST5OKRc=; b=ARVgliRqT4VIgrCXZSodJw7jdV
	6YOJ4qNWoDuAmx5ZBTXPQ9rRYSwFsqxzHstx1rrtgEW9jpdBmYID+PPlFunXK9Eh
	imPeWhEVRm68arQvzf/nQi9FfPeTPbpwjvw2Tf3/1qWMmsTP+txdrzUZCTJoPVNc
	6KvdDMQjoEkk9HK+IGap+goRn8pyyXYfv1mzPTbl1EcC2bKDDBRhltTcXxxX3ONm
	qpoOTBgWljjumdqp0b1VDrlZn43f/0yYk643HqPxlQ6PdZqzdnN+ikZ1yxZDYA6I
	2YuggtI5YKEyAJEpJdPAxdaZf+FlXiio4Bw03rXeiVqvTYArtHwMmxcOcZ8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777340733; x=1777427133; bh=ZcGLwYfek1du+eskoPcGUmrNyveyLVBG4Ap
	VST5OKRc=; b=HbiwMJqmTilaInjZg10aMiPWOAi3hVFwjFGvC5d5iIQ0AK9EhcH
	kuHSnJc/Tz0U+Xt9WVjPbv5ZsWxVc2X3m5acaWEawy/2oqSju4RWPzShr8Z0gTnn
	zYhrgD+0/4Tz5lh4kVf+co1eXsnh1o5WHuybLryd/s0zWUbIgwr9pZS+T+Mpwpd2
	W+9AM9ZTrgUtLtF1aDWFnbpTMKVoxR1eVh1zB9HyJnP4n2pnl3H0/bPs8rwZjtM0
	bJcFg6E50qUVbhCFvJH+d6CyMfh4/pNWZkG3JS7o7Si6Mh/lOtmYQIBiQKX5qVcV
	/MYCCKauxzWnIOOaZ17lufraMmqTmCbrqlw==
X-ME-Sender: <xms:PRHwaT-n0PZ6rP1u6RmbZGzKG-O0fla3pZqN3QSXnliRSi9G2JGJqw>
    <xme:PRHwaezKlutWp0YGYQ10eKZdwQdyHNVWBSjaj3eQ6XoeFh_e7XiW3Sd7iY4TTsLTN
    pFZcHtVt67BmSwtiMuih1Lj1zTAGJ5Fkx1TK4w-t0-2X_FA5ZjP3A>
X-ME-Received: <xmr:PRHwaXMsoRY2es2i_GvSbHiBTsSt2Om6BEv_f_FMvEVQtnsXCv3IpBdeCFkeMVIz6xf3Hx0jFslWxCIyjqOBO_Lqt4MKals-ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdektddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmrhhoihhkseguvghlrgihvggurdhsphgrtggvpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegtrghtsehmrghlohhnrdgu
    vghvpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PRHwab9cfJnEtJVAH57_PuAxg5P7mEYlO7BOGgV48Kn7yA1nMBBeLA>
    <xmx:PRHwac6lmV9R-orpn20Q8AEq7HWAflWoqbE4_00CMSrz_O7u14RnUQ>
    <xmx:PRHwaZ6qAh47f89UXJosr59MeDUd2cY5x87bsjMqQ-QtYe-5rd-5oA>
    <xmx:PRHwadrp1_xMAw2MccVVvB0A-OeAb2aYnfZz4YtUwA5xsojI8Q_ZKQ>
    <xmx:PRHwadoRzrD-N-XH2ZANUJSCQZCHSXsQHxoKwSL6VpaZBSJ5bUShGXNx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 21:45:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  =?utf-8?Q?Jean-No?=
 =?utf-8?Q?=C3=ABl?= Avila
 <jn.avila@free.fr>,  Patrick Steinhardt <ps@pks.im>,  Tian Yuchen
 <cat@malon.dev>,  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 1/2] revision.c: implement --reverse=before for walks
In-Reply-To: <4864ac46dd8ef4b704c29efc96c45f4e1412373b.1776984666.git.mroik@delayed.space>
	(Mirko Faina's message of "Fri, 24 Apr 2026 00:51:59 +0200")
References: <20260422002840.303477-4-mroik@delayed.space>
	<cover.1776984666.git.mroik@delayed.space>
	<4864ac46dd8ef4b704c29efc96c45f4e1412373b.1776984666.git.mroik@delayed.space>
Date: Tue, 28 Apr 2026 10:45:31 +0900
Message-ID: <xmqq1pfz3lj8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 05cee9e41b..3bfe2c99b8 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh

The hardcoded short object names are setting up traps to fail when 

    $ GIT_TEST_DEFAULT_HASH=sha256 make test

is run.  It also may break when the default abbreviation length
and other things change.

> @@ -1882,6 +1882,72 @@ test_expect_success 'log --graph with --name-status' '
>  	test_cmp_graph --name-status tangle..reach
>  '
>  
> +cat >expect <<-\EOF
> +c3f451c Merge tag 'reach'
> +046b221 to remove
> +EOF
> +test_expect_success 'log --reverse --oneline --max-count=2' '
> +	test_when_finished git reset --hard HEAD~1 &&
> +	touch to_remove &&
> +	git add to_remove &&
> +	git commit -m "to remove" &&
> +	git log --reverse --oneline --max-count=2 >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'log --reverse --reverse --reverse --oneline --max-count=2' '
> +	test_when_finished git reset --hard HEAD~1 &&
> +	touch to_remove &&
> +	git add to_remove &&
> +	git commit -m "to remove" &&
> +	git log --reverse --reverse --reverse --oneline --max-count=2 >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'log --reverse=after --oneline --max-count=2' '
> +	test_when_finished git reset --hard HEAD~1 &&
> +	touch to_remove &&
> +	git add to_remove &&
> +	git commit -m "to remove" &&
> +	git log --reverse=after --oneline --max-count=2 >actual &&
> +	test_cmp expect actual
> +'
> +
> +cat >expect <<-\EOF
> +3a2fdcb initial
> +f7dab8e second
> +EOF
> +
> +test_expect_success 'log --reverse=before --oneline --max-count=2' '
> +	test_when_finished rm actual &&
> +	git log --reverse=before --oneline --max-count=2 >actual &&
> +	test_cmp expect actual
> +'
> +
> +cat >expect <<-\EOF
> +046b221 to remove
> +c3f451c Merge tag 'reach'
> +EOF
> +
> +test_expect_success 'log --reverse --reverse --oneline --max-count=2' '
> +	test_when_finished git reset --hard HEAD~1 &&
> +	touch to_remove &&
> +	git add to_remove &&
> +	git commit -m "to remove" &&
> +	git log --reverse --reverse --oneline --max-count=2 >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'log --reverse --no-reverse --oneline --max-count=2' '
> +	test_when_finished git reset --hard HEAD~1 &&
> +	touch to_remove &&
> +	git add to_remove &&
> +	git commit -m "to remove" &&
> +	git log --reverse --no-reverse --oneline --max-count=2 >actual &&
> +	test_cmp expect actual
> +'
> +
>  cat >expect <<-\EOF
>  * reach
>  |
