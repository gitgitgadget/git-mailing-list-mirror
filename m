Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CE51E9B0B
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754000175; cv=none; b=BQnXvi7k2n4kCPEkeUjhY2+YXdf/E/9bjbypZAEdmCGCNjnqoEx5Bu0wAxZf/NoPhUbDsWMCIAkB7geBpf48Ar6/LlX6NFbKqG5+36rVvsJDPS9bdDAQ87WdKvtFJMnyD+wGz6gG3RpUdgejMpU119Zc0gvwpsJAvHIG3tBnmvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754000175; c=relaxed/simple;
	bh=8/iic4YlY/yYvooP/029yBos/Nz5aNVLNS4DezOr/Rc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fTFQMODQU+9Uy9z+bVGduNnXxMq5GijJL97sXfylZ+KyuxlotFJUAhH/zyhnciuyOX3zx9eae4KYFGyABIDsIib0QW4m4FNEYQZ2emVMlY/sHXZ58jDuPTaKBkj6Rhk3zO2KGclk8tVjgcWjT5nINx10jmAM0qHwv8WVuS4DZVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Jwnj0hnW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C8E+jQmE; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jwnj0hnW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C8E+jQmE"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1246E1400276;
	Thu, 31 Jul 2025 18:16:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 31 Jul 2025 18:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754000169;
	 x=1754086569; bh=UaLDWSjpIe3dW4WM54wNsPiYo/lY9BCcBkkvW6vrk3Y=; b=
	Jwnj0hnWY+1sx7Xn7O8cFNQwZVIxezfWjmpN4Q6Jw9aC4Wk9+aZs4SxlL9ZEjQYy
	qYxWV7rxqqQih2ppCAjxfZXQyUBZTtezCbMXEEKJsfa94oCmL+yb9f5v+fP41+Ht
	N9uloUYhPz4dTtn8FY0jOtj9nIyR7eschKGAeOlcTxfldXrbfCWjRIPT37968Fwa
	zyEAz1ZJwdfrCNL+ZcrAtozGpGGOmPvYi0gAc2GygEkmG6txBwiv7ugy1cwgRLmm
	Hd50s8G50pjBmX3vIz6Qja2z+LCzR1sKgD5C9eA8Bd6+TXSSo35DUcflvHx1CFed
	5zJvWIQhk20LLnF4YwBD9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754000169; x=
	1754086569; bh=UaLDWSjpIe3dW4WM54wNsPiYo/lY9BCcBkkvW6vrk3Y=; b=C
	8E+jQmELLjb2ti7q6mzlVIMGA6k8beuC9zJUTpK+9hoRlAC3TmSa6aKWpK9fTF9D
	1Y0HzO01ucsfuxEFSLlVbR94cJpU2OcMrJxWw4KMvMPsVOYzoJ4XW8jFkW8yNUnw
	bVpjPFq446nVDWaQxbYijKf+w0NhdVjkuMxOZ2dsUct4zKtHRzw2cKeFT7im+sX9
	f8pjjo2b9k9s2vQ1hB4i4bMeY7JJE7ohO5nGXZZANQFNfwOWw70uH36footSOrGf
	3+ZsxhJ67yUUftWQH69n9cgGuSXS5n6UPHdhdglOCA6fU0sqJxH6uPAJmnMghL+k
	j79F+F4oWPyzQIVH6LtqQ==
X-ME-Sender: <xms:KOuLaCqJdIXNGkhkfSWSVH7hH7LUjb3AbLgzUUm-DqOpis0SOQkOCQ>
    <xme:KOuLaD4rEJmQxRAgEWqNv9_6hFmZukI-LbXZLfFWAKDPkOTpY2rvxW40fm2qJ1Wqb
    fzixSqUGeLULm_tDw>
X-ME-Received: <xmr:KOuLaAqhrjzlBIDnxWAY-fRrE2wBzpxxB1lZPLWY5b1BAQgukwWhsAhKq4JYlU63T0NKyPdyBBESq9Sj8I3DfLl9GBa9eXXqQGmuaUk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdduleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KOuLaNgIo0YT08429sKU1KXH8gxfFmRzkVekBgGDapiolwzh0lChig>
    <xmx:KOuLaCJVDg-WOfWzscypUTpv_x4aPFVMFQyWLQBfEH-NkTMCNhOsSQ>
    <xmx:KOuLaFDVwa6IUuMUv_1nGiaDIz4zR1CgbJPR9f_elR0-ZF-AI9f1KA>
    <xmx:KOuLaKhzHPev6YfbRQ6K5GjHBGPUq0Ph7UQiKMQWIs7qwoSKS4wHfA>
    <xmx:KeuLaBIoVgOMkiRGpcNjynobpsjNC6FOqokZvcO29DD5GGR5IlanFSJO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 18:16:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] string-list: report programming error with BUG
In-Reply-To: <CAPig+cT9tBSo1od8iuCf+88rvDO9GEikKm38WLcXHemM-emhOw@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 31 Jul 2025 15:33:27 -0400")
References: <20250731063949.1601669-1-gitster@pobox.com>
	<20250731063949.1601669-2-gitster@pobox.com>
	<CAPig+cT9tBSo1od8iuCf+88rvDO9GEikKm38WLcXHemM-emhOw@mail.gmail.com>
Date: Thu, 31 Jul 2025 15:16:07 -0700
Message-ID: <xmqq5xf8ovko.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Jul 31, 2025 at 2:40 AM Junio C Hamano <gitster@pobox.com> wrote:
>> Passing a string list that has .strdup_strings bit unset to
>> string_list_split(), orone that has .strdup_strings bit set to
>> string_list_split_in_place(), is a programmer error.  Do not use
>> die() to abort the execution.  Use BUG() instead.
>
> s/orone/or one/

Thanks, as always, for typofixes.  Not just this step but for other
steps in the series.  Will use them when I update them.

