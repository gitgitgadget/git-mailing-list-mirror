Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C574379997
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 21:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883996; cv=none; b=XuTU3H3W4GHTuG6PkC+vUfJAzGVoN8EDQJJqxSKn3Q/3ZkfOv8e2U6h3GJecKJ9ObgJbPJNFOsGAwG5qDwF14GIp9fLvEaCKTiJHLnwMy1OBMsAKh5pmz/ZIzN/JHTt3MiefD1nQAtiHN+1ZW1Cg1xorkmQzEVh9yCt3glhSE+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883996; c=relaxed/simple;
	bh=Ye0JqCyKQK+uROeqbIGiYPD08QOpnpf6RsDpxi79fNk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PY3M4Wc+tqRRPqR0eEU60JamHJeB+1dkENXVXGHc5eSLiF7DsvrfNVuCpWN2LgqwYqH3Xx23OGgY2c0uDOzW/AOPeysqRBS7UGrdHn9GeFIn/dULYi4FKX5x5IYrgXX2GPh9AUKso1oSD9kz/CuQi8cE1CS86eG4vsOCSTKjoo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zq3sXLuf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R6i+/XER; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zq3sXLuf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R6i+/XER"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id F2CD8EC067A;
	Mon, 23 Feb 2026 16:59:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 23 Feb 2026 16:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771883992; x=1771970392; bh=DU6AZayoWN
	kee1AcYGtGbSc3E1MJJ1HmLAg3AjqiPN4=; b=Zq3sXLufIT3NxovYaiAEnEKyTY
	Nvg+oRjURL1nKIsdIp9OH5obuxm5iMOs6wm9bpRxgIjWJ86+ddMjmEIiBd6Ah8MN
	6DVmADbCz3VNg3Bbug5TU37GVPQ84HjrwbzgvzqCF8URt62L7fYzEoEaAYW/7M8Y
	xxmh/hkc08xSRSJwkxEmkJC8oR5PpY/Tx4DIRxzcPUeVxs5ZGoWPyu3VrzXlxxZV
	zpJHTmiIbYjdb3aOauq16zTFiBVSD50e1SRcYlOp0xVSQfj3vhMentx1CNhuTPDE
	FJy1touywSK9RR+ylI4Sp71Xsnb5oi7fFJTIxRy3cdhqmV0ZjxknfK2n/qEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771883992; x=1771970392; bh=DU6AZayoWNkee1AcYGtGbSc3E1MJJ1HmLAg
	3AjqiPN4=; b=R6i+/XERAZ4nkHbd+q/355hnUC641IIdvE+8vF3ykDDggr1J0U5
	1lckCtk9OZ2IuLjqB2aOHXx12so0jSEjyLQf2eVaLPwewRIyf+WMrWmSBR7sHIJm
	IOT8xO+eermG6dSQFESZmmffpboxTDmExjhNVzNwIygH6EaoBdt9CHRehqbRjpy9
	lXH9R8IYYi9XWj7+Tzeim2eaMqCSbc8lV5ChaV4nzHbT4XVbqf02q7KdBtwPQ4Iy
	UEfCq4aJ2BBhVr6dkt9THDfFY4GDyPdGSLL3bommKNl/Thwh2wOFBfpQOGCWA0tD
	WZ1AGd0AzcMLFYdkZNjRbkolEI1KhABn94Q==
X-ME-Sender: <xms:2M2caRiGj7HRh0-OrJP2JbF41yxNevDytncild86e-NNHYhH2T4LTw>
    <xme:2M2cadefh6yDg_XQ_LnFP3tdKknpkw9UF-w6vdRQc3sYotH9CHTBbmK1m7rIh9YNT
    y8Yg0aWplW6d_2ZerauBMVokR-wGy7PKyxaHKXabn17g5rwYpC2EA>
X-ME-Received: <xmr:2M2caedADFAxUJeVrl_IjOp38XmT2aV53Ugve9q76ybRVae0Ik3-Vq4VtusBGc6q_pc8R-nlYZafVGz0qzeCcKi2Y9Jw9uv2cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeekfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:2M2caf-vRScK4PaAKipNrqsac00M2mHVY1KPjlDRyhCbs5goxIVsvQ>
    <xmx:2M2caSmFQCAG_HAofjkdES1TVmLB0uYmPbnroHOxB0KAM3y8FzBkYA>
    <xmx:2M2caZ8JeQ05SobEGH5xRbTLxWm6esZ3KjePpX7iQNd-5Gso7IIvWg>
    <xmx:2M2caYn8lKlx1pxEOkubkNi7CeGef0oU0pyp_2Np7fgFYdlsXLlvuQ>
    <xmx:2M2caVnFGs26d7AcKeeYUe5qpQTog7YXvk_iEa2eHWscJ70XgnoasEBp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 16:59:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/17] odb: make object database sources pluggable
In-Reply-To: <aZx-mrdbZp-7VZfi@pks.im> (Patrick Steinhardt's message of "Mon,
	23 Feb 2026 17:21:46 +0100")
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
	<aZx-mrdbZp-7VZfi@pks.im>
Date: Mon, 23 Feb 2026 13:59:51 -0800
Message-ID: <xmqqjyw3ktns.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I forgot to note that this series is based on top of 7c02d39fc2 (The 6th
> batch, 2026-02-20) with the following two series merged into it:
>
>   - ps/odb-for-each-object at 3565faf28c (odb: drop unused
>     `for_each_{loose,packed}_object()` functions, 2026-01-26)
>
>   - ps/object-info-bits-cleanup at 732ec9b17b (odb: convert
>     `odb_has_object()` flags into an enum, 2026-02-12)

With the above base, [09/17] fails to apply, as the function
signature of odb_source_loose_read_object_info() no longer has
"unsigned flags" after "int flags" turns into "enum
object_info_flags flags" in f6516a5241 (odb: convert object info
flags into an enum, 2026-02-12).

+++ b/object-file.c
@@ -543,9 +543,19 @@ static int read_object_info_from_path(struct odb_source *source,
 int odb_source_loose_read_object_info(struct odb_source *source,
 				      const struct object_id *oid,
 				      struct object_info *oi,
-				      unsigned flags)
+				      enum object_info_flags flags)

Tweaking the patch (e.g., "unsigned" -> "enum object_info_flags") to
make it apply was trivial, so there is no need to resend.  Hopefully
there is no semantic conflicts due to confused bases (the result
compiled and linked fine).

Thanks.


