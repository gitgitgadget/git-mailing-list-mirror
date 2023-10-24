Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCA2386
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 00:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tzJNazKn"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A54210D
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 17:08:59 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EB58828903;
	Mon, 23 Oct 2023 20:08:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Uay2Eo4koWZoFUnuYYdX+JuixTDMTk0a9lkZq5
	CgZ8o=; b=tzJNazKnCF0xsTMGaOihRMkEj2UOuDnFcIlXjY5k6HCaAPJ2BIfaO8
	rgZh/NJK7vgOYXoVEgO4iO3eN0m9rl+ddvQiFTvI57Bd/mg4JjlwZvcYtqxBAXnQ
	S+01xu5hqjG0l8k3u5tarrctIE3v4JB/UMGlrKWvVth3dxmVEvH4s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E351928902;
	Mon, 23 Oct 2023 20:08:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B9FA5288D3;
	Mon, 23 Oct 2023 20:08:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org,  stolee@gmail.com
Subject: Re: [PATCH v3 5/7] refs: add pseudorefs array and iteration functions
In-Reply-To: <20231023221143.72489-6-andy.koppe@gmail.com> (Andy Koppe's
	message of "Mon, 23 Oct 2023 23:11:41 +0100")
References: <20231022214432.56325-1-andy.koppe@gmail.com>
	<20231023221143.72489-1-andy.koppe@gmail.com>
	<20231023221143.72489-6-andy.koppe@gmail.com>
Date: Mon, 23 Oct 2023 17:08:51 -0700
Message-ID: <xmqqjzrc7ugc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 83DB074A-7201-11EE-871C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Andy Koppe <andy.koppe@gmail.com> writes:

> Define const array 'pseudorefs' with the names of the pseudorefs that
> are documented in gitrevisions.1, and add functions for_each_pseudoref()
> and refs_for_each_pseudoref() for iterating over them.

Makes sense, and we can later (ab|re)use the same mechanism to
extend "git for-each-ref" that currently only knows how to show
things under "refs/" hierarchy.

> The functions process the pseudorefs in the same way as head_ref() and
> refs_head_ref() process HEAD, invoking an each_ref_fn callback on each
> pseudoref that exists.

Good.
