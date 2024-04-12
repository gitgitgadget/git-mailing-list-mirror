Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3D851C36
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915962; cv=none; b=gGe45lW7IADNDRkMemOMwAugp2oUi08fimCkY4oYuM8JjphLOc+O+u1gTKoc0B/NJM85rEwHRYTPXMp/gP87kQ20cKYWBeIHjhV/e+2kYoY4kHN8lPQw62nLbecOcs93ujoBFXvgQPrkoHmzsDLiBsopcsPl/KAetEOr+Z9ST/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915962; c=relaxed/simple;
	bh=19Q7BrB1zz2cpYqfBIJdrihsooDvd92R0leMWbaw4sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrITf/KJY4ZQJMPKl8iPL47YVG1dw1Kdm51QnHKUoatwzdfZW6kJv5n6fTem4eFVwGAAlFZ0c/4yWkKhtiCFNe/WeSpm4E4E8lgOJj80P3Iu0nyKPu5iJesQWXO2tn4tJZ6pXBipA4N3VKJEflsV4IKFRQPlA8BwdGKrMnyQuSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRmNNqCB; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRmNNqCB"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5700106506fso348797a12.0
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 02:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712915959; x=1713520759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RUwR39EG8L5ywVobgSQ6HZRf1En08bGbvKG/EIdXbs=;
        b=LRmNNqCBcRlhSH7BCKwZszQP7ZS/9BqqQN7O34Qv9pm2MNYkhGlosDQzM4YIQzADVZ
         XDep6fl5dtFDX71p1WnsyabyG7f38okT5L6ajjF7fSZWkar8oyyXBGpk0anfY0hTaM5Q
         IaLVI3RnpWg8NM5SlqoPClPQSSojnkEM/3tQ/ub31NFHEfkLacH3FPtjiPdlLq7tHaxg
         L4yuukmKPAuQuPVwJr9kKguUl33IrCiDerUjw2ocQuXQHDkeD8IvStDSXpcW9HBaQpxT
         oO7xBfqkU9HIOQGZMLlEGlZ0yHftg937XNpiku9yOo9Ae5KTDe1z1AR3x7psvgqzaQLC
         xf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712915959; x=1713520759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RUwR39EG8L5ywVobgSQ6HZRf1En08bGbvKG/EIdXbs=;
        b=BZolAkRWgwgcjMVLdhuo0x8OuBtNtefb/uiBaSafgPhkyz5zHkW8OLO8uwCcIAPoco
         zcQpUSi+PPGO6p2BOpWMbQy7eejSdgVQn3iWBCpfTQe95k526HaS/fUbhZyaI+AHmTcN
         sZpTP55md2rUqf4bahBIsudRCI1Er36c8gLMTcyThI4F+wyI8aKmyvUT7k9nJLEmxnXJ
         k60xpf0o0WcCDy2Anwzm6SBi1pyclN7PeKvEIPg2LT94rFCJyoCdtAdt2GCByWMyHgPk
         7Vvcc4TgA+MYDlV0eB4eXJgg0NSYL1QHwrq+tHLlOJ9PAqNNpfeSvVwW5BD7U+8guXcS
         ZS3A==
X-Forwarded-Encrypted: i=1; AJvYcCVqj5fDLPQAZgava3GSRtyxBRtvfuX8nKJARZeLqdlV4oh3cZlIiasgXooyhd6XafIqyTZWWZ6vJTuBxAz7tK2qb3E6
X-Gm-Message-State: AOJu0YxSlQ6RQlR1amMFXPjGey07pNWFhmGzX2qzJ3lcJ4nCzxJ5sxc/
	129mx+PjxH0mKN+3L+Ws+DYEE1+S1zUwe7LhVr9myNE2nj6fZ8SJ
X-Google-Smtp-Source: AGHT+IH/s+9YLutmfWVxdw9wRHUffFKmzUOp7Vtk96zSB6gZDgbiHrzMwknumo2FAXbTxR8gdV5kfw==
X-Received: by 2002:a50:8ad3:0:b0:56f:d910:4b7 with SMTP id k19-20020a508ad3000000b0056fd91004b7mr1942297edk.15.1712915958760;
        Fri, 12 Apr 2024 02:59:18 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:355c:c013:66aa:c838])
        by smtp.gmail.com with ESMTPSA id et4-20020a056402378400b0056e67f9f4c3sm1498552edb.72.2024.04.12.02.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:59:17 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v2 0/7] update-ref: add symref oriented commands
Date: Fri, 12 Apr 2024 11:59:01 +0200
Message-ID: <20240412095908.1134387-1-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330224623.579457-1-knayak@gitlab.com>
References: <20240330224623.579457-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The 'git-update-ref(1)' command allows transactional reference updates.
But currently only supports regular reference updates. Meaning, if one
wants to update HEAD (symbolic ref) in a transaction, there is no tool
to do so.

One option to obtain transactional updates for the HEAD ref is to
manually create the HEAD.lock file and commit. This is intrusive, where
the user needs to mimic internal git behavior. Also, this only works
when using the files backend.

At GitLab, we've been using the manual process till date, to allow users
to set and change their default branch. But with the introduction of
reftables as a reference backend, this becomes a necessity to be solved
within git.

This patch series goes about introducing a set of commands
symref-{create,verify,delete,update} to work with symrefs complimenting
the existing commands for the regular refs within 'git-update-ref(1)'.

The 'symref-verify' command can be used to verify if a symref exists and
its existing value.

The 'symref-create' command can be used to create a new symref.

The 'symref-delete' command can be used to delete an existing symref while
optionally checking its existing value.

The 'symref-update' command can be used to update a symref, create a symref,
delete a symref or even convert an existing regular ref to a symref. Wherein
like the regular 'update' command, the zero OID can be used to create/delete
a symref.

V1 of the patch series can be found here:
https://lore.kernel.org/git/20240330224623.579457-1-knayak@gitlab.com/

I'm not adding a range diff here, cause I redid the whole series, things which
have changed:
1. The earlier series simply propagated a 'symref_target' and only supported the
'symref-update' command, without checks for existing values and such. Now we
support the entire fleet of commands with support for checking old_values.
2. The flow is now changedc to send an old_ref, new_ref pair in supplement to
the existing old_oid, new_oid pair to the reference backends. This allows the
backends to simply do a combination of changes based on what values are set.
This allows us to do symref-update's where we change a regular ref to a symref
while also validating its old OID.
3. I added a lot more tests to cover reflog checks and also '-z' input.
4. The entered <old-ref> and <new-ref> values are checked within update-ref, to
ensure we don't create dangling refs. This could be extended in the future with
a flag, maybe "REF_ALLOW_DANGLING_SYMREF" and a corresponding option within
update-ref.
5. Removed some commits where reftable backend code was reused for symref creation.
This actually caused issues since the reused code also created a reflog along with
the symref but we should defer reflog creations only after all ref creations have
taken place. There is a bit of DRY here, but I think overall its still much cleaner.

Thanks all for the review and discussion in the previous version. Patrick, I did
incorporate the changes you suggested, but I just noticed that I didn't reply to
your emails.

Karthik Nayak (7):
  refs: accept symref values in `ref_transaction[_add]_update`
  update-ref: add support for symref-verify
  update-ref: add support for symref-delete
  files-backend: extract out `create_symref_lock`
  update-ref: add support for symref-create
  update-ref: add support for symref-update
  refs: support symrefs in 'reference-transaction' hook

 Documentation/git-update-ref.txt |  25 +++
 Documentation/githooks.txt       |  13 +-
 branch.c                         |   2 +-
 builtin/clone.c                  |   2 +-
 builtin/fast-import.c            |   5 +-
 builtin/fetch.c                  |   4 +-
 builtin/receive-pack.c           |   4 +-
 builtin/replace.c                |   2 +-
 builtin/tag.c                    |   1 +
 builtin/update-ref.c             | 202 +++++++++++++++++--
 refs.c                           |  74 +++++--
 refs.h                           |  15 +-
 refs/files-backend.c             | 143 +++++++++++---
 refs/refs-internal.h             |  21 ++
 refs/reftable-backend.c          |  51 ++++-
 sequencer.c                      |   9 +-
 t/t0600-reffiles-backend.sh      |  32 ++++
 t/t1400-update-ref.sh            | 320 ++++++++++++++++++++++++++++++-
 t/t1416-ref-transaction-hooks.sh |  41 ++++
 walker.c                         |   2 +-
 20 files changed, 886 insertions(+), 82 deletions(-)

-- 
2.43.GIT

