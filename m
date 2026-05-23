Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A06175A8A
	for <git@vger.kernel.org>; Sat, 23 May 2026 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779549465; cv=none; b=M7pR26fzqW92PMoUrgsIkPOerHuDcZcjiffFO40PlHrwoNXZdt/UB+6Xhxp9jj/sbxRU9DjXKhO4j385ZI2xIXnMhUnpRKMsrSjuD1HdQz6s59ls0ped5iU3N7T83k3b6BPCb23HelccgVR26/EPT4ASM+Fh2fmGFZZ6QtaY8zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779549465; c=relaxed/simple;
	bh=57BbxosPJLcTtlni4lWkopGr9N6SDA+Xe8pHDaZWtjE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fL1r/wVv0mOZXQLFWufOS2ORzk2R1flMBEJeloPBWEYdbJuQi2ZgKBHKsqhj/cQi/I3uqma6lBnqGd7LeUS+nKbWiECg20MoGXRDpXjzhtWt6xXv57oiAr/IbXj7FDceNu3yALS77bRanuBAT1Ft6laKrjMBmEV5B8fh/ahbZi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=iPeE4s1F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N5ztcE9N; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="iPeE4s1F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N5ztcE9N"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 59672EC0173;
	Sat, 23 May 2026 11:17:42 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 23 May 2026 11:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779549462;
	 x=1779635862; bh=msGI7zv0GRIeyFDJSXjak0t46jwbLrdxCbvPCJ/qnc0=; b=
	iPeE4s1FtRKiFxgbq7cxO4Guy5Q6Miqn82Rd4zgyNvME2rZ2Z7zzUzf835XDSlOv
	2yhmzVHLazfo22TXBKiNQblZIii/LK6MBgsHwxz2zcQ943aG5vgCuxZ32bGdV/os
	K2j2PsnjsHNCly/0yTubbMAMLvQe6szSk8u7yLF/RRzXHtWfVSrhSMJu6xcA9ULJ
	5Zs/qrksh/pTyevpQ5QaJ9xwvTqCTMgnnF1/xC4OuREtr4Hco+DzjLMfwlfi2O9M
	Iy8okhv88c0DpOmZj/vJVHzciqphocP+MQY2XaYugBAtkjF73TOACTBHtilWGgAj
	bA59CCX+gtEcQADYGUZvFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779549462; x=
	1779635862; bh=msGI7zv0GRIeyFDJSXjak0t46jwbLrdxCbvPCJ/qnc0=; b=N
	5ztcE9N0gkzlV0/vaIjco+UimJK8HUzvD0c6spEY+uhxeRjLQjnUL3SuFF+MT6ys
	eSBjcoAjTuB8yvaXfiHl42fg2Vcchb77ClPLm5ot39vsmmPl785lPgDm2SG47v0P
	XmSNRa/cFnlYDFELanliC5VhixmS8sJhWEVt9O4FQE0ssy+CTIbXZdr4vV/NLbo5
	96ncCxqaDhclSRByt6+XfwRGZ/YQK41PJkT4QkDGyAjBMoyPTIeuxHsaS+KcEh+N
	W38fW03RZYekYzr91FV+ij731p3UvYa6GivWCSva5rPcv0lOzaEd5uSrxZVSwxqC
	jglFjxBVreos5ZNDEjxaw==
X-ME-Sender: <xms:FcURaoY4ZijV5dq9QrP2T6pOJz0FPlTUTgsgpUDt4riwu5DU8wiFwJ8>
    <xme:FcURauNIZTXx-7VGddin_ElMnlXqMRZWbJf8Hb-z8n55JYF5yq7px3cJBXaXVnoNV
    9zPHoTT2I6iw3ish7OGAAbBQutU_8TTLqJ6MINft1Kok_pBOkbdyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheefgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegouf
    hushhpvggtthffohhmrghinhculdegledmnecujfgurhepofggfffhvfevkfgjfhfutgfg
    sehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkh
    hkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mheqnecuggftrfgrthhtvghrnhepjeeitdektdfguefgleeuleeftdefgeevheeugedvue
    ekgffhgeejhefffffggfehnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhdphihouhhr
    qdhorhhgrdgtohhmpdhhrggtkhgvrhdrnhgvthdpvgigrghmphhlvgdrtghomhdpghhith
    hhuhgsrdhiohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghh
    rhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhm
    rghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheptghhrh
    hishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FcURaggONCZVbHz5df-aCO5u4_2Bm56KWIdRkRtXU8rJQ-MAHqBL6g>
    <xmx:FcURajpZpWlxLhZNjbvJOPTJ1PjLquhIj8BGKalpcmK-G6QIDOzgDw>
    <xmx:FcURauHPqiicQFhaQ2wDYxXHZhgaOzatehvg-TI5BnhhY7amKGWMiQ>
    <xmx:FcURag6l8VFBJNOBQnGnc-iW9WS6bQ36AOJH9EC89_Rimywl6EisLg>
    <xmx:FsURavL61F1b91p1zUe7ocSG17h6psv7p2qd0_Oq7Mx3OdIAd5y-4-4S>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 762CE3020073; Sat, 23 May 2026 11:17:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A757hda0t03s
Date: Sat, 23 May 2026 17:17:20 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Christian Couder" <christian.couder@gmail.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Taylor Blau" <me@ttaylorr.com>, "Karthik Nayak" <karthik.188@gmail.com>,
 "Elijah Newren" <newren@gmail.com>, "Toon Claes" <toon@iotcl.com>,
 "Christian Couder" <chriscool@tuxfamily.org>
Message-Id: <97b9f2cd-7c82-4d4c-b574-31176074e566@app.fastmail.com>
In-Reply-To: <20260519153808.494105-7-christian.couder@gmail.com>
References: <20260427124108.3524129-1-christian.couder@gmail.com>
 <20260519153808.494105-1-christian.couder@gmail.com>
 <20260519153808.494105-7-christian.couder@gmail.com>
Subject: Re: [PATCH v3 6/8] promisor-remote: trust known remotes matching
 acceptFromServerUrl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026, at 17:38, Christian Couder wrote:
>[snip]
>
> Let's then use this helper in should_accept_remote() so that, a known
> remote whose URL matches the allowlist is accepted.

I don=E2=80=99t understand this comma break?

>
> To prepare for this new logic, let's also:
>
>[snip]
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

The rest of the commit message looks good to me.

> ---
>  Documentation/config/promisor.adoc    |  74 +++++++++++++++++++
>  Documentation/gitprotocol-v2.adoc     |   9 ++-
>  promisor-remote.c                     | 102 +++++++++++++++++++++++---
>  t/t5710-promisor-remote-capability.sh |  71 ++++++++++++++++++
>  4 files changed, 242 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/config/promisor.adoc
>[snip]
> ++
> +Be _VERY_ careful with these patterns: `*` matches any sequence of
> +characters within the 'host' and 'path' parts of a URL (but cannot
> +cross part boundaries). An overly broad pattern is a major security
> +risk, as a matching URL allows a server to update fields (such as
> +authentication tokens) on known remotes without further confirmation.
> +To minimize security risks, follow these guidelines:
> ++

So this introduces a list of precautions to take.

> +1. Start with a secure protocol scheme, like `https://` or `ssh://`.
> ++
> +2. Only allow domain names or paths where you control and trust _ALL_
> +   the content. Be especially careful with shared hosting platforms
> +   like `github.com` or `gitlab.com`. A broad pattern like
> +   `https://gitlab.com/*` is dangerous because it trusts every
> +   repository on the entire platform. Always restrict such patterns to
> +   your specific organization or namespace (e.g.,
> +   `https://gitlab.com/your-org/*`).
> ++
> +3. Never use globs at the end of domain names. For example,
> +   `https://cdn.your-org.com/*` might be safe, but
> +   `https://cdn.your-org.com*/*` is a major security risk because
> +   the latter matches `https://cdn.your-org.com.hacker.net/repo`.
> ++
> +4. Be careful using globs at the beginning of domain names. While the
> +   code ensures a `*` in the host cannot cross into the path, a
> +   pattern like `https://*.example.com/*` will still match any
> +   subdomain. This is extremely dangerous on shared hosting platforms
> +   (e.g., `https://*.github.io/*` trusts every user's site on the
> +   entire platform).

The list seems to end here, because...

> ++
> +Before matching, both the advertised URL and the pattern are
> +normalized: the scheme and host are lowercased, percent-encoded

This next paragraph seems to go back to describing how things work. But
this paragraph as well as all of the following ones belong to this list
item:

      4.   Be careful using globs [...]

           Before matching, [...]

           The glob pattern can [...]

           If a remote with the [...]

           For the security implications [...]

    promisor.checkFields
    [...]

I don=E2=80=99t know what the intent is. But using an open block will de=
limit
the ordered list.

    diff --git Documentation/config/promisor.adoc Documentation/config/p=
romisor.adoc
    index cc728bb0b5e..f07a2e883bd 100644
    --- Documentation/config/promisor.adoc
    +++ Documentation/config/promisor.adoc
    @@ -109,6 +109,7 @@ and to update fields (such as authentication tok=
ens) on known remotes
     without further confirmation. To minimize security risks, follow th=
ese
     guidelines:
     +
    +--
     1. Start with a secure protocol scheme, like `https://` or `ssh://`.
     +
     2. Only allow domain names or paths where you control and trust _AL=
L_
    @@ -130,6 +131,7 @@ guidelines:
        subdomain. This is extremely dangerous on shared hosting platfor=
ms
        (e.g., `https://*.github.io/*` trusts every user's site on the
        entire platform).
    +--
     +
     Before matching, both the advertised URL and the pattern are
     normalized: the scheme and host are lowercased, percent-encoded

>[snip]
