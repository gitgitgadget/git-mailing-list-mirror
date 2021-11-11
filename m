Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95C6C433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 18:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8520B61179
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 18:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhKKSPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 13:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhKKSPf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 13:15:35 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D4DC061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 10:12:45 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id c140-20020a624e92000000b0044d3de98438so4290312pfb.14
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 10:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :content-transfer-encoding;
        bh=giKBIiI8LF40bG4STMaRFJ3ZWWIEStbMEGeIDi87Pi0=;
        b=FTIzw38WLA9f8hSw7T5OY4lUr891lATIYFHpwRbDLMIhqYRr+YhG9Y3ZtWqOGobLGH
         1y81HJCfZ/bu4XsgWR0qeUyqSjs1jKqRMl+bQ9X//h1XiaVWlyQVeolroAEdopcyO6F1
         OH47hRM75WLOdXbb0IDjpME2UEWRBQSton/deCDidQyLmHrmLb+Bdk0KemwWHc89d0jr
         1eZUAdu4gycLjzwHuaU2I8mlyNWkdaithv0+kBWEdlfqdn7zv75DSN1n3IAw0oCLyHkr
         LkwlKERePB444q8vjC7MfhQRrY+nmX2XuooF6g7SyQ7ggGL33xy2a1y8N/KRO5qeJbV4
         BzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:content-transfer-encoding;
        bh=giKBIiI8LF40bG4STMaRFJ3ZWWIEStbMEGeIDi87Pi0=;
        b=4I1bwe0v+S9SPRJCXDPlUzoZh3dUre5Zdcz5+Xq1A2zF+Yy3mPaX1s2m9O6qpATJX1
         O7uQdkMOEBcIO1MtF2PkKYt+BXu6kFRvMhisB7bZyTeWrNC3nQEjgyLiJfKD08jUxef7
         F3rUqtgkZsIkdRw7sH6cbgtdFpvKeW6auMb4Tx8e5gG7xr2rzqVLTFazHMGztI4Kvy+1
         //fBqRb0LW9F4GKv3UgNaURaExZCmqfWWTOxqDyDTNOzyv8sSdzjf8zTjL11xOwgCuKh
         p/eEMkChcNCS/Xmf/KwAT1CW/GAgQiPb3uZMR85bC/SNtJXU7lJr+XzKAK5gbRKsmizM
         /EtA==
X-Gm-Message-State: AOAM531mEAInZ5fhR95CV4x9jHLaHLtuq8wQeQY72lHR0B2U2OiPczgo
        RRCmsBjKgnWpbIpGw2OrKWo9V0Ks3/kclg==
X-Google-Smtp-Source: ABdhPJwJZJd5D213eMldh0olQL0r6QpnHqUwk/v8teC5GvOG+CXwSvLQlFuZ03RPSKhfmX0xTfoEwMLxZbDT/w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:74c2:: with SMTP id
 p2mr28547619pjl.184.1636654364533; Thu, 11 Nov 2021 10:12:44 -0800 (PST)
Date:   Thu, 11 Nov 2021 10:12:37 -0800
In-Reply-To: <000a01d7d671$1c7d4820$5577d860$@nexbridge.com>
Message-Id: <kl6lbl2qv9wq.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lv912uvjv.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lh7cjvpm3.fsf@chooglen-macbookpro.roam.corp.google.com>
 <000101d7d661$cbfa4fb0$63eeef10$@nexbridge.com> <kl6lee7nvm6t.fsf@chooglen-macbookpro.roam.corp.google.com>
 <000a01d7d671$1c7d4820$5577d860$@nexbridge.com>
Subject: RE: [RFC] Branches with --recurse-submodules
From:   Glen Choo <chooglen@google.com>
To:     rsbecker@nexbridge.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

>> > 4. If working on the submodule, use a branch, not a commit - typically=
 off
>> main.
>>=20
>> With the proposed UX, step (4) would happen automatically when using
>> "branch --recurse-submodules". Users would get a safer and more
>> convenient default.
>
> I think this might be more reliably done using a switch in .gitconfig to =
enable the capabilities. Perhaps something like:
>
> submodule.fetch-branches=3Dtrue

Correct me if I am wrong, but we might be suggesting different things
here. "submodule.fetch-branches" suggests to me that you're thinking of
submodule branches that track the remotes of the submodule. The proposed
UX is more about how we have submodule branches that work in tandem with
superproject branches.

A user who is only concerned about a single submodule can cd and make
their changes as if the submodule were a standalone repo - I think
that's pretty well-supported. The missing link being able to coordinate
this work with the superproject.

>> > What I could see as a possible improvement is to add the branch ref to=
 the
>> submodule ref file - not replacing the commit but adding to it. I do wor=
ry that
>> there are unintended (unforeseen) side-effects that will result from thi=
s,
>> however, including potential merge conflicts. Two people working on the
>> same commit but different branches may mess the ref file, so not really =
a
>> good idea.
>>=20
>> It's an interesting idea, but as you noted, it is quite thorny. I would =
also like to
>> see more information being captured by the superproject tree (instead of
>> just .gitmodules), but I'm also not sure how we might do that.
>
> I'm suggesting this instead of a command-line option because this seems m=
ore like a policy-based process that you would either always want or never =
want. I would not like to depend on a developer making the call each time a=
 clone occurred. I'm sad to admit that I don't really know where to start o=
n this enhancement, though, even if approved.

Agreed with regards to both points, i.e. using a config instead of CLI
option, and not knowing where to start..
