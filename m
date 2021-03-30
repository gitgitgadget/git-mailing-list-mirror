Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4673C433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 18:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C43061985
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 18:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhC3Sv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 14:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbhC3Sva (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 14:51:30 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC2FC061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 11:51:29 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id o10so25286335lfb.9
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 11:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DyDPHP4R48+XlST+S53CN3rCp2KNfjT7QMfzh/aqioE=;
        b=Iam1IRexN1nu/UcnhSpLPav/8XDXsTvIyUrN17DIJUn6OHTdJ4tuYOiPQK/xDz++Sz
         9EXXy+HHhD6SNErUnCvwE2wPKHLCoTqGylGlsRPYF/DpvdAsxtis6gZOUVMQGgXUUzSI
         NPS5lK03JC2IC2cnBGBYEzwrIZkheDqGnbSMue2WZ/7UvXDV72IKc0lKJfoXjmDzdFt0
         FSMJWKblyyGUWx9ii2PyanQJR5gD1pWffZbztCtkM4PFHjVgmWQktPBPXLBCsdi2RAeY
         a3kywUkiA734nqpshUVSXIU4kgscAJerCs8s0iA3bxHN1X6pYUt7huDPa68eGvr79MQz
         +0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DyDPHP4R48+XlST+S53CN3rCp2KNfjT7QMfzh/aqioE=;
        b=g8HfvHeIUf/WJ4UytECV9prHhZ/6z5RL0Go7658zgKY+dq9UFLbXSwDqIUvTBjSm/m
         iUEY846T++VF2sjQkeTLUoAYq82RzRplnYUr8tev/a/O91vUG47mCOC8s4AZ7xg66abz
         LkNEDQcTZyqpj6zL7datqSdNU+6QSbal1xj5ia/ep3Z4X+qSqEqsZxC+3aw2U2w0T2J8
         bafJEyRrXhPM9Eqr+bvow9ace2yvdKRxob5enNt+n61wzx+yLjBgHwwaLz79NrYlXGq7
         NdouQZv8NWaSszydeGnS1JXJ7l4GuYlvESdI0I7uB4mW5/K6Fo4S6qQxAiI0z7kB3GJ0
         B1Dw==
X-Gm-Message-State: AOAM5325dSQ8zzJC6wr9TpZSJeXgjAyQHuy8etneomrTpmHP+E9T0Jp8
        v5jTcmYiN/FUF4LD8rz1I0LavlcoFvrUKnOEJ6nXVw==
X-Google-Smtp-Source: ABdhPJz0UqkSZb4m6zs85w0uTrlEkD0oaTIfXn3XRSJuNCSBClYFmGX+pliDbb2IZsOAD6cp4tZL2jC0u3US69dsXn8=
X-Received: by 2002:ac2:5446:: with SMTP id d6mr19995402lfn.527.1617130288386;
 Tue, 30 Mar 2021 11:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615588108.git.matheus.bernardino@usp.br>
 <34a61a0d03868c43d68a04bca8d86dd98de2aa28.1615588109.git.matheus.bernardino@usp.br>
 <xmqqsg4sowks.fsf@gitster.g> <xmqqo8fgovuz.fsf@gitster.g> <CAHd-oW4V4_XrY7XfQO1gLEZZmzcLbG0_M2ys+Meh4Ysu0Psz0Q@mail.gmail.com>
 <xmqqlfajnn6w.fsf@gitster.g>
In-Reply-To: <xmqqlfajnn6w.fsf@gitster.g>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 30 Mar 2021 15:51:17 -0300
Message-ID: <CAHd-oW4kRLjV9Sq3CFt-V1Ot9pYFzJggU1zPp3Hcuw=qWfq7Mg@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] refresh_index(): add REFRESH_DONT_MARK_SPARSE_MATCHES
 flag
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 19, 2021 at 1:05 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:
>
> >> In other words, the change makes me wonder why we are not adding a
> >> flag that says "do we or do we not want to match paths outside the
> >> sparse checkout cone?", with which the seen[] would automatically
> >> record the right thing.
> >
> > Yeah, makes sense. I didn't want to make the flag skip the sparse
> > paths unconditionally (i.e. without matching them) because then we
> > would also skip the ce_stage() checkings below and the later
> > ce_mark_uptodate(). And I wasn't sure whether this could cause any
> > unwanted side effects.
> >
> > But thinking more carefully about this now, unmerged paths should
> > never have the SKIP_WORKTREE bit set anyway, right? What about the
> > CE_UPTODATE mark, would it be safe to skip it? I'm not very familiar
> > with this code, but I'll try to investigate more later.

Sorry I haven't given any update on this yet. From what I could see so
far, it seems OK to ignore the skip_worktree entries in
refresh_index() when it is called from `git add --refresh`. But
because we would no longer mark the skip_worktree entries that match
the pathspec with CE_UPTODATE, do_write_index() would start checking
if they are racy clean (this is only done when `!ce_uptodate(ce)`),
which could add some lstat() overhead.

However, this made me think what happens today if we do have a racy
clean entry with the skip_worktree bit set... `git add --refresh` will
probably update the index without noticing that the entry is racy
clean (because it won't check CE_UPTODATE entries, and skip_worktree
entries will have this bit set in refresh_index()). Thus the entries'
size won't be truncated to zero when writing the index, and the entry
will appear unchanged even if we later unset the skip_worktree bit.

But can we have a "racy clean skip_worktree entry"? Yes, this seems
possible e.g. if the following sequence happens fast enough for mtime
to be the same before and after the update:

  echo x >file
  git update-index --refresh --skip-worktree file
  echo y>file

Here is a more complete example which artificially creates a "racy
clean skip_worktree entry", runs `git add --refresh`, and shows that
the racy clean entry was not detected:

# Setup
echo sparse >sparse
echo dense >dense
git add .
git commit -m files

# Emulate a racy clean situation
touch -d yesterday date
touch -r date sparse
git update-index --refresh --skip-worktree sparse
touch -r date .git/index
echo xparse >sparse
touch -r date sparse

# `git add` will now write a new index without checking if
# `sparse` is racy clean nor truncating its size
touch -r date dense
git add --refresh .

git update-index --no-skip-worktree sparse
git status
<doesn't show that `sparse` was modified>

This situation feels rather uncommon, but perhaps the same could
happen with `git sparse-checkout set` instead of `git update-index
--refresh --skip-worktree`? IDK. This made me think whether
refresh_index() should really mark skip_worktree entries with
CE_UPTODATE, in the first place.

Any thoughts?
