Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE1DC1F42D
	for <e@80x24.org>; Fri, 23 Mar 2018 06:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751491AbeCWG05 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 02:26:57 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34414 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751288AbeCWG04 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 02:26:56 -0400
Received: by mail-qk0-f174.google.com with SMTP id z184so11871589qkc.1
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 23:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=eV8i7hNmLZKCARoPh/uUIhCmHGZgAK7Idaff2Q0d5qo=;
        b=FPrFhyBuaBYvo/UpPG1xMYvUl2uQ4K/ZWrJD762yPDav79xH/kImSV2jX8OuT9psmY
         1BxKC8MktsrgQy/ziLTPtEp4iiLwCqpC188+IoFDh88o7xmypxFTrpgmtjZmMK4g2uVC
         Hv7mtx8QyggGZDl+4/pkI6DrsKndqgyR9kjX35KpJGoRUdYyTCqSMmJCqEPngNOjQDNO
         ZWNC2qOjlYc/bl52DPWBQ72ahK0g3rLTJbkIllIHq7Wd39urOr29bNGos7sZE712ekdj
         1yjnDuaHhYqL2tVK4daczKqTNJtXgPU08bL0deJhMdYBiq/cGCia1R4tUPxOEOeNusHj
         Eqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=eV8i7hNmLZKCARoPh/uUIhCmHGZgAK7Idaff2Q0d5qo=;
        b=XXJF/3Vi3tc6B/4SVebzoKdsiroc07j7sk3Jt4NVAO/zQAKIQdp/cBs/GufQi8rVrn
         cASypK9U/oVYDTjbu4iHTUSET+LYQH/4CCZl1K0sn4DaQk6I3rFAXN4k9Vwwc3JfZzXA
         QzDrJeKYoSt+qgHCiq63lA7d0Z1xR8MW1XLP91MDVEghsgIdmb1TZDRM01URXZ77dtmm
         amBrd3Do4zAAmiRTJPNURI9HUE9uhZVRavmWMYMcwwUMW0rvMVUAr1BMXvL9C4sBm4TG
         EDeeTDlc3pBjb8lbQnP3TeVzp6rVRcoinZIn3VwsAnbp0+f1fhyZ9ZO8AnY11K4/Q4r7
         l0/Q==
X-Gm-Message-State: AElRT7F/+OJ/OApWNlnsIefQXf+2AXYEHN0UfSuLoNaOV3eQmHRuKUfj
        6AQMsoTpfOaK+RnxH+0D9IRwy5boq5Q1Kw0uqHkU5A==
X-Google-Smtp-Source: AG47ELsfz+RqQX2JYDwkNNygvAOb9YoMCeohqIFh04CPInj+g6mHFWKaYSPWaJmnULNBQX6KfbNdFaxK7TBiASgkV90=
X-Received: by 10.55.159.140 with SMTP id i134mr35089387qke.220.1521786415709;
 Thu, 22 Mar 2018 23:26:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Thu, 22 Mar 2018 23:26:55 -0700 (PDT)
In-Reply-To: <ed4cfdc9f31b920eae5055c3b080e2ca5b2f6e42.1521779249.git.wink@saville.com>
References: <cover.1521779249.git.wink@saville.com> <ed4cfdc9f31b920eae5055c3b080e2ca5b2f6e42.1521779249.git.wink@saville.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 23 Mar 2018 02:26:55 -0400
X-Google-Sender-Auth: X0dId7Vbr8za5WEao1Dni-YRKoQ
Message-ID: <CAPig+cQG16AhLPMeOFAw1GF81oXivFSDHvQ5B8kX20YGAT_BxQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4] rebase: Update invocation of rebase dot-sourced scripts
To:     Wink Saville <wink@saville.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for splitting these changes into smaller, more manageable
chunks. A couple non-code comments below apply to both patches in this
2-patch series even though I'm responding only to this patch. (The
actual code changes in the other patch looked fine and the patch was
easily digested.)

On Fri, Mar 23, 2018 at 12:39 AM, Wink Saville <wink@saville.com> wrote:
> rebase: Update invocation of rebase dot-sourced scripts

Nit: On this project, the summary line is not capitalized, so: s/Update/update/

> The backend scriptlets for "git rebase" were structured in a

On this project, commit messages are written in imperative mood. The
commit message Junio suggested[1] said "are structured", which makes
for a better imperative mood fit.

> bit unusual way for historical reasons.  Originally, it was
> designed in such a way that dot-sourcing them from "git
> rebase" would be sufficient to invoke the specific backend.
>
> When it was discovered that some shell implementations
> (e.g. FreeBSD 9.x) misbehaved when exiting with a "return"
> is executed at the top level of a dot-sourced script (the
> original was expecting that the control returns to the next
> command in "git rebase" after dot-sourcing the scriptlet).

ECANTPARSE: This paragraph is grammatically corrupt.

?  "When {something}..." but then what?

?  "...when exiting with a "return" is executed"

> To fix this issue the whole body of git-rebase--$backend.sh
> was made into a shell function git_rebase__$backend and then
> the last statement of the scriptlet would invoke the function.

Junio's proposed commit message[1] called this a "workaround", not a
"fix", and, indeed, "workaround" better characterizes that change. If
anything, _this_ patch is a (more correct) "fix" for that workaround.

> Here the call is moved to "git rebase" side, instead of at the

Junio's version, using imperative mood, said "Move the call...".

> end of each scriptlet.  This give us a more normal arrangement
> where the scriptlet function library and allows multiple functions
> to be implemented in a scriptlet.

ECANTPARSE: Grammatically corrupt.

?  "where the ... library and allows..."

Overall, Junio's proposed message followed project practice
(imperative mood) more closely and felt somewhat more coherent
(despite the run-on sentence in the first paragraph and the apparent
incorrect explanation of top-level "return" misbehavior -- the in-code
comment says top-level "return" was essentially a no-op in broken
shells, whereas he said it exited the shell).

Perhaps the following re-write addresses the above concerns:

    Due to historical reasons, the backend scriptlets for "git rebase"
    are structured a bit unusually. As originally designed,
    dot-sourcing them from "git rebase" was sufficient to invoke the
    specific backend.

    However, it was later discovered that some shell implementations
    (e.g. FreeBSD 9.x) misbehaved by continuing to execute statements
    following a top-level "return" rather than returning control to
    the next statement in "git rebase" after dot-sourcing the
    scriptlet. To work around this shortcoming, the whole body of
    git-rebase--$backend.sh was made into a shell function
    git_rebase__$backend, and then the very last line of the scriptlet
    called that function.

    A more normal architecture is for a dot-sourced scriptlet merely
    to define functions (thus acting as a function library), and for
    those functions to be called by the script doing the dot-sourcing.
    Migrate to this arrangement by moving the git_rebase__$backend
    call from the end of a scriptlet into "git rebase" itself.

    While at it, remove the large comment block from each scriptlet
    explaining this historic anomaly since it serves no purpose under
    the new normalized architecture in which a scriptlet is merely a
    function library.

> Signed-off-by: Wink Saville <wink@saville.com>
> Reviewed-by: Junio C Hamano <gitster@pobox.com>
> Reviewed-by: Eric Sunsine <sunsine@sunshineco.com>

Despite its name, on this project, a Reviewed-by: does not mean merely
that a person looked at and commented on a patch. Rather, it is a way
for a person to say "I have studied and understood the patch and feel
that it is ready for inclusion in the project." Reviewed-by:'s are
therefore always given explicitly by the reviewer and Junio adds them
to a patch when queuing. (Reviewed-by:'s are not always given, though,
even when a reviewer has not found problems with a patch. For
instance, even if I review and comment on this or subsequent patches,
I will not give a Reviewed-by: since I'm not an area expert, thus
wouldn't feel comfortable stating that the patch is correct.)

Consequently, these Reviewed-by: lines should be dropped. (You can, on
the other hand, add Helped-by:'s when appropriate.)

The patch itself makes sense and seems straightforward. See one minor
comment below...

[1]: https://public-inbox.org/git/xmqqefkbltxv.fsf@gitster-ct.c.googlers.com/

> ---
> diff --git a/git-rebase.sh b/git-rebase.sh
> index a1f6e5de6..4595a316a 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -196,7 +196,9 @@ run_specific_rebase () {
>                 export GIT_EDITOR
>                 autosquash=
>         fi
> +       # Source the code and invoke it
>         . git-rebase--$type
> +       git_rebase__$type

The new comment merely repeats what the two lines of code themselves
already state clearly, thus the comment is an unnecessary distraction;
it does not aid in understanding the code.
