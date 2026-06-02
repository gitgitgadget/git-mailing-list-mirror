Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D722C326D
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 23:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444333; cv=none; b=bqa0UcGisNvNcJHP/o4At6OM82Xp/OFj6nctbeA8/kAYPTQxqjQOR4b2GlGdbHPOw4uQ2QGwj9yWbC0idBIoCs7dnSd1uPpiBcRl5psEl6YdtirTlUXu/wC5t6XSxpvO5Ao5zftEzd5UFnkv8KeBnezX78xRpH3Tlb9pHqExzEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444333; c=relaxed/simple;
	bh=1dqdRkbhSngp2PtyQlvDnozJg+3hPZ4OT7C2sR3cYgw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EiJ6zS7BjTsKwQPXiaHU48HELkerguvbHZ9iPmcSOOHas4uEY/Oy7tylRr6ApcFeXl94YstE67FDB+WYzT6pvL4V5LnJzmtNURuQAvKMD327tOM33ZkYkS3AdeziiV0oI/XgVmdZgFob43AKdPYZvhRKNVmJvxrGZeylcy7pccQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KdNRkKnt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FhlDQ1nr; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KdNRkKnt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FhlDQ1nr"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 474E37A00E7;
	Tue,  2 Jun 2026 19:52:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 19:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780444331; x=1780530731; bh=LJBAXbEw1p
	fNe0IKjsYtb/LDnCDGTjWImeY9RWuyzXs=; b=KdNRkKnt703n3VXOhqQ4JttGpq
	Cu0atrG73X3VqT33aqx5lyG1hwA0iUsjdw8IwtEw8zhuwMXUaPvTWUQOFdRjYqNZ
	9uyTmz0BgZncnnbbcbG9MnuzlqQBiyCyVZr3ZDPyZkGAs5aujseoKKQRrgNk8hVz
	nk4fvt84z4PBUUHHLNDOJJplPKw+VsDyNqoTLQa1ettM5OkOF5AZXoIsq9jQL0Qz
	rcqMhRYrg3LJRPLWvQezs3YrGPtIuftiPTChAgLFagk/X8U64vsyvm9DYJrFxTQ4
	jNV0wkASHgpdquQ0ItJd722g5E464+0kzfop3+zWhyrEWFlmK5CshSH3hRfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780444331; x=1780530731; bh=LJBAXbEw1pfNe0IKjsYtb/LDnCDGTjWImeY
	9RWuyzXs=; b=FhlDQ1nrtIPHGh8Flt8ehOFHsAD81U/BNNugSnxtl1FQy+Tq3Yz
	RiecvMkRNrSmXSQOJJA4OEdPSXk6uB6ZFxS62GPP4GyuLt0WJU+9NhDGcqHMmB5k
	5BdCmzUna/px81UhpjOxVReeXJ7Eh9kJBXzUcEplGthVFs1jGLtzXj0KqpOmbzT5
	o5cgWC4oN0q40wHXq7pksFyRswDJzCw2O/dpp7U23abyggk7GSGoWVOWrWCaIsA+
	gh1HKdJir9NWpGdYNrl9bf37KVOkalWhKh131cczjjtvQXg1Ghq1ay3Q8L7sqjCC
	IKZSha3EyE6x4i2PM6AESYjU3Cyudw6BNOw==
X-ME-Sender: <xms:qmwfatlCUrmO0ym2xd2BHNn-OKMgN2b9cp4nXe-p9T9TNhQABDPEXg>
    <xme:qmwfagRk808R0GNZcnm15xLo7iARtapWpD-0DAURra5il7_dN9-ZnUmNitBRXYr6r
    IvrfY7axyMvcVbJCOHtlyWsCryZV2bX5UhiVlbQo4zYqW1S7rJLmkM>
X-ME-Received: <xmr:qmwfahA2q5YZYjZ9ja-aCwMGHWKZnnf-9eS2J5P2CHqGzodOXk03yVVsF1re_ToHJVOElZFpx-ByQ54Ep4vUKEqTvp4aa1DhQlUz>
X-ME-Proxy-Cause: dmFkZTEBoN51t6UV7+Wdu9xf6NfQmPT+wESzKbveJiIDH0zSYRND7HJo96Tukide+0G0xV
    6FQLV25SrPhVfRGboGZYR5OFGg/pIZdHgfCg3xWQTzdzZtXLSvxBsL6XjWSbsFbh8oLLKY
    pCXOGpElY/0kHOTJGZl0CMiAU1DU0mNEmTGXwcEXF8LWJipF1kjoK8fDcI1+VkT+uJvEU/
    2Tqvp9JxUZKfgAqn1wXg8eVlHD8BPlENYPiIS0tYqgNb92MexWbsB36wlQLt/PPtRDS2Ge
    OgTFmc2tTOLJEF7fTyf5b1yBgRGeEQy2jBJ+7sytNzetUBhGjGZHo7+UwW48ILv+whcSQH
    bR+JNOcsmR7Yx+V7fUjgwNKekV4o+sqM6e1K+6c1vetAk7HdYWbjVkacVY7A16Rl+/RK2I
    Gg23upD2ND6i9UMdIQg8nNP3rXXcWu3Ul/ErOigFm7zKG0Hcpm3nFO+S0SeHdZlBI3226d
    HjqkBeBlhuS+0d0UDF3BzwZ0PoS19lTQNTjE+iyOisN74seZr8ffktulA5BEJCMJd8R1mD
    g5YSF61Rf1PzYTxyvCjGjJ9IqLyjN4dpr+knB3PcGTXhyOsPlx3o9jYAKg0YLP7VRZL4yk
    iz4RXoqkrPMEJ0Bq+ea9rqqtWSDupW21ObM1M/d7pn9AVTaLQs3Ku2PeUiig
X-ME-Proxy: <xmx:qmwfanToApn4qCzASKid3I3aKvvWz6xIePwFBS16ik9yKReG_Nrkjw>
    <xmx:qmwfavqsZhD6cYYzEm5QIv8gRsE1geKb_goiUnxd2RltHV1s2kcS4w>
    <xmx:qmwfapzDKYgXc-ZrurAsFZDon3R0YgkhHWey4gx1igVvOkCWxQmt0A>
    <xmx:qmwfakJ7KYlTYqDrtOBoK0hYs2F7oWEj_sXtbxb5XfuAbrgNdXAKzw>
    <xmx:q2wfaiY9ccyd1LVQ43LfXfv0y8LAOYV0Eg5t2KaPRbszEwDcIUr65nGh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 19:52:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kiesel, Norbert" <norbert.kiesel@creditkarma.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] worktree: record creation time and free-form note
In-Reply-To: <CAPGaHku+RAV+FA3C0md0xHiavfdB_anoqcMM06MAiU1VyMAdLA@mail.gmail.com>
	(Norbert Kiesel's message of "Tue, 2 Jun 2026 14:40:44 -0700")
References: <CAPGaHku+RAV+FA3C0md0xHiavfdB_anoqcMM06MAiU1VyMAdLA@mail.gmail.com>
Date: Wed, 03 Jun 2026 08:52:09 +0900
Message-ID: <xmqq1peots9i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kiesel, Norbert" <norbert.kiesel@creditkarma.com> writes:

> From 130cd5e4a25e6672b2a97268e1100b6ef03fa552 Mon Sep 17 00:00:00 2001
> From: Norbert Kiesel <norbert.kiesel@creditkarma.com>
> Date: Mon, 1 Jun 2026 17:03:39 -0700
> Subject: [PATCH] worktree: record creation time and free-form note
>
> Add per-worktree metadata so users can answer "what is this worktree
> for, and when did I make it?" without resorting to external notes.

Although I am not personally interested in this topic all that much,
let me point out that we have $GIT_DIR/description file that may be
useful for something like this.  It has been the canonical place for
the main repository to identify itself long before secondary worktrees
were invented and $GIT_COMMON_DIR/worktrees/$worktree/description would
be a natural extension of the concept, I'd presume.
