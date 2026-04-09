Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E45C2472A6
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 20:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766701; cv=none; b=BSjaP7h430w5CyZgLqJtvD58aveDprZvl+kiNHPO1LDobtngkSxTetdaeEO5v6UnaA2LurCPswergMKDIonuV22Ovmz7UyO8kDIGMrj13s2An6eKU3DJC4LAgpCy/0nNYAJi9XFEDzPxlT4dHZ27Lb8ahFNOhlKDKBjcxn0iTNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766701; c=relaxed/simple;
	bh=R5DWppzqCYNVnpKt/YNVjprCc4mv/zACdQcTRrUXnuU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nIi5HXiYvZ7MrGvL88v6W5Z7Gl1a8SneRJidwtL2wTBwWvyOz6xf5SspKkIwUEQ1+/R7BrXDuhcTG53iDkvbk9obpHts+MUDNWj8xnEVujnH6XCtAUoknGyK5N/W25OpO+EcHwfOhDImOP1j977waKFCWXx0X30c63b9RXo3iJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SWd6i0DO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ghVttaRs; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SWd6i0DO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ghVttaRs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9A0C87A0265;
	Thu,  9 Apr 2026 16:31:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 09 Apr 2026 16:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775766699; x=1775853099; bh=lpV5fXwNIZ
	lg+eF/9RuzIev8BCQ7k4WrG3i/VJKzR5M=; b=SWd6i0DOxvrBlKlEAPdslA2EQg
	F65ByAdYEUsvXrssjsIwiI6mWf8BaB5RK/XL+HNDX6WDZGbpJZWvv32insoE1vlr
	6yl3vGiB50Dh7Qm6NdirvET+ImmMKrZ67Z9OEkdxLyVeU/SPIF1l62N1tQLAnTw7
	0Smlfsz5gi7dgwBoetbMQ5u4dKlGoA4mAvKtHx2V2AoxQWigY7ZXRPFz45CsI2Yt
	n0pRi2FJwsVCWleE4UpGrawkjQLjpx3btT7Qvj2sN/d7TVtIJ6En7gIP4CrX9M6h
	PuPmgEynvOCCFbDFH137EiU059kB6r0yCOQ5T8U5pAr2yocOEHAzAVNfn17A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775766699; x=1775853099; bh=lpV5fXwNIZlg+eF/9RuzIev8BCQ7k4WrG3i
	/VJKzR5M=; b=ghVttaRsYfgoBJ4RQEd6PRrv4F7zmcMs1awpZh0jOPAre0UoHja
	FI/j4uWBFboD1MAiG5f28bqnPe3qZKUoT/rrqYmVnmek6DoiQPtFCYdYuWmkmOQq
	34seIjah/TDeDjwi61js8NimMvGIjoCMMuLCVFwil1i9Nuj8fQUSo1jMZ+2uk/wX
	lzlzpSigIfWHpOKt2iDPmNpValAab75FkJVb2sw0c2rMRf/X42YUhkkLyWu4Oquv
	CiuKWXbEtaus0ro3fyPHppPakEIF/O3+pHnnAjj+pS8Smq9tMvi3lJtykyt4jo9J
	JIZ7Dg9mSsWFaSOV3oELh/PGpQrurOl1nCg==
X-ME-Sender: <xms:qwzYaXbUzgos4jTBYh4E4Kh9snAoAxMlmOKsb6bvfwXEAbVVS9jw2w>
    <xme:qwzYaYp-iJxUiDPtb3vqKBxFoedjOYiZ3JCWyOIxfA6RUGOK-XS5mvBtNP3WN24ej
    T8ZP4G80YVwbkZU4XLVi02OCkMkZU448ii0nylTcsEGT9ItpqwsCg>
X-ME-Received: <xmr:qwzYacO4SYZUTKMkQ-ekqUAYWmgYdiruBGhtQ1maTZt8g6yzfYnPQxdmxp1WLLp1ITliFvVv_Ki6JiYl7O8KB7Z8y484XbV7bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjeegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvgdprhgtphht
    thhopeguvghvvghshhhighhurhhgrghonhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgs
    lhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepqhhuvghnthhinhdrsggvrhhnvghtse
    gslhhuvgifihhnrdgthhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qwzYaTpL1mUy4Ya_iiTHdYTFLe6roewRaJFqMSMMyNuN75a5YYYbNQ>
    <xmx:qwzYaRf4ANHg-J2GH9n8fx4WAFXxmyYfhN84EF0OnTmdSke5H_76iQ>
    <xmx:qwzYaZSrz9X4dNDEfCMdP6lqw0vZdlNUfHPnQoQUhnwPi3X93H2t1w>
    <xmx:qwzYaaZh3ZWrvYn3ZGa6DfC8ykCR-QDH1F5QTG4-zuhguiffiX9pTQ>
    <xmx:qwzYaR5-SEhqFj7-OXnz_-Jty0rKhaxk6jDq97Zvt96_v9A7VlRroFJ8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 16:31:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Mirko Faina <mroik@delayed.space>,  Deveshi Dwivedi
 <deveshigurgaon@gmail.com>,  git@vger.kernel.org,  ben.knoble@gmail.com,
  quentin.bernet@bluewin.ch
Subject: Re: [PATCH v3] stash: infer "push" when push-specific options are
 given
In-Reply-To: <a280c7de-1357-44a9-afdd-bd473fd4e2a4@gmail.com> (Phillip Wood's
	message of "Tue, 7 Apr 2026 10:36:13 +0100")
References: <20260404143640.6679-1-deveshigurgaon@gmail.com>
	<20260405110953.3316-1-deveshigurgaon@gmail.com>
	<adP3JZhS7IHDuUxm@exploit>
	<a280c7de-1357-44a9-afdd-bd473fd4e2a4@gmail.com>
Date: Thu, 09 Apr 2026 13:31:37 -0700
Message-ID: <xmqqa4vbswnq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> "create" accepts "-m" as well so that's not unique either. I agree with 
> Junio's suggestion in the link above that we should assume "push" when 
> there is no subcommand given and error out if we see an unsupported 
> option.

Yeah, if -X were unique for "pop" and -Y were unique for "push", it
is tempting to DWIM "git stash -X" to "git stash pop -X" while
DWIMming "git stash -Y" to "git stash push -Y", but the thing is
that the urgency of each "stash" subcommand is different.  As the
"the boss is here and tells me to work on this completely unrelated
thing, clear the desk as quickly as possible to switch context"
command, "push" deserves to have more quick access than other
commands.

It also makes it resilient if we said "a command line that begins
with an option cannot be naming any 'git stash' subcommand, so we
will unconditionally insert 'push' before that first option",
because 'push' may later acquire "-X" or 'save' may acquire "-Y" and
making these options no longer unique to a single subcommand.  A
version of Git may have treated "git stash -Y" as "git stash push -Y"
but if the next version that has "git stash save -Y" stopped accepting
"git stash -Y" as "git stash push -Y" because -Y is not unique, the
end users will be unhappy.

And of course it is far easier to document and teach.

