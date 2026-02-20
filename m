Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E366C1CD1E4
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771618895; cv=none; b=Qx4S62WdZ2Z/uK7G+LkaUDoMkU95T5ojnQvXJlwLvjwbyR5SLtL5YKlbKhCnU5ZbbZFTRmzW3VpFv5Tg5Mdaw2zirIMPx55L5aRpHBR75JedVcSnmzwujwp07lNK0uK9NiovQS2GU5Oo6+85CKTQe2RP+/lLiXJEeBJtmFc0VDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771618895; c=relaxed/simple;
	bh=Grj8j3MjPXkMh0Oi+GbMlDbPph6RlRbu/gUp1BlrusM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M1+c59p+Oy/fjvUn4h16qPSjsEd6ec37ewdq2NSqAIRW84D3UDf7t2RGbgk6O1XOOcSXBSZzHJwKC1ocm3KC+SVoaG4WfuxRZvahQ+Ka/VjImg9EMdCTXkwzTQzUWMhM3A/L5+ypgjPLy+A0v8oUnpMyXe/FBUNrb2YM7IVMa7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pp8QcfBa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r3ZL2BwG; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pp8QcfBa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r3ZL2BwG"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA9B57A0113;
	Fri, 20 Feb 2026 15:21:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 20 Feb 2026 15:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771618891; x=1771705291; bh=JD/sGIU8ZT
	LlXX/DHypRBTmrupY6x2IqeMzi2u6x62Q=; b=Pp8QcfBanwfcI0NTwnR0NFSOQW
	jf1r1Viu6TTQ8+dqv4l+VVKfY2r+rXSv5HILDs8HgHo0CQKg3+Grv7ixa+qug5W5
	ATi6ANT4RPBBhvUICg6VWt9pBlrl/Uz+dXf5gyV6fqpIN4zQ7L/NznzR7gcTLJZt
	Z8c10Fl4vBLkI3YlMTw5hGWZn/zbS2AdbGWZiXgLYJ9+GqPMoqAg6DGkbBi158BB
	pX/aAEGPcirjaJt+ufW/zYy+SZV4+WEDeh0LTOv7VTLyTod7jX+cjUprZtQGsDk6
	vTI2fyPVq4PyD1B5V+LVWshjZZwu2Nh8Ud6Myj2u8C76j9C5gKMInqZAO9TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771618891; x=1771705291; bh=JD/sGIU8ZTLlXX/DHypRBTmrupY6x2IqeMz
	i2u6x62Q=; b=r3ZL2BwGUP7x9vN4s30NcjTfmUvNy8bbdUcLzRQFjy38AcJL6y1
	A5Mogo0rWXcYpTs5LE1fBbrwH3lg5hnecI61lFfPc3er4qqxzIH67yUlALzbD7V8
	vIjtOS9Ga4fhwD6jaOHHvZZMm+cVmOnyhnl1ZxrBw9D9tdG/9VXMKRiDZLYN6rzf
	cPPrOUpcR5hW3xy4jrA0FAjPLdiWb8rU+Wuxu8BDfGTlDle/9XTubPHK7heilGM3
	jRwLVNFQUrYoCqrD37l/jehr+Syqi5SvuzmbcgETYRGNa+jp2tNwI4mSnJUyMQ70
	trNLtRYpqKWAzPnfha2h9Jh4aoBQOQ/IAWA==
X-ME-Sender: <xms:S8KYaTa7d1q7PZob1WWoHcUXAAXNGJiOOpl3NUY3dw_FE3moy-r_3w>
    <xme:S8KYaZ0xxzLPxYukW2HLiA_7emVjWvgABpbqjPYSgQyb6TGisyEjx1jqQT9WYQ7ad
    HH3kf65IBAnFtRncOqHkMI0O-TW5o1XYsVrotQ9I9YZpmjmIam8KA>
X-ME-Received: <xmr:S8KYaTU2naw5HRrcfKA3JnMqAUXFTkqs_QydKwbx0txZrqNy-9xrH6TQ60raDX2FNWZLm_NKSt-6TvOGfbv-Sf-edtMhB2pIRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdelfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigf
    efkeevteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhhrhgvhigrnhhshhhprghlihifrghltghmshhmnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:S8KYaTU2SpXe1miLRvQ6Fi_pBtwgi1IjF0AecgnOsEQ2uD3xHng3dg>
    <xmx:S8KYaScuipYLowuSDjVCIbpt0lbFUzthDMSCXGjmdEN4Kva3l3S86w>
    <xmx:S8KYacUx0qZCCc-ezjJQfvHMG-J7UkbU86apiImgQwxLLCphrHhfqw>
    <xmx:S8KYabc4pQVWGgrEvbClyqW-LLE9ldkt14K5uyHiuFz3qgLNy1KdUw>
    <xmx:S8KYaR0ii0Xp-tC5r5niKjUuL0GidCtNdvQtIswl8_7zknGAZD9s0jxP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 15:21:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] tree-diff: remove the usage of the_hash_algo global
In-Reply-To: <20260220175331.1250726-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Fri, 20 Feb 2026 23:21:26 +0530")
References: <20260220175331.1250726-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Fri, 20 Feb 2026 12:21:29 -0800
Message-ID: <xmqq342vxj1y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> emit_path() uses the global the_hash_algo even though a local repository is
> already available via struct diff_options *opt.
>
> Replace these uses with opt->repo->hash_algo. With no remaining reliance on
> global states in this file, drop the dependency on 'environment.h' and remove
> '#define USE_THE_REPOSITORY_VARIABLE'.
>
> This follows earlier cleanups to introduce opt->repo in tree-diff.c [1][2].
>
> [1]- https://lore.kernel.org/git/20180921155739.14407-21-pclouds@gmail.com/
> [2]- https://lore.kernel.org/git/20260109213021.2546-2-l.s.r@web.de/
>
> Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> ---
>  tree-diff.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Nice.  Will queue.  Thanks.
