Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE55E24886E
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 05:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352228; cv=none; b=fBY0unsdy/ZKd9CNdosoAbWiLmv1MR6pRjOlsCD6JjreGeK01mdTHvekzP2Ufssh9m2Rz9ZWHMgCLzdL/OM2fDE8AQybRmwkd8C2abmavuEIrF6YFVLeFwMTG1bt9BwoCMQFmKYpKR71/Ir5t9cRKkhV4PD2my1BMe2d1QNVEyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352228; c=relaxed/simple;
	bh=1j7Guku2yFHh1jFKR9bguSiT2irmveEpgPAAWdlC/Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ac5Zgdh/TkmggtcvCv1njjvyRqnRmvy0FV2OgjTWtsYuCsWuWuCSZwRMSGPqcwE2P755kFfr9YgJkfYBD+3okWTkwebuZYtEDxQNmHASVv6pav+Uvxeln8rQBZilWsd9+GDl8yF5ouN7B7aqxAdTqI4NSPueCws4I+6WiQkHu2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hh4lLeec; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cdn+/vpP; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hh4lLeec";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cdn+/vpP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id EB1B2EC03BF
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 01:50:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 07 Oct 2026 01:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791352225; x=1791438625; bh=V20VWecLAa
	ZIS8LNEA0BoePMs8xJIl+KFNvYBciQKl8=; b=Hh4lLeecDpSCxkq+cwrUiSuPTs
	ejiJnZ8ZxUvYF7T1ND42JSorkZF5+tLJKPaxtwpKFTK/ydgJb67eYVU+XPzVm7nF
	sqJMAYiNHCqlzn5i0das3FmEay5NIMyyToBa9s1C8Ob4DCZQHTiNnWAovuLeaCDN
	gtReVvfWEQQmtR2MewAlO5UDhdFhEcv0GjtcpkUl8epIpodg7uo7updnoEEmF2dL
	YjwTsahUkS5Tx0g7Q0EGh0v4tz0zAyq5Mmmh/mQf/urjaR4JX8nyUTJ4bjSLyzpF
	C6T5p9jlTOJJ9ETHudxTiU/2S2+P1kC/lffD/vp/m1xNHVVnJdsiQb1uCoVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791352225; x=1791438625; bh=V20VWecLAaZIS8LNEA0BoePMs8xJIl+KFNv
	YBciQKl8=; b=Cdn+/vpPphmhaJt1+3pnJop8re4f0ksRw8mEk33133/uwKPx3ci
	QWJsGvEtFka1RDGXgpyRiyXuXHhQKHv9wEldnG0adz/IB472bXgFSbT5MhoVLrO8
	wClrIJPT+Znaj/9KwQW8WBOcULnfNMcT1llvzta1nMYrOIm2UIDupP1gnCBADfPc
	d44uLdU4FinRYyTszruHGWMY9p/XtQyNoO3uNroJWX3Z8LZ6x/YbGZKsx891Gr3K
	HN/lkgfFi9y0kkjdgg42CbUTRXUlk7M7q75zi5dyCPGZe/cJnVz4wdrS7dnTaoBL
	s2sq0EIbOotL9oZnuI0IT0gWXb5qBida6FQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791352225; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:g+t7K4FlEqidWxMw4R7id2KCbJZ43Z1Wm15qrlwXewlr760
	RO6az9mVoT0sjm4YX0bGu6HYiYhYIuqAkMGSTRNjjN3Rnufr6mrDAuP9OBQCZC2r
	7Zw7hk6GL+5ee/ukQT1+QBGvQyLB5g2Gl8FjU0+MwzM0e358BUlUpETFhyng1/vq
	IuhlkWzRrFq6cyJ7g72mzfns5HrvzIbkIJGeoaCVHbCHP9QtBt8ehDKqORI2acxW
	pgoG+QgWJ2T4wzoRreCBLwiw90I3o/Y1MWtFWGx3ydRsxEji7URXUcAXNNM4cxKg
	7Bg2jS4wMBRbV6ATbHpUtWoRNTt55z7q8wuhc3w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:71ZP6W4imPfZG5GWytqrJysDSunbD9pcIGZ3NEYBVFY=:1j7Guku2yFHh1jFKR9bguSiT2irmveEpgPAAWdlC/Wg=;
X-ME-Sender: <xms:od3Fatq9jW55Zxr_If4sCrhFVu_8JJHJdzsCpg_9ZQ8XRLUUTLCuHw>
    <xme:od3FalpRd1Qoy_VsEBh5J6rw9XYlQeYfGPAYAUedSz2fzouSO_oVBdBeqd5mag5va
    QflsjKaay6P8qq6jRE82tfdOR6FyR3tnk1An_tL27t6hkO77AaeebM>
X-ME-Received: <xmr:od3Fan11JWkpMHJAyKbgIt9h6jflnE9wtYr_Hv0Z_1l49k947zKr0Q>
X-ME-Proxy-Cause: dmFkZTEL4fV0w+SUOwR+DyGmNu23u4zYoDaFSdB2lYApbnEk1+3cclwag4ZhDus0DyEXbC
    GRhqsgYGQmJf2oEjyfk/LwVZCJOYxyZlLH51QTgG8nZ9OvFFPkYV0omLVA/WF1hl27sIKy
    IA4ltvCAU41PFcCdSISOT1Adrb+TZJluLDOgofbWfR4+tg9CXpRR/q9qKNyce2usKZsjRa
    U6726tQbczW22BCz7tSYgVXdyWTillD25IBe51/QuEb+wDO88iU+Ufy3Hd8RMoLIGFR9mB
    1wKlFBFzkU9IxhtGi0EV1/aHUmZGouQvmpxYZtgKmQQQ9TzhRAGWjq/hkiWZ8GCufRWjs2
    SCtxrhZI+g0f2PRK1zBlWrpWLI1Tg68Zgytgi0OmrV0EDLoGp9f1oDDXhnX2yUWDlor3gx
    Hq+JPjOqrnAzEuoUlLedoynbOCvavAvuNnQZUbO8Mo1lhlm/oxqle1qr0wqbS3FolVkKwx
    XQ321KLqyhActtt2R6I+aX8jIVqVMfHCvdQ7kVGJAkEmGonzgChvN5b291kWXdaflLcqFd
    l1h9EXMZlx1SD99r96BDdEWXUo8cWYnF7ScRlJZepVUrZdj00Epr5W8GtaCgzOI2J7RqDw
    MFJmJOAW/AmAheEw7YxEuKI2WBPsP5m3knxD0Ep44AtyGeYTep3jLFTxKh9A
X-ME-Proxy: <xmx:od3FakCdl0nfSPoM7SV5FZs4tSbLueOwixqrFKFu2wNPm2BGzr5-tg>
    <xmx:od3Favfxm-2KwcsYXE8dGgI1fMxz5i7uriOydkaeOFfQqiyCjn1bIw>
    <xmx:od3FapjbFSb4vkQK2F6zR5ObGOOdqcHTudAJ_bJzzh-eLBc5yVxBsw>
    <xmx:od3FanrCTfYIPLTnwdeSAr34vuCy222b_IOd0ta2qL9uR03GnOUl4A>
    <xmx:od3FanaGk3f1Il7K7Kktq-tFd9LaM4B5_5Zb0RKhhy66sZMA1buvMfaQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 01:50:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 87110095 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Oct 2026 05:50:24 +0000 (UTC)
Date: Wed, 7 Oct 2026 07:50:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/13] odb/source-files: move alternates into the backend
Message-ID: <asXdne7-Vujgkud1@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
 <CAOLa=ZTHSRmwJgsxi9Fq5ek5wVsFYUHD_ohwSmzWLQjcM3TYLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTHSRmwJgsxi9Fq5ek5wVsFYUHD_ohwSmzWLQjcM3TYLA@mail.gmail.com>

On Tue, Oct 06, 2026 at 01:53:24PM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > Originally, when designing pluggable object databases the goal was that
> > the object database can have multiple sources, and every source attached
> > to it could use a different backend. This would have allowed for quite a
> > lot of flexibility, as you could trivially mix and match different kinds
> > of object storages in whatever way you like.
> >
> > But while well-intentioned, this design led to a bunch of conceptual
> > problems:
> >
> >   - We're now trying to read objects in source order, whereas we
> >     previously tried to read objects via packfiles before trying to read
> >     them via loose objects. This led to a performance regression when
> >     using alternates or when using a quarantine directory.
> >
> >   - Some data structures are supposed to only ever exist once, like for
> >     example bitmaps and commit graphs. At the same time, those data
> >     structures also span across the union of all objects, so they may
> >     cross sources.
> >
> >   - It is unclear how we can extend GIT_OBJECT_DIRECTORY or
> >     GIT_ALTERNATE_OBJECT_DIRECTORIES to become backend-agnostic in a
> >     backwards-compatible way. In general, introducing an object storage
> >     extension into the current status quo where alternates may have to
> >     be extended to become generic was proving to be painful.
> >
> >   - Some mechanisms of alternates assume way too much about how exactly
> >     their backends work. Alternate refs for example assume that the
> >     alternate is backed by a filesystem path, and that this filesystem
> >     path may also allow us to read references. This is not a given
> >     though, as backends may not even have local data at all.
> >
> > In short, there are a bunch of conceptual mismatches when we have
> > alternates and pluggable object databases coexist. So while the original
> > idea was nice, it does not result in a system that is easy to reason
> > about.
> >
> > This patch series corrects course by moving alternates into the "files"
> > backend itself so that they become another implementation detail. It's
> > unfortunately on the bigger side, and I'm sorry about that, but I
> > couldn't really find a way to split it up further in a sensible way.
> 
> I went through the series, took attention split over two days. The
> changes look good to me, but would definitely like to see another review :)

Thanks for your review!

Patrick
