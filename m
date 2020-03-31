Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9B9C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 23:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D0D20772
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 23:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="dhkcYMNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbgCaXYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 19:24:41 -0400
Received: from mail-il1-f179.google.com ([209.85.166.179]:40521 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731259AbgCaXYl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 19:24:41 -0400
Received: by mail-il1-f179.google.com with SMTP id j9so21284127ilr.7
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 16:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=ih8NTUnHbf50GEx5FoHH1Bu7bXjs6V0kCq8MXyEp+hg=;
        b=dhkcYMNjz2TyHQlssZwcXgyabkmNq0v0qUS5pQVjBsmjc7keKFdgc2qLJDHqz2QTH8
         ZHGE3Yn0UYJy++hBse8YeAyeQkIQVKEq5iZG266X7hlNE09yi1ZgQZhs9aqQjkhVS5sp
         umvvSvC0RiIsKv8vZWP3/Ih3V3LTVXH7lvoXCxDy969g9MY+Q7GkX2EN9JhU2jvxDTdb
         E0FvAQg5x7MPQWBYI447rSpU7VywBsEyiW5D22H7Bi44Vvunaps3P6yc6Z5ahSdsxh0+
         rgg+GzN/7PpComeSoL0lHgQaZq8a8ahNoud7wBLpu6UJhNsLruLOeczqOrtOkXJHaxJ5
         4PRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ih8NTUnHbf50GEx5FoHH1Bu7bXjs6V0kCq8MXyEp+hg=;
        b=jxUpoaS4AAajJSaoHQh+Q5CgEfvHskRlOVsYMMVjc6fdmnvxQD9/F3EDTX2RcpFo+d
         W6JbIyTEnWs+WebsMs7Gd82YFoeU0AZWXaaQVQZHnhtYZcU0UdVNAqxQTso34kpeO7mS
         JUX2doZLADn8qHPmFP2Ih+Wco5WsJL9m29uizVEmekBaRu7GJat3jAoUv4aJL292V6w+
         0eSRrWH7q+I8A6GT1m//ghFru1edIaB2+ybqhUi6iNe3Z/0WOmwO8uA2aoYekXkrWLHT
         hVJLgXimTMg2XTX91vvy0useLKJm/UjFUBoEMiWIMMA+96RfJWS2UUEu22diCjZXrFFm
         8QgA==
X-Gm-Message-State: ANhLgQ0a9EB6U0Yml55ZtvwnEBwwuJrBqsUiaaX4z4fMdCL59kC0PZrY
        1dMQz7YjId50DAhZlfKAwSI2h3kd6lILkLxC4UQmabxbQud8rQ==
X-Google-Smtp-Source: ADFU+vvgq8/frM22jumGxCVyK+aOqys99L/dUGVTB7hN+Wbv9908t6gvq0EMS/1T+hNt1n9NfweKmORQEpJ+5HeyN9I=
X-Received: by 2002:a92:359b:: with SMTP id c27mr18217726ilf.148.1585697079793;
 Tue, 31 Mar 2020 16:24:39 -0700 (PDT)
MIME-Version: 1.0
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 31 Mar 2020 16:24:28 -0700
Message-ID: <CAGyf7-FUjCefwGjvCcwmjO=GADd5S0cU_=S_tVy4nMaj07+rQA@mail.gmail.com>
Subject: Rebase-via-merge behavior difference between Linux and Windows
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the default rebase backend changing from "apply" to "merge" in
2.26, I've seen several threads about behavior changes between the two
backends. This is _not_ one of those (although, as I mention at the
end, the "apply" backend doesn't appear to have this issue).

Instead, what I'm observing is a behavior difference between the same
"merge" backend depending on whether the command is run on Linux or
Windows.

A little context: Bitbucket Server has a set of zipped repositories
that provide consistent initial state, and we have tests that download
those zips and then run various Git commands against them and verify
we get expected outcomes. These same tests run on both Windows and
Linux.

Using our merge test repository[1], one such test performs the following steps:
* Unzip bare repository
* `git clone --shared -b branch_that_differ_by_empty_commit_trgt
<unzipped> rebase-test`
* `git rebase -q --no-verify 7549846524f8aed2bd1c0249993ae1bf9d3c9998
298924b8c403240eaf89dcda0cce7271620ab2f6`

298924b8c40 is an empty commit (i.e. `git commit --allow-empty`), and
is the only commit not already reachable from 7549846524f.

On Linux, when this test completes, "HEAD" in "rebase-test" is
7549846524f because the empty commit was discarded. This is the
expected behavior. On Windows, "HEAD" is a new empty commit, which
causes our test to fail.

If I set "rebase.backend=apply" on the "git rebase" command, I once
again get identical behavior on both platforms, with the empty commit
discarded. (I'm just noting this in case it's relevant.)

[1] https://packages.atlassian.com/maven-public-local/com/atlassian/stash/git/merge/2.9/merge-2.9.zip
