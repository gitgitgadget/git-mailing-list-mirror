Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8FBC433F5
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 19:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiI2TVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiI2TVP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 15:21:15 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7BA3135D
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 12:21:15 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id q83so1681380iod.7
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 12:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=x+nJ1vT2LctTWPMXdmusZkvCSio9ceef3T8v1X6/vjM=;
        b=ezTGXiN0hICNkaMvYc3eUPiS+AbmDAEjSTxh4HRjF9QUm0XZEeaYvKiy6PIBHttBQc
         0wOlJ1vL6RL2alTQClXiz+JusbKhvjBHWDlN1pYc+i2x5RZU6AIWbXjmEd3AHVT8X7Ka
         XuWPGIh0JVO6KISRfhibXtIxXy1pnhv/CREbwNgIiMvmXirYzAwpZm+mEsWitwV37FjN
         VIQ0zqMgAPCOW+8MU6YSIFmE3J2vnU7HjtgyqtGvU5LS9XJLAep6IX9wereWSNqA3kX4
         0/scRS/T5fpMSatH9HRggMhbnEd8+XAMuqMwT6EKKEKU/QwtS5c56P7EdscFu9s9sOLB
         RBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=x+nJ1vT2LctTWPMXdmusZkvCSio9ceef3T8v1X6/vjM=;
        b=UqibQ68d/dM6mxVoDYtDQ+ULPbBzAOPUUu7NEDf6GW9pHMruGUVBWd/QC8QCF/tHlv
         GqvETBIP+5eCoxkHm7LR56oYSKp5QURFcUWpOVRlckaRKqZXEqmtjSoRBWk9MU8LAZg7
         jZpwXEjeS6/lL78txb3RtwHSJu6s+De3a8MBKGMVJlDQ9frXe/ZHhbHIqSrViu1DsXbT
         0dN06oyhhAcdR/OwRoyLTIX26phS5f4RELspeLTUrd1VnCnm3U+AY6ws8ghSAEVSJOw4
         Khyuq4jmv9Yt7xAMbR7rzc1u5dA2lu/ohFKZ7JAUVnBixm5QyPRxYC3cpttgWyFEU73Q
         b3pw==
X-Gm-Message-State: ACrzQf15m516XWwoxTsGFBQEHa277fF5X4Mk7Uuj21Aa9aAJRC2ukhhm
        +nekCjTjHD+o1IiLsop2nTz/E5WzgshMvw==
X-Google-Smtp-Source: AMsMyM7X3rNGjXgIko36DN84dWhfDt8UT2cocDdVzioP5kuRsfgLDW9Sb7acAPUXw/2PuaMhKb6zbg==
X-Received: by 2002:a6b:3f02:0:b0:6a4:b54f:c280 with SMTP id m2-20020a6b3f02000000b006a4b54fc280mr2211902ioa.46.1664479274245;
        Thu, 29 Sep 2022 12:21:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l14-20020a02cd8e000000b0035b666ecc84sm76363jap.133.2022.09.29.12.21.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:21:14 -0700 (PDT)
Date:   Thu, 29 Sep 2022 15:21:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [TOPIC 5/8] Server side merges and rebases
Message-ID: <YzXwKXSQwE4NKdIV@nand.local>
References: <YzXvMRc6X60kjVeY@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzXvMRc6X60kjVeY@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# Server side merges and rebases (& new rebase/cherry-pick UI?) (Elijah)

- Elijah: tried to implement the git side of the cherry pick as flags to
	git merge subcommand, but everything turned out to be incompatible.
	Used git merge-tree instead, much better, but this doesn't create a
	new commit, only a new top-level tree.
- Rebase and cherry-pick is even more tricky because we need sequences
	of commits. Does the current UI make sense?
- I want to create commits on a not-checked out branch, or rebase, or
	cherry-pick. Not only on the server, but on any client.
- Rebase skips cherry-picks, but that is probably just an optimization
	for when rebase for a shell script. Always doing cherry-picks is
		faster these days, but is a behavior change
- Creating a new commit and modifying the working tree - this lets hooks
	run, but I don't want them to run the server
- Rebase and cherry-pick are typically centered around HEAD, I would
	prefer to replace with just a commit range. If you don't make the
	assumption around HEAD, cherry-pick and rebase aren't that different.
- How do we display conflicts generated on the server side so that ? We
	don't have a representation for that. Taylor: Probably just block the
	operation on the server. Elijah: That's my intuition too.
- We have a lot of users who want to cherry-pick a commit on a bunch of
	LTS branches, it would be great if they don't have to check out those
	branches.
- What about cherry-picking to older branches? It's super slow to check
	out the old branch and it's a big pain to update.
- Want to be able to replay merges. Not just like rebase
	--rebase-merges, but with extra content/resolutions
- Emily: Rebase has famously bad UX. Could we create a new command
	that fixes the problems, like checkout and switch? Elijah: I'm worried
	that I'll copy the old terminology, so I'd need feedback on that.
- Stolee: We could rework the underlying API that supports rebase and
	cherry-pick and use that for the new UX.
	 - Jrnieder: We don't have plumbing commands for this yet, which would
		 be very nice to have. For changes motivated by "cherry-pick has
		 this bad behavior", if we're not making an overall better UX then
		 I'd encourage "go ahead and make cherry-pick no longer have that
		 bad behavior"
	 - Jonathantanmy: I think base + theirs + ours is good enough. Elijah:
		 Sounds like git merge-tree, I don't think that's enough for the
		 server case. I'm sometimes porting over multiple commits instead of
		 just one, ort can do some optimizations on that, but one-by-one
		 invocations would lose that info. Also, this isn't enough to replay
		 merges.
- Peff: It would be good to have a machine-readable representation of a
	conflict that the server can serve, but also can be materialized by
	client tools.  Taylor: It would be even cooler if we could push that
	representation and have "collaborative" merge resolution. Elijah:
	Merge-tree can output files with conflict markers. We'd have to add
	info to represent the index conflict. With rebase, we'd need to
	represent different conflicts at different points.
- Martin: Does ort handle conflicts with renames? E.g. renaming two
	files to the same name. Elijah: Yes
- Elijah: One format would be input to git update-ref --stdin, so
	instead of making all of changes, you could output the data that git
	update-refs can ingest later.
- Waleed: Do you support rebasing non-linear sequences? Elijah: Yes,
	but..  (didn't hear)
