Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70AFCCA480
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 08:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiFUIXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 04:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiFUIX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 04:23:28 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F891148
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 01:23:25 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id z14so12481563pgh.0
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 01:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xGO0ahbs4jHfs0ERm2SKyk4yZibhqgVj/bD97IjPa9s=;
        b=GDo0PjFsm4p1f6XUVdgWLTSYNv27NJqrSyfSvYkSEo40K/exRhwnWX7nQMIN8fYnPd
         NKKkQrKNfgrnhT16Hm/2B1/lgB7dtHI3mQN2eo8HmeJJEz1E/4DxxRrmspeXL6dfI4x6
         1nMN1rQ0u7Xo8YKGoX4YwgMidZtmWtaIpM9GbfGHKkbrXK1pD+JlVZs2OR7uY3TIwN4d
         K8R90UXN3pTCAQbrff55cm7XnZ6UswFyl2hE41mWHtNhPAInD8SGvat4bNR3Lw+c0hYm
         mGkUpGMOmKmm0hSBU7KXp/TKOf+KNhuOFM/zVrCMT6qhYLUZrxTa1CKFQ5OKgSX57MLK
         /4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xGO0ahbs4jHfs0ERm2SKyk4yZibhqgVj/bD97IjPa9s=;
        b=RMkJGoDrmBtthydqoyqKFxa+/YY6IP5PzB/lEMiknGDQALYZT0XUxw8zBum/SUqpHh
         AjvQKPGZ9JjLpxmaZRIpMx8Hdubn+hSjRjPiNzebWNe9pQTyQDF3W2GznjxRoBTxuAon
         I2g/in6nZTGxYwfzId5JV0x+o2iky0u+L/vZesEIwB59C6GLDVpmvUnPSpLnjmEc2BWk
         E4YeAlIwtv7mxjXjv0iEHvNhpsvS1IQp9E1MD8bTItZsHhdVKNIJRMYub8Ou8/YNuvlR
         rpay8ZBgrqJUlSFbeXapuv0djHcS6FJLHKX0ZnlcV/Ky7fSGrUbFtKdTbKTIgDfS0NvS
         o0wQ==
X-Gm-Message-State: AJIora/pT/C8Imsog/qAufUMmy5KJObFfRrtMWWjhROPw4GySdwbAiDv
        3+Z98VmB4g84KUpTdUHmDX6EHPVnw7Y=
X-Google-Smtp-Source: AGRyM1sZq6MXmvRlECQJBgnqW4FZS1tOL2Dl87lVpKIXiXFjferrLdOSDZ86RyMoVtZAdl4Yb272QQ==
X-Received: by 2002:a05:6a00:248a:b0:51b:f461:8318 with SMTP id c10-20020a056a00248a00b0051bf4618318mr29007936pfv.47.1655799804812;
        Tue, 21 Jun 2022 01:23:24 -0700 (PDT)
Received: from localhost.localdomain ([2409:4060:e8c:d9c4:a028:bb47:21:6f27])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902eb8f00b0016a106cb221sm5887582plg.243.2022.06.21.01.23.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jun 2022 01:23:23 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/6] Documentation/technical: describe bitmap lookup table extension
Date:   Tue, 21 Jun 2022 13:53:08 +0530
Message-Id: <20220621082308.21376-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <b21af0bc-3234-3aa2-e4a0-82874e9a670e@github.com>
References: <b21af0bc-3234-3aa2-e4a0-82874e9a670e@github.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stole <derrickstolee@github.com> wrote:

> It might be worth mentioning in your commit message what happens when an
> older version of Git (or JGit) notices this flag. Does it refuse to
> operate on the .bitmap file? Does it give a warning or die? It would be
> nice if this extension could be ignored (it seems like adding the extra
> data at the end does not stop the bitmap data from being understood).

No, it doesn't refuse to operate on the .bitmap file. It just ignores the
extension. Will update the commit message.

> Perhaps it would be better to say "the last N * (HASH_LEN + 8) + 4 bytes
> preceding the trailing hash" or something? This gives us a concrete way
> to compute the start of the table, while also being clear that the table
> is included in the trailing hash.

Hmm, well said. Will update it.

> Could you expand that these objects are commit OIDs, one for each bitmap
> in the file. Are they sorted in lexicographical order for binary search,
> or are we expecting to read the entire table into a hashtable in-memory?

Yeah, of course! They are sorted in lexicographical order for binary search.


> Interesting to give the xor chains directions here. You say "position"
> here for the second commit: do you mean within the list of object names
> as opposed to the offset? That would make the most sense so we can trace
> the full list of XORs we need to make all at once.

I think I blundered here. I forgot that the xor-offset is relative to the
current bitmap. The current proposed code takes it as ABSOLUTE value and
tries to find the commit on that position (in the list of commit ids). So,
there are two faults in my code - (1) As the xor-offset have an upper limit
(which is 10 probably; not sure), any of the first 10 commits is always
selected. (2) As xor-offsets are relative to the current bitmap, it depends
On the order of the bitmaps. These bitmaps are ordered by the date of their
corresponding commit and commit ids in the lookup table are ordered
lexicographically. So, we can't use that xor-offset to find the xor'd
commit position.

Will fix it.

> Are .bitmap files already constrained to 4GB, so these 32-bit offsets
> make sense? Using 64-bit offsets would be a small cost here, I think,
> without needing to do any fancy "overflow" tables that could introduce
> a variable-length extension.

I think you're right. I should use 64-bit types here.

> I'm guessing this is at the end of the extension because a future flag
> could modify the length of the extension, so we need the flags to be
> in a predictable location. Could we make that clear somewhere?

Flags are at the end of this extension.

Thanks :)
