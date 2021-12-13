Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28865C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 23:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244154AbhLMXUL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 18:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbhLMXUL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 18:20:11 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009AAC06173F
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 15:20:11 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id n19-20020a056a0007d300b004acbc929796so10885632pfu.18
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 15:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cWtaMkUEvZYJzTOoZpD2tQwjx5SKbFheABjL7kFfYKM=;
        b=FXTY7q+X/1xr1YGu3oV0EU6UGdKJgjDOtx3vXVUizKmYDUs3kclit5U5oUWlLJxN0P
         IF46BfgFr/IKgTk8nNkWcTmJ+I460ukU5w6Cpe+4hakVfArAgkrCBPJgVkIOnVo5xZ2S
         smk9rdnGnzzLNUyIOqwF8SOLNgvmSUeGq7PuV2Ww++WJrdptfge01QC0sDDt1jNJpcgG
         xr4N0auu24o2K5anyzRXWok/x/1DaYV/R7ITRPqUNlp1d4oTsxFe0+iLRCAoAQy8KN5C
         cDarHwl3Scc8YbSb4VfR5OF6RllMhXD7Vrh93E2LWdqIsKCQwWZZaUTFBvUlxfDQwGvo
         s87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cWtaMkUEvZYJzTOoZpD2tQwjx5SKbFheABjL7kFfYKM=;
        b=rURBsMLIDCprcWNTjlmo7npYXyG1lszGmLaWgE4deb9dw07Q/rPWNeIOYn9ovAfhW9
         6a7lKmCPZ7bDNcNvvK517beziqoNktMlA/GVwi7jJRPzQQ+i/+jrQb8mVSa4G6npkcLV
         cP6mOdC/ZJLDdJynucbzJzrIHB6r3SVmL5AHuhWTcALUvwLGjtQs94mIw4nUGdRLhAKm
         mqdE0j+JkF3XHLn5BR+bjAlYwzKFBEcj4L7lT0VoAB2NPLJQX5CaXnQZKu0z0Be5LShy
         15yQ8Zur+PbRnQ2v9F5EdYxv1jeTAxFWfPzR8hmPKQxkF2JhbR1e0A0nQvWW4o9J71D3
         TS1w==
X-Gm-Message-State: AOAM531jVVBuLrKTocf9km2znH4C2oSz0z4P7QJ+D/2JfsmvPwapNFBr
        JJlUwDyopbyeU6+nCYAniL8EuMAn0NK0j1yWyBIE
X-Google-Smtp-Source: ABdhPJx+ij6zjeeZm5V5xf8s/5gNxTIRieGYq/w2aGHjMljiucBoBxfFtEeHNXkDl7ESAHdy0MvRdLqKRUlVchoxsJPh
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:903:2449:b0:142:b3c:f9c6 with
 SMTP id l9-20020a170903244900b001420b3cf9c6mr1240767pls.77.1639437610336;
 Mon, 13 Dec 2021 15:20:10 -0800 (PST)
Date:   Mon, 13 Dec 2021 15:20:08 -0800
In-Reply-To: <kl6lee6la07a.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <20211213232008.771414-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <kl6lee6la07a.fsf@chooglen-macbookpro.roam.corp.google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: Re: [PATCH v3 0/5] implement branch --recurse-submodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, steadmon@google.com,
        emilyshaffer@google.com, avarab@gmail.com,
        levraiphilippeblain@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > Glen Choo <chooglen@google.com> writes:
> >> This version is functionally identical to v2. I've only addressed
> >> feedback around code organization, i.e. the the merge conflict with
> >> js/branch-track-inherit and making patch 1 easier to review. Thus, some
> >> discussions on [1] are still unaddressed.
> >
> > I do notice that some of my comments on "add --recurse-submodules option
> > for branch creation" are still unaddressed so I'll hold off review until
> > they are.
> 
> Are you referring to your comments on v1 [1]? If so, I believe I had
> addressed them all in v2 (and v3 is mostly a reorganization of v2).
> 
> Let me know what you think is unaddressed :)
> 
> [1] https://lore.kernel.org/git/20211124013153.3619998-1-jonathantanmy@google.com

Ah...I just saw that you are creating branches through a remote helper
[1] and are still using tree_entry() non-recursively [2] (to be
specific, I think we need a test where the submodule is at
$ROOT/foo/bar, not just $ROOT/foo), and saw your cover letter that said
that some comments were unaddressed, and jumped to a conclusion. Looking
back, I think that these are my only unaddressed comments.

[1] I said "If you want to use setup_tracking() through
submodule--helper, I think that needs an explanation as to why a Git
command wouldn't work." in
https://lore.kernel.org/git/20211129210140.937875-1-jonathantanmy@google.com/

[2] Discussed in
https://lore.kernel.org/git/20211123021223.3472472-1-jonathantanmy@google.com/
