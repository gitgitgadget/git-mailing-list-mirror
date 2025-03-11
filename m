Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06D1262D05
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716645; cv=none; b=Yx5xsVjtB6EtkluaBpVB9hGf2Bwty3N/CUo4K/Pcsy1NnmfYsnDhNn9gyXSp1K6Wc7cgjaVazv0+ugseWfdAwEnyEcNYy8h5e/sttLNt1xUHt6gVJeT9XmP80GaGGKzMOrMfRbw0rKT+bnMedMyizLbVXQ81BkQZizEE0X2CZZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716645; c=relaxed/simple;
	bh=IJha6tRP4hHM23L6SKPBk8uDuGroZqip+TKR207jQmY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JDFZ57zopspdVUYml0Q1hyX5xAvE9EHl5nICHplI/kLruevv40TDjdngHjxwWbx3DPpIOn3rrewHaSOWJCog1yxByK6f+CjH8fOwRFf5qSX0sZKOaG7SbSm5L421RF7IYa23jZErmq5x8uhyBxgQpe9WNgwEzGRROB8JeQ5jrkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oygng5pR; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oygng5pR"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2fec3176ef3so8653304a91.1
        for <git@vger.kernel.org>; Tue, 11 Mar 2025 11:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741716642; x=1742321442; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IJha6tRP4hHM23L6SKPBk8uDuGroZqip+TKR207jQmY=;
        b=Oygng5pRwnHyhvw2sf2p4fazoa5wQCJ/dwozc8X4ARI2R2rUv1osRcpSHFJ8s+nWI6
         f7Urr/kZaNB/Ji8nt9PXii6iEw4BuHfc1ZoAIIBoXuAGcQgwODOLjCj8K93w1aa0gqY9
         jVijQ6ytg7qaF1zFAufYO7xUoCGqvcDCjRo8KpIz79JH0lejmGcfGfmLA7Gt+cTYace1
         NiLh+XaTL9laOD/WLXsC/zJLcy57wwtUdPeHc/3/iBM7R0oNpgtw1u78Tq7C1kYVhTAD
         uZG9BWkDO1dQD2C6jmKIuNyakosxeC0hovR9K1g7D5wf3L0kL/I2cEbKzzDIra6PmVir
         lQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741716642; x=1742321442;
        h=mime-version:message-id:date:subject:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJha6tRP4hHM23L6SKPBk8uDuGroZqip+TKR207jQmY=;
        b=f/GiPQvyFkmaoIkdZTg5IBtJ5BUGvxvgPj4fYC5+uWBcNQMcJyQftCLADApns9hgMX
         ie55MZqFU+tzK4sYoJV/9MOPQ2j7LR5TfEbUkg4CY94DvoeE+d8tcC8pzHWdOLG7n1+b
         ViSKrXTCssxFf0MijeyeBOm1Uniz7Z00jHHNPmAJHD/g8BcEz5QGo4QHdj+qUn2Gx8bA
         qQsFerQwA9jQ8ujyw+1GR1/4bN/ZvEqnH6cme6dmnkvm1fHJsrciljuMszkCgmODMfI+
         Qqv6F7Im1oQu3L1y4ikKwynmP7hTqTaCwNGsepjj6+Wfy088nY74bwp3CZnHhko3kwIM
         k4Hw==
X-Gm-Message-State: AOJu0YwsXkgPcOraXxXZ0e0iybHD2Y6Czqy9Yal2nLfJX/A7OuvT74VP
	eSwERnDEh1hGR/nuNp0Ah4FBfkVvD9fePp9ncZCMg67Q2wRtfD1n/J1NTVgL
X-Gm-Gg: ASbGncvMSP37B5+ABO8HRvGyn0H+9/nQaCsTyT+9hHtyptaWyWFOJQ60LwSHrghVCe9
	XMPqBvj5jNVPNklDEgeqg7MnY6/SHWlYW/Ua6PHVBxPoA9Xyrkzio7GLnBxfEB8ecy/VN+tgdke
	T9TyTX1whLuPVuTIFQe240FVh9H0JFwSbNr5FDAe5K9gPzZ14bfTLsqS4ELbzWbeG7+R03l1VmH
	0nvp/zIiRXDhsY8RLLD0b/BdqPtpqn0pqQJVkCjbH3sxvzefqvGzLHPkMLBc6C/qQIOQc0C0gv/
	1DJwNe6zY0QQhMpWsoKnaTFcCqZU624bYgR1BRRUGRWLzQ==
X-Google-Smtp-Source: AGHT+IEY9pvXNSkPpiQ3DUOJftxDVO6nBv0eMaPUPlqmmO3Dvu9pj8KTqvlHAAfL7iA1FxrxoxmBfA==
X-Received: by 2002:a17:90b:2fc5:b0:2f7:e201:a8cc with SMTP id 98e67ed59e1d1-2ff7ce93a2bmr32002671a91.18.1741716642451;
        Tue, 11 Mar 2025 11:10:42 -0700 (PDT)
Received: from guix1 (utm3.nitt.edu. [14.139.162.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ff944sm13638378a91.34.2025.03.11.11.10.40
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 11:10:42 -0700 (PDT)
From: 45mg <45mg.writes@gmail.com>
To: git@vger.kernel.org
Subject: git rebase skips reapplied commits
Date: Tue, 11 Mar 2025 18:10:32 +0000
Message-ID: <87jz8v8mlj.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


If the same commit is made and then reverted on both <upstream> and
<branch>, and then reapplied only on <branch>, then
`git rebase <upstream> <branch>` will skip the reapplied commit.

The following script demonstrates the issue:

```
#!/bin/sh -eu

# Set up a repo for the following commands.
repo_directory="./rebase-test-repo"
rm -rf "${repo_directory}"
mkdir -p "${repo_directory}"
cd "${repo_directory}"
git init -b main
git config user.name test
git config user.email test@no.mail

# Create a branch 'br' starting from a commit other than the tip of the
# 'main' branch. Switch to it.
git commit --allow-empty -m 'initial commit'
git commit --allow-empty -m 'another empty commit'
git switch --create br HEAD^

# Create a non-empty commit on 'br', then revert it.
touch a
git add a
git commit -m 'Add a'
git revert --no-edit HEAD

# Make identical commits on 'main'.
git switch main
touch a
git add a
git commit -m "Add a (on 'main')"
git revert --no-edit HEAD

# Reapply the reverted commit to 'br'.
git switch br
git revert --no-edit HEAD

# Rebase 'br' onto 'main'.
git rebase main br

git -P log --graph --all --oneline
# Sample output:
#
# * 5b4d655 (HEAD -> br, main) Revert "Add a (on 'main')"
# * 7881a38 Add a (on 'main')
# * 907f1a8 another empty commit
# * 6c094a9 initial commit
#
# What we expect to see:
# The commit 'Reapply "Add a"' should have been rebased onto 'main'.
#
# What we see:
# This commit was skipped during the rebase and has been lost.
```

Using the '--reapply-cherry-picks' option prevents this from happening,
but it also creates empty commits, so it's not a proper workaround.


[System Info]
git version:
git version 2.48.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /gnu/store/jlqbjxk51bdq5w7wlnbmwxm1j0pnllpx-bash-minimal-5.1.16/bin/sh
zlib: 1.3
compiler info: gnuc: 11.4
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /gnu/store/cdwviyfnsfv7k57qrwmym0mrynjixc1i-bash-5.1.16/bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show
