Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ADAEBE
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 00:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="coKaxT3T"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C1AD50
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 16:24:20 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C5F3D1C3E7F;
	Mon, 13 Nov 2023 19:24:19 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AF0UxIIu4t3/tUHangNkGyH4mygzH874Fg19ag
	4wJK0=; b=coKaxT3Tw88XZpNu+y72QU6C8H+lLsazabPSfProdagSFq8l02pPr5
	CMwFmKtGZVuU2JGK6CqLjOAHlEvPFm2szGAQM3Bf05Cbchuw/pjERL44r0Zl8MQb
	O+YjQpeyu0QzI1Vgo3CCcfagFhgTlm24BLcHV/W+iBW3T3elDjbj4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BE3D01C3E7D;
	Mon, 13 Nov 2023 19:24:19 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1FCFC1C3E78;
	Mon, 13 Nov 2023 19:24:19 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] ci: avoid running the test suite _twice_
In-Reply-To: <pull.1613.v2.git.1699907108371.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Mon, 13 Nov 2023 20:25:08
	+0000")
References: <pull.1613.git.1699894837844.gitgitgadget@gmail.com>
	<pull.1613.v2.git.1699907108371.gitgitgadget@gmail.com>
Date: Tue, 14 Nov 2023 09:24:17 +0900
Message-ID: <xmqqzfzh2nda.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 26B157CA-8284-11EE-8F42-25B3960A682E-77302942!pb-smtp2.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>     While this tries to fix a bug uncovered by js/doc-unit-tests, to avoid
>     merge conflicts, this is based on ps/ci-gitlab.

Excellent choice of the base, as dropping the state is the right
thing to do regardless of the "unit-tests" thing (as Peff said),
and the refactoring done by ps/ci-gitlab topic is what makes the
problematic state=failed,slow,save spread wider and affects more
jobs.

Will queue.  Thanks.
