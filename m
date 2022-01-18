Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCB0C433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 20:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349405AbiARUy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 15:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiARUyy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 15:54:54 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85F9C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 12:54:53 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cx27so1096717edb.1
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 12:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g9wWvWSzWkylpKzQtit3C+OCvbCOf+IrhNi+rmECBk4=;
        b=GC2A/HaWM51cUrzJE0513uYtwRElSdZsE+ghHykd7Be71a9l6jubrQAagQiihGFKTC
         0jcpryn3NIugohZLC+fqq15hymaApswR06i/lqykkgIYv9fFNSHVuwYxligud5/BPt4+
         z6jhUxKLQ6GTZ/nb8dDUYqeMqJoX4N3Ru+UOALw4FEIlk5xlIRAcOb0UTAqBTkpbjYz2
         8W8vcwjjb6w5Ja5QZqByI7NRbNkmcf2miaC4X83YUPnyY88tv6MX0CMkrs85MbfA1+MW
         +htl6CKUUc0v8nbdiI2GEUZhHjr3UXROqylA/hyo7lGhpapg+FzElQ7OmY1cRB3Q8BvQ
         YprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9wWvWSzWkylpKzQtit3C+OCvbCOf+IrhNi+rmECBk4=;
        b=fpBLPk+/NE3neXBJm6P6pkgdGlmpai3+ZFuElIirpwSFELGo7CsyI0GaWwAOqjEJBC
         g3DwCu5Msx8gNLPTWCQiVlaH1G6jFTnM/G9S4oCfo4xwg/Gu+QaCAQAlxH9gJ4bOZLJj
         RnbGH4gZDS02x+aVjb0Sh57UCMpal68C7f+cwGQvvqtOWDqry9zWpd0fEjpzlQhnIFmS
         UAkNxy3oXLqHIh9RGJM6j7dd6f5b1xgYBhVWBogAPjPd9+GUL7b8J93TLtuUX4t0izMV
         iI537bPa/5tgARJmPvim7TLJXl5SoY9voHGly6U32yl9ewkmtRv+m42vGn6dflXKsfAX
         JsZg==
X-Gm-Message-State: AOAM531epF3UZSJrnCsyOu269xCmV1zHSWhhAVbi11gxRVGRkWbyyuOM
        CcpeOh/zXqBVTX0QUk22U1eoHHsGFAYSK2kh37M=
X-Google-Smtp-Source: ABdhPJyTYaYEras+bshvtJ27YduAF57jzrFZe/9rJh372WwSjOT/EqspViz2XPFzKlouu2oH6U7/Lbe0gyEnnhdjlXY=
X-Received: by 2002:a05:6402:5212:: with SMTP id s18mr28344130edd.359.1642539292329;
 Tue, 18 Jan 2022 12:54:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com> <cover.1642527965.git.jonathantanmy@google.com>
In-Reply-To: <cover.1642527965.git.jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 18 Jan 2022 12:54:40 -0800
Message-ID: <CABPp-BE+CCqZxSZnhn7drqYsA9XhqGaE++kPwRiAtbm4pvSFVA@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] Conditional config includes based on remote URL
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 18, 2022 at 9:47 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Thanks everyone for your review. v8 follows Elijah Newren's comments
> about making URLs more identifiable in tests, and also including an
> example in documentation.

Thanks for that; this version looks good to me.

> Jonathan Tan (2):
>   config: make git_config_include() static
>   config: include file if remote URL matches a glob
>
>  Documentation/config.txt |  35 +++++++++++
>  config.c                 | 132 ++++++++++++++++++++++++++++++++++++---
>  config.h                 |  46 ++++----------
>  t/t1300-config.sh        | 118 ++++++++++++++++++++++++++++++++++
>  4 files changed, 290 insertions(+), 41 deletions(-)
>
> Range-diff against v7:
> 1:  b2dcae03ed = 1:  b2dcae03ed config: make git_config_include() static
> 2:  7c70089074 ! 2:  6691e39c82 config: include file if remote URL matches a glob
>     @@ Documentation/config.txt: all branches that begin with `foo/`. This is useful if
>       A few more notes on matching via `gitdir` and `gitdir/i`:
>
>        * Symlinks in `$GIT_DIR` are not resolved before matching.
>     +@@ Documentation/config.txt: Example
>     + ; currently checked out
>     + [includeIf "onbranch:foo-branch"]
>     +   path = foo.inc
>     ++
>     ++; include only if a remote with the given URL exists (note
>     ++; that such a URL may be provided later in a file or in a
>     ++; file read after this file is read, as seen in this example)
>     ++[includeIf "hasconfig:remote.*.url:https://example.com/**"]
>     ++  path = foo.inc
>     ++[remote "origin"]
>     ++  url = https://example.com/git
>     + ----
>     +
>     + Values
>
>       ## config.c ##
>      @@ config.c: struct config_include_data {
>     @@ t/t1300-config.sh: test_expect_success '--get and --get-all with --fixed-value'
>      +          that = that-is-not-included
>      +  EOF
>      +  cat >>hasremoteurlTest/.git/config <<-EOF &&
>     -+  [includeIf "hasconfig:remote.*.url:foo"]
>     ++  [includeIf "hasconfig:remote.*.url:foourl"]
>      +          path = "$(pwd)/include-this"
>     -+  [includeIf "hasconfig:remote.*.url:bar"]
>     ++  [includeIf "hasconfig:remote.*.url:barurl"]
>      +          path = "$(pwd)/dont-include-that"
>      +  [remote "foo"]
>     -+          url = foo
>     ++          url = foourl
>      +  EOF
>      +
>      +  echo this-is-included >expect-this &&
>     @@ t/t1300-config.sh: test_expect_success '--get and --get-all with --fixed-value'
>      +  EOF
>      +  cat >>hasremoteurlTest/.git/config <<-EOF &&
>      +  [remote "foo"]
>     -+          url = foo
>     ++          url = foourl
>      +  [user]
>      +          one = main-config
>      +          two = main-config
>     -+  [includeIf "hasconfig:remote.*.url:foo"]
>     ++  [includeIf "hasconfig:remote.*.url:foourl"]
>      +          path = "$(pwd)/include-two-three"
>      +  [user]
>      +          three = main-config
>     @@ t/t1300-config.sh: test_expect_success '--get and --get-all with --fixed-value'
>      +
>      +  cat >include-with-url <<-\EOF &&
>      +  [remote "bar"]
>     -+          url = bar
>     ++          url = barurl
>      +  EOF
>      +  cat >>hasremoteurlTest/.git/config <<-EOF &&
>     -+  [includeIf "hasconfig:remote.*.url:foo"]
>     ++  [includeIf "hasconfig:remote.*.url:foourl"]
>      +          path = "$(pwd)/include-with-url"
>      +  EOF
>      +
> --
> 2.34.1.703.g22d0c6ccf7-goog
>
