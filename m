Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E929041D62D
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164659; cv=none; b=mvKMukyeQk0IRlnV+zT2xmBXmI0gZ0wDUTyivW5TARgcMpRCq+yRqGXDkZxqrJN++GhGu6JuQRV6vHd+/nOGTc5RVUMRaXq3g77pcrTYScEn3LZ2UmMSbiDCCwQLq/OLTWT3cvE6/oEDuLqKYIrfASoswUGwJQntRznqGQwPzAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164659; c=relaxed/simple;
	bh=0kV4yPOMhIKyXNrNVZMDJFHKH65tdXaR4OFbFQ1SaD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SwEFJWa0weo/o177JRQHFqKdVGlCQp24VAdWl3uYYqdLbNPyaYKWmXa6r4U+gI6YYMPLKqjdsLNmp2SvPpJF0713ofJJHINJtHyixNpIT8038W+EnWhfZsAikMd687+UH5rtv3TKrGSr+k88V3iRyyZXH8QBZid+No0+UrvtiuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EpDrJzSm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oTAeswy7; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EpDrJzSm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oTAeswy7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0D0AB1400143;
	Mon, 27 Jul 2026 11:04:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 27 Jul 2026 11:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785164657; x=1785251057; bh=E1YV9x8Q6v
	kk1ykn5VRUJx5ppzHsO3oGks7AztjzSTM=; b=EpDrJzSm28MG0BMpVKFfTUfk+I
	4u06/h7Ah0yd8c02/MlwpXNE9ZfcM4ZnXP4YerrjHo0CsHRYAihuzJ+RiK1iro4n
	rYkmc5oB8N4ic+b9r/ArWG4EEu7yTHwCtbZ41X4SnwzcqHr9JA7ov2DriYtIwGYn
	5jf6kap1YfXJqGVwKHCFChX22lEeg86rnQ3HIQQRb7C6kEQMyXwrZAkB98ZPWYG/
	9K6+r8nyCYupdw6OeGqU2RYJ/CK1TPF6TQa2RhMzSPWkwNMd4+KmslxAThK95NhR
	LDt3t5QKzNm4G6HzCsuLLezbkO11ae8c+gxBMcXTZqNClGxQIAVo6C7MOoqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785164657; x=1785251057; bh=E1YV9x8Q6vkk1ykn5VRUJx5ppzHsO3oGks7
	AztjzSTM=; b=oTAeswy7lG50YsHOjOBW87rZmXsHUrCVfU+j88Pt0HZKyNRJLBr
	iy9T0karX3C5poVRmw+92zIUKbiSkSdLeLxex7462Am4MBp5rayZPcLsPR4hJkmE
	mK+5gGFDWfiSqRWXmAAy/XVHD1isWRop+4ia57ejTmClxzRZIu5lLM4KsELaIHnA
	b6MlE4v+ynWJoANK/mCINKjV70xWgdpp00clKj45lagVWIkDvQd6w0GARqDEjztz
	11CQ/BMAs23uV+aHAbq4H9XYE7JUGV5kFA8qp5oZjxBekRL7g/brPaC0WzGIGKbn
	v6PNrYMwf4lZhqfWgIYLF4WX5sgUR3U36vg==
X-ME-Sender: <xms:cHNnahoLpFcnu3X_QUyU4R774V3JiDAClZtDlqMSfkub3RJ2BGPrQg>
    <xme:cHNnanVXO3I1g-tO-gi8An9foUjcAGjBQs2YRQ6NRMaWsPIILAvTMzJWh7GpfW2B2
    b9tEr63lCooc-H3uoe-W4LXal3eC73BOdcJ90Ke0vgLOFRh6EGwNWU>
X-ME-Received: <xmr:cHNnaoC1dlKjOYGe8Fbw4gJO_VcTIggWxHE1nCXlD2tgVuokoQqesBaG_nMM5cUxHkOuFjEqDKBAl0dl11rqYRMuZUVJmj5qlA>
X-ME-Proxy-Cause: dmFkZTEgWey2mvVh0Db0AOKsXvy2GovM7oJS86eSLo69IEQqMCI0e5v7SnjQfaleEzkH48
    0fC7Uz5A37EzsyeJB4sOK+T/u8wo+AfTIiN6Gv7CZrTtJPLgTpmdPVzPtn7tkQd0K+qjj5
    hY/0X5QTucW1c3QF0mdHvSEgkGWDDz+pyh/EPC2rJUURk8qh3+U92GIAHI0G8OcY+OTMHJ
    ZKK1VWXzVh6AF2KpV/8bw/qcREaG6ZubLl8B4HnlXb1WrP/RX+CeaiBJjdpS/M02tj7kQ0
    35/rM8lOIUMYysH/uNE+Euv1i50i+uU3bmXdZqKNXjWPLn+KAMlspJBZkag846rR8MxbT2
    wioCcehzgQGGZIPlXF7rTf0nMWcWnNsKmfikcfM9WJvPgH8K5A3R5jerQYH3zMB3TAaUEa
    VCwG0F1Apt4VXr+ZmSUrjE8cdVmJU2H7ASacVvXFdnq88jttuvB2j9PJglGUEkucl1j/Lz
    wAjUaZbgcOF5Vtn2hfZb187MAuYBoRq2Z1ukYEPeQSdsWZ3iQc5ukDS6G8+7Iqo5UlToM0
    2vEWy4uMoN0wUeHHNnjZl4LphmTif7JPdJJrHNaDamrgK4juLUCHU+HyTmJxZGcdpa+Exz
    2Pug9sSN8cp7fjN7J18ejKsTrBM2TxexFAiXsy5EUoqetwMrymVn5Xt661LQ
X-ME-Proxy: <xmx:cHNnaj23iflq7uuPCAAaAwwehS0MHUatK-IDZ1N3WBeg3EqyImrYhA>
    <xmx:cHNnai2i9TIvajpInTWCQ2GnCWXxmkU7uABdEZolrbvat48XSzAaPw>
    <xmx:cHNnagCa9njEEVNq7ACiT-Q2lI58ERUcz7pPx8WVw3ih97qabvwYYw>
    <xmx:cHNnap4IZBUf2YjiVCcllBowpxHnybRa5rsq5uZqS7_FfCvUhaWFeA>
    <xmx:cXNnahFWqBLdKJDW8ELVTDFpbdG18GJTlMl_8jZJyo5t2Xg1fIA85vp4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 11:04:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC PATCH 00/10] repack: combine '--geometric' and '--cruft'
In-Reply-To: <cover.1782500507.git.me@ttaylorr.com> (Taylor Blau's message of
	"Fri, 26 Jun 2026 15:02:10 -0400")
References: <cover.1782500507.git.me@ttaylorr.com>
Date: Mon, 27 Jul 2026 08:04:15 -0700
Message-ID: <xmqqwlugo4nk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> First, a short note. This series is an RFC because I have not had the
> chance to review and test it as thoroughly as I normally would, and
> because we are deep in the -rc phase.

And a release was made.  Has the topic had a chance to be further
polished, or did it turn out that it was perfect to begin with?
