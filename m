Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F4239185C
	for <git@vger.kernel.org>; Sat,  9 May 2026 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778363565; cv=none; b=gCL+wFWYjR4WnrjmjyMw/aeEuhjfXItIbaBE7HEYIaz8bm5BtKB+dnf8H3kYLaXfWDSV0T0qSb+1t5GQns3AD+Ml7YxtL4LtjFsvWdCgzQ8bEfAZ59P1KvZ8VwyS+hqsGffacHDf0zxSW0ZjfcfAkW7SjpAPZtIow00m62xBBF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778363565; c=relaxed/simple;
	bh=9dylC0pOmB3v14IZmaZNDXig4GQt/b1P+UW7zRVkuJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c60qvoLeb7b6GGYhcPkDH81zEZSOJIw4csr9l/F1Hl93o3r14kokNnoMHh4fgpe90H/VwEXbJaZHOOsNQkmKoPPR93Yu1oUg+BppRnvqhIK7mrozqOz2vZRGphG20LNsA/CNG2Y233bipdR9qrtDfut0ivdEENfpuyXcXQJkxE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=UGwyhiHN; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="UGwyhiHN"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65c396d3b36so3195929d50.0
        for <git@vger.kernel.org>; Sat, 09 May 2026 14:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778363551; x=1778968351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z6OvMi4pbM6FzJex3IUmYTwNA4Bu7WJw+RQQwhon73k=;
        b=UGwyhiHNAWLIoSfs1GIMeobdCoxhNMp93NA2gxiZJsw/M0cFOt/9DT7vR5vie3cx6x
         qWEIBaGs/9iNvIsNAGjg7Ch91ldgiL9jjhoxyBsOplFF0tS3sf7HkQLH566QxO+tU1Vh
         0h+tMMr1VkWlNZuUx8b+iTUqHB8pP4aDFV9riIympBm9Wn23MGAjUQcjcrcXp2qCij8a
         6A9J7L7aFaoETZwt8Hcy8FALywQBtkmK6h43Ka0ZhkVjz2EpAdHVeem5HGF3c1UP/o6X
         duUhwmGQwdxItf6NPU1NMt2bTdDYHFZSHo8lB2uuMJaG87+dXsAPGCjK1hYkEPncbKG3
         mqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778363551; x=1778968351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6OvMi4pbM6FzJex3IUmYTwNA4Bu7WJw+RQQwhon73k=;
        b=LmLde1+F/lCcrVYjRJHZDthYbB445dRY97VD+Ls7Z9yOhmrA3wEaXlepnLmGM78xRg
         1MmWwTRwEao2YAZ1QpaKmpK02P/OPyuM71bv0KseK12DvGkpaUrxS/JX7+HpcK6M3x1a
         KMRJLg199j3HbX7iN7C3Wo3sTEOMjKztxD9fFo/xYm06l2vJlldSDS7oGRIUGNR+HMfw
         8WUj69D/VrPkw3zzvZyNp/QtzxPyQvgxu5u2dPpehfveVxBdSJzmWbXDhbdn1HirB5xh
         bpBSQeQbIaRdo3YKW0n4OwU8DpQ2ahg8TF+y0IQ0lceQh1VTNhQlMWyKgthFTDwY7R+V
         MEEw==
X-Forwarded-Encrypted: i=1; AFNElJ/ZNXr+AGnPbeHRBsoQtg+ekIL0iMAXB9fbGvXxh1/O6nhy7qpD8yEX13CfXOvROD7qVxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuxaurFPoxphi/TFpAk6EUqXY2zw6vj0GMh1PUOdJ41cIcGlI5
	+plDgtc9LRoFe4U2LLLd10JKfEXd+95R3WcZ1LkKimT4FyZwFfWmZTu7ISRKlMkIums=
X-Gm-Gg: Acq92OGYBxHdjFwcJ+73lPvt2CRsDwrAuA+v1HSPerwU1G1qY+PkS5pT/BlPVr63Wht
	G36QEXWgX4xMT7x1x5czO19b53kfDdg+7jgEun3ZvZagddEQLzWSw2emY4S6uVqzDy5qRXxIshY
	5spZtHK+MCUpWkbE64QL0iS2sCOGj9YcDofMrOznjymLjK3UP0AzHge2HMto4xvBN3UqQ6LVqQ4
	M4Sm5gaoWLwQk5aRtRW6BnGrnA2zyWOwTkzxDMFFGmagbDeC4zPWqlCOFHZNSzcUOmxU9wAStJj
	YlhV1Bq3KGtLY6mRnaA3cJDFtyrg73P3NBE7cMWXrMPZA+djbS2E6RtONj5WM8TnhK8OoNUet5z
	NDy0ewWCgQoxHoSQ1wcBzyo7tRU5Nlx2J4Wo4vn5lkzndnCl2pMO8gvCyFoC5s4a9PSWpxotue+
	AKIJdl0DhPsBUONPcREzglfLOaFV8GmPF7/tgyJe6NszTzPezRJIRIfFOKB4oBbpwHju7/4TLIT
	zc2XPOOqd5Sdgonxv98uw79bbg69eB6ld3uFsAeyCsdU5Rcq6iz6X9b4tcvxAanSlAOOwCFpIrz
	hR4YXdtobzaQBO0z
X-Received: by 2002:a05:690c:85:b0:7bd:696d:512f with SMTP id 00721157ae682-7bdf5d9fefbmr201929617b3.13.1778363550769;
        Sat, 09 May 2026 14:52:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd665298b4sm123969817b3.7.2026.05.09.14.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 14:52:30 -0700 (PDT)
Date: Sat, 9 May 2026 17:52:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: jean-christophe manciot <actionmystique@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: unexpected auto-maintenance, was Re: git hogs the CPU, RAM and
 storage despite its config
Message-ID: <af+snTGFeoUUyfPU@nand.local>
References: <CAKcFC3arsYExb5dCMQspo4V9UFDadFaj8Q4PUsMWZJw_eYrMzA@mail.gmail.com>
 <20260508180341.GB737125@coredump.intra.peff.net>
 <20260509175249.GA2336928@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260509175249.GA2336928@coredump.intra.peff.net>

On Sat, May 09, 2026 at 01:52:49PM -0400, Jeff King wrote:
> I don't think this affected the old "git gc --detach" because it takes
> the lock after daemonizing[1]. We can't do the same here, though, since we
> need to hold the lock for the foreground tasks. So either we need to
> release and re-take the lock between foreground and background tasks, or
> we need to teach the daemonize() function to update the "owner" field on
> all of the tempfiles to the new child[2].

I agree. We can't simply do what was done in 329e6e8794c (gc: save log
from daemonized gc --auto and print it next time, 2015-09-19), for
exactly the reason that you stated.

Dropping and re-acquiring the lock is possible, but it's racy since
there is a gap during the critical window while we fork(). I believe
that the only airtight way to do this is to update the owner field of
the tempfiles we want to pass down during daemonization.

(As an aside, do we want to do that for all tempfiles? It might be nice
to have a "->reassign_on_fork" flag or something on the tempfile struct
in case there are instances where the parent wants to retain ownership
of the tempfile after fork()-ing, but I can't think of any off the top
of my head. If we do introduce such a field, it should probably default
to "true" to avoid any foot-guns.)

> Ultimately fixing the lock bug will solve that. Though if doing so is
> too complicated for a quick maint release, I'm tempted to say we should
> consider reverting 452b12c2e0 for a potential v2.54.1 (as there were a
> few other regression fixes so far, I assume we'll have one soon-ish).

I think something like the following (untested) would do the trick:

--- 8< ---
diff --git a/setup.c b/setup.c
index 7ec4427368a..c07aeac4f7d 100644
--- a/setup.c
+++ b/setup.c
@@ -22,6 +22,7 @@
 #include "chdir-notify.h"
 #include "path.h"
 #include "quote.h"
+#include "tempfile.h"
 #include "trace.h"
 #include "trace2.h"
 #include "worktree.h"
@@ -2162,12 +2163,17 @@ int daemonize(void)
 	errno = ENOSYS;
 	return -1;
 #else
-	switch (fork()) {
+	pid_t ppid = getpid();
+	pid_t pid;
+
+	switch ((pid = fork())) {
 		case 0:
+			reassign_tempfile_ownership(ppid, getpid());
 			break;
 		case -1:
 			die_errno(_("fork failed"));
 		default:
+			reassign_tempfile_ownership(ppid, pid);
 			exit(0);
 	}
 	if (setsid() == -1)
diff --git a/tempfile.c b/tempfile.c
index 82dfa3d82f2..f0fdf582794 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -373,3 +373,15 @@ int delete_tempfile(struct tempfile **tempfile_p)

 	return err ? -1 : 0;
 }
+
+void reassign_tempfile_ownership(pid_t from, pid_t to)
+{
+	volatile struct volatile_list_head *pos;
+
+	list_for_each(pos, &tempfile_list) {
+		struct tempfile *p = list_entry(pos, struct tempfile, list);
+
+		if (is_tempfile_active(p) && p->owner == from)
+			p->owner = to;
+	}
+}
diff --git a/tempfile.h b/tempfile.h
index 2d2ae5b657d..783d7470b54 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -282,4 +282,16 @@ int delete_tempfile(struct tempfile **tempfile_p);
  */
 int rename_tempfile(struct tempfile **tempfile_p, const char *path);

+/*
+ * Reassign ownership of all active tempfiles whose `owner` field
+ * matches `from` to `to`.
+ *
+ * This is intended for use by `daemonize()`; after `fork(2)`-ing, the
+ * parent transfers ownership to the daemonized child so that its
+ * atexit handler does not unlink tempfiles that should outlive it,
+ * and the child claims the inherited tempfiles so that they are
+ * cleaned up when the daemon exits.
+ */
+void reassign_tempfile_ownership(pid_t from, pid_t to);
+
 #endif /* TEMPFILE_H */
--- >8 ---

That's not too terrible to write, and I would feel OK about putting it
in a 2.54.1 release soon-ish provided that others think it is reasonable.

Simply reverting 452b12c2e0 (builtin/maintenance: use "geometric"
strategy by default, 2026-02-24) feels somewhat unsatisfying, since it
is merely making the bug less likely rather than eliminating it
entirely.

So in that sense I would prefer to "fix forward" here rather than to
mask over the bug. But even the relatively short diff above is not so
straightforward to reason through, review, or test, so I'm open to other
ideas on how to proceed here.

Thanks,
Taylor
