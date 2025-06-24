Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE88487BF
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750800759; cv=none; b=CpNjH7RsVpQYO5zwuNvsl7BuKW5Ma6uH/vAjwTdQbQIkDf2MvZkBG0x+O4oczW3oe8Qo888EgetE5wY8dDWSeQMHPZ84WhpFnF01loOmC0L8jL7fiMTV0hFzPCeNj3p67gWJqOPAhV9ekbqaGd3T5LdNT6WnaJK2tskBgrIS394=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750800759; c=relaxed/simple;
	bh=FZ0bebqemaBvsIpJ6LryHRaI3QKUE3Xz/2d090oYjoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KIwahrSW5wJT8mdSLPbUmofRnoSlQv+RmwdG/pS1WjULp5EFf6PbIM0ibGcebfRjofj0RoICGsL6AlkoezcIpthnjiNcfhJQzDolD78ro1pqnF6T0KO19oxGYSAhmWRyQ4z7eSJ0frjQsxRrdvKx9zPmnhsi55DBau3jGGV7ueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PVbioWPr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g7PcnMOz; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PVbioWPr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g7PcnMOz"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F397F140010B;
	Tue, 24 Jun 2025 17:32:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 24 Jun 2025 17:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750800755;
	 x=1750887155; bh=ApgCsCNoyqDJnscW689gv4AcmdLr86DKn9kErPwO/Ps=; b=
	PVbioWPrj2tiTY/YXXgWQ9qbzgig1mks+yOFI7uP1bdKlWet8Rw1fKQW3YrOSDUf
	WzfExdXQXl/pw7U1U6p8ffRf49bmAgKrE0R/BwC8dRmWmHB/JzMns+JT5VZNz9P+
	qjMeVe8hRlMbGgpMpHjW/BIH4RZsiddy+slyWlX/jSzRVFk4HUnUWGrK7icXVPQt
	+wBng3jg89KMpNWUzRacPofIwDua7tuLCc/czcOtBhDnG1uDqKR2R18P1un3ipFL
	5DgFTL3cri2IM1lNZipY7h/Llco5zsu0wv8xzDgroraDVCrqPBoXQf4pWjVDbQ2A
	Dr/N/lJXNAJ3qfXFRhfQzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750800755; x=
	1750887155; bh=ApgCsCNoyqDJnscW689gv4AcmdLr86DKn9kErPwO/Ps=; b=g
	7PcnMOzGg9LJQdacXcxaxWwGOGi8WIQpUdmdvoqrzMD4y2pQx6i4QmKJh5RMLhqf
	QrKJOCV9cFU++BAvt2IleIp4GlAfo4/aGdlh3jOKKl49JA4klwz998nK+jp7YikH
	m0EiZZ1XhtFuCpQGKUKUpkMIsStVeaM0yyuCfYSGl3EniKUX9oiFiTZkYmzFcpSr
	MK0poDJv5/r8HF4ijxOe6qxWNG+nEUCAr7PR/38DPdQqSQKTd7/Ga5DemrNvqNeV
	VKLfdUuPWIsQQ207WWaRim9efIMaDMH5A3pRxRmufOmJre/Hn9mCl3saUXrint5F
	xEmkEG+Kf781pRFM5t7jQ==
X-ME-Sender: <xms:cxlbaD9DBEoepxYMRPUuy__stT6kbfaLV1QsJLECuSsfNAq5EdLliA>
    <xme:cxlbaPtXRUAvfQaxtTs1BKUhZ78gyKXz_2tC-xD1O5hBGMF9inYBFffC79YdoJ_CJ
    ANPaE2z5fs_4vKiPQ>
X-ME-Received: <xmr:cxlbaBBQVmepXY4UjpCmsXoTKkfTlmhOSUpK5Pj73Kh63bJYeiTbmsJpzOEf52o9eI8WQc_Iauh0QTC22sDJ-g4Byd27sb7dOOkkRiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtdeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:cxlbaPfiUX-gP9IaEl_xaqckX2ifcIj9O4Ova19RLuph7RwUKyIobA>
    <xmx:cxlbaINRv3GYAMrtfSzyZGc3HvlS2wy6vZOndXGmluL6EElgXTx7Vw>
    <xmx:cxlbaBkDXJFQoYxpkeFfBkO845F6a0plqfRsRruYRNYHhLgzWIzo5g>
    <xmx:cxlbaCtZn4oqejEtOTc78BRxgPdKLz_g7vv_gJ6tmnVf361TT_G1gg>
    <xmx:cxlbaM5kILMly4IlVszBqG2LBAYTW40OAADf_7dB99djWdx4A2jKLiUY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 17:32:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 2/3] daemon: use sigaction() to install child_handler()
In-Reply-To: <7f3ac4djbbhskbryzr754kdjdiyauiiy5dduv7h2uaa7mvafsr@chntkatmbbcb>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 24 Jun
 2025 14:28:37
	-0700")
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
	<2e8c4643a60e354d24bda9bf364e1b34ce1c45ae.1750774122.git.gitgitgadget@gmail.com>
	<xmqq5xgl1589.fsf@gitster.g>
	<7f3ac4djbbhskbryzr754kdjdiyauiiy5dduv7h2uaa7mvafsr@chntkatmbbcb>
Date: Tue, 24 Jun 2025 14:32:33 -0700
Message-ID: <xmqqms9wzuz2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

>> Hmph.  Wouldn't it a much smaller change and fix to discard 2/3 and
>> most of the 3/3 and instead make a siginterrupt() call to tell the
>> system to interrupt us when SIGCHLD is received only on platforms
>> where siginterrupt() is available?  Use of sigaction() does not seem
>> to be buying us anything for the purpose of this series.
>
> Using siginterrupt() would work (at least it did when I tested it in
> OpenBSD), but its use is discouraged as it has been obsoleted by the
> last two versions of POSIX (since 2018).

OK, but it feels a bit funny to base the conditional compilation to
use sigaction() (as opposed to signal()) on a symbol whose name was
derived from that deprecated interface, doesn't it, then?

> Most systems seem to be implementing `signal()` with `sigaction()`
> nowadays, but in the ones that are not (ex: Solaris) calling the later
> to get a `struct sigaction` with the flags being used, doesn't work
> and therefore it would seem, that the only way to do this reliably is
> by using sigaction everywhere for this signal, as implemented in 2/3.

Still the many #ifdef's sprinkled all over looked really ugly.  Can
we abstract this out a bit better?

Thanks.
