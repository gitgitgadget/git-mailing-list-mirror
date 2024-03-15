Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4828D482F4
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523248; cv=none; b=AvP0sSo6nrRTvkWqTi+lTRn914HBgM/h4nWqZmVPZteWbVITA7bB0lSdRC4DetgR2PpiSta6FL40Gdu6x3z2pZ4aZsiyQh4S9UFultRXVSfmdrzuWsWLUy1BBmRvV6W6sPBfVE/KGZdkemdehInLggfF1ul19cPCcQ+g46Llm6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523248; c=relaxed/simple;
	bh=Y5b2ia6BhfvkNNHAXay8/LRxq+zqszR+iwF8aFb8nUQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IG8SJ+KoAfIIutEbX/z9D/65c9/VAvXCFaDneq/aOFjyo7UCFLi4iHd7xmZ8rFPpyh3N1jED2vsnkvzLQUZxV5xBiK1V3OHtF5jMFGI7Wta4y834ZVZrT+L+Fx3riipyHkXXQeUlf8oyLzze2N6hZ5glh8s/aVV8lbA+PFC4psU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xEH/OD+L; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xEH/OD+L"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ECE821E924A;
	Fri, 15 Mar 2024 13:20:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Y5b2ia6BhfvkNNHAXay8/LRxq+zqszR+iwF8aF
	b8nUQ=; b=xEH/OD+LoMianBsIioas07pdQBJJ/+JywGkdEAgyvwObDXSLvafxza
	VNtq3ib8omAuWPX+0Gyuk3xSazg/cU12EDG2ZIoQQFmfXhJ2STMAmF5En11jeu/C
	OCA43iLtOa6BleMJiPTdqZQsXIvjMl9tpCHim5TfRtVQ8ZX/LzcGI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E47BC1E9249;
	Fri, 15 Mar 2024 13:20:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5F3CC1E9248;
	Fri, 15 Mar 2024 13:20:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "Christian Couder [ ]" <chriscool@tuxfamily.org>,
  "Emily Shaffer [ ]" <nasamuffin@google.com>,  "Josh Steadmon [ ]"
 <steadmon@google.com>,  "Randall S. Becker [ ]" <rsbecker@nexbridge.com>,
  "Christian Couder [ ]" <christian.couder@gmail.com>,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH 0/5] Unify trailer formatting functions
In-Reply-To: <pull.1694.git.1710485706.gitgitgadget@gmail.com> (Linus Arver
	via GitGitGadget's message of "Fri, 15 Mar 2024 06:55:00 +0000")
References: <pull.1694.git.1710485706.gitgitgadget@gmail.com>
Date: Fri, 15 Mar 2024 10:20:38 -0700
Message-ID: <xmqqjzm3qumx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 58279C02-E2F0-11EE-80E1-25B3960A682E-77302942!pb-smtp2.pobox.com

Not about the series, but about the way it was sent.

The messages in this series have exactly the same kind of breakages
in the recipient names/addresses we recently saw:

    https://lore.kernel.org/git/xmqqh6hkxox6.fsf@gitster.g/

Human-readable names with a SP inside [square bracket] pair
appended, and one of the addresses had that square bracket applied
inside <angle bracket> pair and breaking MTAs (I manually fixed
khaugsbakk's address before sending this response, so replying to
this messages should be OK).

What are you and Aryan's pull.1675.v3 did differently from other
series sent via GGG to trigger this, I have to wonder?  Without
knowing it, it would be hard to avoid seeing these broken addresses
again.

Thanks.
