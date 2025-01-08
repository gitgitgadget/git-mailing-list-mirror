Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788B119E992
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736349456; cv=none; b=RKiYr7VVrANhAyZ9FP5SZHbAbnPzIJmHTyJiqeG+nGaJeCUoIz4B/lteza2Drt0JxX2ap4jWbclTK40TyiQtR0WwnYKzzZhUVufnuKCNVQCG1LUBrcjVrN0qbzF2BBcDr0L0W+tc0SFNbiq5EA1iIJGXtCouHakkOKfpL7pMCRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736349456; c=relaxed/simple;
	bh=K/RdlXwsKE0oX+iUEcro0kehv8bHbMLN4DiZyegP0wU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RfED/yX/40q+lx7Z1YJNh4bTYj3GjCNFgO4PnoscdyJuAbQ2B29Obq8x3LBolOB6fYQA6sJfOF78lpEPUOJK0A5IDtn/q0QQ1TK6M+C/fc186c18PfgEHrTBO0d3+Zv67vJVRxsvodZ48NL4IrAts8p6ywlTTu/C6CGG3ShVk+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xA/vSpXy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qWtrNBCY; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xA/vSpXy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qWtrNBCY"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 86BE11140183;
	Wed,  8 Jan 2025 10:17:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 08 Jan 2025 10:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736349452; x=1736435852; bh=3fv8dVl7kn
	DbFykdrCyxqBkPL4GX411cJOgr/fGDfuY=; b=xA/vSpXyXAhbVf6tSepgEno8V4
	FFcPB7y3tMP8B7BBTPyO1E70wYosRqUO2jMJ8/TNiyvfptEJzJegxtCt80jItCEN
	XSea3TRzTVVuz2bCDts1HX8q184T83hIleRoPQCZSTMqvGXitJdGaDfT4fAZFxib
	7AT3fmPL8Z15EH2rL9e10VAncDXMFBd4O1TgHfq8lM/tBAlugWaV2C1cC/pbt3oq
	sTcW1dp9XJoerSpb8ikscgx9/F6i/ne6yfFz1DveNQ36fUBF0B6XtD2B4L8ftAK8
	TJahHrLoPZh3G5kZ/RKvuDO+/SukXjBZm1SCEvYnh3zrE2hcFIUyKEi7KH9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736349452; x=1736435852; bh=3fv8dVl7knDbFykdrCyxqBkPL4GX411cJOg
	r/fGDfuY=; b=qWtrNBCY2N18JFDIC1d9R2IF/Esv3ToAasr4Z4UM40VT9hx7hwZ
	cQicGwaJR8WpEvWFlzFKf2fGTAb0zohtuBBE1LcZNovZ9/hgcYculL/dct5wKUS/
	NemO0Xawfg4bXBmwBGdcbyvkI3Q6ZAJt8kwoBIKuKaWxMeixQ+p5J+2FEv8YZqe3
	ewDYxWbNzAVwy5cixNsp/w+Ny9HFgzPVK6f7s9Rw/3F1fc1M8XcXw9CVv16nZUtK
	nsdjRRgHhtzfI+cmZibo1JXSSnUD7BVsnGNuZ/V7KghK/c2arv430/ibFClECGmM
	6DztrqB5Q8iZhBt+b3gLSn2w9tdyLoEIO7w==
X-ME-Sender: <xms:DJd-Z_u-b3KqVBTB2SusOPfbMJGl8KmQKrdSn9HKQd9G-IMo7VH74Q>
    <xme:DJd-ZwfvgyCjp0we3uIKcbhYuYlEuW_L92cWPO2huLjReqmYtwUXc4xYslxVIrTLX
    LdL635562bm0h9Bfg>
X-ME-Received: <xmr:DJd-ZyxowcSImaUAyigqxbRs70FUvQ0Kj61h7OU3-3jAXeJwD1Lvtmswi0p71FhtewbwfCWcSnXruuspL6MBf-tED9o-pX5msYE9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DJd-Z-NOZP89Zy660CZLUdS_orHfE8SUMc9u5BZ6hYE6QVY4Lgclew>
    <xmx:DJd-Z_9MHayLeeV1w4HtwI67LsKrcykgvRvTIbhJqhvf5w0dRJ4iYA>
    <xmx:DJd-Z-V-oTnbhutd5zJJWV6KS_ix4KrjMJL5hwQ6_uBRPaKmei26Jw>
    <xmx:DJd-ZwdXfqXCIGOgnlw49t0G_OJXk4TOgTy0sS-A-VUA3blN78B0Ig>
    <xmx:DJd-Z7YfSw-wk-Q6fyeqo4u7raZgDRDzlu4cXSbI0Y2nhJ2ry_LsN_ZT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 10:17:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com
Subject: Re: [PATCH] rev-list: print missing object type with
 --missing=print-type
In-Reply-To: <20250108034012.211043-1-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 7 Jan 2025 21:40:12 -0600")
References: <20250108034012.211043-1-jltobler@gmail.com>
Date: Wed, 08 Jan 2025 07:17:30 -0800
Message-ID: <xmqqjzb5pc6t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Handling of missing objects encounted by git-rev-list(1) can be
> configured with the `--missing=<action>` option and specifying the
> desired action. Of the available missing actions, none provide a way to
> print additional information about the missing object such as its type.
>
> Add a new missing action called `print-type`. Similar to `print`, this
> action prints a list of missing objects but also includes the object
> type if available in the form: `?<oid> [type]`.

This part needs to explain where the type information comes from and
what its significance is (see below for more details).

> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 459e5a02f5..277a0b645e 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -1024,6 +1024,9 @@ Unexpected missing objects will raise an error.
>  The form '--missing=print' is like 'allow-any', but will also print a
>  list of the missing objects.  Object IDs are prefixed with a ``?'' character.
>  +
> +The form '--missing=print-type' is like 'print', but will also print the
> +missing object type information if available in the form `?<oid> [type]`.
> ++

The users need to be told what this "type" information really means,
as its meaning is quite different from what "git cat-file -t <oid>"
would give them.  We do not have the object, so we are not learning
its type from the object itself.  How much trust should the users
put in this information, for example?

That comes back to the "where does it come from" that the future
readers of "git log" and reviewers need to be told by the proposed
log message.  Knowing the internals, I know you'd be getting it from
the "containing" objects, e.g., an object name that was found on the
"parent" object header field of another commit, which is _expected_
to be a commit, or an object name that was found in a tree entry
whose mode bits were 100644, which is _expected_ to be a blob, etc.

There are other places that you _could_ glean information about
(possibly missing) objects.  An object that is found during
"rev-list --objects" traversal (which is the topic of this patch
after all) but turned out to be missing may not just have an
expected type (because it was found in a tree object that we
successfully read) but also the full path to the object in the
top-level tree, for example.

In modern Git, there are even more places that you may be able to
use, like commit-graph that not just hints the object itself is a
commit, but what its parents are and when the commit was created.

Note that I am not suggesting to implement more code to learn "type"
information from more places than the current patch is doing.  At
least not in this iteration of the patch.  What I am getting at is
that it would help us to avoid unnecessarily limiting ourselves by
stressing on "type" too much if we at least imagine what the
possible sources of these extra pieces of information are and what
they could provide.

As I suspect that we would want to leave the door open for us to
extend this later, I would perhaps suggest an output format format
like:

    ?<object name> [<token>=<value>]...

where <token> tells what kind of extra information it is.  I expect
that the initial implementation only knows about "type" as the
<token>.  For future extensibility, we only need to say that under
the syntax:

 (1) How multiple attributes are shown?
 (2) How would a <value> with SP or LF in it is represented?

My suggestion is to have multiple <token>=<value> on the same line,
with a SP in between, and problematic bytes in <value> are quoted,
using cquote(). i.e. a <token>=<value> whose <value> part does not
begin with a double-quote ends at the first SP after it, otherwise
<value> is taken as a C-quoted string inside a pair of double-quote.

If you are adventurous, I would not mind seeing "path" implemented
as another token, since that would be fairly easily obtainable, but
it does not have to be in the initial attempt.

Thanks.
