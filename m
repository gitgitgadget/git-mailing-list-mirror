Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB238C678DB
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 18:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbjCGSaF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 13:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjCGS3c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 13:29:32 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE99DBC8
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 10:22:58 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id ip3-20020a17090b314300b00237c16adf30so8460819pjb.5
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 10:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678213378;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5qrQsdEYpC0L9C9ALimTroR3jsuxHWwJEDHgsg0OEo=;
        b=WNUq4YAZ/TbxLlgWUB30csxdLP+Tl/C0fEilj5avDEysF5rfFRipXnp6EpN1RmWJVv
         2NS+Ru1uuDflBPdMLh6YTQQdOtREShNBoUZeVWmN9mOY45F7q1sRqoTMLjmOcM3iAcqZ
         R+64ubaeoBm6gDYcBM5Wl3aG4MolIEsM/QGilSKgi0dRRHdTNo3uTKlrWZkJwUAKh8bU
         pwLEBBBaFGhuepKdKsX9xZne/k5HKtyuhAkr0Wx5nplSdWZcx1abszIxTl4McFjg4Gmm
         DOUaJskJOwIDgr4PINh1mW3P2Q2/iEAYe0CxrPg0GwHDmEyU3BgFjKL1wrBHBWowVkOo
         IN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678213378;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F5qrQsdEYpC0L9C9ALimTroR3jsuxHWwJEDHgsg0OEo=;
        b=Cy0RlUE+1KU+Hz1qIHntZn2d4bM+JjommR7bA/wHQ4+/RZiWAFJ+lfTT7IkEOgXwvm
         rGuW1YKwTJUyoRm9dx4dacFthJcj5W4XD9ZYxCoISCQY8wVZHVVoQdR9a5GY16ZH/Jeh
         9w0p6z0SUe3yJ7itrtBKIkvWVVjK778WJkdGnBTlqu83bj66+UA/WpCus/+FlIJxLutf
         ztucxpwrJ5f7SMf7xk94f5Ky+IJg1cADooOATdGY8S/P1F+J1STvQZjj4e/VGD2PklZP
         gWcXKgdIqI3RmWDp3MbczkcfSxZFQ2d/geKqpS/nhF8syi0drrFqEAyFNvIXL3cQ8xaN
         Ky3w==
X-Gm-Message-State: AO0yUKVpJkWb07GcBJqZGqzDL8S1KV/WuFJ4jPIauv0gDeMcXZdBgDaL
        y3CidHuJohE4UdgAJIh/IYvlkCoGfWHZQg==
X-Google-Smtp-Source: AK7set+an50P2UZui0NC8Vf7kS3Vk7pp2K7of81aML71YH5aZf6hnzS135M/1XWYptBOHN6LweH5hCixl/RdxQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:90b:46d2:b0:237:ae7c:1595 with SMTP
 id jx18-20020a17090b46d200b00237ae7c1595mr5763920pjb.2.1678213377747; Tue, 07
 Mar 2023 10:22:57 -0800 (PST)
Date:   Tue, 07 Mar 2023 10:22:55 -0800
In-Reply-To: <230307.86wn3szrzu.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com> <230307.86wn3szrzu.gmgdl@evledraar.gmail.com>
Message-ID: <kl6lfsagifpc.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 0/6] [RFC] config.c: use struct for config reading state
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Mar 01 2023, Glen Choo via GitGitGadget wrote:
>
>> This series extracts the global config reading state into "struct
>> config_reader" and plumbs it through the config reading machinery. It's =
very
>> similar to how we've plumbed "struct repository" and other 'context obje=
cts'
>> in the past, except:
>>
>>  * The global state (named "the_reader") for the git process lives in a
>>    config.c static variable, and not on "the_repository". See 3/6 for th=
e
>>    rationale.
>
> I agree with the overall direction, but don't think that rationale in
> 3/6 is sufficient to go in this "the_reader" direction, as opposed to
> sticking with and extending "the_repository" approach.
>
> For orthagonal reasons (getting rid of some of the API duplication) I've
> been carrying a patch to get rid of the "configset" part of the *public*
> API, i.e. to have API users always use the "repo_config_*()" or
> "git_config_*()" variants, that patch is at:
> https://github.com/avar/git/commit/0233297a359bbda43a902dd0213aacdca82faa=
34

Those patches are probably worth sending, even if only as RFC. I found
it pretty hard to draft a substantial response without effectively doing
a full review of the patch.

> It's a bit distasteful, but that change argues that just mocking up a
> "struct repository" with a "config" member pointing to a new configset
> is better than maintaining an entirely different API just for those
> cases where we need to parse a one-off file or whatever.
>
> I think that going in that direction neatly solves the issues you're
> noting here and in your 3/6, i.e. we'd always have this in the "repo"
> object, so we'd just stick the persistent "reader" variables in the
> "struct repository"'s "config" member.

If I understand your proposal correctly, we would move the config
variables to the_repository. Then, any time a caller would like to work
with an individual file, it would init a new "struct repository" with a
clean set of config members (using repo_init_repo_blank_config() or
something) and reuse the repo_config_* API?

It is a workable solution, e.g. that approach would work around the
failures in test-tool and scalar that I observed. In the spirit of
libification, this feels like a kludge, though, since we'd be reverting
to using "struct repository" for more things instead of using more
well-scoped interfaces. IMO a better future for the config_set API would
be to move it into configset.c or something, where only users who want
the low level API would use it and everyone else would just pretend it
doesn't exist. This would be a little like libgit2's organization, where
'general config', 'config parsing' and 'in-memory config value
representations' are separate files, e.g.

  https://github.com/libgit2/libgit2/blob/main/src/libgit2/config.h
  https://github.com/libgit2/libgit2/blob/main/src/libgit2/config_parse.h
  https://github.com/libgit2/libgit2/blob/main/src/libgit2/config_entries.h

I also hesitate to put the config variables on the_repository, because
in the long term, I think "struct config_reader" can and should be
purely internal to config.c. But if we start advertising its existence
via the_repository, that might be an invitation to (ab)use that API and
make that transition harder.
