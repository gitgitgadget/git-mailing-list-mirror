Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C48C39EB59
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 21:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785361589; cv=none; b=tnAl5STQdDc1Up9qt4a6mX7f7V8BjLXt4sQzOdxMz1Ddxb0SsgxEqdbpEGhFK70eUa3Gu7CairwBkHcr/tq2kq51Yf0tgLPjYEmLrfXob9KWpslbbtSeyszbRiuXGGx7QMmxYuzUt7sq+M9RhIw4ShF8rl4ZRTCy8OQz92YdzL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785361589; c=relaxed/simple;
	bh=W2Mz7Y6BwdpyweCpxceR7ncfAT582c9NOXItC3vUwVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O6UoqSnuS2jFlC5K4fjShGpkDHphCKk0KAN/csLCc83cJb0g4R9mBGxg+rm5wgXqNl+I68Q5Zcc8FI6wgiPuFYUWUDo1IDq9FjsJGvvVCnxM4PSgqpmi71PAiIkbbJGy19FCAFyfWlGMDtsklRtD7RGINgAtjoN+J+ageDhgjQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E0zgPtr/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DdaaF58L; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E0zgPtr/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DdaaF58L"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 52E291400491;
	Wed, 29 Jul 2026 17:46:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Wed, 29 Jul 2026 17:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785361587; x=1785447987; bh=ycaFKKP3ZD
	x0M6NyVuBYkuLdVhksa1wAtfkQeOhVbqo=; b=E0zgPtr/9nFfhx5KsLy0B+Nd7T
	jApwYfCFrtMmJE4X8nnOYVDLJ+a0tgfiFbUUjsA8TmQ8dOPUQsQeFWwi0fEgP8GZ
	xlGu/MeRTW0lrJHie3UbWALY4QBTIRp4hVoELKLcAkZYZ60kSRv5NcmNXZ0u1Dvn
	My1s0HR8CssLd/zq2X5Eem5MpEngigHOY572W+fnBCPNstz2Zy1xnlThrS75mlpB
	QdWA0fu6WC06L40YHoJVEnhbZ/Z3yCjIMuN2Fxf0apAKK+beSIOhEd9y7v5efozN
	TTk8OiSRM1LVucRbS1dFyWKqXQ46eSCEKlbCCT8V4yI0mtdU+X60P6vXcS4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785361587; x=1785447987; bh=ycaFKKP3ZDx0M6NyVuBYkuLdVhksa1wAtfk
	QeOhVbqo=; b=DdaaF58LCN6Z4T76M2kDnomU3NUFDUg6PMM6c4KpUTmK4AodeCN
	fZOLFCak5XyYtI0Pp1tdFEV5J5gwxH+JRNvnHSNHENGyFbx1Tk1PZVa2WIwigTm9
	Z1QbQ8DxXZ10Mrzqed+pehzT8fXgXKW9PkCvPU2F1k20/3inG69K1qHg/UjKRbFI
	lPQ8UEDFOEo33Nh+/Ert6IDTVTbfC508BD80ZRrAf0eVwbYYD33AdnWKPvEuKOI7
	mFGLSgbQfUDLy1tEUZ2ill1Px3Z9/9Z8NMqWHS7f/Ym9A72O3K7h5l9ldwr2f0I1
	NPHfsLXFoFlbXQoSu3MpcU1zaj40DxpnbFQ==
X-ME-Sender: <xms:s3RqatceDdafVgkUppdmjpF_UDf36NscDTQ7FUS8UrZ1QDE6_rG1MQ>
    <xme:s3RqaipDUX_Sb3KlGD_yUGMWJ_TgL-KR8-d3TXFBbZaq4GOAvQeDHfQj_YcDdksdd
    YfQZFIGK6RgxbaU9hgOqobJPRX25qgF3r3l7VcAYDavft4MAWJ9gQ>
X-ME-Received: <xmr:s3Rqaj5dJ8ODPft0kcY2-bGyjqrNYp8drEk8HuEnk5ycxVfMZ5Gm6_mNu-fbXHU3PI0M4vmTPckkakg2OQWCH4McXoNmX7Lz8Q>
X-ME-Proxy-Cause: dmFkZTEzO63YfIl4ou2u2816BikRMA5T5cHopQGUpelfoy9q3BOYDrxYN/cE8+lRd8CHIX
    /wYvczsLkbLO+tsNu89Uh6Js4eiRKym3SnF+KLJKMVPZoTMil1Ac92pvqDn6xNggdX0Ud6
    wQK7BvFyvJmiaUeJDXFal6CHZkpbCd6mQymlkqbPh1kHN3hU169wLUHtf+9//4GED/Ealn
    g1vjaAktEpm3JuyFhTj6oAXI/iflyiKsMeMtXn/9mZmg6pKf0dtr+NpaOM9xyGLsnj7Js6
    a4XYw/eZmvGn11p8i1jDXX20qHm2MtH84yXyJE8GKlvRgT8EAXelK8ycYqpqHzF4DF1dNl
    a0NShWeD1rur8RtemVw/ZzPvTBnsEeQiP3UhN+RNtizoLXm6j0NbFJ1EKY6lvjQgCTNpNN
    R78e5deqFHIoWizOXO/CbN05dUvMYMCcmxm0mOpNaKRJZTjOJpWkTwXwENtP3oytqmMyeE
    g8Qpw+ZwjbaRWcLBwjkhhcDP8p3q7qx9CDD+CHJSXx7o4tzs/J/mL5ADwLNoePF6LtQtSF
    /GTmk72tpnqVIcsJ5RJdeZjzHFaLZZorcNQkxVPoHrb+/F2ODVoHdx4Wk+Pvc9NXRCwwF6
    wLztCK4JqXuOvnfocnDz8CGY3KYpTbMPM/3wa7S+0frYnQu8IyQZaTuMkylA
X-ME-Proxy: <xmx:s3RqagrrehdHIAAqN3e1sfXzmCVn1XUglRKzMZIm4CKQ4V-BepVcSg>
    <xmx:s3RqatiKGjLPBVq6c771gk9BGBoym1SAAkPM-L87oj1DN5NSLG0Fqg>
    <xmx:s3RqaiKvvIeYChoL2c8gYu1F4HZUZQbTB0Zo2A7JDG5kXnapTnbdhw>
    <xmx:s3RqalAn2q2slWbA298JelnoOkplGAn2MZvdcsgcFO4CZFZkPbNamA>
    <xmx:s3RqaurFGNmmsGYBS1OpMyUiW5lFRELmOt0l1lQX5TmO9-4T81DQb9Ae>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 17:46:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4] builtin/add.c: replace run_command() with direct
 apply_all_patches() call
In-Reply-To: <20260711061246.58079-1-gatlavishweshwarreddy26@gmail.com> (Gatla
	Vishweshwar Reddy's message of "Sat, 11 Jul 2026 11:36:15 +0530")
References: <xmqqechab03t.fsf@gitster.g>
	<20260711061246.58079-1-gatlavishweshwarreddy26@gmail.com>
Date: Wed, 29 Jul 2026 14:46:25 -0700
Message-ID: <xmqq8q6to4em.fsf@gitster.g>
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
> back to the index. The application step is done by spawning a child
> process running "git apply --recount --cached <file>", which is an
> unnecessary subprocess since the apply machinery is available as a
> native C API.
>
> Replace the run_command() call with a direct call to apply_all_patches()
> using an initialized apply_state with the cached and recount options set
> appropriately. This avoids the overhead of forking a subprocess, keeps
> the operation within the same process, and makes the intent of the code
> clearer to the reader.
>
> Remove the now-unused includes of "run-command.h" and "strvec.h" since
> no other code in this file requires them after this change.
>
> Signed-off-by: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
> ---
>
> ---
> Changes in v4:
> - Pass NULL instead of prefix to init_apply_state() since the file
>   path from repo_git_path() is a git-internal path that should not
>   be prefixed. This is safe regardless of whether repo->gitdir is
>   absolute or relative, as prefix_filename(NULL, arg) returns the
>   path unchanged (abspath.c line 269).
> - Add a test in t3702-add-edit.sh verifying that "git add -e" works
>   correctly when run from a subdirectory.
> - Tested with t3702-add-edit.sh: all 4 tests pass.

Now the way "apply" API is used in this new code path should be
pretty much parallel to existing "git apply" and "git am" code
paths, we should be fine.  I do not use "git add -e", but those who
do who may care more more deeply about keeping this feature working
than I do may want to lend an extra pair of eyes on this patch.

Thanks.

> diff --git a/builtin/add.c b/builtin/add.c
> index c859f66519..20a86a1611 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -13,7 +13,6 @@
>  #include "dir.h"
>  #include "gettext.h"
>  #include "pathspec.h"
> -#include "run-command.h"
>  #include "object-file.h"
>  #include "odb.h"
>  #include "odb/transaction.h"
> @@ -23,9 +22,9 @@
>  #include "diff.h"
>  #include "read-cache.h"
>  #include "revision.h"
> -#include "strvec.h"
>  #include "submodule.h"
>  #include "add-interactive.h"
> +#include "apply.h"
>
>  static const char * const builtin_add_usage[] = {
>  	N_("git add [<options>] [--] <pathspec>..."),
> @@ -187,7 +186,8 @@ static int edit_patch(struct repository *repo,
>  		      const char *prefix)
>  {
>  	char *file = repo_git_path(repo, "ADD_EDIT.patch");
> -	struct child_process child = CHILD_PROCESS_INIT;
> +	struct apply_state state;
> +	const char *apply_argv[2];
>  	struct rev_info rev;
>  	int out;
>  	struct stat st;
> @@ -217,11 +217,16 @@ static int edit_patch(struct repository *repo,
>  	if (!st.st_size)
>  		die(_("empty patch. aborted"));
>
> -	child.git_cmd = 1;
> -	strvec_pushl(&child.args, "apply", "--recount", "--cached", file,
> -		     NULL);
> -	if (run_command(&child))
> +	apply_argv[0] = file;
> +	apply_argv[1] = NULL;
> +	if (init_apply_state(&state, repo, NULL))
> +		die(_("could not initialize apply state"));
> +	state.cached = 1;
> +	if (check_apply_state(&state, 0))
> +		die(_("could not check apply state"));
> +	if (apply_all_patches(&state, 1, apply_argv, APPLY_OPT_RECOUNT))
>  		die(_("could not apply '%s'"), file);
> +	clear_apply_state(&state);
>
>  	unlink(file);
>  	free(file);
> diff --git a/t/t3702-add-edit.sh b/t/t3702-add-edit.sh
> index 8bacacbac6..f628564005 100755
> --- a/t/t3702-add-edit.sh
> +++ b/t/t3702-add-edit.sh
> @@ -124,5 +124,15 @@ test_expect_success 'add -e notices editor failure' '
>  	test_must_fail env GIT_EDITOR=false git add -e &&
>  	test_expect_code 1 git diff --exit-code
>  '
> +test_expect_success 'add -e works from a subdirectory' '
> +	git reset --hard &&
> +	echo change >>file &&
> +	mkdir -p subdir &&
> +	(
> +		cd subdir &&
> +		GIT_EDITOR=cat git add -e ../file
> +	) &&
> +	git diff --cached | grep -q "^+change"
> +'
>
>  test_done
