Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B031339A4
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720209443; cv=none; b=eyuEH9RGkIh+L033IJp+zAg6xGJxbwOWq9M1T9WZCIQBXR5m4cS6pOjdlHaowekxIkrQ1JKy+i1iXtZ2rQFt4GKBm9WrLFd+pFTVkQI03nXIF8Xb/bRIGXtbM7/ogWmXWr18ZtbV+vyeJwi3z9R0w5xx3tx9H2Th0lTZTLPgmKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720209443; c=relaxed/simple;
	bh=VC9bMcKSlMiCCuZk+Xq2JEwoUYORlIaOrfM23l4/T44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKS0mATaihvILbCpUZVpUEnpWqGpNXZOBrTgabBeFoHJAnQdNHFL8qm03iMtevNK5hvEOT7ijoXRm4eR6O7dukvEww7kHE36bGipVIrRp3EbjtGXeyB6Ne/DGvbcrd0gVXhVBBEerYItnRDQj54gYWbHIvtoi8lPA5vdU9iOMkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b5f2ac0fb9so6642116d6.2
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 12:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720209440; x=1720814240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLKnXW42dYi4YNvXg7+Cs1jwVrqLWqgDHK1nJLLvcRU=;
        b=nNz8BusGXU78Lo2foLPnBHDovewX7aeKYOGnDPxdSMaNlgCS+D5ImHVLvKJahk2Osn
         diTnBSZUolvZEzuZIqms5cIFN24HqvJBMz+nzAmYO+ksk3abH099iKIVWM+zhObvC7Fp
         4DDUyZ9DF0/AvU+4rK8/unWbvlCDNHZZ3jh0ARFJI1LgklgYUxImMusRTvpbc+yhIA8s
         Jw2+vWr8wSh1IAB5YlN+h/o+3EPBiXLfCAdYRyVe2u1ai1j99RMhrsBgkxQcatXsXvf5
         VlWLWwwSg2w21J2WTcbIdSC+N/T/O1aBbHhY+MSu8tfIP5yiVx+L4+dDP7jplxhguKkq
         lChA==
X-Gm-Message-State: AOJu0YxwDVy3LdStxgGqfmiySJwas+zGx9hETsUihyz2OutCUp0TH5ou
	pJZpqtuLo9Ys/3jMJ6hljwOzXAtM+T5zRc+vjid4yJiLZycUQE3Hdhyy7yQ073/E6+Vl1BTXsUO
	HFNkExzPJgK4pnLJZohbUtHWUYS8=
X-Google-Smtp-Source: AGHT+IHNMtCscIkXSI6vg7vk53w0taFcbE6YulZ67lEaheH/u9gka6G853xUQJN79RRL+5NuZUeCNEv6TaI6q0pElI8=
X-Received: by 2002:a05:6214:2a48:b0:6b2:b054:c64a with SMTP id
 6a1803df08f44-6b5ecf79214mr56443896d6.1.1720209440536; Fri, 05 Jul 2024
 12:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <17df67804ef7a3c8.df629cdadcf4ea15.524a056283063601@EPIC94403>
In-Reply-To: <17df67804ef7a3c8.df629cdadcf4ea15.524a056283063601@EPIC94403>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 5 Jul 2024 15:57:09 -0400
Message-ID: <CAPig+cRQPrtGBTxM49nUeHvsVr0qEOnKZ5W_4by=A9mXEsR3DA@mail.gmail.com>
Subject: Re: [BUG REPORT] git-gui invokes prepare-commit-msg hook incorrectly
To: brianmlyles <brianmlyles@gmail.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[cc: +j6t]

On Fri, Jul 5, 2024 at 3:23=E2=80=AFPM brianmlyles <brianmlyles@gmail.com> =
wrote:
> I noticed that commits from certain users were ending up in our
> repository with comment-like lines in the commit message. [...]
> [...]
> This seems like a bug in git-gui. I see two fixes, but I'm not sure
> which is more correct:
> [...]
> - Have git-gui create the commit in a way that causes the message to be
>   washed
>
> The latter seems like it would be more consistent with other workflows
> where the user is seeing the message in an editor, so my instinct is
> that it would be the better fix.

A patch to make git-gui strip comment lines had been previously
applied[1,2], however, it badly broke git-gui when running with old
Tcl versions, such as on macOS[3,4]. The breakage was not
insurmountable, and a patch[5,6] was submitted to resolve it.
Unfortunately, the then-maintainer of git-gui lost interest in the
project about that point, thus left the issue hanging. Thus, to this
day, git-gui still doesn't strip comment lines.

Resurrecting these patches would be one way forward, assuming the new
git-gui maintainer[7] (who is Cc:'d) would be interested.

[1]: v2: https://lore.kernel.org/git/20210218181937.83419-1-me@yadavpratyus=
h.com/
[2]: v1: https://lore.kernel.org/git/20210202200301.44282-1-me@yadavpratyus=
h.com/
[3]: https://lore.kernel.org/git/CAPig+cT-sfgMDi9-6AEKF85NtOiXeqddJjk-pYuhD=
tTVAE-UEw@mail.gmail.com/
[4]: https://lore.kernel.org/git/CAPig+cSC8uNfoAjDKdBNheod9_0-pCD-K_2kwt+J8=
USnoyQ7Aw@mail.gmail.com/
[5]: https://lore.kernel.org/git/20210228231110.24076-1-sunshine@sunshineco=
.com/
[6]: https://lore.kernel.org/git/CAPig+cRQN4PjfxEOZ8ZBA_uttsRPS8DPDgToM_JFv=
ichDDh_HQ@mail.gmail.com/
[7]: https://lore.kernel.org/git/0241021e-0b17-4031-ad9f-8abe8e0c0097@kdbg.=
org/
