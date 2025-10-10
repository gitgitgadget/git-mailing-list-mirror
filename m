Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B43A3594A
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120388; cv=none; b=sX9Q355NqtDDTB5C/lwfypUj3rWOm/SapAGq0SN5JMdHis2QYUGIqadcLWvI2vbSYFZK5x4kZqjUk19eVy1WKKd6pyAgJjG0bAJ2GCRvfbaMeuQngsdlHAUayJGznl8f9cAWfAXB5/3RqddkKecnJ6By+g1LSvF9XmVMOKtJE18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120388; c=relaxed/simple;
	bh=PxFyFZAEp/xC0LgPGTk/f/XXJx+78ahZomyfHsmsxW0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gD9GA1OFrBZDiD5E8qSV5+/EMom7YIkgPkwUR795eBH0ZE7uErJNgle4+PqWjGMxtQk2QZRfUUZ4oLMCA5Z2ylJE0rPmg/xw1J73R04ZZ7MR/1kjQsqjWfo72DIT23a3vrrinSS5wXUy3Jizg1KeAdMwmyb+dcXiF4nUflo9Kv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NNuhgHeI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tr99W629; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NNuhgHeI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tr99W629"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1AB951D00118;
	Fri, 10 Oct 2025 14:19:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 10 Oct 2025 14:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760120384; x=1760206784; bh=vsXmhIK/IQ
	JGR8Nz358J1TAxG00XTLBCJSHOj+Fda9Y=; b=NNuhgHeIOve18o9TlgfGOjwrGb
	xdP3jlqOn/olaSU/VybdD2mqqMi3duDyUHyxzOdsp7rvU2S3LD1XRT61Wm5uU6+A
	1jd6vDEVKIl84bKqhxEnscCL5ZDuinA5PTPcSyxgzEsBoxhi8v5qZTNU2g0WOMFm
	vefIXLZSstBIXIS/yaqSTPRgSPuaJLVog6QuXkatgkFdV8bZgp6GikUengnBzcQB
	AN/mPtEZMgEiGHTvrz/ySTGfeTUHL5XlDRCZibWVNsEEsmjGzSDjMXKd0yF3DUVp
	O6MYtC3xVkBg12WL5onP4bxNSFcps+MgHKL/nrr1Z/WHCc7+Vltm19F13OxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760120384; x=1760206784; bh=vsXmhIK/IQJGR8Nz358J1TAxG00XTLBCJSH
	Oj+Fda9Y=; b=Tr99W6291EQo11xkFv+NQAygVimY2QGXjsaq3tWdOeIZlyC6fM0
	WqqoX2l2xB6CYfyefalPTGahqy+0g4SZQJYyNETHx3Uadvu6VWGdZCFS89Oqakfs
	9+NsYIwV77g1+p77gP2lG3/W1TqiX/g10f/09UMOvPyVVvhXgIClfVhte4T+/Ycy
	kllm6w+FAe0teT5Gl90LU5bMq39YCsXcYSLORyN3DQNKoDSVE6pv9VzymGXdJNMf
	t9wPg5a3M76rwtYX9PItC9Fw3j3df1flCwi/8D7jwZ9jmEbQQiCgahkZ3vdKEXVk
	C1DrsnyCFAAX152PAXLQyvfRHh208rO+8Sw==
X-ME-Sender: <xms:QE7paJppfFZMEywFaFg-cgYfvXWjQKZSTjLeLmDZbHvc6Yd0eS1GZQ>
    <xme:QE7paCoTAOMQCxEJ7vd_vLz5-ryYyz_u7Wokhy2QvXRPbuZ0wNa6Q_m4MxdHu5rTn
    G028x5UPzrsuQn9A9oIRkaJNt4mf9k1uUBRXY7ipd0J9MrPv65L>
X-ME-Received: <xmr:QE7paLPy4Tz_TWKYGnRjtpXFVpd2sPheTx_FNmexwD66Fa02WQVBtMRaLsFU9vhx9zhoXM8esyto4Co1qBsEzFGmXEzPz5ieRjrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeljeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhlihhpseguvggtvghnthhsohhfthifrgdrrh
    gvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:QE7paDw2ZbxYE36R6bzhQMUR9ZQj_yjB1QzlxwDm45wgljDWlZMHpA>
    <xmx:QE7paEs1Y9rm3HEr5PNvql9ksZNDH85fnWDiiP2u1eJqRg0gJGpTow>
    <xmx:QE7paM5g2Zf__TiXqT2T2sERTYTs2IVOJrfc-iXUNZ-hPPuttjgRCw>
    <xmx:QE7paDRfWl72Wb_4qzKojFEvjguip7PKiE9VTcf9nEi3e5Na1kElzw>
    <xmx:QE7paPbTQRrxrojUt_0W1NcJdOwa36I8uye9Y1iZBHmHDseaEVQn2Nxd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 14:19:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Philip Patsch <philip@decentsoftwa.re>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 1/1] docs/git-blame: describe sourceline and resultline
In-Reply-To: <20251010152204.815520-2-philip@decentsoftwa.re> (Philip Patsch's
	message of "Fri, 10 Oct 2025 17:21:59 +0200")
References: <20251010152204.815520-1-philip@decentsoftwa.re>
	<20251010152204.815520-2-philip@decentsoftwa.re>
Date: Fri, 10 Oct 2025 11:19:42 -0700
Message-ID: <xmqqldli8vr5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Philip Patsch <philip@decentsoftwa.re> writes:

>  - 40-byte SHA-1 of the commit the line is attributed to;
> +- the line number of the line in the original file,
> +  from when the commit was made;

Sorry, but "from when the commit was made" does not really add
anything meaningful at least to me.  Which commit does "the commit"
refer to in this sentence in the first place?

> +- the line number of the line in the final file,
> +  from the current state of the file;

We avoided to say "current" here because the state you are trying to
explain (i.e., the commit that has a file each of whose lines you
are trying to find the origin of) may not be current at all (e.g.,
"In the code that was current five years ago, we had this helper
function.  Where did it come from?").  "git blame --help" says
"start annotating from the given revision" in its very early part of
the doucumentation, so it might make it easier to understand if this
"final state" were referred to as the "annotated state"?

Perhaps this is easier to understand?

 - 40-byte SHA-1 of the commit the line is attributed to;

 - the line number in the file in the above blamed commit, where the
   line came from;

 - the line number in the file, where the line is found in the
   stating <rev>;

I dunno.

Regardless, the first one that is SHA-1 centric should probably be
updated in this age where SHA-256 repositories are reality.  Perhaps
replace the "40-byte" thing with something like

 - the hex object name of the commit the line is attributed to

but that would be a separate topic.

The same comment wrt "current" and "original" applies to the other
hunk.

Thanks.


> @@ -214,6 +216,9 @@ annotated.
>  	<40-byte-hex-sha1> <sourceline> <resultline> <num-lines>
>  +
>  Line numbers count from 1.
> ++
> +<sourceline> is where this line shows up in the original source commit.
> +<resultline> is where this line shows up in the current state of the file.
>  
>  . The first time that a commit shows up in the stream, it has various
>    other information about it printed out with a one-word tag at the

