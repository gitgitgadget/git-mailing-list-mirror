Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5B131B810
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939367; cv=none; b=Fa1u19Wo8NDSN1yQgSH31DZRCokiUIDP9T8xsvJ0+opVa730AmnD+wU9eU137euMMWOVetZcSEo/GHLRK2vD3l6Txa/rSGd3vwbxW/jY9XUGDADkj0XwqGvIX0ODkWWUIR4kDlg7MXpx7+iwR1YqqEpwOz3p1Yq8C8eeCPi/mZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939367; c=relaxed/simple;
	bh=u6aOpIrf9heI1FKYkxiQHQ/5kNBUEKEhphpLQMh3YbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mCZwQzzFQ8feuyXJyqnOlDFxm+ZwewU+VCR2kCW/87Zmb/Gypsp9NsZiUCpwoJARcKEHGjd5gzFpjYyBSZMV6PqdqusqNl9+L73kKme6RA0yfREvT4oIO3NSt8/54lpEveUC2Cde0XFPqPlNULFb12TOiQHuqNMQrQkcxW+bg9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sOuUY85l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PaBdRAlk; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sOuUY85l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PaBdRAlk"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E2F617A009C;
	Tue, 20 Jan 2026 15:02:43 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 20 Jan 2026 15:02:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768939360; x=1769025760; bh=t0kucYpJBL
	+ZKoUQHc6+q1g1gwV9zgR4wdybqWcHPYQ=; b=sOuUY85l3+LuDz3rm2NnCdq0mL
	8Dul0b3N+bSSsFbRZgNkR3O7lXZLfkEhpu9zZKzAj4BQ1CGmhtuyOhIiY+40Guyb
	VDncJulbNAzXbTsL4wjsT1Pl3jRwJg1OjAkeP9nJ4qUpdmFanD9gZHfUaqD+7K0l
	XQkcZEsrEKUSmcLYRjuX5S7Lt85u+qEZBdysraQBzLdWSo0c0EijJs0o5eNJE+XY
	vTpD9U9yGf2tIbOxEsdDOX1M3i3//NKuO3t2T8OfEe85RAZd1JNGZmw9KnOnbq+q
	Kt6Pn7aXePO2zD0SDPD7HzE7gasVn7hyyTO0WB06MU4kXngChhnLv8j3w+wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768939360; x=1769025760; bh=t0kucYpJBL+ZKoUQHc6+q1g1gwV9zgR4wdy
	bqWcHPYQ=; b=PaBdRAlkYiQ9LWu4IN5f17Cn83rix/Vc3cTaCEgWB1B89shWVST
	9AaKj8l4qReWNbuxgz0RAm9zO/Hlx7wzgDL/Z5Snr1oQGO234VNIiyqREPWWfZYH
	H//nA1+2Y3YF1L3zb6Qnf9xFQPpYy1ZYxujJ1ivuT0zGsyZf1OCUK/gg6YJLCInU
	8czV3uKbjPg5i71uhgwJl4/mN7MsY6hDWV15SVbO52G6E9mL0n68NvRKiIVV00ah
	+2K7nQ6WulwztvpsLM2S1taq4JzynJiRYmR1kwvLHZ02xtvLdhaK6eL/gQTAKsJt
	K7mMfMeYP0mSMPEEV57tdBR5FE1fESiFYHQ==
X-ME-Sender: <xms:YN9vab6nTHat4Wkf0CVp1FyiA2nUmz9xMYiQk2LApJdxaTbeDFQhqQ>
    <xme:YN9vadcGTByziMx_Dlr0MSCVjf6xazH6C7leiaJQk0GYOvC5AA89G4UASD9w2I91o
    sozeukhJpJMnXAKxRrRl-tG57tHBVeQAom_O755OtVVxvb1pmOf8w>
X-ME-Received: <xmr:YN9vaW5MXo4KIQdEGqRwscOrqtC9D96VaVmxHWX6orXaIfqLiQmI0MckgDhXvVlgUhnxRFXRd1LZhiMKZFmL2MOYGjT-tXD1qdHOUQE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedufedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehtsghovghgihesfigvsgdruggvpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehprghulhhordgtrghsrg
    hrvghtthhosehshhhophhifhihrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehptggrshgrrhgvthhtohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:YN9vaS9grmDl-GchE0p5A_jO3HeJHZIiQXdsKoaabcEKAOW91HxCCQ>
    <xmx:YN9vaQEGG56aezfclpw18XlN9j-wD0B18RUj8BNUJ1lCJL87q4Mz6A>
    <xmx:YN9vafXr1NiaWCHZa4T6Qq14DpKcSeOfLVIOouIvNIp9beAgQuT7-Q>
    <xmx:YN9vaU_-Qi5_2xcPIjbybR36TifKLWzGoUEupaeHtg4cn0OKr4TDMA>
    <xmx:YN9vaWX9Q5KGPMYziD_svnVWX95JyBAg12Zd6WvL6oDiZ6s8XtUVDyU2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 15:02:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  Jeff King
 <peff@peff.net>,  "Paulo Casaretto (Shopify)"
 <paulo.casaretto@shopify.com>,  Patrick Steinhardt <ps@pks.im>,  Paulo
 Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH v5] lockfile: add PID file for debugging stale locks
In-Reply-To: <pull.2011.v5.git.1768933954845.gitgitgadget@gmail.com> (Paulo
	Casaretto via GitGitGadget's message of "Tue, 20 Jan 2026 18:32:34
	+0000")
References: <pull.2011.v4.git.1767804355831.gitgitgadget@gmail.com>
	<pull.2011.v5.git.1768933954845.gitgitgadget@gmail.com>
Date: Tue, 20 Jan 2026 12:02:37 -0800
Message-ID: <xmqqjyxcyrvm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Existing PID files are always read when displaying lock errors,
> regardless of the core.lockfilePid setting. This ensures helpful
> diagnostics even when the feature was previously enabled and later
> disabled.

> +core.lockfilePid::
> +	If true, Git will create a PID file alongside lock files. When a

Hmph, are there cases where a single process grab two more more lock
files and a single PID file helps identify who holds these multiple
lock files?  I somehow had an impression that with the configuration
on, we create an extra PID file for each lock file we create.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 0243f17d53..4378256fa5 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -539,8 +539,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
>  
>  	path = repo_git_path(the_repository, "next-index-%"PRIuMAX,
>  			     (uintmax_t) getpid());
> -	hold_lock_file_for_update(&false_lock, path,
> -				  LOCK_DIE_ON_ERROR);
> +	hold_lock_file_for_update(&false_lock, path, LOCK_DIE_ON_ERROR);

A change that is not necessary/essential for the purpose of the
topic?

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 92c6e7b954..1dcc8dd550 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -748,8 +748,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>  		xsnprintf(my_host, sizeof(my_host), "unknown");
>  
>  	pidfile_path = repo_git_path(the_repository, "gc.pid");
> -	fd = hold_lock_file_for_update(&lock, pidfile_path,
> -				       LOCK_DIE_ON_ERROR);
> +	fd = hold_lock_file_for_update(&lock, pidfile_path, LOCK_DIE_ON_ERROR);

Likewise?

> @@ -1016,8 +1015,7 @@ int cmd_gc(int argc,
>  
>  	if (daemonized) {
>  		char *path = repo_git_path(the_repository, "gc.log");
> -		hold_lock_file_for_update(&log_lock, path,
> -					  LOCK_DIE_ON_ERROR);
> +		hold_lock_file_for_update(&log_lock, path, LOCK_DIE_ON_ERROR);

Likewise?

> +static void get_pid_path(struct strbuf *out, const char *path)
> +{
> +	strbuf_addstr(out, path);
> +	strbuf_addstr(out, LOCK_PID_INFIX);
> +	strbuf_addstr(out, LOCK_SUFFIX);
> +}

If we get rid of LOCK_PID_INFIX, and instead did

    #define PID_LOCK_SUFFIX "~pid.lock"

wouldn't it make the overall patch simpler?  I do not see any code
that uses LOCK_PID_INFIX independently (other than the above code,
obviously).  Then get_pid_path() would become

        static void get_pid_path(struct strbuf *out, const char *path)
        {
                strbuf_addstr(out, path);
                strbuf_addstr(out, PID_LOCK_SUFFIX);
        }

While at it, we can also lose LOCK_PID_INFIX_LEN that nobody uses ...

> @@ -127,6 +128,22 @@ struct lock_file {
>  #define LOCK_SUFFIX ".lock"
>  #define LOCK_SUFFIX_LEN 5
>  
> +/*
> + * PID file naming: for a lock file "foo.lock", the PID file is "foo~pid.lock".
> + * The tilde is forbidden in refnames and allowed in Windows filenames, avoiding
> + * namespace collisions (e.g., refs "foo" and "foo~pid" cannot both exist).
> + */
> +#define LOCK_PID_INFIX "~pid"
> +#define LOCK_PID_INFIX_LEN 4

... from here.

> +
> +/* Maximum length for PID file content */
> +#define LOCK_PID_MAXLEN 32

This is used as the last parameter to strbuf_read_file(), which does
not mean we stop reading after reaching this length at all, so the
name of this constant is very misleading.  We only read the file in
the error code path so there isn't much point in trying to optimize
reading from these files too heavily.  I'd suggest getting rid of
this constant, and passing 0 to the function instead to signal "we
are willing to take the default given by the strbuf subsystem".

