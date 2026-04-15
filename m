Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6530373BEE
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776277698; cv=none; b=VAbFPoUdDFwB8sAc/sVw/kdblsESJ8JXZ9EeA0E9ZI26bBaRESu/h+YEos79FBC+S0bwsKzhjc+YGxU5ViUonnerjI1LyEFM5aDX1Z+5RaO8uUecpktPq7NkVX0EuSMeAVmiObFEg8uOQ1ecNRKse3WWCWmP2n6ma03wv7Vhg6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776277698; c=relaxed/simple;
	bh=RIXseNdtD1coOpdIF+1utc++DsWqf8/NEFoGwG0hWfM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oRhEfz4/0bqeVWr/VQosjlIuDozAB+O1JFeTmvZI1njuNBCXKFH5seOYPCTgip7Rmc7cFw7ltthokEA8mtiHV4dR4BD/SEXS9EsNN4qeYbB4J/g+dqYuEaKU+WAO7PbURCpL/OvYuqZxhwsfyDa58zQ7vf9g6ZpIlmlDjozgjmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MwVcZ/AD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uaDJDxMq; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MwVcZ/AD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uaDJDxMq"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id AF9171D0014E;
	Wed, 15 Apr 2026 14:28:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 15 Apr 2026 14:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776277695; x=1776364095; bh=Jl2I7bvDSu
	l9jRunnuJVtlnX8exIH14QDAyGe4CLhWY=; b=MwVcZ/ADwfeZlw4ceQ0/rCyDoK
	pNmiKXfbGC/bRSqg3bfiyEE3R78q95bXhcUP3/AwUk3iod3rvztT4TzAGqb8V66c
	+3OD9JPQpnZGHH2+GZA1DccZ6DarXmtK00tPMkX8Q41oe9mGUoPqin76vqxWXrNb
	9LiECUPIVh/NLz+WDNa/E/7/i72q4eUvDmm3zxsP01nsg/CTZ3d3gY4jj0+j4MoU
	jfyglWUMhy94Sd0olCuOuCobTViQZvtMS3FhcmvBPeFlRzWQqI75LoZbZicZ/uIO
	jEDV7XBnBER8olZIHjRt/ORc21AIgHO2WxtRojEIMRVL9PzFnKHWKm2IRpkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776277695; x=1776364095; bh=Jl2I7bvDSul9jRunnuJVtlnX8exIH14QDAy
	Ge4CLhWY=; b=uaDJDxMqRNzEpxPmF0hGfcNwZTmK8rQigFhyh1eRfJ6FWkZPu/o
	IPNn4J+Fsaekj7hO/VdnmpKbNbFvxvYewLPHpOA8miPyz1wndfnqyQOenOghw6gc
	Xedv2sBEnzO2pPNl4nlMtTXi44kzJjRRwj7octg1ru2MrzeyqMXfytnSXs+cyTAB
	Z71/RMv0b09Oc1BV0kWlD2kKyadGx3Sj3ogZDRqBRJeFHqtxraZvCAiKAbpOy8q7
	HhPoghaXTV8JhXdOXA+Ow3PmGvgD3X9KFD+i4KjrbrrE3sfp6wtrVRt9uVI7IfIa
	yu0//kLokb7oDFwY1eNQC3sipJplgAQbqiQ==
X-ME-Sender: <xms:vtjfaeSduE_AJE0a3JHZy-9zCZ-LreLMagRmSDzNKqDYjQFBrnNYWQ>
    <xme:vtjfaS0ND6TARVWnkmbpKR68SNbf3gTcAUw6FZfUIuwx4OGehh5FBWaZLARXy4_hl
    aJbmJZ6v7-ilTT-D3vn86KBiLzadNGw0JLl_uyGuL00vXHvQbZtNQ>
X-ME-Received: <xmr:vtjfaSDIRx_PIxHRiW116DotDocDqx1So28oiPVefSkRv0KGG2wpbgvdc83eT3UJw_D2Lka5YizKCefVVwUIZLy_EfmWdDlfpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggeekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhope
    gthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpth
    htohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:vtjfaWgTxoF9XKgE1yuEU8hW7qlePO-lhZwAxpRoivN3ZWmi4gwXTA>
    <xmx:vtjfacNB5HIalCj7BcKJd_e_EofmXH40Xn8Z2i704NJzIx8nJ5HrGw>
    <xmx:vtjfae8vwZhZxVI9lHHjlXIJbB85RkuihaqPBRgqEiGpNG-KMC-79w>
    <xmx:vtjfaVdzaZCrtgOyiQtp_j3AQxS8u8_3REFDKv5FAcUmRlYKIdUAiQ>
    <xmx:v9jfabc97_zFKCV2yH2xdzHOjxzPHcVgapTkOMg4bUkCae9IcYFk__Cj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 14:28:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,
  christian.couder@gmail.com,  ps@pks.im,  toon@iotcl.com,
  jn.avila@free.fr
Subject: Re: [PATCH v4 1/1] cat-file: add mailmap subcommand to --batch-command
In-Reply-To: <20260415150943.40493-2-siddharthasthana31@gmail.com> (Siddharth
	Asthana's message of "Wed, 15 Apr 2026 20:39:43 +0530")
References: <20260331121111.9614-1-siddharthasthana31@gmail.com>
	<20260415150943.40493-1-siddharthasthana31@gmail.com>
	<20260415150943.40493-2-siddharthasthana31@gmail.com>
Date: Wed, 15 Apr 2026 11:28:13 -0700
Message-ID: <xmqqa4v46ptu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
> index c139f55a16..0f499c9d1b 100644
> --- a/Documentation/git-cat-file.adoc
> +++ b/Documentation/git-cat-file.adoc
> @@ -174,6 +174,18 @@ flush::
>  	since the beginning or since the last flush was issued. When `--buffer`
>  	is used, no output will come until a `flush` is issued. When `--buffer`
>  	is not used, commands are flushed each time without issuing `flush`.
> +
> +`mailmap (<bool>)`::
> +	Enable or disable mailmap for subsequent commands. The `<bool>`
> +	argument accepts the same boolean values as linkgit:git-config[1].
> +	Possible effects are:
> ++
> +`true`;;
> +	Mailmap data is loaded on first use and kept in memory until the
> +	process exits. Passing `true` again does not reload the data.
> +`false`;;
> +	Mailmap replacements are disabled for subsequent commands, but data
> +	already loaded stays in memory.
>  --
>  +

While the above may not be telling any lies, I think the focus of
the explanation is placed on a wrong thing.  What primarily matters
to end-users is that toggling 'mailmap' to true makes the mailmap
applied to identities before they appear in the output and false
makes the identities output without modification.  The fact that you
read the mailmap data only once and keep it around even when
toggling the feature off, just in case the feature gets turned on
again, is an implementation detail that is of much lessor interest
to end users, no?

Perhaps delete everything from "Possible effects are" and replace it
with a brief explanation, e.g.,

`mailmap (<bool>)`::
	Enable or disable mailmap for subsequent commands. The `<bool>`
	argument accepts the same boolean values as linkgit:git-config[1].
	The mailmap data is read upon the first use and only once,
	even after the `mailmap` command is given multiple times to
	toggle it off and then on back again.

would be sufficient (I would omit "even after ..." part, if I were
writing it).  What is more important than the optimization aspect of
this implementation detail to end users is that we do not re-read,
so if you update the file while you are running "cat-file --batch",
even giving 'mailmap off; mailmap on' would not cause it to re-read
the updated data, and "upon the first use and only once" should be
sufficient to understand that.

The implementation looks great.  I do not recall how good the tests
were but this round does not change anything there since the
previous iteration.
