Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971EC157465
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416005; cv=none; b=QKSt0eWJxeHX3NTs5zIecQmlweoYMigi5yIeZjfFUSR8T2toNjKuhMMLgGrMTte4UFR0TJCe/CnExtqKZSMqosBWiUTxy537lbmEhDiI0W132ENIeTZKaK2Z4X50SosB+VL+MONI7nt3FUFhk789Mu6KSkzPn30qpK8EjejyYW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416005; c=relaxed/simple;
	bh=U7KrPqVuQXt6i2gwyASj6nA5CKZ00GtDuDPLfqbbvOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IS2ocp2xXst+Ioa4PkGICuuuSIC/I7r+n58YVrS62F2ApefHgo1jVn4Q5ILPZK/CSXvo540ij0Cv4+dyhTGtfacV6ZTc7ReVdK8bfM2I1uIrotsGKMZ9LPqfbLtkiXLk1RrJ8FySi3n+EXsp5V7YRGi3wdbteIuVZtcljh6A7rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uuUvZQ+7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zi6VArxw; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uuUvZQ+7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zi6VArxw"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 968F813800F6;
	Mon, 24 Feb 2025 11:53:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 24 Feb 2025 11:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740416002; x=1740502402; bh=oWvuMkWqVU
	v4OXztqv0RV/Fn2NfWyiDgLuf5C7sSfY8=; b=uuUvZQ+7G+wm7JmKbNF9neARe9
	sP11UeixodNbNeJcgn07ncQJcP8/IlWbbtzo8SlclDwk8kHBnYlzlbqfw/YxjPS7
	qzpGDfV+I3Fzc4+HcYLYXBbRZleOOhOFeSy8EPFi5hw6XsN+e9iIKcUiQFl4z8VP
	C34caYBb5S4JyQJSLFLUD6FjABAjNwcQJYUpCcaYJLza5nVht5z1f0sD27hJNTag
	xAz2sOdrSCcJ0BjiuIYBGMie4esYSfQdIj/Rdu3lBa0i0PIOLMaappIFAnqDucz2
	wiFi/XAi+LiZpyyINysN9y90ACiyqJtp1jqEhRawdGptN5jlR47lIP1F0Mhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740416002; x=1740502402; bh=oWvuMkWqVUv4OXztqv0RV/Fn2NfWyiDgLuf
	5C7sSfY8=; b=zi6VArxwpDO6zuTkbRhq0ruDga50dt4C0XJCgz7h2pThQ6sgIlM
	5zst9ARW7pu5PosCa9EEC1lyNcCJvolBAGk8vWHY1k92B90qKXCID+hxY2JPZvTr
	7v/K9gF2JnmTrcI/9tjVF2giLcHcf45HCauw/+PBw7k+6gw+2kGB4e3NmHV0uhVp
	938TFCwRyoXdui4R8nvhP8/c/WvqkqrTZLeRqh6x/f6VRKy9MqfaJ7GdlsYK6cEH
	hr8X98vMj6rVLT4PSGiNFVrvAXkQrVlcfC3YedMk7APInMxHpbuE0R4n5MAFReCU
	syZB9Dh7DOH2Ldfnqve92ltDqex1KBe64nQ==
X-ME-Sender: <xms:AaS8Z5ZKcrzXQnbfUkOC0hVnASqeP4HoHET7-Km3khTB0pHp4TcBUA>
    <xme:AaS8Zwai6gnf_YjCbco_vjqnFrSbSYmkjbRhHSYqFIoIwzyfquRdSepht76O8Vhm5
    DklO8Eey8X64KvnLQ>
X-ME-Received: <xmr:AaS8Z7-4YI8eUsz5T3ISPbTTH76WQgOALGsl_7y_rDJxzYni2XYbop7vmZCpcPGIyzzsw9tAXsNBV1iwuuxrFywhJ5_9MyAvHMMyyoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejleefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepiihhihihohhurdhjgiesrghlihgsrggsrgdqihhntgdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    uhhrrhgvrhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:AqS8Z3qvISnfEDJED9bwV1RIOdSxpRBE59nK2wVMoJSyeT0jOz4xXg>
    <xmx:AqS8Z0oXu5OIxi6Est5ME8u1wwzqMj0rQRfFhy-C_T9tTSCIL18r6g>
    <xmx:AqS8Z9QCtCIbK6YGfL95Ph7gg3e7nFgp5pGoGssfAlCsSkzDLunnew>
    <xmx:AqS8Z8o9PWc3CO8NUSJT0tos2GP6bHIXz74Wn11tCs2jA4HMO3ercg>
    <xmx:AqS8Z9n7aBFAt5boTz3CrF6sqfBqqNoIAXuGspWTIJ1-Fe39LeW8059c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 11:53:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Cc: git@vger.kernel.org, Ruggero <giurrero@gmail.com>
Subject: Re: [PATCH] doc: fix typo in it.po
In-Reply-To: <CAFXmTzjQuZn_b-nQHkYo7KHs9__gc1ctoLx0KioTcPEkqak+9w@mail.gmail.com>
	(Ruggero's message of "Sun, 23 Feb 2025 21:56:25 +0100")
References: <CAFXmTzjQuZn_b-nQHkYo7KHs9__gc1ctoLx0KioTcPEkqak+9w@mail.gmail.com>
Date: Mon, 24 Feb 2025 08:53:20 -0800
Message-ID: <xmqq5xkz708v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ruggero <giurrero@gmail.com> writes:

> This patch corrects a minor typographical error in the Italian
> translation file (it.po).
>
> Signed-off-by: Ruggero Turra <giurrero@gmail.com>

Jiang, should I take this directly to my tree, or do you prefer to
take care of this as part of the upcoming 2.49 updates?

Thanks.


>
>
> ---
>  po/it.po | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/po/it.po b/po/it.po
> index c4af156c80..e43f0fea5e 100644
> --- a/po/it.po
> +++ b/po/it.po
> @@ -17602,7 +17602,7 @@ msgstr "Controllo la ridenominazione di '%s' in '%s'\n"
>
>  #: builtin/mv.c:185
>  msgid "bad source"
> -msgstr "sourgente errata"
> +msgstr "sorgente errata"
>
>  #: builtin/mv.c:188
>  msgid "can not move directory into itself"
> --
> 2.48.1
