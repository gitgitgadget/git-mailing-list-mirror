Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C76222CBE6
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 20:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776197323; cv=none; b=ZVtjYaEUoOou/WsO/htXczih9mCgzS9d+Eh0fd7Qg0BIVINvHYHUxASZ2PQRDDZzpTiHhfIjcjUeem/6STeM1qwaFeCRAm7vT/JZ5Cb1dZiUfx+9Vjn7OmXyo3G8Wl0pmIXj3IW84waV66uQDC4/5QBb7ji0EF69ubQsJE3WLn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776197323; c=relaxed/simple;
	bh=9kKFb6rxB9S2RB0S9kQFHpF5PDc5wkpSBVQOro3lTMA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l7KZxf2ksHLvBMYcpwOgpJRp3nPy+h8+ZvPXKAorLxocXqgLU61p8/rBNJ50zv/sBZSLiQG1dNdRiFaxVn0EWF04w7eonQZDdCAVPe2jT+wTnPute/mlJGY3UTsrfjGpaKa0plyB4bX21Lz21EL7j+LN5wU1xx8hd1bpHXXKVpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cLFSjaZ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rKI1e1B1; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cLFSjaZ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rKI1e1B1"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8459C14000F6;
	Tue, 14 Apr 2026 16:08:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 14 Apr 2026 16:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776197321; x=1776283721; bh=y0Q6hlLFyv
	OS6SOLa6TR2A8ZaOtgVwrDrzrLgpJToT0=; b=cLFSjaZ7ggsyOMHA+yX+TfMgwD
	2PBNLybtlBiDDL0k1tD5a+4a8FgKzJhMlS57SA1zMPXEpz46IP15xTnBfxPdzJWU
	wUJRiJzR6yYtIDrfjzZliHXl3nD/OTtSbnJG/XMNrYWze3cWcfa4UBt8DWpIWPmP
	Uh6Vd93BHCHJc78Ua8Nxovf5KtzuQnh3K8/qukd8D7B6JNij1iEp8UgIx4NveACL
	1E7npFBTl+T7VVe47UD4ztmxtin97S69mMwYI1d99NBrd4mMJLXRk2vvbEEZ4gyR
	BYeZcKjMl4ZMpQDxgr2L212Jc5eTYmCsanu13foiUC3L38DVXhI3qBXBeJxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776197321; x=1776283721; bh=y0Q6hlLFyvOS6SOLa6TR2A8ZaOtgVwrDrzr
	LgpJToT0=; b=rKI1e1B1VbNKLhBx+zHLzna6SyocB0BVXnGI7m9T3TywTgsYe57
	pkZtAgbNHAYOIiN95xUuCTyLqNfhCknTMrYfBlR/+bGNiR9I85L5X9v004xKy6Bz
	IPWFrDKDs4f4qNl8dHlYSpQOUxDFRSXw+YcOG1BtxiO7A38t2KJ6yhfn4npT1Xh7
	wrapiwpIRMBDyXaDyemIMfQJAz2cTZp6mpDCqz7cQIyhypAdPrko0ujGPv51OK5r
	QqcmpB4EEfC3AJkufrsBwe8tCdMu+G4zgCWR7MUei3sJo05EBecF9qHt7K7JLaJk
	n4T22muaNFwa/IaNv6oPfGUveUmGD6yx07g==
X-ME-Sender: <xms:yZ7eaWT02u990fIq546wcMv9X1zsmYfG--MsictEr5QenX384SI_Ag>
    <xme:yZ7eaSrNKPe9w-71vlUvAVgFdZi33DGQgEf_aaSO7jkdJWYvHhK4XucfjpfDJv-xL
    r3ldRWBMHQZ13F0okSaIYca1gVbshjxzsBXngW2H158VfPKgJMUr9g>
X-ME-Received: <xmr:yZ7eacKpfRZGMfsJVyiXoKRXlwULiMalAmEBTiO9VLjuPFNlp5NVGzwjRuhvg6TC4ivgR2kGM1uaMUqTYQ7yZnzcac8Bvnr2ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegvddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:yZ7eadq9frqiVSZ_voU9wfr-VPRiQP9P3PLkb5lrze8HuGQxnwMI4A>
    <xmx:yZ7eacxuloyjb-u3BreC8bkDVmb8WrH-DtL84vw_TmEYVJYPOhAARQ>
    <xmx:yZ7eaZPOpBNLB2gAUPPzuPZb7FKbKjALkhRro9EDyVtDiMacZGmC2A>
    <xmx:yZ7eaZ5Oga6EdhgyFAYg01lZwqWgJmKNhcKnsI2dwheBhJlRtOLWqw>
    <xmx:yZ7eaf-IQ__wDUECGppXzkjiiuSaXHtlKqplwlKwWt_Nz8qJBSzO6TBI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 16:08:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH 1/8] t/helper: add 'test-tool bitmap write' subcommand
In-Reply-To: <d5ef6b959fd7c05c73bd33aa2b394558320aceac.1776124588.git.me@ttaylorr.com>
	(Taylor Blau's message of "Mon, 13 Apr 2026 19:56:40 -0400")
References: <cover.1776124588.git.me@ttaylorr.com>
	<d5ef6b959fd7c05c73bd33aa2b394558320aceac.1776124588.git.me@ttaylorr.com>
Date: Tue, 14 Apr 2026 13:08:39 -0700
Message-ID: <xmqqeckh9uew.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> +struct bitmap_writer_data {
> +	struct packing_data packed;
> +	struct pack_idx_entry **index;
> +	uint32_t nr;
> +};
> +
> +static int add_packed_object(const struct object_id *oid,
> +			     struct packed_git *pack,
> +			     uint32_t pos,
> +			     void *_data)
> +{
> +	struct bitmap_writer_data *data = _data;
> +	struct object_entry *entry;
> +	struct object_info oi = OBJECT_INFO_INIT;
> +	enum object_type type;
> +
> +	oi.typep = &type;
> +
> +	entry = packlist_alloc(&data->packed, oid);

data->packed is "packing data" that has a pointer "objects" that is
a flat array of "struct object_entry".  This array is dynamically
expanded with realloc() in packlist_alloc(), and it returns a
pointer into this data->packed->objects[] array.  We receive it in a
local variable "entry" here.

> +	entry->idx.offset = nth_packed_object_offset(pack, pos);
> +	if (packed_object_info(pack, entry->idx.offset, &oi) < 0)
> +		die("could not get type of object %s",
> +		    oid_to_hex(oid));
> +	oe_set_type(entry, type);
> +	oe_set_in_pack(&data->packed, entry, pack);

And populate the entry.

> +	data->index[data->nr++] = &entry->idx;

And then store the pointer to one of the members (actually the first
member) in that "struct object_entry" instance in that data->packed->objects[]
array we took from.

What happens when a repeated call to this function to add many
objects (those contained within the pack we are iterating over)
caused the packlist_alloc() to realloc data->packed->objects[] array
eventually?  Wouldn't it invalidate the address of &entry->idx we
are taking from before the realloc() happens?

I must be missing something?

