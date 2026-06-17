Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C1C395AE6
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 07:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681207; cv=none; b=W5O24LWV7f6sGI0nYYi4hj2JZmzzSzaI6nqOKISz5/Ixk7IvAFhUKxgXbGmGAaDay6gdLX7EXttnR8mPuPjPLEHDnBuHLnN/89RNKCImaC7NhD96VrXpwxoBw2lweHilqZ1r8JZHWhkfAYF96UpP385+T4pTYPS9kW8FD1UZJl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681207; c=relaxed/simple;
	bh=S8yAdr9z7BlPWc15iGsFMu1YnS57ygnr5e3+IDjHaUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqRST73hAj7Z/8Wn4SUze5FSeTaQ/bKWqIRAf7aOyY1jbD6QwjxzbNI8llYVtFYxPYBPxbl9hqKN5ecMdSrXzKFp8AkYfrh4Srj1grE4+7DddEMk1lUlB2U4+rX8bPMJRchgzL6L8iawwLvPE1DvVqi8Nnz3RTvKavDtt8/m4Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nrSbCC9T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GsLx8rjJ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nrSbCC9T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GsLx8rjJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8D2417A00A1;
	Wed, 17 Jun 2026 03:26:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 17 Jun 2026 03:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781681205; x=1781767605; bh=5YkiOrXGy2
	e9AoV/cHaGREEUccPMVq7cvPRk9iuT9sE=; b=nrSbCC9T8Pm2ZeetMJeABW9tp9
	NIDJXRW++93tPgbiJhgZFFh/gWGOgHFY6PHkf2TenLwyFfxaoyYU44HUleTCWzMk
	RRLCQxVZn1bL/JyfphT7AgDUycJwdHo/oZ3FkA3lWMFbw4W+JWpSvUPxuBzzvJD2
	FcGe2BGOLJq0jWEypugL1hUkboDrYkiV9tfInp0coBefCwNsmrO3fWQP54iWWAxb
	1V6slh7Yw9G6YPqxq7Dg+AZouV8af+SfEpXapyS0MfJpwcJSRjo3sV3bj8VC5dBk
	cYwwVlW86btdzjnrK5RCCwj5WATkdNZ7EbZFpA7j4iykQNQa14kTl8CPLP3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781681205; x=1781767605; bh=5YkiOrXGy2e9AoV/cHaGREEUccPMVq7cvPR
	k9iuT9sE=; b=GsLx8rjJxa8EINH2oIsUVXPpQKZ4iXsQ7T2aJHQowpIirEiWgX9
	tC2l3DL34mjaNzc5bWxW4p2uyXwK89S/Nzwz7ZIyOkyXIkuJstFwdSw5wRLHuE9u
	Y/xQa+ktqRxcPvXg5CQgmsguK1/nfBqfM5R90+z3iabniPRPnnM3OlqazLGNfFEh
	E3kOvNofxHfhF3R3sZv4S6DWQ+ejardoDkCA4vf/RR5D5w5qlqebofMycuyyFFhb
	DX961ajoyoGx9Mkhn2d8IzI5xkWZSbvzOdwCsiNZlsy6ZeiZiwmmgdN3ZOnlMTLx
	G3sCorErq4R9BJsjQ6IAwIw22TNhHWiAXIA==
X-ME-Sender: <xms:NUwyas1dlTzrbA3YdyEfJaZ_FgU-QzINyk-_YuoCwcOU19plolqhDw>
    <xme:NUwyaugVre7NGFvKOUanbtEaMcCn44IH3EgQZjJ0_s77DQOcTA4HMFyLcc2nO7YGE
    Z2WymL-gJM0_yOxVFIL7pzY5iw8KSK5JlIbeTWQs8VPbXie6C3ytw>
X-ME-Received: <xmr:NUwyaiTMvrcSM3FO7tmed83IZHk_oWCO0wSpAeZym5_wuV5ChoCsnDHRWOYHjf_VRMIq5URNgmWWckPdpqmBX7FdrxFDA1gdoIMS1Pw>
X-ME-Proxy-Cause: dmFkZTEGnRCB4ztLexk0VDgUcnfa1S8+g8T7EgsgNAYqoLyaFr9tbloo6W/JJfMqXlOpnZ
    0DazDDOwR7ybRepqjyy4OQKCi0vbQxIL4BB55jBdsWjUTRimpyxb+j6GandZjFH1NK9JTN
    gtcS/CI7XduDDLfZmS8+kh+XHOveF+2oWugM5OK9aujxj2nWR7Mz8CemK1Xy6zReaKI3Tx
    Cdoaqwf+fduybJbR7xDV6ycKVk6O0uCtQ+daWCHPUYjAXjgLdkxCGaGZBF3kfTpdTf2HdR
    UUsW+4rOIWoPbDwFwQqwhUj6vAcyxPcP9GzobLIC14f/y1aRjpZepQ3B9xZCubGNWgkOSy
    UlQmEA8llnwaU3JsDCiFRsCwv3zxf3jzQLzX2tWXGr86xz71wS8/BOyNQpiQLuUmuzasYD
    DE2O1R4Qb2eiL99+lFyJQ+qUuc6EYtllGYB0pSrJ/1jUYpKIUi3DwWWgsBo2FgU4hKx1F2
    Vo+z0mQA+GFCmjnmhNYbPqIdAIF7eJOkDSxpTeM64HO+yMxaI4Y5MJLajYz9ixxBIlHgBk
    Fngexa+eHsfzaAsxOPs+v0Ze8h8TZUgIKR8tRmQkBU7we6inGaQ7I3YBurIEN8qBvNmcOI
    3Dcz1p5RpmWNXuQgo0KoJxOCfnjCKnR6sDv+Hh5SzljWOQB36z4aV90r3R4A
X-ME-Proxy: <xmx:NUwyavjGn_lezO2xATMznafCDP2sVj4oi5eowTxOtPOr6VyMDwd-uw>
    <xmx:NUwyai4DzLwSQlkfgUPiH_uVLQQOidOuhIWebLN0Lyyb5ntCNxPFUg>
    <xmx:NUwyasAvsop64TssfAI4r6EL7U_A4twIzfCNQFefvUUuU-pNSJvpsg>
    <xmx:NUwyapbelxdDrUJ1xhWjTDFZ3YggzZizsxhITifNNVlV-6Fb_5kXQQ>
    <xmx:NUwyaq8MVmNyP1WARjU1Z6tlsYzLqiWDtVLSAfUGbVOBagegFPrKmIiG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 03:26:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f04525ca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 07:26:44 +0000 (UTC)
Date: Wed, 17 Jun 2026 09:26:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 11/17] odb/source-packed: wire up `for_each_object()`
 callback
Message-ID: <ajJMMQiCmV6dBfYD@pks.im>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
 <20260609-pks-odb-source-packed-v2-11-839089132c8b@pks.im>
 <ajHIjrQJvWtbCrZp@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajHIjrQJvWtbCrZp@denethor>

On Tue, Jun 16, 2026 at 05:10:28PM -0500, Justin Tobler wrote:
> On 26/06/09 10:51AM, Patrick Steinhardt wrote:
> > diff --git a/packfile.c b/packfile.c
> > index 42c84397eb..b8d6054c16 100644
> > --- a/packfile.c
> > +++ b/packfile.c
> > @@ -1362,8 +1362,8 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
> >  	hashmap_add(&delta_base_cache, &ent->ent);
> >  }
> >  
> > -static int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_offset,
> > -					     uint32_t *maybe_index_pos, struct object_info *oi)
> > +int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_offset,
> > +				      uint32_t *maybe_index_pos, struct object_info *oi)
> 
> Looks like we are also exposing `packed_object_info_with_index_pos()`
> now. Not sure yet if this is also intended to be temporary like
> `find_pack_entry()` in a previous patch though though.

No, it's not. This function is also required in case you just have a
single packfile to look up objects in there. So there are use cases
outside of the "packed" source where we need it going forward.

Patrick
