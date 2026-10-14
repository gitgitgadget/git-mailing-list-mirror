Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FEE1AA1F4
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 02:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791945499; cv=none; b=MnoVNExO5v+5t3or3COs1i5kVau6vLoAkG8fUqfC9/3Pym5nMZRXq9YYoLSpZSI99Wxq9gARgJxqfh62Zsoce2sHIGuIgQJ6gEOhxm5gJmKIuoZk8ND8CtZ/Y0Sn1hKZgeCEb3hCimDWRwy1thUZhngMPcrafSp3PUz5OpqvXk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791945499; c=relaxed/simple;
	bh=2rDltg6ECCuWCkXTWqbX/pfp6r85oTzpCDbnhWw4lwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWwyqnNmPdMedPT/kPqSat7MpP9VoF4k/9UH82ysa+TDwaIbSi6zxClLDA7MKuU++aHaxEEgmqlscYb8a7+wIxZDqSI64KFr+0z9ra/6Sts9SoMXaZGOQ0K/rp8DkBnc8YStpqt0lmNxLDrABRlp0YeX6gR+ozJ4kjWHe2a61BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XatcDrI2; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XatcDrI2"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso2539184eec.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 19:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791945497; x=1792550297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3krw38k4YMSNW+eEptVRkB4xhv/qvDf/iRQkk+kMF8A=;
        b=XatcDrI2G0s73W8WYvRN/QF1xjc9ZrDSqFyTbKpsu9ONBIZX76ZoXq+Iki5qHjPAKb
         u6ACRY8MnMx94HNwv2Tzb2C5zwdQa0bwlL8O3EO5txoYLeaZu89oyoh91DOmiwSgqp8a
         x8vNmUjf40VuXtQj2ZEtZifYlA+Jf5+YvJFhKuDeSsJGKu2tO1mm6JbD2e6Iqey2sg+m
         xO81k2+wtebm6SS38aA4nM41QXt66tvPxPqw7EowJpLjtaSg4Wc/nZqNxVzSnFfYoOhZ
         QOPjFbBy7jYXyn60EJY6HXgdX0/CleimE4TlEOD+U8ycJx/Gy9SAneCSIxc9G+IA+gwh
         c4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791945497; x=1792550297;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3krw38k4YMSNW+eEptVRkB4xhv/qvDf/iRQkk+kMF8A=;
        b=CnYfil8GNMMzTTNIyRPGlYFwsdWJv5VKUdbo90PXyG67rTeB+VpmKJ5O9y3sF6BfF2
         sH5MN+q3z2PFq26D8M3xjXaXJD1RTVFYHjoBwOEa8I/vUFb3s7YvjKnlZ4B1Gcus+byP
         2oZtUcWwFvjSzsEY7DAxGQzplz08kOX0j34Fro/BDKzw1BJIeiBhcFcuYT2jQRFS1TR4
         KJIIme3RJrjPT++M5DQkCsfppyqMRz/yUieuAXs+deITPPe4gSAG9nHIoZf0dhVg8HQD
         xtGFjXUQPM+4QTpAUg+CTxsRnhtcOAHjQwlrHvAqdvNQi3L1I49rtlJpHD5Y4lIhsbEw
         CsCA==
X-Gm-Message-State: AFq9FYIc45MCUk9BvH5YCntu7KDhklExGCap/arFX05bpRc3HoQW0WkM
	K/JKv7yYBXrFvbJ30TYC7hcOxGnwJT6i79ODDTpz0PyCmzA707P+6JKkb4yqBw==
X-Gm-Gg: AYBFou1cFPIZlGSST4SPfuBmabPIwU8fD2iopF2zPrB81pYo2mlFtnpReWdSbM8Ju7t
	pjOw/4ej7T7kyEzQ96gjohIathPU5pTjbey8/VUDumYodTMWoRNH/KLLLP4LkFynnEi5MLy/dKZ
	CUAuiZotoEDN76VgNA/z66/fTIIgSoz/xrfyaGtcB9GifM44K+72sTs+mgUqVXsLFXJKPT/Cowy
	5wDkctuhHzajHnOP9Bm9EKtBNzGV2W3ZhXv9uO7RhBnFgQvl009r/Rkt+shgHYrnHhNCTveTq5e
	Ptcd1nQHuBYjhHQa4pWt+zO7fmtKipSfL2hQXBSFdyTUy9Y+4poLLVpYuqePr4q+CPEuCSzeGOF
	W4V78l3P79TxbfgRnLNILhdP+OJV1izvg9dmIT5yLeYYhagU/AI+e38juy6w1xfZ6JSb9dhoGFI
	eVCempkOls2rUBEDAfaAyY+wvTopbm98nebvJkT9Bw3QlSUAQ6NtjP83RSEQ6y6/cpPMSV+F+1b
	Zx656bV6krtxm2QzkwRxCaTkPU6yX8bjfRVpUnyZJMt4cKjFUS9wk8xNfY9PXzerw==
X-Received: by 2002:a05:7301:90a:b0:351:7d5f:df26 with SMTP id 5a478bee46e88-3537df9780fmr15095445eec.15.1791945496509;
        Tue, 13 Oct 2026 19:38:16 -0700 (PDT)
Received: from quark-fedora-PF5F60VQ (162-199-88-188.lightspeed.sntcca.sbcglobal.net. [162.199.88.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb68e56sm43671563eec.29.2026.10.13.19.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:38:15 -0700 (PDT)
From: Jun Wu <quark.zju@gmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	peff@peff.net,
	ps@pks.im,
	Jun Wu <quark@meta.com>
Subject: Re: [PATCH 1/2] repository: add core.indexLockTimeout
Date: Tue, 13 Oct 2026 19:38:06 -0700
Message-ID: <20261014023812.2935165-1-quark.zju@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CALnO6CD8c+nZktineZjo6PkZbXXEQfKto-cvJvLW=_xjTPVCRA@mail.gmail.com>
References: <20261013172315.2997446-1-quark.zju@gmail.com> <20261013172315.2997446-2-quark.zju@gmail.com> <CALnO6CD8c+nZktineZjo6PkZbXXEQfKto-cvJvLW=_xjTPVCRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 13 Oct 2026 17:40:01 -0400, D. Ben Knoble wrote:
> Hi Jun,

Hi Ben,

Thanks for taking a look. This area is a bit tricky, so let me try to
explain more clearly.

> Interesting. That must be the slow down you mentioned in your cover
> letter? I'm trying to make sense of this. I think you're saying that
> not having the index lock means status would "lose" refreshed info:
> we're not throwing away the *existing* stat info, just the ones we
> recomputed for this "git --no-optional-locks status" invocation,
> right?

Yes. A file's stat info might be updated without content change (e.g.
`touch`-ed) so the existing stat info can become outdated over time, and status
cannot use the stat fast path to confirm a file is not changed, so status falls
back to slow content check. Note: if the user runs a command like `add` that
writes the index, the performance can recover, but based on our experience,
users might not run such recovery commands for a long time, so they suffer from
slow status.

> I suppose I don't see how that causes things to slow down continually,
> but I bet I'm missing something :)

To give some (hopefully useful) examples,

1. https://github.com/facebook/sapling/issues/929#issuecomment-2628723586
   A user says "I use CLI exclusively so I would be really interested if
   --no-optional-locks was applied only to automation". The user was running
   Sapling in a `.git` repo. Sapling (back then) passed `--no-optional-locks`
   to every `git status` call. The user found `status` too slow to use, and
   hope that non-automation commands would not use `--no-optional-locks`.
   In other words, always using `--no-optional-locks` caused slowness.

2. https://github.com/facebook/sapling/commit/f11d555a3a237254e1788f9e9da40b37cd6e452f
   This is Sapling, but the concept (stat fast path) matches Git. Before this
   change, similar to Git, Sapling's status takes the wlock (akin to
   index.lock) in a best-effort way, and skip updating if it cannot get the
   lock.
   In production, we observed cases where `status` cannot get the lock for a
   long time, and the user's `status` remains slow (IIRC tens of seconds to
   minutes) without clear way to recover. This change forces a recovery path:
   if there are too many (>200) files with outdated `stat` info, then wait for
   the lock and update stats.

> It feels weird to me to fix mostly-invisible behavior from external
> tools with a config option, though. I think of config *mostly* as
> user-facing (whether that user is a client of the Git CLI or
> configuring a server repo), and I don't see how we could teach users
> to look for this or know what a reasonable setting should be for
> themselves :/ Further, we already have a lot of config options! (I'm
> guilty of adding one recently, heh.) It can definitely be overwhelming
> for users to think about all the options, and I suspect many just
> don't as a result.

I agree that users shouldn't need to know about extra options to get reasonable
behavior. In this case, I think the default (1s) is good, so users already
don't need to learn about it. The before/after matrix looks like:

    | Background status   |     Before         |      After      |
    |                     | slow   | cannot    | slow   | cannot |
    |                     | status | commit    | status | commit |
    --------------------------------------------------------------
    | --no-optional-locks | yes    | no        | yes    | no     |
    | (regular) status    | no     | sometimes | no     | rarely |

The bottom-right "no, rarely" + no need for `--no-optional-locks` seems to be
the ideal trade-off to me.

I think the same preference (good out-of-box) applies to `--no-optional-locks`,
too. I suspect that not a lot of tool authors know about `--no-optional-locks`.
https://github.com/facebook/sapling/commit/39380e1871d7c5f6f91ebb67c4efb7588eb9f65f
documented our version of "tool author doesn't know" - tool didn't set the
"is automation" env var, akin to forgetting `--no-optional-locks`. The repo in
question had a spiked ~40% `git checkout` failure rate.

> I applaud the effort for sensible defaults here, which I think will help.
>
> Anyway, maybe it's just me: if others are happy with this approach,
> great. I think I would prefer to see us try to address the underlying
> performance problems, though, if we can. (Maybe we can have some way
> for git-status to not throw away all its work, or some other good way
> to communicate to IDEs that want to poll?)

To recap, the user-facing problem is "commit/checkout" didn't work when
`status` was running, or `--no-optional-locks status` can be too slow.

By "address the underlying performance problems", do you mean:

1. Improve `status` performance so it takes index lock for a shorter duration.
   It helps, but as long as `status` takes the lock, there is a chance it
   conflicts with other commands. This series allows tools to drop
   `--no-optional-locks`, which indirectly helps `status` performance.
2. Improve `--no-optional-locks status` performance so it's fast.
   This sounds like "lock-free writes to the index", which might require
   a complex file format change.
3. Switch IDEs from polling `git status` to fsmonitor-style `status` notification.
   This helps. But similar to 1, reducing `status` frequency alone does not
   address the root issue.

For what it's worth, Mercurial and Sapling have waited for the wlock by
default for a long time, with default timeout set to 10 minutes. In our
experience that has worked well. The most common "waiting for lock" report we
see is an editor left open somewhere, which got rarer after we started printing
the process tree of the lock holder.

Thanks, Jun
