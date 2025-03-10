Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D17D22B8A0
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623560; cv=none; b=DHTxCw+lkSfVwphcDiz9lheF2wT6sC/sQJ86EwaMoQMu8tUz8N0J9P06rpzYbhIixpksYMJzFfUuceRczdh0hDiYRnVwNZouv8w/cUKzm5QF1deLyZbF/z3Q9+ffq/Lf6QZRKWQWjK2xGFNE5h9h/D7n2WgZTFHCzH/PmF6gQVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623560; c=relaxed/simple;
	bh=aYkLoYbxb97jjR4iFY5hVst7RdfrtgWH4CXNSFh1wdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I36srNm8e880/de/uJ8pTH7WWdNy2KxpfNu7CuOYp3/02nYKswMBTVMwxphkFtPM+Bd5jFWyjoCWHQq8/E0uXZhSSZhJiFtWJYf7YRt8rZ5pH4/YV0bXi/i9NeEmyMZg9/selKk+KPKmZyYtcx+Emvij6p8QkrlEw1CdFgAm5N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IQlzH0Hp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WvplzOys; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IQlzH0Hp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WvplzOys"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id D70621140149;
	Mon, 10 Mar 2025 12:19:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 10 Mar 2025 12:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741623557;
	 x=1741709957; bh=hSxXzdrQFBN7WiJX0e/xOrhKwJL0jbdgVqqPXdyCTbU=; b=
	IQlzH0Hp7xGXeKUDK9xstMVxc2eYa04J9MWAg9V2oxNYCcfLgrBwoa8wrJa/a+q3
	+luCpZhTPw4v+8R/bxoM6X5/Lg+ei61P3IEKU464Sm2iQE7AZ2/s9MFiUxk23Ger
	oL34vRfvLH81ZOtsgGxhTmu5kMgrhO8I740AEciT13Cd8Ohcf02Naq9r58dKWp7E
	jaj0fH6+xyWYHvGEOgc6pFQbtCTUzkf/FQ6VQoVMOczWesbXku/G9GibPxUBOJh8
	ZRKGnD46EzJW1L5xDvxS+/Rueu+tDtIfEozxtNO8TNTrrzaJoEfvCcjcqKd+WTUJ
	PJ5uzn9t22WZzhVJ3VpgxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741623557; x=
	1741709957; bh=hSxXzdrQFBN7WiJX0e/xOrhKwJL0jbdgVqqPXdyCTbU=; b=W
	vplzOysVlEW0l7fyqWMokFGmIvp9TP8wtyoOuEq7qg2Dqv/CEU3G2Z1OYvVGubN7
	9T89PqcpgdgS9+iFbJ+CpPwmgf2628C/gXJVxt/LDC59CW8ojOiW2LLfckWKpOCh
	+2I8BODLAAsHkMSwzQAljsCJw8Xjz7iSM23vAjb+2NvtuuFf2cCQ4fP+zf7zh+yz
	Q8KH8wTLgGqOnIOXOdluTah7zKo3AqZxNdxtlUJMqkJiaSSyT1+PgqE3FEeTqLaR
	lOV4imQA5grKKJgDUxh7/vwYpf0zCx6V08qX+R+IPJhi49UmMpIgDRbcVWDGUz9N
	cVwiGt0Hje5MAD9BpOxXQ==
X-ME-Sender: <xms:BRHPZ4-lEFSaV5nMnKuzpQ1tgMDZfaM7cxqDh0o-nrgxCTNVzyblww>
    <xme:BRHPZwsUn6ndfmLC6WLTp01fQBUKb04WstZ-tNlsDnMXxGOLw4aszxbg4iFjfS0zf
    zaIt3L_nGx8ozpsYQ>
X-ME-Received: <xmr:BRHPZ-DCQSDOA1ZTRInmyblM4Zkoj9XMUPmzTDhnsit0c1LNc7acbZDKZ3HC_NlkXaCtfatZSLNRvcT3KJ1sExrBENk8IIoO1Siq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BRHPZ4elePxIr2O_hZJH6Bw5KufpotBnWB-fxolPYBHx9c1p4ooM4Q>
    <xmx:BRHPZ9OIzcqGXvuW9J4GmLUmZc3YDJn0JtXg3eshZFYgJRXE4yhflQ>
    <xmx:BRHPZylw259ogmc_YBpnKIaXW6PIYgdnBVDBtwVmQVCHERij6CfSHA>
    <xmx:BRHPZ_sonZ3At2minyC-uMRWT4d66cfhUw7uFGjZjlU2g3FcmbjNSg>
    <xmx:BRHPZyq87hMHUS4IId5mFGrtGj7EBNEIX-UtBNMbC5zkpOnmBgNnxGPH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 12:19:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH] doc: add a blank line around block delimiters
In-Reply-To: <pull.1878.git.1741549511665.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
	Avila via GitGitGadget"'s message of "Sun, 09 Mar 2025 19:45:11
	+0000")
References: <pull.1878.git.1741549511665.gitgitgadget@gmail.com>
Date: Mon, 10 Mar 2025 09:19:15 -0700
Message-ID: <xmqqsenk97uk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     This patch is basically a mass-replace of occurrences of paragraphs
>     followed by a block delimiter.
>     
>     The issue arose with a Chinese translation where the length of the
>     paragraph turned out to be smaller than the original English and to just
>     fit the number of hyphens of the following block starter.

;-)

>     An a longer term, I'm wondering how converting all the asciidoc files to
>     the modern style (i.e. atx-style, with variable "=" characters in front
>     of the line) would be perceived by the community.

It would be a one-time churn that may be worth doing, when the tree
is quiescent.

