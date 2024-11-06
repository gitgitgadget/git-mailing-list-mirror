Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E611DED75
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730901891; cv=none; b=LgmT5KFy1FQBXpC2l7ci74pR5x/em/mNtZj+dYY9lKP+0DPFFfHl7PpvgI4aig8d13K5XvjthPov2H8AmBbKcWoIBUW99MXE4sSuH9J5OO4XvA6+F4ryygWSbWrbSm4GyuXG9Tfnvy3gYVvZgOFlMdjwxYL0fadBcyfuSvRhGHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730901891; c=relaxed/simple;
	bh=J80K+EugQOP4aR7S4d5ubD67bkQVqIRn7oBoeWpaPUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHtVOgIZoyeXHpu4SQ+Th5KVmmGdgXGih5buWfTnAfaTf7atfy4r5D+cuTK9NExEEB3avG+a0/xaYOuD0P1KHnuyRMtCrnQ4z1XxfooJc77yYqJUMa/DN7XQRb9NnMwbylqWN14BTbh7s0Z9t/vaN4mPym7sN47CLjdxyXKC0dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lAd+2SQH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kOjcIkOJ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lAd+2SQH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kOjcIkOJ"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 8EE5B1380648;
	Wed,  6 Nov 2024 09:04:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 06 Nov 2024 09:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730901888; x=1730988288; bh=GULNz/4k8M
	YeLTERgAFFfpCrlvuZimI5+PxhUAObG0M=; b=lAd+2SQHy7HirgF8Qji75C9+yA
	B9lqIMDpEXme0K1kPv8q4641hZ3UJ5Wqdsr9M5DUlfRdCMd7+0+6+V62hd/ESp0D
	KSo1+V1Gv1axG3OpSHZG2PrBXCwNPIMkjRRzYmJ/0Zzli9WJXtAMiUw1eImKZY4j
	qjLM1DvMdKxJH47mghHCLZ6UcZVfD+cLZzze7tRXd+tD7zkimXzhvwqtpSmbhzwX
	A4wqrGei/qPybcxvAjtuBFJKO5w8BsF52XslFXrJlg3Mw2ePJ+ZkGBxtJpBrRE5Q
	0Vi/hfYoppPUPWYYYIu2FnYka81M+EKtJnlWJacJmvxhOndIJk3yke0W3ayw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730901888; x=1730988288; bh=GULNz/4k8MYeLTERgAFFfpCrlvuZimI5+Px
	hUAObG0M=; b=kOjcIkOJ50Uhvs09N92+xMP4LyrpZ4H/qEfJRewGpLGqPe3ylaT
	D87RJjZoeveritaGPffWuaRYHWTh+YQeC8mftP7/WYLCdrxX/iQ1cIz0MgFgvvZG
	TfRHhdhIRl3c/fUPlaczpzVXiq8rx5cGQ3X3m+2s/FeeJQJUTdOB0XqAFCHBcZKk
	T5Z5e/xSLJA69kvM9u3TFCdjcueXfdWhArGYDe/smMmnXWP+G2q+tKz5T5cV5T7K
	yG1+I5jMS2RbrFE5Nk43e6s7anyOQ051leJV9bG2ApCSmkTV93wF80bQu2YUpN05
	Wnj/s2Pv5Oo1tm20B5iq81nEWfNL0zmPErQ==
X-ME-Sender: <xms:gHcrZ509SvCS-jL_QrxZ6siusHSV1jqrzpXVjsod8BA2ZzM-sWCanA>
    <xme:gHcrZwFmqT1mgmVSK6gZRrUm3LIhar0M85IEHzIG9oCaH_-ydE2Mh-vFaIYLOGvE4
    rERQkHhOV1bj37IPw>
X-ME-Received: <xmr:gHcrZ56sEVFsoZvdUyh49PsItnRXRrtqnMVRMsQ1BK9SUuVhOKH2RJsBi665iolIIg1VHOv_aOLRL6aIYJrlmHKd4C-gsKKX9pNgYxOdFYA-qA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhope
    hmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjhhohhhntggrihekieesghhm
    rghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehjohhnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:gHcrZ23fJ9AiH4aCYsyjUGmNfNMBQCDlkujnRF0T7gYki0oIbVp-dQ>
    <xmx:gHcrZ8HTdS4YtqV-0KnA0qnWhcoX_ooVDxDYcTBHpk762_TV5nPcWw>
    <xmx:gHcrZ38rPblN7hQhtU8IASIgdfKk7T7hYCvNkr-Z_RPw4YrfMUPXdQ>
    <xmx:gHcrZ5kw0YHlsu57AYsAYPdBWWwJtZcE-4ynLeArsCqETwBeSqHsDg>
    <xmx:gHcrZzeJfqRirkjShm2bw1MrBjn72g_UB6X4j2sVYZS2h3xRhJx7Ev03>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 09:04:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c63b54a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Nov 2024 14:04:22 +0000 (UTC)
Date: Wed, 6 Nov 2024 15:04:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, me@ttaylorr.com, johncai86@gmail.com,
	newren@gmail.com, christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com, jonathantanmy@google.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/6] t6601: add helper for testing path-walk API
Message-ID: <Zyt3aE2yNOgDyw4Y@pks.im>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
 <6f93dff88e7cf81800c8f2c8d39175d962a0576f.1730356023.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f93dff88e7cf81800c8f2c8d39175d962a0576f.1730356023.git.gitgitgadget@gmail.com>

On Thu, Oct 31, 2024 at 06:27:00AM +0000, Derrick Stolee via GitGitGadget wrote:
[snip]
> +int cmd__path_walk(int argc, const char **argv)
> +{
> +	int res;
> +	struct rev_info revs = REV_INFO_INIT;
> +	struct path_walk_info info = PATH_WALK_INFO_INIT;
> +	struct path_walk_test_data data = { 0 };
> +	struct option options[] = {
> +		OPT_END(),
> +	};
> +
> +	initialize_repository(the_repository);
> +	setup_git_directory();
> +	revs.repo = the_repository;
> +
> +	argc = parse_options(argc, argv, NULL,
> +			     options, path_walk_usage,
> +			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_ARGV0);
> +
> +	if (argc > 1)
> +		setup_revisions(argc, argv, &revs, NULL);
> +	else
> +		usage(path_walk_usage[0]);
> +
> +	info.revs = &revs;
> +	info.path_fn = emit_block;
> +	info.path_fn_data = &data;
> +
> +	res = walk_objects_by_path(&info);
> +
> +	printf("trees:%" PRIuMAX "\n"
> +	       "blobs:%" PRIuMAX "\n",
> +	       data.tree_nr, data.blob_nr);
> +
> +	return res;
> +}

This function is leaking memory. I'd propose to add below patch on top
to plug them, which makes t6601 pass with the leak sanitizer enabled.

Patrick

diff --git a/t/helper/test-path-walk.c b/t/helper/test-path-walk.c
index 06b103d876..fa3bfe46b5 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -85,7 +85,6 @@ int cmd__path_walk(int argc, const char **argv)
 		OPT_END(),
 	};
 
-	initialize_repository(the_repository);
 	setup_git_directory();
 	revs.repo = the_repository;
 
@@ -110,5 +109,6 @@ int cmd__path_walk(int argc, const char **argv)
 	       "tags:%" PRIuMAX "\n",
 	       data.commit_nr, data.tree_nr, data.blob_nr, data.tag_nr);
 
+	release_revisions(&revs);
 	return res;
 }
