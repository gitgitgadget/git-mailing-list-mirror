Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC757C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 04:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A53F261380
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 04:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhFWETw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 00:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWETw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 00:19:52 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4ACC061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 21:17:34 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id bm25so2008090qkb.0
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 21:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=VQoI5ubC7sphnKpV1ifQZOKdQ0LnQQtBr7y2GY1Juyc=;
        b=i8N8tf5W3eAdPZLb+I6onSGXN3HLCUqt3YExWqQwlwNOvvtiIxPGvLQ6KA23vtDw22
         PiqZFq5tyLucYkI/XlCUusaGktq69PCzRKJcqnpZnSDyQPvZ3UXw1iq9gMpa1A3KbXW+
         byL6DL9hD2UZnOvIqZ3Ubv60aHyngDgJZmHL1et2Ru7562D87Mn8sIDSAcUS1Ej76KSz
         IiB75ld4/uHwHgDQL8sDu9T+ySnI882v9sey/lIYMHxT82JO1XsSAZPXlOe+fkZJt8NP
         TrzkKvBc8bisqPi9cDYL9CCzNvzEAUTyvj/VHrotWH+BRIGhSuyLeAA7ju927la02Vq9
         ATAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=VQoI5ubC7sphnKpV1ifQZOKdQ0LnQQtBr7y2GY1Juyc=;
        b=Tw7sKOsku2i0fz7ezkVQAdv8aaxU/S/FnCQDv3zmyCH/a/Fch0hAHClUSd/Cf4nSVG
         a5ylMT64Uzs6bZBcN+ndsjUlk3Tq1Hel7pFi9daK9+DD0ssSxOcEGzVcBATD1xg5hER4
         aX91ueHMsqFXDL3FQQQ2GfE/uPpU5XwmJ4Kb7sZ0qZNljMPlpc0FPUkeGjrCLWCtAgtB
         pGNS7xx4m4IdUOP1nl8aZ+1CgebTM1WQW3K5kicrPGg36Nam/Pq6eXQAw054qL5Jq0BE
         WrPgGN3KA9vyYmjRA5tDEftvj4jqmYH7JNqEg0vLPNpOyyZtzpArEf58SGTiMvTzAMIm
         8OEg==
X-Gm-Message-State: AOAM5333xXqsKtlDCYEp2JLxiDgCuSuUPn1XeG4v5zRr9h2ES/xiN2gS
        xSa4J6et54Jgfq86t5RGoGQ74YmjfjK6+1OQspp3fclb
X-Google-Smtp-Source: ABdhPJzjD9pPJ/cm+GlOTi7khI4uZLyjCbl99e8jSfEAzv6dqQzjjgIG0+R9gtk2E3HNwjDieOcmpvSSRkcvt9l7KMg=
X-Received: by 2002:a05:6902:114c:: with SMTP id p12mr10022071ybu.282.1624421853577;
 Tue, 22 Jun 2021 21:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <CADdMKP8y3TjeCyJaxazYFY9zN2QpnMVZyRWnpoTLMcZ0ZPNMzg@mail.gmail.com>
In-Reply-To: <CADdMKP8y3TjeCyJaxazYFY9zN2QpnMVZyRWnpoTLMcZ0ZPNMzg@mail.gmail.com>
From:   Douglas Leonard <dleonard.dev@gmail.com>
Date:   Wed, 23 Jun 2021 13:17:20 +0900
Message-ID: <CADdMKP9gPqE6Eg6Z1=SKK3PAmWhX=OaK7epZe=iEPAh9SYkizA@mail.gmail.com>
Subject: git-alltrees: root trees and subtrees without duplicate commits.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

For a very quick introduction, I'm a career physicist. I just thought
I'd share a detailed method and implementation I developed to improve
on shortcomings of subtrees.

This says it all
https://gitlab.com/douglas.s.leonard/alltrees/-/wikis/home

But to repeat a little...

First, it allows a container "sub" tree, ie syncing only the non "sub"
parts of the tree to a repo.  But maybe more importantly, when it
pulls from the trees it's able to "remap" or reconstruct old commits
back to their originals to avoid the duplicate commit issue of
subtrees.  This is round-trip reproducible so consistency is kept both
ways. It avoids the need for squash with subtrees. Compare the two
images in the wiki to see the difference between subtree without
squash and alltrees. Non-FF changes made in a tree repo show as
branched and merged. Traditional advantages of subtrees are kept,
primarily that users/developers of any one repo don't need any
awareness of how to use the subtrees or the other repos.

I have used this some, but not extensively yet.  In my use it has
worked.  I think it's pretty quick, but I haven't tested on large
projects.

Cheers,
Doug Leonard
