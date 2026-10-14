Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBA04A6CF6
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 22:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792017774; cv=none; b=GkTzRambPp3pZ2RwgAuIhCqdGCBOxE9M0k1oDZTN2fJHdWwu7K0GouFFeIYnqFVY8jFvVCVpVjuWRo+1SnvqtzA8aahUEX9lZbWGXnp+E62VKZBM0a7OHs3KU6DGocNu7Egx+11T60f/Otryil+PQN6uEPxECuSWErNCj96XUyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792017774; c=relaxed/simple;
	bh=Wc9Hh6XoWHz4VKPMyjZJN49EJoVZAoyp1/nWSMq0WZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tJz9HIgl7OeAOHy4kWigfB88O1wPkI35weLQgbECqIfH52ZDqrN3ClLR/OfQuTx+6YPYbJXSqF+oxkbToyVaH7iGaBQ/Uftsjj9mmWcZfbQpUFAXehP3bwjEikhta9yWZQAUU/vhvibpHgMEQmSw0OVrOvuJPvy8LvJSrT2TwE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sri6iJO+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ukDkucpM; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sri6iJO+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ukDkucpM"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0CE061400091
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 18:42:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Wed, 14 Oct 2026 18:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792017771; x=1792104171; bh=KRgGENCZSD
	FdmEcBa6PSdcILgbwkjxJS/AOqdwO3AQs=; b=Sri6iJO+LJoXLPDBPhiS+cD26E
	lfvCFsIPPqWsemRvBnFOm8n2Rfo1clHhayIvaf6zxVZHCvv2OIA+0Zz1KQ3/g7GB
	Zq4DenYdYfCsBSJ8Wn2HeqbVnZvxZ325IY/T4zcLH2hC+EdHjywiPAkD0OgM6ckt
	T2AUj0T81DHiCEwAHKIsXxcGjiIr15u0NSVnRuHqAuMK8Zt+BSI42GcPReZ+Fk2S
	kn3uvkZEKJ21BCoT+GM+pVl1wgX/qlXc+/mee1O+uMMdkP/SpWMpFg8hpU2B7lq4
	T7GoSDvGS20HdKJX24nBIH3FTV9l2OOf9GmIvqwPlCtTp8uGsmuoDmpvwBTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792017771; x=1792104171; bh=KRgGENCZSDFdmEcBa6PSdcILgbwkjxJS/AO
	qdwO3AQs=; b=ukDkucpM8uQqDJsAokbOwgYygVsGvkZe4NS44idR8PFiqzrs1we
	7SlU0SOR03NqCfkcN/vc5OYxqy1wGffPEXeWCyV7CP72BTwaj7lBec6SBfSyGeq2
	B7qQ4MKXpUn4OZh8krpItnxOueGCZgib/ie26OT8X3bhXMI/jWvxswWNcfHoNY4P
	i3OI6ScRD61HSMXZz5md/H/OY6VxpEG+NkUpoa3oR9zxaymOeZgIltuimt1el+8U
	lx1n0TGZYX/mc5wDkOS3WT3gGsKiYgaZaNEE0pqSmdMcQWZ9LPu1SThdPhfMA7U0
	Lexuq0mlixz6swavZFhkA0pkR5/TboWM3tA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792017771; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:cqYp+4Cp4pNEPq1sYaCN1zv5Tk15HsLMeH5uddFHYBdV1t2
	j4cRno2HtOFE3L/6ERcJOAUEEVM9zIReSr5X/jPJ5KRyGmbvCqT2a0bjlNcHUcVo
	tXQkbqlmLhBN7AGso3/e/AivQxHSzC/d136k3h5SOgO8VPdGBZ1ZoMtq7JDki7CE
	me/I2sEFQBFC21sdI3kdMqQION54/2+is0ZE2PRXHP8CW6UwT1BMRUiu+UcRva6x
	UXR5nnfwqf53hATdDfF8O5HWqIxgqcyx3Gdhj550YzWU83QU2NahDhpu+z4KH+Bq
	bj51aVbApW0rfpraY6GpQRSokeFgP5ItsH04IrA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Bm5jufXXSc0y1EvsUTXd8vwjCKRiL7GN/GXQkDy5hoQ=:Wc9Hh6XoWHz4VKPMyjZJN49EJoVZAoyp1/nWSMq0WZU=;
X-ME-Sender: <xms:agXQagHsY4zx8Xtgxk3vO5QMsnbIdYWXxk2xGfJBzKeTYaSsImSayQ>
    <xme:agXQagNJrRaOl3EBcea3TCtlLLo-oeFXfDa8C2qfMQFQgV19-Ut35G3FQ3QF55VDk
    TF2TH7d5yA1693_deZqhvNUWf6jOmWKlPiXpFaoIo0rQpcm2AB9zIY>
X-ME-Received: <xmr:agXQaidbN-O5tqxaDw67IruFxZBL-EXBuVEQkoly-CcOtcX3jcKhM3Lmv3Di4smlrrSp0H5RETwBviz_hJeL8XqgzVQu9KUCv5Od>
X-ME-Proxy-Cause: dmFkZTE4qRXb4ngecmzESwdDP2hAorkMI1ccQP3aYIogg18QYLsyewC6bP4qBL5FzD42Vp
    JJAjxmqpll1lFvQM5kuS2y98wb53X3ePQ6sJOzveYHtyFzDp9fOTnAt+L9gYtmpSLxlah+
    +isxRry2gkHM9oqxLRC4u+JRqsgqfvHWRHNRZi2PHL7C+Vaa3l9ZYDmnWy0w2BCJGtIPF2
    6uUpmw+bY5IJZ8kB556laLl9ngX72LDnWeEm9LNmfJvjmFMJjb635cntllSPAs+UIu9IGc
    XkdZWO7BzxnOUvSuB9Llg5rtNSPPXqhlXX3RZ8vNnbyACiINkGAQOO+lgBB/Z33wlC9idn
    IDVu1mlJjofl9QuWXLTL8FqJXGbVFhhaxwsmZgiiplkKwqctW1FxwHyH8yMRTZmDr8HMwc
    yca6T14kx+F33VE0gV4BIsSHRYxD5jFnEIihq5BEFMqPUrvME9RtMsXXsTBeAqDvoy17lf
    PkFVLtjmSkkpGofWC0+Iybjcsm1BOMo4QbYyq1LshRYgSg1lzrHKbKUDBCa551KuoXA3vH
    htHHI1wIBbnOwHWKRboUTcbpX/M2Pjmc0GJHOYVCD/WF94gt7ZUPJweW7lXpwqACECzwNw
    L7AdMku8H/Y2AqmyvTpy/G4V9j/oBxcSm0+FVy8JWTv6HAxvmWH9KD+b6dNA
X-ME-Proxy: <xmx:agXQatsDDNrNcuEagJaXJ0C9wn39WzGC_PFUy-XbJkfGcUiUrOxtnw>
    <xmx:agXQajkjjk-hB1j2jLORRGnnyeX46oJhHA2zLoCjECN-xBcO_yDA4A>
    <xmx:agXQavyOsn13lv-pJXXZomu48wZERVVb5gKCKrSTc1ecpd4oZQNlFQ>
    <xmx:agXQalORBqCZjYGya1iQg3HI9UAc8RTENU6wDy15ozbUU5arxjeK2Q>
    <xmx:awXQasFKXpqQu0s4LeLfs1Z63eFGW0ci9Aa3RT2hDmg3xE-nlRdvVDfn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 18:42:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Marc Becker via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Aniket Gupta <aniketgupta3001@gmail.com>,  Marc
 Becker <becm@gmx.de>
Subject: Re: [PATCH v4] fast-import: allow 'from' to reference new commits
 and tags by oid
In-Reply-To: <pull.2252.v4.git.1792012956734.gitgitgadget@gmail.com> (Marc
	Becker via GitGitGadget's message of "Wed, 14 Oct 2026 21:22:36
	+0000")
References: <pull.2252.git.1791653078449.gitgitgadget@gmail.com>
	<pull.2252.v4.git.1792012956734.gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 15:42:49 -0700
Message-ID: <xmqqqzhrq4ye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Marc Becker via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Marc Becker <becm@gmx.de>
>
> During a 'git fast-import' session, newly created objects are written
> to an in-progress packfile and recorded in fast-import's internal
> object table.  Until a 'checkpoint' command or the end of the session
> finalizes and indexes that packfile, these objects are not visible to
> the repository's object database via odb_read_object_peeled().
>
> Commands such as 'ls' (via parse_treeish_dataref() and dereference())
> and 'cat-blob' already account for this when given a hex object name:
> they look up the object in fast-import's internal object table with
> find_object() first and read it from the in-progress packfile with
> gfi_unpack_entry() when its '.pack_id' is not MAX_PACK_ID.
>
> By contrast, when 'from <committish>' (in a 'commit' or 'reset'
> command) is given a hex object name instead of a mark or branch name,
> parse_objectish() parses the hex string into 'b->oid' and calls
> parse_from_existing(), which unconditionally looks up the object via
> odb_read_object_peeled().  If the object is a commit or tag created in
> the current pack cycle, odb_read_object_peeled() returns NULL and
> fast-import dies with "fatal: not a valid commit: <oid>".
>
> Teach parse_from_existing() to look up 'b->oid' with find_object()
> first, peel any tag objects in the object table using dereference(),
> and unpack the target commit with gfi_unpack_entry() if it resides in
> the in-progress packfile, before falling back to
> odb_read_object_peeled() for objects in the repository's object
> database.
>
> Signed-off-by: Marc Becker <becm@gmx.de>
> ---
>     fast-import: fix lookup for new commits
>     
>     Changes since v3:
>     
>      * align here-doc indention in test with expected style

Thanks.  This round I have nothing more to add.

Will queue.
