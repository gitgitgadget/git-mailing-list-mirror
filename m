Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7102C9D
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759878443; cv=none; b=kji2EhDQ0Bzst7ChYqqnBTzAyqcSR8jyql/jFGEVI3LNNG0fykyI7pcdaWl7fg5gulLg589sTarJI2Qhh25YJwm3t8OEF0G/vABhC9BsyS2rKZ51NwCE6FJqL6QKLnvTKAoy9NYW/hU7ablhOXqyOItCtrwN3exQuxCAajD0/TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759878443; c=relaxed/simple;
	bh=+BDL3UOrv3WFXCwR9K0N2ZihNR3by1OGnprxPt6KZAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrC3DDKbS6JTpO6f4++nsNYVT33JHwk29D0K42/K2fS2LSFH2oFlMeMw+pGksOEakOesRlTb38T8kxYXI/GjzrbAMl1k+tMvgkbzB8BINMbLZMsjvOpIEywJtuJ2ij71a1EIIpUjNancT+qSMXqTF+8JV0Vpg11nkw1rCjdPg7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZwplT2H; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZwplT2H"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-911520e43edso272982839f.0
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 16:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759878440; x=1760483240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATMTyff7bJxjMM35xlWfY2zEKo3liUJXFpeGS4tSOzk=;
        b=hZwplT2HaE/ZE0GMwm2HM1Z7ONjY+S4LaskhynhWOPgFiA9qhPJu5MxEc7vVsbh4ui
         IuMocHP0TqdIzVeuQNrpUMfmJ+dU8UO/mY+aGogvoLmiB5cSU4cpYWyo90q+DP/Yl9yg
         aYViMZXWKBgbtXZblKRuZugvhb3M3/Xaxw7moOuCQPuZwfWm0GxErRrqxcKldhCk+Erk
         p/TFlWP/CatEmpOFNfJtz8Ie8A3mkrV+mjzy8ZmI4McdcOMIL3k9RRVad9KtVP0VGS33
         /Vb8T4+eTZ7ljDCunvjSyjKttHMooNGSAc+T1zrbGj+Ox/7N4pZnaWBspYSvB7sW0jlt
         y5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759878440; x=1760483240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATMTyff7bJxjMM35xlWfY2zEKo3liUJXFpeGS4tSOzk=;
        b=I3Wc3wL5rswBKoAxfck616XMUi/BPM34WOYqRO8kpfWJ4JZo3iJ1RhzDO0huxmvbWW
         8arfXvHdunfuZslg8KfVB6PMdyptCrISZv1T3Oqx+QgBWpYKfiiRg2NmisnJcSlGadSE
         qpus15KrkjdbHQjA14VgvWdmWVTgCgJP07wReKACL4z9sBuBsnZyzH/YVO+Omh5HWhz6
         C+Yz3byqd/OStpNAEu02FudC9CgF73t6vzZVACJprya32INb7Hfk9uPA1FkduI1edM4M
         YZq10hy4nSQlNFHUeS3e6sIZnQt/lgcmZgPvB650NaObL62ir7XC8qPDM2c3j9usgbt6
         tbog==
X-Gm-Message-State: AOJu0YynOYygTcswewTR7unBoxSjUpdJJfST6BS0Z/ACRXQroBFkV+EE
	+eYb5SokfHs6Djy34d0qk4QZAE3xf6iI0tlWkUCq21W22d2fXGUNOhIp9+secapgyI61M2qVHoF
	A4xLYEm2K+cKsOI+f3LCxMkyWiYgalKHcYimS
X-Gm-Gg: ASbGnctfT5//nZLz+0KWQ/DjIbBf9uqm0eUHM19NpUANGXbwRL3r/FJSyuuuPubvLko
	Nv00Uwd+wy0BLaE/2Y4SkJAu3mmzxkvGurhIAizU4bFLkF/XbUvc2BmmkKMMt8c8wsAqtAxqsKP
	NdDXcv0T+dzJiuG2fViY1xzxqMrVpBYQYQGuZF+ZFo6fdfZ87piia5jtkMhIGy/1hlf1pDbcjMf
	e7Jz1zpE1aQmg6AXOQF8fwzun2KrX0+O9C5vAojo3FTqgFxHzh1H9dAJSp+f1Hp
X-Google-Smtp-Source: AGHT+IFmbft3QDVC445FHaF2v0cBMKe39i9rzKVXBoWUWvvaYVEDv8DS4CglYsf1SjgTM8/Udw/jmMCfW79TPKn57N8=
X-Received: by 2002:a05:6e02:12c1:b0:42d:7e2c:78b8 with SMTP id
 e9e14a558f8ab-42f8736cdfcmr11304945ab.2.1759878440380; Tue, 07 Oct 2025
 16:07:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com> <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
In-Reply-To: <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 7 Oct 2025 16:07:09 -0700
X-Gm-Features: AS18NWDdumtqF24hsdoPtFxou2Nm6kLDPgCsHiZ4sJ3qLCLrQI8nksmUlKYHOZQ
Message-ID: <CABPp-BEEHsFwE-bDjcUoDtAYm9pvVN0tGUaoh0KPEJu23LywOQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] sparse-checkout: add 'clean' command
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 3:30=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> NEW: This series is rebased on a recent master to remove dependence on th=
e
> updates to the global variables used by the sparse-checkout system.
>
> When using cone-mode sparse-checkout, users specify which tracked
> directories they want (recursively) and any directory not part of the par=
ent
> paths for those directories are considered "out of scope". When changing
> sparse-checkouts, there are a variety of reasons why these "out of scope"
> directories could remain, including:
>
>  * The user has .gitignore or .git/info/exclude files that tell Git to no=
t
>    remove files of a certain type.
>  * Some filesystem blocker prevented the removal of a tracked file. This =
is
>    usually more of an issue on Windows where a read handle will block fil=
e
>    deletion.
>
> Typically, this would not mean too much for the user experience. A few ex=
tra
> filesystem checks might be required to satisfy git status commands, but t=
he
> scope of the performance hit is relative to how many cruft files are left
> over in this situation.
>
> However, when using the sparse index, these tracked sparse directories ca=
use
> significant performance issues. When noticing that the index contains a
> sparse directory but that directory exists on disk, Git needs to expand t=
hat
> sparse directory to determine which files are tracked or untracked. The
> current mechanism expands the entire index to a full one, an expensive
> operation that scales with the total number of paths at HEAD and not just
> the number of cruft files left over.
>
> Advice was added in 9479a31d603 (advice: warn when sparse index expands,
> 2024-07-08) to help users determine that they were in this state. However=
,
> the advice doesn't actually recommend helpful ways to get out of this sta=
te.
> Recommending "git clean" on its own is incomplete, as typically users
> actually need 'git clean -dfx' to clear out the ignored or excluded files=
.
> Even then, they may need 'git sparse-checkout reapply' afterwards to clea=
r
> the sparse directories.
>
> The advice was successful in helping to alert users to the problem, which=
 is
> how I got wind of many of these cases for how users get into this state.
> It's now time to give them a tool that helps them out of this state.

...in v2, I found some cases where the tool doesn't help them get out
of this state.  In v3, you documented those cases, and didn't attempt
to provide a combined tool.  I'm a little disappointed at the
end-state, because it means we tell users to use a combination of
commands, and they may have to figure out the order to run those
commands in.  However, I think with the documentation you've got,
we've at least improved on the status quo, so we could always make
further improvements later.

There was an error message and an advice message that I think could be
touched up to improve on this (commented on both in v3), otherwise I
think this series is good enough to merge down.

[...]
> This option would be preferred to something like 'git clean -dfx' since i=
t
> does not clear the excluded files that are still within the sparse-checko=
ut.
> Instead, it performs the exact filesystem operations required to refresh =
the
> sparse index performance back to what is expected.

This paragraph is the same from v2 of the cover letter, but we know
this paragraph to be false -- the new command only works in a subset
of applicable cases, otherwise an additional command (sparse-checkout
reapply) is also needed.  So, it feels like this paragraph should be
updated.

> Updates in V3
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Huge thanks to Elijah for such a detailed review. Apologies for the delay=
 in
> responding.

Likewise...it's nearly been a month since you sent this.  :-(

>  * Removed dependency on stalled series around updating the sparse-checko=
ut
>    globals.
>  * Commit message and documentation is updated to better describe the
>    conditions that qualify a file or directory for removal.
>  * Tests are expanded significantly to include special cases and
>    aftereffects.
>  * A note is added around possible future expansion of the --verbose opti=
on
>    to include more detailed status information on the files that would be
>    deleted.

All much appreciated.

>  * Due to a situation where a file appears as "modified and deleted" afte=
r
>    the more aggressive updating of the tree, the previous patch 8 is remo=
ved
>    (for now). I may reconsider and send a version in the future that avoi=
ds
>    this issue. Tests from the earlier patches are more expanded in such a
>    way that the aggressive implementation requires test changes that reve=
al
>    this problem. See [1] for a copy of this change and how it impacts the
>    latest tests.

Yeah, I think I was hoping that patch 8 would instead be modified to
handle the additional cases (or more patches added to make it all work
out), but punting that for future work seems viable too.

In summary, I think this series is close to ready to merge, but I
think a couple wording improvements to an error message and advice
message that I called out in separate emails on this series makes
sense to fix up first.

Thanks for working on this!
