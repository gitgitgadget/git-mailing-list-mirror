Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BBB14A4F0
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214321; cv=none; b=I7aVuZAjyAy86btV3ty7avEXtl9HLGc+g8Q/mxHznX03LWK2AArpNeZc2XI2zl+DlxAwTHwlKegU2dTC+Ar2UcML9yWCwLj0Vrz7quwiTSlxPerTq9CX9+TmSQLTL+Nui6zxjR2EyfDMXJ0ZaP6U94/6XYl3hx4+rOiwOWB+Emg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214321; c=relaxed/simple;
	bh=Hei6Gh3T1olNsNi2DuJhrUb+REtEYMiO1hfh4drhIl4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mPMrmOTfCloY+8J6WIRxxA2AHDAw6vv55Ycz9Mn0SCIDMZprJK6rBqItnhSzVBSQaodyIEzjYaGbaDktI7WZI6hYFeEXTqIgnxjTzrmiWA6ycOcwRnQqpMX2xn0+DnuhSxljmnqMJXYRzT2A+EGHRosfTlGwIMLDiva0JmtFitw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0grsKs5; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0grsKs5"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8b038a00370so80422826d6.1
        for <git@vger.kernel.org>; Sun, 26 Apr 2026 07:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214318; x=1777819118; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8QSW0LB0PyVVtkzxG/NDHVtFkG9fRWEXjuhR2y5H18=;
        b=G0grsKs5QSpwEy4fXnX34s0tJnK4I7nTq7n1U9ReaUp6y825glJkYbLlw1sGnF4ne4
         KeX8U/UH/gIWLa/f5h5iAjftzMVEY+MU6cIXwuvWd3otQm8e4pHykKMV9KELYOwsVS7k
         DqezwcfC9nZ16YJaVzPkvsEaNXB5PretXVCFEcFGDKT4oJvTAv2HnD+Q1IIjbCcMldgg
         cCqpOt5cq5l9pOwPcYywWORJDbB7HsKB7oBX925hdqMto5+n7toOSUlQs4lO06VrvVCz
         BGQtCj7qKVLV5R3jPqurB96KU79fjEM8CEDnhxJl4ryxgSQDUOmAzTDFvUge5h4gfyTH
         46vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214318; x=1777819118;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r8QSW0LB0PyVVtkzxG/NDHVtFkG9fRWEXjuhR2y5H18=;
        b=AXUH+J1wj2/EOFymI5zX4V2ePpnkgFLKjUh4GVF0dHRdQTe7YAudywaGMEW1GTT2h/
         JV5uxFdF/YnzI5JlAm/AS+uoOpd0IXQRMQIA9vm43WsYnDDW+dzJbk/E7IVOrWsepDmW
         zUhra3m6b7YOp2KM/KmlNOyn3k0I4fXxvlA1szVzdsTQrhkgEsY6bVOA2YaNks6r8up8
         76IbJfZbs+fU/pDNQzoCsGGf4y7U64CT8Hwgcojr3BnwKQOO3FWWksaxOXItWwM05q6P
         a6MMaJ9yM9/BuH5sC8bFKBE2EP0vtJ/yP+kuXNUXRKChowKz8+KVnqYZTi7D+xHL0/Zv
         3EQg==
X-Gm-Message-State: AOJu0YyJQBlkJJOk4Dm3lZZKoDUdlBbeZ55/opcmRkH1JWGleMAiXVRV
	2exGaER7oT9XanQa3SFK9J6srJQqUhGPSNhNMrBsAxl15Jq8IVnvV+FbVjN7VA==
X-Gm-Gg: AeBDiet+TkTtU00eACThDBUWHMhsbjznaXEMKKhIOGRDLYAsUU7o7QGpGXr/4s8TJ72
	RwF/c3uHYFTty7eGmNdZwmExTlPG/zm19mv37NkBUoxsSkgWRyY0cGHPEF/41OR1xmn2u5RdPmP
	h96pNG5nvV6jWeYZK4P9ug28G2Mkh9jSUcC5dboxZ0XWRYVpJGF4NKgQhj5nKsTr7gzmGDiprgb
	gL8IVGGmG50ZaWOs22RDebUBLKksdUic8dCSR6vih3QRIHNjKNC7w+HDeose8eVsAjM663oxerf
	Y3EdKPETSmD5zlzeV5IQSYPZLuW6pHA3nm++4m2j43oSQE0VlM6C7/XC9kRNwJ9Ul5e/dIhnPFV
	Yr+2DehPGiT6Cv1KiHxMDkkqY/Bh6i5wLK/QarPSkZjBBZxhcUkFT7Ap2tjTUYuZkPVFUE6X/x9
	QWBtbIGmA+cYcnuiktx9/IrJWSPuaUU2MxSw==
X-Received: by 2002:a05:6214:598c:b0:8ac:b6d7:e60e with SMTP id 6a1803df08f44-8b027fd9d4amr643590366d6.7.1777214318202;
        Sun, 26 Apr 2026 07:38:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.18.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac42b3bsm230806556d6.5.2026.04.26.07.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:38:37 -0700 (PDT)
Message-Id: <pull.2098.v2.git.1777214316.gitgitgadget@gmail.com>
In-Reply-To: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
References: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Apr 2026 14:38:28 +0000
Subject: [PATCH v2 0/8] safe.bareRepository: default to "explicit" with WITH_BREAKING_CHANGES
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

This supersedes my earlier series [*1*] which took the approach of adjusting
individual tests to access bare repositories explicitly.

As Junio suggested [*2*], this series instead takes the approach of setting
safe.bareRepository=all in the test environment's global config whenever
WITH_BREAKING_CHANGES is in effect, so that existing tests continue to work
without individual modifications.

Implementing this turned out to require a number of follow-up adjustments,
because writing to $HOME/.gitconfig has side effects beyond the intended
setting: $HOME is the trash directory, which doubles as the test
repository's working tree, so the file shows up in ls-files and status
output, and tests that manipulate $HOME/.gitconfig for their own purposes
can clobber or remove the setting. Patches 2 through 7 address these
interactions in the affected test scripts.

The final patch flips the safe.bareRepository default to "explicit" under
WITH_BREAKING_CHANGES.

Footnote [*1*]:
https://lore.kernel.org/git/pull.2076.git.1775140403.gitgitgadget@gmail.com/

Footnote [*2*]: https://lore.kernel.org/git/xmqqse98cc51.fsf@gitster.g/

Changes since v1:

 * Made it compatible with Patrick Steinhardt's set -e work.

Johannes Schindelin (8):
  test-lib: allow bare repository access when breaking changes are
    enabled
  t7900: do not let `$HOME/.gitconfig` interfere with XDG tests
  t1300: remove global config settings injected by test-lib.sh
  t1305: use `--git-dir=.` for bare repo in include cycle test
  t5601: restore `.gitconfig` after includeIf test
  ls-files tests: filter `.gitconfig` from `--others` output
  status tests: filter `.gitconfig` from status output
  safe.bareRepository: default to "explicit" with WITH_BREAKING_CHANGES

 Documentation/BreakingChanges.adoc            | 24 +++++++++++++++++
 Documentation/config/safe.adoc                | 10 +++++--
 setup.c                                       |  4 +++
 t/t0035-safe-bare-repository.sh               | 10 +++++--
 t/t1300-config.sh                             |  7 +++++
 t/t1305-config-include.sh                     |  4 +--
 t/t3000-ls-files-others.sh                    |  4 +++
 t/t3001-ls-files-others-exclude.sh            |  3 +++
 t/t3002-ls-files-dashpath.sh                  |  2 ++
 t/t3009-ls-files-others-nonsubmodule.sh       |  1 +
 ...common-prefixes-and-directory-traversal.sh |  3 ++-
 t/t5601-clone.sh                              |  4 ++-
 t/t7060-wtstatus.sh                           |  3 +--
 t/t7061-wtstatus-ignore.sh                    | 27 +++++++++++++++++++
 t/t7064-wtstatus-pv2.sh                       |  1 +
 t/t7104-reset-hard.sh                         |  2 +-
 t/t7508-status.sh                             |  4 +++
 t/t7521-ignored-mode.sh                       |  1 +
 t/t7900-maintenance.sh                        | 12 +++++++--
 t/test-lib-functions.sh                       |  8 ++++++
 t/test-lib.sh                                 | 13 +++++++++
 21 files changed, 134 insertions(+), 13 deletions(-)


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2098%2Fdscho%2Fsafe-bare-repo-default-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2098/dscho/safe-bare-repo-default-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2098

Range-diff vs v1:

 1:  62707b4109 ! 1:  179fcf5369 test-lib: allow bare repository access when breaking changes are enabled
     @@ Commit message
          `--exclude-standard` or `git status --ignored`; those are addressed
          by subsequent commits.
      
     +    The `.git/info/exclude` write is guarded by `test -d .git/info`
     +    rather than using `mkdir -p`, because some tests (e.g. t0008)
     +    expect to create `.git/info/` themselves and would fail with
     +    Patrick Steinhardt's `set -e` preparation (ps/test-set-e-clean) if
     +    the directory already existed. For tests using `TEST_NO_CREATE_REPO`
     +    (where no `.git/` exists at all), the guard also handles that case.
     +
          [1] https://lore.kernel.org/git/xmqqse98cc51.fsf@gitster.g/
      
          Original-patch-by: Junio C Hamano <gitster@pobox.com>
     @@ t/test-lib.sh: cd -P "$TRASH_DIRECTORY" || BAIL_OUT "cannot cd -P to \"$TRASH_DI
      +if test -n "$WITH_BREAKING_CHANGES"
      +then
      +	git config --global safe.bareRepository all &&
     -+	echo "/.gitconfig" >>.git/info/exclude
     ++	# Only write to .git/info/exclude when the directory exists
     ++	# (i.e. when git init created the repo). If we mkdir -p it
     ++	# ourselves, tests that expect to create .git/info/ themselves
     ++	# (e.g. t0008) would fail.
     ++	if test -d .git/info
     ++	then
     ++		echo "/.gitconfig" >>.git/info/exclude
     ++	fi
      +fi
      +
       start_test_output "$0"
 2:  d9a2e76f3c = 2:  4dc5151e59 t7900: do not let `$HOME/.gitconfig` interfere with XDG tests
 3:  9c10e72eed = 3:  7d68155805 t1300: remove global config settings injected by test-lib.sh
 4:  092ec11621 = 4:  5ff48e0892 t1305: use `--git-dir=.` for bare repo in include cycle test
 5:  3aca302275 = 5:  ed7294ace3 t5601: restore `.gitconfig` after includeIf test
 6:  ef57244778 = 6:  556db0eabe ls-files tests: filter `.gitconfig` from `--others` output
 7:  56fe902644 = 7:  ac4da79eac status tests: filter `.gitconfig` from status output
 8:  64db45e385 = 8:  73bb1aa171 safe.bareRepository: default to "explicit" with WITH_BREAKING_CHANGES

-- 
gitgitgadget
