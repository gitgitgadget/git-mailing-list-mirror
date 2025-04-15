Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E8B20A5C4
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744729777; cv=none; b=L9TkLflpKI37J1Ro3UAa4RNyOJTc4jIFHUu69KgHM4phDd85gT0aZZZv3uNxxCMW72YLh4YUfI3It8favenG3aaYFVjQxwtw+vRWiBItUsuVvQHdZIluApTQ0f4gIY6XX0nXcr5bgGpdqfYWIRQw+JYNX//9Y8RZ7m2u6ZmJvNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744729777; c=relaxed/simple;
	bh=r01kpXI29ZQOZ/OatoHWfXXMF8A7d8Voxr6xjAHbPN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wc+zJZdUu13mTMThHGXqJBSdgHczpDataccn/IrtOcSaI6P892E+ojiMY1bi/D5C0+fLChnu6Qn8hCDs/ZqBaUz2KUWliBvbGJWH2UpkcUQkeD0YHK3H0OYRc03TU24SO1birZGL3LfDLUWC2KYPJ5lx5Q/oFQCyipCzC5NhaeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GKCpXVTt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xpcDzpy2; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GKCpXVTt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xpcDzpy2"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 555ED2540169;
	Tue, 15 Apr 2025 11:09:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 15 Apr 2025 11:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744729774;
	 x=1744816174; bh=9TqGAAkCEV91QS1Si/gWneVLHZocNzu3QCXXUOHCOHs=; b=
	GKCpXVTtclaegCfyCJ80eQr13iThriM11nph634ofk5OOwz4F84tSxJ2JbnaQcOc
	YnX7F2LZUWTW6EwZrLvxY5pvCAXx+/MjujJ1TA42sVw1g9Hk9q20nxJD3kVKJeg6
	V2KEXPNhnJWnAiMWx705HhSb1OxIHbO+XSdyIvTqK6a8AcAPxhVoZN9ydcB50SD7
	LVCz3/ywC6Cnzg3iI6Hn8JmzFsFWMUf6jOAcjCbma6gdCi2ErTldN5EkzO8epyM9
	soA91hzt0wlYk8Hmputl8ziGchG0Rv7uvjeDm1/aErd/jVEGSOWrOzFHf3JXBc5I
	Rdm+3ZEr1PL7V24eFyv2Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744729774; x=
	1744816174; bh=9TqGAAkCEV91QS1Si/gWneVLHZocNzu3QCXXUOHCOHs=; b=x
	pcDzpy2+q+0WwyNNuRUwplLMsDXxIc8K+J9Ro8jUzhwgPfbcWDhV9R0+wrr4oQOY
	lPi7TCWkDtE0vBc5JlCj+JWvS6qPjN4/JsEPkgyt7RbofsCErNa7JOJV09+pnKvB
	1JcpoYlO/+VyNIQjpeyzijUV04VSpUGwU15PuRbQCFlb5rNpaWXwTY/fe8oetewm
	vzWEKoNXcm5GPF/auqYx18PIn7wHg7/7Pl5iY1mLW5OAZO/+mty9+dA604bKcAuG
	BRWRlq7saYvYzUWxILVpDE2lC5oQxln/rq354aYz9AoqgwSF5mFQyL7e2Sd+iMse
	Pc/3uk5EvnHuSQDAzE0Kw==
X-ME-Sender: <xms:rXb-Zyzh1ZcspKaxF-bDXJmEh6g-3orQUPjWEFCKrli26CsYOem23g>
    <xme:rXb-Z-SD5NL1xuQsqkAXw1AprmrDl-15vCaVHwu_uAElHYNUis9NseDZA3SoJIoJn
    LPQFOhS5LWsTXNcsg>
X-ME-Received: <xmr:rXb-Z0VYW1_87uAHuXO2CF77_hMcyJXgorE0pOwigtko6gLK3tonrlBm-k3CDX_rr-jU_6lnGW72SkiFsrbN3V_sC3TAVTkKJ4cD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnh
    gvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:rnb-Z4j_sSV4_ZPp4tbxTgOIPKCk1VHI8iIL1wwnWOi2irn39sEZAw>
    <xmx:rnb-Z0DBAbYidOjKMCYSMnuIKM2gNCwoFtQnZQ9RBfhTuLi5WRK9CQ>
    <xmx:rnb-Z5JkRTpfFyFz_VdRTWj_V5DDphoHT4lLq4iHqqNGpVOO5SyzZA>
    <xmx:rnb-Z7CPHO0WRVLzFTvDBxeioTX-qTSTQ9eIdisR-OHJ6H-qvRPFZg>
    <xmx:rnb-Z5KDqbPBNF3nCW1VYn3roxWFslJhQk7vMYmZtdIJyeqLfkTDhAbC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 11:09:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  git@vger.kernel.org,  Elijah
 Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/9] object-file: move
 `safe_create_leading_directories()` into "dir.c"
In-Reply-To: <Z_4klRXH1wwv7JXJ@pks.im> (Patrick Steinhardt's message of "Tue,
	15 Apr 2025 11:19:17 +0200")
References: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
	<20250411-pks-split-object-file-v2-1-2bea0c9033ae@pks.im>
	<xmqq5xjampdc.fsf@gitster.g>
	<CAPig+cQ5AEwTaK2LYkV39yrZppnF_MMMnB2V0nTGWZ-PcptVYA@mail.gmail.com>
	<Z_4klRXH1wwv7JXJ@pks.im>
Date: Tue, 15 Apr 2025 08:09:31 -0700
Message-ID: <xmqqbjsxo40k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Apr 11, 2025 at 05:29:13PM -0400, Eric Sunshine wrote:
>> On Fri, Apr 11, 2025 at 4:10 PM Junio C Hamano <gitster@pobox.com> wrote:
>> > Patrick Steinhardt <ps@pks.im> writes:
>> > > The `safe_create_leading_directories()` function and its relatives are
>> > > located in "object-file.c", which is not a good fit as they provide
>> > > generic functionality not related to objects at all. Move them into
>> > > "dir.c".
>> >
>> > It may be debatable that <dir.c>, which has traditionally been a
>> > collection of read-only operations (mostly for exclude/ignore
>> > processing), is a good place to host "mkdir -p", but it certainly is
>> > better than having it in <object-file.c>
>> 
>> I probably would have expected safe_create_leading_directories() to be
>> moved to "path.[hc]" which already houses functions such as
>> safe_create_dir(), normalize_path_copy(), ends_with_path_components(),
>> longest_ancestor_length(), etc.
>
> Ah, good catch! Will adapt.

Yeah, path.* API sounds like a better fit, indeed.

Thanks, both.
