Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D28AC433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F7360C3D
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhBRMfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 07:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbhBRL6o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 06:58:44 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93007C0613D6
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 03:31:44 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id g3so3854759edb.11
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 03:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=k/gFqJMTLNEMUQP9G11/bLvujEjMc49eCwiIXxSDbaM=;
        b=GiBdvJZzdEKCbwHY8H0GEo6QlcKFJQ7B4b3bEPFy5hhqLBJw1rd6vntbccmHLaHiNx
         jHO8SGanu1jXrSkQkrYjL4tnoxcI6nJsHDeLrUsXjVQaS709zEe5D9hkhLuARUnbU1CP
         GgRrp8EO8goAOTzhHl7SipNJzH9u6iqqFIu/TpSRp+nrhsG2o9bdNPSMZe+Kh+QtXLZp
         ZsPnz7QU3Qj9GK1EKanvVhoV9V2lQhuBzlNAhO+rkPdTcLy2c7VLL/tPS+7iFUgQbYkj
         8yLJotMMl1NkR117R2+dNzAY7lKJXTOPRWiNNkzJ7yNgfsxKlWyIDektHXSQlAqYaBd8
         5tKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=k/gFqJMTLNEMUQP9G11/bLvujEjMc49eCwiIXxSDbaM=;
        b=ElvGj3I8n1ElBwOxnNyt/8XAkdRY3KKeRQv4UWJHqLnoNBry9YH39Pl67xh/7Uushy
         HGwF9sMHYKYRGgp34+9jm5EVkgaKuqmTotpzb8zdhXD/6KonqDehiHzAnZhqWtFm2fSW
         FfGomxzG+2xytLNj4cy/5IumnwA2XROxT3+My7sqO5aQLQ7Kok7AqKfXJDLR58JG7JFb
         giKnAeZKI9xQCLoKQJcTx6x/sOxRazq9HUBnnXUnZPO80XsAxBLK8v4hPBWcYViIfCuI
         BOpNS7lY5k02pjRkfFobjlJ+lB3VyxtUzls5BF1ZdKH5HSbpKzVNHhYn1h2DDF+QnFSo
         7Npg==
X-Gm-Message-State: AOAM531pr3YMEYXMkYFFkLQW4cnkWmpzA1CSFQMJvg+JvAtO9DFSO5Iw
        p08wSoKgKK8jHb6nDp46v18=
X-Google-Smtp-Source: ABdhPJzckL8iudvscPCx7Ih1PHiN/Bp8P7TOAisWCoIUza/n7eY4WUfrsmPn55HibEHFZE3jVsUS8w==
X-Received: by 2002:a05:6402:105a:: with SMTP id e26mr3620333edu.60.1613647903120;
        Thu, 18 Feb 2021 03:31:43 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id ga5sm2368379ejb.114.2021.02.18.03.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 03:31:41 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/4] Check .gitmodules when using packfile URIs
References: <xmqqa6sy26gq.fsf@gitster.c.googlers.com>
 <20210128003536.3874866-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210128003536.3874866-1-jonathantanmy@google.com>
Date:   Thu, 18 Feb 2021 12:31:40 +0100
Message-ID: <87r1ld8vdv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 28 2021, Jonathan Tan wrote:

>> Jonathan Tan <jonathantanmy@google.com> writes:
>> 
>> > As part of this, index-pack has to output (1) the hash that goes into
>> > the name of the .pack/.idx file and (2) the hashes of all dangling
>> > .gitmodules. I just had (2) come after (1). If anyone has a better idea,
>> > I'm interested.
>> 
>> I have this feeling that the "blobs that need to be validated across
>> packs" will *not* be the last enhancement we'd need to make to the
>> output from index-pack to allow richer communication between it and
>> its invoker.  While there is no reason to change how the first line
>> of the output looks like, we'd probably want to make sure that the
>> future versions of Git can easily tell "list of blobs that require
>> further validation" from other additional information.
>> 
>> I am not comfortable to recommend "ok, then let's add a delimiter
>> line '---\n' if/when we need to have something after the list of
>> blobs and append more stuff in future versions of Git", because we
>> may find need to emit new kinds of info before the list of blobs
>> that needs further validation, for example, in future versions of
>> Git.
>> 
>> Having said all that, the internal communication between the
>> index-pack and its caller do not need as much care about
>> compatibility across versions as output visible to end-users, so
>> when a future version of Git needs to send different kinds of
>> information in different order from what you created here, we can do
>> so pretty much freely, I would guess.
>
> Yeah, that's what I thought too - since this is an internal interface,
> we can evolve them in lockstep. If we're really worried about the Git
> binaries (on a user's system) getting out of sync, 

I'm thinking in reading "getting out of sync" that you may be missing an
aspect of the issue here.

We're not talking about some abnormal error in some packaging system,
but how we'd expect all installations of git to behave if you update
them with *.rpm, *.deb etc, e.g. when your binaries are in
/usr/libexec/git-core. I suppose NixOS or something where there's
hash-based paths may be exempt from this.

On those systems if you've got a server serving concurrent traffic and
update the "git" package you could expect failure if any git process
invoked by another is incompatible during such an upgrade.

If you browse some of the recent GIT_CONFIG_PARAMETERS discussion this
was discussed there. I.e. even if GIT_CONFIG_PARAMETERS is internal-only
we bent over backwards not to change it in such a way as to have process
A invoking process B and the two not understanding each other because of
such an upgrade.

That's exactly because of this case, where receive-pack may be started
on version A, someone runs "apt install git" in the background
concurrently, and now a version A of that program is talking to a
version B index-pack.

> we could just make sure that subsequent updates to this protocol are
> non-backwards-compatible (e.g. have index-pack emit "foo <hash>",
> where "foo" is a string that describes the new check, so that current
> fetch-pack will reject "foo" since it is not a hash).

And then presumably index-pack would die and receive-pack would die on
the push or whatever, so the push fails for the end user.
