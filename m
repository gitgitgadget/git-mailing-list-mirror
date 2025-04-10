Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589CA19DF99
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744313071; cv=none; b=Wzkxcm2RFjUsUW8QDv+0RLG0shSKgLrrsMDQRYT3jCZWz3dzXanQz+QETyAnUvldvyVtjWixFMF8eyQiKigRr/zg1gG5QP/xfhhurEg92YilGpAsN6sNaUK8tszi/zj6GbX97x2xfPzR/uNY2eixlMi9CyFwBzXYiId93cyWgM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744313071; c=relaxed/simple;
	bh=+TKuoqX4znCLY4GodHD8L8cjri17ZT0QIsnNHkf34Ec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fGgqrf8BxXWoT10JZjVOI1aH6H7S1vz86rLPfWhzCvivqYralIaPlDBT7j+OoF0SPC4StKyReRcM/ow3iQlsW648Re5N6LucP8mR3zUH/apZt8OP8f1sWyGbcSYWniKldbT2/UE0Dw+J1QRNcLpsx7o85juAqktKbNIxxPYswfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G5xceaJD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EJVS0DZU; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G5xceaJD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EJVS0DZU"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E01F1380147;
	Thu, 10 Apr 2025 15:24:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 10 Apr 2025 15:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744313068; x=1744399468; bh=vnPScDGIdq
	w4QOGvRm0nbjD8pYdqqQddwT/wk5aWu9M=; b=G5xceaJDA8E5DEspZVTvAXKHou
	TW9CQVhSIWh1YvIag4Del7e0gWov1ScAzvXeuw1o2uj3F/OrOFvNs+TqxS6F6Fno
	eLtmFueRj8sMq9zGb3wqegEqraNhTNRZo/F4a1YHjfe3nehleg2p80wQ+7lcBJZ4
	Vr/F1faovR7BTUV0oorDxc5FJ4BfIabamfG0Hhfg4kk2diNC4PCxFjlqS5ux1Qc3
	7JWBwVRqo59nHYFVLC10vT7halpRvHXzBjEtaCTj6zQvscz4VQRjQpeKRKUnmD2l
	wboG+Gst0YMJEvlQEkTXyUNhRGKxAlBConpIjLqBrbW3twI5MpLt0epdWyug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744313068; x=1744399468; bh=vnPScDGIdqw4QOGvRm0nbjD8pYdqqQddwT/
	wk5aWu9M=; b=EJVS0DZU4OEY4THjUfAE6ZSNdCj81Vr6tWTz4dpIjUVIp6kT3mv
	P7ehdlTaXoITV6usGS3c3B4cqW8tQPezt5OhIPQtvWs0bF7gRfouf7s3wza9jk88
	kb+k9INK7knBfH3Z/vLJCuVLXsb4RPC7qb5J5VyMA4Sc7jMaukoLx5iTydiKz9SW
	PwiiZ+Q/Ip9BKpaZYxQAibAXbBAZtZkC9bvODIkMsQjJK0hJCiW55YsxA45d6qIt
	l2zJqVEhVlpNm5gr6ig7TeGTK+TgvrPKhoTnfj35LN2TWb0jsIl2zPsCXnuLpA9m
	kPtcAslaamellhQmsfUkoLY16jrUt3Q9wfw==
X-ME-Sender: <xms:7Br4Z_rtLqJeMEl6Hz_-cOeOuUBkj8FkhTK3dLUxTSbhyrkd-E9sIg>
    <xme:7Br4Z5oLOK5ZYOOj2Z_vEsbEu_2mLCL4HgFpJaGZfZTLG6jLAbeOTh_bkJbqZUir2
    iznHhBGd4DSK3u6HA>
X-ME-Received: <xmr:7Br4Z8Okob0kWROrwPUGfJbynAYPkxbYcUWDNpkKeoUYGS_XLsqvO6mtbgWZTLQQS62QPrNkczKCAM8JugIFkLsRYZf6KTakNsFu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeljeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhoshhsrdhgoh
    hluggsvghrghesphhrohhtohhnrdhmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7Br4Zy7FgTopAdS8s_cx88N8KzeLeAGPJcwIc8Q11iMGq9krXD8Gsg>
    <xmx:7Br4Z-4MFGd1AX2wDm8zmGXXa3stOdxA2Xb-hTv52UPTbeNjcILxhw>
    <xmx:7Br4Z6jxdbdX6gZXeUEjTZqrpMshKRaw4Z0FgfmOS7HupCujwE2A3g>
    <xmx:7Br4Zw5m0v358O2sMfZfd6AsL51Nsp45avH5383qxYa26_oJT8iQkg>
    <xmx:7Br4Z__K7XXNli_dTvlgwhbLzdkIIZjbrTpGKWUzcPpbX1KlouTYuHhc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Apr 2025 15:24:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ross Goldberg <ross.goldberg@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Command whose exit code indicates clean or dirty working directory
In-Reply-To: <jreR52go49E9pIfAmIdRaoqIgKnVV7uOhR4Mbl9_p2dLG_7mPgO8qsUk7CaWC0nGbJD-2F4nGdQ8X65UtIQ5XOBNQXXzrnHnKbOCLCfEil0=@proton.me>
	(Ross Goldberg's message of "Thu, 10 Apr 2025 17:49:23 +0000")
References: <jreR52go49E9pIfAmIdRaoqIgKnVV7uOhR4Mbl9_p2dLG_7mPgO8qsUk7CaWC0nGbJD-2F4nGdQ8X65UtIQ5XOBNQXXzrnHnKbOCLCfEil0=@proton.me>
Date: Thu, 10 Apr 2025 12:24:26 -0700
Message-ID: <xmqqlds7om51.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ross Goldberg <ross.goldberg@proton.me> writes:

> If the simplest such command is complex, is there any feature request to create a simple
> command, possibly with options that specify what is considered dirty (staged diffs,
> unstaged diffs, untracked & not ignored, etc.)?

With the "possibly with options" part, I doubt there is.  Once you
start having to specify options, you admit that the problem space is
no longer simple.  Depending on occasion, you would be caring
different kind of cleanliness.

If you want to know if there are changes added to the index, "git
diff --cached --quiet" would be a way to ask about it.  If you want
to know if there are changes in the working tree relative to the
index, "git diff --quiet" would be a way to ask about it.  If you
want to know if there are changes in the working tree relative to
the HEAD commit, "git diff --quiet HEAD" would be.  You can use them
to ask about various things you care about, and you can combine
yourself, instead of using a single command with options to specify
which questions to ask.

Having said all that, if what you care the most is simplicity, you
can probably use "git describe --always --dirty", and see if the
output ends with "-dirty" suffix, perhaps?  I suspect that it does
not care about untracked files, which you may have to independently
ask command like "git clean -n".


