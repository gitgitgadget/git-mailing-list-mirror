Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597CB3242BA
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395145; cv=none; b=LtjJHcbSj9inYeDkSyTcCEqKTRF7M6+uuqXJNJ/Qr2HXiCT/DypGYK7YDwrESvDpJ5HRPhAup1x/ohmfdcO6QX7kGaqII94UErq/KTLttMWdPwdeELM/eeVpIUuMMukXHrkgndCp7wMxe+kx/O9xFtURqB4vgpaoqVjlbr3idi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395145; c=relaxed/simple;
	bh=5BzGArGxEupGkLL8m8vDQYhlM0QQShKr6wrMXl5vFXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RzCukPWfUaRq8/rPqqJIANXrBugh+gu5FWsMAYWi+HRcq9RGqiLgA8wv7AUnYoysm+gErjyigEAvalor/KQaD8bjkV1tvca3IvWZMLppSgCTQQxZfmPRm/7lyRHJ4FrW0gaAPZQp0A912883GEeW5qZuAqoOpTwPCzRCCCl/Uk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HnSInJTs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rvd3Et+H; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HnSInJTs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rvd3Et+H"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7B66AEC0249;
	Fri,  6 Feb 2026 11:25:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 06 Feb 2026 11:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770395144; x=1770481544; bh=kSQSMkKkEJ
	ClgmRN1qfObbFit2FL0zNihduMEsAWZCc=; b=HnSInJTs45J6BPl4zYF2DzW0kb
	aUfvCIWH0nHo/K3s2xB+y8Ya6rlEttRcNa4hsboNyPVfEae4HHdusTNf0XXs3Bxx
	6VYdi4S/SA31rU+Od85/sn4vxZv/s0q8y82dF8QxNhKthADkOsvp36rH6UcSUP2v
	vIXiqLQnLd1aPkzMenaTOhe9PlWuTbCHGZpe1HTRvYmxbEGKhqjrk0KrI/V15rAu
	UYRQrML0YLURUncXePFklqFuIRoHnNV8bfrV+Rxx2LqGIpJVjHlr4zi+RGbZeQYV
	Gi9K0vAH97veoQm97cN653Et1z2/dC3fBTOMdNrA6Lzl2n453jNCvh/l1f7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770395144; x=1770481544; bh=kSQSMkKkEJClgmRN1qfObbFit2FL0zNihdu
	MEsAWZCc=; b=Rvd3Et+H+Y5PRD6CmruT2WKGYD/2ueG6qMZAcZh2+Vu2tpv5WnZ
	9ODjGdvVskK55Jq6mITxY5Q2KO6ZjdLUZ1izRnBhPBCbGubsjgwPZrzXyS5Z8ulr
	JRVXLHtG5WOG0b/dp7VO4BbK5iN73L4842GDrE2/Bqc0aPJn1nVlnK4IgTGUNlSo
	VtLsLTGrBcsSMoNEtpbRbHB6qeYKw0XCdjiioGddWQS+/W3wCNKhVKg/IhVjG77C
	EHJ/mHUx43SaXibeGPai9iOd/Jy3jUtmmU+K4ZPPvE/Z/m2/r6hZZX87ocSRgo73
	vJDk9QElYsRs/B9xqj2Co/NnwpnEFCa4g2w==
X-ME-Sender: <xms:CBaGaa7l7mCLGpkp6cclUm5o1Hi9WCPlGaKVbmSq1qkkGH1Q1crjYA>
    <xme:CBaGabUWTDo4tj52aooO4OZKKH7BGUBvfhor9O7m-Jtj7vBIKse9Jq1n5pganS8mW
    3vwxD9LDA4QGjhBxoxWq-Wdsj7OIZD2GTJ2p1NXUTwoal1ndYuSYQ>
X-ME-Received: <xmr:CBaGaW1RJkgZD_iH-mXhKiZAIki-g2zDps-OW17x_DlmCl0LB6elRHqetIPAU2X1pmzO1DMHbs_fTzPJeZsYHYWgKlGf3Sm0PQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:CBaGaQ0dv6S_WK1pmKeCYFKdVgk0IbGFEa1vW8aykwKAsV7fN6-jHw>
    <xmx:CBaGaR-I1lGGlJdUw5jL5TAAZQmvfHi_albdORhqj6Q_AcbRvfp3Jw>
    <xmx:CBaGaV1Qyf8lVzNPs1I5w54n8LKetWpZLWnL7d7fPjaQ26iyWEwxjQ>
    <xmx:CBaGaW_PefAB5WJW_tqmb9I7aqDPrh8U-5Wli1isheJ3itVDLi5iIw>
    <xmx:CBaGaTcD6s1XuLOIdm2K5VC-pfw3bJBgPLCWdO-ZAo8aS0f-NKd0Wwq8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 11:25:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] whitespace: symbolic links usually lack LF at the end
In-Reply-To: <aYWKyOIMPLiDxqnj@pks.im> (Patrick Steinhardt's message of "Fri,
	6 Feb 2026 07:31:36 +0100")
References: <xmqqecn0nqyt.fsf@gitster.g> <aYSLP1LqBiMwur3O@pks.im>
	<xmqqms1nmbog.fsf@gitster.g> <aYWKyOIMPLiDxqnj@pks.im>
Date: Fri, 06 Feb 2026 08:25:42 -0800
Message-ID: <xmqqv7g9hm9l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Feb 05, 2026 at 07:50:55AM -0800, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > I'd suggest that we only disable this check in case either:
>> >
>> >   - One side doesn't exist, the other is a symbolic link.
>> >
>> >   - Both sides are a symbolic link.
>> 
>> Hmm.  That is indeed a thoguht.  But we do not want to complain in
>> text-to-symlink transition that postimage lacks the terminating LF,
>> so the above rules may be a good start but will need further
>> tweaking, I am afraid.
>
> Ah, right. Only the other way around, when converting from LF to text.

I've decided to use the "disable only when the side that appears
postimage (taking --reverse option into account) is a symbolic link"
rule.

Strictly speaking, "diff" (but not "apply") has wsErrorHighlight
feature where it can be configured to complain about whitespace
glitches in both pre- and postimage, so it is technically not
sufficient, but it is not worth supporting diff.wsErrorHighlight
that is set to anything but "new" (or "default" which is its
synonym).

> Eh, I didn't mean symrefs here, but symbolic links :) Tools like ln(1)
> seem to strip trailing newlines, but if you try hard enough you'll
> probably be able to create symlinks that have a target with trailing
> newline.

Yes, as you can create a file whose name contains a newline, a name
that ends in a newline is a valid filename that "ln -s" may want to
support.  I am reasonably sure that we do not want to flag such a
symbolic link as whitespace damaged.
