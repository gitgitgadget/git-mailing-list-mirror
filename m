Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98703AC0FD
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164070; cv=none; b=Q3DuAPx3po1w+7sZYIYr+1qEJdxrMnQchAAOYPuXUQ6h5arXec9nW/Kfbf4QstE1Z+8n9Z5TUd5xn7LlbOQykaYMpX6bdTpAZqx9LFWrqH2olcmUk+y1ZtLCneurGHLExHnxtbCMMZV6yV63M8IPXilHVBu0MNIPrdzxJ1pnG7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164070; c=relaxed/simple;
	bh=14IFN6hXRxpGNG4mcn1vRzhpIYRi2JUIjD4C/aoV3gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHOPsH5Mt1oAHYIKkDaf0rtwZsy2Xe7sw4s5iZjbgjgijmg+DhKW+YqzZsHQ9m3dOZ69ZJAfQo0Hc1mKxq5QmAsIONgSZWn9IvuMmrwhXoavfkcFukR3jErxk68UTRgr7rvveT3s2LjpFYnKvJrUYrFyhWocqDNPAJpSkc06uss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k1nYwEY5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TjQjFKft; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k1nYwEY5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TjQjFKft"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1757A7A0163;
	Mon, 31 Aug 2026 04:14:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 31 Aug 2026 04:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788164067; x=1788250467; bh=A9W4IxIWc9
	4I21BOSd0eHthmTZik0VbliOD7yCd4d5M=; b=k1nYwEY5Zk1zKwSoNel1yoKexI
	C9kAwfvewWRuWCdlr5179Y4bt5t5Qi19Sq7xuNcEnKVBFUEcpE0mHAiOEdGsd9Md
	yZtxmKWcvfUMapBb50ckjz8P1No6YI/cRzW9hejWIDNIdlo2rXXnbV83pR9k7NjF
	bXcLRkLZEsN1HvG9wkgCUZLG4hTfw5IGfMHe1NUSe8djmtkSkSK6TnTQCBS9k/LZ
	lkOTVQMtNl++z+JGykhXgeT4twqc2cbsqukgT5XZwmZCs7t0M36nFa9g3nEDQJeR
	RcrxvX+duz2m8OqRn3YjW/6Gb/xdEjDU3H5cnEv90B0gU37vvptu8Mx6E0Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788164067; x=1788250467; bh=A9W4IxIWc94I21BOSd0eHthmTZik0VbliOD
	7yCd4d5M=; b=TjQjFKft8S/VK0W3gSqZ7Cyv7q+wEFNR7EBMvZIz2QRF/qijUO4
	i3jDLddOJzquGIB4eGVezczGgvq3Iugy2RAHyk78TuPrcVQR7otUY/OmfZ7RBGSh
	1nEqmpDcgK28d2ehofFUeWlD1nNKseYWiqqufr32FtuLqPtYWDuHCiS6MYgdadoI
	l9YRTsKkQXpdEoocg/vtDIz/a4hNwDvRqbZQzgAcztNQPb5i8pL8HmTASYwkVw5m
	2blqwd3gsOspMM5K2NnKTE/fpx6D0YlOHl1RITfld7hjAXlQbuIbRJOGNYNYvLCE
	MkgzzOswTXwHY21rF3ako+NXMBLaiDhUW/w==
X-ME-Sender: <xms:4zeVam2QydKna-zepPKFEMt6V20Zs4TAGlAZHY_pCHoHh2j22UdgnQ>
    <xme:4zeVavELpFr9nKGGkuu4mEvWMKs54ivhAFvNUzPIhLdp31jh7YlN2ZbqwvmOA_zsT
    YCzMlShSQaLXJS7iPc6f4clmTLykEsMa4fPR9LOqAGnb0VQbawqBA>
X-ME-Received: <xmr:4zeVasiRCC9tLBVfkqYsMqPlMiy4nr5vRaB-NOyI8c1lbhVQ-WD2XSlqbNVExwKja1TlTg>
X-ME-Proxy-Cause: dmFkZTFizPstinJAX4F331/zcTuI6VAoI2peDJPO3pDGKQOPsNfovojy50ZAPlAo/4pDZ1
    4IiHoTpaUVOE8FJ3eK9HlDDeV1E68za5VqmT9r5dPfVbKd/K3M5BBlYVC/AR3jQDkAccql
    /VlLNFjUxPB2gOvafyWCXz4V7h+kW529ACQDDH4McTdPskh6KxF2NQX8lQd/0B6xb6BM4j
    7LZOpg45zwnASBMru6DrqRa9F6dEb6HP1lbVZFJfPk8LveNAECpVccaceZVxko2gPMiE2C
    sVY2Fv/dBLx76gb/g4zAgWQEYQ1GCXPEvy2NRLVvbt2jqfHedn7bl+UAYOq3vn83X/c0Iv
    UTYf1B/oKeZdqD/RlSfnUQKiiUOPxGCjn2nAL2BpM2SXatjtNNFo7M83cXtzwJmblDg9tl
    VY+Njvi/Vsd78iG2eMLzf2wULinrvn3ZY/W6+6kyTlh12cVJV6i/E1i1ZITXu+LAUaEJ1d
    Zjer2T7s5/ICpGUfLDYgnyoDtMfuPn7owyF3SsoXjadHe1N5IFLvvUWwGocIKqG/iq8n/Z
    7b5ZXaiEu8McrqD86OvxBxgHT0yY7urFK+5yMj2Jj5o8wDUe2uL3e74fSH3fGl1H9tDL/m
    47UCeFRleC95txdrjDRjcg21qW3Wex7/yq/Bt+/piFjzcqZXWpaPQTV94Enw
X-ME-Proxy: <xmx:4zeVai8L2rW4gcUbIBLZOb9liiiMBHFgjWpmosmvp-bd2JyoYjhh9g>
    <xmx:4zeVarp6_U4YilRrn4IBN3qP8DhAL1YcCkomMd_mRtuTlg3nfyGMUQ>
    <xmx:4zeVap9IQGsQNW9HoeKqg7hOpXNDb4e73Qwf5E9ONsf4KV73zNoiGw>
    <xmx:4zeVanV4xhvvNkyZmeKHB2JePjpPJDzrWNcF9szE5zwksRDDChxGCw>
    <xmx:4zeVaiNZGFTMKJnTRoMVEFQ5IqHWK2tUf-gVZKwuCgshL7jDJq1uZ69I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 04:14:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 10c5ae47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 08:14:32 +0000 (UTC)
Date: Mon, 31 Aug 2026 10:14:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/8] odb/source: support writing alternates when creating
 the database
Message-ID: <apU33eMVrjlWlB7X@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
 <20260825-pks-odb-write-alternates-at-creation-time-v1-6-911513ba95c3@pks.im>
 <xmqqbjam3vpb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjam3vpb.fsf@gitster.g>

On Fri, Aug 28, 2026 at 12:13:04PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Add the ability to write alternates when creating the object database.
> > This change allows us to remove the `write_alternates()` callback in a
> > subsequent patch.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> 
> > diff --git a/odb/source-files.c b/odb/source-files.c
> > index b7b3a297bb..5e77b21d9f 100644
> > --- a/odb/source-files.c
> > +++ b/odb/source-files.c
> > ...
> > @@ -64,8 +70,71 @@ static int odb_source_files_create_on_disk(struct odb_source *source)
> > +	if (opts->alternates && opts->alternates->nr) {
> > +		strbuf_reset(&path);
> > +		strbuf_addf(&path, "%s/info/alternates", source->path);
> > +
> > +		/*
> > +		 * The alternates file may already exist, e.g. when it has been
> > +		 * seeded from a template directory. Read any preexisting
> > +		 * entries so that we don't end up writing duplicates.
> > +		 */
> > +		f = fopen(path.buf, "r");
> > +		if (f) {
> > +			while (strbuf_getline(&line, f) != EOF)
> > +				strset_add(&seen, line.buf);
> > +
> > +			if (ferror(f)) {
> > +				ret = error_errno(_("unable to read alternates file"));
> > +				goto out;
> > +			}
> > +
> > +			fclose(f);
> > +		} else if (errno != ENOENT) {
> > +			ret = error_errno(_("unable to read alternates file"));
> > +			goto out;
> > +		}
> > +
> > +		f = fopen(path.buf, "a");
> > +		if (!f) {
> > +			ret = error_errno(_("unable to open alternates file for writing"));
> > +			goto out;
> > +		}
> 
> I understand that using 'a' instead of 'w' is an attempt to deal
> with the potential TOCTOU problem, but shouldn't we be using the
> standard lockfile API, which atomically adds (or fails to add) to
> avoid leaving a partially written file?  Or does it not matter,
> since this is done only once upon repository creation when nobody
> should be looking at the files on the filesystem?

Toon also asked the same, and to be honest I never even considered doing
this. It's the repository creation anyway, so it just didn't come to my
mind that it could be racing. In theory though it can, even though it
feels quite contrived.

In any case, I don't see a strong reason why we shouldn't use a lockfile
here.

Patrick
