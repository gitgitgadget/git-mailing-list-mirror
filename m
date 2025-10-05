Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C425B4502A
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759699847; cv=none; b=PbDxgLK0ey0p6QoFN0vLX04tsyjeXZhuc/D1c5l9joAE+GJDjY64WqqRpQz9Bui2uv23SuOTa1Jp8zqwfyYJs+iS0JlAEMP76EfRR5+iZ85YyPhJomR4RgEk17aUkjKUBGTXBnX9yMrU/bUYHh3d2usUV5+H59VrKpedKjDcoqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759699847; c=relaxed/simple;
	bh=ix+N0YMS0NaQv/rbZDPjiGFrHsAlB5QOTI6nQBYJous=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FBX8BJR1dftBBZ+h5sxK7QqL9r0qRNwD1bYDn+9Wqz8V/JmEwPTau6T/uXh3uFsvqaxI0vqeF/azHZqs1hCMPqo1dkYHA9lsinQmd/E8Ige3FDIQUF35an7D5ljFzWhbz0ZOAA072F1ZpWdqXoTiW52zyFbq8U1XW77TxWccmlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WCDdG2tP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wcUoOOAq; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WCDdG2tP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wcUoOOAq"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B7B407A009A;
	Sun,  5 Oct 2025 17:30:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sun, 05 Oct 2025 17:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759699844;
	 x=1759786244; bh=baoTpVvHa9Xy/TDG7knklF9N8hJJJfu5JoSuFIa/sXc=; b=
	WCDdG2tPByltt4hYZ33ofHAe8njTI6pqbaP1eMD37vH914oZt2upBOeu2nskGIQM
	IyYRy3kPzQ2eRpSArsK6oD8uCw4pgRD94SsFxEGiSb+pRX7qmVQRf9q13WsVxbbk
	FmFYiEbuiCHlA7fpQw5QH7LQtW8zPvGPr4Ef/VGeawK8BjoAQfS/nCeeZmrPiVo8
	QVG77alE12qZl9NyES6ztF9XU77G92MpKyRohO3VTAHD3yRnuDPomDK9wqqWujWY
	ifV4T9ZC4miSpnIBco3OYVZseC47CQzuxOfEqBMdeGalKKyzHVnz/f9si8wrMFdL
	Curol7bG3os2Whs6k5h+gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759699844; x=
	1759786244; bh=baoTpVvHa9Xy/TDG7knklF9N8hJJJfu5JoSuFIa/sXc=; b=w
	cUoOOAqf6G2s73BmjMsV5+5nfbxxtLlTqBu5ppTyPxsNZDkxwWKBfBJC4oq2dJLp
	A+bI5fI6myKfT01wJbbDUAzfzT7JOSuMc9AskMH/CJ0SHsOcCweqzqvrKmRiDoxC
	RE4bIWW/QAYTzYWqTT2BL6+aRIsyAW5dkgvDqC2v66aPLky1VEQklCpEFkmxnCpt
	qxPndRU6Pib5vlyNKHt7vHam+Uk88z+/cwm2DFzclayM8Y+LQOeEG2d4I2yMQmFY
	4rnZzjgQktoeJw5iD0jfDZat97GMiqo2g86cdTtlx2qM7aFu69jf/7tTu4SE3X6M
	0xbMFDkDBD5+CSF5QxSxQ==
X-ME-Sender: <xms:hOPiaGmv-iIGIgdajn1QlJEEy_A-DwC6x7ZHZLAHl8Dj55wTOxfGqA>
    <xme:hOPiaPUvwmZKcP8oObpuF9Dv-s8-1OhqTBFthovNJEe3qNB87x5zAbF-gP716sWXE
    zMZR8XW-TzFJrLnrnz7j7wUz8TSLfW3PsnooNu--svpkL_m4q_krg>
X-ME-Received: <xmr:hOPiaEtGthhqoJDtJcEuczOG6BT7LZ8n8HojVuFtfcdP6MH1jcUsbYQZQefIwBUt_0jachXdykWgeQHZsf9lT63sF5P1X6GJA32j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelheejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehurdifihhnughlsehu
    khhrrdguvgdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hOPiaKap4yPeOuGNU2wkzVJYQFRIvo_coHVq5r10ZXgxLpnBOkn5xA>
    <xmx:hOPiaLWnm4E7b_wmJLS0RHRUKR4A-MHr4EejWYnhWYQJaZ0dKv3JUQ>
    <xmx:hOPiaHRHQJCHPArkIoMvnKuD8b2-pABB-jmHFFd2809hRfcI6ZXjNg>
    <xmx:hOPiaBP_Q-tmf4uJBy_Uam57vOqa1smIiC78ThfZ6x5TTuLQTzVomw>
    <xmx:hOPiaNs1LkMqoI40CfrwzbFjuicZeM11f9-MEj9lk33kEGQ6xaSo4r8l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Oct 2025 17:30:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  "Windl, Ulrich"
 <u.windl@ukr.de>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 2/5] add-patch: document that option J rolls over
In-Reply-To: <187aac4d-18b6-41df-a181-7f42e3cbc0d4@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 5 Oct 2025 17:55:24 +0200")
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
	<17ef29a7-5214-4729-82eb-92a2af33e465@web.de>
	<187aac4d-18b6-41df-a181-7f42e3cbc0d4@web.de>
Date: Sun, 05 Oct 2025 14:30:43 -0700
Message-ID: <xmqq7bx9rq7w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> The variable "permitted" is only not reset after moving to a different

"only not" -> "not".

> hunk, so it only accumulates permission and doesn't necessarily reflect
> those of the current hunk.  This may be a bug, but is actually useful
> with the option J, which can be used at the last hunk to roll over to
> the first hunk.  Make this particular behavior official.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  Documentation/git-add.adoc |  2 +-
>  add-patch.c                |  4 ++--
>  t/t3701-add-interactive.sh | 18 ++++++++++++++----
>  3 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> index 3266ccf105..5c05a3a7f9 100644
> --- a/Documentation/git-add.adoc
> +++ b/Documentation/git-add.adoc
> @@ -343,7 +343,7 @@ patch::
>         g - select a hunk to go to
>         / - search for a hunk matching the given regex
>         j - go to the next undecided hunk
> -       J - go to the next hunk
> +       J - go to the next hunk, roll over at the bottom
>         k - go to the previous undecided hunk
>         K - go to the previous hunk
>         s - split the current hunk into smaller hunks
> diff --git a/add-patch.c b/add-patch.c
> index 912266a3f8..bef2ba7a25 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1398,7 +1398,7 @@ static size_t display_hunks(struct add_p_state *s,
>  
>  static const char help_patch_remainder[] =
>  N_("j - go to the next undecided hunk\n"
> -   "J - go to the next hunk\n"
> +   "J - go to the next hunk, roll over at the bottom\n"
>     "k - go to the previous undecided hunk\n"
>     "K - go to the previous hunk\n"
>     "g - select a hunk to go to\n"
> @@ -1493,7 +1493,7 @@ static int patch_update_file(struct add_p_state *s,
>  				permitted |= ALLOW_GOTO_NEXT_UNDECIDED_HUNK;
>  				strbuf_addstr(&s->buf, ",j");
>  			}
> -			if (hunk_index + 1 < file_diff->hunk_nr) {
> +			if (file_diff->hunk_nr > 1) {
>  				permitted |= ALLOW_GOTO_NEXT_HUNK;
>  				strbuf_addstr(&s->buf, ",J");
>  			}
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index d9fe289a7a..d5d2e120ab 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -334,7 +334,7 @@ test_expect_success 'different prompts for mode change/deleted' '
>  	cat >expect <<-\EOF &&
>  	(1/1) Stage deletion [y,n,q,a,d,p,?]?
>  	(1/2) Stage mode change [y,n,q,a,d,j,J,g,/,p,?]?
> -	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]?
> +	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,?]?
>  	EOF
>  	test_cmp expect actual.filtered
>  '
> @@ -521,7 +521,7 @@ test_expect_success 'split hunk setup' '
>  test_expect_success 'goto hunk 1 with "g 1"' '
>  	test_when_finished "git reset" &&
>  	tr _ " " >expect <<-EOF &&
> -	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? + 1:  -1,2 +1,3          +15
> +	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,?]? + 1:  -1,2 +1,3          +15
>  	_ 2:  -2,4 +3,8          +21
>  	go to which hunk? @@ -1,2 +1,3 @@
>  	_10
> @@ -550,7 +550,7 @@ test_expect_success 'goto hunk 1 with "g1"' '
>  test_expect_success 'navigate to hunk via regex /pattern' '
>  	test_when_finished "git reset" &&
>  	tr _ " " >expect <<-EOF &&
> -	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? @@ -1,2 +1,3 @@
> +	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,?]? @@ -1,2 +1,3 @@
>  	_10
>  	+15
>  	_20
> @@ -805,7 +805,7 @@ test_expect_success 'colors can be overridden' '
>  	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET><MAGENTA>@@ -3 +3,2 @@<RESET>
>  	<CYAN> more-context<RESET>
>  	<BLUE>+<RESET><BLUE>another-one<RESET>
> -	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? <RESET><MAGENTA>@@ -1,3 +1,3 @@<RESET>
> +	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,?]? <RESET><MAGENTA>@@ -1,3 +1,3 @@<RESET>
>  	<CYAN> context<RESET>
>  	<BOLD>-old<RESET>
>  	<BLUE>+new<RESET>
> @@ -1354,4 +1354,14 @@ do
>  	'
>  done
>  
> +test_expect_success 'option J rolls over' '
> +	test_write_lines a b c d e f g h i >file &&
> +	git add file &&
> +	test_write_lines X b c d e f g h X >file &&
> +	test_write_lines J J q | git add -p >out &&
> +	test_write_lines 1 2 1 >expect &&
> +	sed -n -e "s-/.*--" -e "s/^(//p" <out >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
