Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4CB322557
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 23:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768950672; cv=none; b=GT7Fl2iz2YGyhn6yTUUfRMn0fbwyw5RwnjoJPHtzM7Hp2ko4c5a2Dc+kIEnSVAhi1Mvsd+ZzWWWrxgjhEM4UJ0emddAKp7Dy4/0O/9nFXFuOuthMoE3Nk/Pj4Tn8fG+8KcgAoFBzyidq7e25EcOMEXHbRgZZvnDxbHIMTXjxLhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768950672; c=relaxed/simple;
	bh=SnijZ4du6GCczHWD8c/9mcsoNoYqb9z+a/5DGBGkwGs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YdijPjLGcSbI5tqSbekt0GoVRgaK63UkSBzqp8juQRkwBPEN/83NhhuSLaX5EhTlcGJPnvTb1Px1tYupFaS+WJyTaL067bBn7c5Ak6OpaBR8B81YM8lbMM1gGjZVIxsvrRbljKLdQYhLVgcuVO9ZmCjbt+HVIrZ/eQJVeChqOAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SzuulSBd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rh1lCWIe; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SzuulSBd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rh1lCWIe"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E863A7A00BF;
	Tue, 20 Jan 2026 18:11:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 20 Jan 2026 18:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768950668; x=1769037068; bh=Lyltz3MGi5
	9ee8XwlDu/0KhZAkY3w/E22dRnqs+rQBo=; b=SzuulSBdF2i04rJjQILfa6zsv4
	PIUkPbEtm+mLU6pfqehPHiTTvmr07syX+eYrtncKvwY7v20WurxtJ1aYuSg7tWVB
	Itr9OrRNN21QezMxGO1rG6BA0L+e0+Y2Vkpj5MT+CToIsbaAi54CF30ge7U+hS35
	7nk+hJtTkvfuVd801BofH0MPtgfG4392C4KiOGAUAYR0LXHpgQxe67zkJiswyFYg
	Q9JEuHtVIa+9XjHSj0lJ7tlLlPujbPr1XtxeuKSGUI3oo3LQjxUIn1aQTyBYjHaq
	x0vhnOrWSCB+xzpxbqYDS+jbXqiJnS9WVwgqNEKAG9l6og1AYNLrByDPIKTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768950668; x=1769037068; bh=Lyltz3MGi59ee8XwlDu/0KhZAkY3w/E22dR
	nqs+rQBo=; b=rh1lCWIei1X73APTfJ03Oge524aCC6bi8Mn8NtQpQgHmfXhrRFT
	PDvrV/rxdFp4nXM1P/WTyEtSIcK0G71rzgU9VG1GYj+CeSZkEB6Bh/qnl9YFec5H
	c8BGpR+bqYruImjjx068A4h5GtGUqStYlHarVDcKkXW0+Sk1gknxlFwzHQFLYtvr
	W01jmUdD3p2dCyhsmJAXw9WTMm985b5ed/jby5CjzW7CENWW79iNIJHUNxH/7H0D
	WpqUYVg7kkufphdcIulom5eUzJUFqOt3ASIvqRYmlOYXR2/pn78/I/sYi9u8y5Ot
	i3Z3Cl4WU++sRcn7+Nh/3oEBElfVwvON3hg==
X-ME-Sender: <xms:jAtwadGdENc3qAZlexTzHwbpwPIXup09UgttnvJoYe64_7OpcEF1kQ>
    <xme:jAtwaU7YPG2lvmUsb1AikDn4uH9Ca1hcf5NAV7NCdb3cvfp0C58ZTlJnEP_7iUk1N
    1zJ4ZtIc0EUiXgZOeLeuut9PkMUVtUdZ-LCCk1g52dyuP8MGxSSZFc>
X-ME-Received: <xmr:jAtwaSwCRMCHeeljCcjZVnVst7oYQn9IYWwBNd3kqlXPsvyeOugXM6d5SLCeQTa1nPek8PyrTai8uG_v9qVunhFbQKWPJJYFMP5-Vwo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeduieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhish
    gtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopegtohguvgeskhhhrghu
    ghhssggrkhhkrdhnrghmvgdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
    dprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgv
    thdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jAtwaTMqBS1m0tD2UrTaOR4j2p67GhlW9d8VDD1ehJB_NbrS7aKk5A>
    <xmx:jAtwaYn5oHFQc8IRsCJPASOf4GOvIRn_8KwTr_BYZnAmKiFLoFaUkA>
    <xmx:jAtwaYQLqeuxjLVNVrC8Yusd8YhtQ-tez6uzFyPPLsLo7DQUgNW8gQ>
    <xmx:jAtwaXV7CRbZWXDFpG0DvgR_5JRO9Hl1XUTqkhA9pEfLxYg42JX8FQ>
    <xmx:jAtwaY7pR0S4pUXudQzqyOF_LJH5LkSCIiArL4zJTmxKxppr38c_uCqp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 18:11:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, 
    =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Elijah Newren
 <newren@gmail.com>,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH] replay: drop rev-list formatting options from manual
In-Reply-To: <xmqq3440x8da.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	20 Jan 2026 13:49:21 -0800")
References: <01a7acfaf87494419b3766da57d4c05cf99c79bb.1768873599.git.ben.knoble+github@gmail.com>
	<xmqqldht2fgd.fsf@gitster.g>
	<CALnO6CCaVdJQ2xSPfvxQzVCfPsjbWHhMFUiLoiPQtVn9MeKFOw@mail.gmail.com>
	<xmqq5x8w2t3o.fsf@gitster.g> <xmqq3440x8da.fsf@gitster.g>
Date: Tue, 20 Jan 2026 15:11:05 -0800
Message-ID: <xmqqy0lrx4l2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
>>
>>> If I've understood all that correctly, then I have the Python version
>>> installed for building Git and it understood the syntax. Given that
>>> the Ruby version is newer, I think it should also work against the
>>> spec.
>>
>> We have CI jobs to catch the differences so hopefully we know soon
>> enough if one is so badly broken ;-)
>>
>> Thanks.
>
> We didn't have to wait for CI jobs.  You can try
>
> 	make -C Documentation lint-docs
>
> which reveals that somebody is not expecting these multiple things
> there.  I think Documentation/lint-gitlink.perl needs updating.

Perhaps something like this.  Haven't thought things through to spot
negative ramifications, though.

The original comes from f81a574f (doc: test linkgit macros for
well-formedness, 2025-08-11); its author Cc'ed for better ideas.

----- >8 -----
Subject: [PATCH] lint-gitlink: do not get confused by overly long ifdef directive

The old pattern, when encountered "ifndef::git-shortlog,git-bar[]",
complained that "hortlog," (i.e., a substring that is up to 8 bytes
long, that comes before "git-bar[]") is not "linkgit:", which was a
nonsense.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/lint-gitlink.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitlink.perl
index f183a18df2..91621f9db1 100755
--- a/Documentation/lint-gitlink.perl
+++ b/Documentation/lint-gitlink.perl
@@ -41,7 +41,7 @@ sub report {
 @ARGV = $to_check;
 while (<>) {
 	my $line = $_;
-	while ($line =~ m/(.{,8})((git[-a-z]+|scalar)\[(\d)*\])/g) {
+	while ($line =~ m/([a-z]{,8}:+)((git[-a-z]+|scalar)\[(\d)*\])/g) {
 	    my $pos = pos $line;
 	    my ($macro, $target, $page, $section) = ($1, $2, $3, $4);
 		if ( $macro ne "linkgit:" && $macro !~ "ifn?def::" && $macro ne "endif::" ) {
-- 
2.53.0-rc0-249-g60c15f3eb8

