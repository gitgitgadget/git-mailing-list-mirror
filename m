Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A5D143748
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742332657; cv=none; b=CZVvGl5KxzqY57G+FUu2ZMSObQFgICifO8mWbvP7Vuod6blAGrnQ3yFaPS1IdvBieGJcX9TC9gEWVXe6/UROk2yNt8TRvnRXlF4WQBaF0/Gg1OhZxpZJapbU6kP/zs9rhYsPZN2TM9cMdOvEXIZmWv5SAbqM/mu3HQbHiRFJxjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742332657; c=relaxed/simple;
	bh=W8K4/cuxuppiU9DqdB+Kpj3GHrlPpAoUE4icvdEz2AA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J0rYPBCzhHWOehpX9JNjg8dVXufhA6JXbce/oTI1MgpEsbqlSiRRqXuC7+66T4NgpKpzDCLdfsERH8qlQg2kcH4h+yrdosOPGMaaSc/PvPE/xkIU1YmIKWOIcHwHBvTNzzdEFZpCVc+dJQSNKaD+uQTWcO/qSbqW9BPVYMbUu8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gtChvyq2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WeXP4fXK; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gtChvyq2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WeXP4fXK"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id E54CE1382D03;
	Tue, 18 Mar 2025 17:17:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 18 Mar 2025 17:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742332654; x=1742419054; bh=8t115/rU7T
	OmocIPA7Ojqh/r+a+PkaGmOtB66j+R0xU=; b=gtChvyq2b6BvhsAOIslTebjoM+
	jr5/3iBk1r11/g5oO+07xTVLyCUGFM1iIRD7P2sbMZo9KBpxsz9FcfRmJSW6+fJw
	aFdg2NoTq4i1XUE01kQzbjpAUcWVJ9Aw5P6ZxZnG2FNz7lhUh1JmFiUzOQPbwFBn
	716qz4WWOtQOO5B0gvD7TDNWSmdSeGOYs6Oldw3s9s4x7VO18vvdD6qEoHgobzMt
	fW1JSfy8XRM+ndVZBhKepn+o29dkovBXNYgF0m55DJNO5rxGzm7lw/kVKbmgDyIs
	+wKyLj+tDU4FAdj4eTHxfbwHCO0Yejs2Ggmhde6E2zwovCXl5naTcqF5mWjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742332654; x=1742419054; bh=8t115/rU7TOmocIPA7Ojqh/r+a+PkaGmOtB
	66j+R0xU=; b=WeXP4fXK/JBByczHgboILLAedi4JVhSOQo4dIOlI0QcVodjcGt5
	/7DvMCiSwGBDTm7JO+70hDTFu6Ex47pqZWON22iambJI3OK/Y5SNf8L69tXd/2XM
	cAy+0SR8JB00k2wAh/CRRioMi79/4783pVLOaWQ2g7OfSHWynf4UJAhUdAWg94+1
	ry7wE7JbZiNrNCNbsJhmYunk3jsjL0kX4KzL25KLmvAG4TWHyBle/YTuAnbDqgVF
	xqtnjFY1Jv8kQtO3jbXcoROXP+IAYazQLafkb0eVs7I4D7N/z7OnG/Thc5lA3tgW
	3ZsKNMm3nvK50XyUm7rZguwQAmcLjoxXWzA==
X-ME-Sender: <xms:7uLZZxxEqf3mrYeAI9ZvLemRTz2oLKiSatG74s3_gfkfP6jDqPYIJw>
    <xme:7uLZZxRECW5erK2hrAh_kFdFkSZ0mmRLUlGbMAQOVR_K-qP12ejr2nlsWjaMG-0FN
    avfe1UVmRNemspkug>
X-ME-Received: <xmr:7uLZZ7VM7D6VoHk_yuQkG4WEsbPI1_3iFAP5uO12d51J5XWIA5zLhJmw9ecd3Ip_EhbT3omu1Eu15fjl0IhDsFyHqyxS7coVKu6FmXU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeefhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthgrrghhohhlse
    huthhurdhfihdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7uLZZzizRgnG-0hjLr_En1VEYWaQZGZftmByppN1HQPiEAtTXWVYBw>
    <xmx:7uLZZzBjAnzC8CpslXvvKNC_aNQD5SHG8_qcqLeI7Fgs3gREXgBHiQ>
    <xmx:7uLZZ8L3R4O9nhxMYIy8DeUXK92RghZQgVJuw9i91ZqpcEtu4hvGFw>
    <xmx:7uLZZyBbsqO7H-GVAh6BJ7Vu7NOE-hLRqllQqg7Ly9mpuOS2tcSdNA>
    <xmx:7uLZZ6PT2tGniwHN_ZmTlqc8MulacmoD6-qM0CwSSbgXNhNYwY6l1B00>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 17:17:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] format-patch: use raw format for notes
In-Reply-To: <20250318180251.3712-1-taahol@utu.fi> (Tuomas Ahola's message of
	"Tue, 18 Mar 2025 20:02:51 +0200")
References: <20250318180251.3712-1-taahol@utu.fi>
Date: Tue, 18 Mar 2025 14:17:32 -0700
Message-ID: <xmqqy0x2yr6b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

> The default formatting of commit notes by git format-patch --notes
> doesn't make a very good fit.  It would be more beneficial to use the
> raw format for CMIT_FMT_EMAIL and CMIT_FMT_MBOXRD.

Hmph.  That is unfortunately quite subjective.  "doesn't make a very
good fit" why?  "more benefitial" why?

And it turns out that using "raw" is not a good choice in the
context of e-mailed patches.  Read on.

> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> ---
>  log-tree.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/log-tree.c b/log-tree.c
> index 8b184d6776..c40a7599d0 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -857,7 +857,9 @@ void show_log(struct rev_info *opt)
>  		int raw;
>  		struct strbuf notebuf = STRBUF_INIT;
>  
> -		raw = (opt->commit_format == CMIT_FMT_USERFORMAT);
> +		raw = (opt->commit_format == CMIT_FMT_USERFORMAT ||
> +		       opt->commit_format == CMIT_FMT_EMAIL ||
> +		       opt->commit_format == CMIT_FMT_MBOXRD);

After applying this patch and running

    $ git format-patch --notes=amlog -1

(where refs/notes/amlog holds commit to original e-mail mapping), I
get this:

    ...
    Subject: [PATCH] format-patch: use raw format for notes

    ...
    Signed-off-by: Tuomas Ahola <taahol@utu.fi>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    ---

    Notes (amlog):
        Message-Id: <20250318180251.3712-1-taahol@utu.fi>

     log-tree.c | 4 +++-
     1 file changed, 3 insertions(+), 1 deletion(-)
    ...

But with this patch in place, I instead get this:

    ...
    Subject: [PATCH] format-patch: use raw format for notes

    ...
    Signed-off-by: Tuomas Ahola <taahol@utu.fi>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    ---
    Message-Id: <20250318180251.3712-1-taahol@utu.fi>

     log-tree.c | 4 +++-
     1 file changed, 3 insertions(+), 1 deletion(-)
    ...

There is no indication where the note came from, and more
importantly, the contents of the note loses its crucial leading
spaces that makes sure that any random lines in the note that happen
to begin with "diff", "---", etc. are not mistaken as the beginning
of the first patch.

So, no, this change is not a good thing to do, at least in its
current form.  Besides, unconditional change like this will break
existing users.

