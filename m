Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8173E248F69
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765378715; cv=none; b=LyDkB+nOobA9xcYwyoWV/WKhvGh+ej+G05IoC9D6e3ZJeYrduvor1DcvZshBbHae+wVB6ws/aM3djDvSRbFYb/YuskSxO5892lQDInWrbFlkle+WDsffF9lgd6AQTjauFYAn41AVVsPw3a+/5pkr8TorKVmRoq85iG8loyZjfQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765378715; c=relaxed/simple;
	bh=tDBH2j0jRBqB90Qh+1fmiBGSjWl0vISn4iJHgtjAods=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AY3XSeyET0WySC3pSfSb4Bz1VqzqVTz/cIcLcPsA8e8dhqbicMA2tLDYwr8bf1+/ewBwmFiFReBfugiNfjq5CDYkXRNr7YSrL+SXrn9GpBS4fUXodjvj8njnV/3oGtEL/oEGJRMyP0kaXa5KHhOP2jb1Rjn/OfiJxZbKXbKfq68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DVzH9wAK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EX10rL3L; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DVzH9wAK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EX10rL3L"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9622E1400132;
	Wed, 10 Dec 2025 09:58:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 10 Dec 2025 09:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765378711; x=1765465111; bh=JVytq5atO2
	+qqEiTY3pJHJPJQgF6uOgQzHAGB6TxHiY=; b=DVzH9wAKAEADiQw57LpLDN376+
	c/dZIaAadGLUpnmAUxK+cccoYncXuPSGfAxyfINj/2aZh/AAME5VQuvODL8cRlUP
	XbOPbaeROM7ej0cCz39Oe4Bke5f9qQ6axdWXPHdH7YVeBwCe/+42GARIcty7sfck
	UAn7AwWpNpdI6OooIK8IMN1Irspz6H3ziDmY+hUcwGGU9gQO62mRdEecqRtZpKLh
	js366elX3hixskTQxJYqq+EBkKo4yTmjGtKl4nur5ZnBNuSXWzH1+bWRuYgEWw1w
	Ziq9iOaSAbJYMg/tCEuy5ou+4uWz6XF4TDg07CQAqDaCjxcGRhJy08m74LqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765378711; x=1765465111; bh=JVytq5atO2+qqEiTY3pJHJPJQgF6uOgQzHA
	GB6TxHiY=; b=EX10rL3LviqSG3OeQrT5DzUgE9dghKbR8YHeHiiFJX/lfgZt9xC
	DO+qUEsilB5w7nnqBSzuQUsvV6o2pcHuRX49hEWlnK/zqyLJkJlrz/bg4SGI4P4P
	+0ZYfe0VDC9mddd87KqnMlynq56x+Ap8c0YtdJiTNKJ8fyuGl/E3+wfOnhXedENV
	U7Nad/hRZVNu/EgSZiUuT904S7BmzYSaZxK+IMKfX4GaeAGNQ39Ww57zULP+mDxM
	pdfp4HihLLaH6o795PWIAFa4qkmDzEWsia25Z5T4K1W0GbNZhAe5AgMj7pQd7ZNW
	XtZr8NXw0aS6uiXffBzkmEDJCZyqNoipX8g==
X-ME-Sender: <xms:l4o5aQ6ztkqCqe6Ib6AZGvIBxAwbWfZhoZ8fahdWhL5yORKy2znS-g>
    <xme:l4o5aYy3vUTMLhgrlvTM6u9omX747BLXRfZU36purxawtf-cw4Rt1mLQSDC4J_91U
    rNngXQ7LaUz10JXW1kYp6MU8g2f3ypKOdEyUyTbu5S6Qq_J9hocBQ>
X-ME-Received: <xmr:l4o5aXyB0fcA6LbxCgHyhxy8L9L8OqR7Jvp8DKNHP2H4wEIaqsg8e_QUMK6fvcMu7EHydU3gkh-OllSnx5T91_zqsvL93o1Yng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:l4o5aQy0eiqDTm9z9Zxjd3kxNOgkRen8kaiY5u6b3YWbMqmZGtZujw>
    <xmx:l4o5aRYuJ-w5w1aCp9fFhXIyjBLaWRiu97E65qCO-6D0JEy1MA6NVw>
    <xmx:l4o5aRW9WlSYzU0glDXAyGEitcKu-mu6twd-ZSmwfTD_bqSPTNjxSg>
    <xmx:l4o5afinGExjDzI-iVriiSrPQPzbBN4dSMc4UBHv1UzCBlMV8B7ckQ>
    <xmx:l4o5aUAd8vIuzA7TXsbhzqoffLut5uJpibR1qsYAWI9knXfbWTCD8j0d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 09:58:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>, Lucas Seiki Oshiro
 <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 5/6] builtin/repo: add disk size info to keyvalue
 stucture output
In-Reply-To: <20251209225820.2861276-6-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 9 Dec 2025 16:58:19 -0600")
References: <20251209225820.2861276-1-jltobler@gmail.com>
	<20251209225820.2861276-6-jltobler@gmail.com>
Date: Wed, 10 Dec 2025 23:58:29 +0900
Message-ID: <xmqqikeegz8q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> -test_expect_success SHA1 'keyvalue and nul format' '
> +test_expect_success SHA1 'keyvalue format' '
>  	test_when_finished "rm -rf repo" &&
>  	git init repo &&
>  	(
> @@ -106,16 +137,12 @@ test_expect_success SHA1 'keyvalue and nul format' '
>  		objects.tags.inflated=132
>  		EOF
>  
> -		git repo structure --format=keyvalue >out 2>err &&
> +		git repo structure --format=keyvalue >out.raw 2>err &&
>  
> -		test_cmp expect out &&
> -		test_line_count = 0 err &&
> +		# Strip object disk usage from output due to platform variance.
> +		grep -v "objects\..*\.disk=" out.raw >out &&
>  
> -		# Replace key and value delimiters for nul format.
> -		tr "\n=" "\0\n" <expect >expect_nul &&
> -		git repo structure --format=nul >out 2>err &&
> -
> -		test_cmp expect_nul out &&
> +		test_cmp expect out &&
>  		test_line_count = 0 err
>  	)
>  '

This part has both textual and semantic conflicts with Lucas's "-z
is a synonym for --format=nul" topic.  I think I resolved it
correctly while improving the "munge expected output into expected
NUL-terminated output" approach to "munge -z output into textual
output and compare with textual expected output".  Please sanity
check the result after I push it out, merged at 32f8d84b (Merge
branch 'jt/repo-struct-more-objinfo' into seen, 2025-12-10)

Thanks.

commit 32f8d84b5cfc5a5704e30fe4abc9d8755893179c
Merge: 09bd4419e7 b8cacabfa5
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed Dec 10 20:41:31 2025 +0900

    Merge branch 'jt/repo-struct-more-objinfo' into seen
    
    * jt/repo-struct-more-objinfo:
      builtin/repo: add object disk size info to structure table
      builtin/repo: add disk size info to keyvalue stucture output
      builtin/repo: add inflated object info to structure table
      builtin/repo: add inflated object info to keyvalue structure output
      builtin/repo: humanise count values in structure output
      builtin/repo: group per-type object values into struct

diff --cc t/t1901-repo-structure.sh
index df7d4ea524,51820cc3f6..31c77c4666
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@@ -90,25 -148,18 +148,29 @@@ test_expect_success SHA1 'keyvalue form
  		objects.trees.count=42
  		objects.blobs.count=42
  		objects.tags.count=1
+ 		objects.commits.inflated=9225
+ 		objects.trees.inflated=28554
+ 		objects.blobs.inflated=453
+ 		objects.tags.inflated=132
  		EOF
  
- 		git repo structure --format=keyvalue >out 2>err &&
+ 		git repo structure --format=keyvalue >out.raw 2>err &&
  
- 		test_cmp expect out &&
- 		test_line_count = 0 err &&
+ 		# Strip object disk usage from output due to platform variance.
+ 		grep -v "objects\..*\.disk=" out.raw >out &&
  
- 		# Replace key and value delimiters for nul format.
- 		tr "\n=" "\0\n" <expect >expect_nul &&
- 		git repo structure --format=nul >out 2>err &&
- 
- 		test_cmp expect_nul out &&
++		test_cmp expect out &&
 +		test_line_count = 0 err &&
 +
 +		# "-z", as a synonym to "--format=nul", participates in the
 +		# usual "last one wins" rule.
- 		git repo structure --format=table -z >out 2>err &&
++		git repo structure --format=table -z >out.raw 2>err &&
 +
- 		test_cmp expect_nul out &&
++		# Replace key and value delimiters for nul format.
++		tr "\0\n" "\n=" <out.raw |
++		grep -v "objects\..*\.disk=" >out &&
++
+ 		test_cmp expect out &&
  		test_line_count = 0 err
  	)
  '
