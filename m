Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080E2C77B7D
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjERUPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjERUPj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:15:39 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8262210CA
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:15:37 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-64d138bd73aso760416b3a.0
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684440937; x=1687032937;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YbnBH8Cm2ZaYuRKDj8SaOUH24mbMMV6e9MTNuIoLE6g=;
        b=5zkHGLYGEvUiOjjhZ9Z19iwVa450zYRjrbFAL1Ewe5ii29Qy6jlQN7xi2agAqogfGu
         M6SqAFtJGK42Xdy/xlG7jDPumLLAjmjjwRsNZRru4+iEaE4KtIhL8meLjfzh2Vxgc7oX
         i4akdvRRJdwN3hLzHzKdW/5NGfMUi6maJij8lA3qpqbb74JScj1SGctJ63fwYix9B7ky
         DABMaaAe+r0WRc0iINcJrC/HafY1N99lPeeTTRUMAR+lS0+qCoDWEyeurVG/pyechlXH
         oUvlPKqQ6BSodXjigRkxepOTp/pLj4e8ZpbNXjdhiAXeeTED6+LMsLENlp/28g+07bNo
         CFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440937; x=1687032937;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YbnBH8Cm2ZaYuRKDj8SaOUH24mbMMV6e9MTNuIoLE6g=;
        b=IhlIgv2SPOzwySn07QBYPrAzoWEVe3do3IHvZSAR2zmYvK98AtJZgeJI8ATOmIxKcs
         VHaSpPZfWjITHr3mcLUvx+5Jkg9NqDGCt9DlnCZ7YP5pmVREGv4xGQSu/7xQKCcVa1q1
         GJOKrek9e+blrpHjhb+vxCWcfeQKP8LdlOtBcYscjDlQwajOy46nUrjrbjNq7JBWRj9Z
         4Hh5ZE/Rc3KqYcFvIMGVdQNNWUbMcBT0z7PR5pgKZI4BQ4tdXd51FPbQllZP2YR1qBJT
         yQzWEJqM88rRpDY7yoNEnG09sLEguSASn5oo+rqYZYHJuwdt5ZeDNlXneD5vd8aCk+LG
         jBXQ==
X-Gm-Message-State: AC+VfDzFFtu0bHqZnT1FGei7HeCvjGRAUv/uuat4mvUFBsUe7wUrTmIc
        +lY37uN2a1dooPaPSkWtzsZpBxCmrVlneA==
X-Google-Smtp-Source: ACHHUZ7Fjdu6ADEwKeBezUbmmL8RkRW7YVXj6uwFDDqtenPSTd4DzCVbFKXAulr5jUruHGwvPQOYKkRcT2Uw0Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2d02:b0:63b:234e:d641 with SMTP
 id fa2-20020a056a002d0200b0063b234ed641mr7260pfb.4.1684440937035; Thu, 18 May
 2023 13:15:37 -0700 (PDT)
Date:   Thu, 18 May 2023 13:15:26 -0700
In-Reply-To: <20230517-unit-tests-v2-v2-2-21b5b60f4b32@google.com>
Mime-Version: 1.0
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com> <20230517-unit-tests-v2-v2-2-21b5b60f4b32@google.com>
Message-ID: <kl6lzg61xuox.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH RFC v2 2/4] unit tests: Add a project plan document
From:   Glen Choo <chooglen@google.com>
To:     steadmon@google.com, git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>, calvinwan@gmail.com,
        szeder.dev@gmail.com, phillip.wood123@gmail.com, avarab@gmail.com,
        gitster@pobox.com, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

steadmon@google.com writes:

> Describe what we hope to accomplish by implementing unit tests, and
> explain some open questions and milestones.

Thanks! I found this very helpful.

> diff --git a/Documentation/technical/unit-tests.txt b/Documentation/techn=
ical/unit-tests.txt
> new file mode 100644
> index 0000000000..7c575e6ef7
> --- /dev/null
> +++ b/Documentation/technical/unit-tests.txt
> @@ -0,0 +1,47 @@
> +=3D Unit Testing
> +
> +In our current testing environment, we spend a significant amount of eff=
ort
> +crafting end-to-end tests for error conditions that could easily be capt=
ured by
> +unit tests (or we simply forgo some hard-to-setup and rare error conditi=
ons).
> +Unit tests additionally provide stability to the codebase and can simpli=
fy
> +debugging through isolation. Writing unit tests in pure C, rather than w=
ith our
> +current shell/test-tool helper setup, simplifies test setup, simplifies =
passing
> +data around (no shell-isms required), and reduces testing runtime by not
> +spawning a separate process for every test invocation.

The stated goals make sense to me, and I believe they are worth
restating. I believe this is mostly taken from Calvin's v1 cover letter

  https://lore.kernel.org/git/20230427175007.902278-1-calvinwan@google.com

so perhaps he should receive some writing credit in a commit trailer
(Helped-by?).

> +=3D=3D Open questions
> +
> +=3D=3D=3D TAP harness
> +
> +We'll need to decide on a TAP harness. The C TAP library is easy to inte=
grate,
> +but has a few drawbacks:
> +* (copy objections from lore thread)
> +* We may need to carry local patches against C TAP. We'll need to decide=
 how to
> +  manage these. We could vendor the code in and modify them directly, or=
 use a
> +  submodule (but then we'll need to decide on where to host the submodul=
e with
> +  our patches on top).
> +
> +Phillip Wood has also proposed a new implementation of a TAP harness (li=
nked
> +above). While it hasn't been thoroughly reviewed yet, it looks to suppor=
t a few
> +nice features that C TAP does not, e.g. lazy test plans and skippable te=
sts.

A third option would be to pick another, more mature third party testing
library. As I mentioned in

  https://lore.kernel.org/git/kl6lpm76zcg7.fsf@chooglen-macbookpro.roam.cor=
p.google.com

my primary concern is the maintainability and extensibility of a third
party library that (no offense to the original author) is not used very
widely, is relatively underdocumented, is missing features that we want,
and whose maintenance policy is relatively unknown to us. I'm not
opposed to taking in a third party testing framework, but we need to be
sure that we can rely on it instead of being something that requires
active upkeep.

I don't what sorts of testing libraries exist for C or how widely they
are used, but a quick web search gives some candidates that seem like
plausible alternatives to C TAP Harness:

- cmocka https://cmocka.org/ supports TAP, assert macros and mocking,
  and is used by other projects (their website indicates Samba, OpenVPN,
  etc). The documentation is a bit lacking IMO. It's apparently a fork
  of cmockery, which I'm not familiar with.

- Check https://libcheck.github.io/check/ supports TAP and has
  relatively good documentation, though the last release seems to have
  been 3 years ago.

- =C2=B5nit https://nemequ.github.io/munit/ has a shiny website with nice
  docs (and a handy list of other unit test frameworks we can look at).
  The last release also seems to be ~3 years ago. Not sure if this
  supports TAP.

For flexibility, I also think it's reasonable for us to roll our own
testing library. I think it is perfectly fine for our unit test
framework to be suboptimal at the beginning, but owning the code makes
it relatively easy to fix bugs and extend it to our liking.
