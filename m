Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E738634FF70
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761680444; cv=none; b=rmCuR98CGZoJLeTSbm48xwqfl8VKOtgAD4Oucjaw08ygI1wreg5XTWbbZX1fwohXff0+y8Lm90XBgyz6sbTxALe1PcXCToZjYKRhzXua4dc02fOjuhRwRU1LOxkfx2bBh2XR/FsQbyO5ibvdl5EqFZ7FdfTvSZBQ1vJP6M8lXdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761680444; c=relaxed/simple;
	bh=itPkJ8diwitEUOT+WHj1+1guAwhCO7qrGttbkZMj6mo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=INy7qBvX2OWhxvO+cX4QHufztoG3Z8mLtBznwOtgXL3sYYbbORXTBmwMR5RlXRSTw67jviAR5S0/YhyX5Xqyb4sL6YmAoJ+Whzb120VJJWzJYIWojIIPARHPiLGtTz7YyOtqDPa17l9+1ps+edgtyXT+HJKvNa4z0seo2zzS6IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BZN7xzXC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xYTbIqFx; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BZN7xzXC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xYTbIqFx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0A9087A00BC;
	Tue, 28 Oct 2025 15:40:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 28 Oct 2025 15:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761680441; x=1761766841; bh=yTgDyVuZoV
	wr+4kZoGAx6UZVDUE2FVNI5eMIBFQkM3E=; b=BZN7xzXCJlSkw5jL7KKVsJcgH4
	EnztycDpNM6l+bTrbf87JDEgwwwdoo/Y46fys+2g0MOCN7C/HJEC5HR9MPLOILRq
	LfaWQqouoU7XwswBXZa936e5SIPal+6GLs5hR7GkWZTlsQPx5v4bFO4Y+v2toct7
	YBsJ37Ww1f0P4LT+3W9FeU4Z+XM4ebZpsCZIDAzItN+RTneL0DjlSxeeXGtYvThR
	XlQ+SOWJIDrqBPNB5Q2buEWf9oJcsxr4cIhSzYHA/xeiK8iduUM5y6Q+/Gka2agT
	P+0C1O0u8k2CIgh0OdjOqrxJ8GeaJ9snrkQksfcleNUKldRrSNKecyAApebg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761680441; x=1761766841; bh=yTgDyVuZoVwr+4kZoGAx6UZVDUE2FVNI5eM
	IBFQkM3E=; b=xYTbIqFxzLmuBHyEqCHF2W0cDIZbqi91aLu+BRCrnK1rkcHchaQ
	hQvbhi6Bxm5RF01Mu5VBJwK/uRWA43hFjP51rwEX6V/8XDazxSWCBFHAQ9W0+Ngw
	Gl5XCn+Au7OY72lLBfU2wx+06dZHyBDIjJrtHuOmEv31BaeIV55yc40GJc+6ROBA
	lBV7CTtPOwikoxHd3f8/NcAhX/n3JIJ13CkzLdpUxfSxcvzeXSE7kBzvxZRePkf8
	oaOzzUq4eGM1syovLts3VqLLSePyX4XtG8BhsX4rbHC7u4AMrozpVvSZW9kiuIJJ
	SZbjz8vS7Vj+t1m8b81NBHUwE961oYUnssg==
X-ME-Sender: <xms:ORwBafLoivhj9dIdvLNszjzkGxMIPtPMRCw2EtM_m4zdcEgp91QZAg>
    <xme:ORwBaaCBs1b4971KLnqzPjwHxzngOytX-XBul8H8chuR6Ng-6RVFvFJ0G0VdjoR29
    IAKxpLqjrAucaqCVZhhgkdins0JitBIGPWJMMhLCXHEYYigfBayDw>
X-ME-Received: <xmr:ORwBaQCEdhOnm_EEdIJha__x_tehSFFusOoIZG5wDSxG4NvRD4ZYUOjdg49m-6WGt7oJEko-3whJorTNP8f3dlhdRes-UHU9XWr7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedujeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieeuleffheduudffffegjeelffeilefhleegheeltddtgfelhfejueekhedt
    kefgnecuffhomhgrihhnpehgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgs
    pghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshht
    vgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ORwBaUBer_nZHdrAq_sEI5VAQpRyiwfVKpyrg8po-OWORtgj7sZz6Q>
    <xmx:ORwBaTpebnbyyGXZpIe5r0rrigUXRiqGSFDbqmc12QMnc7T0R8YGUQ>
    <xmx:ORwBaWmUGsMh4ZLCcIMyQ7kha1dSAK_RWwxKjQPW8JaxokBadli88A>
    <xmx:ORwBabzOrCh7UYwh20iYccT6L3a4vNzUB84FO2ZNsvUrTeUZhsnumw>
    <xmx:ORwBadTjJn1T8KYQvtSnkEatSB5R9JbHfyFsAbYiFDYWU9I5NAGfTz85>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 15:40:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 04/14] rust: add a ObjectID struct
In-Reply-To: <aQCKD--ZmKnwBWs9@pks.im> (Patrick Steinhardt's message of "Tue,
	28 Oct 2025 10:17:03 +0100")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<20251027004404.2152927-5-sandals@crustytoothpaste.net>
	<aQCKD--ZmKnwBWs9@pks.im>
Date: Tue, 28 Oct 2025 12:40:39 -0700
Message-ID: <xmqqa51addc8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Oct 27, 2025 at 12:43:54AM +0000, brian m. carlson wrote:
>> diff --git a/src/hash.rs b/src/hash.rs
>> new file mode 100644
>> index 0000000000..0219391820
>> --- /dev/null
>> +++ b/src/hash.rs
>> @@ -0,0 +1,21 @@
>> +// This program is free software; you can redistribute it and/or modify
>> +// it under the terms of the GNU General Public License as published by
>> +// the Free Software Foundation: version 2 of the License, dated June 1991.
>> +//
>> +// This program is distributed in the hope that it will be useful,
>> +// but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +// GNU General Public License for more details.
>> +//
>> +// You should have received a copy of the GNU General Public License along
>> +// with this program; if not, see <https://www.gnu.org/licenses/>.
>
> We typically don't have these headers for our C code, so why have it
> over here?

Yeah, another thing that puzzles me is if src/ is a good name for
the directory in the longer run (unless we plan to rewrite
everything in Rust, that is) for housing our source code written in
Rust (I am assuming that *.c files are unwelcome in that directory).
But it may be a separate topic, perhaps?

>> +pub const GIT_MAX_RAWSZ: usize = 32;
>> +
>> +/// A binary object ID.
>> +#[repr(C)]
>> +#[derive(Debug, Clone, Ord, PartialOrd, Eq, PartialEq)]
>> +pub struct ObjectID {
>> +    pub hash: [u8; GIT_MAX_RAWSZ],
>> +    pub algo: u32,
>> +}
>
> An alternative to represent this type would be to use an enum:
>
>     pub enum ObjectID {
>         SHA1([u8; GIT_SHA1_RAWSZ]),
>         SHA256([u8; GIT_SHA256_RAWSZ]),
>     }
>
> That would give us some type safety going forward, but it might be
> harder to work with for us?

Can the latter be made interoperate with the C side well, with the
same memory layout?  Perhaps there may be a way, but the way written
in the patch looks more obviously identical to what we have on the C
side, so...
