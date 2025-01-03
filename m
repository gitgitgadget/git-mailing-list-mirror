Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4998C186A
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 20:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735935943; cv=none; b=MvqzDJcrDGkqNT0rmT8LeAL4LdTfSyijjwcreYN6HHD0f+pd54MUgvyH/9RXr3ms7B4f13c7EIPgrWzo5wljkZr0uboAFuJR+PwBCKewIkPrrXQQBSAYJ0Gikjyh2AG/zz1lfIXisEH9LEEirM/FCDhO1JwAHzmcx20iKtOoyLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735935943; c=relaxed/simple;
	bh=ubLqVHYkqO4c9ofVhokpunQFxGS6ntdfzA8iPyyLfWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LnypY82noeCw+YgwN1RxBUPDGaX+HH2oyP6VbuXY+qxCHuc33TgTG3j4qIpGKd+wZyE4+mI057w9lKxz99pntTMEKUaV94J6L4ktyKxzvU6uyflqoeJzUAcCYrED4FmGSkk9G0eUOSgLQX7yNK3JU+RSh6L7naD20wb31vVpltU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZezOBfEN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wXvHy8+5; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZezOBfEN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wXvHy8+5"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 67D53138037E;
	Fri,  3 Jan 2025 15:25:40 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 03 Jan 2025 15:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735935940; x=1736022340; bh=DlrVaCSmLD
	glpsE7+tiSGMYNNqTEBcy5LdQ5QB6ws1E=; b=ZezOBfENDRh2umL16WWf5BePD4
	BWKzOA3spdEzQoEWj0HYuE3ZzdQ+CtbLb3nT0+6BvGITONEk9/HnGXzCc+GdwpzB
	L81jZc1GziiojztZfCIlUU6GHKmt1VpNj0ueekoceS6/qIU+3TpxElkws3x7zHPL
	QsNND1B5dLU1mdh73V//FeXuLDz8OnxIBIwqtFatYiSBDvWy1BO5DfD5Jf9NoKLq
	SyZdJHWPBtf6DjPrw2yg34F0XTy58Ft1fxOEgMpdCNaCAVcwv1LlkBKgr/mu/83c
	4BgthtUmS1nxrGDX8NOShl0U1uU/a0Li0Ve0XyBllK0wZATphDOOBBY7wYdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735935940; x=1736022340; bh=DlrVaCSmLDglpsE7+tiSGMYNNqTEBcy5LdQ
	5QB6ws1E=; b=wXvHy8+5b5f5J5RYTsjZ6UptMjazNbueGSEmDsCHeTVGP8eaOYz
	GiXTz8U81CkVi6XpXWPs0wFL0MK/cGFqqM7hPy9dWR3r2lyXuW4AvWDtI579D7iu
	Bs2K/1eu+U1PZo1mmKVU6uZQXWbqZ0YL2r74UPt5Bn3QeAyJDjfSL10/KNB20R+g
	gYVqfFQhwHxpY/mjkWB9K4BDzoTYalIM2Za+7HX6/5QTUCisydjc2CAN9G36+O9f
	I98ZIXkDp8hpA7FVUh82hlHHLnvr1ecebD9IElre9PnbhE9v3C69IhusTYE3aHEG
	N3kQvStH/me49dBEO3yDoJyuoByV2Q10gvQ==
X-ME-Sender: <xms:w0d4Z2rq9jHKIE6J9UXaLBQSK8wmaTps_jOqKgNp0Ass3UvZnT6VvA>
    <xme:w0d4Z0ona2ojsYtpEpv_VItc77xasybWehJT7MXppLISMZaXNI012PK1eSZnpvdQ1
    YJ5ta5qGCrFVMbofA>
X-ME-Received: <xmr:w0d4Z7OOhPDqKNGfTLDFy6VuMmlxkT2NTGFhhFuKKflzSAD8VMUOqlHiWevXPJikZqDlU3Rq5Ih-Di8ymHjA4DpYaP53QLYV7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:xEd4Z14AjYwQ2NS0IBirufjo_SqrkMqo3iBstuLhiBg5ctwQlDf5pw>
    <xmx:xEd4Z15gSZ3Z8ClrioYMdN-nDTm6DmPGZ6ElYlJRIEDjBCCDXHUo7Q>
    <xmx:xEd4Z1gYYcDBHnE6d_3OY_ZVCrfHz5rLLgZgSMp_fpyYTNE3XWkLtQ>
    <xmx:xEd4Z_7-81j0W8SqV2RKcLKf77hxkzTTm7T1lazcBn-wDjk28gJ7rQ>
    <xmx:xEd4Z40ve_S921jx1Im-xMP6gB6bBErP92crn3X4kKhrMrHTHKoP3ZAg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 15:25:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] object-file: retry linking file into place when
 occluding file vanishes
In-Reply-To: <20250103194058.GE3208749@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 3 Jan 2025 14:40:58 -0500")
References: <20250103-b4-pks-object-file-racy-collision-check-v1-0-6ef9e2da1f87@pks.im>
	<20250103-b4-pks-object-file-racy-collision-check-v1-2-6ef9e2da1f87@pks.im>
	<20250103194058.GE3208749@coredump.intra.peff.net>
Date: Fri, 03 Jan 2025 12:25:38 -0800
Message-ID: <xmqqsepzprul.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I share Junio's uneasiness with looping forever based on external input
> from the filesystem (even though you _should_ eventually win the race,
> that's not guaranteed, and of course a weird filesystem might confuse
> us).

Yeah, "a weird filesystem" would be a lot more plausible than a
determined and accurate attacker to break it.  The only thing they
have to do is to yield EEXIST when failing link() for some other
reason.

> Could we put a stop-gap in it like:
>
> diff --git a/object-file.c b/object-file.c
> index 88432cc9c0..262a2f3df2 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2038,6 +2038,7 @@ int finalize_object_file_flags(const char *tmpfile, const char *filename,
>  			       enum finalize_object_file_flags flags)
>  {
>  	int ret;
> +	int retries = 0;
>  
>  retry:
>  	ret = 0;
> @@ -2080,8 +2081,11 @@ int finalize_object_file_flags(const char *tmpfile, const char *filename,
>  		}
>  		if (!(flags & FOF_SKIP_COLLISION_CHECK)) {
>  			ret = check_collision(tmpfile, filename);
> -			if (ret == CHECK_COLLISION_DEST_VANISHED)
> +			if (ret == CHECK_COLLISION_DEST_VANISHED) {
> +				if (retries++ > 5)
> +					return error(_("unable to write repeatedly vanishing file %s"), filename);
>  				goto retry;
> +			}
>  			else if (ret)
>  				return -1;
>  		}

Sounds sensible.

> Otherwise, I think the logic looks good.
>
> -Peff

Thanks.
