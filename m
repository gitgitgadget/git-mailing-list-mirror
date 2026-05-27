Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE45828640B
	for <git@vger.kernel.org>; Wed, 27 May 2026 03:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779852125; cv=none; b=NSzmkxa22E/4bziqWWy2SU7bpGfeJ8cBrDxKae0D9barAA/0tLqWPxQA8otxh3sfvjBJ/6N+TX/LQ1x7WQmGqBGnKZVU3ArNZaGLC6MKyCWOdAXakBt9pKDS8gT/3VFO4ywUWPM6h1PlWaPynyTbSO4yIb9P9PKYfl3QRV7hmFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779852125; c=relaxed/simple;
	bh=Ssmpdt92NzTdpjnhER+lvtWRN71yOFhTPnvPpk/bss8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cLmmE7TMTrQtZlq1YIfprOTD0ECc0ola4uiiYgSHwj5pQoEHRKjt5OfZRqt/xC+94cpINWybPzhKpaXxf5oAJJyczs4LvNP/2CMgZ+z/4afBB57/U1911YEnOaEkY5wELE1wThreTdlJX/1+QplPq/cdn0Jg6TE1wxP15Ac/zKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=txUQ7KFs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UD6NoOb2; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="txUQ7KFs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UD6NoOb2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 23C42140005F;
	Tue, 26 May 2026 23:22:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 26 May 2026 23:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779852123; x=1779938523; bh=uotVgIbgm5
	FL9nBHGjqrfrtZWvXq6aXY88NfDXtXaA4=; b=txUQ7KFsZWasOtMJ0341usFCFa
	uyHRP7QsM7OWhhBj9IxopOoGVRK+tT2s7n1SKXpIqp3rRCbS8Xo9zLGHADr0lFDP
	2PfxRGvI3j2d9D/iSlKoeALrL8RgTS+unGNtV9chG+p2RLkSY/gtrKqwU6vEJk/P
	fo4oibIhha1/ld+59sbRC7rBWFgkOoDf3x8jiGumvIAhBVzfYD1v8cqRMLgw4ZZR
	C7h96ro9SLEgDw0olLweMcK24/L4HzzBki85gGlM8IrlrWyQdhkIvYpX08iOokDU
	dYaatGKBNo0Rwfn2KjkGT5r6/GN0UnTgG76IlgrjO3mr6CNqZNduiaqqQDQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779852123; x=1779938523; bh=uotVgIbgm5FL9nBHGjqrfrtZWvXq6aXY88N
	fDXtXaA4=; b=UD6NoOb2VHhI8Tf/8mdHBsF/O1RkoPWaMoi09aWmg8mMCdFdr3H
	uyEn0PCvh8KJeuOyzwFOJ1UkQLdtZ79WNpK5mvuJ+iJ0nQ4g+1UGmXLvHfqP4bZ9
	8VcDUQl4pMsm01/Acr+aRz2GGgx6qlkSI2GDzaGhHgSZ+jgsEbyRv5+BFfkzun5N
	9SA8lTGTShzZ5zgjY8k8qwvnCHN+S6qKMk0g4YBu+O7lDpicRZButMFN4JWC7gGa
	eHMG6bmm2+DHzt2vH+4nWGfzkcvnQG5NWs2ejwvUdRvmHGvrBdr9rSoBkcMdeHSa
	fbkSEwtgxdpXlY6mblI+dH+Ed99JtlgLqVQ==
X-ME-Sender: <xms:W2MWaj4BtUIQCf23c0MVtaZOvPCUgjQL22oZoDgWlY-XJ9486qoReA>
    <xme:W2MWav77hVJZbkGBp3KRl5Bl1vCi35WsEuqEBvCUYXACh2eRTRolx5zeSnkXLw5Nm
    u0MDP8_iQDX-boggiICIbbyq09JmI6eLImyJAp8xt34Qbh4w5JZM-A>
X-ME-Received: <xmr:W2MWaveMhIPJAzoxraI9qoLY8GjGihkWDun3KpqB0YmSagAwBAqqINvC_qH1MOp0cTnrGZ_VcCzFoaraLgeOn-qO5q43n09oSAuK>
X-ME-Proxy-Cause: dmFkZTFsjLr3xN6bFXCqOe89ts3sKl+G+3Pddi6/D/dnAPau5CPfGG9p4iU3LQuJt/e8LT
    qPoQ396gROi1HxoBhq+nDQ2GmSe9bUqvDff1hNYmMsidnN7Kqa7pdQENJUmEKLjmk3PHeR
    5QQ63woLK1hoxX2w956HlbKQiGXdURT4kA976PJAfjd1ekqNOsSSg7/g20Utf68tOmhWdF
    8Ur/6C0Ff6gViDZE6Lgl2vSDUUBS7LUn7HqRnLgXkgoVJxUC+2UsuRzAaVlWb4+OrSgwut
    auHP3sOgnSsqAS2u3zDEBQ354Aph8XsZPYxAYGbx76GEAzZqfOk1pB3iMT5wG5LD4TCSpv
    jz590RC8yBgHQr6lO7Kcdb7poQgPAq1ZhkCkp0XLzRTyhuL+vKkZZ0e3nJyhbE/g2Rd4ad
    cdToXmHqKehUmjQSwKaZrgvXzBEY604/Qp2cWXIO085xcr+ZIeQZgeZh9B6uoPhUVSrn+F
    20stq5F1tqp/FzM106DygvsJXAxi3se9RMooq4CoBfuXEjie/cf0ZWMda/V3pMyop2g0+4
    RxDS7KP1xeJZvrOHHG9/WloHFEnFZ0b4+kT51aRFmSLn+zCONxlh0YjoS/pRe5Wr5fjP2b
    eck2zUi2AlNsOEwe50JFGA5REAyKXRD950M0BzCRpTqvPhDrD1IudFyzc9XQ
X-ME-Proxy: <xmx:W2MWajD96RQctcuTyj9PecWulU5fTeqT5ulIcqLcRep0EoBes75jsQ>
    <xmx:W2MWai8jm9Yg0moouyChYEdJFSaIJ7EADoPi5_14DiEk2KVCwD1n6g>
    <xmx:W2MWauKClEG-zv_P_cLqE_e0YeE0cp01Bg0LcJULuKpH6swJ4Hqvig>
    <xmx:W2MWarjZFYZUQnmoAr-Z9WaABaAnLIYznxTDyIhn4A0ynJUYwsDaoQ>
    <xmx:W2MWau_tJYcimfnoICQDtcwwD0K4ZI_qC3VjKUbgGlA9NO_DdNS-fqf2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 23:22:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Zakariyah Ali <zakariyahali100@gmail.com>
Subject: Re: [PATCH v2] completion: hide dotfiles for selected path completion
In-Reply-To: <pull.2311.v2.git.git.1779808987825.gitgitgadget@gmail.com>
	(Zakariyah Ali via GitGitGadget's message of "Tue, 26 May 2026
	15:23:07 +0000")
References: <pull.2311.git.git.1779590184752.gitgitgadget@gmail.com>
	<pull.2311.v2.git.git.1779808987825.gitgitgadget@gmail.com>
Date: Wed, 27 May 2026 12:22:00 +0900
Message-ID: <xmqqqzmxlep3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This matches standard shell filename completion behavior, where dotfiles
> are hidden by default unless the user starts their input with a dot.

OK, with this rationale added, I no longer have problem with the
proposed new behaviour.

As I'm not going to give a serious review  on the patch body itself,
I would really appreciate somebody more knowledgeable on the
existing bach completion code than I am to take a look.

Thanks.
