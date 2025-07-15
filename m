Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD02254AEC
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752614630; cv=none; b=C8RZoUd5F7pk2flxmoAYyXiT84BvgWtTmGkCKOxU+XsnLqd5aQiyFUUQkFA+yHpnnJspVI+glBcCVHmguguTZOXZbtGEcBDhVNxJ4+vY7sVToesZJQbE74eWNz5kyQRdGjhZ2nclM/6umatDxGhjyXDNx9XIcAq9FqRmKKzbgm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752614630; c=relaxed/simple;
	bh=D1iBmvXxxjEhnm3mRONyXQP7/mMisyjWJqJBFsEY3X8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DSyIy0wXCKOZIpZevBmobuUtaowvbumvFIv3+EBdWumwtPPOEiRU3ytGkA9sJyFNtWqv3vr0KKQB91ehqCCweVBF3RGJaAruxpXZaMy31P47eBteGTw1SRrJ2fV1F8GV03kky9DlKBh5M+At4JCWjbA6xXnzbviy1xIEi61hoes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TQyMyrg0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bczsHVrk; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TQyMyrg0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bczsHVrk"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3D54E7A0161;
	Tue, 15 Jul 2025 17:23:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 15 Jul 2025 17:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752614627; x=1752701027; bh=uGOL4QdGMH
	xCXCAtTdB5WFKVzFsHgwq89HT9VH/buyI=; b=TQyMyrg0uGQ9tRoE7TmK7a79AK
	ZIhjH0f6yVcg3Lc4kuKX02N7cgBCv4pfcyzE5fNcO1ZmXbrMVTrEUR3EwvVP7wKH
	wRbzY3ZwNo452cmjpuZgexQLZeWfg/Olqr/v59aXXzN2pDeffqbAbfLP9QUCKLDw
	Ley1ppLp1s5nuMgp1KWOrd/BcvEJMgdeJYAJJpUp8e6locl80Xutkdl4ELjxyC1J
	6Lbcnz1DnGlIQTgmtDaOz1tiERZ32CE9AzZyPAGpf9N0AYM/H37Azbh1FD8RjmgU
	JFPjN+b8MSJqfXAwPWM8gFKS71mlyWnk5WVrHo/ALFJGY3+nx177Z9fe4CSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752614627; x=1752701027; bh=uGOL4QdGMHxCXCAtTdB5WFKVzFsHgwq89HT
	9VH/buyI=; b=bczsHVrkEtKrxhmtgiC9nX47UsgxGxfOP2dzJXfn0ylPsOlh8eo
	P6rX5VPfP2vzn0isEVMuAMWqpII+fd7tuIOmTILlKM056AsblF5al2yHmxZMrvYS
	w02/HZaiGm7nWCjC+5DxnH2wgNAzlkeoGWnk1k0tWWW+70rL2hZJeTiY/PHlqnQg
	we/LAJGFTFFnYr1DJMC8e8bKehvV0ZGCQpjVJYzm8lWPLeNd0I5CX44phLcXPo/s
	womy0cGs4vBrMf803Z2u3Wi+X0bf4qVmgVZPlishuxuR2G271ldumykVsJaJ3wMA
	q+TYCChvWJhad1V6w9Ml79vFLdg5SRhw0KA==
X-ME-Sender: <xms:4sZ2aFIey-L2zkucEja5xbKXRjNPVQg3Cso5FrM3PRDeBOUEg0zI1Q>
    <xme:4sZ2aOtwlQjasjVfa_zGxu1qfEK31pKI1WXVvyJzTl3WmmisY9IXqNe9LcntbRi2N
    AeaYPe8ewuN-eR6TA>
X-ME-Received: <xmr:4sZ2aEKkZ1wOl_C0_EV8hGIIJUnRL-VriYkFW3VeYnB8o8TndGE_NQGgJZ5i9OFeYYbVQ0KpcVKBDvuA1zBQtr7-JrwNXbYC2cF9fSc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprgihuh
    drtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhi
    rghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomhdprhgtphhtthhopehshhihrghmthhhrghkkhgrrhdttddusehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:4sZ2aH8QQWYHXkStJpCP7miDjJ-NPFm7lyJcoh7IB84EBBx-8s-4pg>
    <xmx:4sZ2aNx_56c0QdZR7ZPCG9hClrKW3iXBq0yPpHCXAiAY8GmDSoiCsg>
    <xmx:4sZ2aE50G5W5vKBsK_pWREAze27hwR02QobEYJNh39PGxN2KRfuHIQ>
    <xmx:4sZ2aE-Uf5F_3FnOHxjJy6LNDv6VOJAt2-EN6YJh9gHspu3oIfMihw>
    <xmx:48Z2aAzyMqKlzV23-G0MVHSKudA6UB5J4-IprwFjWHlizRb1DH-MSdjF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 17:23:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,
  phillip.wood123@gmail.com,  shyamthakkar001@gmail.com,
  kristofferhaugsbakk@fastmail.com
Subject: Re: [GSOC PATCH 2/2] config: set comment_line_str to "#" when
 core.commentChar=auto
In-Reply-To: <2a3c2d323bdb520a37a099b361be9ec5f2d5d46f.1752602474.git.ayu.chandekar@gmail.com>
	(Ayush Chandekar's message of "Wed, 16 Jul 2025 00:21:26 +0530")
References: <cover.1752602474.git.ayu.chandekar@gmail.com>
	<2a3c2d323bdb520a37a099b361be9ec5f2d5d46f.1752602474.git.ayu.chandekar@gmail.com>
Date: Tue, 15 Jul 2025 14:23:45 -0700
Message-ID: <xmqq1pqhgnby.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> If conflict comments already use a comment character that isn't "#", and
> core.commentChar is set "auto", Git will ignore these lines during the
> scan using ignored_log_message_bytes() and pick a new comment character
> based on the rest of the message. The newly chosen character may be
> different from the one used in the conflict comments and therefore,
> these are no longer treated as comments and end up in the final commit
> message.
>
> For example, during a rebase if the user previously set
> core.commentChar=% and then encounters a conflict, conflict comments
> like "% Conflicts:" are generated. If the user subsequently sets
> core.commentChar=auto before running `rebase --continue`, Git parses the
> "auto" setting and begins scanning. It first uses the existing
> 'comment_line_str' (which is '%') to detect and ignore conflict comments
> via ignored_log_message_bytes().
>
> Then, Git scans the rest of the message (excluding conflict comments),
> sees that none of the remaining lines start with '#' and decides to set
> comment_line_str to '#'. Since the final commit character differs from
> the one used in the conflict comments, those lines are no longer
> considered comments and get included in the final commit message.
>
> Set 'comment_line_str' to '#' when core.commentChar is set to 'auto' to
> reset any previously set value.
>
> While this does not solve the issue of conflict comment inclusion and
> the user visible behaviour stays tha same, it standardizes the behaviour
> of the code by always resetting 'comment_line_str' to '#' when
> core.commentChar=auto is parsed.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> ---
>  config.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
>
> diff --git a/config.c b/config.c
> index eb60c293ab..bb75bdc65d 100644
> --- a/config.c
> +++ b/config.c
> @@ -1537,9 +1537,11 @@ static int git_default_core_config(const char *var, const char *value,
>  	    !strcmp(var, "core.commentstring")) {
>  		if (!value)
>  			return config_error_nonbool(var);
> -		else if (!strcasecmp(value, "auto"))
> +		else if (!strcasecmp(value, "auto")) {
>  			auto_comment_line_char = 1;
> -		else if (value[0]) {
> +			FREE_AND_NULL(comment_line_str_to_free);
> +			comment_line_str = "#";
> +		} else if (value[0]) {
>  			if (strchr(value, '\n'))
>  				return error(_("%s cannot contain newline"), var);
>  			comment_line_str = value;

This patch is exactly what Phillip suggested in

https://lore.kernel.org/git/9e96aaab-79a2-4632-94cd-d016d4a63b30@gmail.com/

isn't it?  Makes sense to me.

