Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B79223F431
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764019167; cv=none; b=QdIFhL91P47jBXgvea6xUkI+bW/2czS/PxUzoB1bj/3e1YEqswRP+1v+GEVKbT8iw+gu23NUbdYd/bDtg7Lm5CFATNGApg82ajq6ioquTK4kebax9ajpgSwE+l9N4leZF/ram8GJxnfBSVYK/atrdDbN28LSEPpQoQtonaR54Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764019167; c=relaxed/simple;
	bh=Ccru+xKk9tbqUq/4dwxyZQpG0DSwcwltn7q3OIBLCWs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cvl+wAlB3jTOPvZDj8I8ybyldpXDLeC0Xgio/uFW3EWpvvtwaDS1oMCMlYNxTV5IXQK67Ua4nVLDqg5rifZzbo9EEcdS58jLLyoLY97qxf487wKL0WQeNU30Iw27uAax0ydSrdN01anxVz+pHbTh7o53G5bSTxb7s5erZSvrP5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gmoIShU1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IMpZ7rWf; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gmoIShU1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IMpZ7rWf"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4BEB5EC03DE;
	Mon, 24 Nov 2025 16:19:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 24 Nov 2025 16:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1764019164;
	 x=1764105564; bh=ELpczhfMw5rUvz0qa6vdsajSSXKEXHdbZFe7ZfCsDKM=; b=
	gmoIShU1lF+Rit7KUwPSUlrlNlQ8JiBKtyAoahgFGX/kd34P+ZZNMKmtJ8iboq1x
	xEa+hGi0mniMw1h0J6W1u5t4bsrKELf3l1DEKg2nxhfXY1KBCh9Rq/nRjGMsRpe7
	JqxWJhnpIKXHAJ5PlS98kVrzoHuzXFTM53Ymspj4qkuX6aDmLTxnW0Of58P90Plp
	0dOVt04GKa0Ax7V6xL4OK7z2qADLeLkLofrpEvCMrt5KXbZPDnxW1P1BXF+5MdLP
	fc0JwDeDcBY5uYyRU3MbHAc6nafVgU4+lSKsbz/588geTsikqmzCHKByD3StP8R4
	3W8J1+9u9YUFN1evgR2wAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764019164; x=
	1764105564; bh=ELpczhfMw5rUvz0qa6vdsajSSXKEXHdbZFe7ZfCsDKM=; b=I
	MpZ7rWfAbN9EDofRDiNbXnjaDSuQotZVrdcDNoojm7eDbV88myPwk/GoTUUPAkJF
	GV8+M6yaOIjvkRGtV7Uf/iFOzoa/gyNJB6U9LPU49ut6b+pbS9UT2thCd58WRHdt
	ytrqXlv8AGhpTZ9P11pk34/66j2uOQ+LYN/QKiMGlGMha2vx7MO+eGLGNze9AfE6
	4Wkxuhg8C0hVPd++DP925eS/fUP/FHFqXOsnVyeE8Tjk9p6IU+Xj4eYAa/ElYY+Y
	ZpcqvhyfwPnFwTuDEdt54Qexl4xGFR4xrFt+nkp9/YhPt2eonS345mwVuL49JSrO
	76KQE7aqJt5STYjzuIfqw==
X-ME-Sender: <xms:28skafXuiy6AOb2G6UqfL2oZcL4TCWoRdQMaLJT0afu_pt05pYGMmQ>
    <xme:28skabQdkkELE8egVH6bYlzgLpe2AEnKyBADmETaEA54yW0AfcqVHUl7U5p2y-dZI
    ZIkb3f51Pw6aX2PCznvqNyren2umIDvuYPOxE5zuC6vGLf2FRIosQ>
X-ME-Received: <xmr:28skaVO4mfQjXlrXgfZTJvmkkXToS2G1CcTlCF6ryO4aZMBPIb3FsqC_c7Kbk_AMGDsdXPk5D30cRaKw4ok8MEuuxWSm47WTNrEM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeelieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehrrghnrdgrrhhighhurhdoghhithesshgrmhhsrghrrgdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehrrggrrdhlkhhmlhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3MskaRR9fwvYHzg7Y5f4OvpKe9CwuPmX7aBnTYiQSyGfKgm97F_K-Q>
    <xmx:3MskabgIjny0mEM_ay7M2V8i8ZjN1V90q_oS096sYZ6nESBc_wJj7g>
    <xmx:3MskaS8lH82vo9MgK52FkaWhTCCZeCTe6wbaf_gF_uGrc9Pw83sZOQ>
    <xmx:3MskaaGFB2kmZmQBoseEPv-WtW76hIGX4bs0adP5KALMTOuHAeyAuQ>
    <xmx:3MskaY4c9qshK44ozn7M46w9jkkDBZJ-WnA-1iN59bONwIPKkTBrO-zN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 16:19:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Ran Ari-Gur <ran.arigur+git@samsara.com>,  git@vger.kernel.org,  Jeff
 King <peff@peff.net>,  "raa.lkml@gmail.com" <raa.lkml@gmail.com>
Subject: Re: [BUG] `git clone '-c KEY=VALUE'` no longer works
In-Reply-To: <CALnO6CBJppT3ELyu54rJvP+uqcMomJS9Nr_JTgfssn8iqG7MWA@mail.gmail.com>
	(D. Ben Knoble's message of "Mon, 24 Nov 2025 11:20:05 -0500")
References: <CAN1UxBvk_GJjLWd0XexRxp8FFhYozGCNcodai0eqnjrhjKEh7Q@mail.gmail.com>
	<CALnO6CBJppT3ELyu54rJvP+uqcMomJS9Nr_JTgfssn8iqG7MWA@mail.gmail.com>
Date: Mon, 24 Nov 2025 13:19:22 -0800
Message-ID: <xmqq8qfvw2lh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> On Mon, Nov 24, 2025 at 12:23 AM Ran Ari-Gur <ran.arigur+git@samsara.com> wrote:
>>
>> Hi,
>>
>> There's a small regression in Git v2.52.0; it used to be that a command of the
>> form
>>
>>     git clone '-c KEY=VALUE' ...
>>
>> or
>>
>>     git clone '--config= KEY=VALUE' ...
>>
>> would trim whitespace around KEY, making the command equivalent to this:
>>
>>     git clone --config=KEY=VALUE ...

Hmph, as documented in "git help clone",

    `-c` `<key>=<value>`::
    `--config` `<key>=<value>`::
            Set a configuration variable in the newly-created repository;
            this takes effect immediately after the repository is
            initialized, but before the remote history is fetched or any
            files checked out.  The _<key>_ is in the same format as expected by
            linkgit:git-config[1] (e.g., `core.eol=true`).

I do not offhand know if the option really used to behave as the
original report described, but if

	git clone '-c KEY=VALUE'
	git clone '--config KEY=VALUE'

does not complain-and-barf in the first place, I think that is a
bug.  The above option description clearly asks the user to give the
dashed option (either "-c" or "--config") and "<key>=<value>" as two
separate arguments on the command line.

Interestingly, unlike other long options described nearby, we do not
seem to even list "--config=K=V" form, and that is a documentation
bug---other options like "server-option" is described to use "="
after it before its value, and to parse the "--config K=V", the code
uses the same mechanism.

Also, if the user writes

	git clone -c ' KEY=VALUE'
	git clone --config ' KEY=VALUE'

and we behaved as if it were "KEY=VALUE", that is another bug.  As
documented, "key" is in the format as expected by "git config", and
we never allowed leading or trailing whitespaces around the key
names.

So I dunno.
