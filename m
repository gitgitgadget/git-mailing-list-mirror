Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C05B1CD3F
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 00:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736209599; cv=none; b=iwakj8+ivYu2eHkx5cJqumo/71wheytl8ID9tAxcLvF1Tlgs8aqFDuBDxkP8BXTgoQqKD7yLuuNkbk4RjKFCNHoTUlZje8jB8bhcznsJ9XEzWSaiDBPqFMTMuRJJs0MX2U9ZOTrw/bc4LdjvnFIFboYU1dSz99dX8vaMlR0v9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736209599; c=relaxed/simple;
	bh=ro0il0TqAOQ2CXXUuJum0VP3SFgObU8sdSj5eCSs4uk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BKbAAU9JuexjXHpoja+vORhGSSA40mbW2qzS+Yizf5me4qCTOtMMS8to5w5VzR3sDlHWwX5WGnZW9uLNtpRtMV5WyxYr0oiCXjSxnKu2Pcw1Q4jLO2H+Sk+NqwuTMouZJws2NQHpUQ57vBqSzWqhxbUnP4Y24rygAuq4Un4pMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vqiNlpi7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VQp/dIvq; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vqiNlpi7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VQp/dIvq"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 74FC325401D0;
	Mon,  6 Jan 2025 19:26:29 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 06 Jan 2025 19:26:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736209589; x=1736295989; bh=rRKU0wCcL4
	VnsCge1SR13xFdpPnqst/2Iz9Ff9Z/8xY=; b=vqiNlpi7Oc9QvcM/1XpYUx+SCL
	Hnw4TWDP9PPx8bomgdYVUZi7g6jhwWzobLMnSNWG/Hi+2Xwsr6vtfzUUxaXJBkUw
	PM2J1lQ3c9bIFBg+c4hVbg8VgAwj7S+LNBpaIJfxk76X2h0oIqZ2ZLB9zYROI8Z9
	K9wOAo1kmapgs0teeCo93XTYDNz0KP4oMbEmzZZM3+u7faFCfrwCzjL+CRlM/LY6
	SEx79gmpAVFsmPCsx3CYDaxZDD+njj/T6E1csP5IwPVaFgL9TnNpcWVWIev8lXjx
	HdbUOkRJrBTYQpGIYJHQcO6+eRNyMMIrQJljERrWCoQ7oaX97lFJRQBesAyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736209589; x=1736295989; bh=rRKU0wCcL4VnsCge1SR13xFdpPnqst/2Iz9
	Ff9Z/8xY=; b=VQp/dIvqDVu1wFPwQo9+L5rJhNSZ+YDj08oqwQMVi9bXZHnVhvP
	GpdovncoNYatSZB4FNGJuKrfi/oZufvh/fOjGZ7LlF2FAsfOhIhVItJc57YQi0sj
	xBoa8PyoLvlXaKzuPP4MlTylV304Pf8VipXLrlLx7V39+bEuCbvyccM2m/BK9GWC
	2MAToGLuqCSwqIRKFERpO789hSW01SvNUBeiIERGhfBkQPLzBBVcgkDxoMHh8e67
	sh1bY6UkgqBbcxAW0sAQdJhUnO7yPi1mVBmUDACqnrC82yQDy/EEKu5Mt5lAXiGR
	i/kUYfOAvmO0JHkpsz9KD+jIYVGweAmi4fQ==
X-ME-Sender: <xms:tHR8Z26gmMlk22eKM0uQjYAylPA3Kg-ADOCdRsZZcObeq-ePDLbHTw>
    <xme:tHR8Z_4-fYeci9k2-M5MF6qOxtuutric8D7UeDvhf08bS-EygSBJ3akhIyulhhZFY
    5mMYe3tOGnjj_qJ0A>
X-ME-Received: <xmr:tHR8Z1dedISZl4B9UPZUBtRRjuH3wP-BlEC7tTQksLAwgoic1U2_NIvvRGVHADPGNsB3tALjSvZcSVMP5RfeSn8Sm9H3GgvSlbHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeguddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
    dprhgtphhtthhopeigmhhqqhhfrhhmlehtiehuphdrfhhsfhesghhithhsthgvrhdrghdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepshhovghkkhhlvgesfhhrvggvnhgvthdruggvpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tHR8ZzLBZaG5Xs0MKyUgnr60IEfzqQCYgdT56QwU_WRSxCSvFrDCWA>
    <xmx:tHR8Z6LyQdbuA_HS2usIs2vwCUdSLi3XbBtcNXgvlmkLXmJ-OSRWmg>
    <xmx:tHR8Z0x3UCQ3pgFd3VDKQO8FjsTltIWakR4kFpcwWVIve5gNdXIxEw>
    <xmx:tHR8Z-KkHhbZp4-G-nKr3MK7-psqBLnT8KuncWVbNvk1SFFrU-31ZQ>
    <xmx:tXR8Z7qEzB5uhexZL62XUJ_6X1QF1wHTkqQsHTHFVz_Vbp1GBy3EzLY3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 19:26:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: xmqqfrm9t6up.fsf@gitster.g,  git@vger.kernel.org,
  phillip.wood123@gmail.com,  ps@pks.im,  =?utf-8?Q?S=C3=B6ren?= Krecker
 <soekkle@freenet.de>
Subject: Re: [PATCHv2 1/4] add-patch: Fix type missmatch rom msvc
In-Reply-To: <Z3xxxbKtqyLmDAif@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Tue, 7 Jan 2025 00:13:57 +0000")
References: <20250106190855.3098-1-soekkle@freenet.de>
	<20250106190855.3098-2-soekkle@freenet.de>
	<Z3xxxbKtqyLmDAif@tapette.crustytoothpaste.net>
Date: Mon, 06 Jan 2025 16:26:26 -0800
Message-ID: <xmqqed1fwjt9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We don't typically put comments about the revisions we've made to a
> patch in the commit message.  We may put them below the --- so that
> they're visible to readers and reviewers, which is helpful, but we
> pretend that our patches were perfect to begin with in terms of the
> commit message, since the future reader of the history only cares about
> the actual end result and not what changes we made along the way.

Thanks, all true.  The future readers would only *see* the end
results, and we do not want to hear about the previous stumblings
the author made before reaching an acceptable version.

>> ---
>>  add-patch.c       | 53 +++++++++++++++++++++++++++--------------------
>>  gettext.h         |  2 +-
>>  git-compat-util.h |  6 ++++++
>>  3 files changed, 38 insertions(+), 23 deletions(-)

I already made this comment, but I think the offset/count being
ulong is a very sane design decision, and what is causing the
compiler warning is some earlier change that introduced size_t
variables or parameters in the callchain.  As far as I can tell,
there is no system functions that yields size_t (hence we must use
size_t everywhere) in the code paths that deal with offset and
count.  I suggested to find these abused size_t and fix them to use
the matching type, i.e. "unsigned long", instead, as an alternative
fix.  I did not get an impression that the author tried the approach
and found why we must use size_t for offset/count instead.

And if we go that route, there is *no* need to talk about 64-bit ve
32-bit platforms.  ulong used consistently everywhere would let you
use offset/count that fits in ulong, and the apply machinery is
artificially limited to limit the patch size to a few gigabytes, so
32-bit ulong should be plenty as Phillip pointed out earlier.

If we needed to parse an integer into a large integer, the existing
code seem to use strtoumax() into uintmax_t and move it to the
target (while checking for truncation).  "Ah we are on windows, so
use strtoll, otherwise use strtol" is not something we want to see
in our codebase.

> If we're using size_t, we can use %zu.  That's specified in C99 as the
> appropriate formatting type for size_t, and we require C99 or C11 for
> all systems.  We don't need to cast to uintmax_t.

You and Documentation/CodingGuidelines contradict with each other
here.

Thanks for a review.
