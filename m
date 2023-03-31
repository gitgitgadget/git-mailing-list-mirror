Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44E6C761A6
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 16:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjCaQSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 12:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjCaQRm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 12:17:42 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4735A22238
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 09:12:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id z19so21692112plo.2
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 09:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680279139;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RliXcd8uMDdE7yxtE+U/daFumJrYSah8LFhRyFJTMeI=;
        b=G1iF9Z5VC15E2bobgtLSQZliqKUWcT+Ivm1dUTLr6et60akO6yeGESQ0USkcmhEdpR
         nGYOrd44UggtIWrL+t3DnAjWMkajt7gtJ5xRwmXUb4JcAATGXp0AfyOpBUKO7wZUNIol
         0TODfRXcjiZ/MLwJu8tGDmmV/vt91obciIUSBJWk2YRIlzdsDjm7GNLElySqzYHr1DS/
         k0qLuAiK2/ynZrYo5ENzpWMGjyPV00N+P7GL4VxgR34mFaWeO5/YugQENEf+twU2I5gD
         bzlfr9EmIRDaTR7ct97hgy4E2eK2TcaakXJ61uo1lNUAhTeZ/kgtjnkuvDNPv6mxMecb
         KoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680279139;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RliXcd8uMDdE7yxtE+U/daFumJrYSah8LFhRyFJTMeI=;
        b=1bG+NwFTUXnG9g0jRpLDmG0QG69AKSmoOoHH6DhLREa67HmmRuwTGfWdZBq9c7L3un
         ptWQq0NJ3kMRVGsXncSnxubNaDG1Cq/49F+cwmhFEi252bnwxSlP0Jsq7j21qSqNuPMA
         E5qPVkG2aIEvPXx92hUE1MHqbQ4cT8dBLVGAtpR3xn1657nvitNMZUX0TwE/C3Wt+xxu
         YTWB+2ULaYhDOL0a9d0vHK0PbuiOz9Mmvrdorrea9PSZQLvelNYvHcmw61kJR7TOZMoa
         YgzNEi4JmOd4o86b43nZ1nUkb/Ts5iLJUqlJA91arrUd2P72Y0sMxpUaEvgU+YtoBPiK
         ufhg==
X-Gm-Message-State: AO0yUKWh2L7dMIxYhDpbnx4DYD2mFVnBU/I7ZoWjflywqBmXCZ00HL8g
        6MbPAes5ppXUKmzeEurjXXDH2rfq4JI=
X-Google-Smtp-Source: AK7set8vY+CXAtodQnc4rWtjrVuvOLNIBeQiNjN/UBZexOApKROJWXRZsf2NsMP80r7x7FAXZKeAWg==
X-Received: by 2002:a05:6a20:4e1a:b0:d6:b44e:f644 with SMTP id gk26-20020a056a204e1a00b000d6b44ef644mr23457547pzb.59.1680279139105;
        Fri, 31 Mar 2023 09:12:19 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id s14-20020aa7828e000000b005a8bf239f5csm1988209pfm.193.2023.03.31.09.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 09:12:18 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "ryicoh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ryicoh <ryicoh@gmail.com>
Subject: Re: [PATCH] doc: add that '-' is the same as '@{-1}'
References: <pull.1484.git.git.1680257503697.gitgitgadget@gmail.com>
Date:   Fri, 31 Mar 2023 09:12:18 -0700
In-Reply-To: <pull.1484.git.git.1680257503697.gitgitgadget@gmail.com> (ryicoh
        via GitGitGadget's message of "Fri, 31 Mar 2023 10:11:43 +0000")
Message-ID: <xmqqlejchpct.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ryicoh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 9aa58052bc7..9e7ea2cf71e 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -94,7 +94,8 @@ some output processing may assume ref names in UTF-8.
>  
>  '@{-<n>}', e.g. '@{-1}'::
>    The construct '@{-<n>}' means the <n>th branch/commit checked out
> -  before the current one.
> +  before the current one. You may also specify - which is synonymous
> +  to @{-1}.

I know the author of the change meant well, but this change makes
the resulting text overly broad and misleading by saying `-` is
"synonymous".  It is certainly *not* synonymous in general and I
doubt we want to make it to.

  $ git switch --detach master
  $ git reset --hard maint
  $ git commit --amend -C -
  fatal: could not look up commit -
  $ git show -
  fatal: unrecognized argument: -
  $ git log ..-
  fatal: ambiguous argument '..-': unknown revision or path not in the working tree
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file...]'
  $ git log HEAD..- --
  fatal: bad revision 'HEAD..-'

There are only few selected places that treat "-" like "@{-1}".  The
primary motivation behind "-" is to allow those who are so used to
see that "cd $there && do something there && cd -" to come back to
the original place to do

  $ git switch there
  $ hack hack hack
  $ git switch -      ;# or "git checkout -"

and the intention is to use it where we do not allow arbitrary
commit object name but it is clear we are taking a branch name.

"git switch --help" and "git checkout --help" already mention them;
if there is another command that uses "-" as "@{-1}" (and not as
"the standard input" or "the standard output"), for now we should
update its documentation to mention "- can also be used in place of
@{-1}".

Thanks.
