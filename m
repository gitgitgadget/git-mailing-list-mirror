Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA4538FB9
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736175023; cv=none; b=r+KFhXg+JZKCWvv+r3dGrcbyWQQ+IGW2+M414PVoXwBkulRtQYfeyVpovptYEL1a2GjQ5EPA96vByDCCqNGZIoZVbwoCNyeuXyXnjTG7EKk/vgIdEB4Cka+EfdV7c/z5XhsKCQyvlwuI8WZFG4sML7lHn4f3uZ0taM2qQg5zrOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736175023; c=relaxed/simple;
	bh=5RRuWNuODXssgSDWEMHkyxA5aibpPOr8g7HunPegpIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HiJrwXqlFrLbasXOvNJgiLtNQe7GWjYvk9fJQC6kODSyuKIOnysg3ZnfasHjs6gG/mQh4QnahjUB62hDKDp7aHuNRKNA4czYYna3kF2GjPt7l9ElVNIlFdi9rZbk89xorqC1jojjjwpbxALbS2yXhkQbsOGSkXcuA/EID4AaLDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hTJURzsq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k1J3cLW1; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hTJURzsq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k1J3cLW1"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id BD7481140132;
	Mon,  6 Jan 2025 09:50:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 06 Jan 2025 09:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736175019; x=1736261419; bh=K0RM6aT26E
	7A6AfIZmyuGimLb7ScPABiKttd4YiDhjU=; b=hTJURzsqumj7IT2qfYiekJifGm
	f9tx7KSesxgsUTTkOjAsGlXocMIq8ITeNAEinvME2TLm1NOw2u5Z0OXo9IkRQ32K
	D3iIL5cTtuvb7rXAb2pWko4mlMDIlEl17P5rOZ57l9xH3kja0awCUu1NO0z8Fg6K
	4TT9RqIhPUxzrq1GqRsBOZxQ8d5NwwEuf9JDTBpD4Euah3t4wl1HO4CnIh2hokYe
	40DySJndHUzkP7oXKzLBqJbOGB8vTl7Bl/OpESzwvTzUBvj96u8xVmPh5bqvZmRx
	pcJKtawjSv8LYqKOACfjDcdj9mF0XbFbx+4okDygCnTiMFUXq+e1vhqIIX7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736175019; x=1736261419; bh=K0RM6aT26E7A6AfIZmyuGimLb7ScPABiKtt
	d4YiDhjU=; b=k1J3cLW1PsyOqdUCrGV0kx1UPLZ2uAVGhOoyuXaeC10RoZY0fiX
	Hp7Zms5Zr9xZ+083pOXNb0JV/9McNeEcvZzSdDtvUiNoG5jWs8zh2m+La06IeQXR
	XHbVUo8JjUkaFs50iwnUhOt4A0MINsXO0FybCyA1lOB6aUNyzHomt5MJ8dIsDphG
	Uet/o67P8gCzzONnWD6UseBNcyDnY1U4evWCQ2R/8RNXoTS96rTwCSjxVwt3oUXs
	5lYd4hawBQjkM1/tBMnjvwqklkxJBrFWcrvovpBAoozSebjt3OQK3XWMuKXKUw3E
	UKChY3xfxlAS+kNWzBmL97ErdLyV9mV8GoQ==
X-ME-Sender: <xms:qu17ZzwDoBCP8hETS8lexT1xDpKFO9VkQe0LRGdDKFuQTzFK2M1-dg>
    <xme:qu17Z7RkTyKshaEhNiOBAvIzVKVPH9-Kua-Pg3PM29CmQ4PSf20ZSYWL-fH-rEsPA
    DR3bl34nUD4aRU88g>
X-ME-Received: <xmr:qu17Z9Xwl9X4pcoXjod-ry1Gql1H9G2FE-5ZmIB7Y_lilLf3CUWMEtJA2iglX4hMAzxyjOSZ9G8DEUUAs6YjqIUe0Yk41JpM76v_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvg
    hrughinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgi
    druggvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhr
    ghdruhhkpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopeguhihrohhnvg
    htvghnghesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:qu17Z9hUUHPKV-HJ-NrwSmdQqmFFoJX7o_XoUiJ3m1RZvWEXAywikA>
    <xmx:qu17Z1D00QgGqFewYMmVnp31lV6vwunrSuC0lRDuwIGxBn9SRhzQFw>
    <xmx:qu17Z2KCi32qZU1PzzSi6ieaxQrrR_4jHy-4yJr3B8gynw4gMubXHw>
    <xmx:qu17Z0AhgGzXtNFJNUNHxTgm1jXyt2WEHcn8h_sxDP3_ygczEsMklg>
    <xmx:q-17Z5463iXKCL87W0iBWdtl7aG191JuotMG70cxxi_h73lDBtB-k_86>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 09:50:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  Johannes.Schindelin@gmx.de,
 	karthik.188@gmail.com, 	l.s.r@web.de,  me@ttaylorr.com,
 	phillip.wood@dunelm.org.uk, 	ps@pks.im,  "Teng Long"
 <dyroneteng@gmail.com>
Subject: Re: [PATCH] fetch: fix erroneous set_head advice message
In-Reply-To: <20250105161017.210412-1-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Sun, 5 Jan 2025 17:09:40 +0100")
References: <20250105114201.35079-1-tenglong.tl@alibaba-inc.com>
	<20250105161017.210412-1-bence@ferdinandy.com>
Date: Mon, 06 Jan 2025 06:50:16 -0800
Message-ID: <xmqqikqs2dzr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> 9e2b7005be (fetch set_head: add warn-if-not-$branch option, 2024-12-05)
> tried to expand the advice message for set_head with the new option, but
> unfortunately did not manage to add the right incantation. Fix the
> advice message with the correct usage of warn-if-not-$branch.
>
> Reported-by: Teng Long <dyroneteng@gmail.com>
> Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
> ---
>  builtin/fetch.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 2d37a378ba..fe2b26c74a 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1588,8 +1588,8 @@ static void set_head_advice_msg(const char *remote, const char *head_name)
>  	N_("Run 'git remote set-head %s %s' to follow the change, or set\n"
>  	   "'remote.%s.followRemoteHEAD' configuration option to a different value\n"
>  	   "if you do not want to see this message. Specifically running\n"
> -	   "'git config set remote.%s.followRemoteHEAD %s' will disable the warning\n"
> -	   "until the remote changes HEAD to something else.");
> +	   "'git config set remote.%s.followRemoteHEAD warn-if-not-branch-%s'\n"
> +	   "will disable the warning until the remote changes HEAD to something else.");
>  
>  	advise_if_enabled(ADVICE_FETCH_SET_HEAD_WARN, _(message_advice_set_head),
>  			remote, head_name, remote, remote, head_name);

Thanks, both.  Will queue.
