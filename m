Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAB9284880
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536559; cv=none; b=dotio1Lo1H/qHkhzMlHaaQ1nCgBWO+TuPhVvjJjIeFTR6skZ0Dl0TnJYxCTYBIZTXvVcDeH7Q6C49W30FaXaK+8MQ9mOp2Mf8c3nQpKIa6BT6udmts2eafKYLC9HytsPE07Q27pgLEh8tPOHuHsOfd6uaQX+12EaSoYEkFnVM98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536559; c=relaxed/simple;
	bh=r4KFslxXNcLluQwQjha5FtduQXgKpfCRvTGxWkhyLTY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AbjGTn3m8TeuCAx81w7E6JJ3rej0S65wcA/NlAGEAwdO6L7nJGo/CUNi8ZvBFd9kFU5FyKp+JeDU0MUwy7k8iVrpCfD4lo54EUlhxt7IScW7g3t0zcSuknibD0JhB9wq8nO6n87djob0zxrZRTimtaNfHvZme3svy+4XOcELVUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eQ2iXTiC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f3hJekSC; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eQ2iXTiC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f3hJekSC"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 03BDA7A0063;
	Mon, 18 Aug 2025 13:02:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 18 Aug 2025 13:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755536555;
	 x=1755622955; bh=e76cmeRSRjyzHjiqvdidoRZ5i4+gJxq3fig8D8gd9lY=; b=
	eQ2iXTiC/btKvhDO2I1OD56ssMghW29VtNoE7C0/u906Ud8/OhicNocODVexltI8
	eLcL7CnCktuQDEItx1m9K8uy7yGRlBm3HfPhgnhnyOLQj6sS/MdhHqdXXA+M+9XD
	M30lw3GxUqjYJv6YQK7nOfBXNi4MHV6T1BujLAqv51VtTGC0SutyBLDFy/i56n1e
	ea+KomqJljsIpCrSw0xI9pvfh619d9oT7Es7uS4kJE/YJxOQNh/h3AS/ue3B/Hqg
	yl52Q6/XFokvqSHvDqdkqic+bhly62QckXBkl/n/hQ1Rx1A0BHj5MpArgQSq2kRt
	7YYMBzvtIq/xtbowHhMrow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755536555; x=
	1755622955; bh=e76cmeRSRjyzHjiqvdidoRZ5i4+gJxq3fig8D8gd9lY=; b=f
	3hJekSC8HAZ1ki28h39I1NZdvp7BuDQlElQnmNrU4rVOhu3gwXSs33qf0Zu0x3VI
	SroWynJYGY6BHjpjjxWwMl20p9jDvAagRKmQilRC7qlNu+oDfTH565imL8oWTttY
	O+o4Lo3cY+Qes73QXvgiGdYBpA95CJnZJZtdpp9/FhMeBzQovIa7r9rTKybWA4qG
	7hnslAUA/6JwHQA71hcajTEiCul5d0I8xCXYqfIFGlFxEbrbi0M8gMnpGsDRHdoc
	EKY4Sv205BtpmTOCc+xNpN0KpXs+S8qC6i1xG9dWoAOb7+UrurPo2zV0LmJMTzDB
	okg1ikcz3Ill7lMNfMAnA==
X-ME-Sender: <xms:q1yjaMvX-EAJFSDSWvPNGfyCs7Pk_b8GGpBrKf6PzrLrmr2Tkntypg>
    <xme:q1yjaNQXrXxjz35g-LHKUks17wBOAr1SBaIJT3O0RecOFfdMWQclZZCn5JVCQuAUX
    gfgTIbR8mzmj1T1_w>
X-ME-Received: <xmr:q1yjaA392Lo0w5KI-0waILt02KD4h00oq71wj9d_aXHAFclMwEfF5Q1ceddJlHB5ixXsTq39WFcj5HEWqRlVYmrfdcWibfC5VbHt7pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheefudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkh
    hufhhorhhijhhileeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtoh
    huuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:q1yjaCvIk4PHdKbEFMyZawiW-ohZPJ0cD9sscfFlPEbI821j3hRb9Q>
    <xmx:q1yjaGjXzyv8e1Vs_7Wp1e6_I6byy1AD1q4j8ukZambzIYph3_Hi-A>
    <xmx:q1yjaD_lcro1gLbwzqKhZ_UUOl07Q4hZO1e3ASfYcvPUj4wzsbD5Sw>
    <xmx:q1yjaJtT3wlO7EdQxqu78zEYVEMEMfBCDZR5lC-Az2mbxMJRp1lNpg>
    <xmx:q1yjaF21E8zKaDZNf_iVPaDHm-7LSl2P38HsBMSG_FCUpWYDMuoBMhOL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 13:02:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Taylor Blau <me@ttaylorr.com>,  Christian
 Couder <christian.couder@gmail.com>
Subject: Re: [FEATURE] Proposal: git format-patch with `--with-line-numbers`
 flag
In-Reply-To: <CAGedMtd_atWTAQXOPSJThB_tpHiOSY=PUhrfFxFZOEkgUtHf1w@mail.gmail.com>
	(Seyi Kuforiji's message of "Mon, 18 Aug 2025 11:08:43 +0100")
References: <CAGedMtd_atWTAQXOPSJThB_tpHiOSY=PUhrfFxFZOEkgUtHf1w@mail.gmail.com>
Date: Mon, 18 Aug 2025 10:02:33 -0700
Message-ID: <xmqqfrdok1g6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> While working on converting unit tests and sending patches, I ran into a
> pain point during review. The reviews by Junio, Patrick, and others pointed out
> issues in my patches, but without line numbers in the emailed code
> context, it was sometimes hard to know exactly which line was being
> referenced. I had to manually count through the diff hunks, which slowed
> things down.

Count through?  I do not usually see a review that talks line
numbers (e.g. "your change to line 772 is wrong and should look like
this"), so I am not sure which review comment against which patch
you had trouble with.  Can you give us an example or two?  URL into
the lore archive would be good.

One things I try in my reviews is, even though I trim my quotes
heavily and leave only the part I comment on, I try to leave the
filename part (i.e. "diff --git" line) and the hunk header (i.e. "@@
-L,K +M,N @@" line) in.  See

    https://lore.kernel.org/git/xmqqikla86id.fsf@gitster.g/

for an example.

> To address this, I’d like to propose adding an option to `git
> format-patch` (e.g., `--with-line-numbers`) that would include line numbers
> numbers alongside context lines in the generated patch. This would not
> affect patch application (`git am` / `git apply`), but would be a visual
> aid for mailing list readers.

"This would not affect" how?  If you show something like below, it
would break it so badly that the patch would not apply at all, so
you may have something else in mind, but I do not know what it would
be.

diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index 980130be78..e12e18f97f 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -112,16 +112,19 @@ do
112 	adoc="$(builtin_to_adoc "$builtin")" &&
113 	preq="$(echo BUILTIN_ADOC_$builtin | tr '[:lower:]-' '[:upper:]_')" &&
114 
115-	# if and only if *.adoc is missing, builtin shall be listed in t0450/adoc-missing
116-	result=success
117+	# If and only if *.adoc is missing, builtin shall be listed in t0450/adoc-missing.
118 	if grep -q "^$builtin$" "$TEST_DIRECTORY"/t0450/adoc-missing
119 	then
120+		test_expect_success "$builtin appropriately marked as not having .adoc" '
121+			! test -f "$adoc"
122+		'
123+	else
124 		test_set_prereq "$preq"
125-		result=failure
126-	fi &&
127-	test_expect_$result "$builtin appropriately marked as having missing .adoc" '
128-		test -f "$adoc"
129-	'
130+
131+		test_expect_success "$builtin appropriately marked as having .adoc" '
132+			test -f "$adoc"
133+		'
134+	fi
135 
136 	# *.adoc output assertions
137 	test_expect_success "$preq" "$builtin *.adoc SYNOPSIS has dashed labels" '
