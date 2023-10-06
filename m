Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F43AE81E1B
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 17:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjJFRUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 13:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjJFRUa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 13:20:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A3CBF
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 10:20:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81646fcf3eso3331542276.0
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 10:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696612825; x=1697217625; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=meyAnGDbuQpvOhJOtRP8HhGqbeZluh8ATZLfycX9KPM=;
        b=Lf1BJ7WKgrdE5evZOKCY5EGtKdaJaafgJ/hZGaYK6wT2/BkpRqR2reIR6y8liAXKGP
         xk/8yIHsiMnyzojdvMchdeySPepfZyq7L5Zq2iU2ZpJbL4WeUpoOEw/0q+LvY0n14GiG
         SjG8/xFBEhKCeEAX7SAdLF6CFhXnbStsOHZ/t43LtAaqW7/l0amqVch9aIS8GKyWmPue
         4xvLNfvMosEVMiq5ICyrXdTTZJK3HIgcOKrDNL2OywL9oAXtZAxh2lS6JfOty77KhAXH
         0qCC4z+FByS1ZMEPN9qQDhhNs7CTxxjf6a93XBcUTCyaYowgCv9muiYAZgJZaqS/5xzG
         9CcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696612825; x=1697217625;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=meyAnGDbuQpvOhJOtRP8HhGqbeZluh8ATZLfycX9KPM=;
        b=cLy6Y6iVwA2tmI/Lr3EaAxL0dps3YwMGe1n9M73JQhuSGw4qrgakhUtzc9Vk1EhNVc
         eTtJ9I0Eq7H4Sz+j1fxOpamJ94egwQo2IaOtprQl4QlSvcWv4I+4JdJF7O69UepIw4ZZ
         3+gsCFA21wxUoFS3+OZ73ViZLQl7L6IFLfY2dL8e+QeETAA5+gRDXXAURG4Y6fIcVyf1
         q75HcIHq46roxUHUtRoU8mVfMb2ObaLgvwbk5OJUs6flYW0L20XzuRo121JgJmf6OJhr
         LJureQN4qWiLoXp7K5mb98lZgptZFhJ1ovX8qgvV9gwyKZtCUmm0JKex63UnJKYuXG5k
         ua/Q==
X-Gm-Message-State: AOJu0Yz0AiGsxW3yPbP0Ymhka8LTcq1sV43j2NKPYSftkJGFQBll9vLr
        2Iy+zCwXlCfgNPXtmvA5lSEZb7qQ2B/o110zi63w
X-Google-Smtp-Source: AGHT+IHFoBIxT36pHNyZcLEcu3mCoeotdqV2Re/LOSyZE6PvGw6S+YrxOXjrz60YTc8ytHdMpfJxWcR2G+AEP+1cokhP
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:3bbe:7224:c3d6:1ff1])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:180e:b0:d77:984e:c770 with
 SMTP id cf14-20020a056902180e00b00d77984ec770mr150658ybb.5.1696612824877;
 Fri, 06 Oct 2023 10:20:24 -0700 (PDT)
Date:   Fri,  6 Oct 2023 10:20:22 -0700
In-Reply-To: <xmqqv8bmlzoi.fsf@gitster.g>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231006172022.1153171-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 1/2] attr: add attr.tree for setting the treeish to
 read attributes from
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> As this adds a new call to git_config_get_string(), which will only
> be available by including <config.h>, a merge-fix into 'seen' of
> this topic needs to revert what b1bda751 (parse: separate out
> parsing functions from config.h, 2023-09-29) did, which made this
> file include only <parse.h>.
> 
> As this configuration variable was invented to improve the way the
> attribute source tree is supported by emulating how mailmap.blob is
> done, it deserves a bit of comparison.
> 
> The way mailmap.c does this is not have any code that reads or
> parses configuration in mailmap.c (which is a rather library-ish
> place), and leaves it up to callers to pre-populate the global
> variable git_mailmap_blob with config.c:git_default_config().  That
> way, they do not need to include <config.h> (nor <parse.h>) that is
> closer to the UI layer.  I am wondering why we are not doing the
> same, and instead making an ad-hoc call to git_config_get_string()
> in this code, and if it is a good direction to move the codebase to
> (in which case we may want to make sure that the same pattern is
> followed in other places).
> 
> Folks interested in libification, as to the direction of that
> effort, what's your plan on where to draw a line between "library"
> and "userland"?  Should library-ish code be allowed to call
> git_config_anything()?  I somehow suspect that it might be cleaner
> if they didn't, and instead have the user of the "attr" module to
> supply the necessary values from outside.

I think that ideally library-ish code shouldn't be allowed to call
config, yes. However I think what's practical would be for libraries
that use very few config variables to get the necessary values from
outside, and libraries that use many config variables (e.g. fetch, if it
becomes a library) to call config.

> On the other hand, once the part we have historically called
> "config" API gets a reasonably solid abstraction so that they become
> pluggable and replaceable, random ad-hoc calls from library code
> outside the "config" library code may not be a huge problem, as long
> as we plumb the necessary object handles around (so "attr" library
> would need to be told which "config" backend is in use, probably in
> the form of a struct that holds the various states in to replace
> the current use of globals, plus a vtable to point at
> implementations of the "config" service, and git_config_get_string()
> call in such a truly libified world would grab the value of the named
> variable transparently from whichever "config" backend is currently
> in use).

This is true, but if we were ever to use the attr library elsewhere
(whether in the git.git repo itself to unit test this library, or
in another software project), we would need to supply a mock/stub of
config. If attr uses very few config variables, I think it's clearer if
it takes in the information from outside.
