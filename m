Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0B7246764
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753454558; cv=none; b=Qgj6bB/ngfmY+OQSbmk0Pd/qK1Vg6WRk5HFifLoeJa0f/du/p2oXqywLmuhhXOE6M1HYS1FlfCEdLZVE3kgJ8dTLUe2xhZ8bpmA2GiqnIfwYBSYK3vLMwxAciOpwvet6lCbJS+QphGxfPd+A0AsJRJ42hwHKnUFlcV97VP5lbQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753454558; c=relaxed/simple;
	bh=VE6P/wK7DUPGqHBZ7OyUEmvyz31XbJFSXIVrumFrZrg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C3LmiS7GSQgYQjvLqGftcskUs+l4bmoVhTmmdZKcL7A5YVUZbIuFTLEQgQVQTEw3VTOIUPXp70taoBZ5vEZju6pvOv5DV5nbMKyJv6zWJnhkxtBcDkNOcalA+/7i13hi/h8uTi+e7/C1+PhqjmbsUiUG5Qj3P8QyrEQbm1vMbyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZxzJilqh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GuvqUWnH; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZxzJilqh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GuvqUWnH"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 307C8140032D;
	Fri, 25 Jul 2025 10:42:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 25 Jul 2025 10:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753454555; x=1753540955; bh=bZFaDmqyVq
	bp19Vq1itQRycFqgPKpZbwNDTpzEj7weQ=; b=ZxzJilqhGK9EkGjwx5FOMgaErA
	uybUs2alfU0+B37ZLlDb7ODYhj/8wU4mbignmqbHpRIzstJIIUagTrC89ZWZdsph
	4Wb6hAxaZ4Au+y21nEK9Ft1e2T92uG6yLa8fhJ+SmYduHTceyUu3m2zSnfZ54b5B
	bUlefwSgpcS4iJdCVpkNIq2iqwB5Ra9Nigm1ExzVdu2IU5S9qEi2BnDb8AA1IYZ6
	/zsfVaT9qdbnJ6FP2m6JYRtw23dHbzDbPKhMSY9UqfZv5IEgVpG+wOvyKtd+83/9
	4JQjo74kgjTtXUspcz9qwgTjx3nKDW+ZlxsGKbNhdIE7Xs/cXhETBDZjQ26w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753454555; x=1753540955; bh=bZFaDmqyVqbp19Vq1itQRycFqgPKpZbwNDT
	pzEj7weQ=; b=GuvqUWnHhDuwm+rENL4cMhu2RH+T6C2pIppnwHL5JtDSw7Bju2L
	iVsyZ2eQNQLFI2SWRjlOVD7jspkGcTABpml26KT8zwbfZmJUYWfszd93Rk05NcXL
	fsacupGddV63zYm6t5mpmHtBeJAmb6YcZ2N0+EmeyOWvgnw8QsqKWDrJxZucI/P/
	omxTsRCjjkfBjI6CdCzTvqFA2g518OlAVaDM/pgXe2LbOsi8ChYC5q2/KK5JQlV6
	GTY3B3hKW8zDz673aM19NpgU+NaprfIxK5MKvLC8/Yw0svz+SRzHidA9lci5yFPl
	rVItQ9KeyGxdASYI9b4C6e8VBSn5Q5BGTzg==
X-ME-Sender: <xms:25eDaKwWx-L04FU0MBx3cbkZ2iz8PQkc4VrIOQ29jEXtevU1_IDKYg>
    <xme:25eDaA09nemjyH2lqZMVazIzvJVUpnwIPH8X-T57zXRYz9mNHLuzz38YdPmbdOKR5
    IWM_yUNDcd-hp1ZoA>
X-ME-Received: <xmr:25eDaI666CMQxJxf4QLskJxg0YJlIVOQE3GgaMBzsezKMYcJuhhJOl6sy0-mIs9nmY8KPv4VBMVjoDv--vAxPsB7pLOTvixGmYv0Cxs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekfeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehlhhihfihkugdvvdesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:25eDaDU43C0rQs_U_3nksFkIkHZEcJH0UdR8uywoFvwwMEZSh6golg>
    <xmx:25eDaHDatXYIGJVk0H-cK5-ue2AoVt1B8iO0-Tfe01tZyJbAsdJ9kg>
    <xmx:25eDaC612fQNAl2oCgywPDg6ehAuiS1VG-evnhmdAZCoz0WZ_RDR4A>
    <xmx:25eDaCxfDt_8z2kC4AmpB72obE8ng2soGCOiASo3US7VDMwYZ0nagw>
    <xmx:25eDaHBNM8nlXV7gRPHnxnoTMTiCr-QfvbiTe7TTlmWX5HKooLMCNc-D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 10:42:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Hoyoung Lee <lhywkd22@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v4 1/1] test-delta: simplify delta helper with strbuf
 and better cleanup
In-Reply-To: <20250725111530.GA3015021@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 25 Jul 2025 07:15:30 -0400")
References: <20250724093327.2261615-1-lhywkd22@gmail.com>
	<xmqqjz3xh34c.fsf@gitster.g>
	<20250725111530.GA3015021@coredump.intra.peff.net>
Date: Fri, 25 Jul 2025 07:42:33 -0700
Message-ID: <xmqq1pq45o2u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Jul 24, 2025 at 11:09:55AM -0700, Junio C Hamano wrote:
>
>> OK.  Except for the whitespace breakage, I didn't spot anything
>> glaringly wrong in the patch.  Looking good.
>
> Hmm. This looks like just a squash of the 3-patch series I sent earlier?

I think I have your variant in my tree, and the results from both
variants do match.
