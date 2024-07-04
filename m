Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FC22F23
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720123686; cv=none; b=A8a7ALExdxPKIrD1qxWNNSdMwC+nrApQF03li6vvdU95uafQ4ho8nnZyhEPQz2N335ZGROD3UegognK3i59E+VSuFcYXtnzf1N4YhTb4+Kkrm870N91woZ3YbgRvUzyJjgamgU6omWRCgRGKmA5YF8pyD2v22CQS3pbGDjZe17U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720123686; c=relaxed/simple;
	bh=fHwt5HzSrQt565RPkV+L3b2WdHLc0drgRfsBUTVhSxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RECyN474RN2ii/ARd3NnMtgHNDOppmTNppzrzTqR3z+AMO5U0FgouezIAjGp/xNfFXYxazLM/VWpCag3UejGA8mRLVv0SI+YCzN3IJnfT/mN/UObvQNCCMr8bTX2BwErtbGmTJVFatCjIp4UcqBd+v6F/k4vjpbUsMMxSkpQKTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQt6CJ71; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQt6CJ71"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7f65a32a58fso32114039f.1
        for <git@vger.kernel.org>; Thu, 04 Jul 2024 13:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720123684; x=1720728484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzIlimJVIVTffUQnHV3cnjA4xIcGKTstj3EF+lh55WA=;
        b=MQt6CJ71PxkawJwbcKqmA+hHQl189k2Zn/uZCTmQcGQK3b8JsnI4sMHkI6Tl4DvAcX
         WDdLjFFTm2mDgBPIUQICqIzuekN/CO1PQrDUIaVs+QjJdA52bvL6Gwu9h3qruDpRg5+d
         wvZB3Vwd18IZj1IkAi28qh2TctkPBttFURYpgB5bWeE3fskJLxX5WnD2cfRfebQuI+OA
         dXI6kO5gwggiSxsPz/a5kJkJgtsxy58vNLUxobPjag73jloDZ/OXf5kPxuZxMtnGRw1B
         jmg8O3XHMEGGPBjr8+FKy12LPuXRqNz+W0DQqY7zWyOL2jbAyt3ljCdXmWrydWhEcRfd
         sR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720123684; x=1720728484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzIlimJVIVTffUQnHV3cnjA4xIcGKTstj3EF+lh55WA=;
        b=Toc1VLiqp+jRG7/6b06xeusIVxu6Kq6LY55zWk8Qpc0N9QpYQbN3VEpEgy3PPKaXAd
         iJ0ZbqEhxI0QCuejZUoA+ZUOgAy6syvYr9QF7S3qc57asWPAi2rdtRMA0JLldl4JiA25
         dmyVAt4NC3J6tG3arb8+h02SisH+B7Wjfzf6oVZ87w6IyUhFyn/OnBGfivyv4TnasHAQ
         SiHlAwQpT3zGUECs2O+PzqJEwj9EdZBAF4m0+OeEk4WlJ3F0DQwVSCWNUlKShwZBDdIL
         nV7BQN5L7Mw+b8R/6CSeGFP01mu5Ep1E0iW+yRRWgcvMtUpzW+rIrOPjxuIOTfIeI/IH
         7qXg==
X-Gm-Message-State: AOJu0YzCJdBxVAUakACP1yB7NTaIehOdGfW/fYKV+8Et9k3m3k9aN6Qu
	cH950ClM2u1w+SiBaDgSCZnfFld69EOs6HgHTEqAv1mVTCg+Z1bjChxs4h43S3UmtoVbWVDRXLf
	C5zrJTvFxDxtsetHY2hR1MO1Xs3BGLPBx
X-Google-Smtp-Source: AGHT+IFGJZ4tfmuXOKApbm3fdfq65ofmh/qbdpCGZqjfc/CR8dOkkGANdxhH0G8YwhMwJhgPIxs7pj55q4EWIWA7EfM=
X-Received: by 2002:a5d:81cf:0:b0:7eb:db06:e067 with SMTP id
 ca18e2360f4ac-7f66debe0b4mr291600139f.9.1720123683745; Thu, 04 Jul 2024
 13:08:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFjaU5sAVaNHZ0amPXJcbSvsnaijo+3X5Otg_Mntkx2GbikZMA@mail.gmail.com>
In-Reply-To: <CAFjaU5sAVaNHZ0amPXJcbSvsnaijo+3X5Otg_Mntkx2GbikZMA@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 4 Jul 2024 13:07:52 -0700
Message-ID: <CABPp-BGVdQZCr=0NzY9vpUJqaH+5yxJdpvfUqqhtWB4V=nkwDw@mail.gmail.com>
Subject: Re: `git diff`/`git apply` can generate/apply ambiguous hunks (ie. in
 the wrong place) (just like gnu diff/patch)
To: Emanuel Czirai <correabuscar+gitML@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 8:25=E2=80=AFAM Emanuel Czirai
<correabuscar+gitML@gmail.com> wrote:
>
> Subject: `git diff`/`git apply` can generate/apply ambiguous hunks (ie. i=
n the wrong place) (just like gnu diff/patch)

Yes, this is already known.  In fact, it was one of the big reasons we
changed the default backend in rebase from apply to merge.  From the
git-rebase manpage:

```
   Context
       The apply backend works by creating a sequence of patches (by callin=
g
       format-patch internally), and then applying the patches in sequence
       (calling am internally). Patches are composed of multiple hunks, eac=
h
       with line numbers, a context region, and the actual changes. The lin=
e
       numbers have to be taken with some fuzz, since the other side will
       likely have inserted or deleted lines earlier in the file. The conte=
xt
       region is meant to help find how to adjust the line numbers in order=
 to
       apply the changes to the right lines. However, if multiple areas of =
the
       code have the same surrounding lines of context, the wrong one can b=
e
       picked. There are real-world cases where this has caused commits to =
be
       reapplied incorrectly with no conflicts reported. Setting diff.conte=
xt
       to a larger value may prevent such types of problems, but increases =
the
       chance of spurious conflicts (since it will require more lines of
       matching context to apply).

       The merge backend works with a full copy of each relevant file,
       insulating it from these types of problems.
```

> This doesn't affect `git rebase` as it's way more robust than simply
> extracting the commits as patches and re-applying them. (I haven't looked
> into `git merge` though, but I doubt it's affected)

This was not always true; and, in fact, rebase is actually still
partially affected today -- if you pick the `apply` backend or pick
arguments that imply that backend, then you can still run into this
problem.  The merge backend (the default) is unaffected, and this
problem was one of the big reasons for us switching to make the merge
backend the default instead of the apply backend.

git merge is unaffected.
