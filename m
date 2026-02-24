Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6868D2D59E8
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 08:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922473; cv=none; b=jDCTlET723baSNOoSwU5tQ5oU30w83rptxIKLUs6k5TSYKMZmfHJdFFayzQqbOD8gCSsGh58qduMrnn9aFPlZhZ9CH7Ei6C7xZy0ML1yuwBp4W3dg6uzpHxdd4iCxLF3Opi0/eo3C0dtd/YXu5tCe+ZfDo5iit/pERALpZp3s2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922473; c=relaxed/simple;
	bh=+U/FaeJsiuUhKng7lAMTcU54WPfIY93IfXgIXBvQVoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2UrU0QowR/hldk7df3+YCQvwFOn1VQLXsdQ4Da2uw54oWI/EDGkz30KLJmKtHhy4l5skR/3k5rIjYylVUl6d3Gsscj66FMdN2X+BskdsN6Hdpm8Bo1PKyHVSwGXFrcsAWhGJKEeBq+bZz77dXmCyc63MQ93okbKGeOOwIibxEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RFqKQdqJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VvZg2fwQ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RFqKQdqJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VvZg2fwQ"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA0FE14001C1;
	Tue, 24 Feb 2026 03:41:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 24 Feb 2026 03:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771922471; x=1772008871; bh=mpTVjPA5rF
	HJf/j1WyAGl5ktCP1qM2HCrKvO6kpxy50=; b=RFqKQdqJV8bMYFyPviBwTLnR9u
	gtpMJtNK3QinS1PS87j7ZHeqMzdsRkLS+wL3kbwxJoG2gCjm+EoXvf12kzc/Y2Ip
	agViOgFNOWyhMB0dckWHx+kqS0ENaRfIMyrTaWkDW847t/jzVAqk8slRHQCzndpJ
	mEdegYgJI5sq9dYqUec8GgwRqkwG9hfSTF2MpHheQ4/Q9+xS04xiCpapgZfX3CR4
	TrKnpG46ZatvyrdvfmhAw1OvatMhXrVsjaJXHV6zteS1T7Fcvgr7Xw7ID/lv4dqL
	xcvuTPjhehmrcaoZ2qnpOkhBwA2qt1qapkLH+iDpA1PX14zNE0zox79eZ6sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771922471; x=1772008871; bh=mpTVjPA5rFHJf/j1WyAGl5ktCP1qM2HCrKv
	O6kpxy50=; b=VvZg2fwQ/9txfj5hz058XYFJWvRlDBs3hzl3N4FzJ1OGVvjaMTT
	uHS6kMMUHXUidtKex/Fjdu2xIb/babxmLdrSu52L1fTHw5PBVJkcvfZp70dBJ4SA
	A82e6AQ5ZxPfmiSdbsNjZcGiWIlIp406BnwrBI34+cgqFS0LqQkWEtIAYtL+eQyT
	kjJbsJHyM1mR6YSwx3oVD2SHlUU6HMXqbFZgMYWueeINcOFwYOUGi3eX8eAFb0Pa
	HtEtG0+jsdfOzHinASvbbBs7Iz+dhbIrVaRh0ghNIzjPULopxnlkqm1X2uxrWePe
	Csdu9DI7FzWONVxzeYfSQTGreiHchFhEe9w==
X-ME-Sender: <xms:J2SdaVbWyjRHVCOrePYUfHNmXFN27WmBK0gOmTRRR4-ZnY3LRk0qkw>
    <xme:J2SdaSYmyro1eihsgziEoAHoRsroX2CLP3HybYRBOt3YR8a3X2uPtnkypTjyN4lLL
    hn2mrK6v5GuYT6_zxfd3pXo06m9B3Eo-h_zczPH1QFpwp7U03mdouY>
X-ME-Received: <xmr:J2SdaVlYqXlClh5spRlOYovN2DkfaO6k6fmzb-2RS7k6S3nC_tS00-jU3sVj2hKe6ns7wXUDBfSmki2Ict_JhuL_ygqSXsBnfvuXEPxauVxvmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeljeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:J2SdaezcYLrq8hmjKu67rwtRWpOJs4SaejoNXC-DMxWYa3lIjyjSmA>
    <xmx:J2SdaTOWEJ0tk7s7YAsZpaqOEcnPjT_gMf_ChhrhB9xAWOElVv1WuA>
    <xmx:J2SdaSSxnRUAY7SK45-xEv7G_MGp9V8mpmIEnHFsQXmd2mamP0cY8Q>
    <xmx:J2SdaRZ3D0Jj-iaoGIa0wGCD4lq0Ka14dBAiGA0OasiI3u0TToyanQ>
    <xmx:J2SdaYzH52JtmM7QNMR5DYB5eg3qh3iaZ6YIS8_KburTykENVefrfeze>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 03:41:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c6a29203 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 08:41:09 +0000 (UTC)
Date: Tue, 24 Feb 2026 09:41:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/17] odb: make object database sources pluggable
Message-ID: <aZ1kIib-CaeOHGSO@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <aZx-mrdbZp-7VZfi@pks.im>
 <xmqqjyw3ktns.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjyw3ktns.fsf@gitster.g>

On Mon, Feb 23, 2026 at 01:59:51PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > I forgot to note that this series is based on top of 7c02d39fc2 (The 6th
> > batch, 2026-02-20) with the following two series merged into it:
> >
> >   - ps/odb-for-each-object at 3565faf28c (odb: drop unused
> >     `for_each_{loose,packed}_object()` functions, 2026-01-26)
> >
> >   - ps/object-info-bits-cleanup at 732ec9b17b (odb: convert
> >     `odb_has_object()` flags into an enum, 2026-02-12)
> 
> With the above base, [09/17] fails to apply, as the function
> signature of odb_source_loose_read_object_info() no longer has
> "unsigned flags" after "int flags" turns into "enum
> object_info_flags flags" in f6516a5241 (odb: convert object info
> flags into an enum, 2026-02-12).

Indeed. It seems like I mis-resolved the conflict that happens when
those two patch series are merged together. I properly resolved it in
the header, but not in the implementation.

The fun part is that this compiles cleanly with Clang 20. I would have
expected a warning here that the function signatures are different. I
tried to play around with -Weverything, but couldn't get it to produce
the expected warning. Oh, well...

> +++ b/object-file.c
> @@ -543,9 +543,19 @@ static int read_object_info_from_path(struct odb_source *source,
>  int odb_source_loose_read_object_info(struct odb_source *source,
>  				      const struct object_id *oid,
>  				      struct object_info *oi,
> -				      unsigned flags)
> +				      enum object_info_flags flags)
> 
> Tweaking the patch (e.g., "unsigned" -> "enum object_info_flags") to
> make it apply was trivial, so there is no need to resend.  Hopefully
> there is no semantic conflicts due to confused bases (the result
> compiled and linked fine).

Yeah. I'll rebuild my patch series on top of the base that you have
constructed. Thanks!

Patrick
