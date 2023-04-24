Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E936C77B60
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 01:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjDXBnd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Apr 2023 21:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDXBnc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2023 21:43:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BE910CC
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 18:43:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-959a3e2dc72so109494166b.2
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 18:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682300610; x=1684892610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8KDfWaGOHlEb95j/LuYNy4/nXl7N2bNGQd36UUkBq8=;
        b=KXkJtU1pR0zyYVAQzW/mDHY8IsJ1Fc4n9EBI2Pcyn42/Q938TKOSxvDILl++5xcoIt
         ieScwyOnwsvuFw1HJyU3Aq+NJ9A0mWd1nOvhDGQNP17Th64XkjaVso7QSoJ0t77nMpfP
         i6u2Y70t/9RDApjfAQYPQ4EYXUCpb6Qy/Qnt68YxMOX8zNVL2XbC8oSvisSMDBdcsH3n
         mM8x+Ky0EjA1Pnq1QjIb5PNsje7CFWekR1nytOt6HkGURNTd8QQY/qDV2Cfr9nzCvx/t
         UNVUvr3Rx6hj6Fa8n9BSFkO8vx13JgvpsTdLgk4KJ5JtYmrM2Zji+ZV08aQTtqznrtj1
         EFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682300610; x=1684892610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8KDfWaGOHlEb95j/LuYNy4/nXl7N2bNGQd36UUkBq8=;
        b=Owsjw8tV6Yx93ZJzmmkhyQN/X+8XdKNcyostcPZ9SHQGOdhJzeaFKRtxHhQqWW6gAK
         bmORvs8Pck+8q+4ThSOaWTto9n9EVQWSU6weGfP8HCxgqVARrAACk8NWzQ2utUgHJhn1
         IUNrCPku18wIUX6y23UeCmPNPa7EJ0ot79RtZ6ONGb9pTNKdbpfwLPSucbFXWSNG+Ova
         gEHaA28gUO/hqvB5zMBl3oDP8KTKduSKX9ulUijVw/uNsBXzB7qr4JFX6n8dgpHbd1Tq
         7lxEEgDlgPEDb5Pngbs924SHsHfihLLp503/d8bvPMPILisdXJ8x02MJS+BX/YW5lprr
         /Cow==
X-Gm-Message-State: AAQBX9cWzMQCsY4KzRYQpGgj3ExoWc3X8KvJZkC/mQcEdZa9vTHOq3Ky
        gUzE1schPy8tR0ty8du485420FRZSG+e4aexoAWGsmsstyI=
X-Google-Smtp-Source: AKy350b8KFYZIPnrsIhBBlmiOKf1k5/wnyPMUq4HPaUXa+c1L76zfoI20BSCDYFCwXG2GeZ5WoU8xmiTPj+oO3QMbvU=
X-Received: by 2002:a17:906:8464:b0:953:57a1:55e1 with SMTP id
 hx4-20020a170906846400b0095357a155e1mr8398980ejc.62.1682300609788; Sun, 23
 Apr 2023 18:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
In-Reply-To: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sun, 23 Apr 2023 18:43:18 -0700
Message-ID: <CAPx1Gvdc6bqzt2PpqD1Z4e5w+b=8gZhUSyfUQC1n8QazdBacEw@mail.gmail.com>
Subject: Re: Proposal: tell git a file has been renamed
To:     Jeremy Morton <admin@game-point.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(By the way, apologies for the stuttering "gitt" typos that seem
to keep creeping into my messages here. I'm not sure what's
causing them -- I make a lot of typos but this is abnormal!)

On Sat, Apr 22, 2023 at 12:22=E2=80=AFPM Jeremy Morton <admin@game-point.ne=
t> wrote:

> [renames are a problem]

I have long wondered if there was a way to improve this
experience myself.

(I also note that most of the followup messages up to this point
have missed the point.  It's true that you can run `git mv` and
`git commit`, but you've already said that this becomes
particularly painful when you realize that it's appropriate *after
the fact*, when you've already made intermediate commits and/or
staged changes or whatever.)

> The standard answer for this is to rename the file in one commit, then
> make the changes.  That's fine if you know ahead of time you'll want
> to do this.  However it's a total PITA if you have a bunch of changes
> and you realize that a rename has caused this problem.  You now have
> to back out your changes to the renamed file, add the rename, commit
> it, then re-apply the changes.
>
> Could a command be added to git that means you tell Git that counts as
> a file rename?  Git would add a marker to the staging area that the
> file has been renamed, and upon commit, would first generate an
> additional commit for each rename before generating the main commit,
> ensuring the rename operation counts as an actual rename, and the
> content's history is maintained.

The index *currently* has no room to store anything like this: it
is, in effect, just the proposed next commit, stored as a
flattened tree.  There are, however, extra marker records that
can be added.  So:

If `git mv` (or a new command) had a flag to say "make a special
index entry so that the next `git commit` does a double commit",
we could in fact make this work.  Alternatively, we could have a
command -- similar to `git commit --only` in effect -- that uses
the current (HEAD) commit to construct a renames-only commit, in
which 100%-identical-file matching would (in general) find the
desired renames -- and make it, perhaps also co-ordinating with
`git mv` of existing files in the index.  (I'd also like to have
`git mv --after`, in the same vein as `hg mv --after`; I long ago
wrote a cheesy script to achieve this, but it would be nice to
have a proper command.)

On top of this, it might be nice to have a standardized commit
message and/or other marker (in the commit header?) for a "rename-
only" commit, which this kind of extra-rename-commit operation
would use.  Then `git log` and `git blame` and other commands
could easily detect such commits and default to an automatic
`--follow` style following, and `git log` might be allowed to omit
the *display* of such a commit by default, by showing all the
renames as renames in the subsequent commit (though this would
presumably require an internal verification step to check for
spoofed renames that are not in fact rename-only operations).

In any case, this *idea* is easy, like many ideas.  It really
comes down to implementation.  If someone thinks this is a great
idea, someone (perhaps me) should work on *implementing* it. :-)

Chris
