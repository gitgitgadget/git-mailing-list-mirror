Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222CCC433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 08:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7F2023131
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 08:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbhATIL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 03:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbhATIJq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 03:09:46 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A472C0617A2
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 00:07:48 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id r12so20878334ejb.9
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 00:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=8xHo15CogmNjWuTjEwo0gOOT5RDZ9/FHgUNgkVM90PI=;
        b=m3NQZb0I9n5fZniaTXMKg9k4lzWQqDEo2gKbB9RAfdYK6mv15b1alXaZ4r4g0HvvlK
         hGpczgudPdeiz4j1z/6W1bbJFjrCCblSAgY+SyNlQ5YrU6YPhptGW8s57owpOYto4HXD
         XH57SUHWnFH0v753wbYN6uAtPCRMWQVENQQpbMGrN1pewThosr/JP8QBMDqSrYxSNo9b
         p5updOpjKYCjnGR8ddGnAF3er61JNJ9UPr/umbI+pzMFyZQ3jdqfg54t84GeSByZQPH+
         5Vr7eurn3Ku4Z0vUSP2XpSG/XB3lO5+4dHfiFhpBsYYiloPZQO80PfdRLULM22n1E+/G
         ui6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=8xHo15CogmNjWuTjEwo0gOOT5RDZ9/FHgUNgkVM90PI=;
        b=ah7ZMBppgtufptiZhPpmxWNGwHEJuQ4ocWgCXnV/LafWT2ob+YrGH9a+i51zFtEZxc
         y5h9+YtZImj4lEpX7+eVC/4cxUBBmcSqtfvudeM2yPC+Y2b7t/AH9eySiXFLRzEmSHUH
         FvXQWT7gNbT60fxF0yGFqDo8hTM+mTH6YudDX8zZkPUKjIOgn91BtdXcsWy6WBSvkj9Z
         PqSGsP2S1MPNs23v2VM5IMsvzX8MR8wvCWS//fFOtzY6Y52O+4x3hbwnwQTKOioquK/C
         nJjy+SeZXRbBHgEbUVfd6mXEaTToLrTzKKk+7ByGNRE219zvXgxDK7xcJslqfcUhzLIg
         zQjg==
X-Gm-Message-State: AOAM532CAlm0OUXf90kqeHLr7uHi+nKXZ4XJT44RWe7iBxHS2ZvbxuB2
        Y3Ofg5rfZA/9i4+ZdBzqbFE=
X-Google-Smtp-Source: ABdhPJwYqbfevvsBYokFS7sSgOoThFCW1GYIGkvQlErLsy+fMNPyBfp3RJGcBgxpj9DPGmXDIdV2CQ==
X-Received: by 2002:a17:906:a2c5:: with SMTP id by5mr5568346ejb.356.1611130065947;
        Wed, 20 Jan 2021 00:07:45 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id g21sm664961edh.20.2021.01.20.00.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 00:07:45 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: RFC on packfile URIs and .gitmodules check
References: <20210115234300.350442-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <20210115234300.350442-1-jonathantanmy@google.com>
Date:   Wed, 20 Jan 2021 09:07:44 +0100
Message-ID: <87o8hk820f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 16 2021, Jonathan Tan wrote:

> Someone at $DAYJOB noticed that if a .gitmodules-containing tree and the
> .gitmodules blob itself are sent in 2 separate packfiles during a fetch
> (which can happen when packfile URIs are used), transfer.fsckobjects
> causes the fetch to fail. You can reproduce it as follows (as of the
> time of writing):
>
>   $ git -c fetch.uriprotocols=https -c transfer.fsckobjects=true clone https://chromium.googlesource.com/chromiumos/codesearch
>   Cloning into 'codesearch'...
>   remote: Total 2242 (delta 0), reused 2242 (delta 0)
>   Receiving objects: 100% (2242/2242), 1.77 MiB | 4.62 MiB/s, done.
>   error: object 1f155c20935ee1154a813a814f03ef2b3976680f: gitmodulesMissing: unable to read .gitmodules blob
>   fatal: fsck error in pack objects
>   fatal: index-pack failed
>
> This happens because the fsck part is currently being done in
> index-pack, which operates on one pack at a time. When index-pack sees
> the tree, it runs fsck on it (like any other object), and the fsck
> subsystem remembers the .gitmodules target (specifically, in
> gitmodules_found in fsck.c). Later, index-pack runs fsck_finish() which
> checks if the target exists, but it doesn't, so it reports the failure.
>
> One option is for fetch to do its own pass of checking all downloaded
> objects once all packfiles have been downloaded, but that seems wasteful
> as all trees would have to be re-inflated.
>
> Another option is to do it within the connectivity check instead - so,
> update rev-list and the object walking mechanism to be able to detect
> .gitmodules in trees and fsck the target blob whenever such an entry
> occurs. This has the advantage that there is no extra re-inflation,
> although it might be strange to have object walking be able to fsck.
>
> The simplest solution would be to just relax this - check the blob if it
> exists, but if it doesn't, it's OK. Some things in favor of this
> solution:
>
>  - This is something we already do in the partial clone case (although
>    it could be argued that in this case, we're already trusting the
>    server for far more than .gitmodules, so just because it's OK in the
>    partial clone case doesn't mean that it's OK in the regular case).
>
>  - Also, the commit message for this feature (from ed8b10f631 ("fsck: check
>    .gitmodules content", 2018-05-21)) gives a rationale of a newer
>    server being able to protect older clients.
>     - Servers using receive-pack (instead of fetch-pack) to obtain
>       objects would still be protected, since receive-pack still only
>       accepts one packfile at a time (and there are currently no plans
>       to expand this).
>     - Also, malicious .gitobjects files could still be crafted that pass
>       fsck checking - for example, by containing a URL (of another
>       server) that refers to a repo with a .gitobjects that would fail
>       fsck.
>
> So I would rather go with just relaxing the check, but if consensus is
> that we should still do it, I'll investigate doing it in the
> connectivity check.

Would this still behave if the $DAYJOB's packfile-uri server support was
behaving as documented in packfile-uri.txt, or just because it has
outside-spec behavior?

I.e. the spec[1] says this:

    This is the implementation: a feature, marked experimental, that
    allows the server to be configured by one or more
    `uploadpack.blobPackfileUri=<sha1> <uri>` entries. Whenever the list
    of objects to be sent is assembled, all such blobs are excluded,
    replaced with URIs. The client will download those URIs, expecting
    them to each point to packfiles containing single blobs.

Which I can't see leaving an opening for more than packfile-uri being to
serve up packfiles which each contain a single blob.

In that case it seems to me we'd be OK (but I haven't tested), because
fsck_finish() will call read_object_file() which'll try to read that
"blob from the object store when it encounters the ".gitmodules" tree,
and because we'd have already downloaded the packfile with the blob
before moving onto the main dialog.

But as we discussed on-list before[2] this isn't the way packfile-uri
actually works in the wild. It's really just sending some arbitrary data
in a pack in that URI, with a server that knows what's in that pack and
will send the rest in such a way that everything ends up being
connected.

As far as I can tell the only reason this is called "packfile URI" and
behaves this way in git.git is because of the convenience of
intrumenting pack-objects.c with an "oidset excluded_by_config" to not
stream those blobs in a pack, but it isn't how the only (I'm pretty
sure) production server implementation in the wild behaves at all.

So *poke* about the reply I had in [3] late last year. I think the first
thing worth doing here is fixing the docs so they describe how this
works. You didn't get back on that (and I also forgot about it until
this thread), but it would be nice to know what you think about the
suggested prose there.

Re-reading it I'd add something like this to the spec:

 A. That the config is called "uploadpack.blobPackfileUri" in git.git
    has nothing to do with how this is expected to behave on the
    wire. It's just to serve the narrow support pack-objects.c has for
    crafting such a pack.

 B. It's then called "packfile-uris" on the wire, nothing to do with
    blobs. Just packs with a checksum that we'll validate. An older
    versions of this spec said "[a] packfiles containing single blobs"
    but it can be any combination of blob/tree/commit data.

 C. A client is then expected to deal with any combination of data
    ordered/sliced/split up etc. in any possible way from such a
    combination of "packfile-uris" and PACK dialog, as long as the end
    result is valid.

Except that the result of this discussion will perhaps be a more narrow
definition for "C".

1. https://github.com/git/git/blob/cd8402e0fd8cfc0ec9fb10e22ffb6aabd992eae1/Documentation/technical/packfile-uri.txt#L37-L41
2. https://lore.kernel.org/git/20201125190957.1113461-1-jonathantanmy@google.com/
3. https://lore.kernel.org/git/87tut5vghw.fsf@evledraar.gmail.com/
