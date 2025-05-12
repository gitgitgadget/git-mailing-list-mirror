Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90712957B4
	for <git@vger.kernel.org>; Mon, 12 May 2025 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066934; cv=none; b=LL3Je7hBaWuqQ28xa/UZ0iOMgwTSFlZOsPXOCTythJrLbn9W/O8yv5CS3NZe+4xXqiBebi4hkbHN//9Y8ondrPGWe6uHDb23uLxPIZOa2h7OspBtw+ZT4/p5ib/Y+Q5pjHRwWMj7fT8DzKh1umD9JjAZEa8S/sBTaXyvv6JBVFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066934; c=relaxed/simple;
	bh=g1eUfrBtrerRtAjQCtBbdxNN8Ny/urt6BrV4phA1SB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WCuIo2+ymWw+kpYLvCTRhnTfvsfbJi+W1zAMXfVWjSAi/o3/RSp8J9n2P/szq0YnOwPDYhuaPJUNr+Krhq2KvZu0Ms5t67ryIUs5Rg5Iwzlku4cEpGgIuqBR2rbkw6Q1fnWu++aIoHqfVuGTMxRZ9yPU4viuzZG34ND6MOs3mRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kXmdBdIu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TYLLRzY3; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kXmdBdIu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TYLLRzY3"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 89E1225400F5;
	Mon, 12 May 2025 12:22:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 12 May 2025 12:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747066930;
	 x=1747153330; bh=IyuXtaeztvZIVZxUG9L4NcI5iZITYmXtQ8ibjcCOLOk=; b=
	kXmdBdIutlvvFIBgRyS9Tn735q3PXy45fb4lbYdMyrTLQmsd9hXKa1+MrOqbzYtT
	UJSlwklNf91VQMDX2BPYXqCzL/NIy2c6b7ABI/2B7Z88ojW/yokUCAvfDsBvw1R6
	QfNCB1f1iZGYJMEu1grhC+jYqnG2xO+SzGRyr+NkGJ8bajpJSfa6nnFekUdq6T0d
	xvc/2cRnYGMy1Ha+qzlUaMLcC4JmWvmNtEkXuM3vfbwNusuTU65ZWoxcMzvxU1+h
	f8eNHjgN/v/UvDrvGUd+xQoQ2FuGNSY4jfGsUIRhuvKQT2h3uqJ+UPrsEX7+h4hL
	x8WV9wNqW3c3j+InYXjwQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747066930; x=
	1747153330; bh=IyuXtaeztvZIVZxUG9L4NcI5iZITYmXtQ8ibjcCOLOk=; b=T
	YLLRzY3JSnP3E1vlFNNY3Nf27i6BPz4BOlWSDqHO1/jctDNr39HyTecSmm+6RLZs
	LKQGWx4BCiYFlwfZ3Nl2d5EXE5DagPHtkrUj08WYK8ogoGJRrQX4BX3KzCcvVMzM
	NJXWaagnb/3fXjzGu3VgsMog1Xc/jN7EXsIfZ0ir703gSgV2vE4Nmhe64/91yMtN
	nDfC4AZNoxMs+PvVe8k7PoCPEdTuMG1FQ62tWe6eifvNNugRK6ODdSvNbIWzhn1E
	GvMJceVt+ugNvrjpT2S6B5zvtINajt04Ew5SeKeTwxxuRrlx/Db7A5GplO8Ixa1i
	VTj0om0nwf2Ivb7wEVDXA==
X-ME-Sender: <xms:MSAiaC-4qJXYATN3qd7YCJv8lP_w3sGhjY1k6EJIBh7r_qmzKMUsvw>
    <xme:MSAiaCvCmiPY9Xx0zE2mW3I4EY3EVmwntXSwVejKzwB0WNZp0SMOoMFqvLRioGTIT
    fIbTmXuLpuAO8cRNQ>
X-ME-Received: <xmr:MSAiaICmW3TvvFAATqoEL6ixL5HfyHRZZQQN1KlSL1U_xJH4d3gCPO33AcJr8Vkt9PW9-gCPfcZpOIecinDLOVI4aZq6mm8rmE9OwF4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddujedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedugffffefgheffgeekgfekkeevhfeu
    vdefheevffdtieeiteefffeggfejfedtffenucffohhmrghinhepghhlohgsshdrohhrgh
    dpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtoh
    epledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohgu
    uddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesgh
    hmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehm
    rghtthhhihgvuhdqmhhohidrfhhrpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnsh
    hhihhnvggtohdrtghomhdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:MSAiaKdQgKX2-JLwseDfoK4WPIMun1FhsTe1Qt_Rycxlw8EeQN0lpw>
    <xmx:MiAiaHMlUCiOC104nT78v7hu_WYBgMUHHljfzCVrtSMemxfr3I1ZuA>
    <xmx:MiAiaEngr-zkkBf8SH9ENIp-2u0BrZfVNISTyCcHkTIm1G26j6O4uQ>
    <xmx:MiAiaJumTU6pb8oWcYB470TgrWsJCy1AY0-_WUQ5n7cFjC6Bbd3VKA>
    <xmx:MiAiaGef9pv7DAYqF2bWHQW03kspKBIP42jqpnEb4aa475f8wmN4WIAx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 12:22:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Collin Funk <collin.funk1@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Matthieu Moy <git@matthieu-moy.fr>,
  Eric Sunshine <sunshine@sunshineco.com>,  Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v2 04/11] contrib: remove "thunderbird-patch-inline"
In-Reply-To: <a3aaa11a-a842-4c10-8189-07b681663573@gmail.com> (Phillip Wood's
	message of "Mon, 12 May 2025 14:02:43 +0100")
References: <87jz6mo4n9.fsf@gmail.com>
	<a3aaa11a-a842-4c10-8189-07b681663573@gmail.com>
Date: Mon, 12 May 2025 09:22:08 -0700
Message-ID: <xmqqfrh9vlxr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Phillip Wood <phillip.wood123@gmail.com> writes:

Due to 'text/plan; format=flowed', the attached patch was damaged so
the version I may be commenting on may be slightly different from
what you wanted to show, but there is one thing I noticed.

> diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunderbird-patch-inline/appp.sh
> index fdcc9483520..72c37aace4e 100755
> --- a/contrib/thunderbird-patch-inline/appp.sh
> +++ b/contrib/thunderbird-patch-inline/appp.sh
> @@ -1,10 +1,12 @@
>  #!/bin/sh
>  # Copyright 2008 Lukas Sandström <luksan@gmail.com>
>  #
> -# AppendPatch - A script to be used together with ExternalEditor
> +# AppendPatch - A script to be used together with ExternalEditorRevived
>  # for Mozilla Thunderbird to properly include patches inline in e-mails.
> -# ExternalEditor can be downloaded at
>    http://globs.org/articles.php?lng=en&pg=2
> +# ExternalEditorRevived extension can be installed using the Add-ons
> +# manager in thunderbird, the source is available at
> +# https://github.com/Frederick888/external-editor-revived
>    CONFFILE=~/.appprc
>  @@ -25,8 +27,12 @@ fi
>    cd - > /dev/null
> +# The headers are separated from the message body by a blanks
> +# line. However the message uses CR LF line ending so on platforms
> +# where the native line ending is LF we see a line with a single CR.
> +SEP="$(printf '^\r\\{0,1\\}$')"

Here we assign to the variable SEP

>  SUBJECT=$(sed -n -e '/^Subject: /p' "${PATCH}")
> -HEADERS=$(sed -e '/^'"${SEP}"'$/,$d' $1)
> +HEADERS=$(sed -e "/${SEP}/"',$d' $1)

The old reference must be expecting that the variable SEP should be
already set up.  I understand that a different separator is used in
the new version, so it is perfectly fine that HEADERS need to be
changed, but shouldn't the previous hunk that assign to SEP be
removing an old assignment to SEP that gave the separator wanted by
the older version?

It turns out that after the post-context of the first hunk there is
assignment that the old separator value is assigned to SEP.  I think
that should go.

>  BODY=$(sed -e "1,/${SEP}/d" $1)
>  CMT_MSG=$(sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}")
>  DIFF=$(sed -e '1,/^---$/d' "${PATCH}")
> @@ -37,7 +43,7 @@ CCS=$(printf '%s\n%s\n' "$CMT_MSG" "$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp
>  echo "$SUBJECT" > $1
>  echo "Cc: $CCS" >> $1
>  echo "$HEADERS" | sed -e '/^Subject: /d' -e '/^Cc: /d' >> $1
> -echo "$SEP" >> $1
> +echo >> $1
>    echo "$CMT_MSG" >> $1
>  echo "---" >> $1
