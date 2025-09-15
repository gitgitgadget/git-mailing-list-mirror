Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E09F2080C8
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956784; cv=none; b=J13KaJRuQW4WcFjtAQjnwu7cS1E4Dr2qKFUCaQTdWq+Eb99xr6WPDdPJP0t/9S+EXGw7gpii9wLIxoQpe0Zk8Oun+L+v7gIwJQ0cuF5Q4QrATjl9Smp00Z1B3/XTnefnt+7KXhuZN5UqWy/wSuePX0YNY/PVUcGeC6DBplAQpUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956784; c=relaxed/simple;
	bh=5w1JX//CoijvfvaGeDcEpHg6Qwnx7WVGu0L1B8q/m5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CJaQBiZ+O/HYZbHYlTVJ40oa8cWVgOBLzNgR9ClEhiBh2TdE9qU+e961l0gu4ExBNQ7tdEHFhPxTSBAu9TzLUy10Ga5jpkaRQ2EJc++ne1A6XyObPLjnjsFW8zGrY2lLyZjOWLoBmYRAXGFAo8OJCs0eOa3dOwUIuHRay2UNbvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T46a4WPF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=icOLAf5K; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T46a4WPF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="icOLAf5K"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 43066EC02B4;
	Mon, 15 Sep 2025 13:19:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 15 Sep 2025 13:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757956781; x=1758043181; bh=w9t/khEhv6
	WOHi+RHtWadpV5/MYsjAw1+823SJwAp0A=; b=T46a4WPF/NkK0wKCPNBLralFS5
	upHpMqgYylQonG+YusScsV3NAxYDLce42u5AbBCCdRlQloe5zci5hbbqhqp2ySuW
	jrA1lyfU+CLX947GwmvvBfe0K0nyv2F/kG5xjDS8CZnKkiVLHmMjdezgUe4mqiyw
	0xKbFHTT+aNur5o8RM0+Ba5W0pFWhZL4ow4MKwdcG7pfyrTNfEznOWaByJurL/o9
	K9/XflXBqB2iYjxZ5alCYSL16/J3O8eXDXEYIUAolsj3spMesTU0E0q3FSUdWtAc
	O2jHD+FV9Mi8F3JOEwLXcc4cdNpYUtDj4dLTqY9Cz0XGrJoiJAu8QV3YqTvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757956781; x=1758043181; bh=w9t/khEhv6WOHi+RHtWadpV5/MYsjAw1+82
	3SJwAp0A=; b=icOLAf5KdYyp8C771U6JNXeVilqMc2FvlWg1Wqli1yr1PNIu+ec
	x4GT4c5x+OaFN78fb+Xodgoa/u/934qJIYglVg9QqmQCOAJMY+0VlFoebevkI866
	KFZrD/44D0s8rvLP8aw6lOys0mNSF6vn1FnlWAGqxDbB9DzpEotkA6bJoawRgjQJ
	YsZzf6rF1+Bua5c56zIrDFO4N7KqqSm6vWrb8BAJjSQO53QU4qhTU6MzyP4hDumN
	0sf1jqiQffJf9Rsf9dVG9CLiwWbbG6BUkz3FYTNJeMq13FuOnE71dR/6AhlBsjVO
	yo7hEk4u1HkdMKyRBn03tXL9Ga8rDGlb2PA==
X-ME-Sender: <xms:rUrIaEv6LsDp2yTgINdcFToYJiGuRd1TdiUc41ZoD1smSHKZqIFxVg>
    <xme:rUrIaM-GFnNlAHRJ2HK9akAtqj7L4kI9ZpMkpMfMiyveRbFySwfwrTOHCOA9xkWcA
    TvJls292CiDWS4vTA>
X-ME-Received: <xmr:rUrIaGOKKowh2X0n-57YbOCKb8QLOcVcevyFIBSHlQOU2wawLAgFfoVsKBxywt3VBKwC8rA0RiFzWIAQE3oPYI3XoKEgDOzeM57PebU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhm
    rghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:rUrIaCGby4iyjZvGmCn9FZuG__b8II72dy5c65tSTvlEV7vKy5u_mA>
    <xmx:rUrIaMQMedBNYxLif61H-RPwePr1overY1bEzJscJU7xae3IGOkOIw>
    <xmx:rUrIaHvP65fjKJj_9kJYxLWFeFm6zuvxq2Z3XnXcs7QytmWrGRSQLA>
    <xmx:rUrIaMIapXJA27PwpIF3LUwat_ZSQJl8C9C2hUlo8cylg3Ma7dsfCw>
    <xmx:rUrIaNevvd60scvX_FhuTx90AP9miO4Vp7iZcqY56zP30DSn16cyeBPd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 13:19:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 4/5] builtin/config: special-case retrieving colors
 without a key
In-Reply-To: <20250915-pks-config-color-v2-4-e4290bd8d13c@pks.im> (Patrick
	Steinhardt's message of "Mon, 15 Sep 2025 14:52:51 +0200")
References: <20250915-pks-config-color-v2-0-e4290bd8d13c@pks.im>
	<20250915-pks-config-color-v2-4-e4290bd8d13c@pks.im>
Date: Mon, 15 Sep 2025 10:19:39 -0700
Message-ID: <xmqqo6rbhbv8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Our documentation for git-config(1) has a section where it explains how
> to parse and use colors as Git would configure them. In order to get the
> ANSI color escape sequence to reset the colors to normal we recommend
> the following command:
>
>     $ git config get --type=color --default="reset" ""
>
> This command is not supposed to parse any configuration keys. Instead,
> it is expected to parse the "reset" default value and turn it into a
> proper ANSI color escape sequence.
>
> It was reported though [1] that this command doesn't work:
>
>     $ git config get --type=color --default="reset" ""
>     error: key does not contain a section:
>
> This error was introduced in 4e51389000 (builtin/config: introduce "get"
> subcommand, 2024-05-06), where we introduced the "get" subcommand to
> retrieve configuration values. The preimage of that commit used `git
> config --get-color "" "reset"` instead, which still works.
>
> This use case is really quite specific to parsing colors, as it wouldn't
> make sense to give git-config(1) a default value and an empty config key
> only to return that default value unmodified. But with `--type=color` we
> don't return the value directly; we instead parse the value into an ANSI
> escape sequence.
>
> As such, we can easily special-case this one use case:
>
>     - If the provided config key is empty;
>
>     - the user is asking for a color code and the user; and
>
>     - the user has provided a default value,
>
> then we call `get_color()` directly. Do so to make the documented
> command work as expected.

Yup, the UI is still ugly because this is not config at all X-<.
Only because we lack "I have a color name.  Please parse it into
ANSI sequence" command, we are abusing the "git config" command and
using "--default" as "here is that color name I am asking about"
argument.  Even if we were to add a more intuitive "parse --color"
command, the (ab)use of "git config" for this purpose has been with
us for the many years and cannot be dropped--and under that constraints,
I agree that this patch is the best we could do.

Thanks for working on this.
