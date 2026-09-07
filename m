Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955AA36F429
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 04:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756310; cv=pass; b=oZTfxDy0G8JdXOT661g0Ul0vcmRSdol/+mPx4GXFBTwYAlcJZc+XQYs6JkY5/IbkmmUm+hWl2w3BkMF64XaTw7KJJ/NFiX2YTolwT9nHmr4lHJzKJOzCVU2GPlWtz7bjeb4uwtWqzAvQ5YfHfISSQhb7m3Ok9q2nCgFt3DwpmZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756310; c=relaxed/simple;
	bh=4XBHMQmgKyI+f2twa8mOMuhMbgRlGZSxniTuXvUI3MA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=aFM5JfJy8Z4wiriBPYSDbJ7mtt+xT3V/7bolDkAs9mNBBA9xfx2DMzGFkHHgo6bWp2Bw1ItwiJtVeh6R5197BHmADYQJRzuywfZpprOMvMe0hGQsuYmnOEuRcSlL6I9Ob2Gz0GU2x6/rMbYspcVRytRY+ZBWLuawdQlqZJNSxa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barzilay.org; spf=none smtp.mailfrom=barzilay.org; dkim=pass (2048-bit key) header.d=barzilay-org.20251104.gappssmtp.com header.i=@barzilay-org.20251104.gappssmtp.com header.b=Hgb0fI1S; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barzilay.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=barzilay.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barzilay-org.20251104.gappssmtp.com header.i=@barzilay-org.20251104.gappssmtp.com header.b="Hgb0fI1S"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49c5a927a1fso573775e9.2
        for <git@vger.kernel.org>; Sun, 06 Sep 2026 21:45:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788756307; cv=none;
        d=google.com; s=arc-20260327;
        b=Y4QLGnMTPuVD7civZAspu9UcpGlk6mbkyjxZU5sEIoBes1lgJidetpfg0cGUp+WgFD
         rklMkDQKqsaW+rAi2z9thYq9wk2WtITcaA7g/iL4uUPYrOlSOUTb0/zV0pXHMAOgCPWK
         AOAdxVjX7V3HflZqE4ENRewrRda9GFwwTPmckD/g+FlAet+JhC9pHGi7BR32jxORdbj/
         M+VDZMhZqdjk05yzVDgtgEbX520bMQcWCxI0PLJgDVyBaQJmiTqvgXdu9Oyqg8XK9ENs
         2+slN2ET+7JXLsSyTCTznyEDOFErXlC/6qmaCBq8vWMsrNt26dSsuVh9awED4UNjmPQf
         AfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=fw9g219jGAXFDjwdzECww8mlgdQbnbgc9jTMAbA8ENE=;
        fh=EbAi3aH7dvp5fWvHzbiEGXPrqvy29bDdGM5R7Dlg3ME=;
        b=av1yKyO/K+FZSg3ZwAwPmL+Qp79G8f9OIUhMwbtFqUkpzlUFQIlY4a6fmKiJhCTQr3
         CcaMCdGN+uJ3NLKQ16iCyb7lNnosGXC24dLDhPJuXMabRyMebsix2RJKQob/MMq/9cxn
         zMdWitd3TcVV/6FTW7qtqeLEnNLnKf2Cc17N9+zKHdyXySalKLzZnkkQdHyB44dS+G2d
         NDyYN7HNScN18Dy+EqOKDX58UfPzN+MM9UHUoSETFDVAzJfUJzD+waaGNGWENKeACh6c
         GhGyHMyyoDr427PamQB5qkdYBRwCKuWvcmrRY9YuJAF4Lw9WFEuTETNvM2OPRXl68Y+/
         t24A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=barzilay-org.20251104.gappssmtp.com; s=20251104; t=1788756307; x=1789361107; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fw9g219jGAXFDjwdzECww8mlgdQbnbgc9jTMAbA8ENE=;
        b=Hgb0fI1SZ4Bm0PriDvEAfVMi9FBWqVbIcbVLbY06oZsOhR34dv/fu+S/hFA/VoqMmZ
         r6pmPDZkdp4Tfkg/FbMWaRICneZQjrq7dRFUIt/FDhaV77w/Wxmv4RlrH7GBVZ2SR/Ag
         SE/hv4/1DupKj1AO/K3b502Or30SApGAEkFIqITAAfZTo3kpiWbhBL5ngnItMnBK8zG4
         Dkz5y34Rc/b5GBYGVY2cz7/iG+n9N+f6lu6GMa0hiPekuIkh9FFZZr9usF03MrhOh/09
         vQiByTPVIrb412ATxNFLrpAnwyGriFh4WjfM2s4HDX+RJ+v7hqfDOiHl6wZYZaIkUTzA
         /D6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756307; x=1789361107;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fw9g219jGAXFDjwdzECww8mlgdQbnbgc9jTMAbA8ENE=;
        b=e6nqwlY9PcfKt2CR0SYHSZUEefYTPOh5SrCRkWGizJAGzFXr8rkqJ5GUe9SWWcrec/
         8NJkEZnlBI0L7scMoUu7Q9OJ880TKGKNZJPERBQ23rix73svr3pP6RHXG7885sLs3a97
         oguGdl3gH9g8fFIlpV+T9PdtHN2ygUNRLwkR8mrP1c9Ew82vAnhZz/a/U6wU+ba2eUWl
         TEWoVlobgIdyz7c4Xk5oDF4GbVPzLnEt8QxP1o2A0TK2D6S7h2sWj2X07EFnHDid/aSM
         ENYd2myWusE+9yoj6OO36woiorZtZjaIik7tmdPAoisR0qspVwRzBvOQa3/V7qBRnVo9
         /s8A==
X-Gm-Message-State: AFuF++k/xXfkhFIyz1Lh+wHJ/3tEhBkgNJRA1QprjkdoiXVlPXBkOQw7
	O7eomAVwW8wdqd4YWL86dcLcIalvCs6bjaiiPlqHsnWYJiuV/Ddtg+WjCmBJ5oJNbm0FVPQbOX0
	igocd24i5t0ESkEkev4Ihbo7tH+J6lc6jiGfvbzNogm77zZ2ftX5puw==
X-Gm-Gg: AYBFou2lvLUjSiviSOL4aYHw6W1Ar6Lqo97LIHBBMaNi2l/uV7JZ3+y1/yRWLf/1XXd
	hS5jlRl8NFm0p7PwLhlQmxEoHxdoJMv3fatY3hQkOETKjSNQDaRRZaz3Ww3TXWDfxT71gQRWMdH
	84+yayaq2KM2D2fTpE+AtZhHIS2F+UQT+223laOHjRCdOeAQLqwjGjXyifCzyVXoOi5LQZ2gHGP
	nbuKr/yI3C6HINlSMJuMcJMnJLmNpghRm/UFRno/9viX44ef+mZW/Q5bz6XthnrP03AeWMXQfEb
	fvYdnLZZFZYPgk7TLKdMwRPt7joq95qzrfUYZ1abETlOOCa6aD2Q49ZSGjSRn/JkprZQqkRHmlf
	M6VIL8upeGFp3njPBLM0waqyZ
X-Received: by 2002:a05:6000:2501:b0:482:f930:95be with SMTP id
 ffacd0b85a97d-485907aaad6mr11310844f8f.2.1788756306460; Sun, 06 Sep 2026
 21:45:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eli Barzilay <eli@barzilay.org>
Date: Mon, 7 Sep 2026 00:44:23 -0400
X-Gm-Features: AcwNN1XEykFB8ypcGf2-S5BXMTrPssK4A3dr-tioajjFZvV54I98MyUlLTmO0p0
Message-ID: <CALO-guvbk2TcrVwzdNQ3yRpzHr0HHZ3h1wite0Xp0sUyAT4otA@mail.gmail.com>
Subject: [BUG] stash.index=true leaves a redundant stash entry after an
 autostash fast-forward
To: git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Disclaimer, the following is written by an agent, but the bug is a
real problem that I have.


With stash.index=true, an autostash that is applied successfully is
nevertheless stored as a stash entry, and deleting MERGE_AUTOSTASH
fails.  A staged change at the time of the merge is required to
trigger it.

Reproduction (independent of the reporter's configuration):

    #!/bin/sh
    set -e
    export GIT_AUTHOR_NAME=A GIT_AUTHOR_EMAIL=a@b \
           GIT_COMMITTER_NAME=A GIT_COMMITTER_EMAIL=a@b
    rm -rf /tmp/gitbug && mkdir /tmp/gitbug && cd /tmp/gitbug
    git init -q -b main up
    cd up && echo a >u && echo z >z && git add . &&
        git commit -qm base && cd ..
    git clone -q up dn
    cd up && echo more >>u && git commit -qam up2 && cd ../dn
    echo staged >>z && git add z          # a STAGED change is required
    git fetch -q origin
    git -c stash.index=true merge --ff-only --autostash origin/main
    echo "--- git stash list:"; git stash list

Actual output:

    Updating 34a5e40..84ccd9d
    Created autostash: 71d4617
    Fast-forward
     u | 1 +
     1 file changed, 1 insertion(+)
    Applied autostash.
    error: cannot lock ref 'MERGE_AUTOSTASH': unable to resolve
reference 'MERGE_AUTOSTASH'
    --- git stash list:
    stash@{0}: autostash

Expected: the same without the error and with an empty stash list, as
happens with stash.index=false (the only change to the script).

The autostash is applied correctly, so nothing is lost: the leftover
entry duplicates what is already in the working tree and index.  The
command also exits 0, so the error is easy to miss, and the entries
accumulate one per merge.

Reported via `git merge` above for brevity, but the common way to meet
this is `git pull` with rebase.autoStash and pull.rebase set: when the
pull can fast-forward, builtin/pull.c:1164 hands off to
`git merge --ff-only --autostash` rather than to rebase.  Every such
pull with something staged leaves an entry behind.

Analysis
--------

Merge keeps its autostash in the MERGE_AUTOSTASH ref
(builtin/merge.c:1675) and applies it from finish()
(builtin/merge.c:540).  apply_save_autostash_ref() resolves the ref,
applies it, and then deletes it (sequencer.c:4821-4848).

The apply is a child process, `git stash apply <oid>`
(sequencer.c:4737-4751).  stash.index turns that into an --index
apply, which takes the index-restoring branch of do_apply_stash() and
calls reset_head() (builtin/stash.c:684-691), i.e. a
`git reset --quiet --refresh` child (builtin/stash.c:455-467).

That reset has no pathspec, so it calls remove_branch_state()
(builtin/reset.c:543) -> remove_merge_branch_state()
(branch.c:829-838), whose last statement is

    save_autostash_ref(r, "MERGE_AUTOSTASH");

which stores the autostash into refs/stash and deletes the ref -- in
the middle of the very apply that was about to consume it.  Control
returns to apply_save_autostash_ref(), the apply reports success
("Applied autostash."), and its refs_delete_ref() then fails on a ref
that is already gone, producing the error line.

The child's own explanation, "Autostash exists; creating a new stash
entry." (sequencer.c:4775-4779), never reaches the user because the
parent mutes the apply child's output (sequencer.c:4736-4738).

A staged change is required because with a clean index the stash's
base and index trees are equal, has_index is cleared
(builtin/stash.c:665-668), and reset_head() is never reached.

The rebase backend is unaffected: it keeps its autostash in the file
.git/rebase-merge/autostash, which remove_merge_branch_state() does
not touch.  Only the merge (ref-based) autostash is exposed.

Possible directions, in case they are useful: remove_merge_branch_state()
is about ending a merge, and `git stash apply --index` is not ending
one -- having stash's reset_head() avoid the branch-state cleanup, or
teaching an in-flight autostash apply to shield MERGE_AUTOSTASH, would
both close it.  Making apply_save_autostash_ref() tolerate a missing
ref would silence the error but leave the duplicate entry.

Versions
--------

Seen with git 2.55.0 on Linux (WSL2).  The code paths above are
unchanged on master as of 2026-09-07.

-- 
                 ((x=>x(x))(x=>x(x)))                  Eli Barzilay:
                 http://barzilay.org/                  Maze is Life!
