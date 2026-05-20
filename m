Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CDE23394C
	for <git@vger.kernel.org>; Wed, 20 May 2026 06:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779256959; cv=none; b=TJjPLLxXPNg9rz+dm9nFUFNkyZfZGVIrjCcGhwPM5WFl2n0KT4oAf3qCdFCdAEDUEtIGqqJ/8Li+pqLVwCODnYqHFSMYwELKFo64BUip45Vj8cavgR3IX0q368vfJX/AJcm30rzLk8uBFra04E9Gk1YM/G4l0q3Ya5p8I1CYY+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779256959; c=relaxed/simple;
	bh=SKrXpPhAN8lvc75t9K5sOugpa6i1lsI1TAkETFMZoRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FI5V48pbQyLgw/K0p95qupFBPQ4iYFnUzJiaURXMZ9TXTp/6J+inz1BM5kUQ0DLq6srCxjnDmWME9E+OZFiBWWo+H9BBYBLiU31U/A8QM+vzL9EWKcEO1MRfNIywrm4eo+OWM4t61bBTfgVJjhbFcJGKGmJgajkpBxhoCI7JtrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=laOw733l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cuBsNV3m; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="laOw733l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cuBsNV3m"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 739DA7A00A5;
	Wed, 20 May 2026 02:02:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 20 May 2026 02:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779256956; x=1779343356; bh=cA8Of5uhtU
	j1LJe1LFFa0R+a5+mXHQjWupo1lMgOaAA=; b=laOw733lQZpRxs+K1xBROfGehE
	dGC4N6lEqLDkx4f8hOXd1ShFUbzEfwciPxW8gj3XoaItRVH/T/A6VuKDZfxd/5Rl
	8a2aJDlmwPODxIpsAqBYYUSZlrY2SGM/OJzNDNSpCGwdOxwpoXokI1r1Ib+Bwpy+
	+2xefl1ACfzetVJ6YkVYCVbFeg7x4fadQJ2ORZK9EiDDBAFob/XxrAEvlZMefnkM
	WavpLfbnRMnWIZAl897VRCIMxb8vaPqf4iDsarzLNzhAZ5zWqGgHej6IAlK8mdlm
	UXQdYJ4zzRn2uEWosR0tza1v159n3pNz9KTPkxd+W5Dy8qn5i+M6fHaN0IXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779256956; x=1779343356; bh=cA8Of5uhtUj1LJe1LFFa0R+a5+mXHQjWupo
	1lMgOaAA=; b=cuBsNV3m5FCuaLxGRld2yOIAj63L8LlblBUC7iR3MTGi5UJiWVe
	FQ1YnmNdpGVx1Zr1j+I6WdF2BfJmgjgzZAawPQGUbec/gaq7DV7QyOoR8Nmabmvv
	ejpuH3Rr9XrriKG0E50hz9PyQZCJ13UZp6y7bMwreUjJRgHj1o4eM3kEEG2sV/5B
	UQWefB+n3hXJycKlppPEI3kdTm6Gi+Az5yhXdf9JoN5nenp/hEDribfgc3i1SpvD
	G9GDHmH4QhlRhFRWf5oSYzoiWo9gw7g46lNxF0GNHZes/NB4JFnGD/RRmjmPtOYM
	89apM266k914zIT1Ola42XkEId03inMmvgA==
X-ME-Sender: <xms:e04NalnivkRvH0ZKnqD1HoAdigQPNTRlZ6RoR1GV_76LvmhJue2rqw>
    <xme:e04NatY8ehQyomN8H3CR2cEiu8SdrwFx97eAtQlqAbD4Cytl_DJBXG4G00aQm0yBi
    rHfmSYa1TDHrUdqjf6GqM-Rb0KtTSZoDmmrsHsuTjQ22hRH6aolXw>
X-ME-Received: <xmr:e04NagFkoqd8b-NCqxtuSkSVabMdnHztkqwW5RXLmjyCzOpgUJYHEaAK-SwvCjO7_igwBI0pk4EGSAdiQz47dE2g8crK3IaqiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmh
    hrohhikhesuggvlhgrhigvugdrshhprggtvgdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtoheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhopegsvghnrd
    hknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehjiehtsehkuggsghdrohhr
    ghdprhgtphhtthhopegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:e04NasZ7XoW2207o-_LW9YGx9ycph8-8m2fkrlmsYT9sKpy2YV6LPA>
    <xmx:fE4NakxvFNdYeutHH_9j-txurhU9slyIQzWbb1cHEh2DXJrVpX2Jmg>
    <xmx:fE4NauQixEpcAoa418DVWXsCUhIV7yxj4ZilQ7Vx0_UeVYZtfSr62A>
    <xmx:fE4NahIczII-Axfi8FniEI1OEBlXzoDKH5xX6Qht1jSV6EGyGRRpFg>
    <xmx:fE4NanrW0yXut5hbW5dZBaVpZX_TUcSjWic_POkuT7HzxdPtVvfQBAFf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 02:02:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  =?utf-8?Q?Jean-No?=
 =?utf-8?Q?=C3=ABl?= Avila
 <jn.avila@free.fr>,  Patrick Steinhardt <ps@pks.im>,  Tian Yuchen
 <cat@malon.dev>,  Ben Knoble <ben.knoble@gmail.com>,  Johannes Sixt
 <j6t@kdbg.org>,  Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v8] revision.c: implement --max-count-oldest
In-Reply-To: <8210d60832b9a58aa4d71fc3790e44d8989564ce.1779152064.git.mroik@delayed.space>
	(Mirko Faina's message of "Tue, 19 May 2026 02:55:22 +0200")
References: <463cc8e2764edb7de3d379f615f5cfbd0919bfa3.1778887662.git.mroik@delayed.space>
	<8210d60832b9a58aa4d71fc3790e44d8989564ce.1779152064.git.mroik@delayed.space>
Date: Wed, 20 May 2026 15:02:34 +0900
Message-ID: <xmqq7boy4o05.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> --max-count is a commit limiting option sets a maximum amount of commits
> to be shown. If a user wants to see only the first N commits of the
> history (the oldest commits) they'd have to do something like
>
>     git log $(git rev-list HEAD | tail -n N | head -n 1)
>
> This is not very user-friendly.
>
> Teach get_revision() the --max-count-oldest option.
>
> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---

This breaks CI

  https://github.com/git/git/actions/runs/26138986677/job/76880268854#step:4:2072

Squash something like this to fix.

--- >8 ---
Subject: [PATCH] SQUASH??? test portability and other fixes

* "test_when_finished" should use "rm -f", not an error-detecting
  "rm", as the execution may not have reached to the point to create
  the "actual" file it is removing.

* Do not hide exit status of "git log" by piping its output into
  another process.

* Do not expect output of "wc -l" is portable.  macOS puts extra
  whitespaces in front, while GNU/Linux does not.
---
 t/t4202-log.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index c3c1b862d3..75edb0eb38 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1916,11 +1916,10 @@ test_expect_success 'log --max-count-oldest=1000 --graph --boundary' '
 '
 
 test_expect_success 'log --oneline --graph --boundary --max-count-oldest=1' '
-	test_when_finished rm actual &&
-	echo 2 >expect &&
-	git log --oneline --graph --boundary --max-count-oldest=1 HEAD~1..HEAD \
-	| wc -l >actual &&
-	test_cmp expect actual
+	test_when_finished rm -f actual &&
+	git log --oneline --graph --boundary --max-count-oldest=1 \
+		HEAD~1..HEAD >actual &&
+	test_line_count = 2 actual
 '
 
 cat >expect <<-\EOF
-- 
2.54.0-398-ga4b2d32071

