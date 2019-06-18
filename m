Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AA331F462
	for <e@80x24.org>; Tue, 18 Jun 2019 04:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfFREZN (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 00:25:13 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:39925 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfFREZN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 00:25:13 -0400
Received: by mail-wr1-f47.google.com with SMTP id x4so12290525wrt.6
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 21:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=lrXQgNInbq1GCKkQ3Wj53zzBq8S9FqNXgIQAzO/ctRw=;
        b=G9Qbz8iDlRDnkIi67497dB/hef5ERF6idNtOP67fPkXu36yqOsiP4YfyqtLzCVr/Ww
         BAL3BzlLW2VHNLkIoSUUyB/c2NNsH8WmAZQo7KzgCC+itpsIN9AM93Aoz9jn9F8fy1Mr
         /WPOvPSqxVd/k8IbrDbvfEqzs74/LkblXFruKfSW6rVCG6h6FW793G0s66yYQ1kcPvDM
         HwTLwakDiB8b9WqvuB9s4rLLUD6xFsYzxaN4axnVl+E5E+dZDVzGg8e/2M1bt1sCXAsl
         wLs18RSyhXs5QrQDD+EWfGlqCMlCicWXzbLRoLB28tnBvGidP1NR/9Ey8IB9rMY0fUTF
         x3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lrXQgNInbq1GCKkQ3Wj53zzBq8S9FqNXgIQAzO/ctRw=;
        b=QQdNU69uQYqcg3+Pn7c2qNkT8+B+TG6UzNUmE0yGL6W6hc+fr+PFcPvT/+telw1Svg
         qx70mEQzx9IY8IJy9kApQc9mqCVeT9GlLrQ3YQOyJj+EhqbRaqs/lWx8RoZKUfR/EVK2
         7jdFCh1flt540EWr7pRRv2nWfzaYbzYrjRm0mj3ES+PF//MiOrckZvpUv1aMskSnrDlC
         ABwgl+sss0VYkyLr6cbIQN2/20G3EF70BZQH77sjZKpEaCIN3XdV15RQwapRRrts1j5A
         +iHqnjTGidL5X0VBEHf7ZhaQaHGblR8YnfmFA0W5Pad5kYqY+4MiMPO7z4n4/2SbRxmO
         jM9g==
X-Gm-Message-State: APjAAAWmh+eSUYhD2EDvY5+HwD5Okddx0NamOkXflASoG1RC5lwkPhdz
        4i1bpW18aNOfQOYK6ztuYvZUBzX4D2rqV6nD1UTPnt5Gi6o=
X-Google-Smtp-Source: APXvYqxbgk7T8oCA8UqzHcGde19bgr3HmjtHdde7O5+gh4P1HCpb3ETdIrCKeP4rMRytC+izkhRIU5c4y92ck6WZK0c=
X-Received: by 2002:a5d:4008:: with SMTP id n8mr19776255wrp.353.1560831911669;
 Mon, 17 Jun 2019 21:25:11 -0700 (PDT)
MIME-Version: 1.0
From:   Matthias Goerner <enischte@gmail.com>
Date:   Mon, 17 Jun 2019 21:25:00 -0700
Message-ID: <CALB88e9n7raRET8Av-uSih8Xj=iAaUYrVx_+cOR2Bf8zYGQaKw@mail.gmail.com>
Subject: Should sparse checkout be extended to clone, fetch, commit, and merge?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Sparse checkout is a great start but I wish that clone, fetch, commit,
and merge also had sparse functionality to skip operating on objects
associated with directories not listed in the sparse-checkout (or
similar) configuration file. To clarify, this is different from
shallow clone or fetch which skips old commits but still fetches the
objects associated to every file in the tree.

This functionality would be very useful when dealing with large
repositories. Sparse checkout helps, but it doesn't reduce at all the
amount of traffic and the amount of disk spaces needed for the .git
repository. git submodule is an alternative, but ideally, one wouldn't
need to break up a repository as it grows and use git submodule.

Are there any plans to implement this? And if not, why not? How much
effort would be to implement this?

I don't see a conceptual reason why this can't be done. In particular,
it is not hard to see that making a commit after a sparse clone/fetch
is still possible even though one does not know the content of each
file in the repository. For example, assume a repository has two
directories /A and /B at the root and a user fetched only the objects
in /B to make a change to a file in /B. git could compute the new hash
of the root to make a commit by computing the new hash for /B and
simply using the old hash for /A without the need to know the content
of /A.

Cheers,
    Matthias
