Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB9B266B6B
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 19:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758397947; cv=none; b=RCcLKMiQAwnl4AEfWnoxzRsh/lHcCYW+qrWbjY0hnFs5rteJ8ZpwmlgeWrRcEkpZbAFazX/Yj3ANQq/jXp4FBd3jUZq8pdJyQm5NoVcQ/86rRl1iwLwWoqMl93NmWLiDbuRvfI0f6wPdEaB/NDkK2s2cjhU01NzvGvh5gvju4g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758397947; c=relaxed/simple;
	bh=A/M1efgFIevfsbpNd3cYZsH8NWFjK94SZ5YCSEbWuJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I86nfdKGzz2b4cz3qhGC6h0gmgk/MNzp0xADJe7YwPzvGCGQKDufVhj/Sv/m6dS1Grz8GzHfAODRHvgJX0uHPRqfHMFkc3QslBq1JWbmqru4eHvvgV1sJyfWSASkSS3zmi9HYay9Hp3vc2e5y37ps1QrmYOdqXmUyGOaLO78Q3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbPYOVp1; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbPYOVp1"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-78dfaf6a9b5so991166d6.1
        for <git@vger.kernel.org>; Sat, 20 Sep 2025 12:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758397945; x=1759002745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/M1efgFIevfsbpNd3cYZsH8NWFjK94SZ5YCSEbWuJ4=;
        b=gbPYOVp1hdjKVs52RHhmKllSQKzdD9eQIQD8A26df6GeZ6hfmlzTMyrR2E+4pa+/O2
         i61M/E4+jubbf+hvvMRw6N3LRZdt/Kpoc5xr2ljB7WBGm7w/A323XdGqv0YfGp2of9Sq
         HmZ7PYxk47O0+OXYLo3HxaNh1+QjS9R8RVHTpfYGnVfXJJkVA5nzqfIVTH8ZnKDOwuEd
         QK7+bR3olAqLe3W1eRcMeVNtC1weLgDIV6wbyw+6VR4hU8mHd7KMFJNtTS/jAgdbx9Qq
         qHBjXB04gPEG+iPbo+/BivfYwGUI/6uieDh4ooqWO3+kkV/TPR7tRBbq7bexfMhrL6jD
         7jFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758397945; x=1759002745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/M1efgFIevfsbpNd3cYZsH8NWFjK94SZ5YCSEbWuJ4=;
        b=LVB7ktvsZlBLEMjdcW4lE2zy/uv+5OnPerMGIRqvkmFaizo4CWQ+MjW+BajUnjYgQi
         ffDuXCNzodTM0RKb+9kt75eJvSW7AT3KDWHiLxWRgJEzbBrwozEOQh7WA37eCEpo+lel
         uRJDiF+SmxgwKpFS/FHBa20sCIZ7wLhaK62MEVh1NOPKrPtA2+hN4GqifDV1O/wzbzB0
         q/0Ew7uZbgBVD1/QlCsvkQ5L0JSo1NX+5o39GvD44jDxexuGrfyfBktuAI8P/yI3Un+p
         9WindAIh/9GPoCX13f6qq5mHxry7KryceVJx/wTGsj/o4BW4xp9kvsMlv3r9di3hZgQd
         ILmw==
X-Gm-Message-State: AOJu0Yx1EafDcelvg/5A1angPeRSX+zfctjCwzppAe9H8fO7ohYhjb4G
	HKBj5lUzpjonNPRMfZTme8C3M+s3Jop2N87y9ANGyH8w8paCjTMaBCH0reuJKAbq5Oz3gQ+va9C
	gya/QjSQ2qsPpGadWeE4r9i8A4MCGA226TrKRcT8=
X-Gm-Gg: ASbGnctT7Eb2Z6ErOI83qFj1NqXFW5DgxTS/2M0HJi2A+RJVXVwmetPMnHi3Auy/6NL
	owLhg/tP9TIPw0IZWBgRMsJoPlqO5Q8LxzAlut/cjV2Z6zRTjWb3WBy9HA5wwzJLDVF3EI2OslC
	8B6GbQSkzvt48NyRxSb4Emv68KHeJNLwaAx8/wOtT8uUWv/b2uB4RJkiIPY/UtuKM1BQA5iffQb
	rfee3aEWgojPS2VjNgsjsNGd0r9ibHDvrZ7BCR5
X-Google-Smtp-Source: AGHT+IFppDxeIKdMsO3tsxTmg7CwfIO4Wv4tCwU7mJIoMB5bXZ7BS6T70IwEt8yPGa5Ls39Sl5Erj8Mj0MHuBq9Cgts=
X-Received: by 2002:ad4:5bca:0:b0:78d:8226:756b with SMTP id
 6a1803df08f44-7991dcf6bfcmr54318316d6.5.1758397945047; Sat, 20 Sep 2025
 12:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2994140.eGJsNajkDb@alfonse>
In-Reply-To: <2994140.eGJsNajkDb@alfonse>
From: Eric Sunshine <ericsunshine@gmail.com>
Date: Sat, 20 Sep 2025 15:52:14 -0400
X-Gm-Features: AS18NWA15q9mKbX7n_ejMmnvvULTgo61IUHIKsuhyYaaeCESB3Plg8s1842Y9Qw
Message-ID: <CAPig+cTRYK+5ezmGxz0d1TwMTu1RKy7Xj05CzDE2-i14aUpSAg@mail.gmail.com>
Subject: Re: [BUG] gitk assumes availability of `osascript` on macos
To: lists@humanleg.org.uk
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 8:07=E2=80=AFAM Robert Scott <lists@humanleg.org.uk=
> wrote:
> Tiny one here. On macos, gitk (tested 2.50.1) attempts to call `osascript=
` so
> it can focus/raise the UI. But it fails hard if `osascript` isn't present=
 in
> the $PATH.
>
> There are a number of reasons `osascript` might not be available in a
> particular environment, e.g. if launched from inside a "pure" nix shell, =
but
> seeing as it's just a quality-of-life feature it would be nice if failure=
s to
> call `osascript` could just be ignored.

A patch[*] was posted to the mailing list years ago which, I believe,
should fix this problem for you. Unfortunately, the patch was never
picked up due to the then-maintainer of Gitk being missing-in-action.
Perhaps the current Gitk maintainer (Cc:'d) will pick up the patch.

[*]: https://lore.kernel.org/git/20180724065120.7664-1-sunshine@sunshineco.=
com/
