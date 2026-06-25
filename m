Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5124F3BD65A
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 05:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782366749; cv=none; b=ksP+Syp88UOTM4liqthtFcbG8iSoZObqiDYbOmdRG+KALf3qkqVLntQ4mvCJmCaj3BRnRi4xNuobGCEFfNuDPTrewqWcJOlZGEe0IgGy6k2T20ztt6IfZUtttfnVwT+tmiIH6odNTesT68lD8CaNL+EWgBFVOQ/bt4p/8o24jH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782366749; c=relaxed/simple;
	bh=Cp/IgienghK/QfHNN4nhjTZUDKE4eGIeJYOO2bg8qXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQIjXPeDAkDo85pIhBZN9M0Nyqebk0vBLkZVMKp8YmS38nNa03veLGk2HsnCgsOr42mYMS9ULTzK9bHcKKctF7/lilVxNLTio7Qf9WAG62O/qktL0BuGqPcknrgvrqJhInrQ+1XLU8TAlZnZb/vrBVk1Zxy0PvJUBl/NKIKo/hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XrQ9OmIZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NqHi7t52; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XrQ9OmIZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NqHi7t52"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A56BEC0331;
	Thu, 25 Jun 2026 01:52:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 25 Jun 2026 01:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782366745;
	 x=1782453145; bh=bBpu9E+OB1+n7NSfcSiZpo9nEAslXT8oGc1/lbWQNjI=; b=
	XrQ9OmIZFcNIU4lKBmEJuATfgiEcokRCHbAO4RDFsr64sX1TGXmEd4VIDdJfK6nR
	fdi9sd9UHCHgu0H9hjazsdj7CWEdLjcn0+igYCIGZ4xvJ+I8BjJnsBKkt5+WhlN4
	miUhSLd38dFTrZxjboohxuFI4zBrZvCFa7gp4i3hVPapi/+V++JXWog5sE5bmNZ+
	lsSLx6Nd8LqneSGH0KYB63kjJiuDwf/kNjRAMh12zKMMFEo+jV8eJpy6QwNmmTmf
	e0zS3iuYWrFG9EseLYP6RYtxwFr+l1VVf7gcTpZfcExoWA09/3gDQPNc/qzxSnO1
	1yCjudA76VPVp64K3V2k2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782366745; x=
	1782453145; bh=bBpu9E+OB1+n7NSfcSiZpo9nEAslXT8oGc1/lbWQNjI=; b=N
	qHi7t52DXDov6mRzuX1+o9uDW4KdMTK223nt7vbRfZjAarUHhLmgHXhtebQEK0Xf
	YeCCIjsUNniJ0aacIydVgMFicOOZfZk0MGZ3z93j6GDFxKB1OJkwX7PJdhPNC1Z2
	mtKkGwu6GCOIPZfpmKrjQJjcbYJCpjtjBS+UdUMH/l7kn6WRdrp8Tss/zsFjhvZK
	LAVV4amGLQ05GPaE3BvJ1Xs4k0YGQsOxOtIEbshqrub4srzUrGL77RrPb0s+PAYu
	/vk0n4ZKu/+5Sf2sIEVWUCMq0WI/yvvFauZOxBIDYU4W+n7dR5txtW+FN8ppA1s9
	CBCNhtby4z4eTnKiJFWzw==
X-ME-Sender: <xms:GcI8amf2fz0ITcUlWVdOb00Gdfy6znNi_O5Vn2uSDJOTcj0cpqMNQw>
    <xme:GcI8anM0_wIzYy14XtYrd-G-7ABYRzdbAhadF0XeaIviKvSMsfP8x_F0uWD9BoBy9
    IIf2p2UKtlOesnA97FWipDawbqTVKopdtfL4tEcZUwCSyL8e8uSNfY>
X-ME-Received: <xmr:GcI8asi0thF5UOIF2BfKZcqd0rhFuppgDp6uvMQEv68cg7fYsLjmiGc8MqJC4fsg1_eFrFTnoV6nQ8WOQMXm6U-IrUc6VxphFuBIQlRBhQ>
X-ME-Proxy-Cause: dmFkZTFVCNHJNWCoqIewx5AYDm3oLrI/v60TrpXgcCNItbGm6wMM7y8qbsfAF4WOdcyNM3
    9bnSbFkI5r+eYRKBu/XH7SOEFFfKLV2eEYn3jHs75rlsjPa5LgY5l4skL2RoPzglpzXTMz
    cHo5dV6uAyVM1RevE41gBY1Ky+JWL6TCzWa5W/xeE/W9FpPf66iNit2y3Wf6S+aC5fLOXV
    rCCY6/pH3IOzL0TMKK9T3kQsX6WG2lgOJSlRBkh0vSYUO56CRP+jyctHt6/UTKZjrJ+Dbp
    BGYgWedH4nIh6JJkQtk4Zdf6lWdAPA6utYGWBWmkMXVMgy7mW4ohGWe/voNLdnY9V3g1Sv
    n0XKAAMnzohYYlSuXMYZQhKUp+B6Q9USZY+j1TMpoSwnpihB2abVT9zcEQUbXkfRvK+EqT
    t46lls1FNSv5WU9bT7X2T0uusfyByV/t6sPikask3A6KE5KNlVRjXaBxfqBOkh936kxsWT
    abr3GFHzXsOVkBHrGOhG1RROnCCny03yB7WC5VfT4JVwE3ulixJlCuBX0JiHsoB1Fa82ou
    rtbwZqhvVRXBfiz7de80IGUQGGVu9c21WYrp0/C6S52SHs7BVqmUjlDlJx6FWA4afnC9iJ
    WZS83FK+MgW0zgpuxAF+qfFn1ztp3tBM4exmPme3NAwYWsqhFipu9Nq4pWPQ
X-ME-Proxy: <xmx:GcI8ai23tqLnwhugz29UVJBm0ZmQ5RXLW0IoPBK5l5_zAQwIwwEDLA>
    <xmx:GcI8auihGwGsO-aULa8EzUUuVW3-hd8dpYjBdDDVfIykIrNmrrx2Bw>
    <xmx:GcI8aqetsAx7Ef9Zp1yttAp9FH9r3dG03yduumHb2L_kEEz7u_oPnw>
    <xmx:GcI8apkNHZMrAlNJpC023fwstEvuYeT1wBAtFIxHQ-F35HwJ8xoPEQ>
    <xmx:GcI8aghrN_8Tch_6In5KAY_U-1CQtaRsDNQQ6NJ0d0zsc_wmTVpCcvIe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 01:52:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d8db89a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 05:52:21 +0000 (UTC)
Date: Thu, 25 Jun 2026 07:52:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/4] odb/source-packed: support flags when iterating
 an object prefix
Message-ID: <ajzCDpviaL6EillJ@pks.im>
References: <20260624-pks-connected-generic-promisor-checks-v2-0-132d73ee47b9@pks.im>
 <20260624-pks-connected-generic-promisor-checks-v2-2-132d73ee47b9@pks.im>
 <CAP8UFD1sJNJbAAu9ZUanB8gJV-Vb64pLVkNULm3onSFZirdKxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1sJNJbAAu9ZUanB8gJV-Vb64pLVkNULm3onSFZirdKxA@mail.gmail.com>

On Wed, Jun 24, 2026 at 07:02:48PM +0200, Christian Couder wrote:
> On Wed, Jun 24, 2026 at 12:37 PM Patrick Steinhardt <ps@pks.im> wrote:
> > diff --git a/odb/source-packed.c b/odb/source-packed.c
> > index 3afc4bf01f..6f31f0ff94 100644
> > --- a/odb/source-packed.c
> > +++ b/odb/source-packed.c
> > @@ -171,6 +172,20 @@ static int for_each_prefixed_object_in_midx(
> >                         const struct object_id *current = NULL;
> >                         struct object_id oid;
> >
> > +                       if (opts->flags) {
> > +                               uint32_t pack_id = nth_midxed_pack_int_id(m, i);
> > +                               struct packed_git *pack;
> > +
> > +                               if (prepare_midx_pack(m, pack_id)) {
> > +                                       pack_errors = true;
> > +                                       continue;
> > +                               }
> > +
> > +                               pack = nth_midxed_pack(m, pack_id);
> > +                               if (should_exclude_pack(pack, opts->flags))
> > +                                       continue;
> > +                       }
> > +
> >                         current = nth_midxed_object_oid(&oid, m, i);
> >
> >                         if (!match_hash(len, opts->prefix->hash, current->hash))
> 
> It looks like this is:
> 
>                         if (!match_hash(len, opts->prefix->hash, current->hash))
>                                 break;
> 
> and I wonder if the `if (opts->flags) { ... }` block would be better
> after that prefix check rather than before it.
> 
> Putting it after the prefix check would make sure we don't continue
> when the prefix doesn't match.

Hm, that's a good point indeed. Will adapt, thanks!

Patrick
