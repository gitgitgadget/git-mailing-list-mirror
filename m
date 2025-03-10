Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A5921E092
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741606890; cv=none; b=SLGRqxxAxdJUX11JccsjIhHUX1XOZz6Pf0rrA7ANZvPGyxrEYrSvjmVX/S1hupPnju0D1kPLyZ5YJh9PcPw5D68IXcjV6TQTF5MkbzPdM91Y6pb7H8LT96Sodvw3K6ee98kJ91dMhgcCDaoZrMmexYnBlxM5dRjla1Jh6K20inM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741606890; c=relaxed/simple;
	bh=ung/r6S5GUnep+H5A5D2moFQqpvaaU+I/TrWq7Qj47M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjYgYJRxjqPwMCQkS1PLJvkzuhqMuBjLLxhkY9NTNm5cPnyh3h9rWH54o+qHGobzB2rcFjnxyzMUcQ+eEfyIpgTiv3I9CkwqNyQjbUqWahiUg2Nen8a2v94WE0sUGGPqUxgMUzkHxBYVz3SPWntxonTp4m2Oi1tAB474AsaPOyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yc+zRppx; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yc+zRppx"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86112ab1ad4so1604751241.1
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 04:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741606887; x=1742211687; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E+X7p10iYGiHWVTSqNurAiwGFJMUWlGiyDSPw8amvBs=;
        b=Yc+zRppx5MEnEfnDzZAvyasQqQFU8o+18VdCO6RpqdjYSv+glvsTf0AJlYqRnIodsr
         MABLMtJCdKZHigbKSezeO5yEvqJnCWIC90xQS+87woIg3d9ZJq5B0zdlCLyhoroEZDO+
         bQZC8Cm1qH1XzwvO5g6R5ghiugkVYlKQjt9wgRueG+W1gRI9nm1H4rDy6ZR3kMKkI5mF
         DvRtckwWmnGE98rT6EMwjKw3o/GndYZtJXgoTWF/UfLypoxJ7unvd2/v+ejxWpO4zaug
         nRovNbixd/W3mdpddHqsZ/AuY47zYUljpLAF/qutwpRZkw2EH+8f5wkqiUMzZEa/pMlt
         xRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741606887; x=1742211687;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+X7p10iYGiHWVTSqNurAiwGFJMUWlGiyDSPw8amvBs=;
        b=VsmxUGpoZoNcDQOdMikaWIznXLdqVxyumZkCwq3UYJw7GYW1LBtl9AfpQMYl33IRrO
         cVHxvFfUyye4WEkww99HSGVUUIqIRV1nVyzbCCDZTADqhBWmSpWTQ6qKLQVXrJ0algdW
         8DALOnq7dI3Q15YHeF9+acR2yJyMtIbBOpyOlcMkZftiqbbkqHJzrzCV01qWG021ydEf
         sWzEdQVY+qrEZ9eZCx2keKSwsvRTig1D/yo+cVKRoBiMfOYmu66V2pzTB7bPDHzL69IW
         pyrYBfPVK2zlB5y87L6J9RMiOmaRNKh+ok8QLjyuJS0y0w0QHS3hh36UaDfkzIBNQfrO
         3ejA==
X-Gm-Message-State: AOJu0YygkjjfntPO94bqAfuAdQk+ylPfTt2f1IKhpPLvGh6b3twj4Vpv
	coBhbH8hzzuoibB6lelvvpBm8aM3+CKrjEDcN0r2mCBzrjUXTnVZbHefkNTD5BJFbfzEHDV0KGw
	fRyxU2+nyYN7ZwIGixv7EZVfI/N1Va9QQ
X-Gm-Gg: ASbGncv9KoXslW/XI8Wou9YBdmGa9P2Mh6uVCsC3i51sSk11aq5OBZmbq/oPDgmzss7
	YXjMVVXJJ6HoKwhgofXfpIufCbqbXMwxWWeEw07AhJCHgXik7S6juNf+kvZ45QCfcaKT2xETC5J
	CFIrZllsOKwozIEM4Vxo5glsV6W0s=
X-Google-Smtp-Source: AGHT+IEaA88jHC1+EBKhk3cgQH8jEmPclttl8Nei3uzXMUp/RSx4hUKEBgzO8LKLBw9LorD3CVgpF/diM0leBF9bFqo=
X-Received: by 2002:a05:6102:41a8:b0:4c1:76a4:aee4 with SMTP id
 ada2fe7eead31-4c30a6ad03amr7238678137.19.1741606887582; Mon, 10 Mar 2025
 04:41:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Mar 2025 06:41:26 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqo6ycczdr.fsf@gitster.g>
References: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
 <20250307-493-add-command-to-purge-reflog-entries-v1-1-84ab8529cf9e@gmail.com>
 <xmqqo6ycczdr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Mar 2025 06:41:26 -0500
X-Gm-Features: AQ5f1JpEVxvvGHY_LOEfBQPUiATtVoYdinsI6xhN7Tl4IVWe1TfJK0w3yWwOzt8
Message-ID: <CAOLa=ZRqMnus=MZV1ASce4pxnMkVRGqhZZ+vZNcGhWdUQE-JRg@mail.gmail.com>
Subject: Re: [PATCH 1/2] reflog: drop usage of global variables
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000df9015062ffb7306"

--000000000000df9015062ffb7306
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The 'builtin/reflog.c' file uses the 'the_repository' global variable
>> directly and also via 'git_config()'. Since this is a builtin command
>> which has access to the 'struct repository', drop usage of the global
>> variable and use the available repository struct.
>>
>> With this, remove the 'USE_THE_REPOSITORY_VARIABLE' macro from the file.
>
> I suspect that this is not quite right.
>
>     $ cd w/git.git/; make
>     $ ./git-reflog list -h
>     usage: git reflog list
>     $ cd .. # not a repository
>     $ git.git/git-reflog list -h
>     fatal: not a git repository (or any of the parent directories): .git
>     $ git.git/git-reflog -h
>     usage: git reflog [show] ...
>
> but I also suspect that it is mostly due to the original program
> structure that uses OPT_SUBCOMMAND() that the subcommands fail to
> respond to "-h" unlike the top-level command, so this may not be a
> regression.  I do think however that this change is making it harder
> to fix.
>

Hmm. But this is the existing behavior, no?

  # Inside a git directory
  $ eza .git
  b4.template  branches  COMMIT_EDITMSG  config  description
FETCH_HEAD  filter-repo  HEAD  hooks  index  info  objects  refs
reftable  rr-cache

  $ git reflog -h
  usage: git reflog [show] [<log-options>] [<ref>]
     or: git reflog list
     or: git reflog expire [--expire=<time>] [--expire-unreachable=<time>]
                           [--rewrite] [--updateref] [--stale-fix]
                           [--dry-run | -n] [--verbose] [--all
[--single-worktree] | <refs>...]
     or: git reflog delete [--rewrite] [--updateref]
                           [--dry-run | -n] [--verbose] <ref>@{<specifier>}...
     or: git reflog exists <ref>

  $ git reflog list -h
  usage: git reflog list

  $ ~/code/git/build/bin-wrappers/git reflog -h
  usage: git reflog [show] [<log-options>] [<ref>]
     or: git reflog list
     or: git reflog expire [--expire=<time>] [--expire-unreachable=<time>]
                           [--rewrite] [--updateref] [--stale-fix]
                           [--dry-run | -n] [--verbose] [--all
[--single-worktree] | <refs>...]
     or: git reflog delete [--rewrite] [--updateref]
                           [--dry-run | -n] [--verbose] <ref>@{<specifier>}...
     or: git reflog exists <ref>
     or: git reflog drop [--all | <refs>...]

  $ ~/code/git/build/bin-wrappers/git reflog list -h
  usage: git reflog list

  # Outside a git repository
  $ eza .git
  ".git": No such file or directory (os error 2)

  $ git reflog -h
  usage: git reflog [show] [<log-options>] [<ref>]
     or: git reflog list
     or: git reflog expire [--expire=<time>] [--expire-unreachable=<time>]
                           [--rewrite] [--updateref] [--stale-fix]
                           [--dry-run | -n] [--verbose] [--all
[--single-worktree] | <refs>...]
     or: git reflog delete [--rewrite] [--updateref]
                           [--dry-run | -n] [--verbose] <ref>@{<specifier>}...
     or: git reflog exists <ref>


  $ git reflog list -h
  fatal: not a git repository (or any of the parent directories): .git

  $ ~/code/git/build/bin-wrappers/git reflog -h
  usage: git reflog [show] [<log-options>] [<ref>]
     or: git reflog list
     or: git reflog expire [--expire=<time>] [--expire-unreachable=<time>]
                           [--rewrite] [--updateref] [--stale-fix]
                           [--dry-run | -n] [--verbose] [--all
[--single-worktree] | <refs>...]
     or: git reflog delete [--rewrite] [--updateref]
                           [--dry-run | -n] [--verbose] <ref>@{<specifier>}...
     or: git reflog exists <ref>
     or: git reflog drop [--all | <refs>...]


  $ ~/code/git/build/bin-wrappers/git reflog list -h
  fatal: not a git repository (or any of the parent directories): .git

Seems like the behavior is the same with as with (git 2.48.1).

> In any case, when you are adding a new feature, I would strongly
> prefer you did *not* take it hostage to unrelated internal clean-up
> with a dubious value.  For the library-ish parts of the system
> (e.g. reflog.c at the top-level), not depending on the_repository is
> absolutely the good thing to do, but the top level cmd_foo() are not
> meant to be called as helper functions repeatedly with arbirary
> repository instance, and a churn like this one, only to mollify the
> USE_THE_REPOSITORY_VARIABLE macro, does not deserve to take a more
> interesting (in the sense that it improves the life of end users)
> change hostage by pretending to be its prerequisite clean-up.
>
> Thanks.

But point taken, I'll drop this patch in the next version! Thanks

--000000000000df9015062ffb7306
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c0662bc091805e45_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mT3orUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNlluREFDQjBEMlBWb1BsQURKdlY1NE5qT3d2WmZxTwplOEdkdXNhNFNk
VUdkY2Z4V2hNVHpqRkNIMDJKY3lLekdCdWZiemxyZXZNbERsUzQ4LzhVZTc2cHp2ZVhIQUx5CkxN
QThCT0szRnlRV21va2h0WkJBc2hXem02UVltNTNvRUN2K3lDWE9kQXBqOHQ2aWRTUllsUTBKZ1Rr
bkZKVjkKcXBuRzcrTm92a3VsV2ZNUCtMblFKUVFvS3pycUgrdmdmaGZTTExrTTVJQ2pHZ1ZzOHo0
ZFgxTFI3ZXhiNy9uRwp2OVlFbWlEY1dZWFdPV0ovaWR5SlRvcFNvWkV2MnB2TlRLN0Z5VnBsc2Jh
TEx1RzZpN25VSFk5elg1SkhWOVhhCmFXRGliZ1BEb0M5dlg5QUpMV1NOQm5TV0J1Rk8yd3RGTCtC
SlZCL3VFMXpZem16RjNnU3FXTEZkSjNiVWZ4OEUKdllOcVF6OW8yWExDcEc1SzVCK1UzZGIydUs5
NllTN04wWXQ0aHJYYUs3VldSWUs0OVUvcE8zQW1iYmZsK1NSRQpoVG50M01PODltcUdvci9TRXAy
alVCek5aZW5lT3ZBaDkrNU9IdDVUaWtLR2hkNWx3enZGcllJYXZqZ1hBNVVsCm1zdTNxeUJOV0ov
ZWtTcXZXRzlHUHYxVnZmTU1ZYzcvUVhVTU1tST0KPWhnVlkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000df9015062ffb7306--
