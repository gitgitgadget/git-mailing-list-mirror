Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581B8373
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PQNYACzz"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0998010A
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 16:10:27 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D298F1C15B3;
	Fri, 10 Nov 2023 19:10:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QnB5UdEtpE6YfyvVyQ4aOPA4Uf7MEL4sNWez/H
	T73ZU=; b=PQNYACzzr3erQ/+pz8Fvso0fBHQkYQr5CiFKT2qtoC233O8t/r2bN1
	zubBL3NOgRFAnpfUu0OZMnZj9OHld4jktdCZv25z/TD2HpqjHOfffAUzGeCAfy3C
	EsqTY8/5xdzt0r+uv+QM+xKA6EbaVUk2QjEUXIXXk5doyKwkFEPqQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C9B3A1C15B2;
	Fri, 10 Nov 2023 19:10:24 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4209B1C15AF;
	Fri, 10 Nov 2023 19:10:24 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 0/3] t: improve compatibility with NixOS
In-Reply-To: <cover.1699596457.git.ps@pks.im> (Patrick Steinhardt's message of
	"Fri, 10 Nov 2023 09:16:56 +0100")
References: <cover.1699428122.git.ps@pks.im> <cover.1699596457.git.ps@pks.im>
Date: Sat, 11 Nov 2023 09:10:23 +0900
Message-ID: <xmqqh6lttaj4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B5D5623A-8026-11EE-A50F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Three changes compared to v3:
>
>     - Switched from `test <expr> -a <expr>` to `test <expr> && test
>       <expr>`.
>
>     - Improved the commit message to explain why the new
>       runtime-detected paths are only used as a fallback.
>
>     - Rebased on top of 0e3b67e2aa (ci: add support for GitLab CI,
>       2023-11-09), which has been merged to `next` and caused conflicts.

Please, no.  "The other topic has been merged to 'next'" is *not* a
good reason to do this.  Before that, the other topic was in 'seen'
and causing conflicts already, so getting into 'next' did not create
any new reason for rebasing.

I'll manage this time, but please do not do such a rebase unless you
are asked to do so.  The rebase will force me to do (1) detach from
'next' and apply these, (2) discard the result and detach from the
base of where the previous iteration is queued, (3) apply the new
iteration with "am -3" to undo the rebase, before I can compare the
new iteration with the old iteration.

> Technically speaking this series also depends on 0763c3a2c4 (http:
> update curl http/2 info matching for curl 8.3.0, 2023-09-15), without
> which the tests will fail on NixOS machines with a recent libcurl.

Thanks for that note.  This topic has been queued on top of
v2.43.0-rc1 which has 0763c3a2c4, so we'd be safe.

Will queue.
