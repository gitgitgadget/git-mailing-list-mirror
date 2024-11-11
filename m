Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E75D13E02E
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731313505; cv=none; b=lebKlO9aY0C5G5GkXnjHDMBBaoHcS83tC4Tnj8C8wqLYOmhDjeYfcPit1F9jKHr54cjRHviicxu+K7IFmX2TcGaZgPRSuh8G3Ds5cYypGLXg8MvGuRuRePL6t3cbEAi2HnPxo4mj0cWTi5tgi50ellPPYPqmEC3eSJNA15OvWBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731313505; c=relaxed/simple;
	bh=90bPXX4G992phG1CGDGQMjv4y3nNkoD2TbrJiVYiSkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P55Z9usd/oaAyKv5EtX64m2WqzzNoyPGuaxbPdjsca6xRy7GVXNZWQw3ilT5qmvYYbw8ngP7+O2LFpDpYIYPALyRPPJYohETfxH/59da/1S8Ui5KrAkTN+RDvfrhcRIq72lMp3FC9iDYVTt/Lqri280zPv3OQ5efAxF/T0a6EHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=muYwwM7B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I3K/uy7N; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="muYwwM7B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I3K/uy7N"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8C675114013B;
	Mon, 11 Nov 2024 03:25:01 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 11 Nov 2024 03:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731313501; x=1731399901; bh=uuITITMcN3
	bOJThWVJLIoE5DnB9Zw3nC4TVKmGr48T4=; b=muYwwM7B4XSh8G8t7U1qfVg6U/
	A7xkhFIgMqlz67zmdcOn4zlH1yE9mjeOpqnS4CDvwGbpzy98Rtg7HJ9LoN651a5y
	7SwK0Pae1gdsRi3nKZkGP5kBlzqyO/UiKrBQ6+u3vlwVETC/FDME8q8vzZyVcIIg
	Thqo4dLQBzy73Ti5cWA6pfR/mkeizhT8HlBMh30WBH4l6CBtUZj+n+GgsNF5IdKz
	Z70hEQFbDM5LMau4L698+3lC0dbPxU9FJLZuZBvyA6bfCOjthtdvWtbRrGt/Li4m
	gUUvYLdyGsOyyNmuVc/VbEbqz5chgBRqcOKdVRClSvPM9k7swYdtQABn0Kkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731313501; x=1731399901; bh=uuITITMcN3bOJThWVJLIoE5DnB9Zw3nC4TV
	KmGr48T4=; b=I3K/uy7NGsOwA1Bs+MahAw2BFocF+D8TH5CDSSRjKRUWIJOxoYm
	toUcsRYKckoKd+VA0JYzppzzkf6QIAoAATmKPzxzmcDW1vXMKca9CWNbi0N02+t0
	ubQG1QE+UTvAHfbi0h0qJEISeCHThIAQ1E4spxYcMutfU5k6/kZsOl2z1Fw/sSnS
	XeoS+G1xl4FjyLdy9LrY01AFBFNxjwro1Ec4kk5zCMhFC2dOZ/0BzNc/A9MbeS3S
	gPnBaWL+eICp7TAaXfkYdLPBSrXzN7/dpIlwkrKMoJ/2/rdp7Sqdjh7xuyhRGC7j
	Cwx5Ve5LLUXMQZPZJpUr3AuUhOLhiAC2y9g==
X-ME-Sender: <xms:Xb8xZzXYFSSVMa-92PHO-Ly7ucAq9J8uk2FKar5xVM2Ce38xEWyMSg>
    <xme:Xb8xZ7nIXoxWg_Kaq3Dx8sBIH4IamlOWgv7GjLgIAUV6uR28gDHQ61SFbV9zmJv1q
    7S4Gq5BSl8sru4gKA>
X-ME-Received: <xmr:Xb8xZ_YEnlws1LRHhLcj5lZFJCZ0HQam9OsXCzn-SFTLUZvEXEKhjw4WAx-NMSZpfl3qWvXmCX1HO9gTJQ9blM1omvzZfe-Tx_1z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehsthgvrghmughonhesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepvghmrhgrshhssehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsth
    holhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:Xb8xZ-WMaJMbtfJkTO2dZ2aFmvzF1yYL5vUUNMruNH_eSU4EWafe_A>
    <xmx:Xb8xZ9l_eWcTgXMXf3JF65jTyEiKoYH0vZ-11kQUqIZp1zHaplRFPg>
    <xmx:Xb8xZ7cBi8KdEymVkyJ_bAcv9RgY6H7SRV6kIeTmurKDWGA6n3H8vw>
    <xmx:Xb8xZ3G2C3JfoVzHHwR6vFkp5G8_sZ3C06FFfD3JymcRcFKMpYZbFw>
    <xmx:Xb8xZ_4WUHdLgbkONuYizIlZyrzIS3ESPSEirWEzZfdWgygis7ug-ZY->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 03:25:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org,  steamdon@google.com,  emrass@google.com,
  ps@pks.im,  me@ttaylorr.com,  stolee@gmail.com
Subject: Re: [RFC PATCH 1/1] maintenance: separate parallelism safe and
 unsafe tasks
In-Reply-To: <20241108173112.1240584-2-calvinwan@google.com> (Calvin Wan's
	message of "Fri, 8 Nov 2024 17:31:12 +0000")
References: <20241108173112.1240584-1-calvinwan@google.com>
	<20241108173112.1240584-2-calvinwan@google.com>
Date: Mon, 11 Nov 2024 17:24:59 +0900
Message-ID: <xmqq1pzich44.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Calvin Wan <calvinwan@google.com> writes:

> +	for (j = j; j < TASK__COUNT; j++) {

This seems to break the build.
Here is what I got from my compiler.

builtin/gc.c:1588:9: error: explicitly assigning value of variable of type 'int' to itself [-Werror,-Wself-assign]
        for (j = j; j < TASK__COUNT; j++) {
             ~ ^ ~
builtin/gc.c:1535:11: error: variable 'j' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
        else if (opts->detach > 0) {
                 ^~~~~~~~~~~~~~~~
builtin/gc.c:1588:11: note: uninitialized use occurs here
        for (j = j; j < TASK__COUNT; j++) {
                 ^
builtin/gc.c:1535:7: note: remove the 'if' if its condition is always true
        else if (opts->detach > 0) {
             ^~~~~~~~~~~~~~~~~~~~~~
builtin/gc.c:1533:6: error: variable 'j' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
        if (found_selected)
            ^~~~~~~~~~~~~~
builtin/gc.c:1588:11: note: uninitialized use occurs here
        for (j = j; j < TASK__COUNT; j++) {
                 ^
builtin/gc.c:1533:2: note: remove the 'if' if its condition is always false
        if (found_selected)
        ^~~~~~~~~~~~~~~~~~~
builtin/gc.c:1508:10: note: initialize the variable 'j' to silence this warning
        int i, j, found_selected = 0;
                ^
                 = 0

