Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062DB41C69
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 03:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742786755; cv=none; b=IjCaX5esw1rH7B9bXsjfQl0L5XvBW0cZ6UlRI/BSk8/IPHA9FUsvG/7q6gQAL91l4zgbhCdzQr1Y/jYhioFokChguPxDFQ++9q1QO35CGVqx44R61vbT6+dw4L0jE+2hyjJ/DdNro0XeJJ/CtQs+gqrID0z0+FbT0i+t/rIuD34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742786755; c=relaxed/simple;
	bh=5/zVZR/CjkAziNT4BZzyYF1TeAIYb5jJeLQxmQ05TGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nh6kRrj4llKfZXdCvRWxgfK85bkYe2VjDicsBrlBif0tMo56JXruaNsJVr+ZcG2Iq9GyndG49nMpVHqIQ7NxZQT5zZpIuDx6sEoDRnkhrevmABGCHejrKEnJOnoIex3UgA47VQ2FIvL/K618bT0VGcA8VOmoHEWBJNjsFwGig7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VpxJCiRj; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VpxJCiRj"
Received: (qmail 15377 invoked by uid 109); 24 Mar 2025 03:25:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5/zVZR/CjkAziNT4BZzyYF1TeAIYb5jJeLQxmQ05TGw=; b=VpxJCiRjND+CJa+4myHA1OqxjSz5xE69z/sD7SwJOZY9BbQL+1/EsKce14K7Io6bLIVgoU/UbMW9aAyrPG9HRAUabMiS1CmsssgBUBgLDHF/OALdz8Z5m8Mi3QnLMufzxHbFqa5fSv58+1ILPKJDOu8B6D7eakYxEcLYOBpDoqkYjLJ0Gkpn7PTIT+C3FIw3etUmmD8slNkYuiKjhvisBHUrDFlBMEC8MrOpN04B6dOZgriQrjNPXMJQ66iNqAjv7BctN1IYP2SL8BOLeSSaVJEgGRd44Oh+6YFDEw/r4CXLMR+uGJ0/jRpTtQnL8jen5GAZoPmOQcsZ2aYlZBzVUQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Mar 2025 03:25:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17088 invoked by uid 111); 24 Mar 2025 03:25:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 Mar 2025 23:25:51 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 23 Mar 2025 23:25:50 -0400
From: Jeff King <peff@peff.net>
To: Ayman Bagabas via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Chris Torek <chris.torek@gmail.com>,
	Ayman Bagabas <ayman.bagabas@gmail.com>
Subject: Re: [PATCH v3] shell: allow overriding built-in commands
Message-ID: <20250324032550.GA690093@coredump.intra.peff.net>
References: <pull.1930.v2.git.git.1742688740650.gitgitgadget@gmail.com>
 <pull.1930.v3.git.git.1742743771108.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1930.v3.git.git.1742743771108.gitgitgadget@gmail.com>

On Sun, Mar 23, 2025 at 03:29:30PM +0000, Ayman Bagabas via GitGitGadget wrote:

> From: Ayman Bagabas <ayman.bagabas@gmail.com>
> 
> This patch allows overriding the shell built-in commands by placing a
> script with the same name under git-shell-commands directory.
> 
> This is useful for users who want to extend the shell built-in commands
> without replacing the original command binary. For instance, a user
> wanting to allow only a subset of users to run the git-receive-pack can
> override the command with a script that checks the user and calls the
> original command if the user is allowed.

OK. We do not allow users to override normal Git commands with aliases,
etc. But in the case of git-shell, those names are really a well-known
API that a client is using, and this is the only opportunity an admin
has to plug in between the client request and Git just running the
command.

So it seems like a reasonable goal. A more restricted approach might be
to provide a more formal hook/plugin interface. E.g., to run a hook
script with the command name and arguments, and have it return
success/failure to allow the to proceed.

That's not quite as flexible (in your approach I could replace what
upload-pack is doing entirely, cache its output, and so on). But it
might be harder for admins to screw up. I dunno.

Let's look at the patch...

> diff --git a/shell.c b/shell.c
> index 76333c80686..8c7f4388bd5 100644
> --- a/shell.c
> +++ b/shell.c
> @@ -194,9 +194,11 @@ int cmd_main(int argc, const char **argv)
>  		/* Accept "git foo" as if the caller said "git-foo". */
>  		prog[3] = '-';
>  
> +	cd_to_homedir();
>  	for (cmd = cmd_list ; cmd->name ; cmd++) {

Hmm, so we have moved the cd_to_homedir() call up, which used to happen
after this loop. This means that when running a builtin command found in
the loop, our working directory will potentially be different now than
it was before your patch.

That seems like an unintended side effect. Though I admit I am not sure
why git-shell would be running in anything but the user's homedir in the
first place.

> +		char *full_cmd;
>  		if (strncmp(cmd->name, prog, len))
>  			continue;
>  		arg = NULL;
> @@ -210,10 +212,15 @@ int cmd_main(int argc, const char **argv)
>  		default:
>  			continue;
>  		}
> +		/* Allow overriding built-in commands */
> +		full_cmd = make_cmd(cmd->name);
> +		if (!access(full_cmd, X_OK)) {
> +			const char *argv[3] = { cmd->name, arg, NULL };
> +			return execv(full_cmd, (char *const *) argv);
> +		}
>  		return cmd->exec(cmd->name, arg);

This leaks full_cmd if the exec call fails, I'd think?

> +			const char *argv[3] = { cmd->name, arg, NULL };
> +			return execv(full_cmd, (char *const *) argv);

So we just stuff "arg" into the argv we pass to the script. But isn't it
supposed to be a shell command, that could have quoted arguments? For
user-defined commands, we call split_cmdline() to get the real array,
and pass it to the sub-program.  For the built-in commands, we seem to
cheat a little and just assume it is a single string, which we pick
apart with sq_dequote().

But either way what your patch is doing seems wrong. Your custom
git-upload-pack (or whatever) script will get passed the quoted value,
and have to unquote itself. I guess if that were documented it _could_
be the right thing, but it seems rather unfriendly and unlike how the
other user-defined commands work (and of course it's not actually
documented).

You also miss out on the option-injection protections from 3ec804490a
(shell: disallow repo names beginning with dash, 2017-04-29). We skip
those for user-defined commands, but I think you'd probably want them
for something meant to be a wrapper around the built-in command.
Likewise the setup_path() magic done by do_generic_cmd().

So it seems like rather than running execv() ourselves here, this should
probably do one of:

  a. Break out of the loop, skipping the built-in command, so that we
     can run it as a regular user-defined command.

  b. Hook into do_generic_cmd() instead, after we've done our de-quoting
     and checked for option injection.

Of the two, I think (b) is probably the least surprising in terms of
what the wrapper script has to do.

If this were just a hook that asked "can we run this command", then none
of this would matter. Running it would be a separate step.

-Peff
