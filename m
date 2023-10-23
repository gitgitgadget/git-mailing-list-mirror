Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5E81DA39
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mDXbXMrF"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D8894
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 10:24:03 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 688753EE9C;
	Mon, 23 Oct 2023 13:24:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=q8zWO8hfzWZN
	mdw3jKeH7gUPIy3nm/2oXackihKG3no=; b=mDXbXMrFjzbp0pEOfbrDmOJXtHSq
	3qUybYnMrWhrByI02mN7I/1GuVTRW/WLlvmdmWuvcnBOtrD+NUxAhTw/nPEBP+CF
	PUboDCx2LZyyQ2D1+uI/rNGURz+cbtCxAr+435cZIDh9Bq1nSuc2Z9jgkxXaXjLo
	vgKhNfROMCVuVq8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 60B1D3EE9B;
	Mon, 23 Oct 2023 13:24:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C94B53EE99;
	Mon, 23 Oct 2023 13:23:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  cousteau via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Javier Mora
 <cousteaulecommandant@gmail.com>
Subject: Re: [PATCH] doc/git-bisect: clarify `git bisect run` syntax
In-Reply-To: <ZTYi55w_70ZlP8Ew@tanuki> (Patrick Steinhardt's message of "Mon,
	23 Oct 2023 09:38:15 +0200")
References: <pull.1602.git.1698004968582.gitgitgadget@gmail.com>
	<CAPig+cS4J-L44a-fjQ=2bXxRj6e1qdQK8705K3NPqmTsWXBQsw@mail.gmail.com>
	<xmqqa5sap44i.fsf@gitster.g> <ZTYi55w_70ZlP8Ew@tanuki>
Date: Mon, 23 Oct 2023 10:23:55 -0700
Message-ID: <xmqqsf61ntg4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F259430A-71C8-11EE-AC2D-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

>> I also thought at least some commands we know the "-h" output and
>> SYNOPSIS match, we had tests to ensure they do not drift apart.  We
>> would probably want to cover more subcommands with t0450.
>>=20
>> Thanks.
>
> If we don't want them to drift apart I wonder whether we could instead
> generate the synopsis from the output of `-h`? This reduces duplication
> at the cost of a more complex build process for our manpages.

There also is the cost of making it unusable to peek the source
git-foo.txt files as a quick way to get the usage guide, which I
think is a downside only felt by developers of Git (not developers
of other projects that happen to use Git), but still a downside.

But aside from that, it is an obviously possible direction to go [*]
and in fact I suspect we may have talked about it when =C3=86var made a
gigantic effort to clean these up in Sep-Oct 2022 timeframe, which
resulted in the series leading to a0343f30 (tests: assert consistent
whitespace in -h output, 2022-10-13) [*].

[Footnote]

 * And another possibility is to go from the doc to the message
   string, which may be even more involved, but at least the code
   needs to go through the build process anyway, so the downside
   might be lessor)

 * https://lore.kernel.org/git/patch-v5-34.34-4de83d3d89a-20221013T153626=
Z-avarab@gmail.com/


