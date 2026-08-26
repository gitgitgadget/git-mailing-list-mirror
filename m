Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3D03B52FA
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 21:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780247; cv=none; b=Rju1aFsgKRrcFnPFP0Nki5i1xhjmTdolF1EDub28ETI+RF+4Dndq9+Jx/BK2B9y5O/SK3Cms5I6CAg2CcPsFh14/SbWTPyLajqRFSoNju0RllZjjt5FJKwyCYv6Rv4e2NVxeXnvB7KndXuzwMDyuVNrJyLcBWrqga5Fl2L29J/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780247; c=relaxed/simple;
	bh=aLMPVx03+Hr3/Di5evCeWIMwwRpnqCAR8K5RXTfiK5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cEBG66DMZtUq2fEai+A2mMdwDNW0N4UB0eaPJuj1mWcIW4vO8V05RLaEDg6hMOq2Ik07Iuj384h9WMgf17fwNJFn37PgOx5O9+sO4Ivd4D4y6UYcHXt92lkwu+DLpXDq7ECQmTfpZ4la2HIJz0AtTrtIJBMVQ3HDG3elS2xV8Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iGZN8mbC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cy/PdGmc; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iGZN8mbC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cy/PdGmc"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 79ADD1D000C6;
	Wed, 26 Aug 2026 17:37:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 26 Aug 2026 17:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787780245; x=1787866645; bh=aLMPVx03+H
	r3/Di5evCeWIMwwRpnqCAR8K5RXTfiK5c=; b=iGZN8mbCXReaVP5vn5eZGLqT1H
	2Oo3Xy9PiQC652sSGp+O4RANTC7GhFt4V3zAE3lFkXUcDOCSGxEOgZCX6Qrm/tL7
	7RyrbZB8Bkal0I4T14QjNzs4jWShXFYGsDWDZyi7w6++i269mhwvHvHXGFFwB3i5
	UP2hYw1qMInU4eKFpLsTgXWqwVWfyfCYIckUjxJOrHithRm6dEAf127st4+w/JuK
	my+1PuhWKPG1Z5nZX9urdy54oi5+pbHzllBTfaqto4RWIk7PbDXGiflG3YjO8wEA
	0rE2204HN6O5o9zurdXzW4y9tIeP1uZsHQSve9qO75LmRis2Eoiu4jYrz7rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787780245; x=1787866645; bh=aLMPVx03+Hr3/Di5evCeWIMwwRpnqCAR8K5
	RXTfiK5c=; b=cy/PdGmcRn3ycz30T8qc/xeugDbwo0R+VI0w/f+4+aR5Q/8jZ+d
	CdbrjQI/B+6VX5NRy2Y/VgIDIwg+LRt+55+0vrhcUgYzEv5e1rxGw9NoNYHpe5Uz
	CJDInMVT1BdS47MXWJ7WmESpweOwXNH6rlLUndQyTGXSqouxnF876NGfUZZYiCJC
	shxv3k5/b1Sy05GhW49eWlGySMdAchy8/Z4KOWs456svBJL+e+H04SqyJr2Ri/kA
	KgVS8wYLbGE+KkjsGMG/vuscU9S4nEB7aYwKhqiWeI0dZ3ZOkw5lh6KVzWa/jG1H
	ZWEgx0BWzRlQBZ2MD8VQ2h2I0A0f6vuXCrA==
X-ME-Sender: <xms:lVyPalsPhxPp7CLlMTPGlsFgjpdmelP0p2wUtkjIkiaUE0THba9zQA>
    <xme:lVyPathGmkjPlCGhcw1s382PV3uzQFoLLCgWFbQp9Ju_ncGk_NmuAj8x-sEXzKP0W
    _z7UR2OwYSKffKOS3K2xXNhBfX6EsodnDfapZaADgUCKsSxeoqD>
X-ME-Received: <xmr:lVyPau_3ArhsUpuzepK_7f151GEHGMRhvK2LcqnopoBJ2mPSYj4xqtL0rAhOOf3qk_f0yEbRJlLLYrJfTrzCdA94vyREwjcS1w>
X-ME-Proxy-Cause: dmFkZTEh4KtsNUdLTYq2fAsT8+HvKkOoMtg/zucjauOZZr5nAGD9dk/9ge4J3klAVkpn0g
    +22L9hbfOroBI/9thZzUW4v/ysGBGbbwEaEZrihDlTohHHj3ZWwPA+wLaGY7/sGvMUg7Gw
    eni5Mapkvj29et0Dn9UygF7X+UdFJEvXdxwQWYy7FI3A7+YB2O47F77HPq5CrfcUiWbG61
    RgacCbFvzAyAvsCOT2J3TeduNFJJSn7R3gPhdSqZ0gqYkdtYZ+Ix/RNR+62twdy/7cHcPw
    h3cAVjdANhLCAhkMMnwRYOAEtPALhoNzLK3ICuthndE42KFHRXVGWpbv+NgjAOAxa83bNO
    D+TzF2/xCXcHPAN+70MBUjlVaD5hzyOtKWVEpDMieG6Hsy5c4UnB3g9jSRpe0V+c4rb/RY
    pLLGQJ0tEPnVHm7m4/QNNopoKEvZe5RCK6AnuStjwsHzucWgPHvL8uopOSXHbYE6TfuFnE
    ENjd46d/MOzRbumJWc7knlu++zSWjapeRXYg3SLQd/JrPMM4M5qXcV7APZTBqt0irDbD1m
    NTXEl5ltcGHun0DsxI9PT61M10d7GdwQP2uDiQ/sqEEbCmSL5e4mB8Dg78QiVOF2vi4aOx
    87qfqcvQNHCEeeVqVS6x8VpZkXC8tBvFtiOh93PRDm7W2UfwYndUYXXDKsEw
X-ME-Proxy: <xmx:lVyPaotoQUuTdH-lYMiekx94X3On2dCaJRwOym_qrJQ82T8w72N1uQ>
    <xmx:lVyPaqrzKOEYknE6xLZ6j77xGA9hpVeE_eD-4klhRCdplUKJ4kPOJA>
    <xmx:lVyPakp5ypZQ5pzMtgLceZckXV4QIf5QHCjQLJ5BiVC6BMHSSYQsPg>
    <xmx:lVyPahZxKZxNDPwxplx8T9rEF64fRajmNXOnebSbNTRmKUCGxsWHmA>
    <xmx:lVyPah_UcK8mEz0Mqx-vIf36-_fmhbIUOB3jfQQCvhdqX7aOuYMA5Znq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 17:37:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <ttaylorr@openai.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,
  git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 3/3] midx-write: include packs above custom incremental
 base
In-Reply-To: <an4uIQA09rDCwwBp@com-79390> (Taylor Blau's message of "Thu, 13
	Aug 2026 15:50:41 -0500")
References: <cover.1781294771.git.me@ttaylorr.com>
	<7bf7c87b60532a90c04c4a2404449a9d8ea21214.1781294771.git.me@ttaylorr.com>
	<an2FAWvyfX2LuGsG@pks.im> <an4uIQA09rDCwwBp@com-79390>
Date: Wed, 26 Aug 2026 14:37:23 -0700
Message-ID: <xmqqtsogd0mk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <ttaylorr@openai.com> writes:

> `ctx->to_include` can indeed be non-NULL.
> ...
> The filtering still does the right thing: packs covered by the selected
> base are excluded, and the remaining packs are checked against the stdin
> list. But the comment is wrong, so I'll fix it.

Has anything happened since we saw this comment on Aug 13th?

Thanks.
