Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E589F30BF4F
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063962; cv=none; b=lLYQKiCDFWoa37b2tDsDkZ3dISa7BJC+JxBDIeGqj6kUxm4Tvu2QtAfVnwvbK2PlRAf4NbhKB/rWJraengZqtedWMCtFt04De4vod7lciLEA7/InvOfJK/it/ks8Q8bQ+mIUWvjgt8NCzffNQwrXOD3bRmEq5+0eAppNp+fXeGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063962; c=relaxed/simple;
	bh=eCm5T2Z3FKSPTaKNvtSojPUBEVBb8UoNHmCrqekqBfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOGdSoH4OPHCuyCq1hkh45s4XFgtExsVlJeusn5p1CcNNiHaYTlvWkZuG39/KMWam5+KcGa21AZ2KkDw93CV8zYU1XvnQzXNqmf2WDNJ86CVmpYwfTkXfF8IKcRugY39I0mxKSrIv6ojv2u3+9Ebn9iZLNupcpoFSuSFHElDBrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=On2VJk3m; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="On2VJk3m"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a283c44478so13928665e87.3
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 13:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777063959; x=1777668759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgAknIsuGhm7pAI+QcXtOK1CQEyjfaBovnWP9TkkniI=;
        b=On2VJk3mFKD6AFH9q81po+HgQQ/E1idwGvG22KoAdbthR5hotCjHswDm583Sle8ORK
         Wa+Smo7prldbfwbt5WNA0OLaNyG9gZVh+muzy27gDlCwloI1PBcehpbI9jJpigqnlNs3
         9b1Bz7ikuHym8UmOs/fdyraS80ejfi7SUtCVxJZt3KRPYZUslMr+TqUNybAdhIYEVFNi
         byoDYuh6U/cfMWEd6ICyk3QCTMmMvyRNZWJZEJJ/oTKYMz4mTm+xOh6iJcbdvneyVRfU
         FIEMUJLjUo8pkfTBOThiszil0OJ9fqrZArWtPEZXkhk6JjfYxuUCtBEfyUxaMa+v1j5U
         BFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777063959; x=1777668759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EgAknIsuGhm7pAI+QcXtOK1CQEyjfaBovnWP9TkkniI=;
        b=r1rFKbxe8nBm0GGpAwOKuVfef38Y3Y77/Aq38Rv9k5Qo81grNPQQA1gi1+hepsiHer
         pqv+oOFbXDiY2G/yFvd6RvUoPR7oy9lP8kYwp2rAfM2kqER9H0G7jmgA6etiW1vyEysw
         AkumHt34MVo28I7Bjx5s19WT2z2JkF3H0F0/DyWWkPW6TOyHBiMzMmGUuR5dOiRzel4v
         H7ddJ6mE3M19wjqJwFGhjTEHYnyNwosd+vfp6YVAZn6zF5oXzfuzFpRMsYlBxIypyKN1
         mtVWNN4TT7wSfGx1VbUiu8i680IfK/q0AYAZr+4ULsN18Lf5s+sjlV3XyivtOA97OqLF
         N07g==
X-Forwarded-Encrypted: i=1; AFNElJ+28tmIDK9M0kTSrjb+LQl65RdEBrfTbSsrzisNEJUdATyfOJgRIgPftm8c/oGNVeQZ4Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbn5TO0EkO/YaEPjnKWEQ9GLftNUP0aRz8PR1G5R/tQuSOIQ8f
	M0yC8Qt+snfFVXNj2s0lC1fDEg8dIziLg3nFHM8MidoYBAKZl4xxcYZUkRD8cttW
X-Gm-Gg: AeBDietSP68mXTmyorKUAnSx2xC/OlYplvpeCgDF7QAwwAOB7dBUZizGP5Z5WLU/Cbe
	lQKIksak9d1IHCJ7rekfZfnthun0GaMsJFejjFNW2iZtLw1XBIZlbgRB75U2Plptd/tRebMtkBf
	ivN3G4zMydW5FagLZFpf3sPvJj8IaOWS33uAfaC4sTFSolqmW8tkHERQbCBSURrAgPdUlFZ4vji
	s6scdI/U9DQT74hgnEJyt9q0t+6L2WaarJWVFcjDjrBQZtqCqkvEcCB+qPNLBJH/w2BWwEN6+sw
	7ZjRtjR/mrSyTuHg9a8RZoyGvh6PXjy96skAjf27NO71GmTh16ymdao6JO4YWfBHfxEfSrEOiQn
	itq4//pElqXs8+LpmZB4BETN+W3qf9cA9fC9x1JfarmCUZJVXB9wC0JS8WcPNTQGoDPgoULFzkq
	ECuqUvVmRBjM64oFulVkuSdSNaKJdz3F+WeaeCjNdxkUjAb7qQGlZD8QrcV/I9c8nhcQ9kXK9Jx
	JYtvomvTqhnUA4yKr/5/vcZaso=
X-Received: by 2002:a05:6512:3b25:b0:5a2:a8ab:ab4d with SMTP id 2adb3069b0e04-5a4172daacfmr10739714e87.22.1777063958783;
        Fri, 24 Apr 2026 13:52:38 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187e11ecsm6332143e87.47.2026.04.24.13.52.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Apr 2026 13:52:38 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: Comments on Phillip's review
Date: Fri, 24 Apr 2026 22:52:37 +0200
Message-ID: <20260424205237.65227-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0-rc2
In-Reply-To: <65f77343-2ee6-4ed6-adb2-271814148310@gmail.com>
References: <65f77343-2ee6-4ed6-adb2-271814148310@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> ret is -1 so we return the same value if unpack_trees() fails as do the
> checks at the top of the function do when they fail with "return
> error(...)". Therefore we cannot determine whether a failure of this
> function is due to unpack_trees() or not and so we wont know whether to
> autostash or not. You need to return a unique value here like -2 (or
> ideally a named constant)

👍

> Good - now we only try to restore the stashed changes if we actually
> stashed. However we only restore the stashed changes if there was an
> error(). If there isn't an error we call update_refs_for_switch() before
> restoring them. It would be safer to restore them straight away in case
> that function ends up dying for any reason (though I think that's pretty
> unlikely)

I hope I understand correctly, the code becomes easier this way, so that's
nice!

> As I said last time we should not be calling apply_autostash() if we
> have not created an autostash. We should also not discard and re-read
> the index if we haven't stashed. I do think we'd be better restoring the
> stashed changes in a single place as I said above.

Makes sense.

> where the changes appear to be part of the advice message. Perhaps we
> should print a short (i.e. one sentance) message along the lines of
> 
>         The following paths have local changes
> 
> We should test what the user sees here as well.

Add that message.

Do you mean to test the full output? I'm not against it at all, but that
seems to be going against the convention of the other tests in this file.
But it would be a more robust test.

> I'm not sure we need to say "local changes" twice here

👍

> I find the bulleted list a bit odd, maybe
> 
>         You can either resolve the conflicts and then discard the stash
>         with "git stash drop", or, if you do not want to resolve them
>         now, run "git reset --hard" and apply the local changes later by
>         running "git stash pop"
> 
> would be better?

Much cleaner, thanks!

> we already have tests for --conflict=diff3 and
> --conflict=merge I'm not sure this test adds much.

Deleted.

> > +
> > +     cat <<-EOF >expect &&
> > +     a
> > +     <<<<<<< simple
> > +     c
> > +     ||||||| main
> > +     b
> > +     c
> > +     d
> > +     =======
> > +     b
> > +     X
> > +     d
> > +     >>>>>>> local
> > +     e
> > +     EOF
> > +     test_cmp expect two
> > +'
> > +
> > +test_expect_success 'checkout -m respects merge.conflictStyle config' '
> 
> Looking at the existing tests, 'checkout with --merge, in diff3 -m
> style' and 'checkout --conflict=merge, overriding config' already test
> that we respect merge.conflictStyle and that --conflict overrides it so
> I don't see what new coverage this test adds.

Deleted.

> > +test_expect_success 'checkout -m skips stash when no conflict' '
> > +     git checkout -f main &&
> > +     git clean -f &&
> > +
> > +     fill 0 x y z >same &&
> > +     git stash list >stash-before &&
> > +     git checkout -m side >actual 2>&1 &&
> 
> file "same" is unchanged between branch "side" and "branch" main so we
> do not need to stash it.

Deleted.

> > +     test_grep ! "Created autostash" actual &&
> > +     git stash list >stash-after &&
> > +     test_cmp stash-before stash-after &&
> > +     fill 0 x y z >expect &&
> > +     test_cmp expect same
> 
> Even if we created an autostash this test would not pick it up as the
> stash is not written to refs/stash unless there are merge conflicts and
> we don't print "Created autostash" even when we do create an autostash.
> The same is true for "checkout -m -b skips stash with dirty tree" below.
> I don't see how we can check that a stash was not created without using
> GIT_TRACE to see if we run "git stash". Even that is fragile as we might
> start stashing without forking a separate process in future.

Deleted.

> I don't think the two tests above add any extra coverage when we have
> the one below so they can be deleted. Our test suite is slow enough
> already - we only need one test to fail for any given issue.

Deleted.

> > +test_expect_success 'checkout -m stashes on truly conflicting changes' '
> 
> This use of conflicting is rather confusing - what's the difference
> between a conflicting change and a truly conflicting change?
> 
> I think a single test is sufficient to check that we create a valid
> stash entry

Updated.

> test_expect_success 'checkout -m which would overwrite untracked file' '
>         git checkout -f --detach main &&
>         test_commit another-file &&
>         git checkout HEAD^ &&
>         >another-file.t &&
>         test_must_fail git checkout -m @{-1} 2>err &&
>         test_grep "another-file.t.*overwritten" err
> '
> 
> which passes on master but fails with these patches applied. We need to
> make sure that we don't set "quiet" in unpack_tree_opts the second time
> we call merge_working_tree(). The test could be improved by adding some
> local changes.

Tricky to get right, the test if very good to have! I rewrote the logic now
to make this test pass, I hope it looks better now.


Harald
