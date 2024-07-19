Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1174610A09
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 02:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721357793; cv=none; b=YKPK3Y0PpQpcnFN1RW1+9tjbHT+zVFt+qUP7KSzVMBa3eFq/g0W8aoZBy3W/VtWHrkeWzcKMEu7jFcrWujTf5wjXBmPGtcmEaBG2TBiOBSVJPMqh0A9IFNdTCt/Q+nXUk5rKLb97Yx2VJfTrLn27HrEnWX7mtSDVUBPvgurohHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721357793; c=relaxed/simple;
	bh=A18YzuGf4+3ZZQbFcR4V3qaDYvBUuidccgeye/lvU0w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JRRicDYlNh2PySNVVepChQdBuAHckYZXRXTr5SlOSkNfuLhgTOpzD/doGOIyPgiWSQysFGo68pZyNRcj62gMm7OSYi7bZdP2m9hfWjkYTaRA/NnSiOfpmWfNmYXSbrTlypEkFwSa102viXzglhiLdo6bLFow6qyScD0KEMvPStA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUD0DFUV; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUD0DFUV"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7f684710ff5so43220239f.1
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 19:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721357791; x=1721962591; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nbT4QvtjHE4TQzqHPQKs7D1Gc63jtegD6kW+keXdvFQ=;
        b=bUD0DFUVGL4ssUc6nifkSMIhGh98OffTdfAT5JddoUz3aaKLW4YOkzeO7f5bQItKcP
         Vgrkr6IhKjCgC4gY3hcesTqYTFvw9if0wA9SwoB836NMPhFkibSM3FrHl25fif5QEuJo
         vnDGsZw9Bq025NP7+m4qP09kz5GEPxFtztknBWbm/GFG2TR7x0HPozSjwd2Wn+S0L3Rg
         aE8v6SU9Jv1aN+mpRct18mgYUEG+9/ij7wtFRhqmuJ08yCuYMJCdZ6mf3u99zRlR/SI7
         pnkcL5zJ3BIi8+daiphx8ru6RG2z+a/3GZohhc+N2eKKv+ZSMUcziY39q2VppHDa9NZm
         sZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721357791; x=1721962591;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbT4QvtjHE4TQzqHPQKs7D1Gc63jtegD6kW+keXdvFQ=;
        b=oPnYtpReVGtiplrp5qgL/hPjO96kCRMU9RHgs3VwBv7aE28icx0nuB0YaOPgsJn+sv
         GCSNKgcQn3Ac8Rjk+cVY1B817vyCnqMHwu6LcnrdHOOXV+HIAC8YZrkp4+EUJ3kGyM0E
         Knk3ZAoc53HkPZA+K/pBoiwtdv6H7ZAB1ujrYYtWIKcHCZAqDaSExhoca4ZC9F9cl133
         b+bAsvH1SoYIYkAwUFBzd+R+eS/WaZacJ/eBTW/orGXu2nmPA74MUJ8T7kWRusQKGNOs
         q6Q80w3UDgkas5Z1qBWESBnmg9MpOljfIR7JaLdtJDsT4DqxLXLjV9L1yB5OIW1hA/CS
         QnJQ==
X-Gm-Message-State: AOJu0YxPaFeQegzthsaC9G1yrHcvrUpgwFlOMcJgcxQR2GphiZ1acNUz
	NdQq1aw2Wx5yZw5GYDoSFFJISIVblCgGd5rXSLIqfAUuo8dv7K3b7yrSXGLaw46SJx3Adht2cHc
	ngXbrM8nG8YTe/7zundY+aQDRTm8cPouT
X-Google-Smtp-Source: AGHT+IFhHQdaY+BvA88OXan+wZk6znlRIAi1ESMM+nR1OybBST+5P4zozJkphm2YV1ZpfHLneg+jArjEyAiSFXbCdss=
X-Received: by 2002:a6b:fc03:0:b0:7fa:244c:bfe6 with SMTP id
 ca18e2360f4ac-8180f91ab2cmr316403339f.8.1721357790785; Thu, 18 Jul 2024
 19:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Elijah Newren <newren@gmail.com>
Date: Thu, 18 Jul 2024 19:56:19 -0700
Message-ID: <CABPp-BEsJX8FiqYKwWsJ9+RHoZeOPG02Z0CFZHQXuKx9MAj45w@mail.gmail.com>
Subject: [ANNOUNCE] git-filter-repo 2.45.0
To: Git Mailing List <git@vger.kernel.org>, git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

After a very long hiatus, git-filter-repo is again finally getting a
release.  v2.45.0 is now available.

git filter-repo is a versatile tool for rewriting git repository
history.  The public repo of filter-repo is at

    https://github.com/newren/git-filter-repo

The tarballs can be found at:

    https://github.com/newren/git-filter-repo/releases

git-filter-repo can also be installed via a variety of package managers
across Windows, Mac OS, or Linux (and maybe others)[1].

[1] https://github.com/newren/git-filter-repo/blob/master/INSTALL.md

----------------------------------------------------------------------

git-filter-repo 2.45 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Fixes:
  * Work with git >=3D 2.43 (instead of immediately aborting with an error)

* Backward compatibility
  * Do not create new replace references by default.  Use the --replace-ref=
s
    option to change this, if wanted.

* Usability:
  * Throw an error when users pass `--paths` instead of letting python
    autocomplete to `--paths-from-file` (since users usually intended
    to mean `--path`)
  * Apply commit ID updates after the --message-callback

* Documentation:
  * Update link to GitHub docs on purging data

* Miscellaneous:
  * Add a --date-order option
  * Cleanup callback scope

* Contrib scripts:
  * [convert-svnexternals] fix parsing of wrongly transformed SVN revisions
  * [lint-history] fix --refs option
  * [clean-ignore] handle .gitignore exclusions
  * [clean-ignore] do not require additional arguments to be passed
  * [clean-ignore] support utf-8 filenames found in .gitignore files

Reply
Forward
=EF=BF=BC
Add reaction
