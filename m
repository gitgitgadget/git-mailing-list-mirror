Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F93B336880
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776453702; cv=none; b=g728HHMkf0O72e4xlm/5vPtjNJv251iODRRUlpPB3Y4/iq0rQcXIocXYz04wnpxzKG3B/NcJWbRoU8lbtAQzWDxEaiAe3F/y1GQFdUmxQEAJ2B0W7rirGc0mrjA1Pg5KnMlefOhLcGGa29n3sJUUECIzQLTPKCPLF7hWp4sF0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776453702; c=relaxed/simple;
	bh=Z3OLm46RsQwTlA8c1zG7TZI1sslsOvZQnFNMDWqZdcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IihHiep6T0OljBes+9Bqt1Q/Oxqz0QiAmqJv+Z2+7FxTIr9iGzHpO07h/6Ayi0TRN1eaGKZhSZwMxXEVo3DLphqnrG0c3BGKQ6afko3po4gG3tbxxAqrAprCLcZfHOVhX9KVrcMjDJTfW+VqvILEu81QwguAIG+piR3PuMQ8dwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PJ4oigPn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KrTTDOpK; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PJ4oigPn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KrTTDOpK"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8B62E1D0013C;
	Fri, 17 Apr 2026 15:21:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 17 Apr 2026 15:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776453700; x=1776540100; bh=7QGN/oOD83
	UHY6bMsezcLHpYE8dV2O8oGErVstFlypk=; b=PJ4oigPnCOqtCS04t//U5vS49O
	6ma5/VY4b7ftgURL/n4UrElqOYhEVuGNYAg1odWJOOYFfxAeawXylqxx3Badeaf8
	PIOAtyMF0Fv2O7+kUzguFWHr2U7XUSoIaytbBgz3uWyfElcahTiVfY/+MuL72Rm9
	4EgOC/5JHuWJnyAQEbfSu+uYDIOVistoB/F6OYID4Ivsj49k8+BnyiV4Tg1uQPyj
	6DPZc2cM5IqzAqGU1MlkteZcycCIDnJKdPx/H5kU4XHPhUJXe6yr/lxhf9DZ1nuF
	5mmh5UUDAMfG682frnGTnLwzAYwjmM36yMTohARHVtw38yM03LLgY9J6eZRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776453700; x=1776540100; bh=7QGN/oOD83UHY6bMsezcLHpYE8dV2O8oGEr
	VstFlypk=; b=KrTTDOpKi6RwXboDOI+h3s/62AByQmcKZne+47chpyyf4mtEQpW
	fQm/XFYsMaaU6vejN5Uih/D+AcXlfJ0zyKw59KliQKQrt6q0Se0m1VS+GXMkluej
	9VPjQwVgXskJTZsrQa3qkNNdfaNkaAx5Up6362/8QH3d046HyDUF8O0YFjQtA6qY
	R/o7uKRXWR6Bll4kMsNDlHLh0B83dqYlX/a077MmBDhVYt3yXyWL8+YDEqKyDexX
	MvX3JvK2G0qIVnLpW6hyukt2Z7X6RTXiZQkyCtloefPGoSmBJH0PDWha3filOD1K
	j9lR0FdvoJ7N97i74fEVWyKnNzjWjp8iwKQ==
X-ME-Sender: <xms:RIjiaS0s_b1LoEpvHAVKhktiT8-XD-ga1r1Tkpt6kGfmOvIQVaYSRw>
    <xme:RIjiab8jJTXVlOY8hMyqQvnRZwVeXVrc2cSpcRRWGzcl41Hp9EvwThmFEQdpoULyn
    PGkdFD4v50cL5_eki3Kwyvoz9i0czhFIVxGgSg2vzmc6Q9EYsBHeb0>
X-ME-Received: <xmr:RIjiaTNlFDiDQ1tkQS7KZytibm_rb65YjnNIbQ8VSqrklV3Qseq6K5zKhiPNTKZQnttFMan4drw1fCLS0_ra_f3y7x54ETmANA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehtdejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhorhgvnhiiohdrphgvghhorhgrrhhivddttddvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:RIjiafcSQD40g7Tf1nev_ygiUEhRllsc_aD5zhLKbaChMLtu06wKRQ>
    <xmx:RIjiaSW6G_U8uQ_uksSEoExv7Wi51f3iOVFRk800nhSmyDtAB3erSQ>
    <xmx:RIjiaXjZI_r6mL1dMaC1CPQx8LUHEYWycS7e_jC6TDpFDrW9tkf2ng>
    <xmx:RIjiaR-wfpflsueLmUVth63mihaem8Uu4NE3cU-vV3s3pWZ7bQaDxQ>
    <xmx:RIjiaesvwMesO-MHnMnND6KskN_Nose3E3zqKCt4AMnLzg9qL9uPYzJ6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 15:21:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  LorenzoPegorari <lorenzo.pegorari2002@gmail.com>,
  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] diff: fix out-of-bounds reads and NULL deref in
 diffstat UTF-8 truncation
In-Reply-To: <pull.2093.git.1776443163041.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Fri, 17 Apr 2026 16:26:03
	+0000")
References: <pull.2093.git.1776443163041.gitgitgadget@gmail.com>
Date: Fri, 17 Apr 2026 12:21:38 -0700
Message-ID: <xmqqv7dpwfy5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> f85b49f3d4a (diff: improve scaling of filenames in diffstat to handle
> UTF-8 chars, 2024-10-27) introduced a loop in show_stats() that calls
> utf8_width() repeatedly to skip leading characters until the displayed
> width fits.

A tangent, but I get a datestamp for the same f85b49f3 (diff:
improve scaling of filenames in diffstat to handle UTF-8 chars,
2026-01-16) that is different from what you showed above.  Did you
find a bug in "git show -s --pretty=reference"?

> diff --git a/diff.c b/diff.c
> index 397e38b41c..7b27241733 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3093,8 +3093,17 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  			if (len < 0)
>  				len = 0;
>  
> -			while (name_len > len)
> -				name_len -= utf8_width((const char**)&name, NULL);
> +			while (name_len > len && *name) {



> +				int w = utf8_width((const char **)&name, NULL);
> +				if (!name) { /* Invalid UTF-8 */
> +					name = file->print_name;
> +					name_len = utf8_strwidth(name);
> +					break;
> +				}

IOW, we punt on "scaling" and instead use the full string?  I was
wondering if we can punt on only this segment by replacing this
segment with just "..." and resync at the next slash.

> +				if (w < 0)  /* control character */
> +					break;

When we have a control characer, we instead chomp immediately before
that byte, which sounds good.  But then wouldn't the loop that found
an Invalid UTF-8 sequence in the middle of a name want to do the
same, i.e., take the good bits found so far and chomp at the broken
byte?

> +				name_len -= w;
> +			}
>  
>  			slash = strchr(name, '/');
>  			if (slash)

Thanks.
