Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6031E3774
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739297500; cv=none; b=JCDzSOBVsg9AFTPvgs2mzObRQFg1kOsgscWHf+7vJEUw2HOu+6Ij5BkiUAeGeOg1d7Ky6UL55PkftsVisB5bY0bCaY9DlNkk6Y1FN2DSKq9bHhfKZu7YjQO0PgseBgwByQgjti6WPEnzffDRFo9kc/kV3MeSh7zVfM5zvnwziaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739297500; c=relaxed/simple;
	bh=7yrUdUh1emq3psF6lkkRDjV2Z3hq5GBIwEexSUHQ3lY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sF/xfobWocU9XWou6oSbibGaoRx5jxqCRgiyP004AdE7I3ME+iyUQvXEp7hB23OGNHNGOJchmWgFsta+x7cGHrSiaTvSRrLU5B0doKfz/9WY4uAEdB3kqsADdVuzUh9cTIUnle0vK3xEb74XxoZ+O+dBm+i47sFncAsfKnHvLHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mEnTVRTr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iCW3ebJx; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mEnTVRTr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iCW3ebJx"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 475BD1380A24;
	Tue, 11 Feb 2025 13:11:37 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 11 Feb 2025 13:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1739297497;
	 x=1739383897; bh=cnm1EEaElkvlPJsyuQnx8fme9s+xrW/cjBNMOjfSH2k=; b=
	mEnTVRTrYvW6qJl0J6zl/NC6+sK/ILhc5QHhaUNeXhgozFY/zU34rhDaH3hMEKWw
	/lRE10fZ3kdXNDxWbZXbK4G6i+yhJ6BL/ruDvSTFznZlAnG6gRLfpMUxU8P/X9yf
	Qpdw5+xXFpoTG42ekngg7YU6n5NpBB7fUKL5Y9TsQ8WJXyQJmDncDf8i+jLrJE2l
	cI7fBQEATb3Bh2TQqAI7s+Dxu3l76Xv0fblXhA+0bob+XxOfWfSspHsP0vmmhkqD
	KMTqkEXPaq+g5ifHNlrE7YwfZnccsRdQhdKBHaVUcDg5Bx5xCbeaqPmq+UiOjATN
	kwBcC15LfJTSzWLXO+4qjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739297497; x=
	1739383897; bh=cnm1EEaElkvlPJsyuQnx8fme9s+xrW/cjBNMOjfSH2k=; b=i
	CW3ebJxOSuPeYvHsc2D2m0X2pafsnA58eGQvQm0gVBF/E95qlSrWoW29w2uSjlpM
	XtnW3A5Gk6KEAS1w70WGXsEb+k9lIoVBQEzjNRGAmfS7oQbG31d5kA+FkFqy660S
	+U33LyLhb8jMkz78v2THzxISD5KVCcTwWbIxK0TfoCqHes2oVxHsnaitc/IXGN1M
	pqCv5B1XsdZpVhT9jOBkx7xybaneJeMxnD1ldkMt5Va21Ic7jzUtMCh9RjN8dXN7
	QIOQ882sDw0RkYZ93ijWwsDhc5VxeP6gpbCjVgz6uu72AJXmaBiCCgbtFpcjGwUn
	g3leoiquOw/ye34agK00w==
X-ME-Sender: <xms:2ZKrZ1iS0L-_0sMgPxTEuDYsEvMeWsFC_X709AB0ugPalCCKVy9eSw>
    <xme:2ZKrZ6B7X5AHuBGl0et3-PrsWRLwVjfrx0Zq94Bk-bHx38jY0E6JRlaP_z8-dLqZU
    yUsBGo3nxxGUjtAkw>
X-ME-Received: <xmr:2ZKrZ1G7mfC4L7AWRNGC4w_N2sz-nBYYwoLJfjK_bmM_hnYWzk8Lxv0D6131tby22zql0E4Dh9OIOTEvl5m7T3a_y_wPRdIaBaKRl7k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegudeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekofdttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepkefgtdeuvdejfffgheeufeeugefhtdej
    hffgkefhhfetieffteehleehtdfghedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepihhnthgvlhhfgiesihhnthgvlhhfgidrnhgrmh
    gvpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2ZKrZ6TzTsGR_YN8FvhYGvXzSft65UZQrNN4BoO9U-GhnP2jo0GhzA>
    <xmx:2ZKrZyzZ9kwG5m_8NBPajackbL3vS2tYK2USpzSIYn19pzd6PPfD_g>
    <xmx:2ZKrZw6crmnK5mzCaB4B6KJLWFlnNZK0gVOwErcYEwR8wtezeS7t5Q>
    <xmx:2ZKrZ3yXElOeXUcB0E7GMBrVZjP0CWFMopqlAPB_az4B4C8eJZ94yw>
    <xmx:2ZKrZ5pTiUtPNNOOsNE1WguMMlrpl_Z4LkErMpkjnES0ajd2nQhJvl5N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 13:11:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org,  Ivan Shapovalov <intelfx@intelfx.name>,  Taylor
 Blau <me@ttaylorr.com>
Subject: Re: [PATCH] doc: centrally document various ways spell `true` and
 `false`
In-Reply-To: <CAPig+cQ2miLtU1HXCcn7q6GqTPiBAqKT3gGOMoug1m0VHczN1g@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 11 Feb 2025 12:42:23 -0500")
References: <xmqqy0ycz9dk.fsf@gitster.g>
	<CAPig+cQ2miLtU1HXCcn7q6GqTPiBAqKT3gGOMoug1m0VHczN1g@mail.gmail.com>
Date: Tue, 11 Feb 2025 10:11:35 -0800
Message-ID: <xmqqseokxsfc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Feb 11, 2025 at 12:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>> doc: centrally document various ways spell `true` and `false`
>
> s/spell/to spell/

Yes, indeed.  Thanks for sharp eyes.
