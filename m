Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5DA208D0
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 04:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762490386; cv=none; b=Qv0Opdpep8+JeBuOMT5gFtkdPRWLtOxeC7hIbe75CHMyMK4KQc+WQiJNmSucNx1QmMfJrJ6/oQHkVmK9q6dWvvfGh0XGLOUjCoNpMeSN0tr1xnmIVgfbWd7Vosw7cS+G8Vbtzy8wNjYmvmbLEPWe+NULK2fl47QSkHGsR453Qso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762490386; c=relaxed/simple;
	bh=ibFJp0GzOJ5DAU9dRDUQcjSLstz7BZ/J4ysv6kO+KKo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=q3v0xlNFtfH2953RNY/2tyH63HF5TWA8m3ckPrbHMjoWiIz97SnjnNGNZquLDWsPky1qQwtUsSZxEmQZ17a7miIBBrtmOFpTFOLgaKdfM/56vZerDwD2DxZNnWqOcaqZd+jgegVDt/tGEy2JM+fPtdGxfqNOBvKtVlXvIQF39Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXB2x9OD; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXB2x9OD"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-932c2071cf5so200309241.0
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 20:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762490383; x=1763095183; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSjS/QDPRGD5eRWBa5w5ctHLwqw+L5WP4qcKwr83l2Q=;
        b=MXB2x9ODh3mQD97iCOwYO6fWM+4Ha8q2cxdGJFgkpuLRmxR2kxTQjocMyovu2QuTQO
         rHx/SPNJ5t9ZLgnVzT2qminXPILEOHe4DhRVkitUU1mHO/Vq0l+7Vfgd96WGqTBZkI/f
         T8XiPGm2tymmSFX8pHQjVWoJ1UTBD2FbkCBhHiALs44rE9ZqT00i/MVQvO1/g95FgzYM
         WqEmpg+6ksmpBhe4Mc5h6h3p+kAnCZTOb3U2mQ/+EmredTTilZ9RWyL0qXgBOywIXygq
         rrqqs7eZ5m+HWGgGqF1vYZHDJLV1OItMmVqVfQHM9ivVup8Jzz8we3yNIeve7c9N0vyl
         QVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762490383; x=1763095183;
        h=to:subject:message-id:date:from:reply-to:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSjS/QDPRGD5eRWBa5w5ctHLwqw+L5WP4qcKwr83l2Q=;
        b=FB8mCF8YdxshhYILp85AY6GrSm48u0OvCqlCDrksUBH3/RbblxH5dF6AV3Xhff7025
         m7+iTS47PdNKbS7uMIHdISCybPyFPsfThUH/vBHljPlRlZPBBxViEg0NX4qC66MAN1/y
         H2e3Ct4cVh9zyGV0wFpFxKPu19vReVVjRBmDMy8gy4LHPbep8PxYp6WQs1meEdbTL74k
         u8kBH0yhCtZeqDBk5uae8m6ErCeQAiaE6Duj0mf3v3AjM+lc36sp4XRoBe8KnFOiQOEk
         tsUFUbLgzgjUpf7GLVcwvqoqGVIVvIdlbhqPA+9NA2/Q0hM3TDzFOUYgePsW+tzF7UUa
         cp7A==
X-Gm-Message-State: AOJu0YwAOAZ0BSljY0/G6avvbCsTSaVzLjLE0CTZ+N1yCgyIRkDtaRaz
	o5EClyE1EIXuSyfHmJD9AsN3cGChkF3/WK0XDPTP+z4XotgSLMfV4sfKUauwR06Zrvbd82pqiop
	ISXneP7FoaiAUBX7KE5iG3n3YZJzy2/qkSoTq
X-Gm-Gg: ASbGnct1W1OGoxVozrUcXbfKF8n0syPAFyxN5nRIoaxtHSqdwTSM2MXGuNFallY5PcC
	LdS4TEPIhToHnL2y6FuzVwmA7P2NkeiHrKOz0tJ94mnnBKIqjdFvIq3ItkvkJmOo3+17IZUQ9Mk
	BKX5dGc8NHTJdeZMktfh693ucZEVQW7YVyX5DHzkVQ+CR5s/+epISbchQePoJ6S1TnV3Py1pDqs
	rMBtSF0wToSFkOcgf0W0Bmgta4dIyw3h6rO8foby4XM+cLnA8+5Xc744xuv9Um8EZU9ocQ7
X-Google-Smtp-Source: AGHT+IGFbbvkxANQRtEHcnseALuEFFpEomSsFGEeWZ9sykB5BstRczQdThnIm1J0IaUJv2Lm4KtkfH7NHbzkTdY4vDc=
X-Received: by 2002:a05:6102:290c:b0:5d6:85a:229f with SMTP id
 ada2fe7eead31-5ddb9dd43fdmr121570137.15.1762490383128; Thu, 06 Nov 2025
 20:39:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: bhavikdbavishi@gmail.com
From: Bhavik Bavishi <bhavikdbavishi@gmail.com>
Date: Fri, 7 Nov 2025 10:09:32 +0530
X-Gm-Features: AWmQ_bmUmOnCgB9jvXSG1ljuDvEB9rpCVAi9xQmLhO2ke9uusO4Inic94zvYIEw
Message-ID: <CAEyHQXWd77_jJachC6FYbWMJ+L=KkKoUqiACQ7z8r-ZwYq8JYw@mail.gmail.com>
Subject: [Bug report] git cherry-pick silently ignores error whereas git apply
 fails for hunk apply
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
> ran git cherry-pick command, which went fine without any error, but missed to apply change
> created patch with 'git fromat-patch' and applied with 'git apply --verbose', which error for the issue

What did you expect to happen? (Expected behavior)
> git cherry-pick should fail, since it failed to apply hunk

What happened instead? (Actual behavior)
> git cherry-pick completed successfully without any error

What's different between what you expected and what actually happened?
> git apply --verbose, failed with error about the issue, whereas git cherry-pick didn't fail for the same

Anything else you want to add:
> same error observed with '2.51.2' version as well
> we do primarily use Gerrit UI for cherry-pick, so JGIT has similar behaviour as git cli for cherry-pick.

> can we have verbose mode for git cherry-pick, like git apply --verbose ?

> below is output of git apply (note I've changed words for source code references)
=======================================================================
git apply --verbose ../test.patch
Checking patch mango/connectors/apple/ops/query_check_hierarchy_op.cc...
Checking patch mango/connectors/container/loc_base/util.cc...
Checking patch mango/connectors/container/loc_base/util.h...
Checking patch mango/main/http_test_ops/new_op.cc...
Hunk #1 succeeded at 56 (offset 2 lines).
Hunk #2 succeeded at 1074 (offset 21 lines).
Checking patch mango/main/main.cc...
Hunk #1 succeeded at 9876 (offset -63 lines).
Checking patch mango/main/ops/refresh_apple_hierarchy_op.cc...
Hunk #4 succeeded at 1713 (offset 18 lines).
Checking patch mango/main/validation_util.cc...
Hunk #1 succeeded at 42 (offset -1 lines).
Hunk #2 succeeded at 106 (offset -2 lines).
Hunk #3 succeeded at 11167 (offset -14 lines).
Checking patch mango/conn/ops/apple_box_storage_package_op.cc...
Checking patch mango/utils/apple_utils.cc...
error: while searching for:

//-----------------------------------------------------------------------------

// Returns true if Apple Box Pack usecases + the corresponding updates flag
// is enabled.
bool Converter::IsAppleBoxPackEnabled(
    std::shared_ptr<const orange::FeatureEnabler> updates_checks,
    std::shared_ptr<const mango::RegisteredParams>
        newed_params) {
  for (const auto& usecase :
       newed_params->apple_params().use_cases()) {
    if ((usecase == RegisteredAppleParams_UseCase_kBoxPack) &&
        updates_checks->updates_list_map()
            .apple_box_storage_protection_enabled()) {
      return true;
    }
  }
  return false;
}

//-----------------------------------------------------------------------------

}}}  // namespace org::mango::apple

error: patch failed: mango/utils/apple_utils.cc:658
error: mango/utils/apple_utils.cc: patch does not apply
Checking patch mango/utils/apple_utils.h...
=======================================================================

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.15.0-160-generic #170-Ubuntu SMP Wed Oct 1 10:06:56 UTC
2025 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
commit-msg
