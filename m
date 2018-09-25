Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18D1E1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 01:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeIYH3R (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 03:29:17 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44492 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeIYH3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 03:29:16 -0400
Received: by mail-yb1-f194.google.com with SMTP id y12-v6so5876935ybj.11
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 18:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1VCurAMso5KvU5mdIi+toKGi9hZoViPC+xpUcXRRfOo=;
        b=s9uShstf9vaVTkjti8ts0mQGnOjEEClhJUvG4DlmZLPsUFQC6zlBZuV1LwiEa09/9F
         T5N41dSbA0hdN1XNkAF8WB50adIxh/xqP82K1+F0QTU6zRTA2nTYatGGFzy381Hi5O5I
         BT4x2F8Fr01TFf0i0VFvsCexX0HF9rac56pfqLOx6PQ4mBX0ltk6FxLf/A1Lroa7IckI
         3JilOcaE6sEo18v4OBP2GwNNdHtuKpz8mCEUqZdcR7SbELslJ9XsV3NmZ2eGw+gwQbP9
         3i9t1Sy0mklaNvozTsBxmqjicCalxX01AR0w9Q1U3TO0X0XGrQxCX/11Pz60GhbGpROk
         YDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1VCurAMso5KvU5mdIi+toKGi9hZoViPC+xpUcXRRfOo=;
        b=t2WGF+Z/b2FT5+9xpFRBU6f8hInZQNHjdcRjcAdWOisVl/Rn+NWm0FPjFh8xMHCeE3
         dkqf1BWFIw9/06yFgmbTLIRmXR4ArK17XqO3g7EPWSYLCuNTzUlcCEdocCcGv4N4Puat
         DfzywKOXYLusWkZDHxbBSU72xO7C/yHGdN/Kpex0FWHQ51+fHjfhRF7YHrX9B1TAQ/U9
         lUJwQDrtqHHxXX4G4e1ghaTK0k+ThZ9smm3ErjBIaUTy1ac7vkwrcMV2+W1UZv8oigZO
         0pwjazgYUeMoETjbhDXz0VxlAG5L2S2QKfNOUCrkG8ABvflQJFmp6aLvIiW+TmSowhMD
         t54A==
X-Gm-Message-State: ABuFfogsCrmifHAoZzE7w+QWoZzKiR2TGCQV3YKrIT0fd1DZxJH8YOlt
        Twh2i7o1g0FHgOhiTz9oL33TwkhTVtGOjPj/uiYXxA==
X-Google-Smtp-Source: ACcGV625oogfFJrXLgCW/lsPKzgV2bCrMJJyF/Tdw9ehRa86yBxhzP/WEvtRJsMoUHgJcu429FVd+s4NYTYLjcl3ZxM=
X-Received: by 2002:a5b:1ce:: with SMTP id f14-v6mr686387ybp.363.1537838658570;
 Mon, 24 Sep 2018 18:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180924212352.41909-1-smckelvie@xevo.com>
In-Reply-To: <20180924212352.41909-1-smckelvie@xevo.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Sep 2018 18:24:07 -0700
Message-ID: <CAGZ79kZa-d3kPXp=q-YezffF68BUZzXv_tUaOKCi8=9SHy6jrA@mail.gmail.com>
Subject: Re: [PATCH] submodule.c: Make get_superproject_working_tree() work
 when supermodule has unmerged changes of the submodule reference
To:     sammck@gmail.com
Cc:     git <git@vger.kernel.org>, smckelvie@xevo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 2:25 PM Sam McKelvie <sammck@gmail.com> wrote:

Thanks for writing a patch!
I wonder if we can shorten the subject and make it a bit more concise,
how about

    submodule: Alllow staged changes for get_superproject_working_tree

or

    rev-parse: allow staged submodule in --show-superproject-working-tree


>     Previously, "fatal: BUG: returned path string doesn't match cwd?" is =
displayed and
>     git-rev-parse aborted.

Usually it is hard to read, continuing from the commit title to the body
of the commit message, as the title may be displayed differently or
somewhere else, so it would be good to restate it or rather state the
command that is broken, which we are trying to fix.

    Invoking 'git rev-parse --show-superproject-working-tree' exits with

        fatal: BUG ...

    instead of displaying the superproject working tree when ....

>     The problem is due to the fact that when a merge of the submodule ref=
erence is in progress,
>     "git --stage =E2=80=94full-name <submodule-relative-path>=E2=80=9D re=
turns three seperate entries for the

"ls-files" is missing in that git invocation?

>     submodule (one for each stage) rather than a single entry; e.g.,
>
>     $ git ls-files --stage --full-name submodule-child-test
>     160000 dbbd2766fa330fa741ea59bb38689fcc2d283ac5 1       submodule-chi=
ld-test
>     160000 f174d1dbfe863a59692c3bdae730a36f2a788c51 2       submodule-chi=
ld-test
>     160000 e6178f3a58b958543952e12824aa2106d560f21d 3       submodule-chi=
ld-test
>
>     The code in get_superproject_working_tree() expected exactly one entr=
y to be returned;
>     this patch makes it use the first entry if multiple entries are retur=
ned.

The code looks good.

I wonder if we want to add a test for it, see t/t1500-rev-parse.sh
(at the very end 'showing the superproject correctly').

>
>     Signed-off-by: Sam McKelvie <smckelvie@xevo.com>

Side note: the commit message seems to be indented,
but the patch applies fine, which makes me curious:
How did you produce&send the patch?
(Usually a patch would not apply as white spaces are
mangled in the code for example in some email setups)
(If I had to guess I could imagine that it is the output of
git-show as that indents the commit message usually,
see git-format-patch for a better tool)

Thanks for writing the patch!
Stefan
