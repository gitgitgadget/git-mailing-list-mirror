Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAF82E3714
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754238964; cv=none; b=tQI4LInznT4AnOFd5bGTALupJodya8mjSmlzJSQVY1rTlWKQa+Yxhj7yu8T3/tFlT5e44GCh/9906AS+3a9eUIJeD67UvRg2VE6C9sGJR3jRC+6IBt/exDV+ld0O4Fsy55UwnhjAbRiOPWaAZyRVMByH3nqG8LhZupP73AUff4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754238964; c=relaxed/simple;
	bh=/5oRCqfra+e4tJJ0jsbbV5p859tB+5lyGsNo9NxGSqM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qcqMzenlxJ+9WDtxa1tecvFYlDHAtaOuRb/e61H+MmBwm1Exa/KoZftCLHOt5kmig5KnN6h8RrMdA2OwhNOsvp4o2I9Mmtm75ZNCKDqe7fFKaMnU9UtYx8Yf6xV7uBt7jbAJGad9qopUGvVsX/xJm0lz7i3nolsgOExXQz8zJ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k3qiodZc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KcWXII6X; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k3qiodZc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KcWXII6X"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1002E7A0050;
	Sun,  3 Aug 2025 12:36:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 03 Aug 2025 12:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754238959; x=1754325359; bh=yqLNuE6VoO
	3xdZsDT4G0pwfw0N4J9myPtxEqeEt3qWM=; b=k3qiodZcTpx31gM5H61iwk5kSx
	7HCgABLtv2B1TmMq/4PYwxogg2wqgUyYo90OwCcJYrTR3vuQpnznFiA2ZumMFHGE
	fusTYFx2RKzk2ICZSTqRY9Oj6zFVDEtQOvdr59nzhBBLxxiVKGuC3ZrmHpYV08ta
	Co8iRnH4LqDl8IlXJcFlM5vzwLs71rUw7VpTomJcyFnxybe+yp9wScK/MLPEdn+F
	iFxLTSryvflgiqKFxnSy83niGTgjQ3zWQC3yLen/Dn0sCxezEbXa/CgshULiMs0w
	wb88oChBr8uQJx+OjF0C+Inn7MvC9GaTqrZkmpFnTDDC0EgnAPwCa6qv5oXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754238959; x=1754325359; bh=yqLNuE6VoO3xdZsDT4G0pwfw0N4J9myPtxE
	qeEt3qWM=; b=KcWXII6X/F/x1PmUYbPpEsU5GVuYI1WXtAWfVXfXBDcx7dkEUA/
	F0SOlVqEPIw/y160NXPuOuMNbwKYDs4Y6jA49Nb2daUd6KSBrcwvO8IfYE015Ah4
	+uQreSIUV4Kl4KtUg9lSl4TlqtgX9rM/gL0JP07WYkabF/Wn+2iCLKDWmKNZn56U
	S78CI0ev1nEQDB0rGPVFCpo8yKUbu+jY53YZpIj2OhDLer31TbBbQLaoWyS4xCVk
	b0Tv75V3MB1JyRiHeBo04tgRbMzgFq/6MVCNz9zhz6XmHO0VaVurU2zmw4+4ntoH
	W1STP+ieX7Mh20llh8od4DXVFGSUT3rwERA==
X-ME-Sender: <xms:74-PaATk7S-LTZaxL27y7uS7x8Z7gj94m3sISq-Lao1Rr1y3Kn6Uog>
    <xme:74-PaHPjFnzEPVpY35_uNcFsbcGJOYvvtUm8FUmzrC-syB15-SmVoT_LYk4ikfriU
    UU0QyzWx4Q5Mh-UzQ>
X-ME-Received: <xmr:74-PaNZ3shwr5XOA7wPmnFjJ3RJMgTwgPPrbIgduq6bKinP6y9kIQjFqhkQa9gMSdC5Z3DIP4fl_LDImLE80Gl5uVBUlIbv6cuN9bJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdelleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgeslhhi
    nhhugidrsggvrghuthihpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvg
    hlmhdrohhrghdruhhkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:74-PaJxd2iQe3ga3lwH1i4oNcSMlgTiC7zNyLKRiM6xiQBZggymDGA>
    <xmx:74-PaALqEJA8jGMWo4pje9Pa6Qviei8QMhTZ4ZUr-vM0Zab6gL-WBA>
    <xmx:74-PaLoBXKJG2FVI2JMARKd_n5z1NwL2s-HazK5hSGz4XOLOvgL41g>
    <xmx:74-PaHIC0zNI-l8xjDCE8k-55JQSsAjvZTo-I0gzhVAk3lGLl_lCoA>
    <xmx:74-PaESN-T68kFzQ39ZKh34acfs4qWDSi9J5AnAUFkGwd9x1scWNfPUM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 12:35:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Li Chen <me@linux.beauty>
Cc: "phillipwood" <phillip.wood@dunelm.org.uk>,  "git" <git@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] rebase: support --trailer
In-Reply-To: <20250803150059.402017-1-me@linux.beauty> (Li Chen's message of
	"Sun, 3 Aug 2025 23:00:55 +0800")
References: <20250803150059.402017-1-me@linux.beauty>
Date: Sun, 03 Aug 2025 09:35:57 -0700
Message-ID: <xmqq8qk0fjma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Li Chen <me@linux.beauty> writes:

> From: Li Chen <chenl311@chinatelecom.cn>
>
> This two-patch series teaches git rebase a new
> --trailer <text> option and, as a prerequisite, moves all trailer
> handling out of the external interpret-trailers helper and into the
> builtin code path, as suggested by Phillip Wood.
>
> Patch 1 switches trailer.c to an in-memory implementation
> (amend_strbuf_with_trailers()). It removes every fork/exec.
>
> Patch 2 builds on that helper to implement
> git rebase --trailer.

Try running "git show --check" on this commit.  My attempt found a
handful of whitespace breakages ("indent with spaces.").

Thanks.

