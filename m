Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B26BC433E0
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 03:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 436DF2074B
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 03:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAQ2mBU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgFCDmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 23:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgFCDmR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 23:42:17 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B27C08C5C0
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 20:42:17 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p21so758205pgm.13
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 20:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yp4It6MMCu+m1XDXCzWDH+tEhOvblHHzqKhbdGhY4X4=;
        b=nAQ2mBU+OlDcM+qS1Ag+qE72CfcXyL8o+MS6k47puHlX4NBFVEsE6QZ89VtiexqTf/
         wDScURFsioQ+/oev6pr/F0YwYivHm/li9uncuR4o6TWRWVGmAomf16Z42vz0xZzf70HQ
         r72yWR3WO15Ui+jTl886Kb8AzTj1TrJkT0BBqx86LzaAn0KuNR3/iEOlmML8cepiGqDR
         kRoPJ1M4RMaihV2lM3qaPHGRfrx9E7avpJ6O60j28SgI9wCLiyBIwSjn7HCs0t/LhvV7
         QrDUnxnBiPaex1lEXWtvslM18aIB3/U2ofQBCVvwCPJAnhPJ2B4q80471pi7OtIpaJc4
         kt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yp4It6MMCu+m1XDXCzWDH+tEhOvblHHzqKhbdGhY4X4=;
        b=sJe27gc1f4RZpf5S73OGKm+CQO3Uj19oiysG93HDy5dHslhTvBqn4PcNu7/DsoZK1/
         TIWaQN8qy28jnon8lMo1X8AEouCi3YzJTheAhEGg7Ks7oHdfCt8/1WRB9+Si422lzGll
         sOUOdzMnwaCJjmxdFi75p2MEuj84N88qkWaROdNyqEyuMn/uEL57AQpZDHjPS534CAVy
         SgRrF/ByfQ4sjwTJK/lUbieoXbw4Mg74qNeAxW3egy9Y5NO0wkADcAExdz2wb3ueNA/c
         gwzf1Sr6BQes4UIdu5mncZllV40HLA1HiFMXIi5yyBZjSFOCfLON3GISCxE4wF1Inmxc
         Wdbw==
X-Gm-Message-State: AOAM530msdSz1s9O3n/oFgbxhthV5+FNtdcaAZCNcgWqk2pGtvssTH1D
        pCveo7pZ8O35BIRhB1zVTnyywmEv
X-Google-Smtp-Source: ABdhPJzh6+I+7yxon+xUEpLsBhnQgheWMYq1EGOFHr1eZwg1V8bT5gCCcRs+E4OttKIqzYsAte+Gug==
X-Received: by 2002:a62:76d5:: with SMTP id r204mr19826188pfc.46.1591155737056;
        Tue, 02 Jun 2020 20:42:17 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id gm11sm433772pjb.9.2020.06.02.20.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 20:42:16 -0700 (PDT)
Date:   Tue, 2 Jun 2020 20:42:13 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        newren@gmail.com, Jay Conrod <jayconrod@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 2/2] shallow.c: use '{commit,rollback}_shallow_file'
Message-ID: <20200603034213.GB253041@google.com>
References: <20200423001438.GC19100@syl.local>
 <cover.1587601501.git.me@ttaylorr.com>
 <296e70790d7a391d471554b0bc5a58e2a091ce88.1587601501.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <296e70790d7a391d471554b0bc5a58e2a091ce88.1587601501.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Taylor Blau wrote:

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/receive-pack.c   |  4 ++--
>  commit.h                 |  2 ++
>  fetch-pack.c             | 10 +++++-----
>  shallow.c                | 30 +++++++++++++++++++++---------
>  t/t5537-fetch-shallow.sh | 29 +++++++++++++++++++++++++++++
>  5 files changed, 59 insertions(+), 16 deletions(-)

I haven't investigated the cause yet, but I've run into an interesting
bug that bisects to this commit.  Jay Conrod (cc-ed) reports:

| I believe this is also the cause of Go toolchain test failures we've
| been seeing. Go uses git to fetch dependencies.
|
| The problem we're seeing can be reproduced with the script below. It
| should print "success". Instead, the git merge-base command fails
| because the commit 7303f77963648d5f1ec5e55eccfad8e14035866c
| (origin/master) has no history.

-- 8< --
#!/bin/bash

set -euxo pipefail
if [ -d legacytest ]; then
  echo "legacytest directory already exists" >&2
  exit 1
fi
mkdir legacytest
cd legacytest
git init --bare
git config protocol.version 2
git config fetch.writeCommitGraph true
git remote add origin -- https://github.com/rsc/legacytest
git fetch -f --depth=1 origin refs/heads/master:refs/heads/master
git fetch -f origin 'refs/heads/*:refs/heads/*' 'refs/tags/*:refs/tags/*'
git fetch --unshallow -f origin
git merge-base --is-ancestor -- v2.0.0 7303f77963648d5f1ec5e55eccfad8e14035866c
echo success
-- >8 --

The fetch.writeCommitGraph part is interesting.  When does a commit
graph file get written in this sequence of operations?  In an
unshallow operation, does the usual guard against writing a commit
graph in a shallow repo get missed?

"rm -fr objects/info/commit-graphs" recovers the full history in the
repo, so this is not a case of writing the wrong shallows --- it's
only a commit graph issue.

I'll take a closer look, but thought I'd give others a chance to look
to in case there's something obvious. :)

Thanks,
Jonathan
