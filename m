Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE3A1CB528
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805876; cv=none; b=NIy/lv+q9AiACE9IPWwZGvdwPd3HzNnJkyctmGg+3ct+vdenbaYVmoax2PWoHCwzjBbGh8fhA3IAz6GGJn1o3vBQSbr9wCtKtKCAsJht1jCTIM9tO2VF6KVO7zZY2fixio7oXLZsq0sKv8NN74DxK6IMgdF1QSaGIKxoiNGqLaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805876; c=relaxed/simple;
	bh=RAp7iWIWfVUoVzAYTFW7VCaD0QcpFasuhjdz1OGsAbo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cdHGBh+7WsIniSXbJ1nTYwa52sOg7huusxW2V40yqfFydQwmDRdSHEer6eyBb66snR+KcYeedb+PgxrpjEcVsBYq9nct648tC2K768jtnZ5IIBGH8ZfFLkt0MJcrSb2W7w4CEIo6Edr/d8C0+npL+kLBjVgJG/kPBHRCtpoT/oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E1RCiqfG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y8U3O9DC; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E1RCiqfG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y8U3O9DC"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 3D81F1381125;
	Tue,  1 Oct 2024 14:04:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 01 Oct 2024 14:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727805873; x=1727892273; bh=k0OebRCXtm
	2rTaBvIS7TFZxEU2jqXvQXnCGf9kpsZIU=; b=E1RCiqfGirULsrS8iTdSwHCGtT
	6SKE1mocopYO2iVekOGSCtUKnG8IhEPvlAUyNcLLHDPvCU/GCyXPycVKhalZYrm4
	n8wrtU0E3SPQGFwjCKCdlVA/9kUItKCi6Eu0ujt1a23YmiO/MzjdtWaZnK05q4EQ
	0YO9xfcVZV3aEtm1JUr95uW36+yI+IWopZJFzUpzFCx8jrQG+z6NBwf3pjTbaHMU
	lySDmVAyIkOlYXJ/UMXNnMcaubolrdAymw2qNkACKEwoiTOCiieo0BNxVhhQXKF5
	8Hs48f//EVsLtKYz1hIauHo3nrTyxNllYaHCUDCQIU4B90Pa8BvDL5ANMqog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727805873; x=1727892273; bh=k0OebRCXtm2rTaBvIS7TFZxEU2jq
	XvQXnCGf9kpsZIU=; b=Y8U3O9DCOMFivww+qrw9udhkgGcUi+f7TanNKWw5RDHq
	9uL5g6kPOroZst4YRzk122pq1W2YENjYlo/j8rbbHZbCN3lDbQ/iz4PbZc2Qylo2
	XilCQ7vIZlBlhR/qmo0PB9vAKvAFovwlyYyg1mgNJaaCiLl6e5B4u4TZboVXfopY
	IFqNxq1ERljAcfrtHKCZ1kMNiDtkScOXWoOJkpUbf3VQxbvDN2LB5Q/HGCnljQz3
	KauL9/nkq5z8ycWZEfQdSLmp8ymNHd209HCpR6rdfYF1l/ykPWEKDapl2zun7g6R
	ja05uFE4WiUg8IhpkuYEWpYDprdxEvkjC4vAI/i2Xw==
X-ME-Sender: <xms:sTn8ZnerhJHJG54r04NcPl4vqrkuU9dZT-ZUYY5ZnlxDFph-GQVgaQ>
    <xme:sTn8ZtMHNLODpgm5VfC1zXIYhuGQn3hmp_tdlYgY7NTMsM6Kd5GFx4wDeCrDG1zKb
    _q4e7dXMuScL-cgcg>
X-ME-Received: <xmr:sTn8Zgg_EzQBfY-JfLzOAc4SH13Ij79_MFVRR4JebUbqT-A65lNRR7NgAoHQZ88vAE9DV4oOCy2xAPwYV-oiJ76kV6N09nNP_gnbV2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkohhjihdrnhgrkh
    grmhgrrhhusehgrhgvvgdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sTn8Zo9yFseZkqY-GTkn7IT7J37Alz8zs2Z-5DGSQbj19Z15uYMVZg>
    <xmx:sTn8ZjsFk8m2l89-67NYSAUFaU60x7DwrGtizhPNImm6uStZeP9WFg>
    <xmx:sTn8ZnHYlmdcDXuTae40QNSAZV6mDQ9WcZnHCVAzj5rwWFXJSIyC8Q>
    <xmx:sTn8ZqM_eZoHo2icJU8CQkfoAkrNnof_yS3YjK5fzAsK3nTNkY4SeQ>
    <xmx:sTn8ZtL_p_wp9liWC9CaV-7wRI9VmnkukGTysS4UFj6fQ0Ua-GgIkB1P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 14:04:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Koji Nakamaru <koji.nakamaru@gree.net>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v2] fsmonitor OSX: fix hangs for submodules
In-Reply-To: <CAOTNsDyg2SB-wd+a7vrctXck46jyfqV4uME6nf4YQZEafWbxMw@mail.gmail.com>
	(Koji Nakamaru's message of "Wed, 2 Oct 2024 02:51:47 +0900")
References: <pull.1802.git.1727577690390.gitgitgadget@gmail.com>
	<pull.1802.v2.git.1727759371110.gitgitgadget@gmail.com>
	<xmqqwmis11f7.fsf@gitster.g>
	<CAOTNsDyg2SB-wd+a7vrctXck46jyfqV4uME6nf4YQZEafWbxMw@mail.gmail.com>
Date: Tue, 01 Oct 2024 11:04:31 -0700
Message-ID: <xmqqmsjnya1c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Koji Nakamaru <koji.nakamaru@gree.net> writes:

>> > +test_expect_success "submodule implicitly starts daemon by pull" '
>> > + test_atexit "stop_watchdog" &&
>> > + test_when_finished "stop_git && rm -rf cloned super sub" &&
>>
>> If stop_git ever returns with non-zero status, "rm -rf" will be
>> skipped, which I am not sure is a good idea.
>>
>> The whole test_when_finished would fail in such a case, so you would
>> notice the problem right away, which is a plus, though.
>
> t/README discusses that test_when_finished and test_atexit differ about
> the "--immediate" option. As git and its subprocesses are the test
> target, I moved stop_git to the current place. This might be however
> confusing when someone later reads this test. Should we simply put
> stop_git and stop_watchdong in test_atexit?

That is not what I meant.

I was merely questioning the &&-chaining that stops "rm -fr" from
running if stop_git ever fails (and your earlier iteration you had
multiple "rm -fr" ;-chained, not &&-chained---not using && is often
more appropriate in a when_finished handler).

>> > + set -m &&
>>
>> I have to wonder how portable (and necessary) this is.
>>
>> POSIX says it shall be supported if the implementation supports the
>> User Portability Utilities option.  It also says that it was added
>> to apply only to the UPE because it applies primarily to interactive
>> use, not shell script applications.  And our test scripts are of
>> course not interactive.
>
> How about the following modification? It still utilizes $git_pgid to
> filter processes, but avoids "set -m".

Nah, your original reads much better, and the code is grabbing and
using the process group information anyway (and my question about
"-m" was more about "should we be relying on process group features
in this test to kill them all?").

I am OK with the idea that we can assume, at least among the
platforms that support fsmonitor, that sending a signal to a process
group would cause the signal delivered to the member processes just
as we expect.

Thanks.
