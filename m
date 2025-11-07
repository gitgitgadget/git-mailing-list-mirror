Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952062192EE
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549414; cv=none; b=YGYz17vlfUoT7dFhyYxiZWmSXvuV4M89fJovPPLrQHw3IIWv7gY5aPOxx3bUfEzHJMscDIi6FD+ILP/wGTP/D/GczoD9SKvJrFNt60Tp3GM3Pc790wCKBgRs0zb/h936gFBQBXxB0RZSORxagNJgYwDhBpjopNS/cAsestmQBnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549414; c=relaxed/simple;
	bh=l2XLIjsiZOltz9SqnvpGrjhNnUpKrSfNuXAi/EaqAio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VwsSNv2eKJnYXJMOlF1x9DKRxXo232s4tUdbzKyDDN2jUuhzVIbYkkN84bvf8NEAYD5FG+N2rioayJseX7Ii9GmabliiyYeOg/cZxBhqZBAZHa7BwUzefYcPd9eGZfU762fVm4U6NQCWGL/IHp4ZoFqeOHMFvK/g1aP71OLzoGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fin1tOly; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vI3Lbfon; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fin1tOly";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vI3Lbfon"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D0E6EC00DF;
	Fri,  7 Nov 2025 16:03:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 07 Nov 2025 16:03:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762549410; x=1762635810; bh=+6jTytPhWd
	M33JP4lp9P7pQdDYp+VOMrZe5Gu1obj+s=; b=fin1tOly3LBmDuwZ8VlCjfyy5h
	AwN2PdVCR2ytk5BhiaafygOWiFtbk9QCtPkAaVbN+Esc4JAh+Gk/Vn3f2GffZTRZ
	rdFp7buYojAnX0dO6ZwaKPvtoFA+iJhH9NDf241fApiohYaxTlTH1gpZhqUnLRt2
	NuBcObOor930H1Db8sF8wQnEaf0uVKewGudPRqOzUIc+0Coab1Vxd+fxkIt/RXUU
	g7cgaMVaLnc7x0E7XjcuYnQaj/NXc+rfg/n3QsMmDGa4988DHag8G0I0y1LdU+gJ
	hmWHMpk2lJtZwJJxFJFl3lOxgqsbbcqRwjf1AOJse4V3oD80S7RvaJKdNktw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762549410; x=1762635810; bh=+6jTytPhWdM33JP4lp9P7pQdDYp+VOMrZe5
	Gu1obj+s=; b=vI3Lbfonn5mKhdtdC5IGBYd/Vwiy3jK27u6GgOZ3P7rQhpsEYez
	BzV2VeHeKGNiHOTLd6dOlxjDTBxpubu2Aa5wLTsr5horJcz9KsULjCg9l1DBvX/V
	xNnC1F6hh0dKggaD935QHd7FgwvNFsH1tLJfvGDRD4QHWrTad2R40i1VkzaA4k0l
	4u7XTKvrQL3u46kCbNkIwk2V8eZHFMqsHgeUWYIdf+B2m1ORmq1ulhjX42xtLQTN
	XOdR7gs5ylYjknEa1/qNz8iiilbWjs4IxAKRhKohTfK3YiCutFkXgKDyne2tBN+R
	kw5OX7pyoCrNXJqGxOqQEmsqWhBWWGkgq2A==
X-ME-Sender: <xms:ol4OaddaSmaq9o2jqkKuoRk62sSzwxRb9dpo1nDbidSFB81Wimv4OQ>
    <xme:ol4OaYyzvXZJay6_Itl6FaB08tRAUlU5OcBZYA75O9s9ins6lWAeM0ZUpMootNOmb
    4w28iPCyYS65hNDxc4wynXcvcTybrS3HJeiGqw4u2eu4QhXbO5vMw>
X-ME-Received: <xmr:ol4Oac-o1HkK-iS4uLy0xna68dZx4glAO5LD9D64ohy3WIRa2kTUcRH6Ch5RdPy94kKoksGNxSeVURlfHN6HyvPbVtzqr2pMAKdI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledtieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhope
    hjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:ol4OaYiuvlcZ1OQE27NdMEYOCZPo5Vw_95h4tTPw-8t_wbPOeh7P7g>
    <xmx:ol4OabHfq9RXcIVvsGr2ufUdvTfKKEp6NxR_jfGQYUr150Zi0onprQ>
    <xmx:ol4Oaf-fLSHu02tQHvQwIiq6EsfayKILNK2bnf-ayOl8rnRzWL6ssQ>
    <xmx:ol4Oaaw0qU339jYLl82WXc7v_RxkntDahRsLH0JP81wobkX1P-0yKg>
    <xmx:ol4OaSdUjz7ZhUobLifi1dGNHmFJC6YKOTjR-ZRUnkQWPkMFESHfBU0I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 16:03:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v6] doc: add an explanation of Git's data model
In-Reply-To: <pull.1981.v6.git.1762545177204.gitgitgadget@gmail.com> (Julia
	Evans via GitGitGadget's message of "Fri, 07 Nov 2025 19:52:57 +0000")
References: <pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com>
	<pull.1981.v6.git.1762545177204.gitgitgadget@gmail.com>
Date: Fri, 07 Nov 2025 13:03:28 -0800
Message-ID: <xmqq4ir5ftcv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> Git very often uses the terms "object", "reference", or "index" in its
> documentation.

Not about the updated text (which I haven't carefully read yet), but
we'd need this squashed in to avoid xml that does not validate when
using AsciiDoc (not Asciidoctor) to format gitdatamode.7
documentation.

    XMLTO gitdatamodel.7
xmlto: /home/gitster/w/git.git/Documentation/gitdatamodel.xml does not validate (status 3)
xmlto: Fix document syntax or use --skip-validation option
Document /home/gitster/w/git.git/Documentation/gitdatamodel.xml does not validate

Perhaps I forgot to send this after queuing the previous round, even
though it was queued on top of the previous round in 'seen'.  The
patch still applies cleanly to this version, and seems to fix the
breakage for me.

   ... goes and looks ...

Ah, no, I did not forget.  The same patch is in the review thread of
the previous round:

    https://lore.kernel.org/git/xmqqcy62213a.fsf@gitster.g/



 Documentation/gitdatamodel.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
index 1cefbb4833..eaab3f800b 100644
--- a/Documentation/gitdatamodel.adoc
+++ b/Documentation/gitdatamodel.adoc
@@ -18,13 +18,13 @@ means when the documentation says "object", "reference" or "index".
 
 Git's core operations use 4 kinds of data:
 
-1. <<objects,Objects>>: commits, trees, blobs, and tag objects
+1. <<object,Objects>>: commits, trees, blobs, and tag objects
 2. <<references,References>>: branches, tags,
    remote-tracking branches, etc
 3. <<index,The index>>, also known as the staging area
 4. <<reflogs,Reflogs>>: logs of changes to references ("ref log")
 
-[[objects]]
+[[object]]
 OBJECTS
 -------
 
-- 
2.52.0-rc1-455-g30608eb744

