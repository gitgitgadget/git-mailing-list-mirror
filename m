Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D32625
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 00:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784853234; cv=none; b=o5iDQ5UUQY1Hqa5II1mkOOuQGJgE+ZAL3+bu83v5mQNjjjQa38RPp9cAUwVH0ie1DGVByFHCH7vcq6O41cb08/m0TlcuCXvdFlg2GazUKQmmmk4Rb0O4T7XOpnJXjqDp8eO0eC88DxFPolN0LZKjP9RT8ImQR02QBpPpxpytPyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784853234; c=relaxed/simple;
	bh=rPfvTWmzLJshdlmPL9m6zEfiJ9g/HKVu5pyWIYlmSoo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jdxdnZRiQS51bguznhZWrUR2kt5nB1JGqLuGDS66X+plRuDqyaA9ZPUYEdOOEXquXowHyKU183LHJzuI8eKO/mZf2O6nphOqeWWBOBN4zP3PhcaRuf7Oap51vfaqttqUS3WaMKgo9AepJVvgVnbRVaqnAcYbU66wpAEBhGZRXv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n4nKNipu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hj++s0kK; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n4nKNipu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hj++s0kK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C6291D0032B;
	Thu, 23 Jul 2026 20:33:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 23 Jul 2026 20:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784853232; x=1784939632; bh=0qYW6klYzk
	F1vQdS0gHjcnek11tJumTAXDmHfceGBIQ=; b=n4nKNipuQldldKceajgfj+8Nm4
	0bhENflAYQQa3T8C4+7ieyZqCAPk1xMyXtWpOkshJDr8ntU/D+RjqJ38/1F633i7
	rvcfsK1dvIrV1wRYQeUB7mKrb0uaum0+nUBilNHkdgK4esbxWwze6M/lCWXn3kIw
	L3oKxWZEfXFuPM1eTFTxZg/TIbaf2itJOXrIx3qNh7oGdLl/emFwfT33vX9oF1Ft
	yX8OwL83wC62Q9+Ns/OSEtmRGYgumxx0mUlKP8lZEERchj7FzCQkPlalgz9mVvo2
	50hRjjMZhEbxnYaQ4oHI+9zdEpwy2nAaSkTLqb34xSUEU4jDlVPIerhGrtww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784853232; x=1784939632; bh=0qYW6klYzkF1vQdS0gHjcnek11tJumTAXDm
	HfceGBIQ=; b=Hj++s0kKD4Ob+KOcCLvptmP9VVgyLwnlEaESHLRZp5XitkiXRVk
	JupIsRXH4PXUmOfxk7cj6WSD8HHM46oZfYftm/O2aMiYFfnGciQ2MYN2L7Sk9Dwj
	CRmsY+vNFWb/GcM70BRoKowP7xFbseE1nPPlhWVZ7nQVcq997umU0TxtRBMrOUb9
	bWWlsXPOWzzMsOeO477mA+5Nzy5IlYWGnYv06vO9/Q7NA1hv2pgE6liNmEzzjg0c
	KtXL7MWsnTbYs+OzZO5K/BAkyCXZZ6CI8IoGpV1wjj6qEJ2bKs0ZLXazYv7irVWw
	pn8jbBDnVB2SHNPcPid0MwhifA/9Ybh32bA==
X-ME-Sender: <xms:8LJiatx2Yrvyci1r1TB0w0G2mSImaIBvDQuBezwS4_TGvahDl3fQVw>
    <xme:8LJiaks7WEz70cvM3NhNonVrCEmoLxajckMY-n7DNbOD-3K2GXH2_OEeChuhyHcI2
    U0WOqIRL-ARSDMdm5Qvn4-7xRLmfPv7fclaIXRFdtlSxykl-Z4lQw>
X-ME-Received: <xmr:8LJiakupeK5hLrf-btBV50rbW642cqAeCe2v2IO3nxaPoTWshUIlot-6N3Dg0KUS7TktH_Tr2Hos_3A1qYufKQocVr3shsiK-g>
X-ME-Proxy-Cause: dmFkZTFEqDzFazAfy20VxE3cqLDOAzDz/yBu1VkbyyzkM1D6mQwI5jggLEGERTNMioyFep
    mIiPNkaGkjH99eeEYYgmTzRt2pNWXeMvIFFjrQ1WTvcRZY6T/y4TmLAKMRl7/OKjagzMBu
    ACw7sf1HONXDJey3KMISEZjr5cUl5GZCeuWcKFfKtneI0LD9WNJ0LymfYt2qStLR4oiHBh
    s7U5PnQzfNhZgzkhOl8yqBvqv5yxofsbzbhSGOKTVN51qRUqQKaT9243iqDmEVOKFQHK+6
    OmZt+MHRwjUbvhAYsBUNjYP97salwSLMxSY7qXG+TQRgCxoBm54ibgjkAYNq4jRFKGcpY+
    ZXr0KwOPkgfnHQ97gkZpsqWW+J4Z6De/qxUoj8Rp/z3dzZfAkOHfYeERVyEU9FMVQYq6lL
    YyQYuLe88OelXoHVMMGXjyHvUF53P8vxKSF0tnWZKk6qs8LRf7z4oaULMrcVRuVOuprFlb
    0/XANKtDCRpoOmCIxy09pBjYAA9VoLT/R/fK5mCqzarYwmAp2t+xFPmVoDvqhgOlVZpQ9j
    Oq5w1KW4B7py/x1v7kHmtzaaKtc6PAZCiUVwQ2OXLPgVR5o8fc9Rfo7MDWeEiYRcCYZviA
    W+ZYR+rxbWzGeafKEvLayUm/DQtxr/VWtM2pd1pVeL/aOsNZu1akG3VsiMNg
X-ME-Proxy: <xmx:8LJiapP6Z7XM2mDsXfXFvNETvd-VkmevOn0iPKhV9CszEym3AO6zvg>
    <xmx:8LJiai0-S4zBGH7vl7Vvp0OzJrIiCTrDTccUuVuzMk40KYqcf3V9Sw>
    <xmx:8LJialNo87eME4iIOURDGGalNTCp1FeubD8hB2-T2EjkTiCv7siwKw>
    <xmx:8LJiai0HtZb_M7ibnKb2gw1wgiyHtkPhShhgIIc_IpOvEqs0k0fPig>
    <xmx:8LJiakvRuegd_Xq7fgu9LED5vvETbx18zQblpPBKoEa51Nrv4o4eJQYv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 20:33:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Pablo Sabater" <pabloosabaterr@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2026, #10)
In-Reply-To: <DK6AAT0NM6G0.3SP94VJYJWPKU@gmail.com> (Pablo Sabater's message
	of "Thu, 23 Jul 2026 23:55:36 +0200")
References: <xmqqfr1amnvn.fsf@gitster.g>
	<DK6AAT0NM6G0.3SP94VJYJWPKU@gmail.com>
Date: Thu, 23 Jul 2026 17:33:50 -0700
Message-ID: <xmqqqzktb501.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Pablo Sabater" <pabloosabaterr@gmail.com> writes:

> On Thu Jul 23, 2026 at 4:38 AM CEST, Junio C Hamano wrote:
>>
>> * ps/cat-file-remote-object-info (2026-07-18) 13 commits
>>  - cat-file: make remote-object-info allow-list adapt to the server
>>  - cat-file: add remote-object-info to batch-command
>>  - transport: add client support for object-info
>>  - serve: advertise object-info feature
>>  - protocol-caps: check object existence regardless of the attributes requested
>>  - fetch-pack: move fetch initialization
>>  - connect: make write_fetch_command_and_capabilities() more generic
>>  - fetch-pack: move write_fetch_command_and_capabilities() to connect.c
>>  - fetch-pack: use unsigned int for hash_algo variable
>>  - fetch-pack: drop the static advertise_sid variable
>>  - t1006: extract helper functions into new 'lib-cat-file.sh'
>>  - cat-file: declare loop counter inside for()
>>  - transport-helper: fix memory leak of helper on disconnect
>>
>>  The 'remote-object-info' command has been added to 'git cat-file
>>  --batch-command', allowing clients to request object metadata
>>  (currently size) from a remote server via protocol v2 without
>>  downloading the entire object.  Format placeholders are dynamically
>>  filtered on the client based on server-advertised capabilities,
>>  returning empty strings for inapplicable or unsupported fields.
>>
>>  Needs review.
>>  source: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
>>
>
> Hi,
>
> Karthik reviewed it a few days ago [1] and it looked good to him. Two tiny
> nits came up, which don't seem worth a reroll on their own.
>
> I think the series is good unless further issues come up.
>
> [1]: https://lore.kernel.org/git/CAOLa=ZS8J4t12ab1=3-LRYNuZOwqSHG861iYm97JjF3mGprvJA@mail.gmail.com/

I was silently hoping that you would fix these two nits, saying that
one of the alone might not warrant reroll but if we have multiple,
we would better get them right for the final version, or something
;-)

