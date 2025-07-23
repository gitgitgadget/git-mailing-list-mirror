Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77FC1DFCB
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 21:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753307515; cv=none; b=DvSQi5MyrEopb/6Zq0Jj71MaPaKY/sN3hmbZWQAiFGQLPUpS5Wwvp4d61JjN6rNaaDU+uqFBzeavIBAAZyBCqt7KBXXGekhgLflDy2Bzjv7ldU5+lblmxzug2l7uPsS+NCv0DBQvj8BgNpsRzM5ruhNteLmw60HSOiyqAi51QbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753307515; c=relaxed/simple;
	bh=1xgFIb5zV5rp/4x99wluHe2WuO74oDSDbBFQLw07E/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RTBbtFRdHC5FknL5REmO0WRK1GB7BL6BERf7NybSWMwT+sj/8bYSlay/4LFWpKMl6YhikUInQuEYu1Z72wiaCY+E78HqK42IiFKPbnS48jFvF6dVKnXAI/a4VihJMBSHYztUjapibGU9FzGE0bn3/gNGur3AZoI+jJx+NZ0bQK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VLDPddYV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jpWKD8Ne; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VLDPddYV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jpWKD8Ne"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 048A51401EF0;
	Wed, 23 Jul 2025 17:51:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 23 Jul 2025 17:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753307513; x=1753393913; bh=veOicXcMbR
	l7k8WAObpJYSnk4hq+6L0YlEm1FIUjG90=; b=VLDPddYV3V9KPG4PvpKt5sjJzP
	3Yob7N/a+tGtX60Cq3I2mmizzxscnP3fVM0MYI+m2S5gQy7nN8t/MlNBX8tg/bOT
	0CkITF8xBoShCVdxndLgsRHd1fswfJJ9gpz6yQJxvye5mVHq+5Ru40W3EGk/V34u
	FTc05ogD+FmfVgig3kkMiY/FmHEXyJY9ebpAyQy6NV6uwIsNHScb7XPRUBaID5me
	33QDkTez6fLQyj1tVOz9HaIoNMxV23UUGTV1/xMSznx0PppwzH2cXEJKTg/UF6MG
	MCZGpg/7wISqnpPrrSyqwwfS/kir22y2OFdqrR125ek9qDKzmSaEKNGZx/cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753307513; x=1753393913; bh=veOicXcMbRl7k8WAObpJYSnk4hq+6L0YlEm
	1FIUjG90=; b=jpWKD8NeEl7tVDA+gawZKjyyPj8YdAYd6/D8c6TkfKR7lPv9PGb
	seuqnQvRRmdvjn5HRQAdIxnXIozW2nFbc7h/cHe+Jen/0t6O28UuqpH+S/SLFv4+
	+P1ij4Pv/LLn0mPdk+CLOcKy8Zp/5zAREQa9lsYQ3Tgsh2Cw7UjSdkIxCl+/QA8H
	kvCo2fBboLfGLndTssDNuFqRYmYBUUXZOoqCBKjxIbZaaQFDfu/LKWtPWaVYYDhN
	bTaiAdmxSbLLGxTyyut4l1m/TXP9zahIiKRO1RlMUd/xKo3FnF952XvvbDIKjcks
	AqnotGErrqkYalXE62DgbOlQC3XMdEC71xw==
X-ME-Sender: <xms:eFmBaO4RC6B4mWwx5DNbiTdp_hG7MOgo-28hjFPHz8GWN0JADNkbOQ>
    <xme:eFmBaExLWImBJhyD3Qr_A7upKO6Mfuhejjs1TsDHYARx3j4hHLq2SBGLlHQtvkCxP
    3XmxfGK8zzahDhFxQ>
X-ME-Received: <xmr:eFmBaNMM2y2fKTSMrpegYBgrPWXzObxkPkFuZxRk5mG8yt5XmP2fKcmF_EywllQ68oGELkFo1uh_DY7wmXg4CVqbsBlw2DRb0SddqRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepshgthhifrggssehlihhnuhigqdhmieekkhdroh
    hrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtph
    htthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:eFmBaKk3zqEFWs7qCZTN0VYRpwcaXPhaipNJZTdgUVG0L6dlgLCJ6Q>
    <xmx:eFmBaCQ_PRoCKjZJfzHmCSrjdEzi2mOqnexB8J1f7fyG-sezY4oUWw>
    <xmx:eFmBaJU2BWl1m2cvgYq0wEc6UmHvSxqBq0aYZAH2HEZvB-Z5LclHEw>
    <xmx:eFmBaGICamX3Mgvqf_yg6GD7Wn7bxxpe-Bah0H1Kh52BRSSNmN2PTw>
    <xmx:eFmBaF3hRxSpiTXMXM_CnbKDM9QJRUAJ6dckBFS27DvGjmhWSGGsNXyd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 17:51:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,
    schwab@linux-m68k.org,  phillip.wood123@gmail.com,
    Christian Couder <chriscool@tuxfamily.org>,
    Kyle Lippincott <spectral@google.com>,
    Jeff King <peff@peff.net>
Subject: [PATCH] ref-iterator-seek: correctly initialize the prefix_state
 for a new level
In-Reply-To: <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
	(Karthik Nayak's message of "Tue, 15 Jul 2025 13:28:25 +0200")
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
	<20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
Date: Wed, 23 Jul 2025 14:51:50 -0700
Message-ID: <xmqqldoelgnd.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

When cache_ref_iterator_seek() "jumps" to a middle of the sorted ref
list, it forgets to set the .prefix_state member of the new
(i.e. deeper) level it just initialized.  This later causes
cache_ref_iterator_advance() to look at this uninitialized member
to base its decision on what to do next.

Kyle Lippincott [*] and Jeff King noticed this with MSAN and
Valgrind, and Karthik Nayak as the original author located exactly
where the missing initialization is.

[*] <CAO_smVg9TDakUnubepjPGmLyOzW6n8Z=MDbnZKvkwN2=kN2RRw@mail.gmail.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/ref-cache.c | 1 +
 1 file changed, 1 insertion(+)

 * I had this as "fixup!" on top of your topic for quite a while and
   forgot to ask you to send in an official fix.  As Kyle's
   discovery was after the topic hit 'next' (understandable, as
   their internal edition of Git is based on 'next'), we need a
   separate fix on top.

   To prepare for merging down the whole thing to 'master', I wrote
   the proposed log message to help expedite the process.  Comments?

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 1d95b56d40..ceef3a2008 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -527,6 +527,7 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
 				level = &iter->levels[iter->levels_nr++];
 				level->dir = dir;
 				level->index = -1;
+				level->prefix_state = PREFIX_CONTAINS_DIR;
 			} else {
 				/* reduce the index so the leaf node is iterated over */
 				if (cmp <= 0 && !slash)
-- 
2.50.1-521-gf11ee0bd80

