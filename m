Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451B31B85DC
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 23:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725663877; cv=pass; b=gkriMYG6eHOPrhh03HPXSvu5O6uIl9J0HKTRVlm1WpJ+NlDE3xPodO7M4tizwDLvgbrd5w3B96nHI3X94FfYAq49fCSuMsJBq9/a66Sje9WbIOGyT0WaOka7+usjFcOfA8YW8/VwtWEa1Y15jK70JK4ZvuyXCutZHbxHaSLiEMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725663877; c=relaxed/simple;
	bh=iKUoRicSz4p6SL7EYioWdlicj390IrttOzia53ybBfc=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=XzMuxECnaS80TLwS9K8fh8DJqHjR3HvxcG5ol3D0cxiZ5NZXdAzdMVukv17UuQyWcAy0fFrFmOjrOt7XItlZHF78bY85uKS2fmelUECLspUMZxuo3J6RJNJb7dZ/X2l+wwM0hsiDq6UAPYUS4g3MbOisY9Ak2ru0WiD0jW+MQkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mpri.me; spf=pass smtp.mailfrom=mpri.me; dkim=pass (1024-bit key) header.d=mpri.me header.i=marco@mpri.me header.b=f9jnD+tf; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mpri.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpri.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpri.me header.i=marco@mpri.me header.b="f9jnD+tf"
ARC-Seal: i=1; a=rsa-sha256; t=1725663872; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XSGuQwibYxbFWhQ8lTFXhwUn9s1ZxpnRKd9EIcQBJ0zm4FqGZSSokg6wzV/wb19l/mfLt3uPe4UE+hYlqMfom6BOn5zH/NOiBU77K4mJud1bq5RlolOnwG2Hm3JEjl/pt3a5x8nHQxJTZ7UAB728B2zkETeCgkg2DC5G0Rpg9YM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725663872; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=sWuADf7J4XackKB0UguLfkbUYRTN8eA7HA4hKuLSPc0=; 
	b=gzrQgNEiH6sI1dyPWZje5u0y5WtM3GJUT8ES0Dy2RR5S7l2srLqil/ZGmYzfquaMi1Tj7fOxdOP44wMwwJNlorcdosp4vAIelDskrauO3KK9JP0B5EU7e8IzFZm46mIGNMH/fFQsiOSPiq7NmJzO6z6Pd4DCiOiE8i94o3ovaU0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpri.me;
	spf=pass  smtp.mailfrom=marco@mpri.me;
	dmarc=pass header.from=<marco@mpri.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725663872;
	s=zoho; d=mpri.me; i=marco@mpri.me;
	h=From:From:Content-Type:Content-Transfer-Encoding:Mime-Version:Subject:Subject:Message-Id:Message-Id:Date:Date:To:To:Reply-To:Cc;
	bh=sWuADf7J4XackKB0UguLfkbUYRTN8eA7HA4hKuLSPc0=;
	b=f9jnD+tfcbsqGBCNuJpObTL9j7vw0lZ353nhFHlPFHYH4i0WfZ+Z5MUnu7hTXJ2x
	YelfNo/BgGeXi7977q4fAc4+KyK+PRCQ8zC5f8QKyezVn2dqKHOKY6ppflQCiJrdk1W
	0j3B513fOD7IVZOZonjHydNTzhtxW/g+7FoJ1KX0=
Received: by mx.zohomail.com with SMTPS id 1725663870782971.3220020448241;
	Fri, 6 Sep 2024 16:04:30 -0700 (PDT)
From: "Marco P." <marco@mpri.me>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Behavior change for git diff --cached --exit-code in git 2.46.0
Message-Id: <646EB2F8-53B3-4B24-90E0-09A71DD4445F@mpri.me>
Date: Fri, 6 Sep 2024 16:04:19 -0700
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3774.600.62)
X-ZohoMailClient: External

I noticed a change of behavior when upgrading from 2.45.2 to 2.46.0.
You can decide whether this is a regression or an improvement.
I thought I=E2=80=99d say something just in case. Don=E2=80=99t shoot =
the messenger!



Overview:
The --summary option to `git diff --cached` seems to override the =
--exit-code option in 2.46.0 such that this is no longer true:

>  --exit-code
>    Make the program exit with codes similar to diff(1). That is, it =
exits with 1 if there were differences and 0 means no differences.

You can reproduce yourself by staging something, then trying the 4 =
combinations of:
 - With and without --summary
 -  2.45.2 and 2.46.0

You will see that with 2.46.0 + --summary flag =3D>  exit code is always =
0.
This is different from 2.45.3 where --exit-code influences sets the exit =
code regardless of --summary


More context:

I have a scheduled script that daily updates submodules.
The logic is:

```bash
git submodule update --init --remote --checkout
git add path/to/submodule
if git diff --cached --exit-code --summary;
then
  # Nothing to commit
else
  # Create commit and push=20
fi
```

This has been working for a while, most recently with git 2.45.2.
After updating to 2.46.0, it stopped working.
It would _always_ think there=E2=80=99s "nothing to commit", even when =
the submodule did have new commits.

After investigating, I discovered that the --summary option seems to =
override the --exit-code option.
i.e. if --summary is present, then the exit code is always 0, and not 1 =
if there are staged changed (as I=E2=80=99d expect from --exit-code =
manual entry)

This is not limited to submodules, the behavior is the same for regular =
staged files, e.g.:

```
# Stage a file:
$ git add debug.md

# Diff with 2.45.2 prints summary and exits with 1:
$ git diff --cached --exit-code --summary ; echo $?
 create mode 100644 debug.md
1

# Diff with 2.46.0 prints summary and exits with 0:
$ git-2.46.0 diff --cached --exit-code --summary ; echo $?
 create mode 100644 debug.md
0
```

I fixed my script by dropping the --summary option.
But maybe this behavior change was unintended and not covered by tests, =
in which case you may want to treat this as a bug report.

Taking this chance to thank you for reading and for maintaining git. I =
don=E2=80=99t know what I=E2=80=99d do without it!

Cheers,
M=E2=80=99



