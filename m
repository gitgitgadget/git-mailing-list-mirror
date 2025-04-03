Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BEF24E4A6
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743695775; cv=none; b=btpKleikIxsKtYUSYOabyX5OJPLGXBXf9WT70JlbqW2hflJOqfYJxF/baAGQE/3DBTS8pkxHS7zWCtmJBrq9StII0yGZn3Rpq4jDHm5ABstlSdA+jQylyQTsY9b8RDkYe4EHL+weYJkCBtvBNDft7DNy4qaEz/IqfzTqgLF+Iqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743695775; c=relaxed/simple;
	bh=pP1htqVu++BtSFn7piN56nqjmOxlzx6gOv204Xs3knU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJHasS1+Vu7dGnnmYozV9eMQzZyDQM0cBOWjrLBWhnEj7ugOB7j066g8zO/VhOtQJMtsAqRTKWCUbow7DB7YXyqN3hgzQ5N9htsDPzIqESr9VrA5QSnkh+myMFz87jLUL7zcy/D5vG7AKKKAIV5cs44Obt1n1nrSTO0lDwe9VHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2XU2QJq; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2XU2QJq"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d442a77a03so3541015ab.1
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743695773; x=1744300573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHHou+SZXZgNZ7u7macH6eQiG5KNa/A1LoF1PfNKTz0=;
        b=c2XU2QJq3LviADWBpWWciT5S/Gi1lv53XOspop4PGrFojrYiBlQK5rW/4ZmnJSoryG
         ni0+3SxVGqRWrQee+HXAqhOLzLqAsCFjMVQ0Z/9/7ke1ArRtk7kmlQHIU1itjC//nl6Q
         kTV41S5D5xTHxrZDs6kHk9lMtTdzikM7uq5bhiVKE++CGUoVJj518rGFQl3TVFgSUDsR
         n3xT4Ozi1oSI3Mgl3t8BTwoMo5plwuJlDvn2GrEl4rCHnM8p3CgxCv/3upx5P97rLaiB
         R/Rnl9CTGktCzd8ehK0N2fKgA0bpLayIi7s81o8zxzxUHpep+2zrXHxd/0XwQXTbaJO4
         RgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743695773; x=1744300573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHHou+SZXZgNZ7u7macH6eQiG5KNa/A1LoF1PfNKTz0=;
        b=Aq2yaHCsqi8wNyP+w/FzlOUskU8E8VCwIdS0zEiXK0AYxf3ZAyU+7CP0uHVqFqyYk8
         3ysjCvNAeMAPYVhAxD3B4cCbfAaEJ4D/5rdN8F5WhHSTLj9W1I8VdhkyNhR+X2DjQh7n
         kcoR4tjEflWqan86W3bahYtqSzIPEKci+cxcf0NoG1wcHutAjh44hZLHAumVMlUqUaCj
         Wfefti16+0i9k9Zi1T0zGZusT1cxs52XaNMrEPFle1Ka3x/jZnVWsaZVx5WAGqyuzCcP
         GNmn3QzOcjtipolWwuIRrWTTz+pSRmDb54P97q12qGvZXjZJW4gALuZPoyogjKTKWnLH
         2a5g==
X-Forwarded-Encrypted: i=1; AJvYcCXULvelCMv6Yrri/IE0yJzTsxNIiV0A4ZgM4pGqQ7T5PD/iuMpmfgatFFLiHZjMO8txpyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRlvWtT0iLawxhBKAH8EF6oR5qYb+sADvm/Zf5f41qEqGBRfYi
	STYPih1ux6hl+epBUnUd1tR1rNIWClv4Q2oloqSDejAmfoFVWHHWFm1j43BGNszhuXskb6c0eO6
	6ktcmxdoiVvG7V7P++zh7XzBBm7Q=
X-Gm-Gg: ASbGncvQk/xdsfXc0VuHzbkLhjI+saTQURbbUd4FqpA8R9WeKUS2p+tfnAuSkMl6Mwn
	G93U1J8ueBpSiBScphiQ4CzaxinV4EoZpZndrXAzvfwHhkOiOppOvdpR+pxTq90krtMpK0EYTje
	SQWGcqy9mo7VTp1tzkokRQytkhxjWXj/uxsLRoJmthUhjSr9ZJ41ZYt94vUQ==
X-Google-Smtp-Source: AGHT+IHwNCUvfjd2+3GUwXppt56/TvuPiL8mc9DtyvvnpmCviIG6kL4LIW/UmDYaIIj5GzWldgMRraQuUyCBa9asAro=
X-Received: by 2002:a05:6e02:184e:b0:3d3:dcb8:1bf1 with SMTP id
 e9e14a558f8ab-3d5e08eb179mr275796015ab.3.1743695773322; Thu, 03 Apr 2025
 08:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <Z-5QR57zgSsm6jNP@pks.im>
In-Reply-To: <Z-5QR57zgSsm6jNP@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 3 Apr 2025 08:56:01 -0700
X-Gm-Features: AQ5f1JryxgBXGG7jivjVbY2gc-Cmiw_PEbM4mz7FgO7xHfjfygEvTI5UDwiNy3s
Message-ID: <CABPp-BGwXaiohvfSdr96hzKNPYXQqz+_okxLNj7P9KSjX2PW6g@mail.gmail.com>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
To: Patrick Steinhardt <ps@pks.im>
Cc: Martin von Zweigbergk <martinvonz@google.com>, Git Mailing List <git@vger.kernel.org>, 
	Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 2:13=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
[...]
> Agreed, change IDs solve a couple of issues that many users face:
>
>   - You can reliably track how a patch evolves over time. This helps
>     various different tools to track identity of commits, like for
>     example forges, but also tools like git-range-diff(1).
>
>   - It becomes trivial to see whether a commit has been cherry-picked
>     into another branch. We do have git-cherry(1) to do that right now,
>     but that command is based on heuristics and fails as soon as the
>     patch itself needed to be adapted.
>
>   - Working with history rewrites becomes easier in the general case as
>     you don't have to adapt to constantly changing commit IDs.

Could you elaborate?  I agree with the other points you raise, but I'm
unsure how this helps with a history rewrite.  Do you mean the
rewriting of history, or someone trying to consume the history
rewrite?  If the former, I don't see it, and if the latter, didn't you
already cover that in the two bullets above?  Or is there something
else you are also getting at?

> So what would it take to get change IDs into Git? I think the most
> important items would be:
>
>   - Generating and writing change IDs in commands that support them.
>     This includes e.g. git-commit(1), git-commit-tree(1), git-merge(1),
>     git-merge-tree(1). This should of course be completely optional and
>     probably be disabled by default.
>
>   - Making tools that rewrite commits aware of change IDs so that they
>     know to retain change IDs. This involves e.g. git-cherry-pick(1),
>     git-rebase(1), git-replay(1).

And also git-commit(1) [when passing --amend], and git-fast-export(1)
and git-fast-import(1) -- though possibly with options for the last
two to expunge them instead of preserving them, but probably
defaulting to preserving them.

However, I think some of these might already handle this.  Commands
which call read_commit_extra_headers() and pass those along to
commit_tree_extended() may already preserve these.  It appears commit
--amend and replay both do this.  sequencer has some code that looks
relevant, but it appears to only be reading the headers from HEAD (at
the time the nth commit is being replayed), which seems like it'd be
looking at the wrong commit.  That might actually be a bug...

>   - Extending revisions to allow specifying commits by change ID.

Would this essentially be similar to <rev>^{/<text>} except searching
specifically change-id headers rather than commit message?
