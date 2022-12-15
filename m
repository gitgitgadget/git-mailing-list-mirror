Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6302C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 16:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiLOQIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 11:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiLOQH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 11:07:56 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0883137F
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 08:07:54 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id c66so27685974edf.5
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 08:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/tjreacYxwI20ETS3kT3Eiw4LEIeN7t873R5Qwpdlo=;
        b=Ey2O8wByoTy2NydFuM4TvUQFcO5fOf/I08xPysQ3y2Ysd33/wULCW8bfzl1WJZXQBj
         8QZiPYdpoQ/nlRixiydhzM6YTaIFG4Q1cNKkVXJ20/J5jUdQ5ojHM/m5Oq6n/A0o2OX2
         fs3ZZotJQQjHHTApGpJJ0RX7gD9bo5fg2mckRn+XIZPbGrGgSjQGrnPTlBejQOVYU1H6
         +cUNcJ2DRms5Gxs6uTFtJq+sAzzKkn06UIX2cuBwZcxrVgF6yWlK41w0aKFN+OSOxuDe
         YRgqDgni6SGu5pETTxHsrDU7RVg8SbJT+EoqETRMhID8HhHMA9Elpl1Dtz0194PcMyB5
         i7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/tjreacYxwI20ETS3kT3Eiw4LEIeN7t873R5Qwpdlo=;
        b=PutQeGXiBLsZzENZs3vd0JB4o1iWlJi6g6RrZvXm2ypL1geXtl/Rf18An1NFat/E5D
         1CBFYvwlrh36hjh/9l9wRiIyzpn8IJv4zXJ0C0062biEM+3Hz7uYjZjQ0PaeBIlOoogQ
         rn3VFR0Mf029vKoR+PJ7ncIcmtId2jQKHrqHaSbFa9fFqBfzf6JHwp1+syjBnHyYgMz/
         J2hIYIJucEbchorgQ/aXfkObQ3RJZPZGsDveTocHzC49A/MeeKHHVY0KRQd93Q1mrRpP
         RmO5WNX8ytVhCeV/6GRcYay3Dkzbkyw2Jo7yYop1Uj+dt3s3JLS7aQEHFJuukZSLVcKa
         0rKQ==
X-Gm-Message-State: AFqh2kr3s6xGX3oIIlYKPWeljm3wHY28VTZT7eOzVpT4Czy8CMBfPqn7
        uPoPNhmUm394SnsZmA/DZPjXcURU8T7yxA==
X-Google-Smtp-Source: AMrXdXuwE7VD8FeMLHclRkrnWNaC7zhyY41fwxm8avnLeCa2ufx6wB48eCNoDfsZ4nSb2p3DSqzPFQ==
X-Received: by 2002:a05:6402:1057:b0:474:a583:2e25 with SMTP id e23-20020a056402105700b00474a5832e25mr957226edu.5.1671120473089;
        Thu, 15 Dec 2022 08:07:53 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id l16-20020aa7c3d0000000b00467481df198sm7590076edr.48.2022.12.15.08.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 08:07:52 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p5qm0-006NhA-0E;
        Thu, 15 Dec 2022 17:07:52 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        newren@gmail.com, Jacob Keller <jacob.keller@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/4] Optionally skip hashing index on write
Date:   Thu, 15 Dec 2022 16:56:11 +0100
References: <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>
 <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
Message-ID: <221215.865yec3b1j.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 15 2022, Derrick Stolee via GitGitGadget wrote:

> Updates since v2
> ================
>
>  * Patch 2 now has additional details about why to use the config option in
>    its message. The discussion about why the index is special is included in
>    the commit message.

Re the comments I had on an earlier version[1] I tried this series with
these changes squashed in:
	
	1:  b582d681581 = 1:  53d289cf82c hashfile: allow skipping the hash function
	2:  00738c81a12 ! 2:  db487f3e76d read-cache: add index.skipHash config option
	    @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempf
	      
	      	f = hashfd(tempfile->fd, tempfile->filename.buf);
	      
	    -+	git_config_get_maybe_bool("index.skiphash", (int *)&f->skip_hash);
	    ++	repo_config_get_maybe_bool(istate->repo, "index.skiphash", (int *)&f->skip_hash);
	     +
	      	for (i = removed = extended = 0; i < entries; i++) {
	      		if (cache[i]->ce_flags & CE_REMOVE)
	3:  86370af1351 = 3:  35188bbcfb5 test-lib-functions: add helper for trailing hash
	4:  6490bd445eb ! 4:  4354328e8fc features: feature.manyFiles implies fast index writes
	    @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempf
	      
	      	f = hashfd(tempfile->fd, tempfile->filename.buf);
	      
	    --	git_config_get_maybe_bool("index.skiphash", (int *)&f->skip_hash);
	    +-	repo_config_get_maybe_bool(istate->repo, "index.skiphash", (int *)&f->skip_hash);
	     +	if (istate->repo) {
	    ++		int ours, theirs;
	    ++
	     +		prepare_repo_settings(istate->repo);
	    -+		f->skip_hash = istate->repo->settings.index_skip_hash;
	    ++
	    ++		ours = istate->repo->settings.index_skip_hash;
	    ++		theirs = the_repository->settings.index_skip_hash;
	    ++
	    ++		if (ours != theirs)
	    ++			BUG("ours %d theirs %d", ours, theirs);
	    ++		f->skip_hash = ours;
	    ++	} else {
	    ++		f->skip_hash = the_repository->settings.index_skip_hash;
	    ++		/*BUG("no repo???");*/
	     +	}
	      
	      	for (i = removed = extended = 0; i < entries; i++) {

With those all of your tests still pass. Which leads to these outstanding questions:

a) If we're doing to use "istate->repo" in 4/4 why not do so in 2/4,
   neither patch discusses *that* part of the change.

   On an unrelated topic there's this[2] fix-up of yours, 2/2 still
   seems like it needs the same treatment.

b) In 2/4 we'd get the config if "istate->repo" was NULL, if you
   uncomment that BUG() in the squashed 4/4 we'll get test failures all
   over the place. Aren't these places where we'd get the config before,
   but istate->repo isn't set up properly, so with 4/4 we won't get it?

   Maybe that's desired, but again, neither commit discusses this
   change.

Now, I *think* it's a good idea to defer to the already set-up
'istate->repo', but I also know (and have some local patches to fix...)
about the cases where we don't set it up (but should), so it can't be
fully relied on.

So even if we can't produce a behavior difference, just doing e.g.:

	struct repository *r = istate->repo ? istate->repo : the_repository;

And then using:

	prepare_repo_settings(r);
        f->skip_hash = r->->settings.index_skip_hash;

Seems sensible. I just don't get why 4/4 has that seeming fix-up of 2/4
after-the-fact. Isn't it better to carve that bit out of 4/4, just do
the config setup in repo-settings.c to begin with, and have 4/4 do what
its $subject says, i.e. to have "feature.manyFiles" imply this new
config?

The rest of this all looks sensible to me, sans some isolated things
I'll comment on on individual patches.

1. https://lore.kernel.org/git/221212.86v8mg4gr2.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/857d1abec4cf124e011c7f84276ce105cb5b3a96.1670866407.git.gitgitgadget@gmail.com/
