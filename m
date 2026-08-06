Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3CD3769EC
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037413; cv=none; b=VbTFslhoZSQghYQzzNTv908lHmP9DD5CsUzBuxLWEyFM0XEX2Mv+2dfidUl/ZFgsl38p3RyU2kWMXtPrbErw2P7nK1w6oB0ikx1zgARNp/b5qtHG8HRbIi5JOe/HfnxiitFWvLt661yRtO8CExGkNKgkqOtt2ZglYZKNSPW3cfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037413; c=relaxed/simple;
	bh=22zbkzIwPwvGcyYo+oq3NdO49O9Eh8dRHq10b/+vWEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PFt18H7hW701RnlEFutsPXWGdMeHzVEndUBSw/8tMFBimBTJXnpIEipL+LmwhOvQYLMuuyMb7dHbOMB+/HqLkU0Hw6BjO2T0/qfpFRKNERPiu+SH99wr/GPRV7qBdRl8hsVd2ExdEGY06n1Wh2jN+4ld44rsfAeM2Mw2aNB9PLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GVheQJb2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S60mHJpm; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GVheQJb2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S60mHJpm"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id AFBA01D000E5;
	Thu,  6 Aug 2026 13:30:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 06 Aug 2026 13:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786037411; x=1786123811; bh=Cnkv8tBctt
	x8mssv52tURkEEPNTesOtdP3+GLmYRjCw=; b=GVheQJb2CxvSwGAJ+wnLg89d7v
	/DMiRhaDpNyXBV19VYMFVd8gxZN/SSlDFMd2YZ0+A+mnXAgpGndzOmm7MNs1l3uZ
	C2rDOTrWCxJkO4G0I/qLRGn6VHPHRMvVn7YNmxcZlYDbZba02nmc6EYW8+AHA5kp
	UiQ09fLJjO1oYpxld72TQXYjjcNE61Fep4N5xDSjw3H88+4cYHEuvZ9INUeRKW83
	rhbzFSbKz0ZJz7xb7UzKbQEE8n1EYIS0xI93Awu9yGnh89VZyia9IjJAvNreINMA
	JoMXMf3vkVJm49pxpcwr0QlF2YoGc7I8TveMEKfwCA+Iu4dzOdSfb1ZArw8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786037411; x=1786123811; bh=Cnkv8tBcttx8mssv52tURkEEPNTesOtdP3+
	GLmYRjCw=; b=S60mHJpm7/qSNKy82pph0yTh3eAZpfsjPIb0sBUeZl0h8FnA/X5
	w2B7Npd1WEfaHOR0nWcsR04bdSbl2qlstdgrvUpm/HbR3NnzYabb8PYWta+mU/9B
	9pp59BDtfFjAczUjXQ7AK2rktKBjOU5En/Fk3NiKCj8SfHymyKu3x/bqIfRTalsh
	cX4YBVqy1Z+Fx2Bwibwj95yUZwVhcOQmOK6hAa6/6/lisWOeZA08AXF5E+3Iu6N3
	3htH1lD651cmftZ5/UDFbDPDazvGWGS9m3uhmBzQ6H3xnHkIFZ2GwxHDTijNRo+K
	ADXEBlbDcVzphAs7t+xMjP2lbfvF53RKMew==
X-ME-Sender: <xms:o8R0auPK4Tt95Ur2cQwoiaLwXJ9ESB7xGl8HvHmjt1wHpqGQ8QMFCQ>
    <xme:o8R0aj073FkLtzsgV0hTy6IEx1Pnw3vH5zv7dhvQhXZikq16POOGi99jvsfJKaWdt
    -EHyJkJPPBd4jJrFdgzMF4fsO1wBlt0XlKaEPlu7E4PGnbuI2INEW4>
X-ME-Received: <xmr:o8R0atmZTEUwVK-rBMb3oI0TxmIinpjtfvY4g-_pvemkMJNHUd59zHfAmHMrx7P6hiTQxhanzSDBoEKphxB0CtypEGE4-a_X4A>
X-ME-Proxy-Cause: dmFkZTElnZWLExWKBKZWlCxAl4wMjHAYIeltk/droKY8L1quXe/XzMhXK3AG/DQn1EMJhc
    CRBdYJMCQYEn1y1571RbYBQhxvA40fQpUdB1j/vzfxguRQ/VALduUB3EklQFWEedzW5OkH
    pE3Bzpgo/TisZzriBu3s8H9NwL2vX99Y/BLsJlUZfSD7IGd7PPAxafphUTHQciVCRx18IS
    W2euKuN3ww1Ig1tqndtK50gbUIn2S2tz7FWDhXBWJyHsv0Z5DHA7usILuYdWiUPKfAY4sj
    y90TcrIb7h8ErHL+qPK564fR/iRl+I+nBAze18TYfpFde3uSG23n8isZ9Eevh2lGWnztqo
    DsR81Gp7D0ew8X/EnFN51QWIDZeGXihK3PJ63EKdZrYalS4vq19R/S8nseOWfDWCUe5lPL
    mEPUKKZR7mCFBQXpFgwFLwgblnK6GUS8QOBcvnc9l2D3EdbAi/zFTkFMqGlx426dW4PQQy
    jwncSvsLVNzPzKAoaX21ahW9VmaLR9NJnWD9t2jsTsPxqQw2j0NR3M8V0OTRI4vpQU7w2n
    OfWhGC0Uc4vEU5xbCXo4ev/fYVd+aioPNiF7L9dRuLupI91xBCnnWyfeCtz/lc+c7d3RZu
    9l3tWLyNZjOX1SAiKjZ7L0jDmJcOAzqYoOmS+kqjnnebwjYCKaEkUtONNJYA
X-ME-Proxy: <xmx:o8R0aqWhg9ssPmZitPHz19EQcfGWnuyl_FN2Pli86nVt8SPPZiL2BA>
    <xmx:o8R0ajvOdwkHhXPZow52BlNfrSXI7bX1GmI0K0JXM9xx949Efr4NaA>
    <xmx:o8R0atYqrPfLAJG5YkPFtRyyLtziiALocvn3hnWhlUkCvGwMfMe65g>
    <xmx:o8R0aiXJS4rKwDp0sVqm21ajJudRQS9PDourOs30O09pt-JsOqX2kQ>
    <xmx:o8R0aotvE4rxzQCxDnKFxLSRXS0Km_6TGG76WuEBPqjTSO2mXTtsOuu8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 13:30:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 00/12] Next size_t stop: pack-objects/delta
In-Reply-To: <anQmffJEhKxttUjO@pks.im> (Patrick Steinhardt's message of "Thu,
	6 Aug 2026 08:15:25 +0200")
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
	<anQmffJEhKxttUjO@pks.im>
Date: Thu, 06 Aug 2026 10:30:08 -0700
Message-ID: <xmqqy0ejjgwv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Aug 05, 2026 at 04:14:27PM +0000, Johannes Schindelin via GitGitGadget wrote:
>> Changes since v1:
>> 
>>  * The return value of sizeof_delta_index() is now included in the unsigned
>>    long -> size_t work.
>>  * To assign correct values to the now-widened max_delta_cache_size, a new
>>    pair of helpers are introduced and used: git_parse_size_t() and
>>    git_config_size_t()
>>  * There are now two references regarding the provenance of the
>>    deflateBound() formula in the corresponding commit message.
>
> This addresses all of the comments I had. Thanks!
>
> Patrick

Thanks, both.  Shall we mark the topic for 'next'?

