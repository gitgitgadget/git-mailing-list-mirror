Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672482FF16E
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448195; cv=none; b=bd81mvcOZfn405j+W7qzEY3UDfS6ujuiuHQ4RmYQO1iKYHhdYfN2sVnTrkSBUb2fl/nPVwP0wTkrXiLfr9T8txVOOsW0na4ss/lU6mcTrRk1pvzETZVLG8eU8HR/fu7ZWTvns91KvRYUW6lbLMuGVs+FlYdEz2mAtVQixPy4oRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448195; c=relaxed/simple;
	bh=DjGzolQsDqZgmrP7fEMnaIXEi2URjWC7a3r4+fT8qE0=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CH/lt6AR4sjs8IrRRL81eZdopsTeNaJiWQ1XK6OFM+82+JhqP8la5qZyEWPnGfijBgxQjmDhf2dnP4i23GUcqvHMR55e8KtvL9CgSBB7kuoJfUJuQTcF2en8O7oQwa9dHrAtj+I+w8c+yRIGYFcTbpbMkfZV+0hdVzCBPKgywcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=OTQbyire; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qIXsiV4n; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="OTQbyire";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qIXsiV4n"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 54B8E1D00114;
	Tue, 14 Oct 2025 09:23:12 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 14 Oct 2025 09:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760448192;
	 x=1760534592; bh=hYdJQvOHki1eb5RWKM4UTE/k808nrIoNTMrn2uzVgp8=; b=
	OTQbyireANPx0TbXUw1MCmjO1RuGjtaUgSweu5XKI0huofZ7dzQESfCwP9aMqV9O
	YWhl3XiIZEA6pca3UyJhRTwyi/YriY8vFkRSr04hnAnKrYnvOYeTPOAyhysv3WCa
	felqGC0clPuwDs0H9bKWlZ9tffwEj61dBRe7coURyugxt0FBvZyXot9QkDO3oiMu
	aFiQtPZAx3PaHaWjM3E4zDgNVYGrg5rOSZW3ijC+HukNXEL0mlXTu4GHBEPArpWw
	vW0W7p8uN3+uDPvFz2egjfarLZ+gFLL4QWg1iNIs/hhSpLZbTZFeE0n/7+s52xNq
	TsW6IIrqv0QWlG5tyZFXuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760448192; x=1760534592; bh=h
	YdJQvOHki1eb5RWKM4UTE/k808nrIoNTMrn2uzVgp8=; b=qIXsiV4n7U0xpTCxt
	aVvQnVdmqc6HqtyrDT4zjsAtcsWPpw9jtkvYGTrkpaX0wRHZNXV+Dc/FoPf08PLk
	A4RK4RL5Qi3MJweoXlWyeX8MGZAjhlSh+0WwjnHTHw6Nt3l/JR6zChId3hnyKKoe
	+CaW3yxuK6mQpHo8vDjoJEzVswpecCF5PNq0ki8cvYAEkMrETV0QYcP5983SefmD
	pDpJT6AVzN0dNvKTf+xkYiI/QCzvvVw9V0CCPCU/nmQ38A/Mc9eteYvtEEYqoPoK
	t3r6A1HOmdLKPEThknGVQGsuK8tpEws5JixuRat/35hr+O3snTvs40kEUlToLxjE
	mXhkA==
X-ME-Sender: <xms:v07uaJgw5z9H2KdLNqWctfnehPiHmJsDvMfRn-PmnKFzKDr3_eM0fRw>
    <xme:v07uaI0Ux2Ie1m3kpGqqxwaJdSnRjSTL-lEDgn0YHSsJIkg6JMfLUKFzaZIifIuW3
    Hf4cXDnU54HlUo4FGR2U2DqkX6X3ePpFFs3z69mGjoyqlyyydgK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudel
    hfefkeehtefggeefjeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghl
    mhdrohhrghdruhhkpdhrtghpthhtohepmhgvsehlihhnuhigrdgsvggruhhthidprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:v07uaHJnks2o6PuvlaEefxcq_yRebW37aRhVe6ADbP0PzR300sJr8A>
    <xmx:v07uaGnF9Jd838XUxFyeL-CN8A55di6KXfYXFGiUIZb8wyu3xAe7LQ>
    <xmx:v07uaDN3Sy_H7CVvT5drHjkq8KflT1C_rRs2wBUNDpP5nRrDUsRJog>
    <xmx:v07uaE15aij1YlCWZIvYdZN_FJDqCSjbJjos3PUBwS1g-tatgU5ohg>
    <xmx:wE7uaDQDf-Cmld6DL0x-KYKG24ipWlMq5AbOl6tgJyTeJOVzpi5Oo7JS>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4D0411EA0062; Tue, 14 Oct 2025 09:23:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ACC-opc9_vMN
Date: Tue, 14 Oct 2025 15:22:46 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Li Chen" <me@linux.beauty>, "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 git <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <69565243-0d5b-4a11-9826-c4d36affbfba@app.fastmail.com>
In-Reply-To: <20251014122452.1851103-26-me@linux.beauty>
References: <20251014122452.1851103-1-me@linux.beauty>
 <20251014122452.1851103-26-me@linux.beauty>
Subject: Re: [PATCH v4 25/29] tests: t3440: test --trailer without values
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025, at 14:24, Li Chen wrote:
> Added a regression test to ensure git
> rebase --trailer accepts trailers without
> values while preserving the separator=E2=80=99s
> trailing space in the recorded message.

See =E2=80=9Cimperative-mood=E2=80=9D in `Documentation/SubmittingPatche=
s`.
Something like:

    Add a regression test to ensure

>
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> ---
>  t/t3440-rebase-trailer.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
> index 36f11f579e..df121efd0e 100755
> --- a/t/t3440-rebase-trailer.sh
> +++ b/t/t3440-rebase-trailer.sh
> @@ -50,6 +50,16 @@ test_expect_success 'reject trailer with missing key
> before separator' '
>  	test_grep "missing key before separator" err
>  '
>
> +test_expect_success 'allow trailer with missing value after separator'
> '
> +	git rebase -m --trailer "Acked-by:" HEAD~1 third &&
> +	cat >expect <<-\EOF &&
> +	third
> +
> +	Acked-by:

This adds a trailing space to the source which will make
`ci/check-whitespace.sh` fail.  I think you are supposed to do something
similar to what is done in `t/t4124-apply-ws-rule.sh`.  Namely to use
some placeholder character like `_`:

    Acked-by:_

Together with:

    sed -e "s/_/ /g"

I could also imagine that a variable like `${SP}` might have worked
together with `-EOF` similar to single quote:

   t/test-lib.sh:SQ=3D\'

But `t/test-lib.sh` does not seem to have that.  (Although it does have
`LF` (line feed)).

> +	EOF
>[snip]
