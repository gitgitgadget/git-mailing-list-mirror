Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C8B1F03C1
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501423; cv=none; b=Ud0nSn4H0gLN0iDtsq5jc34NUiypdDTyd33kIPeMOOjP0jqSePtHVUq1HwTH4YDcE0jmf5zI3qtgQ4KubUNkl7zPpao779LvmwE9W4lwsM2U+Rgx87oWPXWneRnXjsfwttC09+LRTph8LAawlz+wSp4O1ulq3GTIpKk6eUFD20k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501423; c=relaxed/simple;
	bh=ac2jrWnf7annd3aNHXGvD8/4UiQCgVXVDcbR18nZdKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k7emFkTlv7fcZyGb9OfQASPle+JzTHcGY17TRCGNqsOmr0WNgs/beI5gQaiRn5MwtRTEkfGDApRgYYGUNcBtTrDA/RaPNnMzNa31FSR3RfnJlbWzvJ4UTIcyc2dy1OHepA2SDcpKIVExG4LcM2JOwyZqvXZAmHFkMx745e4LvZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CnotLNI9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ucKmin9I; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CnotLNI9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ucKmin9I"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 7599511400A1;
	Tue,  1 Apr 2025 05:57:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 01 Apr 2025 05:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743501420; x=1743587820; bh=fAngqyFzcR
	LzCEYAu5L33Sxf5oIbFcbuQ1GQYskvdFE=; b=CnotLNI9g8w2o+oZymF4Or9YXj
	A9NjD5T9dM/opJe0Dwvu1q/9MAZrM8Vh6oHuj5mwSVCX5E7UleTXUHTSuzFns+zt
	Ycja7QY4HGzVTa+JCoOBf1IW1rtYjSAfDD0uITuumOwy3/qAf3j2oQRCBsBeij0H
	Vc1HLSmF7G94KQr/ziB9Nm7VDkpL/p3CT+rSp74NE1oq4mLG2kNo/Cwt2LnMqZM3
	f0DpewnMFu1wavSBZxhUu/Vt1Nie46hbIUaCWl+4swP4xDhuG5UV8uEFSDn9SUTo
	HaAx20o6CqM78pCMgsRjhzX0JLi2yEfMfJAO+0qSyDQPbsUiQwt6TsN4FLjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743501420; x=1743587820; bh=fAngqyFzcRLzCEYAu5L33Sxf5oIbFcbuQ1G
	QYskvdFE=; b=ucKmin9IZJ3s7Hf17iwA8yMoe1bxfH8xnmn0I+JlIPiD8qqLKBL
	1PUDpf2ye11n3whNuS0YCabm60fJ/HUBTDnuWUfUt5d1pXckw61RfS2GU55Ft+Ia
	DbxUvtyOh/+BR4VTAB5ikOEGwk/WIkjEtwW8l/kB/syrsuDF5qXqa3Oo4Uoz7A8Y
	DhRzL+NJWKWzwFEqZuB0nWP48vRUjVfRy1f0h5dEBKMOidKhpd3UTp5PmovQY0po
	X+KIBaUMqVkziFGA1x8NsCOaWKtBrq8oA5iv/LN2P1mQmdQSevgvN3/36eFHtae2
	YZyxtskW7e8NOg+5JFOvDhhFRF8eruvEHbA==
X-ME-Sender: <xms:bLjrZ4qzjGAhSupBQQk3G8rtfRK3rIwQpmGza7aQjamV8Z4efXDt-A>
    <xme:bLjrZ-qJZPzlzl--9fNVL9OOF2S_6h4lgi2_crRWlAUsLl_8jb8hSHYbNKvXgR4ET
    FBUNhMS-4w7rjuAuA>
X-ME-Received: <xmr:bLjrZ9NMz9ET8K-GxxUbEd8f9dn58DD3XASWu02iiUlsff-jRRQNQQlZl3Ewl2fRoHwn-WnttT1Jgl6-FMXPjpVFtlzxBtzH-t-pUAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedvgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehmsehlfhhurh
    hiohdruhhspdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bLjrZ_6zsKVWO_QPf_xKp-woUVjVjiAgaMqYZOGvHte1JqApXPGtog>
    <xmx:bLjrZ36bXrwtOura44rPlFPnApG5nuPNPlU8AiXeAnAjW_Q3S5R2bA>
    <xmx:bLjrZ_gEClG2pr5xDPPLCAhNi40MLZOhy92_AzyLlGkbzQPISAwcFw>
    <xmx:bLjrZx5_-Jiy2FIQshKODsZjLjZpVZTKzP601RfbfdX6UWlZaMaOGg>
    <xmx:bLjrZ62TQ2UiWsjlVnljlkfizK2OOlWnsAJu-jdoGvn9gf8xypxnoj9X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 05:56:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Matt Hunter <m@lfurio.us>,  git@vger.kernel.org
Subject: Re: [PATCH] revision: fix --left/right-only use with unrelated
 histories
In-Reply-To: <644ce9b5-755c-4faf-aaf8-b0383e12ff64@kdbg.org> (Johannes Sixt's
	message of "Sun, 30 Mar 2025 10:31:59 +0200")
References: <20250330055809.1019090-1-m@lfurio.us>
	<644ce9b5-755c-4faf-aaf8-b0383e12ff64@kdbg.org>
Date: Tue, 01 Apr 2025 02:56:58 -0700
Message-ID: <xmqqwmc49pcl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 30.03.25 um 07:49 schrieb Matt Hunter:
>> +	test $(comm -12 <(sort head) <(sort cmp) | wc -l) = "0"
>
> Process substitution does not work on Windows. Please use temporary files.

Also it is not portable across POSIX compilant shells (IIRC it is a
bash-ism).
