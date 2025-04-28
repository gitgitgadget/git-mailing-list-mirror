Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2A8175D53
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 23:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745882829; cv=none; b=qWyH/LGg/FCCDhFKqsoeSJRHTcbTBeFzyPOBUqiP3ozPKShg0FCd8nOCCmnx1JoyOXf2sM6zII5nUhMA9UDE7toBl5aoznHlaZqKLY5tdAcwY/wzEzdRmxVw51/hM6rari1hkncrFOyb/5r2tWC86wKE8dPGrUm+tUKSPqOXxGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745882829; c=relaxed/simple;
	bh=7T0RklSM7Ea9q5Omnn3UiHpbIHlLCW7xXxOk7evTK8s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dWa5lIzM/0C7krpb29MdP6GQLUlBUwk7Vi3BTIkFusUSR6PoCQ7pALAUiR3KdsCqySt3gd9GfONhI1dPOHcAiGkA6uHRAnKJj9dL24/fRU6zBUH00wndXgmI/Om1tbj4PHxMOuoVYIpRAQnqrwJpwo/znS7RBNpsImfmG9dMqWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N7MRWCVo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ocRsPxrD; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N7MRWCVo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ocRsPxrD"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id CD168138021E;
	Mon, 28 Apr 2025 19:27:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 28 Apr 2025 19:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745882825; x=1745969225; bh=OB21MRMU8y
	4zcAl0R2THU73gvpzV/ZW6o/CcMdmYNeA=; b=N7MRWCVoLu97RNU+3X3yRYa7UJ
	JJ1Miabm/VzCLyOOjvCSVFrVTxICJfOb9vpzmV2w3PisASeiThQdXax+u/mxLCef
	a5MqRXRJkSjBIpVkEartnK9oTHeQ0gwqIMsLIOPx/s1SV3zsitN8D/tVTxcrne57
	+jkzE5nvHNKMQeN0nBOBrWVfeDlQ0qfqOuwmO1nkT+/Uj4pxl7f/gtVuNZ8DJtE5
	6iV4WFK1P5cyvWehIrW9t6/LaAL4OkxxtwYxYBqMP/L0kKh/Q1Jhe4hBskdZkuPE
	t+BdPPodtTcao4c8S0z7VxjvETp5Coh6FmbxKYLyiN0062ilUXnO+ayUr6bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745882825; x=1745969225; bh=OB21MRMU8y4zcAl0R2THU73gvpzV/ZW6o/C
	cMdmYNeA=; b=ocRsPxrDBuTzK7GyU8/eCiRMbYjKGdYYT4dvwm1u6FtRnm/3L1V
	shPjTHXL371cVH+eXUM1NY1N9gSWdI2FdwhQ7vEIvnrgx24hJWmfER/B1Bu+z9jU
	YOVl0BKg80Yv6qq1zXIZEkho7F0YiLOo096KOgkBDfvg6WGz7Ve8SQQ3OhAFRpYo
	ue5evkBJrGc+NO4tE0Wv4ufloIpU/NQVzc/VWEFVDmbCwxCWenA8oVGW9RgimJ3l
	6wIuXnfIHnl3ABagTf+PnlMd55wYKQj/wcwHW2Dwu9ffSHWwDSiJ5TZzgQzUW7Fr
	QRdBm0uKKcxlKdchpwWUothwNY9wPCOqEKw==
X-ME-Sender: <xms:yQ4QaM-MFl98VaUqupbR2GG247XrAnQvMKYV-kqQTXu9VRe_fZt28g>
    <xme:yQ4QaEsK5ld75B6SB_IBVUL_xsVJCLG4CB2TgX4JUzWalVBlmCA22zEa0uV4bud4L
    mH3HgGXKEXXjzOrcw>
X-ME-Received: <xmr:yQ4QaCActpjbMeGK2gyVr-cf3G05j_v1C_-aCis0lrS-9Kn64hMeWKHFh7uiFsApixztvR8YSB-xa0lpInVrBGwm16FoZIMw1Kza>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedvvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijh
    hileeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:yQ4QaMclMpV0Fyfy-n_dzPIAJfPBNIAV_lOPA8UMxbEvJyXsZ_hiHQ>
    <xmx:yQ4QaBOkAjbHg6bQCkHCr2hNpUYpdLyGsFBOJnnurJlYBgH74ouC7w>
    <xmx:yQ4QaGmK85oUz5FPaDub57X14uR0ws7_AUtFhaVm4bEp29zt5Oq6Cg>
    <xmx:yQ4QaDvWdeFnD5uhAi2M7DDrPWfNnD-_1EuAwNdZQYZac9vGdNo2Pg>
    <xmx:yQ4QaL0ddKvfRvjzlQkEM0BkURTgmRB58i04zEQLNJe5rgx8THwq6keB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 19:27:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/9] t/unit-tests: adapt lib-reftable{c,h} helper
 functions to clar
In-Reply-To: <20250427185351.82520-2-kuforiji98@gmail.com> (Seyi Kuforiji's
	message of "Sun, 27 Apr 2025 19:53:43 +0100")
References: <20250427185351.82520-1-kuforiji98@gmail.com>
	<20250427185351.82520-2-kuforiji98@gmail.com>
Date: Mon, 28 Apr 2025 16:27:03 -0700
Message-ID: <xmqqa57zamuw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> Helper functions defined in `t/unit-tests/lib-reftable.{c,h}` are
> required for the reftable-related test files to run efficeintly. In the
> current implementation these functions are designed to conform with our
> homegrown unit-testing structure. So in other to convert the reftable
> test files, there is need for a clar specific implementation of these
> helper functions.
>
> type cast `for (size_t i = 0; i < (size_t)stats->ref_stats.blocks; i++)`
> Adapt functions in lib-reftable.{c,h} to use clar. These functions
> conform with the clar testing framework and become available for all
> reftable-related test files implemented using the clar testing
> framework, which requires them. This will be used by subsequent commits.
>
> Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> ---
>  Makefile                    |  4 ++--
>  t/meson.build               |  4 ++--
>  t/unit-tests/lib-reftable.c | 26 +++++++++++++-------------
>  t/unit-tests/lib-reftable.h |  6 +++---
>  4 files changed, 20 insertions(+), 20 deletions(-)

With this step (and nothing else, as this is the first patch in the
series) applied to 'master', I see tons of these errors:

    CC t/unit-tests/t-reftable-merged.o
t/unit-tests/t-reftable-merged.c: In function 'merged_table_from_records':
t/unit-tests/t-reftable-merged.c:37:17: error: implicit declaration of function 't_reftable_write_to_buf'; did you mean 'cl_reftable_write_to_buf'? [-Wimplicit-function-declaration]
   37 |                 t_reftable_write_to_buf(&buf[i], refs[i], sizes[i], NULL, 0, &opts);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~
      |                 cl_reftable_write_to_buf

