Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05992F4333
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 04:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749790169; cv=none; b=jFwP0Rhd+KQdvrBrPiWwXUgz+X/SsOEYoMxr7xj2kYqRfUS9iacFGEESbZEu0vR8I7thqyLgklJi0XZNCzxeticKp0RuGxSBfRopKh9BNol35k0l09+qfiyfiSr4IgdUGlrFh5e1EYiYG2swFv4sAYXHW7JFftipuXf+0nxErAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749790169; c=relaxed/simple;
	bh=rP/v4q843eI9lV9qGDVeBzpc4kSrBQH4bNP0AerQP/A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NpM2O4KQglWMcwphA4/sD5F08/PHNXEt9kukDOBSRqjqXWrnCCtkuep6xs5nrOCILcq1csP20UQufnAIf7NWNCCUINKKd6dKuSTah61HDb3nclgqGrbpHWGWLGzkFpf+yVIfL6VD89axHOgsSJPzRsKHg+hDLgQeePu3HnTKe/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rhDnckQY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iNeOxY6w; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rhDnckQY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iNeOxY6w"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E04C1138064F;
	Fri, 13 Jun 2025 00:49:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 13 Jun 2025 00:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749790165; x=1749876565; bh=Wnx33t2vhG
	x03TK79Jfwku0xDfqhOBwJ2CUqS9ULPSg=; b=rhDnckQYlYQxSc5NHhsPBvykiQ
	Luh0DMJ54FwvOdgy2UovYdUbYeQFSXybXd5Xx0ZW88szSWZ++UawLbEYv5WDRok4
	G+Y+G/hPMjCRxdsdE31TjNEs+0aWByoRseuG8SRIolPxLgksMRLl+npaadFEEOgz
	1Gl6TUyA8XJxBqk6X0Ge/IdefQBbpoiTCFR39ykR6wijWxfKRJpunJeDDuLNBuPQ
	BMKYxdkGFhtrB6l18b20AXh9N/sbRx7r9ML1oDjoUSmaIQq5ON96CL/h3411h3+S
	D1ewvOAZFKUWOkpyxgYiPqsH68fo6qei2YRoK5s2ApB1/EJa27C/PaWJ8vXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749790165; x=1749876565; bh=Wnx33t2vhGx03TK79Jfwku0xDfqhOBwJ2CU
	qS9ULPSg=; b=iNeOxY6w6n7tlvu414fxtIwR1qySP1iYUn1hpFYQyApU/T5jqzh
	oTRfsWvc7sXY5kxFYasFTqtf3sCwvRSCTBOq8luKAga5rdEHFccA+Tbs6yd2RLmw
	ldZ6HNrBlgjiTBekIsQjwrVzy1W4zWbBgEI7MJ5isevGAJVnjjNil6Z/w5fQt2rN
	P2+fmqVC4g7zxnm6h+cgt6t1uc0gMa2hftqFk+vJ2aJUIBbMsulq8Hkr5lWUyY1t
	Hqq1cZMzaLfJ5IufA65zKxRHcAu6r0qfAeOBqAoM+YN0NfY4Hm0zUFbWZsLu6bzM
	PYshYnyrZrWlePs2dcoho5UK5sSml3s2dww==
X-ME-Sender: <xms:1K1LaF5csydmehImCGQkL2hifPdgaU3Kd3Jh_O0Tv2AaiKy7Chs_0Q>
    <xme:1K1LaC7k-P6PuwkEOCsBTlMju8ldIEMjV4gK_FGmX246bA7B-P6SD6D1VBo1KFKvm
    FOp7zxwqJAI1M3pnw>
X-ME-Received: <xmr:1K1LaMfTwmI4SwgTuizZ0LCDFm8oHsiFDbz7Iafx2Sjz8740uv6SrnytZSI5ntF937rIEu2894OIRGoMG-gJR-eJfcclIMdZbGeE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddujedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohephedtvddtvdegfeeftddtheeisehsmhgrihhlrdhnjhhurdgvughurd
    gtnhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1K1LaOJhkCm4uSZ5pqLlHEwrdh9ow9cH45Y3sIVh7l16cjWUKlgitA>
    <xmx:1K1LaJJ9Bt_5JPuXQoW3LTcaKW7bNmoPnx5R5ib9lfO_O1IapE9l5w>
    <xmx:1K1LaHw_E6oQIXPTbL7oN_3mDSgR7Mb1CeRCcJdRwqTVmG6Iw3gJug>
    <xmx:1K1LaFIBKTY-plOdaSyEjVh04VU61S_Kmq_RFy_117z8_XE1KadpkQ>
    <xmx:1a1LaFM55Fe6o7Ljs_qSN8LcPadvAPVi06qtXqfHjdLKYW6aUBO6DLpl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jun 2025 00:49:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: lidongyan <502024330056@smail.nju.edu.cn>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] git.c: remove the_repository dependence in run_builtin()
In-Reply-To: <11AE19A1-7B19-45CE-AFCE-98D89A4570F7@smail.nju.edu.cn>
	(lidongyan's message of "Fri, 13 Jun 2025 09:53:40 +0800")
References: <20250612045905.3023227-1-502024330056@smail.nju.edu.cn>
	<xmqqecvoev8g.fsf@gitster.g>
	<11AE19A1-7B19-45CE-AFCE-98D89A4570F7@smail.nju.edu.cn>
Date: Thu, 12 Jun 2025 21:49:23 -0700
Message-ID: <xmqq5xh0b60c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

lidongyan <502024330056@smail.nju.edu.cn> writes:

>>> The comment before trace_repo_setup() advises not to use get_git_dir(),
>>> but this note is unrelated to trace_repo_setup() itself. Additionally,
>>> get_git_dir() has now been renamed to repo_get_git_dir(). Remove this
>>> comment line.
>> ... 
> However, I believe this concern is no longer relevant:
> repo_get_git_dir() no longer sets up the Git repository environment as the
> original comment implied. Instead, all the necessary setup is now handled
> by setup_git_env(), which is invoked by setup_git_directory_gently() after
> the prefix has been determined. As a result, I believe it is no longer necessary
> to retain this comment message.

If so, please update the explanation.  It reads as if the only
reason for removing the comment is because of the rename of the
function.  If the reason is because the behaviour has changed and it
is not relevant anymore, the readers should be told about it.

Thanks.
