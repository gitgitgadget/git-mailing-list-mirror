Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4011F3DBD49
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775745774; cv=none; b=mun6ayTIJZS1TWOlZ1/FPfKRzRHG8EtFarsqMNLBsHqg4s+PumTSS+RtScmUKvIklE6q23IZqzFj4tNB3zvJgbHTZjAfiN1dIjCoMtOxe39p5SH02w8d5U+KJKrscGKW2RGEw8CYQZRWu3JZeEvmzyOpJtVIYLoksDFgWPR8nSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775745774; c=relaxed/simple;
	bh=7WkLkzhfAKByt0kap1fzJ1njWeYwas5scfG1y6Xg1nI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qx8D9v/34YYHBwlaxcxMQjRPQvu4cVgIWpmJMmdc7SXB6So3j/+TYyyOFCpkDo0D0Tdz3vuB0TKW8LZB9cCyqtOmAXE6aUg5OQSLOphS32pdqpWZ7DJVSpbFBnZaHREwm04nZ202dDjFzPfzpZvX639Xb7TsZbrOsVhnMx7DiqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DHUCDbck; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WxETCqB3; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DHUCDbck";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WxETCqB3"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 54B67EC0189;
	Thu,  9 Apr 2026 10:42:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 09 Apr 2026 10:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775745768; x=1775832168; bh=fWpKcMbqFj
	3kBu7P32wG/7aKJOh2kxSGVEf0al2HOrA=; b=DHUCDbcktw/t9fY0qu194KNShX
	iHgsCyzyCoA0j21u7K8d9UCvlNMBZU553flNS16aV9sgqMWAad9yKnuQv8XOrfFN
	0eBVk6RR8lOibwXQw3F9847Vt7peL8aG6pdWFfwK9RGCFj7NOsteiQvXnYQzAl87
	3J7lScPXt4wLYrLPomqVEfAZf5Tckw9hG3SReSDlUC8qZyXlWyVS0yJ6C5s4Fkfb
	bG5+jZK95mBZASs4H6EFAGC9gjCE6tUwcoBCeGQ+itaE3aaprVY+UrmwWxHaG6CE
	lE+Y7isq7fCZ+7XlhLZEGB9IQu3VkdIjO3EXC0A2RCJMpfJjJDfmdgjOdwJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775745768; x=1775832168; bh=fWpKcMbqFj3kBu7P32wG/7aKJOh2kxSGVEf
	0al2HOrA=; b=WxETCqB3JVUjoV1NmpFxXS349rauJXLZeXPJgWbSZFzWoOm/hup
	VWezk7nTFXiIlM3VR5ZBZjiFiC/a1DFcHYf44Hm1O765cTFSjoDuJlzqDBwqvrK7
	8JPdUa6ELOxuP2nDuOwwjsc9AhrzlFBnglb8jzTWn6TYvZCd3qD7WfYWJr1aY/PV
	JfhyTd1yweUE4cPmGAZ8kOJ0oO3AkHyTe0J08RWeFn7xxmESgox1ilbDtShQ9GGF
	e62g13fvVoGROmTU2OFcbB1ZXqq6UohxAsG+bh9WKxgCesVdNamvif/DloGJ7YK9
	mGn6euQpnT04FFWCYFayLNtnP+xcN06Zzmw==
X-ME-Sender: <xms:6LrXaaV-pnKnTI3hscriAbBn2fesd79YCXHSIzhUMgHe96UiW_B7YQ>
    <xme:6LrXadcQ9VdNYx3BC5uKMWyrBMsp5pnzr73mAMEsA8dvM407R2SkAnJsO0OFgg9k3
    0qjI3siM30QI0Y5eqzoTctNmSAT6ycWEogGc0Pp6vlapGWpI9-hAw>
X-ME-Received: <xmr:6LrXaWvovzsUECDGXgzgq74EhQ6FMu9JIRRMQzWwaGj-f0FNWXzAloljcReas7v265-q68I1Er7HXmcTC_TV7tiC9m2nmLEyIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvieejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrhigvshhhuggrghgrle
    elsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:6LrXac9By23qaSWTe3mDwM0eXTbVy0yuAfrkeQDij4int_1sNN-ZpA>
    <xmx:6LrXaR28lL4PKOGsqJvAkQjfmWnRCdkjSs3_5mwtpvIhRDc5_J9Sxw>
    <xmx:6LrXaRCADlsTJZ5ClGUFvv_b0wm1y4yYfe2xpMPL-Ia_pNo7nyPp5Q>
    <xmx:6LrXadcuNBFW4KKUqtUdBCJ4hdSfzKxNWWqH0zrB_Qv7Wb8tn-Sr1Q>
    <xmx:6LrXacNcsX1ZQvrs4JLrAFZBKUmoT3IjofY0hSa592qFeS94646vyoy3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 10:42:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Jayesh Daga
 <jayeshdaga99@gmail.com>
Subject: Re: [PATCH v3] repo: add paths.toplevel to repo info
In-Reply-To: <pull.2264.v3.git.git.1775714492944.gitgitgadget@gmail.com>
	(Jayesh Daga via GitGitGadget's message of "Thu, 09 Apr 2026 06:01:32
	+0000")
References: <pull.2264.v2.git.git.1775668134796.gitgitgadget@gmail.com>
	<pull.2264.v3.git.git.1775714492944.gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 07:42:46 -0700
Message-ID: <xmqq8qaww5y1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jayesh Daga <jayeshdaga99@gmail.com>
>
> repo info currently does not expose the repository's
> working tree root, even though this information is
> available via `repo_get_work_tree()` and
> `git rev-parse --show-toplevel`.
>
> Add a new field `paths.toplevel` to expose this value.
>
> While doing so, document the correspondence between
> `git rev-parse` options and `repo info` fields to make
> it easier to identify missing or future additions.
>
> For bare repositories, this value is empty, consistent
> with other non-applicable fields.
>
> Signed-off-by: Jayesh Daga jayeshdaga99@gmail.com
> ---

So "document the correspondence" added to the v2 iteration is still
up there.  I expect to see such a change in the patch body.

>     repo: add paths.toplevel to repo info
>     
>     repo info currently does not expose the repository's working tree root,
>     even though this information is available via repo_get_work_tree().
>     
>     This makes it harder for scripts to retrieve the repository root through
>     a structured interface, often requiring the use of git rev-parse
>     --show-toplevel.
>     
>     Add a new field paths.toplevel to git repo info that returns the working
>     tree root. For bare repositories, this value is empty, consistent with
>     other non-applicable fields.
>     
>     This provides a consistent and script-friendly way to query repository
>     paths without invoking additional commands.
>     
>     Signed-off-by: Jayesh Daga jayeshdaga99@gmail.com

This space below the three-dash is not where reiterate what you
already wrote in the commit log message.  Rather, this is a place to
give additional explanation that should not go in the commit log
message, like "the previous iteration botched X and Y which have
been corrected in this version", etc.

I see this mistake often in patches from GGG users---please double
check how to use that tool (I am not a GGG user, but I vaguely
recall that GGG duplicates what you wrote in the pull request
message after the three-dashes, so perhaps you are expected to
rewrite the pull request message every time to summarize the
differences since the last iteration before you submit a new
iteration, or something?).

> Range-diff vs v2:
>
>  1:  05e34bfe2c ! 1:  8a58b6ce03 repo: add paths.toplevel to repo info
>      @@ Commit message
>           For bare repositories, this value is empty, consistent
>           with other non-applicable fields.
>       
>      -    Signed-off-by: Jayesh Daga [jayeshdaga99@gmail.com](mailto:jayeshdaga99@gmail.com)
>      +    Signed-off-by: Jayesh Daga jayeshdaga99@gmail.com

OK.

>      -@@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
>      +@@ builtin/repo.c: static int get_references_format(struct repository *repo, struct strbuf *buf)
>      + 	return 0;
>      + }
>      + 
>      ++/*
>      ++ * rev-parse --<opt>        repo info <field>
>      ++ *
>      ++ * is-bare-repository      layout.bare
>      ++ * is-shallow-repository   layout.shallow
>      ++ * show-object-format      object.format
>      ++ * show-ref-format         references.format
>      ++ * show-toplevel           paths.toplevel
>      ++ *
>      ++ * show-cdup               <missing>
>      ++ * show-prefix             <missing>
>      ++ *
>      ++ * Some <missing> entries may be candidates for future
>      ++ * implementation, while others may not be needed.

It is a surprisingly small set.  Did you do your own research, or
did you only copied what I gave as examples?

> +static int get_paths_toplevel(struct repository *repo, struct strbuf *buf)
> +{
> +	const char *wt = repo_get_work_tree(repo);
> +
> +	if (!wt)
> +		return -1; /* match existing error style */

That is not a very helpful comment.  It sounds more like "I do not
understand why I am supposed to return -1 here upon error, but I am
just blindly following what everybody else does" excuse, than "I
return -1 upon an error because the caller is prepared to act on it
and do X, which is what we want to see when repo_get_work_tree(repo)
returns NULL, which signals condition Y that should be reported as
such" explanation.  If the reason why returning -1 is so obvious
that we do not even have to say it (which I suspect is the case),
then future readers would appreciate if you didn't add such a
comment.  If the reason why this needs to return -1 (and not -2 or
-999 or whatever) is so subtle and needs to be explained, then the
comment does not give even a single bit of information to help them
understand why.

> +	strbuf_addstr(buf, wt);
> +	return 0;
> +}

> diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
> index 39bb77dda0..470e06e8c2 100755
> --- a/t/t1900-repo-info.sh
> +++ b/t/t1900-repo-info.sh
> @@ -155,4 +155,20 @@ test_expect_success 'git repo info -h shows only repo info usage' '
>  	test_grep ! "git repo structure" actual
>  '
>  
> +test_expect_success 'repo info paths.toplevel' '
> +    git repo info paths.toplevel >actual &&
> +    echo "paths.toplevel=$(git rev-parse --show-toplevel)" >expected &&

These seem to be SP*4 indented; one level of indent is supposed to
be a single tab, not 4-column.

You may have copied it from other tests, but the above is
done in an unusual order and I found it harder to read.

We prepare an expected output in a file called "expect" first, and
then store the output of the command we are testing in a file called
"actual", and then compare "test_cmp expect actual", in this order.

If you deliberately misspell the command to pass "--shaw-toplabel",
does it break this "echo" invocation, or will we only notice the
breakage/mistake when we check the output in the "expect" file
against 

> +    test_cmp expected actual
> +'
> +
> +test_expect_success 'repo info paths.toplevel (bare repo)' '
> +    git init --bare bare.git &&
> +    (
> +	cd bare.git &&
> +	git repo info paths.toplevel >actual &&
> +	echo "paths.toplevel=" >expected &&
> +	test_cmp expected actual
> +    )
> +'
> +
>  test_done
>
> base-commit: 256554692df0685b45e60778b08802b720880c50
