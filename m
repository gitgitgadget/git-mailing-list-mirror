Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3962548165E
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872608; cv=none; b=oShSdgs8VrBgpggEoiJcL+X2dISO8IgokD8NohJEL9ziP71ynlDctXKD2nQm1hMb/EIHM8gLmuXR/LxvvNJFOpWKodj31R9Us2h0Wp3pZ9ZddO6SEg7KKU7XICoDJVNn2vDJZFiBWxgDvbguCYjE3SMdBQ8aJGF9MDUgWQt2OQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872608; c=relaxed/simple;
	bh=bslWiGZcnOEkgKPOM8Qyfc4jI0do+XYzAhZ9B+dSrnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EqZyxsOv8NhGxStWazsAF7rLCb87Pmh8q76SWc5yue/f92DaCzL7O1xnhGJEmlN4RcfcTbqF+/n5ihWux8n2PgbjZUmrmI9HKIZU07uW5kVw6VxpTggBMrATkGCAeC/nfxu476n2SWsLYMhD8o39ZSiRceGgZRkcSgt7c4C5nh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V2uCByBz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C2drJShv; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V2uCByBz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C2drJShv"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 28A8DEC011C
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 12:36:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 01 Oct 2026 12:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790872605; x=1790959005; bh=LnsVNAjXgd
	xnD4IiR50LyT36J4oTnSg+O4zW6IGq2IQ=; b=V2uCByBzQUsJ5rIR0vYWqiPqp4
	27MHBBmL6YESNXGPJsayZUW15Y0oztj9YAcIWr97J/eFsYrVH3cBHzgZSrQVxAIG
	rZBzpfpqrRyf2EkcDkFopmiCrcSjkNgi39+lLyyDOePvjnxM2MN6XgMq72mgKGP3
	a/7x4m9qp7BmqHA+fqluosEmtCq0g9LP9kKpGn3QCuscYCZY4HHK3CtASViwheQJ
	fHVcuK3qvOGhiBJX3r1Ffz11IHbF7cnpphz1ICrLOihYbD2wMFR1yaEyzDvzXlCA
	38Vl+cDwcJy8/9jetxrMvy1FFHrQ0AzwF8Z+vHZ7isir7h8/10a/rYCNhgHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790872605; x=1790959005; bh=LnsVNAjXgdxnD4IiR50LyT36J4oTnSg+O4z
	W6IGq2IQ=; b=C2drJShvoMa2aI+HpptwXFefjFr3MP29rs+aytvnzLRfY8lA9ud
	fi3XTv8ZkZ1Ec4GK0ZoIgD+gpib/gGVO/knytVDns8PfD/wdgY7g6ma05asO6lwN
	QIQtrBObJRvCSktFDUti9Cg9UOXG/rg7z2dj/8+d5/+0YPxdAKR/c9c09xq0Hm9j
	dJG4B+r59bsjIZzgje6G9cm3z/FU25d5MEK3guX/QeftBM8Ww8cbX3mJTpk2LopD
	KM6jW1MCVajukFazwi16VpRuJ4/DO4JdBhVlmgzMZ8NqfVNgoLjTosx9OFc5VnmF
	M+57h2OcufdSbx4fNtqaZrdluS7N31a0kpA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790872605; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:IcHXyAXl88GJnsvYzy7ixXAN2btp/PKpGj+RP8QJlGdd4Y/
	rkuACCPD1gtthnO4W1+POERiwGq5easeA9fvs0UcE0jThyYQBRQfh3pdWeuYbGtM
	WUD/8FXp+3hg+pWGLRY0pV+02wI5EA5rHJiwoW8SPpLfWm88svZ61DkYQoZr9Eq4
	sxI3C0/+G+6dZpMWH91M9b9REKHiDF/pHb/PDojN/SuhUWeGBGI3FiQ5GGWLpSAT
	NB4npxstzVyiUl1Y3fQl9EJC++qWvLkqBvNeSJfSurHINxM/PF3M4ESKim5W5vXD
	QInjrbDwQfhioUaIvhqoxCFufQ2qWU7z3oKM9Ww==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:F9ozz3G3sjlkK6H5f5scpwkmuKcV7VYuU5Bxe0paSM0=:bslWiGZcnOEkgKPOM8Qyfc4jI0do+XYzAhZ9B+dSrnE=;
X-ME-Sender: <xms:HIy-auiOAXR3GTwqx4_cSv_-oJ9SZZ48znKpfenAl32GecaQl4PLXQ>
    <xme:HIy-aoW425zHfcq8_vQhauL0ypB3JPp6VEQKWui-UL9vHZY3I-IAtgngnft6DZDaz
    4E5cfRc3S2whS6rs53gjxhVARvMKnCvyAXgxzOO-QEfoczS-K4hFA>
X-ME-Received: <xmr:HIy-atXdZgiSbhx2cFXSIdYBzxR6YNo-kt2qIs_d9CpfVy-sYsItsC3p5vVBgWs6oRQ_7wjLwXVJqJ97EwWqiJJOyd3xD3-S6p4b>
X-ME-Proxy-Cause: dmFkZTGPaJuTUaCN05B+XQ/sLWqTlZsKBoR+MuAZFLWpO9PZx5g/orgTrS/jAipd25C4B5
    R5ADBc2O67uY3n8RnmQ+6Lf1LAwIN/PVN/pwvdgqsve9U00OabJ4Cg5MXWUX7arac0o3kQ
    oU+rApsLeZlYess/KGr/h4jK82roazOhny0xeVS12V6yumcIYy6xvoz7FdIzVZm3QyTwUV
    VXPPIPWdfl3a1SYFBi3kp5/NvUE8VTNHPIezJaeh5fRtXq2UjwOXQ0E1fTY3Idr6oQSrZh
    Sk+kAkBMyioGT73ZxmJMibaPdLJ1XwBNImS0eTVHS17SgZM6nu6RogkoFazR5ISVzgYLU5
    FAMWHBPazLhm1wKtY9s7SYtSWfqCZDIYwEr+IzvOd744hsboogFrL9R+6Y//92vIPPB6ga
    UAjmzyKbJ3uh/fS+6pbDAZloatQ4ELknPUSzSsMxe+V93MF/xM4fnYm3OAK1oPJowLQGyX
    PdsR3H6b/VcrNcNtkKHWmskv0EAw3L1YKkxIAr3hk/0YDaEs30pJbSbkkBN7HB7UKlwZv8
    kmQOPpD67ovpJpQK9QNmWe5wk971ubgbvY9WDczfuYEFAJ4xI5NzABmWfqVYl2dERllSWo
    cxwBeHy4ZGAGvD5FcdAVaLfKgRWH4ErfL0d5NoHan1UsXnqNdzzKrpCs5MTQ
X-ME-Proxy: <xmx:HIy-aojwpcQCUjdKoaO_ymD_HtFMgEE_Lj5QufLsV46twovTjSkhdQ>
    <xmx:HIy-aoYQKoy2yDoO5Q5QrfxDhFnuemjjRO92dGauRQCu7H_1CpPF_g>
    <xmx:HIy-alpxF-ereat23dBOZWva9tzapnWb5QpfrWNMd8xVR7NALHRu3g>
    <xmx:HIy-alP7Desltsfp2UFr81SX3_TkDyT3P2SA_7dBEFTVeNnJt07CcQ>
    <xmx:HYy-anATAe087zCY3yiuA2dLF9K3PGFZOfy_SfxVoO-19MgE7-uqrgzM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 12:36:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kazumasa Shigeta <kazumasa.shigeta@kanamei.com>,  git@vger.kernel.org,
  Shabbir Bhojani <shabbir.r.bhojani@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] stash: expose untracked modes in create
In-Reply-To: <ar5EwwEt8-ADeLdr@pks.im> (Patrick Steinhardt's message of "Thu,
	1 Oct 2026 13:32:19 +0200")
References: <20260929074222.11942-1-kazumasa.shigeta@kanamei.com>
	<20261001042155.33303-1-kazumasa.shigeta@kanamei.com>
	<ar5EwwEt8-ADeLdr@pks.im>
Date: Thu, 01 Oct 2026 09:36:43 -0700
Message-ID: <xmqqcxtt74ys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Oct 01, 2026 at 01:21:55PM +0900, Kazumasa Shigeta wrote:
>
> When sending a v2 in response to review feedback it's a good idea to
> both:
>
>   - Respond to the reviewer to acknowledge their feedback and/or engage
>     in a discussion.
>
>   - As part of v2, send a range-diff as well as some documentation what
>     has changed between the two versions.
>
> This ensures some netiquette in an age where we're increasingly only
> talking with AI, either directly or via a meat proxy. And makes it
> easier for the reviewer to see how exactly you have honored their
> feedback.
>
> Thanks!
>
> Patrick

Thanks for bringing this up.

A response to review on the first round should come _before_ sending
v2 round of patch(es).  Some people send them after v2, or
immediately sending before v2, but the right time to respond is
actually soon after receiving reviews on v1 and you had enough time
to understand the review comments, before starting to work on v2.
And then after working on v2, you would send patches.  So whenever I
see v1 responses come after v2 patches or soon before v2 patches, I
smell that something is fishy.

