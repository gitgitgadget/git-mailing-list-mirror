Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA47D43DA26
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582638; cv=none; b=S+AQKh7L9mAE2i7XJwIrT7C6ytzf8eSLWbhG7ROoJP+CApAFUx5L2MRHOu9WgOs6fyx4DhaBtkuDJ60+ZFXWu+1jfmH7BYQPtEr08IZdDaHdDDUYePfXYkJcQYyv/3a/DYuee5xLWTMOpyaFl8Hb6XWdkhHCVFwuWy4E7ReUq98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582638; c=relaxed/simple;
	bh=3ta2O2gXXhrD4u2TXNdnLP4Mqzdpl4Hi1O9VcI120ro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DtQpkwFMimEtUw/gUvAT8zGb3Y63fXeF5dIdtuvBcV+UlWeATWdPelz5PLoMPqyAM3o15dchklVnbiUy64xuJHBgnSuoLJxQzV7RyyszuvATVAHi3DVNKiFPf4/TSaiqxgUV3Baz75wMsLNcRxFHsSLBFFAiae8bnH7y1MuM1r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kj55Mzca; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z8sCFQ+3; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kj55Mzca";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z8sCFQ+3"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 9DF96EC00E0;
	Mon, 24 Aug 2026 10:43:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 24 Aug 2026 10:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787582628; x=1787669028; bh=R1bu17ZjB+
	9LV+Njm7AGAxezKvCfsotFqGbiPy54S0U=; b=kj55MzcaLmcjGr/XX7eVu+m3Cs
	U5OfgM46gMmu6UB1+sFAxnGUm7We8mVjvh/zSGMNicEObkz1MpFOCOP3DGkbYcPG
	CY3M09O3uN/THSexhTZ+Z/4smMELDhvlaZOU7HGm8oQzMVE88RCtHfvjENcNubCO
	BuKSXANCn3dRsqggy2u0A0eTQflHiL72pkxxUSgrEPzE/v/MZ9fq0iRl7G4BiCMd
	t958M5muUcZFlONBkv83U3HYAAmZcvH2iIDi5s7gtPxj3OuB08WfN1ip43i3ICk8
	qmaU0d7kiy/b9T5g1LBoooCtktWwFcxw9ylbQAstZmgT94w+qATEOug/GcnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787582628; x=1787669028; bh=R1bu17ZjB+9LV+Njm7AGAxezKvCfsotFqGb
	iPy54S0U=; b=Z8sCFQ+3g9R7kvDu8Iw1BipLNH8sZSP5Y4+1LtCHVM7aEIzgR4H
	YKdttSr6qcDO7jwlf0N8ZzXod4t6HMiQT0poarTu0/FyiynXcpyAHl3PRq8BIgyh
	vQq+MsSf9yaIj6S9ggfHepVNf862J9xKFdQrjFN/HNp6wFkGPcJS7yWKj4ktseNw
	FpPHcr7INOSd1gKb09YtVS0GcMPzWLvpMHoHC3ehKJrwD4hkRtRSD5XrJV0yY2bQ
	0WnZIeiVZK9NKoqQ2VN+Sjnkq/NRd8MhB/uheyP2o0g1eqXUlA9XezUUPOFDW+QE
	Jd9mpl7hkbTCToX+1Ul9OI12g0MKRFgWOsA==
X-ME-Sender: <xms:pFiMamCTtRJBS-AaECjbX-zT5VkwVBZrKjEZPjXRi1rttEpBQrP4lw>
    <xme:pFiManbmZFE7L1ZHIpPP9jGmS-uJFvkyvU2pbvzXV49TG16koY-kDIe664jVJY7eV
    iWJIRA-Vf3hN9yF05ctFvaEWBj2Mj8ypREjhId1z6bbwLUuiFGEMO8>
X-ME-Received: <xmr:pFiMah633rovE-do8Bclu7arJdgf1Ev8GUvVN8uY7BfZU9fjhmMRKJiCyfayqKCtDsR5ShYA7lbQHfW5AedblpObqyymQDFoSw>
X-ME-Proxy-Cause: dmFkZTG2zrEcZQKtncz+XNFX9RB1fYsapz/nvw1hF37Th93rSVJdVuHkeqSDFbSENSgnod
    eQZFaIvb26R9ztLJlU16y+apWPYCfbWa9ikALEq9m4kljwb3PYfQquCjnqlD9+Hiv6vznA
    MSXPhqEJ/anCHFtkqRb9wJU7KGkILT/yRsA0TKXvaHD5Cmd+4AdE6ZlkI+vzgtY2oPMMBd
    90o74NNjqWwTFs/5hIoLnNoCxvwfzxa7PX4WJjou5NH2VNYKNlRrkmkeKlgbCIVxb+tYlg
    1gbTw9WTCuI1sB26mzc2Qj5yCzMlynckS6qgLGjD7WVA5WeWoYYhNhjxNGUZ5uroP7psp4
    N6gkH05Rdgl3u0xLqsscr0xnXIZ9M5OFUKoAoGTeiK709vZq2PeHU8ghIGvvalPywZ8SH1
    igFdDVDwmBTzUlCZvPYlLzwpTpSWTkPYXX480CBArLpcOvG3IwDM4FMFWhF4ZAO0PABZNK
    CjArSByrx+909h71c6ZUqOUAhEpoWW/jkSdFYzRaVZ8mz3rMfn0LZYqXokcmONSvb3ax1u
    SE+h21g8BI69LPYC6yN5YvRfiWx82H4uG3Y22/D+QhQQMSAQe4ga+sc/fuUCkuyD/aEQzi
    bVj17pv/NM4TMkxTk7J/qbfJwtlPEV/FzSGauKI2jeo+ZIs021O6TqtyRLzw
X-ME-Proxy: <xmx:pFiMagYWogJzwKGJijsieDv9KLdLAPsSFY9d5RNlgZIDzO7fZhdybQ>
    <xmx:pFiMaoiBanWxb4yDE8Zz9s7ei2oD1FY68dK33ATQ01KqwGt4OQXa9A>
    <xmx:pFiMap-wFQyEMhMLXuVmpJXGmmajuFHFTHtRBb4yqB4aXEVnlfUlEQ>
    <xmx:pFiMarpVuKxXpJ8s4odM4_6AcMMyBXKyYJb-gAMkLELdzpF3xc_tTQ>
    <xmx:pFiMamzxYhCbfQ1eVREIFMWb_gn2NtkzcJK1-CBxKvwsVUwNzGupq6jJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 10:43:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Michael Montalbo <mmontalbo@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <pks@pks.im>
Subject: Re: [RFC PATCH 07/14] odb: gather the odb sources under odb/
In-Reply-To: <aoxQaSGaDwqkP7Tb@ugly.lan> (Oswald Buddenhagen's message of
	"Mon, 24 Aug 2026 16:08:41 +0200")
References: <20260823171915.2662373-1-mmontalbo@gmail.com>
	<20260823171915.2662373-8-mmontalbo@gmail.com>
	<aoxQaSGaDwqkP7Tb@ugly.lan>
Date: Mon, 24 Aug 2026 07:43:46 -0700
Message-ID: <xmqqjypfshnh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Sun, Aug 23, 2026 at 10:18:51AM -0700, Michael Montalbo wrote:
>>Move the 23 odb C sources and 26 headers into odb/ as renames.
>>
> i for one would go with lib/odb/.
>
>>+++ b/builtin/add.c
>>-#include "object-file.h"
>>-#include "odb.h"
>>+#include "odb/object-file.h"
>>+#include "odb/odb.h"
>> 
> that's the wrong include style here.
> it was already wrong in a lot of places, but as you rewrite everything 
> anyway, you could fix it just as well.

I do not agree with lib/odb/ suggestion, but I am curious what you
think the "right" include stle is, because I cannot read it out of
what you have written.  Please do not assume that everybody knows
what you think is right or wrong.

Do you mean they should not be quoted in a pair of double quotes
because the behaviour of such includes is implementation-defined
(instead use "<>" as we use -I<path> on the command line)?  Do you
mean they should be alphabetical?  Something else?

Thanks.
