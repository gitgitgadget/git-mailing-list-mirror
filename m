Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC88C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 12:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D88A60E05
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 12:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhJOMeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 08:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhJOMdv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 08:33:51 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2122AC061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 05:31:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y12so38607998eda.4
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 05:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=z9Gvekh7h2zINf6+c8EP8ghM9E7A3HjNBPeywzHSQZo=;
        b=DlGkuWbqTQ+L1gIXsXdYg9TbjSG2ihiikuRietuh23xY+TiHAu2NBN4+3VETyEptjF
         O5Dc9WZJNcdo8xo79v7oi020LP3TNno03JamJKQOnToruAq002Sh2l0etW/e+0h3uAlD
         JVwrfpeIz4UP/IFNAQ3Lc8dh0eppvTtzCFo4Zv6gexUo9QrLfSuhon6Jyq/9lrpz4MqV
         m49eqoXMawWJOdo3un6g311aF334Vfc1/Z8V7JWBiQXYs5I5MuV9O2PynWRcroSSXReY
         0vySpeaNP76LoqbSwOydOjj9i4LYzfIxoYXBSZQlRpAPAl1nPevL+11s5aIWDXAYWRc8
         nlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=z9Gvekh7h2zINf6+c8EP8ghM9E7A3HjNBPeywzHSQZo=;
        b=gi+vJVcVScixboA8Sq7l1aCPElo2P8luhF7sHjih2HDZ2x2rz8M4+zIMLMBH+XoZV9
         NrzDpK4peVdePm/u03CTHOCSZ9M6fOmB7+uO94nCn543/tPJakLFS61cywpp3CbXD77p
         h4acuJeG/Lv/5OanL2t2FL05I/OxV0ZW0MIQH5L8ol9fSakFzQUlFNXd2MpxHsMJH+3N
         xVCh0v+VvzyKvMvFZ3LkRdVxTFI8Fr6kL4cd2ygZJ42kdpyMyREWkZ/jw6/GE64HPdOF
         rfDXq3houQNZBIYnE0uqvYbdyGY52CVXQKRv8LFXelt9CASneK852JS6AmlElevKa2aX
         X7NQ==
X-Gm-Message-State: AOAM533XVfvm506tcgMg5dj5MubfwRbosE7ByuVIu12tKv2P9Rs2QKa0
        dSWRKOZlRvG2bAxxMfLGRoRfkFUIu8qwQQ==
X-Google-Smtp-Source: ABdhPJz1aafPbGZb7ofVX5rRdVWZW6NOEX9eTeybg1vNY9KT56XypZ84j5+Q9OdwyajADeHc1iVNFw==
X-Received: by 2002:a17:906:998d:: with SMTP id af13mr6371494ejc.568.1634301103467;
        Fri, 15 Oct 2021 05:31:43 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y8sm4108318ejm.104.2021.10.15.05.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 05:31:42 -0700 (PDT)
Received: from avar by evledraar with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mbMNC-0002rk-Du;
        Fri, 15 Oct 2021 14:31:42 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 0/5] Builtin FSMonitor Part 2
Date:   Fri, 15 Oct 2021 14:03:50 +0200
References: <pull.1041.v2.git.1633614772.gitgitgadget@gmail.com>
 <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
Message-ID: <87lf2ueafl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 13 2021, Jeff Hostetler via GitGitGadget wrote:

> Here is V3 of Part 2 of my Builtin FSMonitor series. Like V2, it is built
> upon "next" because it requires "ab/repo-settings-cleanup" and
> "jh/builtin-fsmonitor-part1" series.

FYI: Both of those have landed, so a next iteration of this can be built
on "master".

> V3 removes the explicit initialization of r->repo_settings->fsmonitor in
> repo-settings.c as requested. It also includes a more detailed commit
> message for the 3 commit to explain the rationale for putting fsmonitor
> settings in its own source file rather than adding it repo-settings.c

This series breaks with the "make check-docs" target, which as an aside
is broken because of recent changes of mine, so CI didn't catch this
(I'll submit a series to fix it):

    config/core.txt:95: error: git-fsmonitor--daemon[1]: link outside of our own docs, shown with 'HERE' below:
    config/core.txt:95:     'daemon for this working directory (linkgit:git-fsmonitor--daemon[1]' <-- HERE
    git-update-index.txt:502: error: git-fsmonitor--daemon[1]: link outside of our own docs, shown with 'HERE' below:
    git-update-index.txt:502:       'linkgit:git-fsmonitor--daemon[1]' <-- HERE

But that broken-ness points to a more general issue, which is that it's
not just a broken link, but that docs in this series are referring to a
manpage that doesn't exist yet.

I was going to check out some of the semantics of
core.useBuiltinfsMonitor that I commented on in earlier rounds, but I
see that there's no tests for it, probably for similar reasons as there
not being a git-fsmonitor--daemon yet: It's all (hopefully) in some
yet-to-come series.

I'm all for this being split up in steps from the 30-something patches
it was before, but if we're making forward-references to docs that don't
exist yet, adding ~100 line *.c files that seemingly aren't used at all
yet etc., the split-up seems to be a bit too aggressive.

E.g. the below diff seems to have all tests passing, so
core.usebuiltinfsmonitor is unused still? There's also large amounts of
code ifdef'd away under HAVE_FSMONITOR_DAEMON_BACKEND, but no other
in-tree reference to it?

AFAICT that's going to be used in the future. So seemingly something
that'll only be used in the series after this? I.e. this seems to have
stopped at around part 7/28 of a previous submission, but digging in the
archive e.g. HAVE_FSMONITOR_DAEMON_BACKEND semes to be first used in
step 11/28 of that[1].

Sorry to be party pooper again, I really did try to review this, but
just found that I couldn't, since so much of it seems to be a
forward-reference to some future state.

Isn't there a way to re-arrange this so that the "teach daemon XYZ
command" around steps 13-14/28 of your previous series comes before
references in the docs to the daemon that doesn't exist yet (5/5 here),
or there's perhaps some of the config scaffolding, but
e.g. "core.usebuiltinfsmonitor" comes along with the later change that
uses it?

Or just make this "part 2" series larger than 5 patches, so that it
manages to tell some holistic story, and the various bits are used at
the end?

Even so it would be a lot easier to follow if e.g. a patch using a new
"core.usebuiltinfsmonitor" variable doesn't come at say step 11/20, with
that variable having been added at a 3/20. I.e. maybe 3/20 can have the
scaffolding, but the part that adds the "core.usebuiltinfsmonitor"
support either immediately precedes its use, or is squashed into the
relevant commit that needs it. Ditto docs for so-far-not-existing things
etc.

Thanks! And hopefully this helps.

1. https://lore.kernel.org/git/49f9e2e3d49ce6e7b56839bf44535f271216abeb.1621691828.git.gitgitgadget@gmail.com/

diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 2770266f5ee..2c479d4f36b 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -35,19 +35,6 @@ void fsm_settings__set_disabled(struct repository *r)
 	FREE_AND_NULL(s->hook_path);
 }
 
-static int check_for_ipc(struct repository *r)
-{
-	int value;
-
-	if (!repo_config_get_bool(r, "core.usebuiltinfsmonitor", &value) &&
-	    value) {
-		fsm_settings__set_ipc(r);
-		return 1;
-	}
-
-	return 0;
-}
-
 static int check_for_hook(struct repository *r)
 {
 	const char *const_str;
@@ -71,9 +58,6 @@ static void lookup_fsmonitor_settings(struct repository *r)
 
 	r->settings.fsmonitor = s;
 
-	if (check_for_ipc(r))
-		return;
-
 	if (check_for_hook(r))
 		return;
 
