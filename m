Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152B839C64D
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771939243; cv=none; b=dcYCl83uTWe5xAZTqmN8kR9znEYVXaaonf3ZItFXsOkW6cunW900WzkesVKDT00DCBj1J1Bmz1MTqR28eYziWh3xDK8X20eTxvTmQpr4Z4sSRP1eZf+9VfeXoyJUtv1yQBYRdtT/0LNaFWy5jJygaPNkc8nuO4ME3uRL6Y3f4ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771939243; c=relaxed/simple;
	bh=YjRkfcOZG92+zQchZ0G6HnwHDrEgnhpbmBW36aqwFqc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EPwEeb//agx4e6+W7YfxcYKSbT+a1JJgUAEVl3wzmMNeP1ID3YmoekO5zUYBHbKyIVIvQPxBHnpKLX6YKUP1XUKFtZtH+0jD9olQ00/vDK7zyAp54NafEl7JfJ7RQP1JLJ2u6F3qcYZgxnSM6yc2xh1V8RfK7P/ngtDuyL7MfO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=m2eUDcQy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=faCF8l68; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="m2eUDcQy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="faCF8l68"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 41CF9EC05D0;
	Tue, 24 Feb 2026 08:20:41 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 24 Feb 2026 08:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771939241;
	 x=1772025641; bh=4rzfL5gbkxAa8POKrvQcd0ILdWI59iwn2bMnY6CjuJ4=; b=
	m2eUDcQyskeyyA9PY6jBDJzFDLIOexV8IBdxYAUdsBpLl9lT/hHD93W039fuu+S2
	GZX3Wdctk6VeK6/snJJRogymq4czh5OgKn75Fo3cxxYwmON1Ojg0A2IukmfL/cOG
	/mYD4dVyIYldx95NMRNxtv8h0Bp8M+3SYkAT8mDWWI8qFUU5ZxRLpJgbQNzSSYyQ
	POe/nesNa8YkHHKCM2DHMwccvyJlRcimIFFc7iDYo07h40CY6ucGVt5ldbYsktex
	ElTdfU89ERaQuCv4Bntosg/4olS8i6Lpbzz61SMz1RqK2K5TdrFVfcgzDD3vj66j
	3a2B8Dtk47SBCwTlu8KlQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771939241; x=
	1772025641; bh=4rzfL5gbkxAa8POKrvQcd0ILdWI59iwn2bMnY6CjuJ4=; b=f
	aCF8l68sDGsWkvsBI7MlxMwnO9AVRI1UFf8WGXjpyGTb3S2KbU2nomCRqTfbB1e1
	31TbVDwCDx2ZuM2LebGLt7P1xHylabtrK8ju2UPACZHlwHvIwvSkkdOqCNRLVgq5
	UC81zOLEuYvPRID+Ql5zv/e+/Dz1aVPsCZjRL3/P07w85Pv/nYpqUOCdAimbPL4I
	yyBqjW4yUZHww9LWz4lE0yFRw3kM3lyimMbjQ1aTBXL4GEoHoe+y4adZR5VjV2Bs
	TWz3ezCWrgzuDipLltV0hYHrPLvyzdcmxIJn+QKgBqEGdKOeORg5CiBhOoN8xt6G
	HzU6lBgIE2WXhhDwY1BEQ==
X-ME-Sender: <xms:qKWdafDrcrwnec5497nUueSWjgaCxu2txkA-PugIAbwXJ6PV0i7oQ0U>
    <xme:qKWdaQXptvnE0ifkncbFBdYJZh4gUMo8nqk7Vvy7I0ikDMZVUWRJ1TF0Yxy525ywX
    Z4ziW6Ze-I_qcUlPdhj7y9BlKW33NvBmFrT9RFOT50AU7Xgdt5QuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedtvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qKWdacEZavFZmp7hxOch_O-k-GDl7lzwyxKyHbWJEaQTZYhfsN_Bcg>
    <xmx:qKWdaW2H3b7tISwweVIJ2uklqq-j7yhLt1nHTU0EsvxaxK7YOn92NQ>
    <xmx:qKWdaWNUkN-_0cVxCAZvnP-tzob262DW2t0vqXoikx9StkunRHRXFg>
    <xmx:qKWdad45hYV4InWDBZsrtV5ZkCiYxt34zUJcDhEMsctjmRXvsEf83Q>
    <xmx:qaWdaRTuLKL_KAk21KrOKoXkasxaGx9RLKSD-UvN4237oOf55xGmA1fO>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8A6431EA006B; Tue, 24 Feb 2026 08:20:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AA44t9WoDwMk
Date: Tue, 24 Feb 2026 14:20:20 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Karthik Nayak" <karthik.188@gmail.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Toon Claes" <toon@iotcl.com>
Message-Id: <78ade921-321c-493e-ae4a-dbada55b0fff@app.fastmail.com>
In-Reply-To: 
 <CAOLa=ZTJ3-7OSbfRYbYuTaZBsPSSXrHHJ5LkCO_HSMw=y5+Gfg@mail.gmail.com>
References: <20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com>
 <20260223-kn-alternate-ref-dir-v8-5-0509c132a203@gmail.com>
 <3af8a2ba-dfe4-4e43-8f86-b03a0cbc3698@app.fastmail.com>
 <CAOLa=ZTJ3-7OSbfRYbYuTaZBsPSSXrHHJ5LkCO_HSMw=y5+Gfg@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] refs: allow reference location in refstorage config
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026, at 14:09, Karthik Nayak wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>> On Mon, Feb 23, 2026, at 09:01, Karthik Nayak wrote:
>>[snip]
>> It looks like dropping the list continuations fixes it.
>>
>>     Supported format names are:
>>
>>     include::../ref-storage-format.adoc[]
>>
>>     The payload is passed directly to the reference backend. For the =
files and
>>     [...]
>>
>> Maybe because you are inside an open block? I don=E2=80=99t know.
>>
>
> I don't know either. But this seems to fix it, let me know if it does
> for you too.
>
> --8<--
>
> diff --git a/Documentation/config/extensions.adoc
> b/Documentation/config/extensions.adoc
> index 3e51da36d3..329d02b3c4 100644
> --- a/Documentation/config/extensions.adoc
> +++ b/Documentation/config/extensions.adoc
> @@ -67,13 +67,13 @@ refStorage:::
>    format and payload (e.g., `reftable:///foo/bar`).
>
>  Supported format names are:
> -+
> +
>  include::../ref-storage-format.adoc[]
> -+
> +
>  The payload is passed directly to the reference backend. For the file=
s and
>  reftable backends, this must be a filesystem path where the reference=
s will
>  be stored. Defaulting to the commondir when no payload is provided. R=
elative
> -paths are resolved relative to the $GIT_DIR. Future backends may supp=
ort
> +paths are resolved relative to the `$GIT_DIR`. Future backends may su=
pport
>  other payload schemes, e.g., postgres://127.0.0.1:5432?database=3Dmyr=
epo.
>  --
>  +
>
>
>>>[snip]

Yeah it does. Thanks!
