Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D544202A2
	for <e@80x24.org>; Mon, 16 Oct 2017 23:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932987AbdJPXjl (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 19:39:41 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:55799 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932598AbdJPXji (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 19:39:38 -0400
Received: by mail-wm0-f44.google.com with SMTP id u138so407311wmu.4
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 16:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meteor-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HtPPrugtkBIPCHXvasFvY4WI1hFZwrB8MRxc1H/Pg3Q=;
        b=CISGmdZA5vWgZSu3ldrIRkqHyHaP5VRmSZ6/WKnBrLESV1LXmLn9gfRcqdf/3H97A2
         hDhGnRguTqhlrPZE0KqIwLqyjGUmr/Tz0LSX5L/4tgcZwHgXjyqlHd+9iKfRtdmNNRJ8
         1i0bEiClu3xA2SWVl4UoNJAUJc5eNF/0yq2SoIojMixwpbQLZreU9oQCNiaeY116O7i+
         1AZnoMB+ZE+xlZvzxVv8l0JjEuy++4sdqfwjhnZ6aNHwLKoOcJZc0o8RWstRmg9z+Rm7
         4r/EkPrQqbun0L38FRfQKRNL4+TEuPGKn1/ABvRznnJgKOxYhf6tMwTlFRyGTsuZP2Oi
         sjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HtPPrugtkBIPCHXvasFvY4WI1hFZwrB8MRxc1H/Pg3Q=;
        b=AdH/DD4SCC0UJZJE+eUeUHOQD1lZnFBb2WQClGIPhVnno5sqbZBRIlwb+j9pAscL3v
         BZRNLgVZddnDZchecAviCMHWkoKio+jDrdayGuTVvJCRCN9z43GUGkG30ZzRuggZv+82
         ERcLQRdOi6UVr2pYOYFXNcoGNAZ6XQwd9kzx5Ytb7HCxiBJ7jJpCAoTqS2Bc5O0WZvGQ
         rbjgI2KzVSQAbhNm7J4Lk6eU+pq4pJm1pr+LTPfd6umc0z4s2awjyj6ZAqFi5EJCT7FT
         /A/Je0V0CY6a9IFsKputRTnp1O4IX1+yJulzpwu5nGFc7GO2MAbMv/JH4MDXpzV4r8o0
         1YpA==
X-Gm-Message-State: AMCzsaWz+fgqEA2k7nF8PlZbucJ5w/KDd94S43vbOSlMaqnE6E4+EFrB
        Qov3KqoPqHJFqMNb9PsXGc/6gK8aEzw8VOe8XWzoqlCeyQ==
X-Google-Smtp-Source: ABhQp+SOzkugV7Oxu9+XPQCgxYl3r37ijeg7VoFDWaquXy5X/rlOyYuRzueVV38lFlN0e2oJOeSLAf24IJ/cCARe/CE=
X-Received: by 10.28.207.200 with SMTP id f191mr1828617wmg.99.1508197176850;
 Mon, 16 Oct 2017 16:39:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.104.67 with HTTP; Mon, 16 Oct 2017 16:39:16 -0700 (PDT)
From:   David Glasser <glasser@meteor.com>
Date:   Mon, 16 Oct 2017 16:39:16 -0700
Message-ID: <CAOz3OdswGKiWesrjp2P0oaVkTjGONsY3CoYq1B5Jh7Qq8tTPZg@mail.gmail.com>
Subject: Adding a target prefix to git filter-branch --subdirectory-filter
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git filter-branch --subdirectory-filter is really useful and easy to
use.  It's a commonly used step as part of moving a directory from one
repo to another.  It lets you move a subdirectory to the root of the
repo.

I've found that, when moving directories between repos, I often want
to do a task that is very similar to --subdirectory-filter but not
quite the same =E2=80=94 I want to put the subdirectory under a prefix (and
maybe in this case the "subdirectory" should just be the entire repo).

Searching the web for <git move directory to new repository> shows
that wanting to do something like this is pretty common.

It's certainly possible to do this with --index-filter or
--tree-filter, and the man page even has an example:

           git filter-branch --index-filter \
                   'git ls-files -s | sed "s-\t\"*-&newsubdir/-" |
                           GIT_INDEX_FILE=3D$GIT_INDEX_FILE.new \
                                   git update-index --index-info &&
                    mv "$GIT_INDEX_FILE.new" "$GIT_INDEX_FILE"' HEAD

But gosh, this is just a pain to write.

I'd like to add direct support to git filter-branch for having a
non-root target for subdirectory-filter.

I have a couple questions:

(1) What interface should this have? I'd lean towards having this just
be part of --subdirectory-filter as a separate option
--subdirectory-target-prefix.  For the "move root to subdir" you maybe
would have to type --subdirectory-filter=3D/, or maybe empty
--subdirectory-filter combined with --subdirectory-target-prefix does
the trick.

Alternatively, it could be a new filter type specific to moving
subdirectories around, but I don't know that that makes sense.

(2) The way I'd imagine I would implement this would be to replace the
current `git read-tree -i -m $commit:"$filter_subdir"` with `git
read-tree --empty && git read-tree --prefix=3DPREFIX/
$commit:"$filter_subdir"`.  --prefix is incompatible with -m, and I
don't really understand the importance of the stat reuse that is done
by `-i -m` single-tree merge. Is it OK to just drop the -i -m?

--dave
