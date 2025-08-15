Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA013176E2
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755283455; cv=none; b=k5F8wEhvWRpF0Z734Ld5EZVTVB23n0agfV2eE9pQVe7YZr3nNSQ7N3oWcfDXSAvOqVO1xX4r27yrcvwpqISk9o7UmdflljNG1VNyNMfkWpQ8L48GchnBHltJaaLgzriZINQado2cNLXvx9uTwhqCa4eh/WrD/haNK7lZfZEdj6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755283455; c=relaxed/simple;
	bh=kf4LLYZsTszPHoS4mgadA6wyKR9ROC3YzSlQkrBESjQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WytYOV40QNbbju4kBB0v1mKuXikL0dc70VR5xa8rQBBAehXZAJOXuouCDYfKRei8l9sbKtudifFeTm2gew8y7wZCAudBxTRi9tEE3eLPxE/4S5Ye9bNTFWPNg8lD2W+dPS7Zsv7P45ppiIXnOO/dCyEarbiyHEJHEfLqLTvV08U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PW9Df20E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OtMGDIxc; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PW9Df20E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OtMGDIxc"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1ACCD140012B;
	Fri, 15 Aug 2025 14:40:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 15 Aug 2025 14:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755283209; x=1755369609; bh=KfVj44W2bY
	BxsDJCe0GLPwtvZ/MW6QC8Bso04+rl1eg=; b=PW9Df20EtaaIg6g2FxRXGZ+GCO
	wXBFH/bzY9XyvbKoGabyJEmPZDEOzSH67judmz41IGwjc6rNbBO16SkfF4nd+dpe
	IePXmQnszg5ti1t0fkPL72sUdTLRHHTjNVLqxp8X9l2XXpQf+UMrUP8CuUScmYQL
	uKVCPxp5nIgWtEv47i7s+MkOLR8T1JP8S5gLh+fQYtOYDiAuVbdG7c7E8skeBEwb
	P7thR3pRWnOIDmDG6Hj9xqASZd8AgifjEssYBy5Ti1IVm379RqceZh/w+2Jy/sEn
	qQLbtJ/9/gI/gFfBceL6uSagDVuao6jIXHIvxzwL5bmLFvrqBqslBzNhFjwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755283209; x=1755369609; bh=KfVj44W2bYBxsDJCe0GLPwtvZ/MW6QC8Bso
	04+rl1eg=; b=OtMGDIxcZIG7HRo5VScNFtOIEXFHE5Phk/Qd4CQ7jCMS65VxacF
	45MXAj9vzVUFDefS2TmGvnUNzWaf+kXx8LUc157tjcEgQaQMoWZ/MllTpCVLrnHA
	uXcz2y2qSaqhQx9Nth4jKxC4j9F8Pdb9seJm6ELp40KRabRxglrktYNBCgmHS4su
	wuS18iZgWdimiGHsYpc3AtzahDne6wcarHTR5TEEA/egL9jLof7zvwEJQK1AQ7gv
	UYnO2DO5j7n+eu8gke0qcgTRr3S6+vZo+LFF7+lKUCoyOrE7zqUKJmtWZzKgaWcL
	hEWgFCsZ3/BE8ieDB8/u1ow9N+RJde/dnhg==
X-ME-Sender: <xms:B3-faJ42YGGVS-JERQeOx_P0rWUji5riOmLuL03J0ORAAwY98f9WJQ>
    <xme:B3-faPh4_zu1OuS8wAsUj6K3P56FnzsRimJRPaq1ezUTH8Wo8g79i83KnDqvi65Nr
    DxrmtQud_pHuxmXlg>
X-ME-Received: <xmr:B3-faH4k-p2aaYXoJGx-qK-fJhI00G_u_Y8krfrp5symwkqYkfVANEvVXc2_3jc7buj5eGcL9W-J0NjEtcEYqmqg6IseXNPzaYM-KkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjnh
    drrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:CH-faMHYPbimLAyDFGBsNtm9mYwCUc0LK6GfO0unA4RAD9WgiI5VCQ>
    <xmx:CH-faBIbMPBdV29hjhLyvPNlP3tUIGKvyh4stZIiLTX6EwBz5CtP0w>
    <xmx:CH-faBjsttWczld-SDHKkMCC72_swqvTVLI5_LPvwPwLWgvwl3UzTQ>
    <xmx:CH-faHlTzv87ltI5ArRbSyjkXlfqv6qcdl96RsaKZTxeeWGTQZjcYg>
    <xmx:CX-faJ9n-TEfFM8zMMXJ9MQatpuuFFPSVNm-0wBzWB_BTlccN7TTipEy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 14:40:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  oswald.buddenhagen@gmx.de,  ps@pks.im,
  karthik.188@gmail.com,  ben.knoble@gmail.com,
  phillip.wood@dunelm.org.uk,  jltobler@gmail.com,  jn.avila@free.fr,
  sunshine@sunshineco.com
Subject: Re: [GSoC PATCH v10 2/5] repo: add the field references.format
In-Reply-To: <20250815135521.44044-3-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Fri, 15 Aug 2025 10:55:18 -0300")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250815135521.44044-1-lucasseikioshiro@gmail.com>
	<20250815135521.44044-3-lucasseikioshiro@gmail.com>
Date: Fri, 15 Aug 2025 11:40:06 -0700
Message-ID: <xmqqfrdsqvi1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> new file mode 100755
> index 0000000000..dca4023a00
> --- /dev/null
> +++ b/t/t1900-repo.sh
> @@ -0,0 +1,50 @@
> +#!/bin/sh
> +
> +test_description='test git repo-info'
> +
> +. ./test-lib.sh
> +
> +# Test whether a key-value pair is correctly returned
> +#
> +# Usage: test_repo_info <label> <init command> <repo_name> <key> <expected value>
> +#
> +# Arguments:
> +#   label: the label of the test
> +#   init_command: a command which creates a repository
> +#   repo_name: the name of the repository that will be created in init_command
> +#   key: the key of the field that is being tested
> +#   expected_value: the value that the field should contain
> +test_repo_info () {
> +	label=$1
> +	init_command=$2
> +	repo_name=$3
> +	key=$4
> +	expected_value=$5
> +
> +	test_expect_success "$label" '
> +		eval "$init_command $repo_name" &&
> +		echo "$key=$expected_value" >expected &&
> +		git -C $repo_name repo info "$key" >actual &&

Most tests compare "expect" and "actual" by convention, so this is a
bit unusual, but I'll let it go.

I know it is tempting to write a helper function like this that
looks overly generic, but I've seen that we end up either tests that
are too hard to modify (because such helpers are not flexible enough)
or we end up adding more helpers to cover different cases, and
either case the presense of the helper does not help the resulting
tests easier to read or modify.

If this were "test repo-info for ref.format only" that takes a
single parameter (format), that might have been more palatable, but
I'll withhold my judgement until we have tests to handle more keys
in later steps.

> +		test_cmp expected actual
> +	'
> +}
> +
> +test_repo_info 'ref format files is retrieved correctly' \
> +	'git init --ref-format=files' 'format-files' 'references.format' 'files'
> +
> +test_repo_info 'ref format reftable is retrieved correctly' \
> +	'git init --ref-format=reftable' 'format-reftable' 'references.format' 'reftable'
> +
> +test_expect_success 'git-repo-info fails if an invalid key is requested' '
> +	echo "error: key ${SQ}foo${SQ} not found" >expected_err &&
> +	test_must_fail git repo info foo 2>actual_err &&
> +	test_cmp expected_err actual_err
> +'

Also, unless we capture both standard output (in actual) and
standard error (in actual_err) from the command being tested, and
instead are interested in testing only what comes out of the error
stream, it is more common to use the usual "expect vs actual".

> +
> +test_expect_success 'git-repo-info outputs data even if there is an invalid field' '
> +	echo "references.format=$(test_detect_ref_format)" >expected &&
> +	test_must_fail git repo info foo references.format bar >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_done
