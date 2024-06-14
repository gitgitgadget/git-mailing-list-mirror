Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF0E14882D
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 21:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718400880; cv=none; b=fCqY4d0/VsGpTLgvD9NZakPxbOz5mYdG8erDnxg2YYpDnvFuatYpU3ipKmIElPBOB2UKzQbo1dxg5pAqC8I2atxAXYY1qEP9u76WbjMkHDK38SyA0CfSnCEIsZLje06cD/VfrBAl1gXP9ql+fyyjQHUK4NwH6Qo7lbPQOquylJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718400880; c=relaxed/simple;
	bh=GOsRlhjRS+cGi+MOT/pye718fplCLiyFIIug8n6hdU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyTpVdGqULgtrfRjcm3HlLrFingluLnYyGdptdvbRtMZwo8RJIFHug1JokeL9LFOp0mhvADgss9bA0hHgvVj99E/tBgSh5/G27ielA8B3q5xLPmhhK46icfhQutlksaPQ75m3Pq+JUWcuoT8pr/W71ZNf8ekzM7zKJXF4zrkvoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXxxGsRU; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXxxGsRU"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7eb77b1d2fcso112980939f.0
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 14:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718400878; x=1719005678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxuswqrWEOEpRXAtFY0QUuXCA4W9DWTyI+fFRR93yGY=;
        b=aXxxGsRUnv54QlmeSt/AqmptMC/TCIq+jITpw2hTC6iNf/xoa39iD0yy1S7nHrFnh9
         53iCIzfKqJpHmUzXMN4sXpczOVf0enLVmm8CoGT2KrURnHhrcHOuOj3eoZqCOc2+4xGz
         U9KiiqDTPOF8ySstxVmE7m20mFFPcyzb90lZvsLYApeF6ft0Dm5VYzDaLS6U3QgtjFj+
         9r3PVclzMUIh77Aoyw4E18v65GIOgYskgJl/HJZJpO+kFxNo17DIKQGVkmVk3p3YkN+7
         jkG8xqL3RsECdCJZQYISPocE9fmRK8quiJlHawVExOmNGo9cz30KdvEpCXhjXZ6/hs+T
         DPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718400878; x=1719005678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxuswqrWEOEpRXAtFY0QUuXCA4W9DWTyI+fFRR93yGY=;
        b=v67TMDnp612HgAfkcjuh8+4a4/Oesg+m9Jlau0AVXB6IPjlWb0JKTUeqZKDaPVx8Pp
         +jdQotfPciRPZuw7tAnzePl9mmjsIWOQY6rFhVuoSuEmH9zCCzCWRSLijCK3JGMn5D6T
         oI8jz90EmdIypNWi4YHKB8vn337nkBm+0qrRAvM+sMRDhLP6pVnLpM5CoUTctExS7+q7
         jpxxNZeIqKpJTbNvJfb7l/6cgCF4nKpOMz4nbKo2ck8lzIhC7EA2wzvz2h8HZXMrFfI0
         IDvAjE6elxvxchROxeliWeS6NlIRdGJ+eKfmMNhnsm0Dl2amoNHg6xJAhqrXL8JDs0lP
         sZpw==
X-Gm-Message-State: AOJu0YwjQ5EVBr5EYT4wSTZ+4AVYVhAFkoWlMLB2ohG4DM6hNFUwG6p8
	beh9bTedMKmRfoH98kgHLagx1O/upkFxHjdD7/w+xrbsL1DmF6nClf7ESU4jNjFejK9FDqlBVWl
	ZEd5AeIDjVALMgvRiQfcZpSFs46i11A==
X-Google-Smtp-Source: AGHT+IENRJcslp5jyJW0gvARETViRec1Kc3h88w/hcOs0njrIhx5u465T/lmcgu8UPvCNWc/EBWcrUSr+UFf056NMtA=
X-Received: by 2002:a05:6602:2d8a:b0:7eb:4926:f66 with SMTP id
 ca18e2360f4ac-7ebeb4b677emr415993339f.7.1718400878538; Fri, 14 Jun 2024
 14:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603200539.1473345-1-gitster@pobox.com> <20240604220145.3260714-1-gitster@pobox.com>
 <20240604220145.3260714-4-gitster@pobox.com> <CABPp-BH3ZozGnDueK=J4QvZMYZkS13Gk+0rhe+Dywqbx1F30DA@mail.gmail.com>
 <xmqq7cerdxv4.fsf@gitster.g>
In-Reply-To: <xmqq7cerdxv4.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 14 Jun 2024 21:34:26 +0000
Message-ID: <CABPp-BEM4fqU9s7_dxgi_twe_T169mGjZN9-CJRLU5cjnUi8WQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] show-ref: introduce --branches and deprecate --heads
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 9:21=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > If we are renaming --heads to --branches, should --head also be renamed=
?
>
> I do not think so.  It is specifically about HEAD (the thing that
> lives above refs/ hierarchy, historically implemented as a file
> whose name is "HEAD" that is directly inside $GIT_DIR).
>
> Thanks.

I'm fine if we don't want to rename it, but I don't quite follow this
particular rationale.  The logic you use here seems to be about
internal details ("it's the file named HEAD") and ignores what users
might refer to it as ("current branch"), whereas --branches ignored
the internal details ("the files under refs/heads/") and instead
concentrates on what users might refer to them as ("branches") and
used that as the rationale for renaming.

That said, I've almost never seen users use --head (and haven't used
it myself), whereas asking for heads/branches is much more common, and
I'm very happy with the change from --heads to --branches.  Also, even
if we do agree --head should be renamed, I'd be fine with punting it
to later in order to get this improvement in now...it just seemed like
a small inconsistency that I thought was worth pointing out.
