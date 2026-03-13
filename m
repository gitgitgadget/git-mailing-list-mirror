Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CA037F019
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773417193; cv=none; b=laqqlBhUxoMZoslo7saWSqKRWb0zFDFFFCI28SNh3XhT8n90Qjgj3/kbMGu7m7zV+duGT3Cu41QnCHP+izh76YaaEV6oN/ZzR9m/LfdzIu4FiE1bFGfp042pwhpU0fHuL2IzRd4J/wPsD0juh5aWAlvVf4wQwNlhOBT4//fnQCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773417193; c=relaxed/simple;
	bh=hUnTq2W2CW+9WoOMhr8reYo8iMIzHbXdHsVK7h8wwW4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vDMVki9MjozTs0ZraRNyAAx7/ep4A7VI4dEe+R2fWwebm8ebk5+8Eofl+5CpmJ+9QqtEeYVF3QT2/6j1nCKIGOJdHKL1JoLCVnSDMnI8TJFMkdnJDl/041gILfN8me0vYHOFs/WTntPvdB3JWtfjA/sdfgiSP1f2flN/ps9VQlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dLCjeQVD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FvrTAlB2; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dLCjeQVD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FvrTAlB2"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DEEC914000B2;
	Fri, 13 Mar 2026 11:53:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 13 Mar 2026 11:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773417188; x=1773503588; bh=8pmRhtzIdd
	n3k/sV5IF7rsQFawMVR1Zc42OGm+GUjao=; b=dLCjeQVDcW8Vk04G9a5sP2S8F5
	HhlPcgriudxCsJbNB+yRlX6g61XSAdLuaR8EIomMrqTgurV/h6Qq/BfkE+tQSNZa
	ZoXys3rXrrkXj/q+VuWKqrQq6Y2Xw6RYPI75J8fd5DjJ4gnq7kjyu5OV76YEA3MG
	A4Vm8myctgD2XOYGsJAyKMXN1WLqpy2a3KB6l72HyrZd70TjLQWRPvUhUgeC5uGt
	RHdE8Cuarmx1hgnm33faL8SmJhRLTkThGmggyMJjZAA0d49mftfLm/+KMMpFTg9x
	V9GjOIrJJeHjso/4/oTn1Fa6mm0CwJLKidcar02nzMD//R2VRBKV5nSO+Ryg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773417188; x=1773503588; bh=8pmRhtzIddn3k/sV5IF7rsQFawMVR1Zc42O
	Gm+GUjao=; b=FvrTAlB2qPk18C15ZDBFSjjqBQqkqAG7sbnPXoOYOrwQ1/pkQRP
	NNF2aa9C3ndXeDwgpeMqDYpRNcDs73nsjbWht0VjJ/UvD7vx8cCGDrqm7D4qIhxd
	6bHGI0lwH5yOEv6fzdWwozXLC4bMK20wAZs3s642we5ZoAQFY3WCV53qvFb2XKQf
	WVIj9FjEKHXP3Nqd+fEruH9wdFEaRbFqanqwkwxr/EvUqRWnMDSjkNW3Y5qIors+
	gS0vYv7NUy/Hh2v2aejTSLQE3/gPUAbj4ry1uGJi9QO4QgdFSPJiotJtgNHd+GF9
	VE+FqGIDvsrqdDatLYBarJX+9lMz38gaT1Q==
X-ME-Sender: <xms:5DK0aYp5q24xSFsvlBwqv8cM_LtPPaYcDZRaRigiqM_rZWeKhSZT5Q>
    <xme:5DK0abOiOF1kGOZuWd9hKstZdToyxyHR9Hz036hbSDzPnlBz3r2EGJxctx7B1U28R
    2Vp3iWtuG6-zN2QzuzFf7IooIcqJTE5FdUhKPKeyY1NrhvRuELcy5U>
X-ME-Received: <xmr:5DK0aRpR9D0YmLNqe4zho28XWOZYBxiE_SOVpiIKoo2SftSx0nRHe1_JqbGVnf0WhPLLxenC7K_IrSRWhZiRAF0_FW3Gmz72FA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledttdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtph
    htthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:5DK0aWvlUGLil6ru_cJ0tznD8jfznWP7F6Cfq7Y8bldeeXjCBpZttQ>
    <xmx:5DK0aY2oUS8g5pZe6Yyi05fluu7mFGQZGM-3Oe5CutZbIzVp_zYNqA>
    <xmx:5DK0aZHpMQR_HG7dA-8Y5HKeuAs4Jk7jpFrAT4V28q7XqQIHxsE5UA>
    <xmx:5DK0abshhUSApqKsJT_4gMe_VXMLUBV39RCJxGTxMCKXjVGQ1a-zig>
    <xmx:5DK0aZn-IODOqaqelwzbWl97_J4sQKDhgvm1CveA626KT-YyXXI-3iQm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 11:53:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  newren@gmail.com,  phillip.wood123@gmail.com,  karthik.188@gmail.com,
  johannes.schindelin@gmx.de,  toon@iotcl.com
Subject: Re: [PATCH v4 1/2] sequencer: extract revert message formatting
 into shared function
In-Reply-To: <20260313054035.26605-2-siddharthasthana31@gmail.com> (Siddharth
	Asthana's message of "Fri, 13 Mar 2026 11:10:34 +0530")
References: <20260218234215.89326-1-siddharthasthana31@gmail.com>
	<20260313054035.26605-1-siddharthasthana31@gmail.com>
	<20260313054035.26605-2-siddharthasthana31@gmail.com>
Date: Fri, 13 Mar 2026 08:53:06 -0700
Message-ID: <xmqqy0jv7ml9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> The logic for formatting revert commit messages (handling "Revert" and
> "Reapply" cases, appending "This reverts commit <ref>.", and handling
> merge-parent references) currently lives inline in do_pick_commit().
> The upcoming replay --revert mode needs to reuse this logic.
>
> Extract all of this into a new sequencer_format_revert_message()
> function. The function takes a repository, the subject line, commit,
> parent, a use_commit_reference flag, and the output strbuf. It handles
> both regular reverts ("Revert "<subject>"") and revert-of-revert cases
> ("Reapply "<subject>""), and uses refer_to_commit() internally to
> format the commit reference.
>
> Update refer_to_commit() to take a struct repository parameter instead
> of relying on the_repository, and a bool instead of reading from
> replay_opts directly. This makes it usable from the new shared function
> without pulling in sequencer-specific state.
>
> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> ---
>  sequencer.c | 78 +++++++++++++++++++++++++++++++----------------------
>  sequencer.h | 14 ++++++++++
>  2 files changed, 60 insertions(+), 32 deletions(-)

Relative to the previous round, sequencer_format_revert_message()
that does a bit more than sequencer_format_revert_header() we had
makes the existing code easier to follow, even though the total
codeflow amounts to the same thing.  A new caller that will use the
function now has to do less.

Also, even though this is an internal implementation detail,
changing the list of parameters refer_to_commit() takes makes it
easier to understand which part of the replay_opts structure is used
(i.e., we only care about "do we use the commit reference, or not?"
bit, and we have no interest in any other members of the struct).

> +/*
> + * Formats a complete revert commit message following standard Git conventions.
> + * Handles regular reverts ("Revert \"<subject>\""), revert of revert cases
> + * ("Reapply \"<subject>\""), and the --reference style. Appends "This reverts
> + * commit <ref>." using either the abbreviated or full commit reference
> + * depending on use_commit_reference. Also handles merge-parent references.
> + */
> +void sequencer_format_revert_message(struct repository *r,
> +				     const char *subject,
> +				     const struct commit *commit,
> +				     const struct commit *parent,
> +				     bool use_commit_reference,
> +				     struct strbuf *message);
> +
>  #endif /* SEQUENCER_H */

OK.
