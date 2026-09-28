Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAE645D90F
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582329; cv=none; b=YwhNMNenxvM4pX1Qx7g8jYWS4nCbyRmJx5WgnaHy99s7gOK1dzl5T9Jmsy4Cn27NHwiCaMVAwN+Sn4QDjqFoD75lXUF9/9hcQxIVGCT2EMAN6tg+jufXIErz9bQuctEEsmhLS4qnynF2TyufanKW6zFn0odKueMkZoE6D2ji4CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582329; c=relaxed/simple;
	bh=/ewZPnsSRTkqxoFKtk/H7hld0wVFSfORvCoHvEHax18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BK6tN3VpNApwxUEcyE+lMijk0KPW4fPuSmaKtTBVDfoFa0sHsAJL84HtDUl6c7rA66o35qj91toSN2p02fHOd3p5LrrtzpZ/qmtptjg7TW0RbjyfOQu2os7zawpnSeKhR/MLw4+ZIhcINZpFtnWgx0VlvLlaRcqY/ihlF11HwMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O2UdfKKe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sm5s7g3l; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O2UdfKKe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sm5s7g3l"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D7AA314000E2;
	Mon, 28 Sep 2026 03:58:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 28 Sep 2026 03:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790582326; x=1790668726; bh=3EgM/163Oi
	onqmJtVmZrB9mSLnrk3MrxhmDroU8XCG4=; b=O2UdfKKenQiOUQh8VufV6xzgFx
	+S+iAcjOl0jCkLgJsgy35qWjK5IoVVv1K3pV6zHngXPbGXEnfZwcyOFD1f2QNYQP
	O0SCOP3ycVyhB1yqgSp+tYyfanms9CnwHrPocapn4UQaa+9WQyISIZzsJMEvW/0f
	XdLg1xENvVsd5rkjKszfLv6cOZ40H4r1rP5y01ZldnFi6+jEy+n4B65IddOqGezU
	0B5YizPy0MdpQRqsNLHTcqzYl8pD5JT73aSRM44doY0A0WTJri3D7Y8vp7WqjL5M
	+QDtPdd9WPv7CaLZh4gndyay0trEvIZQ+xQ4dZU2RRtfBdzo8esqTq3gNidw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790582326; x=1790668726; bh=3EgM/163OionqmJtVmZrB9mSLnrk3MrxhmD
	roU8XCG4=; b=sm5s7g3ljl9G/te+SbK5tt6igGEo9o9KUsiXWnx2SPgGMGu1ODA
	icgnoV17/upP7DioIJM+Aq+SSRKnrH/cqLyLaZkiigCNjB55rKTwikfGcVi3sCxK
	jGeC/y/Okmu7/3bGxXm73vIWwpcNw2yrcmt1S2XD63tO3oM/w37ricE1OC9lX8BS
	0vR+RL73pjj0tt6WW/JG9ZlaFBrOTtSh+9afOyuoPNtwr6u7P1Ho431TpdHFCBBv
	1mEE6r7F7ynR5LZSZBDGibgRE7ElYC4QWrQCzfpGlglf5yvt2JDvtun5gkP4Py7R
	eAYqxF2boJb8UHJwLk8gw0Un1GWOYTimk8A==
X-ME-Sender: <xms:Nh66akSXxlWdyQmrrr5TiFb7j7oMd0WjJ_YrFfV5sTL803GoRJaYVg>
    <xme:Nh66aopmUnf01yO1XH586uN5CdXJjTBlLCgpEgBthcnYQd3uOi9NJ831ENTdinYLb
    56zwRbtkB3gtHZ7d8guGe93bec8lsW1T01yEaSlX-7Pxdk4-gXOVK0>
X-ME-Received: <xmr:Nh66aqI3gKxxoTEjPfxbI321mgIHNLXpvzZdn7rUcNhWWY80xIqj7g>
X-ME-Proxy-Cause: dmFkZTGc8MiVRuS57bvHYJxHp/R2uJtAG6EdDWioRMtAYIW0dTNDMVAU78Q9Ixb8Sxa42Z
    j2JY7Xdts0sLs+BoBsFXU7GZXocLeiecOvjz3hTivs3EfzHafGg4ANFuKSkOSyxdq7A2LP
    9F40WKP8zC+QILy968AB6qbtZ+2htCpX+dMSP9jFkHayskVJGco5rk9GL0dpujQctZzxBe
    ggU8xhQuWwRxn9C927mHnHvxZ7DsbUun94bx73ICqy94oXblXwIeFrHLQzc8RuiDhfbT/C
    SruN5WeDCguXQIACsoxN7QFZOEq4CXajKAtLl3gRPtyVYmyB81r8VwA4WyIBVDjLZ9AfOT
    2mRBrhxvZpZU4+L7u7EITstD3QIb8qc2lgDegdWf+UvzUNIMCk+EQM5L2Ymz/l+JL7TKMX
    FyFjG7NtrbqIOO1L0+YZgFxrpvWx4WMMyK73MeW40SFnCaEvl28fkHmtat2jCKXFDMDL+x
    7H2R5dxL1z9eFmsRRgJ0Yv7E4gZWX3oMMAFn/a4scfUxf5YcbLSArPby0nA35shy/Mbk0X
    RJ3kNvKkn/qzzOhDDRfpRqUVBB9jFwrKJbMGIa4Y6ydEukE6GuoWxfB87IYSaNYVFv7F6H
    TMSNqdN0VWrUflTV84hDnTR4ehOfc9lEWHL0UUiuHNiKsQ60omOrHmxtk0tw
X-ME-Proxy: <xmx:Nh66ajpmjO8JUW95U26Mx8ys98L30bgKbT8raAUhvXiL9yqAWNBSlQ>
    <xmx:Nh66aqxfLeF9sRt9mjDpp4YPNcsDD3EA6SnrI1GoxZqBANfqkbxBkQ>
    <xmx:Nh66avOd0gJW3gAEVYWy5lqH3B2GYMgywUc2u-dr5FBEA7PZvJsv9g>
    <xmx:Nh66an7a0hnHHS-6mIIIDwDKFyWZUkKl8pbdfYBgX4vcShvCqLaxpA>
    <xmx:Nh66asBWoyjj_rMWzalBr_SKl-O_TTwqPbQXd1E1kuNxvPZHU64vxOrS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 03:58:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 658a1aac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 07:58:44 +0000 (UTC)
Date: Mon, 28 Sep 2026 09:58:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Royce Remer <royceremer@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/1] pack-write, pack-bitmap-write: register tmp pack
 files for cleanup
Message-ID: <aroeMVWrwvlC1MrH@pks.im>
References: <20260925205633.530651-1-royceremer@gmail.com>
 <20260925205633.530651-2-royceremer@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925205633.530651-2-royceremer@gmail.com>

On Fri, Sep 25, 2026 at 01:56:33PM -0700, Royce Remer wrote:
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index 1bcb3f98a4..c566419690 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -1378,6 +1379,7 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
>  
>  	int fd = odb_mkstemp(writer->repo->objects, &tmp_file,
>  			     "pack/tmp_bitmap_XXXXXX");
> +	struct tempfile *tmp = register_tempfile(tmp_file.buf);
>  
>  	if (writer->pseudo_merges_nr)
>  		options |= BITMAP_OPT_PSEUDO_MERGES;
> @@ -1435,6 +1437,7 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
>  
>  	if (rename(tmp_file.buf, filename))
>  		die_errno("unable to rename temporary bitmap file to '%s'", filename);
> +	delete_tempfile(&tmp);
>  
>  	strbuf_release(&tmp_file);
>  	free(offsets);

The fact that we add calls to `register_tempfile()` to almost every
single callsites that uses `odb_mkstemp()` makes me wonder whether the
interface itself is maybe misdesigned. Like, should it maybe return a
tempfile instead of returning a file descriptor so that callers don't
have to manually register it?

I also wonder whether `odb_mkstemp()` even sits at the right level to
begin with. It's ultimately specific to the "files" backend, as it
assumes that files live in "objects/". Would it be preferable if we
instead made it part of the "tempfile.h" API, where the only difference
to other functions is that it knows to also support leading directories?

We could for example have a new "_d" suffix for `mks_tempfile()`
functions.

Thanks!

Patrick
