Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A70C86344
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748893759; cv=none; b=NO40LwatJz/liRkWKs7KWwnR8fhk2Hmk7N7f/g7LYXPHEwO3NxwtRWxuaJFGRjjpqHkgH9ZhmZBK3RC/XXrUC9TymmkThAwak/aUyuZ63ixQl5YHC28oMKU7Qw5y+aO4A0yg8EwxMtGm5GlDCN8RKan47YnKnMqnJYkZCYdHFTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748893759; c=relaxed/simple;
	bh=7uMf3tk5Bjbi9w9GNNWcdG2dqiyeBs8iUFnOelPq2xM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qbq3S+pZDXkMYSnPj9dp54qf95f0mlF3a3yJwcs5MKsbmq9YP00kgs0fMNldRthT6t6C34yt8aLvY+Vb8lKmjSEhcOfzUp3SiRPt1YaXeFlYhmlgASemn4/zrA8xTV6I87Jpni8NsvMgUqPdW0j0C0O+VPBAisAdCOpcIBwtvKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vylv7Tbo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TZp490xd; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vylv7Tbo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TZp490xd"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 40A4C25400FC;
	Mon,  2 Jun 2025 15:49:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 02 Jun 2025 15:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748893756; x=1748980156; bh=1BkblP5QXk
	i9yGHfI7x2U1Wl3wtdHLmLUbhlugU/WUA=; b=Vylv7TboZ8WjkgmTNn+uGqKJVW
	RjY6JxaVNM9tJ7cNKbnTYWBfg+gxAlT+g3pmcxK02MnCnV3Nj1QY5VkLzWD/leDz
	ESd+UjZOVq2hDma2KGchlaoUycn/xiheUb008ICaBam6ko4GD4DBQlM5C+s8Ze11
	GdFtWDW1rHA/ehDwQ7BNrbiFsyz72Ft12+MiZ+iKuM4D6EmxK7f/ruQxbp34Df6h
	0JfxQ/ESe/XmVHhmkPzcKrpsksruJaiXqWFZKubOC0BysyUtwZCiVzQKvfMqfId1
	X9djAUN1Qrg71MZ/xeXejoFqrsfkhJ8SzNIdm/kohIz1Nr9UVnhueWSM7wrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748893756; x=1748980156; bh=1BkblP5QXki9yGHfI7x2U1Wl3wtdHLmLUbh
	lugU/WUA=; b=TZp490xdrGhlFN105VOxS7gvVq4rA2RUrQDfayMv8gtA6LN15X+
	zDOq9++NEB8RcazxAT2gMa57j0fYRc3DDlhZgAUqX9XpEOvnT3Viej8y6HqOHhzb
	kBu+KuWH12z/jEu6541msNQclTKfr45Gagrx9QQqZWGN1ggPYRBSoa+M3GpUx4yu
	RUp99pUPaXNF3iuSwDzH3147uJKu7RmwxG6XfozMCX3JnUFf7gocmAqwF94PHdAf
	lPc01ZSfE9RF8x35gOKj91P9JHnboJt9p3EsyrBZFSJenICbC3G1SXhd3D55QHuy
	xMiQXUstF2UzMqAEOKIFsiU+5kOg2wqmR5g==
X-ME-Sender: <xms:OgA-aEquw2aR72E6b6Sq5JuJ2sxzF1dtXCiznzDmSfZnJTwM3rQMVw>
    <xme:OgA-aKrNFbChPO_c9R_IFV30YvRumMXbmLoLLq0Kx5qeJzISyXGFQcHwLy31KmxGC
    CMwjQKF6hn3CX7WwQ>
X-ME-Received: <xmr:OgA-aJOlJ4wUc-mERB9pV01Jp6WrNSKVcTw62vx7wzdSJh90D6Z8vbEcvV-2aiYa-l2EUsUhCMKBFYdv_RxZLLYXZGoRK96cf9kD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefkeehheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohgusegu
    uhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvges
    shhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:OgA-aL79Cq5MDFA6gXEgp5j6-PsHoP7YLtrdQJ6zzpbOT9VGwy_8jQ>
    <xmx:OgA-aD6CEuZxn0vT3H72ugT2j60UHKa9_01GiqGbzz2dxMBJ0WB8Kw>
    <xmx:OgA-aLjE8-xqBqThOsZRF66jM8BmWfwDJphvn9A42iiZHiGNmmXS5Q>
    <xmx:OgA-aN6jxULuSKaJ8GxYWwgedZEPXC5s6nDzbA-zlVUTJp-F57ZmLw>
    <xmx:PAA-aJzM_hdD_g_VBiCHOnO1C-47WRaFWSK63lY-9CyysiLxbWEYWcPu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 15:49:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk,  shejialuo <shejialuo@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Karthik Nayak <karthik.188@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH] fsck: ignore missing "refs" directory for linked worktrees
In-Reply-To: <aD176UYWKEbmhiaw@pks.im> (Patrick Steinhardt's message of "Mon,
	2 Jun 2025 12:24:41 +0200")
References: <1d8f471b6dcb7e952afea834490be195189492a7.1748629208.git.code@khaugsbakk.name>
	<aDp55upE6AhYunz7@ArchLinux>
	<b92b5d93-7f7f-4370-ac79-7d9767bb0db5@gmail.com>
	<aD176UYWKEbmhiaw@pks.im>
Date: Mon, 02 Jun 2025 12:49:13 -0700
Message-ID: <xmqq34chudom.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Jun 02, 2025 at 10:53:50AM +0100, Phillip Wood wrote:
>> Hi Shejialuo
>> 
>> On 31/05/2025 04:39, shejialuo wrote:
>> > diff --git a/refs/files-backend.c b/refs/files-backend.c
>> > index 4d1f65a57a..bf6f89b1d1 100644
>> > --- a/refs/files-backend.c
>> > +++ b/refs/files-backend.c
>> > @@ -3762,6 +3762,9 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
>> >   	iter = dir_iterator_begin(sb.buf, 0);
>> >   	if (!iter) {
>> > +		if (errno == ENOENT && !is_main_worktree(wt))
>> > +			goto out;
>> > +
>> >   		ret = error_errno(_("cannot open directory %s"), sb.buf);
>> >   		goto out;
>> >   	}
>> 
>> I think it would be clearer to write this as
>> 
>> 	if (is_main_worktree(wt) || errno != ENOENT)
>> 		ret = error_errno(_("cannot open directory %s"), sb.buf);
>> 	goto out;
>> 
>> so that the condition that triggers the error message is explicit rather
>> than having to mentally invert the condition to figure out when we return an
>> error
>
> The downside though is that this mandates that `is_main_worktree()` must
> never set `errno` itself. So while it may be clearer, the original
> version feels safer to me.

FWIW, I found that the logic flow of the original more natural than
the proposed rewrite.  "dir_iterator_begin() appears to have failed
by not returning a usable iterator, so we may need to complain, but
as a special case, we can tolerate missing refs/ hierarchy if we are
not in the primary working tree." was how I read these three
additional lines.


