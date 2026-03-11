Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6731A33D6EE
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773263480; cv=none; b=mqfgesCnTaoofhcyR8lqw3H+ywZCLuBroUeYbaThLxdm8sXxHKv166LJSeUJ3vW/JTzR8HXWHs9+DKEJdOJHhante2AxKtbbLLZVyW5ToVCvc7C7nSjYS00IDxV2DEv51qNUTztQ1btJwTUnK8fa6XZz9A4yqaImpfZfrxj/UdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773263480; c=relaxed/simple;
	bh=xoON5ZBK+k0dnQcSv4mCGsbMlQigwsqJ+cO+a9o39o4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CJ/zIvgtQCUpn9DAFO4tSWyNeMkV0z+DiOeb3QPmXD9pSscyrjuucQC73noBjSGMYDeQ0T+C2f543PWFKSqTUg93SexupRmUeviUxiNNVj6Ni9761WHQxmoY9CjCH09rl0TW6+2eIv+XvfHtMHomvEkYyUHsS6r9lv3yPAK1epU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xz9+JLLz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TJxpFIOk; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xz9+JLLz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TJxpFIOk"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5A14E7A01AE;
	Wed, 11 Mar 2026 17:11:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 11 Mar 2026 17:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773263478;
	 x=1773349878; bh=KqxYyhQfm0w9xYK+6Hj4ZTg0DCK7T2nB/BiIBIXqeEc=; b=
	Xz9+JLLzyC5HQs6G9SPOySpJ/XRUl5OEclNSJGuplBOEmxzNwceXFtEOyAKj/80X
	qGc2a1Fr6r7gnqq4IksWTGljpxJSKKtDhw1yvGH3LUsftlEsbboLVaemeB8SMpXn
	9pL+jJUatN6uQYj3rn8VyjBf14Y4lHppMILBKNA9B29ehU2vVLPdHMQW5Q/VmKkW
	UvLWl5/tmBgc8BtN3wvszHA19J6oqxEcKv0Ib9gpEpdjwhtRaOg1UiQLBTZrZrGe
	u69crxBYTqQJOsrGFYwZPN5S4kv9Z2FSiCZPsagqnMXFQZLit0+FwnO0RUsI/Vxc
	Oq9uTkTxZy01IxlHJZJw2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773263478; x=
	1773349878; bh=KqxYyhQfm0w9xYK+6Hj4ZTg0DCK7T2nB/BiIBIXqeEc=; b=T
	JxpFIOkZ7SxowIU2nyvqI0GrP2doOFS6dqWgTuYlWKDNSCzKwCdeat3+SvhleNin
	UmkCQAMFm30nPD4eFfSpuKGrpXxW9R2bW2HFngCBWgfYKgCCMmE7Qtr57v+ygFPR
	J+WiLvlSOJ/9R+aISXckY6ZoipBhInGwofK+YE4TY8Y4PlN6n2LHVb8WJ58Dtlbs
	nLfSd5poGrpZeTytOgyfmZkD40LSIJ0gXXOLbat1cAnRQwRAoSvrN5+TVWeWoz6c
	rqD/1hfwzUiTKIw987JvYEmkxrEp9bvePwznulL81GE5QC0Gv+Z3uvUijEWv1tvQ
	E7acZ/VEVxDUlQg6NOp2g==
X-ME-Sender: <xms:ddqxab8s-twl89v0qo_YBWQempe9-giqCi0i39sPa0XaFsX5w5Cq2Q>
    <xme:ddqxaaSHgO_-vAzsq6_5i4fbipKmgk-JupAvUQp35Js-3F4wxE71RFKHKmpOGXJ5x
    a4JBoY3bVi4maFcp5AwM4joRT0Uir5heDiDiOyCy_M0-LQekLVt>
X-ME-Received: <xmr:ddqxacrt5D2TIV2y1my6hSbluZWgfqG2P_i7onjI5pnmCKzvQU9vvytfO4_Lizz3RQsocsSoqRdz4VZQd2rLgpm7yigPSToG9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeevjeeijedtkedtieelhfdvieevteehudevveejjeevgeefjefggfegleeh
    iedvudenucffohhmrghinhepohhpvghnghhrohhuphdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehtsghovghgihesfigvsgdruggvpdhrtghpthhtohepshiivgguvghrrdguvghvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheprghmihhshhhhhhgrrggrrgesghhmrghilhdrtg
    homhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrvh
    grrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ddqxaXlw4Xf5Y6Ix014uekzRmTeYW0cCtchk3BKZCpiffyM4Rap-2A>
    <xmx:ddqxaVfJFbVEG0M5UivLZ6rRCzxSI6Yzxuwhg2kd2tPZCiGMMwhpig>
    <xmx:ddqxaTqaAM30cOh1EAQnVGJ1iY_ouQ_cXbV2oaB7N76uRjCKMm784A>
    <xmx:ddqxafPCUBY1giCTaOd5dSBm_T9MqLmlqd6wga32-Kr1YGiZEJwJ6A>
    <xmx:dtqxaRL1KTQT-6U3XgGeYxH4-Vwy3nDo6AXoNlFqtaz-6Eeya-bzHqJ->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 17:11:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Amisha Chhajed <amishhhaaaa@gmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    git@vger.kernel.org,  avarab@gmail.com,  peff@peff.net,  stolee@gmail.com
Subject: Re: [PATCH v4 1/1] help: cleanup the contruction of keys_uniq
In-Reply-To: <CAPvEtrf7gqyQYMcsii===kXY5Vut0EC_VsJ=xWUKNrq6YmA=nA@mail.gmail.com>
	(Amisha Chhajed's message of "Thu, 12 Mar 2026 01:18:49 +0530")
References: <20260212041017.91370-1-amishhhaaaa@gmail.com>
	<20260228104654.80831-1-amishhhaaaa@gmail.com>
	<20260228104654.80831-2-amishhhaaaa@gmail.com>
	<xmqqwlzu43rh.fsf@gitster.g>
	<CAPvEtrf7gqyQYMcsii===kXY5Vut0EC_VsJ=xWUKNrq6YmA=nA@mail.gmail.com>
Date: Wed, 11 Mar 2026 14:11:16 -0700
Message-ID: <xmqqfr66m5qj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Amisha Chhajed <amishhhaaaa@gmail.com> writes:

>> Perhaps something like this would replace the original "grep | sed"
>> pipeline?
>>
>>         sed -E -e "
>>                 /^[^.]+\.[^.]+$/b out
>>                 /^[^.]+\.[^.]+\.[^.]+$/b out
>>                 d
>>                 : out
>>                 s/\..*//
>>         " human |
>>         sort -u
>>
>>
>
> Thank you for pointing me in the right direction!

This unfortunately runs afoul of t/check-non-portable-shell.pl aka
"make -C t test-lint".  The particular rule was introduced in early
2019 with e62e225f (test-lint: only use only sed [-n] [-e command]
[-f command_file], 2019-01-20).  See the attached patch at the end.

It does cite the then-current POSIX.1 (Issue 7, 2018 edition) but
the latest edition (Issue 8) documents "-E" as an option to use ERE

I wonder if the situation has improved in the past 7 years.

We seem to have started using "sed -E" without anybody complaining
in 2022, with 461fec41 (bisect run: keep some of the post-v2.30.0
output, 2022-11-10).  It was hidden because the 'E' was squished
with another single letter option.

t/t6030-bisect-porcelain.sh:	sed -En 's/.*(bisect.*code) (-?[0-9]+) (from.*)/\1 -1 \3/p' err >actual &&

So I think of no strong reason to reject another new use of "sed
-E".  I am tempted to revert e62e225f (test-lint: only use only sed
[-n] [-e command] [-f command_file], 2019-01-20), whose intention
was to reject anything other than "-[efn]", to its previous form
which rejected only "sed -i".

Alternatively, I would of course welcome volunteers to revamp the
check-non-portable-shell.pl script to make the pattern more robust,
and then add 'E' to the set of allowed options, but I somehow do not
think that is a good use of our engineering resources.

For example, in addition to the escape we see in t6030 above, the
current pattern would not catch use of -E if it is written this way:

	sed "-E" -e "
		...
	" human |
	sort -u

or

	sed \
		-E -e "
		...
	" human |
	sort -u

and million other ways to subvert the simple-minded pattern-match
based check.

Opinions?


commit e62e225ffb589e59c4f64d90b0a393aa6a0a5ace
Author: Torsten Bögershausen <tboegi@web.de>
Date:   Sun Jan 20 08:53:50 2019 +0100

    test-lint: only use only sed [-n] [-e command] [-f command_file]
    
    From `man sed` (on a Mac OS X box):
    The -E, -a and -i options are non-standard FreeBSD extensions and may not be available
    on other operating systems.
    
    From `man sed` on a Linux box:
    REGULAR EXPRESSIONS
           POSIX.2 BREs should be supported, but they aren't completely because of
           performance problems.  The \n sequence in a regular expression matches the newline
           character,  and  similarly  for \a, \t, and other sequences.
           The -E option switches to using extended regular expressions instead; the -E option
           has been supported for years by GNU sed, and is now included in POSIX.
    
    Well, there are still a lot of systems out there, which don't support it.
    Beside that, IEEE Std 1003.1TM-2017, see
    http://pubs.opengroup.org/onlinepubs/9699919799/
    does not mention -E either.
    
    To be on the safe side, don't allow -E (or -r, which is GNU).
    Change check-non-portable-shell.pl to only accept the portable options:
    sed [-n] [-e command] [-f command_file]
    
    Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    Signed-off-by: Torsten Bögershausen <tboegi@web.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index b45bdac688..f0edcf8eb0 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -35,7 +35,7 @@ sub err {
 		chomp;
 	}
 
-	/\bsed\s+-i/ and err 'sed -i is not portable';
+	/\bsed\s+-[^efn]\s+/ and err 'sed option not portable (use only -n, -e, -f)';
 	/\becho\s+-[neE]/ and err 'echo with option is not portable (use printf)';
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
 	/^\s*[^#]\s*which\s/ and err 'which is not portable (use type)';
