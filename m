Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD2AC77B7C
	for <git@archiver.kernel.org>; Fri,  5 May 2023 19:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjEEThb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 15:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjEETha (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 15:37:30 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257E52127
        for <git@vger.kernel.org>; Fri,  5 May 2023 12:37:29 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1aafa03f541so21177105ad.0
        for <git@vger.kernel.org>; Fri, 05 May 2023 12:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683315448; x=1685907448;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOYC2gch85cJJWQe+S8pCrY4GzxG5f4fCs28CEXdL2E=;
        b=UR8vb6cLwef8wuKzfp+j26fueTjuO8X5UmVQGXhmCLE7uslv9GqgC4B8NLC9VuhhVT
         nxFZWEudbTQygrzvKNgBVPQFRNukoY/uY1Lq32HbGlqiZle6TIaWJ1Es3hO4Q+5dTvL7
         MHxs2z8wRbZrpari5lAeHyiVE2MpMALLRW6WLQpRSXKSZhb6PC9rvpmHWfInEW8vg5oI
         fM+VQePucmZJk9TDM66LottZKdu7bgqqz8nmjuqMB81kHfm5cjIPr42ScLGrW9eDeHlo
         0sYZXILOgqgRmBqVVrgFUvRH9hl3tY4QsBBb6xK+KXioh0sLCWnPbGgUU5BDeAFZSBxq
         mrzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683315448; x=1685907448;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iOYC2gch85cJJWQe+S8pCrY4GzxG5f4fCs28CEXdL2E=;
        b=XU3T6iK0r32wvCz3vSYXNDGd3TRjpORYmUaK7mYm/7vdwsChqU5fct9obki1zxUxsd
         rZbjqHH1j2GF2QV4yHVboDE7XKSyCoo4Rl4v50wOOd9Bjh51TKcu714inoX15Ox0Dhrg
         ij/YprQ1AY0RSs6uRJnKQJ09+s/cr8nnBbw8p1ChGxEoinP/BV7Ej+1UxVj87moNnDiC
         llRitB9YiYN4fKn47OKpcDNzu0K49Y6z7QtQcqdAN6N0PfhozPfEVpLSj6B47j7g+dnv
         qc/WVtr5IqZEBmw3VrHVNQoYbsTZC+XtXbpZyTEOqVIVLhA2sAqQTbrdmPvSmGBOsFmC
         0UBg==
X-Gm-Message-State: AC+VfDymVB2GKKJ/I46ke45t+QZcmE4ixlGbpTvcLAkndAV7PtzYRk7j
        XaEh7rMdeyOeyseT29dVKhVLKJ3WJT4=
X-Google-Smtp-Source: ACHHUZ441ye4YVdgDlRgXqSdavoNeoLPL1qYowYQjzW2zIyTtoVnp85stFgrN49LjsDt//86CSO5gA==
X-Received: by 2002:a17:903:22c7:b0:1a6:82ac:f277 with SMTP id y7-20020a17090322c700b001a682acf277mr2856317plg.14.1683315448429;
        Fri, 05 May 2023 12:37:28 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id iw6-20020a170903044600b001aafe4f9b8esm2122715plb.180.2023.05.05.12.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 12:37:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2] name-rev: make --stdin hidden
References: <pull.1225.git.git.1646774677277.gitgitgadget@gmail.com>
        <pull.1225.v2.git.git.1683314270964.gitgitgadget@gmail.com>
Date:   Fri, 05 May 2023 12:37:27 -0700
In-Reply-To: <pull.1225.v2.git.git.1683314270964.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Fri, 05 May 2023 19:17:50 +0000")
Message-ID: <xmqqild6d0y0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> In 34ae3b70 (name-rev: deprecate --stdin in favor of --annotate-stdin),
> we renamed --stdin to --annotate-stdin for the sake of a clearer name
> for the option, and added text that indicates --stdin is deprecated. The
> next step is to hide --stdin completely.
>
> Make the option hidden. Also, update documentation to remove all
> mentions of --stdin.
>
> Signed-off-by: "John Cai" <johncai86@gmail.com>
> ---
>     name-rev: make --stdin hidden
>     
>     Now that --stdin has been deprecated for several releases, the next step
>     of replacing name-rev --stdin with --annotate-stdin is to make --stdin
>     hidden. This patch also updates documentation to get rid of any mention
>     of --stdin.

Nice.  It has been a year, and I agree that it is about time.

Thanks for not forgetting about the topic.

>      -+			   N_("deprecated: use annotate-stdin instead"),
>      ++			   N_("deprecated: use --annotate-stdin instead"),

And of course this one is a very nice touch, relative to the
previous round.

>       +			   PARSE_OPT_HIDDEN),

> diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
> index ec8a27ce8bf..5f196c03708 100644
> --- a/Documentation/git-name-rev.txt
> +++ b/Documentation/git-name-rev.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git name-rev' [--tags] [--refs=<pattern>]
> -	       ( --all | --stdin | <commit-ish>... )
> +	       ( --all | --annotate-stdin | <commit-ish>... )
>  
>  DESCRIPTION
>  -----------
> @@ -70,10 +70,6 @@ The full name after substitution is master,
>  while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
>  -----------
>  
> ---stdin::
> -	This option is deprecated in favor of 'git name-rev --annotate-stdin'.
> -	They are functionally equivalent.
> -
>  --name-only::
>  	Instead of printing both the SHA-1 and the name, print only
>  	the name.  If given with --tags the usual tag prefix of

I agree with the main thrust of the change, but I am not sure if it
is a good idea to "completely" remove the mention.

Even after we stop talking about it, people find old scriptlets that
use "name-rev --stdin" from various random places on the Internet,
and wonder if they are buggy.  I wonder if having something like
this for a year or two may help?  We would need to scan for "was
called" and decide to clean them up once in a while, of course.

Will queue as is.  Thanks.

 Documentation/git-name-rev.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git c/Documentation/git-name-rev.txt w/Documentation/git-name-rev.txt
index 5f196c0370..1173deae57 100644
--- c/Documentation/git-name-rev.txt
+++ w/Documentation/git-name-rev.txt
@@ -46,7 +46,8 @@ OPTIONS
 	Transform stdin by substituting all the 40-character SHA-1
 	hexes (say $hex) with "$hex ($rev_name)".  When used with
 	--name-only, substitute with "$rev_name", omitting $hex
-	altogether.
+	altogether.  This option was called `--stdin` in older
+	versions of Git.
 +
 For example:
 +
