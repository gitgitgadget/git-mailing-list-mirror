Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B788E24A044
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 07:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772953583; cv=none; b=V98svcPQjFh2ZJ3sjD1QREPYKZ65xYKyxinMxMGMIqxLo4KSW9CNCzlKmrAsF/3BxaTpoVdBK1WsPDLPCMVBFz1eqUmGrBkzI2hYHmqv3YQXX1/NVPdm8eEJ6S+Y8lCrNkvBeeiX0JsHQLnKox6PZt2fiQZQZBd+KjrXUNIcslg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772953583; c=relaxed/simple;
	bh=eNzXeaoGB8Fd1aG7WWjV+ER0j+WdZP2DzJivvef4wkc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IF2ob6kZgtPLIrXWt+mjIZXzT9nei4+2FvvgqBrAOUc+UQsIx1pX8KM37tVSMZpnJjmk2lCaKxdbW3uF/c5c9FJVd9dg5mEzq4PkXeFupHONafWNkupRKjfETiBv/LSk6R52hb1cd91X/9ok6eD4xKAKlcyYxEYTrEIEGaHnBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QrQCW1GV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sltz3LHY; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QrQCW1GV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sltz3LHY"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8BEC0EC0554;
	Sun,  8 Mar 2026 03:06:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 08 Mar 2026 03:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772953580; x=1773039980; bh=rEcoA7R9qP
	cfSnsiWP08LGp3IE29HYh+WzhFIVMjylc=; b=QrQCW1GVIdo1YcxyJK4brfiXW2
	nezn3TZsK+Na75r2/repRlX0QALYOF9pVfjxf4Sy4YYm+2cvdOfHVFJMrvxm74bW
	PMfxvC7FpqH8wWQnQSghL3MJqp71RxCVd+d6Jd8ca06RKiVqYng1N2mm4/Z5gAZZ
	2arcDTH6l6s6zBUSmZe71wQ8sMHiPJxmDUMznflcFo7+JD/FjjJ1rYgdv892Rq16
	6bdeZQToqYwhhHqDiJZCnz0N9KnGXN1IYKv3SuEufUCXuR+xfjmuuY8R1ZrVWCNU
	lNaqKTzFroXjrldHizpQPJBIx/3NRHJtQuHWMQgcvNUg0MExTXMGGhOYN8og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772953580; x=1773039980; bh=rEcoA7R9qPcfSnsiWP08LGp3IE29HYh+Wzh
	FIVMjylc=; b=sltz3LHYMZ79vkytjTnYeFVOQg2q9dUZmkWq/YRVSy6YXcXdttE
	Jh5OU24sJOiKeXORCYUeYNDUCpozvlK3rL6p6s8LdArb5EUVrDzJn/PiCUKMGzYr
	nG9y4o8wNaSQFUCvhD4SJYPivrPWZUWFmZ9gEHe7B0aSd03Rs+9rYYka6ILtOUvz
	IHadtQD9gMDqSx+T75k9DU9PR31HoTZeZMafz4q6xCllkqKmV2HRf25KMqSUbshO
	L66HfL7OrOzsxmDYleR85ctL+jIfs86kZhCJHCjHR79RLJLz9iSxyZA4QYtWIFzs
	0KY+TVTFWNvb3PkiYeKQXFM1CNJILGz86qA==
X-ME-Sender: <xms:7B-taTb-OP_GTm4LcULx8VrAr06PzpuF4ZO-jmWLeNOwbv2NZH6d4Q>
    <xme:7B-tad5Tg7DVfWjRBZa6iIpeLjfCrcYf9vFIcsvpzOyWlr9FWY_Krhjx61-WIcOzi
    qaUxIfW3MVI9FmxMtpsR1fhvBiqe0tRKXsVNWm0F8KO__vnoADcdw>
X-ME-Received: <xmr:7B-tacZTjX8y5f5BGX513ywv2ZWtT-xCAvYqDzZc-x303LDh1zL4hpOptQgZVtcx3N5EKbe5b9Cp6ykJ2On0cuLN11G8jDo3yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeeghedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohephihorghnnhdrvhgrlhgvrhhisegtvggrrd
    hfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7B-taUhMDmxBAljbZxUBGSfwXOQipOrMBh5OlHb0nWZOTEsDZlIgRQ>
    <xmx:7B-taV-E-6D7LOW5_P1HIqTQZcXzWYPlLN6XA51CeW17zqE--Hn3vw>
    <xmx:7B-taXr-0UO9LN4O8G-0RjI3EyI-dKvdA1Wb3cm87hlMz68D7XqraA>
    <xmx:7B-taVU39OZljQfN4SXL2EwYIed2amukT6ywDkL83plwOltw-SxXyg>
    <xmx:7B-taXHJakGeEt7_6b5OIPq0p4dpeRYMkNjE026u3A45TMAVMEydbSEq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Mar 2026 03:06:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "VALERI Yoann via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Yoann Valeri
 <yoann.valeri@cea.fr>
Subject: Re: [PATCH v3 1/3] branch: add '--name-prefix' option
In-Reply-To: <6cbb950d8bc3b647d7fff72a72f938ee369b552c.1772802872.git.gitgitgadget@gmail.com>
	(VALERI Yoann via GitGitGadget's message of "Fri, 06 Mar 2026 13:14:30
	+0000")
References: <pull.2202.v2.git.git.1772207333.gitgitgadget@gmail.com>
	<pull.2202.v3.git.git.1772802872.gitgitgadget@gmail.com>
	<6cbb950d8bc3b647d7fff72a72f938ee369b552c.1772802872.git.gitgitgadget@gmail.com>
Date: Sat, 07 Mar 2026 23:06:18 -0800
Message-ID: <xmqq4imqls0l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"VALERI Yoann via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
> index c0afddc424..00967fa758 100644
> --- a/Documentation/git-branch.adoc
> +++ b/Documentation/git-branch.adoc
> @@ -17,7 +17,8 @@ git branch [--color[=<when>] | --no-color] [--show-current]
>  	   [(-r|--remotes) | (-a|--all)]
>  	   [--list] [<pattern>...]
>  git branch [--track[=(direct|inherit)] | --no-track] [-f]
> -	   [--recurse-submodules] <branch-name> [<start-point>]
> +	   [--recurse-submodules] [--name-prefix=<token>]
> +           <branch-name> [<start-point>]

The indentation of the last line seems a bit off; the previous line
uses leading HT both in the original and in the updated version, but
the last line uses SP indent.

> @@ -64,6 +65,10 @@ Note that this will create the new branch, but it will not switch the
>  working tree to it; use `git switch <new-branch>` to switch to the
>  new branch.
>  
> +With a `--name-prefix` option, you can add a prefix to the branch to create.
> +This can either a simple name, or a token. Currently, only '@{current}' is
> +managed as token, and will use the current branch name as prefix.

"can either" -> "can either be".
"managed" -> "supported".

> @@ -319,6 +324,10 @@ superproject's "origin/main", but tracks the submodule's "origin/main".
>  	and the object it points at.  _<format>_ is the same as
>  	that of linkgit:git-for-each-ref[1].
>  
> +`--name-prefix <token>`::
> +	A string that will be used as prefix to the name of the new branch to
> +        create. Can be '@{current}' to use the current branch's name.
> +
>  _<branch-name>_::
>  	The name of the branch to create or delete.
>  	The new branch name must pass all checks defined by
> diff --git a/branch.c b/branch.c
> index 243db7d0fc..c24d7ce823 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -365,6 +365,23 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
>  	return 0;
>  }
>  
> +void add_branch_prefix(const char *name_prefix,
> +					   const char *current_branch, struct strbuf *buf)

Overly deep indentation here.  Our tab-width is always 8, and you
would align the first "const char" on these two lines.

> +{
> +	int value = 0;

Unused variable?

> +	if (!name_prefix)
> +		return;
> +
> +	if (name_prefix[0] != '@') {
> +		strbuf_addstr(buf, name_prefix);
> +		return;
> +	}
> +
> +	if (strcmp(name_prefix, "@{current}") == 0)
> +		strbuf_addstr(buf, current_branch);
> +}

What happens when we need to support more than the @{current}?  Will
this function grow more parameters and the callers need to prepare
more parameters, even if only one of them may be picked by this
function?  That does not smell like a sound way to make things
maintainable.

> diff --git a/builtin/branch.c b/builtin/branch.c
> index c577b5d20f..58631913c7 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> ...
> +		add_branch_prefix(name_prefix, start_name, &new_branch_name);


Here, `start_name` is passed as `current_branch` to `add_branch_prefix`.
However, `start_name` is the `<start-point>` (e.g., another branch,
a tag, or a commit). If the user runs:

    $ git branch --name-prefix=@{current} new-branch other-branch

the prefix will be `other-branch` instead of the *current* branch
name as advertised in the documentation.  It _may_ be how the
feature was intended to work, but then the name "current" and the
way the documentation describes the token are both misleading.

> +			create_branch(the_repository, new_branch_name.buf, start_name,
> +						  force, 0, reflog, quiet, track, 0);

Overly deep indentation.
