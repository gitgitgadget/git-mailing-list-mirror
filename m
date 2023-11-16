Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fnJcyN4W"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB5E98
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 21:39:09 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C9C5E1D11B6;
	Thu, 16 Nov 2023 00:39:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EpGFsEJMaPtjcoOUzNd+qoKzfCwNTNIGfy3r7S
	0AxDU=; b=fnJcyN4W4tzrEtCYM+8nBfFosZUAFEMycQQW10ydXBXu9nlM37swOQ
	CLCNBl2uwCr/xyTq89bpAFe3qFyYYRHX+c5uKy1Pw8Z7Ip49hK0aoe1di+mH1/qC
	E5dPESRrMLj4xQU3gr2xfTRAsllfO5ILUvFF66IDwjnD2otYwz1pc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C1BB31D11B5;
	Thu, 16 Nov 2023 00:39:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 334881D11B4;
	Thu, 16 Nov 2023 00:39:08 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,
  =?utf-8?Q?=C3=98ystein?= Walle
 <oystwa@gmail.com>,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 04/10] ref-filter.h: add functions for filter/format
 & format-only
In-Reply-To: <187b1d6610f96ba16bb7e1ff80d1c994a67b8753.1699991638.git.gitgitgadget@gmail.com>
	(Victoria Dye via GitGitGadget's message of "Tue, 14 Nov 2023 19:53:52
	+0000")
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
	<pull.1609.v2.git.1699991638.gitgitgadget@gmail.com>
	<187b1d6610f96ba16bb7e1ff80d1c994a67b8753.1699991638.git.gitgitgadget@gmail.com>
Date: Thu, 16 Nov 2023 14:39:07 +0900
Message-ID: <xmqq8r6ys1dw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 76490F5C-8442-11EE-B74B-25B3960A682E-77302942!pb-smtp2.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This consolidates much of the code used to filter and format refs in
> 'builtin/for-each-ref.c', 'builtin/tag.c', and 'builtin/branch.c', reducing
> duplication and simplifying the future changes needed to optimize the filter
> & format process.
>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  builtin/branch.c       | 33 +++++++++++++++++----------------
>  builtin/for-each-ref.c | 27 +--------------------------
>  builtin/tag.c          | 23 +----------------------
>  ref-filter.c           | 35 +++++++++++++++++++++++++++++++++++
>  ref-filter.h           | 14 ++++++++++++++
>  5 files changed, 68 insertions(+), 64 deletions(-)

The amount of existing duplication of code is rather surprising, and
this patch nicely refactors to improve.  Good.

Thanks.
