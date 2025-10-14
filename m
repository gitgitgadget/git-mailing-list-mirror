Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9881EDA02
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 20:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474613; cv=none; b=caoZeOMT06lkL/x7zdkPdx9oIkH9VL9FXNfD+4EZSeQlj7+cGZd4/d6HBb884H9Om5W8iqSdCzz1md4FxHno5V5sANO/eWcnT1u5xGOrSddV5K7bA+VN+xA6rbtGdi1CwEMQSZwFCKzCM9p+tOGAaQjRilZQxmon5PwWL26SCzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474613; c=relaxed/simple;
	bh=GhtDdUfi34dONJGXUCBzxV9EwASRGOjdmrU977etZJA=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BiVsU7uS2/JYHryZa+ZHU8kqpygHVSdXP0csHvHM9bamkM1r/EiRwPBbeNU6soB93fIKPVAnOPvJc1UUmurnAPB0/k0lvYcyk7E3fIu4o8f748/UyS0DMt78hzVBvRIBfDdTL6UsSfngP342/cPdNXbXmjGqHAQr5hIPeWrenUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Dl2IMaNV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bi3ZHlly; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Dl2IMaNV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bi3ZHlly"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 54A9FEC09CE;
	Tue, 14 Oct 2025 16:43:30 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 14 Oct 2025 16:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760474610;
	 x=1760561010; bh=+n+Kn2JErGDwlaauQ6P2pTp8dNoVevsd4ri5wPS5Sd0=; b=
	Dl2IMaNVUwsG1J5ZAHmn9L3r6FQ/ASRz9AoYbA8PJPjL4m2JpHoaz4u330RVFxVH
	iGI7ruTbz5VApA7xuISstDIy5bkt0EY5gOOWlrA7NWiUax7yhSzO3t9VM+qJIX9i
	xBy6yucMSHpPNni26rAg4mlqm6Q1YK/nEisZKBzTB5uIbMiMQuTTyn4l9V6lnXw4
	nONfFfwQc1L+Y/jsXAzgWYLiP0i8Y7Tbvg+EtcIT2yupZ5LnIyl5vsc6bdqpMshn
	08hv0SqRXYIwTD95NRRSEDK/Vc7/DmKoyzmQ+WCsVyxI+d2tbkHsjexk6myMP+Wy
	18CgK240LjC8qraviZBvAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760474610; x=1760561010; bh=+
	n+Kn2JErGDwlaauQ6P2pTp8dNoVevsd4ri5wPS5Sd0=; b=bi3ZHllyZVnFKABaR
	W7L4HHpBnRqDIot4wg+ST3St3tLVyHiWZ+aVoKi/p6SX41hswmW76vyEv6wZQFSY
	Q7Cerui9zR8tFo4VoY7FgLu9vFWgwhMYTkBj1tQnlXph9YBClahzNC0qYxRSNiiE
	ekBdqz7rUAJvgnXMXfopZcwWrtYzAujEDeuDoXayn+UUUQOnSEl4aJpz4S/E6TrV
	COvddsjw61m5EruykKKYAjWTre4e0FR+orG3XHC8rK7lYLWIZAWxWAfmJpX6Izkf
	9ISXE6IIUjvYQ+PpZBvqhvRYiNyRFouOxqwxTw+tZyvHdorQPf+vLa2iQ6MhAk7h
	4eNng==
X-ME-Sender: <xms:8bXuaDhXinAYgB_BB7MNosdN19EoNjRqhQTaaMTGtilixAjFTV8K-E8>
    <xme:8bXuaK1Gcgg03esk5iM8HvJ9629uSlEHSbmaKjCd4Qt_G3iNlk3ICuhaM2Tl5mW8L
    tZG4vR0iMHTVqYrOxs1uqBJaeQM4-Nz2U-zq6hK7do65y1JZgBZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdduheduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:8bXuaBKVEpdrxQwPuwX1Cs5gS7wBlHIq-Cj7KcopitzdhmbmF9XijQ>
    <xmx:8bXuaInyBVzDOjNoUt2z0rBqxtHTTKoQtQzSklR36epaR3VtCiFhLg>
    <xmx:8bXuaNNtpnKjTDkgdhg5Kwd4UOxRiNNraTISPSbLtzwDc14F8V4mnQ>
    <xmx:8bXuaG07OatOFVWRfgLv5SB4kkEypLE2v7bzSoRjejxqNm-GyO9opQ>
    <xmx:8rXuaFQCJsbx-P73DSbuNiobVC8Mx3g7wUvUtkUFAe2shGy9GIVW9Rag>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 979CE1EA0066; Tue, 14 Oct 2025 16:43:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9kCBF-IO53s
Date: Tue, 14 Oct 2025 22:43:09 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Li Chen" <me@linux.beauty>, "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 git <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <a0fae0cf-a1c0-4086-bcc0-a66f1aedf512@app.fastmail.com>
In-Reply-To: <20251014122452.1851103-2-me@linux.beauty>
References: <20251014122452.1851103-1-me@linux.beauty>
 <20251014122452.1851103-2-me@linux.beauty>
Subject: Re: [PATCH v4 01/29] trailer: append trailers in-process and drop the fork to
 `interpret-trailers`
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025, at 14:24, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
>
> Route all trailer insertion through trailer_process() and make
> builtin/interpret-trailers just do file I/O before calling into it.
> amend_file_with_trailers() now shares the same code path.
>
> This removes the fork/exec and tempfile juggling, cutting overhead and
> simplifying error handling. No functional change is intended. It also

Why =E2=80=9Cis intended=E2=80=9D instead of =E2=80=9CNo functional chan=
ge.=E2=80=9D?

> centralizes logic to prepare for follow-up rebase --trailer patch.
>
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> ---
>  builtin/interpret-trailers.c | 116 ++++++++------------------------
>  trailer.c                    | 125 ++++++++++++++++++++++++++++++++---
>  trailer.h                    |  18 ++++-
>  3 files changed, 157 insertions(+), 102 deletions(-)
>[...]
>  	new_trailers_clear(&trailers);
> diff --git a/trailer.c b/trailer.c
> index 911a81ed99..8aec466b5f 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1224,14 +1224,121 @@ void trailer_iterator_release(struct
> trailer_iterator *iter)
>  	strbuf_release(&iter->key);
>  }
>
> -int amend_file_with_trailers(const char *path, const struct strvec
> *trailer_args)
> +static int amend_strbuf_with_trailers(struct strbuf *buf,
> +									  const struct strvec *trailer_args)

This needs Clang formatting.

>  {
> -	struct child_process run_trailer =3D CHILD_PROCESS_INIT;
>[snip]
