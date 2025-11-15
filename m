Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860972FE56B
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763224940; cv=none; b=to5Awh/YJQz6kfK9hyeIXynWnJOP69ncLqcu+0WH067LnMp6UqTiGDQJeUt0BNYfHp5hpNVE66qHtCtlolEcKEwHhC3FKFeCymFa5SeLT/6zTBKW1T9C1h/powrSXRUMWahGNrShgAKhGTAGqjbqwTL2u4fNQnlycbs5KfvdevA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763224940; c=relaxed/simple;
	bh=FXOqaVAaRgV/O7zwzUeLAyTL8rA85VeyOhwQ5X/IDB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DAmJdA/TbUwIIBllAiqEaKPxxDGXO9dpM4FBFw8YNfG/PjuKxydAAFqS1obWjR1UO4xElT+KK33A0Y7iRTyOdndGHoDKKhIyjrhIKuRVW32PWMQ9YnioV6VWhKtfv/pq44TxNCPEcuHMx2w1roRBqfPWSrWaYdq6AjOV6OD3d+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C1m/t/qZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q3Y07HYe; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C1m/t/qZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q3Y07HYe"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 690921D0014A;
	Sat, 15 Nov 2025 11:42:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 15 Nov 2025 11:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763224937;
	 x=1763311337; bh=Ws1nGrG3wI3Nlsw7hvGTf/v2qzJlSuLqBT+zk+lkRsE=; b=
	C1m/t/qZW5umCGVQ3bdfjypiAQ2Qdqv11DuwUrjvFsXS4aktaVsc6t+gMs84JPLi
	uUfHqQyjEyR6GgIioYKIpCnWJvTdVQwoZ5lK/voQ0XWKnsjZW5acVyvfEVjLD/NY
	Bw1quPJ5+E+xmj2cRfqrlr6ZsQc+p5+7TSdMcSeUf6J5KinU23NT6Wgb43Bb1Tkj
	+4ZRcCIgXcHBHsxwThBOlqitkkg5angpA6bm+iztZpab1gEWLf4hfEa3zO94aiB2
	kj5bdY57CvIEqdGXBPVn+QSQc/TukNzTmM8AKxDth2aWmNDS+gvI6QLrSMdCXHiA
	POUBi1iMeVJgagE0txp76Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763224937; x=
	1763311337; bh=Ws1nGrG3wI3Nlsw7hvGTf/v2qzJlSuLqBT+zk+lkRsE=; b=Q
	3Y07HYeaz7Ji9RG6xvWvdXLigQmOoGGg89qOCbxXszWEAZQ5a42oMWp9ymVWp5CY
	G95CfDYbX9VMS2LGpCjGgjIQDDiMgzpKWH7o4B6CIfg82bo2HsgwAX9wMUtHlQCd
	/UGS0HvwcQ73F4djhRU7IY3slt7RGOVpJMSfI4fyHP91nia7PBUogXo/Zu6BirZ4
	cUkS0k4XKFPhGUMD91l4UTxFQj8yDQMIbtV1yOfwVleH7vzMpthHvmQ5hGDe4upi
	yNA9X4Mmj7MCKFIdIMayFCycb8rCvc7dHEDgxlk8HdaUfTXKEMOaIdZbk0zFv1nz
	ptXLTSL1Qt9U1ZuiJapQw==
X-ME-Sender: <xms:aK0YaepGVPDRpn73jHpkuX8YLH3DwJHn61hiTzfnsfndQg2RFQ8XiQ>
    <xme:aK0YaftuxYdeq2N3l-xEnaEezmCf61tykURTHpdVeKc12IEzzSter9jtfQww1_e3G
    96kIYnlZ9UeROfNqIThuoOAz1vS8tYGdcY10VE1IKhaG0ntVELU7Q>
X-ME-Received: <xmr:aK0Yad2aR4akBVdTjjGDAoVBSvVf8kedqOmGZe3zS-xJ-yq9Eo_v4mH-8B1UuJS1UOlXpeXrGLdo7uV53bVs9hL4AMLCwlD_5LhN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudefvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrd
    hplhhushdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishdrthhorhgvkhesghhmrghilhdrtg
    homhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:aK0YaaH1XcQCHWnVMX8vkqwIBeSGmwyuz4omsxQ0UEQ1hVH7j-h6Pg>
    <xmx:aK0YaYuk3KinXn0lSco-k7uMyiNg9Ds-VmeZIWd6BZCqv6tN25lrAQ>
    <xmx:aK0YadoBXR4KY78VoKO3K4XyXTQtisow9MY8fmHBN7DLKQw5dr4fsg>
    <xmx:aK0YafVntsfz1smP4XUjk4eF_9vrNe5B7Dgqawa3qZlPiE-ZjYTs_A>
    <xmx:aa0YaSg491DwaXqMv0Qs_yo6lQw82EoBuRy17IgxpDd9Ru27IBKiIxpy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Nov 2025 11:42:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Ben Knoble <ben.knoble@gmail.com>,  Ezekiel Newren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Phillip Wood <phillip.wood123@gmail.com>,  Chris Torek
 <chris.torek@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v4 01/10] doc: define unambiguous type mappings across C
 and Rust
In-Reply-To: <a30ad114-61c2-4eed-a24e-033b3b9d6d0c@ramsayjones.plus.com>
	(Ramsay Jones's message of "Sat, 15 Nov 2025 14:55:07 +0000")
References: <23b7fd8a-2b50-4da3-bc8a-3727ee99654f@ramsayjones.plus.com>
	<5A740EE4-D545-4828-8D38-E0E5E9F87A3E@gmail.com>
	<a30ad114-61c2-4eed-a24e-033b3b9d6d0c@ramsayjones.plus.com>
Date: Sat, 15 Nov 2025 08:42:15 -0800
Message-ID: <xmqqpl9jfdso.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> This was discussed briefly in replies to v2’s 2/10, where
>> Ezekiel said that DEVELOPER=1 warned about sign issues whether
>> char was compared to int or unsigned. [From mobile I cannot
>> reliably paste the message ID or link and preserve a plain-text
>> email, apologies for the oblique reference.]
>
> Err... sorry, but I don't see how this comment relates to my
> email. puzzled! ;)

Me neither, but I suspect it may mostly use of non-word "signless"
that is the issue.  It is understandable for the -Wsign-compare
warning (especially given that it very often complains about
perfectly good pieces of code) to complain when you compare a "char"
with a signed integer, saying "on a platform where 'char' is
unsigned, you would be comparing signed and unsigned values with
this expression", and at the same time complain when you compare a
"char" with an unsigned integer, saying "on a platform where 'char'
is signed...".

I'd say it shows more about how garbage -Wsign-compare is than about
how 'char' is ambiguous and should be avoided, but others may have
different opinions.


