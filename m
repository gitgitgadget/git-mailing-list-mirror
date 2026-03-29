Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BEC40DFD9
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774817720; cv=none; b=GUzacFX638aMJKCDsx8fUuc2kAqQ7Wb8UNQfcyR4UiH3n4tTTA1Y3mAbir7pNWXtw6RDnyMHKVFY3iuTFPCjFfcC6NRVcKg5XxmLtcx4vP1PYB0AuK5/GanewLir0Jx9yFkRdlWAy3bC0Hqo6If1bUCBaPksP2DwEGbuxlWkNB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774817720; c=relaxed/simple;
	bh=74M2wlgIEbIPfgvjkdmXENHuOSYQH/LP5mrH38DXvFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TngBhSFvwcFNf6l2YmWMiL9Swl0dWPncABWkaN1QSOm4A+kHQuXObfyERYiSQk8YMq97HqedphD13diR0pID3mhkUZ6qaX1E2CN4RJroIHtPl/Yfb7C5iahfqZMQ5dsu8A1/ZBcYvknNnEKvBNqD19mkOMhxdMMLGt3bP3m0xkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JmEv+hhj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LlRXJJmg; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JmEv+hhj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LlRXJJmg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BCD0CEC00AA;
	Sun, 29 Mar 2026 16:55:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 29 Mar 2026 16:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774817717; x=1774904117; bh=T93DF5PZIR
	I12mcmEmFsl37NPWtVqN5bYFwoVOuvR0E=; b=JmEv+hhjB4Z8wYAiVpJrkGCGZt
	cG1eIq6lfrlJL8axA6ve3+yt+lVSohx6bxZv56RuMK3KJ9e4X5c37ZwXVTJmuWpI
	N5bRUjIMysTO9xrQRkoPhwFAj8dOaFEvLi7aNWfznbepDYi5H6ufWYQEkX1rA2AC
	doGu/8phO6MRasf62x7e0BJNyqLOLrohTynpFbgJgheL0nKrPyNOqB36d3Z51eLJ
	u0deHKyk8TI7vOS7X2LpSbFX0by/pLT0MWBaRDWfDoS+aY+zgxudDjQLU+NKicY4
	bZorKq7XjLYl/guPw5GuXMBiHfvcA3t+NKViyolcz79FjeIvKSWqV3S9JX6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774817717; x=1774904117; bh=T93DF5PZIRI12mcmEmFsl37NPWtVqN5bYFw
	oVOuvR0E=; b=LlRXJJmg3QaIvvwcnJ1FFyR1f7CxEuk3dkvRpAfDYYUBjeE+3Bi
	0JH7Sd9/Fo6q0D8coyqwdVNMEc1I8dXrnVWoQVnPZ45SKsLuvh9YfmFqNOd7pOoy
	I4XAhqtm4Zl/fHN0powYrth5kiLEnWds+DMeiJ9SRGpijs7cso6+1m8GnzLUbO29
	E82AVbjSD//YKq3yEmxPH6LZsTj6cOtH14JwesOhUUdiCPFaugEp/8ArP6QGATvL
	PhvqOQduLj8be9tEVo/wD8mI4ifUFxfwheWBYNqUrJ4i23vKaDqqAny0Y3+/oBRA
	05+u/s0KjawUdwbtjzFBoIQDkOo4dK9Uu4g==
X-ME-Sender: <xms:tZHJaX_0j_bJ5pPbdakV5hcWu_ntIAwGjWs7Wqr8uixNYkbirEieTw>
    <xme:tZHJaV8419aWWQc23iy8sNZqOhoht8ZYGLf3y1Ir3KxujKEkaco8zTbh8lWG6ZoE8
    TXqLSLPfcVxMzKcXGWVYgdXOY6Pyt8Llki6eCSyUd72gnBu9B-N8hI>
X-ME-Received: <xmr:tZHJaXQ2IBu371TXhX0XprKu4sQUyLx_G_E2pWpHMKEwM0A6obPEtJzb5BKR78mI0EunW7qc8vu0tKSIkq3qq59VM-8aAtctmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeejtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tZHJaZfVQtdntWbgwItBDXTtRuFjoY1_AEqYfRwq9zEzBz-0YMX-NQ>
    <xmx:tZHJabBvQ9SJGduspjbsdhaxBseriehAHX05qQZm4oPobkBy1bX9Tg>
    <xmx:tZHJabkNnN-Y5fe2mP73OJ46lbA4QcmMliBG1mZgMus3bgh6W32Xaw>
    <xmx:tZHJaWdpLPKYOlduLm7z9zkcZHnnYEN87l7fIOhSe634QqqErGS_8w>
    <xmx:tZHJabn13PEd9T0YrfE_197LOqFuwzhAT-x8DZ6B-MwC-3qFKbvV3Jbt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Mar 2026 16:55:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,
  christian.couder@gmail.com,  ps@pks.im,  toon@iotcl.com
Subject: Re: [PATCH v1 1/1] cat-file: add use-mailmap/no-use-mailmap to
 --batch-command
In-Reply-To: <a4ec7bfa-f16b-4505-9b37-d3dd137e93cb@gmail.com> (Siddharth
	Asthana's message of "Sun, 29 Mar 2026 12:55:24 +0530")
References: <20260328203615.60402-1-siddharthasthana31@gmail.com>
	<xmqqldfbh32d.fsf@gitster.g>
	<a4ec7bfa-f16b-4505-9b37-d3dd137e93cb@gmail.com>
Date: Sun, 29 Mar 2026 13:55:15 -0700
Message-ID: <xmqqh5pygxu4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

>> And the cached information in process, if any, would be flushed?
>
> No. The mailmap data is kept in memory. Turning it off only disables 
> application of mailmap; turning it back on reuses already loaded data.

I was asking if the rewritten commmit objects were kept around in
memory and how long; after you show an object once with mapped
author data, toggled the mailmap use, and then try to show the same
object again, you would want to avoid reusing the mapped result
again.

But it turns out that the command, with or without your patch, reads
the object data and maps the author/commit in it every time an
object is requested.  In fact, in a bad case, I think it calls
replace_idents_using_mailmap() twice, once in batch_object_write()
only to grab the size of the munged object, then again in
print_object_or_die() for both contents and the size.

So there is no "tainted data retained across the mode switch"
problem.
