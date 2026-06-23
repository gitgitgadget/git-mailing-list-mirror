Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037213090F5
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230983; cv=none; b=HjaQT9DkZI8Pa+HhW5qiQ6UrfZS2RbTRAtYeNJzvXiNbq9kcdOC7TD6iKkNS8lqz/4fWsVOyHAjlwQnTD2FSi3XfqkckC7K3S9CLYEumrs+5NEsjgGURRGUdgJ9j6ACGcrw1XcPeLrBq1oz17nP7lmQZENz5KlFLm+RuUnIpfj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230983; c=relaxed/simple;
	bh=IOyX+3uFvWjkMJEk70c0ejAxiekhQlTa5qKyJIMShPA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aWB1hcmkZjGTdQk7GnX1GaDINfnabz9o6uB3b1RqweAn7OGS2sRDTISkGNqlw5r8A7Ic+JXUbTTTCYtLZp6vqaX7o4XttNl33VXU7DHGDhK74KEAKxdShoKX6cYDslN1WI/E/9LJ8ZNuqE6CucycbQdEa4qkhSXXVNiiM3GjKqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BqFf5InW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VopER5zS; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BqFf5InW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VopER5zS"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 568CD1D00187;
	Tue, 23 Jun 2026 12:09:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 23 Jun 2026 12:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782230981; x=1782317381; bh=Hifz033Bkt
	Y7isg4Yg2W4RWM/KhnqxebS8gG+qlo2Fk=; b=BqFf5InWYOcFRDyy/X+qiDjLW1
	DREO77DjosI2Q295AzYT6P0cRKY6KYwhRzx2EYWXgJY7BGs9TGVPM+BLskCgXgK4
	c6/KLFsD8iHjq6HUe7WdpRtOalsRYpwdZhNv5dq6XO1Cpdy45Qyk8gkGht7+JQTy
	pp9e8cCljTmfoZ86ULK8ahdwhss2Fl+oQJIrCwEhYNvurutXCDfW8gi6d0IWX9iw
	kk/jD71l0XeZ6s4sHPmOBybWSYqPVVXEnut6TuYDu53S/lZvRP6zVi2YkrDBhABo
	KR+ZJBUgqt9JDThxf/3WaYboUQt/nMgM4hmaYXng3J0bIB/Lqbc2HA+bzwHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782230981; x=1782317381; bh=Hifz033BktY7isg4Yg2W4RWM/KhnqxebS8g
	G+qlo2Fk=; b=VopER5zSKqpkCfSV2tG+uqMLB+KQ2B1ENhMTRWSKzX5frv9hzLt
	R2je3ydt/H22uUVi5UF+yFZj6tMIPsMdPQoeLAHvGTjXYDNcIvcDcpaUuTqaD4s/
	SEML0y1syJkz9Al4dv5PCvMkKMjRWjtF+8aJ36jqCeAT4l+mbHl7k0sVzVX+fTrv
	sSmfP7Z3mGhDLnttwb5cpKm/7skcgzV9238og/IEdL9f077bXd6plF2qFnVNKzz9
	Zz0O2wAKtYOTFHAYilCybbbLCnClMm5j9nakuffqLHIGHnZx6D361PrOtnIM9fYF
	Uvmw3I0QmVR4XnzUFNiSLt8fVYfq+LJ7onA==
X-ME-Sender: <xms:xa86ak-hXUw-chxi_Qp5FaUcppP7I2r7dTH4ILPPbZIRSmlLxaE8yg>
    <xme:xa86ajtpzTxo7ybqGIlo33z2zyoVab7XdHxCyAZmJvLxUQPtOVcGMK0hXSlWtXrkB
    0CbGYW0nCYhOw2MDzKXUTJCBp7ezCvAa1WoR1X7Uv3mD2TcWCHRzQ>
X-ME-Received: <xmr:xa86avDdTgpW3nBjRnIb74F7IBt3mAXmNOfgEVpLcKGGEmL3VR-u6O2oXI2SutIDVdI6MVQQPnNXTEtKbpzh-iTdu7CBYfRbqDApZAs>
X-ME-Proxy-Cause: dmFkZTELepvKbUr2zGpngoYAo2gVVKrlCV1e3sVvqtTtsR4v6GYbRDLox6QdAzspLvnWKM
    sh6BQnLIE/FqmVrmOlPUEEVYjPLnnpp+fn4GwxS4mcYa1HHsyNIZA6UY+TqAbmJFjP/yXZ
    4LxJ1rWid+M1X5Inn8o3q9qyD78e1X4RVTn/yEqXvrRU0ZuRFHHdErSbIi7ryr4/Lzz0st
    CQD+if1Bd2wMgNN3OzgxHchnb3jkkdpKklyvwGSjkuMeVrzXxKGNEGpW6yQbHY0m0PLkz5
    t5BUqooj9TnXkJJQRq0R/OC0Tf5CH0AsD6VTTPwSVms1ehRyHMbGcU/GurZdadO/q5C9Of
    rRl6c2OdksdISyjlbOePntzw9wU0k9jrt3Eta76jvCClxo0PGcmUc3xUMxij1+bjUKzszL
    1970QJZLqlMjnvS7VvJIF964U7nv8jwuz/vvmPDIfrJ4azH2/XXIUchUai6apsj7zJHMPT
    SfERK33uHJATXtR9Gk+w9DCfaalsypHjNLokt8yYQDB9t0df2HMKMP4rZdAydBu4GU00Of
    fSACgDbO0s7COCdvcjMWsYqRRhFHJxQs3wp6bWyK/+huO8zzF0PVYysKHhVuHQBauh8IML
    /QdR5gOgSh5sL7YSbs1r0vQJAF7fHytRlqWe4b9PrpbPh+a0dBAxpkrx3V4w
X-ME-Proxy: <xmx:xa86ajUtWtEDmh7VKnt5K3ke2R3mqlBJT4zBkdGnddt63L2olofL3w>
    <xmx:xa86alATIHisOh-85r4yU_AQ4DMOiqezkl9sY8nkRbrJ3VjSOL8ECw>
    <xmx:xa86au9mWHP4p_G_ywMYOByyxY-eBMoC6LFA34dEEdIk1YKqGmqZlw>
    <xmx:xa86akGhXTfbIdkGQEEygGb-7legHYSXEzDn_i0ClAXxXee-7R93Rw>
    <xmx:xa86aijQCFXAchYPnsRCitEgCjymfSx3b74rQOzTwLSAl-RIVGkXTMal>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jun 2026 12:09:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jishnu C K <jishnuck26@gmail.com>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2] help: include arguments in autocorrect=prompt message
In-Reply-To: <6a357689.0f9b68c4.317a5d.1919@mx.google.com> (Jishnu C. K.'s
	message of "Fri, 19 Jun 2026 10:04:09 -0700 (PDT)")
References: <20260618142033.15216-1-jishnuck26@gmail.com>
	<ajQuqTB580gqNP8D@denethor>
	<6a357689.0f9b68c4.317a5d.1919@mx.google.com>
Date: Tue, 23 Jun 2026 09:09:39 -0700
Message-ID: <xmqqcxxhnsqk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jishnu C K <jishnuck26@gmail.com> writes:

> v2: Reworked as an incremental improvement to the existing
> autocorrect=prompt code path rather than a parallel reimplementation,
> per feedback from Junio and Justin.
>
> ---
> From a4e8fb6fd6dd6a501e565c7500cbf927d7cb0b42 Mon Sep 17 00:00:00 2001
> From: calicomills <jishnuck26@gmail.com>
> Date: Fri, 19 Jun 2026 13:01:40 +0530
> Subject: [PATCH v2 v2] help: include arguments in autocorrect=prompt message

To learn what a typical v2 of a single-patch topic should look like,
see

  https://lore.kernel.org/git/aipTOsH8LKTSwglj@collabora.com/

for an example.

 - Having auxiliary comments explaining why there is this v2,
   including description of the difference since v1, is good, but
   have it below the three-dash line after your sign off, not at the
   beginning.

 - Please do not include "From a4e8fb6f..." line, which is meant as
   a separator in multi-patch output from the git format-patch
   command; knowing the exact commit object name you took the patch
   from in your repository would not help anybody.

 - Do not include "From:" in the body of the message either, unless
   you are relaying somebody else's patch, i.e., when the From
   e-mail header (you) does not name the person who wrote the patch
   (somebody else).

 - Do not include "Date:" in the body of the message either, as that
   is the timestamp you wrote the change, but we care more about the
   time when the general public first saw the patch, which is in the
   e-mail header already.

 - Do not include "Subject:" in the body of the message either, as
   that should be on the Subject e-mail header.

> When 'help.autocorrect=prompt' is configured and the user mistypes
> a git command, the prompt currently shows only the corrected command
> name:
>
>   Run 'checkout' instead [y/N]?
>
> This leaves the user unsure whether their original arguments will be
> preserved. Update the prompt to include the full corrected invocation:
>
>   Run 'git checkout neo' instead [y/N]?
>
> The help_unknown_cmd() signature is updated to accept the args vector
> so the prompt can show the original arguments alongside the corrected
> command name. Callers that do not have access to the args (e.g.
> builtin/help.c) pass NULL, which is handled gracefully.
>
> Signed-off-by: calicomills <jishnuck26@gmail.com>

Documentation/SubmittingPatches[[real-name]] prefers to see us
interacting with humans with real-sounding names, not handles.

> ---
>  help.c                      | 49 +++++++++++++----------------------
>  t/t9003-help-autocorrect.sh | 51 +++++--------------------------------
>  2 files changed, 23 insertions(+), 77 deletions(-)
>
> diff --git a/help.c b/help.c
> index 30f32a7206..9ea4c076e1 100644
> --- a/help.c
> +++ b/help.c
> @@ -739,7 +739,16 @@ char *help_unknown_cmd(const char *cmd, const struct strvec *args)
>  		else if (cfg.autocorrect == AUTOCORRECT_PROMPT) {
>  			char *answer;
>  			struct strbuf msg = STRBUF_INIT;
> -			strbuf_addf(&msg, _("Run '%s' instead [y/N]? "), assumed);
> +			struct strbuf full_cmd = STRBUF_INIT;
> +			strbuf_addstr(&full_cmd, assumed);
> +			if (args) {
> +				for (size_t j = 1; j < args->nr; j++) {
> +					strbuf_addch(&full_cmd, ' ');
> +					strbuf_addstr(&full_cmd, args->v[j]);
> +				}
> +			}
> +			strbuf_addf(&msg, _("Run 'git %s' instead [y/N]? "), full_cmd.buf);
> +			strbuf_release(&full_cmd);

This change seems to match what is explained in the proposed log
message.  Instead of giving the "assumed" command without its
arguments, the full command line is gprepared to be given in 'msg'.

But if we really wanted to let these be cut-and-paste, don't you
need to shell-quote the command line?  If the user typed

	$ git comit -m "Hello world"

the above makes

	Run 'git commit -m hello world' instead [y/N]?

which would record the change made only to the file "world" with log
message "hello", which is not what the user wanted to do.

> @@ -762,37 +771,13 @@ char *help_unknown_cmd(const char *cmd, const struct strvec *args)
>  	fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
>  
>  	if (SIMILAR_ENOUGH(best_similarity)) {
> -		if (n == 1 && isatty(0) && isatty(2)) {
> -			char *answer;
> -			struct strbuf msg = STRBUF_INIT;
> -			struct strbuf full_cmd = STRBUF_INIT;
> -			strbuf_addstr(&full_cmd, main_cmds.names[0]->name);
> -			if (args) {
> -				for (size_t j = 1; j < args->nr; j++) {
> -					strbuf_addch(&full_cmd, ' ');
> -					strbuf_addstr(&full_cmd, args->v[j]);
> -				}
> -			}
> -			strbuf_addf(&msg, _("\nDid you mean 'git %s'? [y/N] "),
> -				    full_cmd.buf);
> -			strbuf_release(&full_cmd);
> -			answer = git_prompt(msg.buf, PROMPT_ECHO);
> -			strbuf_release(&msg);
> -			if (starts_with(answer, "y") || starts_with(answer, "Y")) {
> -				char *assumed = xstrdup(main_cmds.names[0]->name);
> -				cmdnames_release(&cfg.aliases);
> -				cmdnames_release(&main_cmds);
> -				cmdnames_release(&other_cmds);
> -				return assumed;
> -			}

What is this removal about?  The original used to give interactive
prompt to let the user say "Yes", but with this part removed, it no
longer offers the "well we have only one candidate, do you want to
run that one?", and you instead ...

> -		} else {
> -			fprintf_ln(stderr,
> -				   Q_("\nThe most similar command is",
> -				      "\nThe most similar commands are",
> -				   n));
> -			for (i = 0; i < n; i++)
> -				fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
> -		}

... only give "these are the possible candidates?"

> +		fprintf_ln(stderr,
> +			   Q_("\nThe most similar command is",
> +			      "\nThe most similar commands are",
> +			   n));
> +
> +		for (i = 0; i < n; i++)
> +			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
>  	}

Puzzled.

Worse, this [v2] does not even apply cleanly to any of the trees we
have.

Aha!  Is the removal I see above a mere "oops, this was wrong, so
remove it" done on top of a previous iteration of the patch?

Please do not do that.  It would mean we will keep unwanted code
that went into a wrong direction (which is v1) in our history.

The development may wander around in different directions like a
drunken man, changing course every time patches are updated, until
it finally gets right, but the name of the game around here, before
your change is merged to 'next', is to "pretend to be a more perfect
developer than you actually are" ;-).  You can pretend that you
never made a design mistake you made in [v1], and instead directly
arrived at a good state from the state of our public tree.  That
means [v2] (and any subsequent rerolls, until your seires gets
merged to 'next') must apply directly without any of the older
iterations to 'master' (or if it is a bugfix, 'maint') branch.

Thanks.
