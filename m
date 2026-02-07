Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A96C50276
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770499624; cv=none; b=ipgj9pxamLTfJaYUDAZD8NvZrIfVPHQkGv2Ut7f9H1i3jR7ofYlqDW/igUvhHHslM92fwzvxxobRYHR6BQFM0T8KEG8Z3bAaF7Pj1lOXPC3mEBCSi2ViOBCcxaKF06or8D3wmePa79Zsdr926waFHLTdBnbt+OEmrjLX1c7Yfe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770499624; c=relaxed/simple;
	bh=3Jx47orIB9T6adYYCvsq5BghV5NxYqJ8h+RuXfP8djM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mts9+E0IVahk+1kxG1H1xPQlZczN8k76rrMb0y5XZcIXzBLs2Tc+sjBK/EJb1IWVYdiz9Zopcziv2EfNOENwa5UqzDc/UTujgic3D8uLWehIvIcDgvDD/Ld20tRDsOro7DT2OyzUSxyTd4hUpl0DeupOfs5sznnh+Z2k/YHNjBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qSDL++3c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q1dWhJSY; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qSDL++3c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q1dWhJSY"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5BFD51400051;
	Sat,  7 Feb 2026 16:27:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 07 Feb 2026 16:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770499623; x=1770586023; bh=Eu+BTsuROi
	aWY0D7UEbQfFDNxpRqWS8bEfT2J7Puxe4=; b=qSDL++3cwU5NH1+OMffOJO1ShL
	h78z9orgPn/izWD/6BWRPjaSAQVPyhQRsj42lMrCYbI0nd7lQ2Od//MZjSy2vZqN
	vhYSHMB/N6vnS0+dh4YOEd98rPmHO1FCmEtfJiKNinB/LMZj0JhLb6soR8Q5Omm6
	k4cpdQgr077dSY0Kt9rw7+YHIrvowGdEzyF847uSeCaAwdSOJ4FB87zB46u5TMfJ
	m5x5CdshshOORXC0/WgBA7a/8lKGcEhgMrnSwIiNokP0CkTopDV0L7M0aAJn/Cdt
	zgcg3XqYxYEPXX/Ui1LnxgwGsAw0kYKG4jBYlMwycADfJ9RKH+j+dJGLymuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770499623; x=1770586023; bh=Eu+BTsuROiaWY0D7UEbQfFDNxpRqWS8bEfT
	2J7Puxe4=; b=q1dWhJSYt3GUc+3jCSJxDz1HBb/QuM0UuupZvQjypbvIo/RUO9z
	D8KYuNqQ0eTueIz8k/8WNHHhnHXv5BC3DCZavlsVpksxW9MvYSt+XL+qY9REy8VO
	W9h7DYK43oDq2z0OLE+fkifESTWD/92ES0a7eIneCEmv46gP6+llJjbDSaziVqDU
	pfZOQR5/uP/qzL+AgPYu+kSYWM5C+TkLncK8EbFsK7cPhEAtzT/yUI3N0qWs5X5z
	kniakGm8TCK5zZI4t81Kb2nJt69l0mntDV7y51TNyKAjrsndA8Q1hTl8wVx7m8/W
	e/fU50ryG/OZ1OQhdfs0zpUejhG+lPYceMw==
X-ME-Sender: <xms:J66HaU7Mt7b_LsQ0lxFfI9Pp8UtkRKUYWiFO61UkFxGhSGeg46TSdw>
    <xme:J66HaYIVhujFdv1Ucn9-umJLXx1XG06vVLcKaSxRdIlro6HP-JBGKIavU42XT5NOd
    pG0_4iwm09o4CKcREHhPdjsFxKlzAXFPfIhu1wvw7HcwBZFHOLd>
X-ME-Received: <xmr:J66HaVvQhfNwUfjr6hIfzZn_VCyrO5GHa-dqBwTjGcuDIAyz2NpTvbQBJ1JUpTOdcIer0oC4zu24fM1KT0K8cQMOhfHoyczUzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledvudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmrghilhessggvhigvrh
    hmrghtthhhihgrshdruggvpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepphihohhkrghgrghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:J66HafLmvnU1lrSgQjBlecvPWLJsDda7OoJYhXpM_v64ghOu3dc-Vg>
    <xmx:J66HaW-VkrBfNUktYTBh0BRgi0uZ9wOgUlCKM3SP1cEZzvHz3pSvzw>
    <xmx:J66HaQy6TDdQNKnQUwfCv0Jm9zoVsypmTDNn1iHNOf87nDGbG7TkuQ>
    <xmx:J66Hab5avNnXGgpeMR2ifaxJpQR7pPJpGWjI8u93dMzL4Vka6ZMC8A>
    <xmx:J66HacB4LscYPACxESuJoFLpjIq6FvqOEuDC-xQAwkHV_0XTYtGKhrd0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Feb 2026 16:27:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Matthias Beyer
 <mail@beyermatthias.de>,  Jacob Keller <jacob.keller@gmail.com>,
  pyokagan@gmail.com
Subject: Re: [PATCH 3/3] templates: detect messages that contain a separator
 line
In-Reply-To: <83c100a73ec722bf72a15b7b40b0c82bf8829168.1770476279.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Sat, 7 Feb 2026 14:58:02 +0000")
References: <20260206090358.GA2761602@coredump.intra.peff.net>
	<cover.1770476279.git.phillip.wood@dunelm.org.uk>
	<83c100a73ec722bf72a15b7b40b0c82bf8829168.1770476279.git.phillip.wood@dunelm.org.uk>
Date: Sat, 07 Feb 2026 13:27:01 -0800
Message-ID: <xmqqldh4b5y2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Messages that contain "---" separator lines will be truncated by
> "git am". This often surprises users so add a check to the sample
> "commit-msg" hook to reject such messages. As it's conceivable that
> someone is using "---" as their comment string we delete any commented
> lines before checking for a separator. The trailing ".*" when matching
> commented lines ensures that if the comment string ends with a "$"
> it is not treated as an anchor.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  templates/hooks/commit-msg.sample | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

I have no qualms about the topic up to the previous step, but I know
one of the things that I sometimes do will be broken with the change
in this step, namely, when I know what I want to write below the
three-dash lines, I would commit with "---" and additional notes
below it, so that I do not forget during "format-patch".

When the commit is turned into a patch email, possibly with some
other material like "--notes=<ref>" that adds notes there, the
resulting message will have two three-dashes lines, but because "am"
cuts at the first one, and "apply" knows that the garbage lines at
front, including three-dash lines, do not matter until it sees "^diff",
this works out perfectly well.

Admittedly, I myself do not send out so many patches as I used to,
but I suspect that there are others who have discovered this trick
independently, and they would be unhappy to be interrupted by
commit-msg hook like this.

A saving grace is that when the user is stopped with this,
pre-commit hook that inspects the contents to be committed
have already run successfully, so rerunning with "--no-verify"
is not with too much risk.  But still, I am not sure if this is a
good thing to do overall.

> diff --git a/templates/hooks/commit-msg.sample b/templates/hooks/commit-msg.sample
> index 099cc58c303..c7a9db88cb9 100755
> --- a/templates/hooks/commit-msg.sample
> +++ b/templates/hooks/commit-msg.sample
> @@ -39,9 +39,16 @@ comment_re="$(
>  		}'
>  )"
>  line="$(sed -n -e "/^${comment_re} -\{8,\} >8 -\{8,\}\$/q
> +		   /^${comment_re}.*/d
> +		   /^---\$/{p;q;}
>  		   /^diff -/{p;q;}
>  		   /^Index: /{p;q;}" "$1")"
> -if test -n "$line"
> +if test "$line" = "---"
> +then
> +	echo >&2 "Message contains a '---' separator line that will confuse"
> +	echo >&2 "'git am'. To fix this indent the '---' line."
> +	ret=1
> +elif test -n "$line"
>  then
>  	echo >&2 "Message contains a diff that will confuse 'git am'."
>  	echo >&2 "To fix this indent the diff."
