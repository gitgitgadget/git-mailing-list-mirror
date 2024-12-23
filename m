Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD30718A6B7
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734977318; cv=none; b=O+KXvEPlxliS+bGyQnVA3J15qoVWoc7RExXNPlgNtLifQqhj/6k/rCS7QtB3cMow2mYcltbrR4oEauWxQUJJcGlpo2YGd2OcsLToxiyHsP9oV5t4coTSg3YVwikqH9euvxtbeAkmuyc4/OHrvBoXdLmYwv3eOtF8xhp1XNlhTqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734977318; c=relaxed/simple;
	bh=x3hAG5M10DCgcF3+XQvZvh7nXEIALSSrmBHIz+Zt8Wk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FeO11P/woY6RBIrlrCRdb3bC/7GcxUQQPBrv+HTlw8a5MLCBlT0viZ3zbd+0YTQPmwcXVcrVpSnN8YrTYl3y1C62BgvhpkaG2cvWLhjaToAO1b+/75M5Tkr6bhy91cuNxM8+ohwhG8z17E02WnUGbXLAFMrkUpLtz0MhjlMnubk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TwESwFFQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RhYsJaK7; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TwESwFFQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RhYsJaK7"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id D102C1140194;
	Mon, 23 Dec 2024 13:08:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 23 Dec 2024 13:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734977314;
	 x=1735063714; bh=nINMp55EFiIJuaDr+xM3XAojuhKCBWKw/2T0qTp2p6Q=; b=
	TwESwFFQRA6VrGqfUs1RvjvAKiFpsPzSmsMqNOpde3h0iUM7e+djd82GYHW5B61E
	yHmLHi+4+f921sSievsKJyq4aiOoizGJGsQ/OsTPVrWJIK+JOGki3DLnGOX+vOh+
	LyoLCEaDFn0n7tCLp7bnAxqB3AST2cfLeDNIyDtIsNypFxCmtIquotKnnfA6p7qL
	kXNHxpq7c9Mpi4Jp1aoXm514xiVtVF80HpyshbpVbs+JmpbmrXnndy9btYYts5ft
	Tb/DHhZUnlNmTorwK4RYo33hUTYMr9BhBdJEB7kx3KGqHKmnrAE2TY8tm5h2FrY6
	L6ZPt3bHEXXL49cvxbu1jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734977314; x=
	1735063714; bh=nINMp55EFiIJuaDr+xM3XAojuhKCBWKw/2T0qTp2p6Q=; b=R
	hYsJaK7QeyJmtYxU9yaZbb61TCGLQP0OcZSTxGSdZhZ+sBMOU7+8/TLFl1fnlulO
	UdEXdgZi+JuBBtqk/LNhmeyDS8z6H786TIRY6/QShXb99MTAmmhj7iqdoRz0kcET
	s6kXh7wfVpFiErQHeMnOvtLvnfyIEIGS49rYo2busdLjyBS1WFjfWp7WRXCREYXm
	UX3juRLIV+XQs4g/3uwLOLlkmNFISTfblXbIyBBr+GsltYMYVQsTC6KFbKdioxOo
	5N2QVq7lxMxAyh6jFWHUJVS+C9YnNAfiuxpfMMti7Y68+5X7FGqDM8H6+bA3/9f1
	UCXPIz6CGTBdF5BtFgBrg==
X-ME-Sender: <xms:IqdpZ3OhikwTWiDR-YahvAsaJSPs1UazY7nwbyS9Oq9nvikIdZNkLQ>
    <xme:IqdpZx8sDvyXjGCBUK6vG9std6Ad5SnvgmbYLMkU4a4bwnRv8h8e1eDiLodj8ZYlw
    nXfXLewn8IV1bao7w>
X-ME-Received: <xmr:IqdpZ2T7oJNpA20tGn-mJ_2x2oXL0VEoOxek7AFaYeXrDc_6PCTXIcgZvG7TAjt--zgKioOgLx2bes75KUeYcRqUsslDPif2bA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudduvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsgh
    drohhrghdprhgtphhtthhopegrshhhsehkrghmsggrnhgrrhhirgdrohhrghdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihorhhlug
    hhvghllhhordhnvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgruhhluhhsseho
    iihlrggsshdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:IqdpZ7tNejpuaAVVzJxO9s8EG_0-4g1RMnuNZXKR9OEbhfXMcRvAQw>
    <xmx:IqdpZ_fekNbBdGGChfw0yKqO_Hm8UA6iact1KzHhzdQsjBbJjEANIw>
    <xmx:IqdpZ311m8I6eiaR0ru93sdSGRmh-UdX3Jy1ik0AzuAFRgbrxNXPdA>
    <xmx:IqdpZ7_lmK-F-NrHDiy64L2j6KNw-98Je4PIjmLO4fx0hHqSYhoNRA>
    <xmx:IqdpZ3RJ_3d_2mM9aWRdv3GhwEStyymM_71Ae1lXCJ5cap-j0y5KOZec>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Dec 2024 13:08:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Alexander Shopov <ash@kambanaria.org>,  git@vger.kernel.org,
  worldhello.net@gmail.com,  paulus@ozlabs.org
Subject: Re: [PATCH 1/1] gitk: Update Bulgarian translation (323t)
In-Reply-To: <af81f74b-b5ef-4557-b929-c56fc3309d29@kdbg.org> (Johannes Sixt's
	message of "Mon, 23 Dec 2024 18:31:19 +0100")
References: <20241223133918.25133-3-ash@kambanaria.org>
	<20241223133918.25133-4-ash@kambanaria.org>
	<af81f74b-b5ef-4557-b929-c56fc3309d29@kdbg.org>
Date: Mon, 23 Dec 2024 10:08:32 -0800
Message-ID: <xmqqplliz2zj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Johannes Sixt <j6t@kdbg.org> writes:

> Am 23.12.24 um 14:39 schrieb Alexander Shopov:
>> Signed-off-by: Alexander Shopov <ash@kambanaria.org>
>> ---
>>  po/bg.po | 696 ++++++++++++++++++++++++++++---------------------------
>>  1 file changed, 360 insertions(+), 336 deletions(-)
>
>> -#: gitk:2203 gitk:8681
>> +#: gitk:2206 gitk:8739
>>  msgid "SHA1 ID:"
>>  msgstr "SHA1:"
>
>> -#: gitk:8700
>> +#: gitk:8758
>>  #, tcl-format
>>  msgid "Short SHA1 id %s is ambiguous"
>>  msgstr "Съкратената сума по SHA1 %s не е еднозначна"
>
>> -#: gitk:8717
>> +#: gitk:8775
>>  #, tcl-format
>>  msgid "SHA1 id %s is not known"
>>  msgstr "Непозната сума по SHA1 %s"
>
>> -#: gitk:11508
>> +#: gitk:11571
>>  msgid "Auto-select SHA1 (length)"
>>  msgstr "Автоматично избиране на SHA1 (дължина)"
>
> These strings are no longer in the code: "SHA1" has been replaced by
> "commit ID".
>
> I am unfamiliar with the translation workflow. What am I expected to do
> so that you can make translations of the current state?

You have Jiang Xin on the CC line who is much more expert than I am,
but in case you didn't hear from him...

The update-po target would run msgmerge to grab new messages in the
code, mark existing translations as fuzzy when it is noticed that an
existing message got updated, etc., and give you an up-to-date .po
files to be edited manually.

On Git itself, we used to make it a task for l10n coordinator to run
the update-po and translators only updated their .po files, but the
latest procedure IIUC is for the translators to perform both
update-po and translation for their language.

I do not remember how gitk/git-gui l10n was handled, however.

