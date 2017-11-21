Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85BA92036D
	for <e@80x24.org>; Tue, 21 Nov 2017 18:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbdKUSiV (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 13:38:21 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33195 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbdKUSiU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 13:38:20 -0500
Received: by mail-qk0-f195.google.com with SMTP id 78so13397428qkz.0
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 10:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=28TpptAzcoJtIRa2guDRvdqaA9ck2yuTZzJMhpYem6A=;
        b=gtXiFJ7zUiqBOrBbM6boCbPSb5eZv/DYImpXpmEkNOdEHWoJMb/pVkd0Ci4jkuj3d9
         oOXhD6aIeFLgGqMNmqi6RzglwDRxk0ZGK+WTqOrxsrMylXxWktOfrWyxaFyuSFbNihMO
         EQ2DJZdnspEAkVdZ9ONLlrIT+lj75jVb8SqS7emktpDCiEphL+81hlRXmoiJ1iAK/FjN
         qAjjuugMrMFmd10Zwtl0lywb0WZapVSo2pyyT7ilcW7bvgcreDfvj/eM01/AtmGkbSJ0
         aTF4TwHA6y5aiKsU15bXrK5vMgtKwGERnhuf85oJE7WZuOR2//LQ9xdnVf8G8GSHDIgj
         B7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=28TpptAzcoJtIRa2guDRvdqaA9ck2yuTZzJMhpYem6A=;
        b=DaQpFxVSFhruelO/RORdfMt7Aq8xmTMXi1FMCMmpzgS8GDnTJI36WuOIH/EubGqfko
         736yfA8EnWZPI4YuDy85aDPJ51zPOSgFu6Ti/0TpvBCDibYujnMV+h5lz1gvTlguRARM
         yjYrPQiB+/YAd5Jl33M/rQFdbwll1rSh5CEP9Ifci17gQDUTZNnWOUGPSYnLCRTtsDSs
         G9WmVII8UF9n5HM7u4sYOVVdE7jPcdPdHzACMai075ndyYguhbeUn0ZZ53YzSgU1rQzB
         jzKDS0kn9UDxP5O8b1pJ751CyTVMJXm11v+42OexE88Cp8VMNwmM/Z/WjaE0bA3EvaGg
         Wwhg==
X-Gm-Message-State: AJaThX46zZLL7doVtVXiCmP/y9z5kSA9KHDxSxRRobsyHN/6fafS/KmT
        xkblqsUji6w7Ccuqe7FKheJso1oswZNsbA6F0BM=
X-Google-Smtp-Source: AGs4zMbdGPtxjf/EpHnXvk+6hA+m94BwVlC7XifITp5WEo82I+hbIjoC1Xr8qXOzTkT0PHNlb/npE1jiR1Vp271/xoI=
X-Received: by 10.55.90.4 with SMTP id o4mr15421346qkb.296.1511289499645; Tue,
 21 Nov 2017 10:38:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Tue, 21 Nov 2017 10:38:19 -0800 (PST)
In-Reply-To: <20171121141852.551-1-kaartic.sivaraam@gmail.com>
References: <20171121141852.551-1-kaartic.sivaraam@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 21 Nov 2017 13:38:19 -0500
X-Google-Sender-Auth: DnFfiS0B4W1D5KYVwfuosASVOSI
Message-ID: <CAPig+cSGu-+6Bw3YBzMwzxO8vKt7jdf9xgtr9FUdOAQpXzi2rQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] builtin/branch: strip refs/heads/ using skip_prefix
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 9:18 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> Instead of hard-coding the offset strlen("refs/heads/") to skip
> the prefix "refs/heads/" use the skip_prefix() function which
> is more communicative and verifies that the string actually
> starts with that prefix.
>
> Though we don't check for the result of verification here as
> it's (almost) always the case that the string does start
> with "refs/heads", it's just better to avoid hard-coding and
> be more communicative.

The original code unconditionally uses "+ 11", which says that the
prefix is _always_ present. This commit message muddies the waters by
saying the prefix might or might not be present. Which is correct? If
the code is correct, then the commit message is misleading; if the
message is correct, then the code is buggy and the commit message
should say that it is fixing a bug.

I'm guessing that the code is correct, which means the commit message
should be revised. The motivation for using skip_prefix() over
hard-coded magic values should be pretty obvious, thus doesn't require
a long (and potentially confusing) explanation. Perhaps take a hint
from de3ce210ed (merge: use skip_prefix(), 2017-08-10):

    merge: use skip_prefix()

    Get rid of a magic string length constant by using skip_prefix() instead
    of starts_with().

and pattern your commit message after it.

> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
> diff --git a/builtin/branch.c b/builtin/branch.c
> @@ -493,13 +495,17 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
> +       /* At this point it should be safe to believe that the refs have the
> +          prefix "refs/heads/" */
> +       skip_prefix(oldref.buf, "refs/heads/", &interpreted_oldname);
> +       skip_prefix(newref.buf, "refs/heads/", &interpreted_newname);

    /*
     * Format mult-line comments
     * like this.
     */

However, this in-code comment shares the same problem as the commit
message. It muddies the waters by saying that the prefix may or may
not be present, whereas the original code unconditionally stated that
it was present. Moreover, the comment adds very little or any value
since it's pretty much repeating what the code itself already says.
Consequently, it probably would be best to drop the comment
altogether.

>         if (copy)
>                 strbuf_addf(&logmsg, "Branch: copied %s to %s",
>                             oldref.buf, newref.buf);
>         else
>                 strbuf_addf(&logmsg, "Branch: renamed %s to %s",
>                             oldref.buf, newref.buf);
> -
>         if (!copy && rename_ref(oldref.buf, newref.buf, logmsg.buf))

Was the blank line removal intentional?

>                 die(_("Branch rename failed"));
>         if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
