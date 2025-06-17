Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9543A2F5310
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750200368; cv=none; b=i7Ke+VtQvYP94Wa1coTCK/o0zo6NoKBD12o4gbL/zUL4Cm41Edi2hZAFeLMEjfjFje469sSDlmJ4tAvrw17mZvRSES7tvFmYRPp5EFdH7HbpbUrYKD0mm4eWHX9RRS+9A9w+3xoGUlNKyuyJh3vJCk45OT8/xD6bXsiGyR30Cno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750200368; c=relaxed/simple;
	bh=K/X6AUIlkgP6nMuQTg84r6pzD1kRpDN2x0mAE9S5mGI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O8uEkmeXcqNSbolYaKhVRZqgIsP0+2rGhL+9VRX4Xi4b7rd7DtVf3gZlkzHfaBhUa37zRwcsrlWZ3uOGyOzjKI3iBhTekAALuX5ihmYnrx5wZTIhpFjWSuXNZ6d9q4LUdEz0e3YtfPerC6O3Dzb5DTPEwoEpqd1HIS0spK1ixmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qCEOEGpQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LOpZDmnn; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qCEOEGpQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LOpZDmnn"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 7B9F6138049E;
	Tue, 17 Jun 2025 18:46:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 17 Jun 2025 18:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750200362; x=1750286762; bh=J/8HHGI2zw
	WqgJyuUWw4ZQ6pxPklavnb+T9gkTEwyHg=; b=qCEOEGpQ/66XW1OzpxsZnai724
	lKFK3z5Hn4HIxwNr5T7rZtbzoSEl2FrIqnokGVlpAHH/JIn6An/Vb7EkSX198Lma
	u4SRENAM6I4lrXteQWbojfcN/9U5mfbHac+cB0Wji0IqEbXnCo/X3MazI0jGsuNa
	zvZL+J7fbCKwUKwdFOnQY+AKSEFySu98qkwCoZ7SXPaBFP338DCkA/PPeOFi/zmc
	MjgNYuyDgLwmJgo1eJa3PvII9eUlEGq/f7xXRg3XJ48E7zPTQ0UENFu7ir3Bjdw5
	Jfrqu8U4wRngJS2JSNNevBU4WDBMRVTnqrY2/szBTxJxczbRdYk4w2i8IvRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750200362; x=1750286762; bh=J/8HHGI2zwWqgJyuUWw4ZQ6pxPklavnb+T9
	gkTEwyHg=; b=LOpZDmnnbk2+q6oH568mthZigTLWd138FZ7Z7P7F1Vd8sppXzQ6
	59799vNmeXd0NdiTlDtXQZioAmqFmqWnEfdds8wqxSiJE82LDPPBTnS9h4MElPv+
	k6TQUEno0HEshIm9cwgVVsoVKLf3F829OSdilatzNFxwyWEKIOkxBW6PRWUoWVbT
	PrE4fyPw/ifpjVzfYPOzWymW7SofvwAcKXH1e5Y/vLzXPf90BdjN+uiahwaO8vfg
	rA8LgCrMZsF4JhUhJX8JrVyCI2b99zZRmEXWDeBCbiXDG++y7205BYCnudMhw/Fx
	gDVXSYkfjvsVuuZ7ruNi0dgOYLfLhQadXFg==
X-ME-Sender: <xms:KvBRaOn9ZxTht-uZyuRtyGyjTbc_ZSIimWZ76ZJkH6qpOhx3mrImhA>
    <xme:KvBRaF2OKId0Ehf4FXjXJrp0uGOGbNY93X7gIQ_QF6LGo0fa6foiTrK8ae4XyjL3R
    Pt_HdheUySYZzCkkw>
X-ME-Received: <xmr:KvBRaMqDSNcvb-cK1NfSwRw0Uo_NtjlPDiT6zJhbp0fVfeGBpLm1N8jmh9C4ViMtnSw3MVqb6cN56-lyj62t9oCjRKRZ-zUYauTU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddugeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrtghosgdrvgdrkh
    gvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopeihlhguhhhomhgvvdguvdesghhmrghilhdrtghomhdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:KvBRaCkFY7-JEAYt4tnWZg36n0cc0KB-c-NyCjGVTSmP0AUcaYlugA>
    <xmx:KvBRaM3M2_8IXNjX9O3xNjOc8zx6oAgnY8Mkwh0X4Y15p9K5W-UmRQ>
    <xmx:KvBRaJv9eH4am5mEjWgKSWJn3-3y4A8VpfHzAA4_pmLBn4Tf4pIcvw>
    <xmx:KvBRaIXO3jRsjmuYXXaVddTXHFr8C-u-zMcJ6JWlGXtih8QD7GIGBA>
    <xmx:KvBRaFYUwtyaIdbmoy9uckLX1hY8NSw65FU7ADmVNvq-xCE3GdNuvp83>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jun 2025 18:46:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>,  Lidong Yan
 <yldhome2d2@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 3/6] remote: remove the_repository from some functions
In-Reply-To: <20250617-jk-submodule-helper-use-url-v2-3-04cbb003177d@gmail.com>
	(Jacob Keller's message of "Tue, 17 Jun 2025 14:30:43 -0700")
References: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
	<20250617-jk-submodule-helper-use-url-v2-3-04cbb003177d@gmail.com>
Date: Tue, 17 Jun 2025 15:46:00 -0700
Message-ID: <xmqq7c1auguv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> The remotes_remote_get_1 (and its caller, remotes_remote_get, have an
> implicit dependency on the_repository due to calling
> read_branches_file() and read_remotes_file(), both of which use
> the_repository. The branch_get() function calls set_merge() which has an
> implicit dependency on the_repository as well.
>
> Because of this use of the_repository, the helper functions cannot be
> used in code paths which operate on other repositories. A future
> refactor of the submodule--helper will want to make use of some of these
> functions.
>
> Refactor to break the dependency by passing struct repository *repo
> instead of struct remote_state *remote_state in a few places.
>
> The public callers and many other helper functions still depend on
> the_repository. A repo-aware function will be exposed in a following
> change for git submodule--helper.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  remote.c | 58 ++++++++++++++++++++++++++++------------------------------
>  1 file changed, 28 insertions(+), 30 deletions(-)

As exactly one remote_state instance belongs to each repository ever
since fd3cb050 (remote: move static variables into per-repository
struct, 2021-11-17) defined the former, and remote_state is not
shared across repository, passing the repository instance that owns
a remote_state instance and pick up the .remote_state member out of
it as needed would give us the right remote_state, and gives us
access to the repository instance it owns it.

Makes perfect sense, 
