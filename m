Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B62C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 21:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiJGVEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 17:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJGVEg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 17:04:36 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A732F2
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 14:04:34 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id j3-20020a170902da8300b001782a6fbc87so3941746plx.5
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 14:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bm8DaORcS3pa7sY2cQ5zEk36ljPCzu09ede8Mwa70ps=;
        b=nquueH+SeUqeiy1dlraJxBl6NXLX8XoRFjQB8U/+hrNbpAPqGSl7V/ApnGTgE5L9wR
         f/sLD2fl6zohFEPbrT5T6VEmsOB1vzUqG2A+3vh7/bpvmq8cNnGSWkeQ5z8fSo1LIOGI
         NRmKrVKEhYYz36TYxSPI3PROHaiFBlPBaeh4tvrLYajcnBhWM6xOTQu/UwWbWPEVgB9j
         l/w5gJPWEtsqP5jvMXnx3iW5g7gcBXOXVPPZV8D7xLgFE2T3GF102YKi3zIRNN0Y5VVC
         gJRc3zQMcVkMPFTeQXh7R51Lo6U2PUGPfqb0v5QcR1XtxGUQDl5P+WmD/h5mudlFrapI
         atcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bm8DaORcS3pa7sY2cQ5zEk36ljPCzu09ede8Mwa70ps=;
        b=8NM/laIOlxOT/xMaZFezvUI1EygNcoIpkWzIBTgIlqrC2JabceIIF1ZHQNyYqAMYnx
         a7gDMfZ4CiWyrGUMVZq/e2+g2rq/bZQku42nqJwv0m9ONPEa+cpBpzZrppCkWTMEHD/K
         FthaBtAZkSzXdZg+c3pU9aR4UyPNHM9AMmkXQn9zKzNmmJNR8rbpiERaVGrvohIltk/F
         qWh61//0aCPwyN7KvuLXGfqWHfRa8kZY7DyL7C0rnOOPqY8alHDDZqMIGcMcwwfYWwSh
         a6Pe5kcPARGMzm1VU79V7pzXo087iME+B/lqlIryiXzlE3GUT/tFANNU2eqFOwVFjUDq
         +/Cg==
X-Gm-Message-State: ACrzQf03WD6/pEsdugph+9h3JB/WbS4XWj0d2uN8BnfC2yYwUqCszYwL
        H8brtptLUtoMNkTd1QhoRCPqA/gIz85FNg==
X-Google-Smtp-Source: AMsMyM5AH1cHTokNOlfgMge0KBcUB3DmpVWIW1CMtSqkCeI0/yb6c38yQWpjKuyRYVNR8nljyOF6L2ki63b5TA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:da81:b0:178:2663:dc8d with SMTP
 id j1-20020a170902da8100b001782663dc8dmr6676141plx.49.1665176673718; Fri, 07
 Oct 2022 14:04:33 -0700 (PDT)
Date:   Fri, 07 Oct 2022 14:04:25 -0700
In-Reply-To: <20221007085334-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
References: <20221007060713-mutt-send-email-mst@kernel.org>
 <221007.86wn9bq458.gmgdl@evledraar.gmail.com> <20221007085334-mutt-send-email-mst@kernel.org>
Message-ID: <kl6lpmf3wdk6.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: sudmodule.<name>.recurse ignored
From:   Glen Choo <chooglen@google.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason" 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Fri, Oct 07, 2022 at 01:09:39PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> On Fri, Oct 07 2022, Michael S. Tsirkin wrote:
>>=20
>> > THE CONFIGURATION OF SUBMODULES
>> >        Submodule operations can be configured using the following mech=
anisms (from highest to lowest precedence):
>> >
>> >        =E2=80=A2   The command line for those commands that support ta=
king submodules as part of their pathspecs. Most commands have a boolean
>> >            flag --recurse-submodules which specify whether to recurse =
into submodules. Examples are grep and checkout. Some commands
>> >            take enums, such as fetch and push, where you can specify h=
ow submodules are affected.
>> >
>> >        =E2=80=A2   The configuration inside the submodule. This includ=
es $GIT_DIR/config in the submodule, but also settings in the tree such
>> >            as a .gitattributes or .gitignore files that specify behavi=
or of commands inside the submodule.
>> >
>> >            For example an effect from the submodule=E2=80=99s .gitigno=
re file would be observed when you run git status
>> >            --ignore-submodules=3Dnone in the superproject. This collec=
ts information from the submodule=E2=80=99s working directory by running
>> >            status in the submodule while paying attention to the .giti=
gnore file of the submodule.
>> >
>> >            The submodule=E2=80=99s $GIT_DIR/config file would come int=
o play when running git push --recurse-submodules=3Dcheck in the
>> >            superproject, as this would check if the submodule has any =
changes not published to any remote. The remotes are configured
>> >            in the submodule as usual in the $GIT_DIR/config file.
>> >
>> >        =E2=80=A2   The configuration file $GIT_DIR/config in the super=
project. Git only recurses into active submodules (see "ACTIVE
>> >            SUBMODULES" section below).
>> >
>> >            If the submodule is not yet initialized, then the configura=
tion inside the submodule does not exist yet, so where to obtain
>> >            the submodule from is configured here for example.
>> >
>> >        =E2=80=A2   The .gitmodules file inside the superproject. A pro=
ject usually uses this file to suggest defaults for the upstream
>> >            collection of repositories for the mapping that is required=
 between a submodule=E2=80=99s name and its path.
>> >
>> >            This file mainly serves as the mapping between the name and=
 path of submodules in the superproject, such that the
>> >            submodule=E2=80=99s Git directory can be located.
>> >
>> >            If the submodule has never been initialized, this is the on=
ly place where submodule configuration is found. It serves as
>> >            the last fallback to specify where to obtain the submodule =
from.
>> >
>> >
>> > However, when we are talking about the recurse attribute, it is
>> > not taken from .gitmodules - only command line and .git/config seem
>> > to be consulted.
>> > Is this a bug or a feature?
>>=20
>> It's a (security) feature. We have had disussions[1] about how to safely
>> read in-repo config, but we are very far away from that becoming a
>> reality (if it ever happens).
>>=20
>> If we read this from the .gitmodules the repo could change how you
>> interact with your submodules.
>>=20
>> 1. https://lore.kernel.org/git/YzXwZQbM69eNJfm7@nand.local/
>
> Hmm. Well we have a bunch of attributes there. Why this one? What did I m=
iss?

I couldn't find the `submodule.<name>.recurse` you referenced in your
email subject, so I'll assume we're talking about `submodule.recurse`
here. A simple reason would be that `submodule.recurse` is not specific
to a single submodule so it does not come from .gitmodules. .gitmodules
is a way of providing metadata for that submodules need to work
correctly, e.g.:

- where to get the submodule from during a fetch/clone, e.g.
  `submodule.<name>.url`, `submodule.<name>.branch`
- information needed for submodules to work correctly, e.g.
  `submodule.<name>.path`
- default config that gets populated in .git/config via `git submodule
  init`, e.g. `submodule.<name>.update`,
  `submodule.<name>.fetchRecurseSubmodules`

With respect to config, the general stance is that .gitmodules is meant
to provide defaults for .git/config and _not_ to be read directly (see
=C3=86var's answer). There are some very limited cases where config is read
directly from .gitmodules, but that approach is very frowned upon and
it's unlikely that we'll add more of them in the future.

>
> --=20
> MST
