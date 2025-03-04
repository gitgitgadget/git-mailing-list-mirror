Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BCE25F7A8
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109223; cv=none; b=CKftPTRP4/aG5J7/DB3grSVzB6RFql141FEAMJPGBn39sENosWrVYiP3k90roy0sSmUnhxEv7oztZy2hMSgZGK/FCN0shGTkthqWHA6w6Eew66MdzII40nXmF/1daG0K7M10h1Tsmm9KyD46TCDfA5Wuxti62y5AValNCcrZRdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109223; c=relaxed/simple;
	bh=JB/Puz6YIsJGkwGaliUWY4of+S8h+nYWuplPf2Dm8Wk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dV+W8PvPmvOdlN8k6ZXZMzX85mU/AlQEoxlJRTUBFZdRY1KK6efzdkjMX9cDe4HDQbuwkJUWoYjioTifUvhDN9/JUE8a74sh5fy8hV5hV1auVzv+3HUrKKc2luo2p+cqJ74fZIoRa6elCOmjkqLpRHRxGSy+sGDU49ccPgUORVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GpBqWcSa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OxrNyoqL; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GpBqWcSa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OxrNyoqL"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 0DBC1138273A;
	Tue,  4 Mar 2025 12:27:00 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 04 Mar 2025 12:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741109220;
	 x=1741195620; bh=B8q2r3vCFnHMpdLYUJvUJTQTQ4w8EzhAlGycuRquVO4=; b=
	GpBqWcSa0YqgMcllGN1AGcpfm+puFoekl8gGNkMvYxYjHf1wuET16nquUVwGOhTe
	NcYQl4RVLquh0ryYMMzYKSbWKpBpI+/dCDQ/77w0mKaya2a9icOzlw56iqMD6vdN
	/IpjGRp9x1XPtOvAyNTgH/CSclqK9XHkT+UPEbTsvIarhdqbLF9SB4THAKK7aaFf
	Wif1dviFZbKnvc2q4tXdG0jgUd8wImdNPDiQD9Qz6jNrpE9CP53eWOvTzcQP5Zq/
	3BeH0bO2zk36BMmOFWWfy1XpfEW0f2+WjX86aJCH398VtefIOFtDy8brQTuX4jfC
	DXMP5x5mXixVeXpL57UknA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741109220; x=
	1741195620; bh=B8q2r3vCFnHMpdLYUJvUJTQTQ4w8EzhAlGycuRquVO4=; b=O
	xrNyoqLGfnot2enSwdF8oXlVSSqgbKuj0EDXwEreEGk3oLwHCEYkVb/NzhHG5F9e
	WR/9LhEBmDNEBEATFKI31qoV40PP699RIfaJVqpbCRAjpIBho4MNBdmjrcctyMrg
	k1sDTdcChvTaximIDQIU8SwPNAdMdIbk6paIeY+EnWpgV6Um5UVqZ2fLc6i47/jO
	cZoJlqUZw9tqhApFiLF/Vpfxn1+E0WHXpFXm/1vS7yrqrxClglqfhUhga+Y/dv3B
	cDVPTyWA4N9kvEyCJH7tDLUzpXvUCZKOAiQIh7l4mRum17ntrvGrtuTwlEOdszbN
	01txHP34ucurRYRGueNmA==
X-ME-Sender: <xms:4zfHZ1Ooca1TaHM8X67FHhi61EYAFtV_x9szaFwW9BfaULLPAHgj3w>
    <xme:4zfHZ39ZGWUzxQC48zvIBu_s0UvkC9uUdhzG-uxvq91lRwM8JvXE46t21ru-OPIQQ
    dM9eKbV5R7rLl8X8Q>
X-ME-Received: <xmr:4zfHZ0SNp2xNrG6iUIlZdmkXMlKpYSOvUM-IJjv48lCgHJKSHjg4ZU2MplvGjIQOykupmvs9KlcOIU-K7PvBZeY6lGnta9pI6Gki>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnihhmrg
    hhvghnughrrgdtledtgeesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:4zfHZxuq1UPGYUmuUmV09O8EMZXQKuOVD1lNMCmMJFN8675p7lKyyA>
    <xmx:4zfHZ9dz9U-izCKfkvKAlwhbhKDG2Qb8eSmiPX3gFFD7zXr4W_JSJQ>
    <xmx:4zfHZ90YsE7L3y5jwbKUCcn0WVNVnfp7IviAsijyt4vdQDSchh_5Qw>
    <xmx:4zfHZ5-1qrvHAU8qkER8Aci3n1hPN6XtKgQ0L9EmFnzRcFaSYE4q5w>
    <xmx:5DfHZ065u4159D3ALIahycPIEKhhotTURrDpIzEEQBuTaVKDOs3TIDQS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 12:26:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mahendra Dani <danimahendra0904@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 1/1] t1403: prefer test_path_exists helper function
In-Reply-To: <CABGrwBAaN3U8WCtPgd+UjVjsoBniCawWV3U+WdKOzBdG5LxmAg@mail.gmail.com>
	(Mahendra Dani's message of "Tue, 4 Mar 2025 22:54:00 +0530")
References: <20250301105838.1481-1-danimahendra0904@gmail.com>
	<20250301105838.1481-2-danimahendra0904@gmail.com>
	<Z8WD2MeHpOH7Ni8A@pks.im>
	<CABGrwBB1-UiiPEOptN9csVP1WYg2X=SWeMxxiyDfz02VmDp1vA@mail.gmail.com>
	<xmqqldtlt304.fsf@gitster.g>
	<CABGrwBAaN3U8WCtPgd+UjVjsoBniCawWV3U+WdKOzBdG5LxmAg@mail.gmail.com>
Date: Tue, 04 Mar 2025 09:26:58 -0800
Message-ID: <xmqqwmd4r9jx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Mahendra Dani <danimahendra0904@gmail.com> writes:

> On Tue, Mar 4, 2025 at 5:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Mahendra Dani <danimahendra0904@gmail.com> writes:
>>
>> >> >       remove_object() {
>> >> >               file=$(sha1_file "$*") &&
>> >> > -             test -e "$file" &&
>> >> > +             test_path_exists "$file" &&
>> >> >               rm -f "$file"
>> >> >       } &&
>>
>> You may want to think about why there is "-f" there.  If we remove
>> it, do we still need to have any check there?
>
> Here, the "-f" flag in `rm -f "$file"` does not produce an error message even
> if the file does not exist [1], thus the `test -e "$file"` check was redundant,
> as pointed out by Patrick in [2].

So what happens if you dropped "-f" as I hinted?  We'll notice the
lack of file and the command exits with non-zero status.  So "test -e"
was not necessary in the first place, was it?

