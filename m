Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117EA2C21FF
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783784523; cv=none; b=RbJF82gNbGLr8TSfkTEoDVLK1T7sFAMWLYgdzCPe14OfyPgBLMv10lfAH/OJfBPtWyl8SwQZnpsEryzQ6CQtvVKXDOYqIPHYupoa1yNx/N7f/BRt9rqXxE+nqscIpFCkHQYjnnZIdwwOkrjlT61bt5MyRcncPYiQpERUrD1rrBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783784523; c=relaxed/simple;
	bh=McTiqoX5sfnu8ZIpjs/efwDuVJixSnuCMOC20WOc/bs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=X0Xu+vrYmn8aFOuldLmR1KNHV+d/PL2MKJ2hqFb77+/Mks/qlRCSnHHXoXKyB5EJvLu8+oBqSSiyWctkTE4fN+qyUiTxNEynoa3A7M1CWIwayLv9sqaZauQiiC3BUF3dQLLQcvzVsu/sNP5DFxuDxypX1KzaVlwAuELyXpiyRus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VR3/D/sT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VR3/D/sT"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso15204105e9.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 08:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783784520; x=1784389320; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YtOSdhLwq92aV4w8vbHVDgaRwbV0j9+ulT4GBYzzxFM=;
        b=VR3/D/sT9rc8n1Hpb+bcBxbJEeMuWnX6c1TYWNJS8JdNFNL4dDA8E1cJjRRTE6YkmH
         Io6KoTHPP1I9J9UMGZelw/ZQs5aDhmXI5ovSq8ARj36xGyFPuuiXHUKWUr7VOSz1hmpD
         btlQoJZtQXT1Po/3hB5T7hO5hJpobRayiWUT7H5ROLwEDHeQzZD6QWfQjuOAgL92fkBq
         MCPAQIpHaeS/ln5pLsAfLVA0OgfArpt2bCRaBCYL2cOQL6l0yo1MnLQ29iUPKeuyPD7W
         dMkNZvGuJxBIda+Sn9L1ZdiEByZSgwdpRDpHYFdVSxqEpohIB2LZPNc/q5jPc3J+hPGC
         FlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783784520; x=1784389320;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YtOSdhLwq92aV4w8vbHVDgaRwbV0j9+ulT4GBYzzxFM=;
        b=arRNf8DJHie0gjkN3eDWBBfr5R9gBLcukaeXZIgKLiccr6oQfQKE0V40NG2hpl7YLd
         rVFdhZiS43XPvi6Z5sFTYk8QCJ9GDgQkBUvI1LjVjQeOo9bEAb4/OU52fWAGvI27yGS8
         CrXh/6N9XYgRtTlx1tnQxQpYrD7T7lPFK4LpC19rvjEPcQEjn0sNFMVdUQAGJLLL3rnL
         dKGM0kmp+JUPtLyvpvTTXZiMMPArGEOXiJPpxmBusxdOnKnvEzebp+eizK7GYjh3k9D2
         NmLEC/mnmkN5QUpjnPis0J9AGCx0jpSf3Um288AYghCFf5QNNfOD4mdlPWm1QodKgRwS
         3qrA==
X-Gm-Message-State: AOJu0YxZ4tP7pp+0tZPC0NZe0k3xTVrSpq9iwip424GBqw1xgW3mJ0Ja
	hqoeVBjVQxsRPIHYLSRnYlARk0Y5sJhlAv+RwuJlEDJbnqXrkuGkGKQw
X-Gm-Gg: AfdE7ckZH2J4VcojcI1eFf4WtXPmc7PTdCmWYF1MrjkJbyvIoF1aFcOzxu9H73bRP9z
	NKJZTaT2U7n5DssJy6PfEfUS5MAfSyu/vLh5oTwuP9s1zIJyqwgnRMmaHOMTn0S8473R9vzVq+h
	Hx0ekmd2Smv9jufjDmcvZnczpfJDuIRiESCQSjYBN2R0dUft9s+raDW5JG6nb7QOVc/lrXMCdig
	sbrT6sivww3qotSwHjU5jboULaiKTZJhmvkqsVv87E67z6V5R9TGdyAFLs7sNbesB3Sf5axf91C
	I8uGVxVq0NGpwr4zCtRoi74Emj0Gc3xc0q3KJD6zrer5p93ZKHqRUbg/LBVLCgp3MFw0HfNPTH/
	h7Vk0tDpvmHh5OXJkuMnRkQoyUsFmrL4UHAqWjPDY2EwsebPvt/oBpoExLV9k+IxXMzLNNItdt+
	Xxp7OBIEkia/nfW9yLhYiAwzxpBwOBo7X/0xa4jLVg93Y3MpgfB6XAJV1KmdNEt7nxEm5NvZIjk
	TqUez8H90944la2BA+EU6ZIv5quYPeMWkV5/CMqo3Ja7On6nr3L3RQIhPSKSniDHA/W/CTWGQpe
	wkV8c1Z6Gd8s3uVcnC4yBJ9YoNiXiK+41ghLIhWTj8fFHNyZzuluwHllKCa4qlps6gEaYQ==
X-Received: by 2002:a05:600c:310f:b0:493:bacb:1341 with SMTP id 5b1f17b1804b1-493f87dc3e8mr25603555e9.4.1783784520410;
        Sat, 11 Jul 2026 08:42:00 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2a2e499sm151121315e9.0.2026.07.11.08.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 08:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Jul 2026 17:41:58 +0200
Message-Id: <DJVUU76PUXR4.2BYRTA8SEEBVC@gmail.com>
Subject: Re: [PATCH v9 0/4] graph: indent visual roots in graph
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Mirko Faina" <mroik@delayed.space>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
Cc: <git@vger.kernel.org>, <ayu.chandekar@gmail.com>,
 <chandrapratap3519@gmail.com>, <christian.couder@gmail.com>,
 <gitster@pobox.com>, <jltobler@gmail.com>, <karthik.188@gmail.com>,
 <krka@spotify.com>, <peff@peff.net>, <phillip.wood@dunelm.org.uk>,
 <siddharthasthana31@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260710-ps-pre-commit-indent-v8-0-d3b636463bf4@gmail.com>
 <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
 <alJOgYmAfGg37hsB@exploit>
In-Reply-To: <alJOgYmAfGg37hsB@exploit>

On Sat Jul 11, 2026 at 4:15 PM CEST, Mirko Faina wrote:
> On Sat, Jul 11, 2026 at 03:37:49PM +0200, Pablo Sabater wrote:
>> When rendering a graph, if the history contains multiple "visual roots",
>> actual roots or commits that look like roots (i.e. have their parents
>> filtered out) can end up being vertically adjacent to unrelated commits,
>> falsely appearing to be related.
>>
>> A fix for this issue was already attempted [1] a while ago.
>>
>> This series adds indentation to the visual root commits, so they cannot =
be
>> vertically adjacent anymore making it easier to identify them.

 [snip]

>
> Sorry, I know I'm a bit late to the discussion regarding the design,
> but, could we maybe have two different code paths for printing graphs?
> Having the old one as a default and this new one only when we're using
> --oneline (well, --format=3Dreference would benefit too)? As it is now if
> I have multiple one-patch series in sequence the entries are
> unnecessarily indented.
>
> Thanks

No worries :)

Well, I thought that it could become annoying given the scenario of
having too many visual roots one after the other. But I didn't have a
clear way of having that scenario without forcing it.

I think that this solves an ambiguity so it should be the default option
and someone who doesn't want the indentation has to explicitly unset it
maybe with something like '--no-graph-indent'.

Apart from having an option to disable indentation.

We could have the cascading to have a limit or make it zig-zag:

instead of:

A
  B
    C
      D

We could do:

A
  B
C
  D

This would have its own edge cases like:

A
  B
C <- if we zig-zag here C and D become ambiguous, currently we are
D    indenting only the last commits (visual roots) here we would have
D    to chose between continuing cascading or indenting the first of D.

I'm not so sure if I like the zig-zag solution because we need to think aga=
in
if it causes an ambiguity, but I wanted to mention it.

I think we need some more opinions about the design.

Thanks,
Pablo
