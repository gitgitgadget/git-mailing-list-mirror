Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE4CC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 22:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E5136109E
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 22:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbhJLWMa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 18:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbhJLWMX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 18:12:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0EBC061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 15:10:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q193-20020a252aca000000b005ba63482993so1064989ybq.0
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 15:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FMOn2N6Gl8lGH7WHHEpcrfxHLhayjJfB8T9bGSylqV0=;
        b=P4s7kCh2jKfZ6JKE5h4iIw9MkZZlO/aAsJbn4PN3A4n72MiqAFHh0geY62fiTAVRLz
         aRcg10bfZ7F4c3KnonqkgHS/9FemrtcIGZgsX/+9bD0HTS9t8lpDGSf7m0gfvLROaE5I
         f9QFilh8FVVR3oRlChzFvRGejXI0HnmHeXuK8dWg6Kpba17H5+RCl9+XEFMJePqNBl38
         PAHxCU3mGgtoTWhpvBYroP0yfD5GWeYpFqxT2lre+2OOi0bY3gTqWXGgwFJFOT5J0qPF
         /7TVhT5jeJEcoxo70tL4ZBYt3K1qbsOjtcYbVAMtW284qSYv3ZExrCh8G+Vns9My6SXj
         2MQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FMOn2N6Gl8lGH7WHHEpcrfxHLhayjJfB8T9bGSylqV0=;
        b=RuuQouxaJFE3mTLkQcJzY6p8WFZJTkcFtE6hLlFi60qpdMq6inqeh0R+YvtGNbD+4+
         cgSOIvwL0iWu9V43ThE1Lbhvs8gou/6JWh7zvlynxSwskN81Lf/K3uk58dNKyGL6bnum
         XYLB/4VA+AZa7OqmC1HcaSYTACtPAaJm93O85lLc1o8zNMIxDKuTPKst0hvZxXiDpqO/
         usiP+H1txrK5xUShbCJQ8/K3ZuueNVAFvOMTNef4yb7vvfoDc16DbJ3frb7bpYTHc9+W
         oMMI4YMj+25NbI11ZyFWT9ftMaiZW3WB9yJ0zR0UEGeDWiRIF6a5ICDKBwZbXo1o1oOH
         f2QQ==
X-Gm-Message-State: AOAM5335MP8gL7XS60EHjP8jy8ndvgQ/oHWfhRBX+zbDX4sTDXT7RynG
        aba3UI/aTXKLbEJXIyTYF8aeU1ZsONWGIA==
X-Google-Smtp-Source: ABdhPJyGIhnckpo7XSfKVkdD7piqpkWkZaOIe1i14bavnsTwBIQzWqYXKztDpV8tOoBNwMm+hgSc3/e2N67fhQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:d157:: with SMTP id
 i84mr31389582ybg.434.1634076620759; Tue, 12 Oct 2021 15:10:20 -0700 (PDT)
Date:   Tue, 12 Oct 2021 15:10:18 -0700
In-Reply-To: <cover.1633727270.git.jonathantanmy@google.com>
Message-Id: <kl6l4k9l3ned.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <cover.1633727270.git.jonathantanmy@google.com>
Subject: Re: [PATCH v4 0/7] No more adding submodule ODB as alternate
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, carenas@gmail.com,
        steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Thanks everyone for your reviews. Here's an updated patch set, including
> Carlo's fixup squashed.

This series LGTM. My comments on v3 center around the remaining
references to the_repository, but as you have noted, we aren't at a
stage where we can remove the_repository. Rather, we are making
the_repository explicit in anticipation of removing the_repository from
the entire ref writing system.

I have some reservations about adding the backpointer from ref_store to
repository. I don't think this is the best long-term API, but it is a
reasonable step towards removing the_repository from the ref writing
system, and as Josh mentioned:

  This seems reasonable as we don't keep a lot of these structs around,
  so the additional memory usage isn't much of a concern.

Reviewed-by: Glen Choo <chooglen@google.com>
