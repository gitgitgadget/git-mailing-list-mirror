Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2C5C05027
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 01:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjBIBrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 20:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjBIBry (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 20:47:54 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4771F5EB
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 17:47:53 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id l12so894789edb.0
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 17:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2jMGGsJYQUB3CDnXyuDrCMzi6fglZcd9QbdWYEL52KQ=;
        b=fEMXjNrJxQtMRE3YXavq1JT8UWoIijvRpjH5WqU8KSFoR0fR0kheohl7OC4McnVcpB
         IZbaNkKkTXhAMxcnlsShtOciwpRXtFKz+FwShmUrsh02ERJ13s2oYuCfZ1EzyAiU1CuY
         NISuCv9x42gbk1twYp57qjCnHfYgWyaaMUvSN8iO+VXpXGfpfM5AUZX9EE1KnxkVb93a
         yiB35SN5IxqAJk9nqq5sJzohI5Us1HBbo4bAAYYmfeEnt7nvDpmxtgUJVqZfKNC12e0Y
         R96J2sg0uZ/AtU4vkKwGahAPX8WYRJj22Cj4+tK38u8ucqjYGN7vbTpJrEjfcQiEeLTd
         eZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jMGGsJYQUB3CDnXyuDrCMzi6fglZcd9QbdWYEL52KQ=;
        b=u+BG7wcCvf7C0zyehFhzs6titsNkwlwuUGyYWYF9H19M1cVOeNPt6uEjSFKlRk6H1a
         nNbsBWbMXQ46a022h0Ja+QRuKEKlYW9pPujhLTUTkPyuMwaOb3GPNwW4pTR0G7XtYjyk
         5IOIZ6a91MMnRDL2QLdQ0QUuxaRCjjJ3uJ3nmEWfKsjumaOoS4EeccZ+NJb37HU3/iMT
         6jPr6GmA3OB6bwpXBIB2FlKWY8Uj8xRjMOfgfM3skR7v/hq47M7FzzdEgB4TWSGDsZHL
         0DG0ZWJBzXHpC2gzxr1LCFLEC2kJ9IGtWHEfSxTMWAuqIBf8+cs+6GPvJFZ0fLwktPaj
         BgqQ==
X-Gm-Message-State: AO0yUKV5LE7Vi3zSqCvv9VXVBedm35dse59EfspZrI8bTrGL9rE7hiaf
        xK4rYRpI6crGwfUyZDjf2dv9A3zJv7+Sr51a
X-Google-Smtp-Source: AK7set9trxLm0LqIDBUwleXytWDWUsJd3h4/clM0diw2u9TGbXjnsYOTCrQiSxRmA6Wb4D2Drqc3Vw==
X-Received: by 2002:a50:a694:0:b0:4aa:a131:cbfb with SMTP id e20-20020a50a694000000b004aaa131cbfbmr8816592edc.6.1675907271378;
        Wed, 08 Feb 2023 17:47:51 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id u1-20020a50c2c1000000b004a21263bbaasm100281edf.49.2023.02.08.17.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 17:47:50 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPw2Q-001aiS-0p;
        Thu, 09 Feb 2023 02:47:50 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, newren@gmail.com,
        jonathantanmy@google.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v8 0/6] submodule: parallelize diff
Date:   Thu, 09 Feb 2023 02:42:15 +0100
References: <20230207181706.363453-1-calvinwan@google.com>
 <20230209000212.1892457-1-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230209000212.1892457-1-calvinwan@google.com>
Message-ID: <230209.867cwrzk1l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 09 2023, Calvin Wan wrote:

> 6:  0d35fcc38d < -:  ---------- diff-lib: refactor match_stat_with_submodule
> 7:  fd1eec974d ! 6:  bb25dadbe5 diff-lib: parallelize run_diff_files for submodules
>     @@ diff-lib.c: static int check_removed(const struct index_state *istate, const str
>      +				     unsigned *ignore_untracked)
>       {
>       	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
>     - 	struct diff_flags orig_flags;
>     +-	if (S_ISGITLINK(ce->ce_mode)) {
>     +-		struct diff_flags orig_flags = diffopt->flags;
>     +-		if (!diffopt->flags.override_submodule_config)
>     +-			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
>     +-		if (diffopt->flags.ignore_submodules)
>     +-			changed = 0;
>     +-		else if (!diffopt->flags.ignore_dirty_submodules &&
>     +-			 (!changed || diffopt->flags.dirty_submodules))
>     ++	struct diff_flags orig_flags;
>      +	int defer = 0;
>     - 
>     - 	if (!S_ISGITLINK(ce->ce_mode))
>     --		return changed;
>     ++
>     ++	if (!S_ISGITLINK(ce->ce_mode))
>      +		goto ret;
>     - 
>     - 	orig_flags = diffopt->flags;
>     - 	if (!diffopt->flags.override_submodule_config)
>     -@@ diff-lib.c: static int match_stat_with_submodule(struct diff_options *diffopt,
>     - 		goto cleanup;
>     - 	}
>     - 	if (!diffopt->flags.ignore_dirty_submodules &&
>     --	    (!changed || diffopt->flags.dirty_submodules))
>     --		*dirty_submodule = is_submodule_modified(ce->name,
>     ++
>     ++	orig_flags = diffopt->flags;
>     ++	if (!diffopt->flags.override_submodule_config)
>     ++		set_diffopt_flags_from_submodule_config(diffopt, ce->name);
>     ++	if (diffopt->flags.ignore_submodules) {
>     ++		changed = 0;
>     ++		goto cleanup;
>     ++	}
>     ++	if (!diffopt->flags.ignore_dirty_submodules &&
>      +	    (!changed || diffopt->flags.dirty_submodules)) {
>      +		if (defer_submodule_status && *defer_submodule_status) {
>      +			defer = 1;
>      +			*ignore_untracked = diffopt->flags.ignore_untracked_in_submodules;
>      +		} else {
>     -+			*dirty_submodule = is_submodule_modified(ce->name,
>     - 					 diffopt->flags.ignore_untracked_in_submodules);
>     + 			*dirty_submodule = is_submodule_modified(ce->name,
>     +-								 diffopt->flags.ignore_untracked_in_submodules);
>     +-		diffopt->flags = orig_flags;
>     ++					 diffopt->flags.ignore_untracked_in_submodules);
>      +		}
>     -+	}
>     - cleanup:
>     - 	diffopt->flags = orig_flags;
>     + 	}
>     ++cleanup:
>     ++	diffopt->flags = orig_flags;
>      +ret:
>      +	if (defer_submodule_status)
>      +		*defer_submodule_status = defer;
>     @@ diff-lib.c: int run_diff_files(struct rev_info *revs, unsigned int option)
>       				       changed, istate, ce))

I think you dropped the 7/8 per my suggestion in [1]. I think this 6/6
is actually worse than the v6.

I.e. it seems you dropped the previous refactoring commit by squashing
the refactoring+functional change together.

What I was pointing out in [1] was that you don't need the refactoring,
and that both the change itself and the end-state is much easier to look
at and reason about as a result

I.e. I think the diff in your 6/6 should just be what's after "it
becomes" in [1] (maybe with some pre-refactoring, e.g. we could add the
braces first or whatever).

But in case you strongly prefer the current end-state I think having
your previous refactoring prep would be better, because it would at
least split off some of the refactoring & functional change.

I haven't looked as deeply at this v8 as v7 for the rest, but from
skimming the range-diff it all looked good otherwise.

1. https://lore.kernel.org/git/230208.861qn01s4g.gmgdl@evledraar.gmail.com/
