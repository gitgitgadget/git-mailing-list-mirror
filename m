Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FE5C04A95
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 20:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJVUCf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 16:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJVUCd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 16:02:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF86EA6
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 13:02:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id u21so17732441edi.9
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 13:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X1+8YjyEkRh3c4TBQxkzkLpKgrxZe9QLUd09QCAze/Y=;
        b=ibc/8CQ1y4vILt+2HB4uUbvOR/kCqvv2p0UBxVMbjOn/imhRjM7u3W0TJ9Jo7+GAqM
         +HZKw+7TQKZET1L/jz4w6xCl2EJ2J+SRCSMO6II24YE36Jmux9Sn9uix0sC6Dn6i3O2k
         BbrQMeyWoL5BpSvGXfjLfPdrAB3GaUyLZI5jm6zpg3tNO/BsG2vzrwBrC4Ajb48x20qu
         8hRK82N7+L8kmXg7fWzrC3uH84c63tW99QyTR2//RK4Sla/Ff1tFEmPQ9Y1Vpy4sqdMt
         SXYWPcwKe2gblfmpaqpH6VaHp+jU8W2gaW8EyHUzRvD2F0CZemOEZVbzCsX2pQPcXdWb
         22vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1+8YjyEkRh3c4TBQxkzkLpKgrxZe9QLUd09QCAze/Y=;
        b=U+qolkNWL171dSgfs2qzAnFgET3qZIuS3Zg0rjjRh2W0DW6lClNXgYP3E8ZjUPZ88P
         9y7unKSwN7+N5/V4w6IYWCSQc2SnHCIJe5doydquNNvNdaHnHHlz1leyC+73FudeCbES
         ULFjAaP3tuVXVePi9ss+ayJeas3Okcb+k3gbD+p3jEyty81xNvnXPV/FH96j6PQw0I77
         Fi/ihHWIwnUslfcKylBwHhHKGDaj4R4neWrpCdLpnp9GhSeiDp0wK/BTeukquhb076DI
         cJFStp3FXFDoF0niox+wc42HLdcj6NCvii5zuovwLy46jMuIsj6R2UleS+3f53z9Hap2
         l+TQ==
X-Gm-Message-State: ACrzQf2K5ORDZXvjDsyaIZmpmlR7qA91U7SwI31SVsKP7mR2fumter+s
        xDonSi7Cn2FjJs0jDSi1GWfTyPMTHNw=
X-Google-Smtp-Source: AMsMyM4rZHMhEQWBTM4usdfw3h0ns54DDGq0aBmT2iplEdEQnzEaeCDszdPGl/q/B4VzrjLtc927jg==
X-Received: by 2002:a05:6402:348b:b0:45c:b22b:c4a9 with SMTP id v11-20020a056402348b00b0045cb22bc4a9mr24025269edc.65.1666468950415;
        Sat, 22 Oct 2022 13:02:30 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id nb36-20020a1709071ca400b0073ddb2eff27sm13355437ejc.167.2022.10.22.13.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 13:02:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1omKhP-007PCq-16;
        Sat, 22 Oct 2022 22:02:27 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael McClimon <michael@mcclimon.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] setup: allow Git.pm to do unsafe repo checking
Date:   Sat, 22 Oct 2022 21:45:14 +0200
References: <20221016212236.12453-1-michael@mcclimon.org>
 <20221022011931.43992-1-michael@mcclimon.org>
 <20221022011931.43992-3-michael@mcclimon.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221022011931.43992-3-michael@mcclimon.org>
Message-ID: <221022.86eduzeiek.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 21 2022, Michael McClimon wrote:

> The previous commit exposes a security flaw: it is possible to bypass
> unsafe repository checks by using Git.pm, where before the syntax error
> accidentally prohibited it. This problem occurs because Git.pm sets
> GIT_DIR explicitly, which bypasses the safe repository checks.
>
> Fix this by introducing a new environment variable,
> GIT_PERL_FORCE_OWNERSHIP_CHECK, which we set true in Git.pm. In setup.c,
> if that environment variable is true, force ownership checks even if
> an explicit GIT_DIR is provided.

The 1/2 is unambiguously good, thanks.

As for this step, I think it's good if we want to go in this direction.

As to whether it's the direction we want...

The vulnerability safe.directory was supposed to address was one where
you'd set your fsmonitor hook via a config variable, so running "diff",
"status" etc. would unexpectedly execute arbitrary code.

Especially on Windows where apparently the equivalent of the root of a
shared mounted volume routinely has global write permissions (user's
subdirectories being less permissive).

An alternative I raised on the security list was to narrowly target just
the fsmonitor config, since that was the vulnerability.

But it was decided to cast a wider net, as it wasn't disclosed yet, and
the list members might have missed some other config variable that would
allow shenanigans, fair enough, especially for a time constrained
security fix.

Now that the cat's thoroughly out of the bag I think we'd do well to
reconsider that.

I'm unaware of any other variable(s) that provide a similar vector, and
safe.directory is encouraging users (especially in core.sharedRepository
settings) to mark a dir as "safe", and we'd then later have an exploit
from a user with rw access who'd use the fsmonitor hook vector.

Better have them "safe by default", and start refusing to read the
config when we detect that fsmonitor setting, and insist the user mark
*that* safe.

Anyway, that's all on the general topic, and the above is just my
opinion on it.

But on this much more narrow topic: If we couldn't come up with an issue
other than the fsmonitor config for git's C codebase, I think extending
the same mitigation to the very small part of git that's still in Perl
is thoroughly into the tail wagging the dog territory.

I.e. what we'd presumably get out of this is mitigation against some
exploit via a variable that git-send-email or git-svn use (or the
handful of other more obscure Perl tooling we have).

Can we think of one that could be an issue, and if not is the current
behavior in 1/2 maybe OK as-is?

>  test_expect_success 'use t9700/test.pl to test Git.pm' '
>  	"$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl 2>stderr &&
>  	test_must_be_empty stderr
> diff --git a/t/t9700/test.pl b/t/t9700/test.pl
> index e046f7db..1c91019f 100755
> --- a/t/t9700/test.pl
> +++ b/t/t9700/test.pl
> @@ -142,6 +142,24 @@ sub adjust_dirsep {
>  		     "abc\"\\ \x07\x08\x09\x0a\x0b\x0c\x0d\x01 ",
>  		     'unquote escape sequences');
>  
> +# safe directory
> +{
> +	local $ENV{GIT_TEST_ASSUME_DIFFERENT_OWNER} = 1;
> +	# Save stderr to a tempfile so we can check the contents
> +	open our $tmpstderr2, ">&STDERR" or die "cannot save STDERR";
> +	my $tmperr = "unsafeerr.tmp";
> +	open STDERR, ">", "$tmperr" or die "cannot redirect STDERR to $tmperr";
> +	my $failed = eval { Git->repository(Directory => "$abs_repo_dir/bare.git") };
> +	ok(!$failed, "reject unsafe repository");
> +	like($@, qr/not a git repository/i, "unsafe error message");
> +	open TEMPFILE, "<", "$tmperr" or die "Can't open $tmperr $!";
> +	my $errcontents;
> +	{ local $/; $errcontents = <TEMPFILE>; }
> +	like($errcontents, qr/dubious ownership/, "dubious ownership message");
> +	close STDERR or die "cannot close temp stderr";
> +	open STDERR, ">&", $tmpstderr2 or die "cannot restore STDERR";
> +}

This whole "save stderr to a file" etc. seems much more complex than
just writing the same test in our normal *.sh tests, and doing something
like:


	! GIT_TEST_ASSUME_DIFFERENT_OWNER=1 perl -MGit -we 'Git->repository(Directory => shift)' 2>expect &&
	grep "reject unusafe" ...

I.e. you're spending a lot of effort on capturing STDERR within a single
Perl process, then restoring it etc., when we can just run one-off
command and have it die (no eval), and just inspect the exit code &
stderr perl emitted.


