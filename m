Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D18145C71C
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302052; cv=none; b=B3RjtpjyjGqUZS1SxsUdmDJSlB+xHl1VRX2NetkjOyO3ebzoEavc8V7mnBopqtSaQkHxSD6tuR74rOpn36xlET/zciJH8IEUeW+D769idHjtdPApj1pWW1gaFgdxfEj19F1nGJiBOZt1ZmaJDU3pbmqh9EHS/VG1elbnqWFRwlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302052; c=relaxed/simple;
	bh=5DN23onDVEmO/zro5Dwiw8h6mpCzyAfcA6opQZ5k4aw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JxeQ7sbpDlvkRhVRAsuQIJDDDdCfMjdNISmb8BUVp05e+5fwuBgKrYmJJJrxsUx/gK5lQnv+jCadcxFO532uNRjLb/fkbFZz+TsRSf9yL47CU+1HLb4s7xaTFPJy7PLJT+YZwPdwBq4T9dTsPNM+vWerT0ki3x/rWlVDdiyu6YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gI/qh+gk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HqJMMiIJ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gI/qh+gk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HqJMMiIJ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 73796EC00E5
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 11:54:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 06 Oct 2026 11:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791302050; x=1791388450; bh=KORPhUlcA0
	KPfVBwmvQcBdcSWyN0TgoY1D2GZdDUnVA=; b=gI/qh+gkRBQ6OtppYtGuByEr3r
	PQ1feOgjpE38TWQbe52LSR1jxDEyBAvemhVBxrGzjA3w7bRa6CQiPusHfEfQCgwK
	6ddRyfY8u+puPWhoNXTYJo0D9Sw0BSMxl78Pf0pKKJfCYGt1eyFuIurtUgQZYARi
	TGlSZZsg2NBk4t0y2XPP89n4+Ut5HpXhTFnLlOCT9kxbHZY8L7sUv+8J0gL2kKIU
	VVDHKHhU/H/7CRvj1PflKrgkLUEHRC+kXdHmA3qJBh/iO0hIfj4Vl4J8qhbAbn2X
	a2UkBfUPwxB5K/9/15AsYf7idTVURCg+m2YPDtIeSNnNk9uYvw+bYpqFnp5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791302050; x=1791388450; bh=KORPhUlcA0KPfVBwmvQcBdcSWyN0TgoY1D2
	GZdDUnVA=; b=HqJMMiIJHyrlGK3mQR2G/gXVSvc8XWlxnjjViWDpOtcPC1qgSbY
	0/EVa4BR4URwJgmOl2o5gMYStxc2Ltm3xLiYkk0sX4LODQWV1Std420cs/pa0+84
	pD5HwjcQlnFm4H2Lmnefj++n8nufCwWjflUW5qhtGLKdc1Na8JoIvx6epHgLkE2x
	yRqQvjmvFhvvo757WxpZhZZ+9pK9ouPkrx4S7kK1iMCEZ8E+l94II7okV1+wBCzS
	Ynmbi9GXUuL2cKH/hi1FM6rBgD1w5Gy/vdfYkhrPQ6nBAeaRD0+rojpsvH1WzBmJ
	hgn5V8kUfK/Uz+S7XPR1pd1FTFaFLkJcTUg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791302050; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Hb4aZCjE6BYdYCa3AilFkDcfD1igb1Co6oJrZKyr/RDbcc4
	MAFqOON3jYi58ZGrkA0yb3/1kfOdPBgPOVdCyUsDcqPfbuZXBsa+MfaUkRs/GaeL
	N9prOz+lQiIq+0VyO5Uu8c6bMi3mIelA8bqAYkVt6VzAdsHfHz3iPYMRtwQkwOk/
	0UR4wgQ/YnLDchbXR8fv1Yw8yKXigNbXqQ3Oeybe7qvncoFZABgzhFI9LyHVjXUv
	tgnaCl1stYy9lwzuOBYu2g8T+AlUTr/Xvr5YE0xxl7X4UM9QLWcRUfBDRQjbvSA5
	fg4FM7i+QUop9hTrGVKB4j3WenQlPefw5cRCPNA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:zdFck2G+5DwtTOKPHKnGxy3LZO6GacB6t2L3/Q6f7Iw=:5DN23onDVEmO/zro5Dwiw8h6mpCzyAfcA6opQZ5k4aw=;
X-ME-Sender: <xms:ohnFarWfbSsQwA9PxIzfhAz_FDjag5gZBuWzecRRVQpHDYKmojBubg>
    <xme:ohnFaqleNI9wtOcgT5SicMHdBHCvK6Wr4VzSovuZEpUYiXxwNDYlPNTki_SM7Pl1R
    4JaxYjtfFE57LPt_vXNIyXjDiWNNPsUqGsGpddTz35s1QH2_UuDaw>
X-ME-Received: <xmr:ohnFasYxDkZKp3OFC4schYFwmX64jV9uRks0FqLjkDI4X2jnz3o3jk8IADlX0BIu7CdCB9DlJrQi3yOJXG6iwD-Kzz2prp5W4yRf>
X-ME-Proxy-Cause: dmFkZTFdEzq36cykNoc2OqXsRhkBF2KzPbU3OJ0JNOoTPpLH2AASO7BcdlFUJjXxeUKm3j
    /OxoLEdr+RKxjjOuKFR6s7dih0CPJud0eka9wSaVJI+uHIfWBb4/iZrfouCXqIw2eZjzJt
    EIL/csYBIczEZ5iVNxgZnkE/K8MUJebPGOx09uRmZY7uCvhwHEsvAG4nYKbULi5YqU1hj4
    oQG1MAv4bZmLJ/pP0Ca+wV2/qDun+21oyj8aH9fiOliRnh7yb34rN8fWwoxcN1bt8AjXb9
    EaQOQ2Mac80jxj5KhwVtUK707fHu+klM4RC4vlx+5vFY//F8EpJrO7ceXfQVWW5n7sXMjz
    VJkP3KkJiwqqXGzL7llSkgoVmGxye0UHllKOL9Mp8Z98WSFQ/AA9c3oMwkP44FkQ5/mkWV
    w8X+va3zFPnujQuwIywO5gGmBicfUKISaDG85xLEqj5yv57BSFnvIQG4SjF0E82PoISn4X
    NF1meMtGceMfuUjliDZ5kniGLS0eeC99W4YtWIQnVpYWdEwVcD5hf9g9eDQdDxWCsY3WUv
    WP8s/46MLf716FS7eyBb2Ym13E8TNyPMkGwwfWWXwMBBN8wmVIBkGZL9/nvpnDFTrFP093
    lWvQ578F1fy1ki8wRIEx0KMw+BYaf8jwduKTFpGNrdngVYT1WwrCOhGr62xw
X-ME-Proxy: <xmx:ohnFalMjawRVOtpPPnBYWD_drkiCrDhzQ724fknzwzOgqBVFTBrvxg>
    <xmx:ohnFahbSH1uTe07IkLPB4yjEUXNUfNR1BEqHdXcGdVOfI2qS1YWHEA>
    <xmx:ohnFaj2FKnI9TNShS6kWT2CpKuuXYRyW2MA1mmJuhCCKCmNil0HJ1A>
    <xmx:ohnFanec9hEcLEPNJw6YdYwc8a4Fm3UKTxexRjjVJb10GehThL1Okg>
    <xmx:ohnFan4LMVTaoTkDMg1Djq5j0NZ7LEA0Q77WfV-6P-xiWGR6TOktHbVh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 11:54:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Sphinx <sphinx9692@gmail.com>,  git@vger.kernel.org
Subject: Re: Question: behavior when reverting a commit from a shallow clone
In-Reply-To: <asNKZpxiuFhVkVQd@pks.im> (Patrick Steinhardt's message of "Mon,
	5 Oct 2026 08:57:42 +0200")
References: <CALfz8Qx63qNoSbXq7C7u+KwX4=HCL7=uOUahpXd6j7KvW_c_Eg@mail.gmail.com>
	<asNKZpxiuFhVkVQd@pks.im>
Date: Tue, 06 Oct 2026 08:54:08 -0700
Message-ID: <xmqqbj96g6zj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Yeah, this can indeed be surprising behaviour. The reason for it is that
> in a shallow clone, we rewrite the boundary commit (so in your case B)
> so that it doesn't have any parents anymore. It thus looks like just
> another root commit that has added all files in a single go. And the
> consequence of that is that reverting it will then delete everything.
>
> Now arguably, Git could be improved here. We just recently had a similar
> discussion around maybe forbidding to "git commit --amend" such a
> shallow commit. Your scenario is a second one where Git should probably
> at least warn about what's happening.
>
> Arguably we should even completely refuse editing such a shallow commit
> by default. I would guess that in 99% of all the cases where a user does
> it it's unintended. And for the 1% where it's actually intended we could
> give users a way to override this safeguard.

Yeah, I think that line of thinking is going in the right direction.

It is not surprising that these non-core features (read: as opposed
to really core features that were already considered mature even
back in Git 1.5.3) that had many years to mature still has rough
edges even today around corners that practicaly nobody has touched,
and we should not be afraid to round them further.

> I wouldn't warn about an empty tree in general. But editing a commit
> that is a shallow boundary is something that I'd agree Git should warn
> about, if not even refuse by default.

Yes.  Committing an empty tree, whether at the beginning of a
project or in the middle of a project after you fed up with too many
bugs in your early attempts and want to start clean, is a perfectly
normal, if wasteful, thing to do.

Thanks.
