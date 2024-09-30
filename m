Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7243BB21
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726483; cv=none; b=okTGut9F5FN0FTNfMHjfmqxjjYKV2h40wnbz2/gai5An0kQU/YD5xJoqJYBo09Ssqw1PFuEh8ZpeUSoUIiTwYpYaKC11wWL204NxOCp0yL9eZ5FBQO563vfal1zo8DsApDdDHwTxdsCv+U4AX/ixskEb+rYIzdg8BZZkEMWCYoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726483; c=relaxed/simple;
	bh=yEMn5UF2FWK7nkty5aECwm3IUPPxnQppEtLEgSyX6co=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k+6cjb4zirQEcTzFJNZE4Lxkk2ao2S3CHIj4BNcz51xZQEDXvN/Yvife5e+r3GrGU4uGGE4ylQK+NxfZhqO2ddQyaF9uHZAfzXByHzTYSN8URumLVCluxn/BsJIVpPpyYPVY3Mtvc59p/TG1e9U6us+iZPQtyac6ODafTdbjWCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WZQnDs6R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V+HRwBAj; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WZQnDs6R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V+HRwBAj"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id D287A13801D9;
	Mon, 30 Sep 2024 16:01:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 30 Sep 2024 16:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727726480; x=1727812880; bh=kRz14oDImh
	uAifaUWPlxef8gqfX73gm1h38JhuSL6Ro=; b=WZQnDs6R2+Lh4Jm+dHfHgSyNF7
	gpw90//mplPpp8tom9iZcEpKVeveW9e4wC54i7rowEXlpKDYHtRmNEAk3fDNEDxR
	/IikgduIBJ6zuB5VrQeG17KPmcqCWm8XupC9faDKLeFLcLoxbch71wCJsY39VmbB
	JjW0oqm97xdFiN1Yr0fXoSp5cfE1c+aBVKAX2JWBzHDwgMhJ2WrkOexpPLg+bKQW
	BFNKC/yzUWLwIi4NyeH+BU8HrbnpsQe2WTCU4CqPgDCKn1MNSyxVRkDT8norYr8u
	W1upEG29LU7Jd+EtMg/CMWTFzXgln1Nrdo6XEGQzUqqnxnP3WwYr9sqvPe8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727726480; x=1727812880; bh=kRz14oDImhuAifaUWPlxef8gqfX7
	3gm1h38JhuSL6Ro=; b=V+HRwBAj80cHdNk7L0+aj8cJjDt8mLC/a1tjFUQpOioF
	H2+Nj1Q7pPtKyAjUXQ0QUxfF1GyYs3PxSSlBJoz3MDuY+toWQftETn3E1Ye6klhn
	puu+RQQTOiZur98sZ2yl0svocpHZN0WeKMFIh+pczCyZyvYz+eSMMwh8fHvfel2x
	HxyjKroFMuh134MVhlndVNgVWkPJWoOuwATRAzRdyJrOmKeLRgUFnrwlIBrVX0m2
	hdFAfd6PVYgfs9m0/6ZTZWZtb0DaciW4FQE2CdVYiPPrjKrNNTT65GDQb4f3e6dc
	FiFQRSVEdhZ1Vvm5HnSJf7iB3NJGwmghxeMpvbd0iA==
X-ME-Sender: <xms:kAP7Zn6vOK2DKiLdUPGWAmSeidzVyJMNpWEFRl2Og2nHOzOXjuJZ8w>
    <xme:kAP7Zs4I7AI4BGsq3RxXiRvG2fJ2oGtXwwMJw3221hODXcbB5zy0IpKajiDHE5dBN
    pG8Z2AkHaFMbRDDew>
X-ME-Received: <xmr:kAP7ZucrsQek-8o-NldRmXA3Q6PDEPxL-3HfI-FHZ8gvtXGWp9_2KgjrM7qQK6DlwFizTmp7ndTU93shoCVii2yciJPEFEfyki39DSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhohhhntggrihekieesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kAP7ZoKnuIMwO_IGf3X2RnNrRZLlWImpfuXjRfJ__vpAeqGnfUNGsQ>
    <xmx:kAP7ZrLiOWDWXWb9Skrg_yEOXM6hQxnXjRqFfllwVowAV1yHPOn86w>
    <xmx:kAP7ZhwOUNNxpUBJUy3LBn7b56Vi_AjbrbUW38cktaDmXJrXgkCVXg>
    <xmx:kAP7ZnK7MKJ_2P2-iBoOAxccQM9gH682Mv1C3X_CsQAu3wn5CnxzMw>
    <xmx:kAP7Zj_wSN3hzjxTKDOAP6goZmYsdy_6lhvrcTr8CPeDNKvkxpQmQJse>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 16:01:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  shejialuo <shejialuo@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 4/4] archive: remove the_repository global variable
In-Reply-To: <857291d7f7dffdd1a63ce9268c8ac91a82f2bdb5.1727718031.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Mon, 30 Sep 2024 17:40:30
	+0000")
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
	<pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
	<857291d7f7dffdd1a63ce9268c8ac91a82f2bdb5.1727718031.git.gitgitgadget@gmail.com>
Date: Mon, 30 Sep 2024 13:01:18 -0700
Message-ID: <xmqq1q106hdd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -#define USE_THE_REPOSITORY_VARIABLE
>  #include "builtin.h"
>  #include "archive.h"
>  #include "gettext.h"
> @@ -79,7 +78,7 @@ static int run_remote_archiver(int argc, const char **argv,
>  int cmd_archive(int argc,
>  		const char **argv,
>  		const char *prefix,
> -		struct repository *repo UNUSED)
> +		struct repository *repo)
>  {
>  	const char *exec = "git-upload-archive";
>  	char *output = NULL;
> @@ -110,7 +109,7 @@ int cmd_archive(int argc,
>  
>  	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
>  
> -	ret = write_archive(argc, argv, prefix, the_repository, output, 0);
> +	ret = write_archive(argc, argv, prefix, repo, output, 0);

This looks OK, but unlike the original, write_archive() now needs to
be prepared to see NULL in the repo parameter.  Is that reasonable?

Perdon me to think aloud for a bit.

The context before this hunk handles "git archive --remote" which
can be run outside a repository (and that is the whole reason why we
ask SETUP_GENTLY), but this part has to happen in a repository,
doesn't it?  Or is there some mode of operation of "git archive" I
am forgetting that can be done without a repository?

	... goes and looks ...

OK, write_archive() has its own setup_git_directory() call when
startup_info->have_repository is false, so this happens to be OK,
until the beginning part of archive.c:write_archive() will not
changed to start dereferencing "repo" pointer.

That sounds brittle, but probalby outside the scope of what this
patch series wants to address.  It also makes git_config() calls
even before it realizes there is no repository and dies, which
smells fishy without actually doing any harm.

So, after all, I think this step is probably OK.

Thanks.

