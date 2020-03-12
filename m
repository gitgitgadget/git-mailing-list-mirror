Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA653C1975A
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882D7206F1
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDjc6Zba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgCLRHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:07:22 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:35276 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgCLRHW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 13:07:22 -0400
Received: by mail-vk1-f201.google.com with SMTP id g131so2589170vke.2
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 10:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4Gh44twcqFlNe/0sChu2haFG8fbqQB6AZMV8jzl5occ=;
        b=pDjc6ZbaAwUOk2QytUPYaWaZXAsIohzXWiHYZZlyeQ2dXAGpt6bZWo8HWM8hSwOsqV
         Ud9wslTHIxekhM9YClyVCgsrK0zWhDyZFhtVu+uisqnVOEFfHaGgS1JDCZT7DwncxEyG
         5M4Eo6rO4NiLLtQvxpUPTagRB0jRZhHGDSWgRIm2BfGpbPxc+jP36CtzC+h1DUmaqClK
         ReNGZBvLaBAUd0hPtYE499eZQdFT3mFf1dt8Fc8sUIZugh+ETpMflHAsWVyWVBxbNTw7
         G/sXVw4/VO5V9sOtksWlkhnyrf/WjCTzvpNbF03ItVTgCTTgv7qHneEmuwga5iiuDa6j
         YrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4Gh44twcqFlNe/0sChu2haFG8fbqQB6AZMV8jzl5occ=;
        b=qVdYaoXjwpt5t6nsHvdZYQrrozijWS2m57LIhiIiDDs/07xKnmPmJBL1Kjri6uYeAP
         fZbR7XQKJq4p5tVeY5cYd6i69VAJnt8AteF3OtjhzEltIrR+vps8UreFPfcDiEP13JD1
         GXtfYVBqAa9bhAHjRtc0PLAu6VBdWZS4XqCgSleB9n7F5w8SkGLMEzRF9FWxpnDWfVh1
         /aFFCKWr/G6r3F46yqUrDOOcv87RItjXpkw8O6UZrSIsseUwqtojpApXk/qIIUlJaQin
         doHgyRD4p7DYrp/P4s2kVmgvg6dlxiJaFstV2nJ6tEOmV9hwP2u2AP1WWzKS0GKlnoNK
         JBQg==
X-Gm-Message-State: ANhLgQ1pva6oEqaIlVd4KvU8cN+WzCZLWuLRvujARO8APBAgK/gp5RRR
        dbLsv5secjMQEr+c5COOVyFzdOabf4mAxissIgZL
X-Google-Smtp-Source: ADFU+vsflb0rz7yjFumk2cV8q0V/acvXDbDTmYSoVCCUA/WPrjbrOUdsSAP4u83iKmfNr1hnOMEJpYGEMqoBcIyR3t9d
X-Received: by 2002:a1f:9948:: with SMTP id b69mr6095878vke.13.1584032839636;
 Thu, 12 Mar 2020 10:07:19 -0700 (PDT)
Date:   Thu, 12 Mar 2020 10:07:14 -0700
In-Reply-To: <5981c317-4b39-de15-810b-a781aa79189d@gmail.com>
Message-Id: <20200312170714.180996-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <5981c317-4b39-de15-810b-a781aa79189d@gmail.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: Re: [Question] Is extensions.partialClone defunct?
From:   Jonathan Tan <jonathantanmy@google.com>
To:     stolee@gmail.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, me@ttaylorr.com,
        christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I was looking into an issue around partial clone in v2.26.0-rc1, but found several references in the code and documentation to "extensions.partialClone".

[snip]

> but it appears that we rely on the "remote.<name>.promisor = true" setting instead of this extension.

Hmm...besides giving the name of the promisor remote, the
extensions.partialClone setting is there to prevent old versions of Git
(that do not know this extension) from manipulating the repo.

> Indeed, if we run `git clone --filter=blob:none <url>" the resulting .git/config file is as follows:
> 
> [core]
>         repositoryformatversion = 1
>         filemode = false
>         bare = false
>         logallrefupdates = true
>         symlinks = false
>         ignorecase = true
> [remote "origin"]
>         url = <url>
>         fetch = +refs/heads/*:refs/remotes/origin/*
>         promisor = true
>         partialclonefilter = blob:none
> [branch "master"]
>         remote = origin
>         merge = refs/heads/master

I cloned and indeed it is as Stolee describes. Git still works as
expected if I remove "promisor = true" and add
"[extensions]\npartialclone=origin", so at least extensions.partialClone
is still supported, even if not written by default.

> So, I thought I would put this up on the list to point out the inconsistency, in case someone with more context has thoughts on the correct way forward here.

Thanks for bringing this up.
