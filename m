Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA9C2C375B
	for <git@vger.kernel.org>; Thu, 22 May 2025 23:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747955762; cv=none; b=R8ZzydDZRO8peI4/eNR7sHVWBQ/bMjWxGIDkonykFl2B+NVdvj+eyd406YSnd7ypU5ASd13fCSafzzMU01cnNzTiksF1I9Md5rQHZ2E44lD6XexeaF4fsmP57oZzYI+lENzgmtbkWGNGw+h3eTIPKQI3AiAJBxN4W0N71/+4naE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747955762; c=relaxed/simple;
	bh=u5MT9bT/NRs3K+WpXCfRtYA5619DU55s6Q+hVxSoqHM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lMoUcM/5YL141etZA0wBp5qBgkH8aJqU949XklGqGKBCaD7TC4GNvjP/rZswxX51g15g5UtSfFKqbLaGiHFB22SYi8DCSM2ocMH1ldf7ek37qaKOvgPAD/qfTcL2kr7ZepDerwnIy+QNwYlmCYxoHJh6teF7UNiElua0pqq4mkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YDbvjTsz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ccqM/mCr; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YDbvjTsz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ccqM/mCr"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 251001140145;
	Thu, 22 May 2025 19:15:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 22 May 2025 19:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747955758;
	 x=1748042158; bh=RuZxmfZOaRKs5S65uhdi33+dKxT0IoQqz/uiAaRJSSQ=; b=
	YDbvjTszGfQZOWHkPTqlzfLGZWd3q5d5ESDp3RFhyNdiEaSHZr72URT1GFim51eQ
	C+kS5bOBd52qefaGlWhGbXN2Nnp+0cxMa70Ytb6RK0QlzBaxJ0zY65QnH7cRXIiC
	Hx/QQ5W9MGmogSQ/YzdeNqstXmegVIM4HiiLPrKCU/Z0kzS2vZNqd7PzvSDrCTsP
	DEbwsnM/IlWRfSrcEpHiyRDJF1rC0Yi4QHbJzDDOievONXBqvJWuOpepv/9wVJGM
	a95HyCCsF6YOkr2Se7SwNtNgbzpqYppWfDu8scvMip6vR/+rHoO4WnslsLCFfh3M
	6ohQRS+oq4U0t8P5LPGUyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747955758; x=
	1748042158; bh=RuZxmfZOaRKs5S65uhdi33+dKxT0IoQqz/uiAaRJSSQ=; b=c
	cqM/mCrOA5ZlxncLD0bijQn6NeZ6uYuGQ+NcdcT6ETyB9CFJucavRwo2TPQ8ltfx
	AbgZKuFODAh8jCOhdjklHLtJ0JMIR9U+d961f3dp6U5+GzSN3yxF35NatokcJMaz
	HJzPbhgD8t/P2TzOfQLEzDbtHql1mBI3hH0PSIf5XpHM68y+4+WM/OI3rTv1NhoW
	mK51nY39+LYRfAWjLmOxDGZdNziAQkL/Zbd8b5cbtgfsafsPFQ4Ig3vKUKOmmBMu
	qFoxrsyW1fRfoZQFC1c6rKJaP92okPmYIp7+cZ5SphpkXlNeYWkGzy9DQ0kZFAeD
	x0Tnm/XJkZL4rEqKipf5g==
X-ME-Sender: <xms:LrAvaOWXgGq_J0nxVaD1RGKhKmuB9zTQoZLbWWqhlwcHQK05u1XPXw>
    <xme:LrAvaKmGSsYkpVIBA08DvQHJPl7gRHabn3HKpsy_YD_lzV-CYBElUhF-as1q44_K2
    DdqDq9xmPbpn4i9Lg>
X-ME-Received: <xmr:LrAvaCaE4wsXl2dqZeVyaXWvpBDdSftcSCHalwN7asIVVCiXP7Y07sWod7jKt21kw5jCfCZDMwstBJuo330i8RCT809Sj_oTJSqE-Nc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdejvdehucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteeg
    vddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdprhgtphhtthhopehmrghrkhestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhgrnhgurhgrphhr
    rghtrghpfeehudelsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:LrAvaFXUhIRZy2J1nn93Dhl7NguGUgGLbjGHWIrDl02DHQdvV6KRNA>
    <xmx:LrAvaImK8nMM9VHC8QQjfOAOmSMnoNHQT7lrAh4pcpaSmXw-oE4TXA>
    <xmx:LrAvaKeu7kvpp76DIyvONG2qHt_aXbzsubgshIAuL3lTs7kLST47eQ>
    <xmx:LrAvaKH4Gwx3Cld-A8LaoRLCicDdTL5IesfHYQWo3Dookfhlw6swQA>
    <xmx:LrAvaKUtbAMTgZM3jErkQgfnzXyEnJsluPrSEEPDXVs-ElYlCZyJJW3z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 19:15:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Mark Mentovai" <mark@chromium.org>,  "Git Development"
 <git@vger.kernel.org>,  "Chandra Pratap" <chandrapratap3519@gmail.com>,
  "Johannes Schindelin" <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] apply: set file mode when --reverse creates a deleted file
In-Reply-To: <91c86145-1a78-465e-a08c-2fb727dc5a02@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 23 May 2025 00:24:11 +0200")
References: <20250522220235.8650-1-mark@chromium.org>
	<91c86145-1a78-465e-a08c-2fb727dc5a02@app.fastmail.com>
Date: Thu, 22 May 2025 16:15:56 -0700
Message-ID: <xmqqplg01bkj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Fri, May 23, 2025, at 00:02, Mark Mentovai wrote:
>> Commit 01aff0a (apply: correctly reverse patch's pre- and post-image
>> mode bits; 2023-12-26) revised reverse_patches() to maintain the desired
>
> The way the commit is referred to is almost like the usual
> and recommended
>
>     git show -s --pretty=reference
>
> But with a semicolon instead of a comma.
>
>> property that when only one of patch::old_mode and patch::new_mode is
>> set, the mode will be carried in old_mode. That property is generally
>> correct, with one notable notable exception: when creating a file, only
>
> s/notable notable/notable/
>
>> new_mode will be set. Since reversing a deletion results in a creation,
>> new_mode must be set in that case.
>>
>> Omitting handling for this case meant that reversing a patch that
>> removed an executable file would not result in the executable permission
>> being set on the re-created file.
>>
>> When git apply --reverse is used, reverse_patches() will now additionaly
>> swap old_mode and new_mode for what's represented in the patch as a file
>> deletion, as it is transformed into a file creation under reversal.
>
> The usual way to refer to code behavior is to talk about the code
> without this patch/commit in the present tense.  I think this is talking
> about how the code behaves with this patch applied/with this commit.
>
> In my opinion it helps the narrative flow since something right-now is
> problematic.  Therefore (see next point) do this and that to fix the
> situation.
>
>> Tests are added that ensure that git apply sets file modes correctly on
>> file creation, both in the normal (forward) and reverse direction.
>> Existing test coverage for file modes focused only on mode changes of
>> existing files, and only in the forward direction.
>
> It’s recommended to describe changes as “do this and that” to the code.
> “Add tests”, not “added tests” or “tests are added” (and the latter here
> seems to use a passive construct that doesn’t feel in line with the
> preceding paragraphs).

Thanks for pointing these out.  

The phrasing convention was chosen not because it is superiour than
others (e.g., as long as we do so consistently, there is no logical
reason why describing the state of the codebase without the patch in
the past tense and the state after in the present tense is inferior
to how we describe the state without the patch in the present
tense), but to have _some_ usable standard way to express what the
status quo looks like, what the perceived problems are, and what is
done to improve the situation.  What you described is what we chose
to use, and it is good for all of us to stick to it.

