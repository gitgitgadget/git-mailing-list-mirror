Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6F0200C7
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dn2rN+uf"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAD5A3
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 10:35:38 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C218B1C387D;
	Fri, 20 Oct 2023 13:35:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kJLD0zJ01gUcx+Gc51Z2qRlIzHNTUhz3Ru+wSh
	/oA9s=; b=dn2rN+ufkvRcD5ytdg1huUwDfdRmqK7UNOz8f8ByV8NjCfrYTbUL2p
	OfmYWU8ooYpq8AWSk77u7m62yURuUi/Xzym2lQYGAeuwJ1MiCMLNvYZkDvG1eUc/
	Ze9mVLQ8aVfjRER4/9+taAtcKhnWH7OjIZdmSDZXe9my+AuDqWmMc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A8E4A1C387B;
	Fri, 20 Oct 2023 13:35:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ECAF61C387A;
	Fri, 20 Oct 2023 13:35:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] commit: detect commits that exist in commit-graph but
 not in the ODB
In-Reply-To: <20231020100024.GA2194074@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 20 Oct 2023 06:00:24 -0400")
References: <ZSkCGS3JPEQ71dOF@tanuki>
	<b0bf576c51a706367a758b8e30eca37edb9c2734.1697200576.git.ps@pks.im>
	<xmqq1qdy1iyr.fsf@gitster.g> <ZS4rmtBTYnp2RMiY@tanuki>
	<xmqqjzrlhzci.fsf@gitster.g> <ZTDQjangLsQ1cSJl@tanuki>
	<ZTDn-Wd5xsFrBmqI@tanuki> <xmqqzg0ey1kn.fsf@gitster.g>
	<20231020100024.GA2194074@coredump.intra.peff.net>
Date: Fri, 20 Oct 2023 10:35:35 -0700
Message-ID: <xmqqpm19qjrs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 146EC7D2-6F6F-11EE-BF0C-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> I guess that is really like a global variable but even more gross. ;)

Yeah, I tend to agree, but ...

> But it is nice that it can cross process boundaries, because "how
> careful do we want to be" may be in the eye of the caller, especially
> for plumbing commands. E.g., even without --missing, you may want
> "rev-list" to be extra careful about checking the existence of commits.

... these are all very good points.

> The caller in check_connected() could arguably turn that on by default
> (the way we used to turn on GIT_REF_PARANOIA for pruning repacks before
> it became the default).

True.

Thanks.

