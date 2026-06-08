Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25197376A1A
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920398; cv=none; b=lweLNU2hLjH3Zk3HQkyIKkpXY0/q08gbyUfohpR+gVuWno1djvstMtPAO1JKhFK//ae05MPZUDh3K7Rv+TfKgAhJxXQCSSY9+v33evRJx8nnvYrkXh0pNxSZvsGOeKhziFiQ4t+31J9Yj3DQSP1nXSFxWX9OVMmE27h2dvDL5ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920398; c=relaxed/simple;
	bh=BLuYk+fAriaAL0tZAesilMsjc7wiNhO79sgj7bi9tbM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J9rENYAZMebQilbtl2KQ+ABbM2AIy7K02Mkg4oME431r3OerMvCLlSo1hYJsuEXxcNy5jHE2+atfS0Y/rq7xTvhgshXf3wm2ziYmTesCLG1xr0v8yVXNu/h8zuzOWoKG2zUtC4chYG0H68K86u+ubZUiZNzTCcWv0bwjm2gFND4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l3rZJL1L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HsR/Mr1S; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l3rZJL1L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HsR/Mr1S"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6BC1FEC0073;
	Mon,  8 Jun 2026 08:06:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 08 Jun 2026 08:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780920396; x=1781006796; bh=YKicXNIAlU
	IMh9oM54sPdl/SsXnBifFpeaYvXRXqhkg=; b=l3rZJL1LoawA5WTxc+lXdGEhHb
	F5jIZAJAJh4SzSNNdT9qATKuuvmaxsS/vVnue68IvqFadeb1tZR4wpGemuUwqC3l
	kJ5OkVO4/x3o1FGnOO83hF5XcARVFJQla+8vIwdGbunC+cUvkyGLcdR0G2dtQ7x3
	ctzo51SBUe7AQtMyiZgpnU0r9WN6YpZbU2vNJe4c05bdOHO+RHsE5iES1coPHElD
	oXCSAQi0vQvRCZSi3KZZobTEx3mrafnHYUYJ/cPgPJMCQufDm8kxpbQvzQnwg+DO
	jtFcKVeDf1xXIhsBYRliFQcKRBqt3dKA2+elVhoZKXNzFDc4Eg0EoStSISbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780920396; x=1781006796; bh=YKicXNIAlUIMh9oM54sPdl/SsXnBifFpeaY
	vXRXqhkg=; b=HsR/Mr1SF8laaJUx8+Z1iWstTENd5jfVPkLTyBYqYpOndW4TCAq
	EBbg5giekMbEZnYSdGoYp7x563M28RvQ0UK6T5qu1bukU7t3vwSxhzz0CpHHe0rw
	AGsppHc8lp/bh8f+cWIvVWLyGJSBFVMgzhG5YXR0MnzejoGrv+BIhjqDtYvAOmes
	KnhWUpf2GuIE1rag3/EZKsxK95AO4KzT3gHxuirMlkdy+Xonk8AOQA4rTu/rDBL7
	njsUXvQLGKOzsnY7DCoeBXeLvybuZGG7/tzNouJn3/pRQgLu437kKLQNsKuX6PWm
	HQlWk5GDfomC715a/f4PDzjPG0+NVseji/Q==
X-ME-Sender: <xms:TLAmaqjgrjpn_L7FH1FJFn5uEIroEz-Vun2CeTH-R3cL5-FSaHOyGQ>
    <xme:TLAmah5-WQAfcyF4cYZcf3ndcPhhiiPbW1E6e1j-V7WoUptFxJPAAfKjblyrorY52
    sCtDyvo08kx_031MiMGMa9oEU4fPbxhyNvYpL1ZKQYokYZcugPia0Q>
X-ME-Received: <xmr:TLAmaqY5JHi9y-nH_iDHoac8TAmsgmgCaOTMoSyLcWtJFpY7wLGxAuZLDiYsNwmjPLUjOUXhNiZFSypGIePci1eITEMoiG6VfZSv>
X-ME-Proxy-Cause: dmFkZTFFtTdmF6+7+Tdxr6BsnR883K87BZcRfxUGaedsOpGyK92HCBoHLlMnzVFYSmoIk4
    wfgPtUygJeBSorcWR73zWR5rz8+dagrkP3Wucg3TtlE0ljeHT/kPTe9Cau1GzJFI3gJwQj
    ppxrkPUaXEr5A+TEZWWsN38dwjzoeY/VrKXSA2udniic+cld84lKq78hGEfAhEYLPjEOKw
    L2JpeOaRsgmNRlZW/pikJuFD0PzOXF1bFVR7UD6duVOwLO1Zjr1StskFEDRZJAItmWfV6g
    W2U/1VGnEOsGXrN52ZCRd7z1YC9tZZK35TPNq2vFzeBbfZh+30q7Y4lR5n6iVLlONDIZF/
    M76JUvBIkcpbA6fmNp/0meX1K8c8XVtZ4dJpGEbFZUVL4/IBA9PjlP12i/UHVafhak7bP1
    W9z4LpDHSOZfzeAL5NWziLKt+QSWIwqkTe1j2F/uExB+2tA6lONAc+FM8W4mAOHOhYFltx
    txnFk97pLII7BPiFVhFOtLhPCovwxRtayflJIm8TXBvDWq3KPJ5IiFXLjIX9CUsEWu1noZ
    GNLu0wgumjNgIvxgVARo55rBR4BIeWwXt9Ve1eYeMOrWBkf8FG4isLIIwoj9W5EZTlG5kP
    x1P08oScMJZ7qYuCby84nVDwUdH+MX6+DqXmTdt7IbLl6Xfuu00vEaqyhdbA
X-ME-Proxy: <xmx:TLAmau7Z4FGekxemoGetIbavfSdE83wDxX9XExjeu2L3TXlHxmFBnQ>
    <xmx:TLAmalBbBmGhSUYkTYchVjuKao8PDs4qqtDuDlOgdgjm4RFy8xxprg>
    <xmx:TLAmascae5e_eNuN_Gc1nvbIGpqjLQk_Ddo7QhvRsmWuu6dQhpjwEg>
    <xmx:TLAmasJ4JrET0Q9RXbsLf9y0fMk6pgrQ3NOUkzBpO37DNhxtSbL5Xw>
    <xmx:TLAmasfxnmmxL1GL4Vqb6jDYOrkq6wWU3xXsConaw-wHLMcJIN8xNyly>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 08:06:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v3 4/6] diff: add long-running diff process via
 diff.<driver>.process
In-Reply-To: <c7987f11-9181-3975-552c-14e74abb2c97@gmx.de> (Johannes
	Schindelin's message of "Sun, 7 Jun 2026 16:36:15 +0200 (CEST)")
References: <pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
	<pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
	<d044fa0ee5c9cda7dfe4f663f34443103521ef43.1780087700.git.gitgitgadget@gmail.com>
	<c7987f11-9181-3975-552c-14e74abb2c97@gmx.de>
Date: Mon, 08 Jun 2026 05:06:34 -0700
Message-ID: <xmqqv7btz16d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So the conscious project direction has been: fold pkt-line test backends
> into `test-tool` and drop the scripting-language prereq. Reintroducing the
> same shape in Python would walk this back.
> ...
> The `PYTHON` prereq exists in exactly five files today, all `git p4`
> related (where Python is an intrinsic prerequisite given that `git-p4.py`
> _is_ written in Python): `t/lib-git-p4.sh`, `t/t9802-git-p4-filetype.sh`,
> `t/t9810-git-p4-rcs.sh`, `t/t9835-git-p4-metadata-encoding-python2.sh`,
> and `t/t9836-git-p4-metadata-encoding-python3.sh`.
> ...
> That commit is of course not intended to be used as-is; Feel free to pick
> code parts of it and integrate them into your topic branch. Or write your
> own test-tool helper from scratch if that's more your jam.

Showing better direction to new folks with such a clear thinking is
very much appreciated.  Even though it is natural and perfectly OK
for tests that interacts with parts of Git that are written in these
languages (e.g., we are OK for gitweb tests to require Perl), we
should consciously keep ourselves clean and not adding unnecessary
dependencies.
