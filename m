Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7F5194A6B
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503204; cv=none; b=WMRlA0Lp3H799KqB5umTmPnbrBdX4olzkSMAdQNyIYR374V7uo9DVPZaB3YC+2fEC3ZytPXW+PAPPannOXsiCZzri+p3eY5H33dlutF/t92EJpdd31Z2R3Xs/Pnau+gmv9N9zvlh+iDixrt8U/9EKCx606Lqaex4hf4aBvqD6Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503204; c=relaxed/simple;
	bh=4i5v7gLlt+xQf/aBTCPr2fMZT68Kn+Cx/mRI61g1sug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q8GyKDIgQC39j2vfAq/3u6VKmZeCJfQU8d6kY/665JE+gDCDTJS+Un8vYMpvppaqQ5xkYj7k4SWLUXGqX6Q/Z5PgcwqYez8m4zvnAzcW6r0Ej9AknUxYBJ8GhhS1bjIdeU/W6f2yb48HP+VAQJiIVdVpN1zJvbht3kUwJeGFCRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Hec2zr0r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f2G9ffX1; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hec2zr0r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f2G9ffX1"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E791D25400DC;
	Tue, 25 Feb 2025 12:06:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 25 Feb 2025 12:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740503201; x=1740589601; bh=VQH10HiGcT
	Qp0veSI/jxAjI1Guk+wIpbmqv71BYGWic=; b=Hec2zr0rHr/5EsWSbuPlpm0mFn
	N3D4Bs2EgtjRZHe1uw2QCLKQ/2AO3XqOZ80IPk/ItsLDo8UWqRUY2gQ4i/G7CauV
	E8NrqXav3l2FWVkkgT74NrqO3H0aA2r4kt5WFZ1zw0xnZNVR43C9UrCgqfxnyBo/
	xRDXWndXtw58BqPPUnk1VFfbQPlfn0p7Yiyv2a43teXT+n+2hakv8/UZ8il+a8yL
	ukYtiSh2i/24l8h4pXj9zPBxMi/vwGp5+tjnW0xlbr4UD8UnQf1GToaGxdHwV5Je
	mRlQZ/v1KUUJRu9rpaeihQo5XjUKYsBU2z5Ku4k7etj+ETjz0T36Tapb5Y1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740503201; x=1740589601; bh=VQH10HiGcTQp0veSI/jxAjI1Guk+wIpbmqv
	71BYGWic=; b=f2G9ffX1ut3LVnCku1Hlp9esp7ffecySmcua+XLG676OoOKlovQ
	du4WqeHab9AsS8Rv8zUlJjqi2k8awDrjuQzlS1nwalU9FOSAoPl3AImyO2R2jVAk
	rL5OCR1SDy82gTy1qRS3gAtb1c3vmFvNJhpS73GAX6X9vJyd+7dWypZKza2wdERZ
	VajybKlJxxrNDEqzCzZeDErHI2PJAuzxlttrzW7hy9rmferIHtO5LVtEyYpmVoVd
	ytILGTUhr1XdFoyw9VFGCQ+CZh2mOdLnD0OFQ34fMh20M1uuOmCQ158oaEEaLs3Y
	T2Tx0Q/dzKNyE8DR+TsDyghDhD7c1fqtRsQ==
X-ME-Sender: <xms:ofi9Z-bRZQgVepzGp8hYlK2BBuGIoVdPu_WpwVF4Fb-1UqRw39FZ0w>
    <xme:ofi9ZxYf7Ul6BHl2ZxCZ7GlL_9R7CwBmbxvp_SHm_gXFTyLHwI-PlVkm4ZC2QMcoV
    Gt-v7hWH2dVTlETYA>
X-ME-Received: <xmr:ofi9Z49YjDen3KYbEiY4ZF7Ve_INN3nln8SsXyBtPr5xRDiQXV1RFt0MfOasJtfO1hdP81vXPTQaJ7i0sNOHSO99OMVqg7eHfGS->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ofi9ZwqbCalbO5LKWjG77nbvzBiKASRR7zX_4CLpsx6fmwB735LhiA>
    <xmx:ofi9Z5rD3W_XTZnmdVzrRdaazkxN3to_m7RvbQyOHL-uLeokHX1KKw>
    <xmx:ofi9Z-RABz4iko22bjW9i8X5I_MtNGB6XFKUcJ8pooeEaomCKIBePA>
    <xmx:ofi9Z5oKMeobJ00ZFhz7qwMk10FN2cjOeXzvemSfhhvuZ5g1FrRCMQ>
    <xmx:ofi9ZwVf2WKYrOixWx54jHU-BkwWq117qTqCN6wF61Xj2oWnGoMwYyTT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 12:06:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2025, #07; Mon, 24)
In-Reply-To: <Z71ns00inrW0rZN8@pks.im> (Patrick Steinhardt's message of "Tue,
	25 Feb 2025 07:48:19 +0100")
References: <xmqq1pvm4u6c.fsf@gitster.g> <Z71ns00inrW0rZN8@pks.im>
Date: Tue, 25 Feb 2025 09:06:40 -0800
Message-ID: <xmqq5xkykl7j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Feb 24, 2025 at 06:47:23PM -0800, Junio C Hamano wrote:
>> * ps/meson-contrib-bits (2025-02-20) 10 commits
>>  - ci: exercise credential helpers
>>  - ci: fix propagating UTF-8 test locale in musl-based Meson job
>>  - meson: wire up static analysis via Coccinelle
>>  - meson: wire up git-contacts(1)
>>  - meson: wire up credential helpers
>>  - contrib/credential: fix compilation of "osxkeychain" helper
>>  - contrib/credential: fix compiling "libsecret" helper
>>  - contrib/credential: fix compilation of wincred helper with MSVC
>>  - contrib/credential: fix "netrc" tests with out-of-tree builds
>>  - GIT-BUILD-OPTIONS: propagate project's source directory
>> 
>>  Update meson-based build procedure to cover contrib/ and other
>>  places as well.
>> 
>>  Expecting a reroll.
>>  source: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
>
> v2 of this patch series hasn't yet received any comments that require a
> reroll, unless I've missed something.

I misread the exchange between you and Ramsay; I am fine with the
decision to leave the sparse and the hdr-check outside this series,
for some future follow-up work.  Let me mark it for 'next'.

>> * ps/path-sans-the-repository (2025-02-24) 17 commits
>>  - fixup! rerere: let `rerere_path()` write paths into a caller-provided buffer
>>  - path: adjust last remaining users of `the_repository`
>>  - environment: move access to "core.sharedRepository" into repo settings
>>  - environment: move access to "core.hooksPath" into repo settings
>>  - repo-settings: introduce function to clear struct
>>  - path: drop `git_path()` in favor of `repo_git_path()`
>>  - rerere: let `rerere_path()` write paths into a caller-provided buffer
>>  - path: drop `git_common_path()` in favor of `repo_common_path()`
>>  - worktree: return allocated string from `get_worktree_git_dir()`
>>  - path: drop `git_path_buf()` in favor of `repo_git_path_replace()`
>>  - path: drop `git_pathdup()` in favor of `repo_git_path()`
>>  - path: drop unused `strbuf_git_path()` function
>>  - path: refactor `repo_submodule_path()` family of functions
>>  - submodule: refactor `submodule_to_gitdir()` to accept a repo
>>  - path: refactor `repo_worktree_path()` family of functions
>>  - path: refactor `repo_git_path()` family of functions
>>  - path: refactor `repo_common_path()` family of functions
>> 
>>  The path.[ch] API takes an explicit repository parameter passed
>>  throughout the callchain, instead of relying on the_repository
>>  singleton instance.
>> 
>>  Will merge to 'next'?
>>  source: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
>
> The fixup commit looks good to me, so I'll refrain from sending a v3
> only to roll the fix into the series.

OK.  I read them over before saying "'next'?" and still missed what
Peff spotted, so I have no confidence in my reviews over these
patches, which is a bit of a problem for me.

Thanks.
