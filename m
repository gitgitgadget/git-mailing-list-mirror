Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0F03B19DB
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783665668; cv=none; b=V3pXOu+otScN6FOyoKspYRh6YPG5IIte4XFLbIitSXs7ggSSzVOdLxl+gi6fY7x5XvisJ1q11V7xqg+fYHhzt1qmJYHqF2jhWrMYHnfDLuR0/Ttgj0v21bIcIEeynsPbykQYSh2EerqO+VJBj72WoGQbI5JSbDeHFb7PTEbpakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783665668; c=relaxed/simple;
	bh=+F2Xb/O2Ksf62wDRnqzT2Nu81eHheiCo+VUKzMQCGlM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=URN9kH8Ul9UnUatgqMiBBC0WDUz9imwG6ceB7Ma/Bt4SrcC6oRDhq59YELIo/AqX8Hh+OctDuirhh8KVkry6LiH7M+L1q3Kl+vvktcd31skSAX/rz0afMqKdgW9ood8a+J6Qh3fR9w2DDyhO94xK1Zsze3aOMzmSVgq4UCt7WuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n7QoepWP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HGsmfzf7; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n7QoepWP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HGsmfzf7"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 551A67A008A;
	Fri, 10 Jul 2026 02:41:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 10 Jul 2026 02:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783665665; x=1783752065; bh=yxF0FsjfEK
	SajqKTWKnYs8Zt9rTbhsMKSmaudQhvxzg=; b=n7QoepWPgzE1nbX3oAyEXT8Qj8
	Zztv6m4FOVv09OwPZtJbKBmY493vyNAhAcNe2hdaOZVuu9K2DLdWyaZCdDuoH90E
	9++J98vOB+zCUED0Szkpc2I8anygIrDSrOChn2Q26auG+DMnhQSVS/eFu/zcv1Xi
	v5OVIlUoKjmISyZYsBGLCW2Gm0lt/THscnQjeK8Gd39cJu6hhUjhj4R8bJQHR8gM
	ddYtne13iNfZ3MhYCJC5itkQnQu7JnGpgbR9igNKYJSg24h03eW07/KbrS57l21g
	C/FQItPfxm3C0HJURxbRGq2YrY+wxNXBn6uJincNqP3UB/HjcDzrtk+haiTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783665665; x=1783752065; bh=yxF0FsjfEKSajqKTWKnYs8Zt9rTbhsMKSma
	udQhvxzg=; b=HGsmfzf7id6WL/y6mfd1UzLHrgUInqrsl6rgT9H6KcZoz6gCg8p
	w8H7WPR1tlsadVg8wHG3MoxukIZzCAwIeSsw6upJnuJlbaYWP8Mome8lOf1pDaV8
	QoUXyGhP0GdzFKoYCwdZDPuHmiVZ5RwhSiav0A2ym4QStVZZ5hWhAM3+jH9APH+l
	8biypTX+MM3KKt9RQQ68G5Eyu/ru+79+xbGH+6i8flmf2mIbQmffLCHquWL3HJ5K
	sGbahOHQ4p24ZgMhZDGNhKrqGOxy/jgOWpsEk3fLpa4gu6QBrhv9qJzkMq7pwYzy
	ElCNBkNS9oaIpRo0lT6zcOpTuJnSMGrlKtA==
X-ME-Sender: <xms:AZRQarUtNI_USF1-JylSYzf8VFFQyQIsTq3DW6HKgAtnCDSvB0oMWQ>
    <xme:AZRQarAL9qSXRD_jr4n8L1G-TrHkNB4nyjZLAT8vF7QzUqZCIEg3IK1QX0jW35_Nt
    ZCPd_5khXXZXiOshEAzWr_DrEQlTr_XJa9OdWhZXaf0Mbo36ny-4xY>
X-ME-Received: <xmr:AZRQakwiAeZLWSE6b8vGaIVDRGemcnoQnUhiwernI6rJJRTTLmJ26I8fIXMh9Dg7qyq2ZcprNnrImDBMJhV3is89ASfgT0d5_4elVek>
X-ME-Proxy-Cause: dmFkZTEqhU8LZ9RWy0shc1HAdvUH/LmbpXSzRT2OeEScdjTDReWI5qwPdfDYZ5Dj6TEeOx
    c3WtVFhkA+BTMGdZUx9TCCLTAsjRjgFGbecM+I9J1T5/c9/qKv65l7uEsmdRb3AZw7qL4G
    KJZmZkDqWyS9LCTj/0iE63GI1e+KMAi4VJsQ3gclZbEOlmP2IumvhSHvXV8fbRrdsVYuLF
    FMHSSJjQp+aldVC6Dzr0srwEGqY7OqHhVniJiABXe9Ufa121IZBH4UIWyVbBGX6Z8h7VfT
    /EsvLYdtQAQLPdSddmsk8SvIJZ5XL1A+Pb98KVOKQRDDP+TVtfSwXlmqfSSZ0kgpQR0aao
    15pV1JQRQSz0hvWAVx2roi16YwYSmQQl4yC+LbVorT9XFBPbMuBzbardvPDyE+GjITxX9Y
    zKkRqqnWNYRpv34J29fYlu0Ovmbkc5VqEEsBd0Xb7OHSHTpulTuMezL1Ci48VVxAxkiSF6
    ghWk99zpCODGYPaLIuEZ4dMu37xh6v4sQfNLyOyI05hqIM1O445LUPEnt55f38owa/SuJt
    I+0U8706XiVQUu075I6WpwStBuzcb9PQstpMQavfakjbVrWcdvTKLrbIk6BHAU4dh+V+j/
    R0b6WdyV+/Dl0AeixR8/X1/+3jpxlV1d0U64fIcAoF+cB99ZHO/vy0tcZ97w
X-ME-Proxy: <xmx:AZRQagBmJmLz02AAudYTq6x0VDIJguq4MGRcKtf9L90f8i49M9KqaQ>
    <xmx:AZRQapbpXryaSw82GNJWrDP74taMUYoB6GjQS4apih_p1jm-d7SUnw>
    <xmx:AZRQagi6H-90y5wJtSqZ50UThUWo051tjms2yr3EeKXGq6E1uz8-UA>
    <xmx:AZRQaj5v2C7xRcoiZVK3KGkH0wFo-9Aese0s3caz3Xl5toeHopYdVA>
    <xmx:AZRQavAxFUlaPYXmz9-6baSohGhWJZ11w4ot_hJMBjjJ7Jm8QTMsgdXS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 02:41:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] builtin/add.c: replace run_command() with direct
 apply_all_patches() call
In-Reply-To: <20260709192619.46791-1-gatlavishweshwarreddy26@gmail.com> (Gatla
	Vishweshwar Reddy's message of "Fri, 10 Jul 2026 00:56:19 +0530")
References: <20260709192619.46791-1-gatlavishweshwarreddy26@gmail.com>
Date: Thu, 09 Jul 2026 23:41:02 -0700
Message-ID: <xmqqmrvzfitd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com> writes:

> When the user runs "git add -e", the diff of the working tree changes
> is written to a temporary file, opened in an editor, and then applied
> back to the index. The application step was done by spawning a child

"was" -> "is"; in the first part of the log message that gives an
observation, we describe the status quo in the present tense.

> process running "git apply --recount --cached <file>", which is an
> unnecessary subprocess since the apply machinery is available as a
> native C API.
> @@ -187,7 +186,6 @@ static int edit_patch(struct repository *repo,
>  		      const char *prefix)
>  {
>  	char *file = repo_git_path(repo, "ADD_EDIT.patch");
> -	struct child_process child = CHILD_PROCESS_INIT;
>  	struct rev_info rev;
>  	int out;
>  	struct stat st;
> @@ -217,11 +215,15 @@ static int edit_patch(struct repository *repo,
>  	if (!st.st_size)
>  		die(_("empty patch. aborted"));
>  
> -	child.git_cmd = 1;
> -	strvec_pushl(&child.args, "apply", "--recount", "--cached", file,
> -		     NULL);
> -	if (run_command(&child))
> +	struct apply_state state;
> +	const char *apply_argv[] = { file, NULL };
> +
> +	if (init_apply_state(&state, repo, prefix))
> +		die(_("could not initialize apply state"));
> +	state.cached = 1;
> +	if (apply_all_patches(&state, 1, apply_argv, APPLY_OPT_RECOUNT))
>  		die(_("could not apply '%s'"), file);
> +	clear_apply_state(&state);

Compared to existing callers of the apply_all_patches() API
function, this implementation curiously lacks a prior call to
check_apply_state().

Has this been tested, and do we have sufficient test coverage for it?

Calling check_apply_state() should flip state->check_index on, given
that state.cached is set to 1 above. If I remember correctly, having
this bit enabled is required for apply_patch() to toggle the
.update_index member, which in turn allows apply_all_patches() to
update the index with the patch results. Please double-check this
logic, since it has been a while since I looked at these specific
code paths.

If my assumption holds, this patch might inadvertently stop writing
the result to the index, even though the original intent of
replacing 'apply --cached' was clearly to update it.

Thanks.


>  
>  	unlink(file);
>  	free(file);
