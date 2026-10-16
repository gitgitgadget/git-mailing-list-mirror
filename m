Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2B7384CED
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154280; cv=none; b=Uzzx1bo0USoYdzAE8mYyDaaoyigGXIbKsvuLafqmh2GwFkhOI6QGJEECO9Tgp10CM9YGfWZFhox6QvRPX6pHG3xav4eNMZfSjaYDrXKmPdmm6w8ty3olE5vckEic1l1qGwLPqWK+I92fvCPujRaemYXAbyjLff+9sFD2kz/tEKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154280; c=relaxed/simple;
	bh=XT485SeVCmyuqmGMRO5OANj8/ycEi0mf2GlmOi2ylDk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=PTgZPM4nJY0jo6EntVx2po1FlrYCi/baEVpM3rNkO6pYo7qVOEKdpxA310+WBySnM6/l4FGUCmTXp7hxzY6Gz7zFVtWA/WzbRAeRjw8Ksa9kigVHA+mXkqSnAXLCAxL0SZQswSsi1LNFqNdayvm9KvSLOtQfZobMm9qHaaEiDxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFp3HIEV; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFp3HIEV"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8874539bccbso1719853b3a.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 05:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792154278; x=1792759078; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dyptWKE6+L4gGztz98gHie+QcW2ONV4qzr/eI5lFHB0=;
        b=WFp3HIEVrBnL+nvJFQInRIuMejuvo3T9pCZBSPnZ3DVfotVEM/lM2eajeLo9XbJf3D
         fLZxmqphK/BJJd5tjeVPCk1nJxs78ix03isDiS07D9Gw7yc/hGDOqHHjcQHtmDdYx8FV
         EjMugzxO6dAtqtTSgG+Zl+q507nrMP6KLQCWpGEsiB4cDUjDzB2Mk1xrolf8xpJT+B9B
         nlRuWv6+YcWsxKF4oXSBxh2GAF+lx74bAto7ScWe6bHe0UFXVOEMbMrfhpyK8NA5vC7L
         ZpoxhRMtuyaxQadm/X2ltYStONu/Pb+lLG2so72o2H7OdzSpsHgiL4rUKYRjpT7K9jko
         Jucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792154278; x=1792759078;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dyptWKE6+L4gGztz98gHie+QcW2ONV4qzr/eI5lFHB0=;
        b=vFh8fG4psB+TKE+NKBI+1msZSHEu7/tL1mQ7fBlowfoxcpHyUMTU5yiudO2zJaveQo
         kiUwRqh/3XdKZhUtmLIHx+hoAi8W6uSzwGG5dKxyUPM29WHwHKHAkHY713DgTTaY6Xwv
         1eP4XwM9Q0rIJveqkJxf3IUgmz5kR5a2rgcCP1yfN7y5FzSxd/nFRvxbYwaBykinaPtc
         5+qwQdT2WyrrCVQEQM/T/GFqJzwztGdxt7G1xWV7VV8BY6x+zEAaNifau/hGJOFNpOFO
         auJFnZpoeHH7dhyVH/KKkqUnlDMUubRKF+5FRrKeYgycq82gghVdjcJlzvZ4REB/8m2z
         zq5g==
X-Gm-Message-State: AFq9FYKjJdMTgPbEYF8L7+0To+E0Gh8u8yhHVkfUIpgFFSpMWuO/tcQ2
	ZhHpaJsXdB4A+09BFm6GcSgVcJWNjddeqsycOe/CgU0iBLkGmuXFAiS0uy5Sp8S5
X-Gm-Gg: AYBFou21Bmvl8XL0GZaheIxNuxDBSipT1DCocK2Lbjvq8REm1hyej4+ldQ3/LM5hTgn
	AUaRklkYzolncGVqZ+3Mzx1Pe76G3X8dirip7m4vNPnmOIELZA576Mm3UaEdpd1EXHwi/vsqXzD
	0ak04FdWNlF8Sz8FBv07BCcry5YejXzwFr+720bbxiQzlH1oYLLZzegSs7f4vKm81l9UQkk5Lke
	i76b1YGd/N6drwqGmGtrUJa+hP8ZyqjAHVams+0y9hqe0v4PNRDr+HQf3rqsaLAupdkbblOjzeD
	K6DW5lmYpRMf+Py6kr1nx7GA2eQJgRq0kMjA7KtWpOGiFnKBDsvlmOEre74G9vdyHzBrMoRxDR1
	DufJ5jAPvpR39+Jmtjde9l5EFgWdQlkkM127vxXefjD9p0/sT0n/nWQcDV4+fiRkH7lPD0CF5Lx
	FnWvBf8NA8DHHR4XHKJ4eTvJlIDWvv/UJ0s1pmEas1dduhkw7FcLyRGd40nwy0749cYLsATGOHM
	Ns=
X-Received: by 2002:a05:6a00:a01:b0:886:bb44:631f with SMTP id d2e1a72fcca58-897c6e1c80emr22352747b3a.10.1792154277782;
        Fri, 16 Oct 2026 05:37:57 -0700 (PDT)
Received: from [127.0.0.1] ([52.250.243.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57944b5dsm1028571b3a.36.2026.10.16.05.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 05:37:54 -0700 (PDT)
Message-Id: <pull.2263.git.1792154272296.gitgitgadget@gmail.com>
From: "Ian Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Oct 2026 12:37:52 +0000
Subject: [PATCH] sigchain: recover from concurrent double-pops of the same
 signal
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ian Hu <hu2008yinxiang@163.com>,
    ian4hu <hu2008yinxiang@163.com>

From: ian4hu <hu2008yinxiang@163.com>

sigchain_push()/sigchain_pop() update signals[sig].n and the handler
stack non-atomically.  When two copies of the same signal are delivered
in quick succession to different threads, both instances of the handler
run the usual "cleanup; sigchain_pop(sig); raise(sig)" pattern
concurrently, and both read the same s->n before either one decrements
it.  Each then installs s->old[s->n - 1], so a two-entry chain unwinds
both entries while the dispatcher keeps pointing at a handler that was
already popped: n ends at 0 while the effective disposition is still
old[1].

The surviving dispatcher then runs that popped handler, whose own
sigchain_pop() hits the "n < 1" guard and does nothing, and the raise()
at the end redelivers to the same stuck dispatcher forever.  The process
neither dies nor continues; every signal-handling thread spins at 100%
CPU and only SIGKILL recovers it.

This is reachable in practice: "git clone --depth 1" over ssh holds two
SIGTERM entries in the chain at the index-pack parking point (clone's
remove_junk_on_signal, then tempfile's remove_tempfiles_on_signal from
the first lockfile), and two SIGTERMs a fraction of a millisecond apart
land on two threads and corrupt the chain.

Rather than serializing the chain mutation, teach the "n < 1" guard in
sigchain_pop() to repair the damage.  Track how many pushes were ever
performed for the signal; when a pop finds the chain empty but the
chain bottom is known, reinstall s->old[0], the disposition that was
in place before the chain was built.  The stuck handler's raise() then
lands on that disposition -- typically SIG_DFL -- and the process dies
by it, exactly as a single delivery would have.

The repair is inert on every legitimate path to the guard: if the
signal was never pushed, nothing is installed; if the chain was fully
unwound by regular pops, s->old[0] is already installed and
reinstalling it changes nothing.  The push/pop fast path is untouched.

A fault-injected A/B run of the minimal reproducer, compiled from
identical sources with and without this change (the gap between the
"read n" and "decrement n" steps of pop widened so both racing pops
reliably read the same value; 300 interleaved pairs per arm) froze the
unpatched arm 121 times out of 300.  The patched arm never froze: all
300 runs reinstated the pre-chain disposition and died by it, and
20/20 single-delivery control runs never reached the repair code.

Signed-off-by: ian4hu <hu2008yinxiang@163.com>
---
    sigchain: recover from concurrent double-pops of the same signal
    
    During git clone --depth 1 over ssh (or any transport that parks the
    client with an in-flight packfile), two SIGTERMs delivered a fraction of
    a millisecond apart can corrupt the sigchain unwind: both fetch threads
    end up looping inside remove_junk_on_signal() at ~200% CPU, the process
    survives both signals, and further SIGTERMs have no effect (only SIGKILL
    recovers it).
    
    Mechanism (git 2.56.0):
    
     1. clone pushes two SIGTERM handlers: remove_junk_on_signal
        (builtin/clone.c:1134), then on the first tempfile activation (e.g.
        shallow.lock) remove_tempfiles_on_signal (tempfile.c:117):
        old[0]=SIG_DFL, old[1]=remove_junk_on_signal, n=2.
     2. Two deliveries that land on two threads run the top handler
        concurrently; both sigchain_pop() calls read the same s->n and both
        install s->old[s->n - 1]: the chain unwinds two levels for two
        deliveries, ending at n=0 while the dispatcher still points at
        old[1].
     3. The surviving dispatcher then chains to a handler that was already
        popped, whose own sigchain_pop() hits the n < 1 guard (a silent
        no-op), and whose raise() redelivers to the same stuck dispatcher
        forever.
    
    This patch takes the "repair after the fact" route instead of
    serializing the chain mutation: sigchain_pop() remembers how many pushes
    were ever performed for the signal, and when it finds the chain empty
    while the chain bottom is known, it reinstalls s->old[0] -- the
    disposition that was in place before the chain was built. The stuck
    handler's raise() then lands on that disposition (typically SIG_DFL) and
    the process dies by it, exactly as a single delivery would have.
    
    The repair is inert on every legitimate path to the n < 1 guard: if the
    signal was never pushed nothing is installed, and if the chain was fully
    unwound by regular pops, s->old[0] is already installed so reinstalling
    it changes nothing. The push/pop fast path is untouched -- no locking,
    no signal-mask manipulation, no Windows-specific code.
    
    Validation: a minimal reproducer (two threads parked in read(), the same
    push/pop chain, first handler entry doing real close()+unlink() work),
    compiled from identical sources with and without this change. With a
    fault injector widening the gap between the "read n" and "decrement n"
    steps of pop so both racing pops reliably read the same value (300
    interleaved pairs per arm), the unpatched arm froze 121/300 runs while
    the patched arm never froze: all 300 runs reinstated the pre-chain
    disposition and died by it. 20/20 single-delivery control runs never
    reached the repair code.
    
    An alternative fix that serializes sigchain_push()/sigchain_pop() with a
    per-signal spinlock exists as well; both eliminate the freeze. The lock
    prevents the corruption, this patch heals it; they are independent and
    either one suffices.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2263%2Fian4hu%2Fsigchain-recover-from-concurrent-pops-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2263/ian4hu/sigchain-recover-from-concurrent-pops-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2263

 sigchain.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sigchain.c b/sigchain.c
index 66123bdbab..f6da68ce4d 100644
--- a/sigchain.c
+++ b/sigchain.c
@@ -7,6 +7,7 @@ struct sigchain_signal {
 	sigchain_fun *old;
 	int n;
 	int alloc;
+	int pushed;
 };
 static struct sigchain_signal signals[SIGCHAIN_MAX_SIGNALS];
 
@@ -26,6 +27,7 @@ int sigchain_push(int sig, sigchain_fun f)
 	if (s->old[s->n] == SIG_ERR)
 		return -1;
 	s->n++;
+	s->pushed++;
 	return 0;
 }
 
@@ -33,8 +35,21 @@ int sigchain_pop(int sig)
 {
 	struct sigchain_signal *s = signals + sig;
 	check_signum(sig);
-	if (s->n < 1)
+	if (s->n < 1) {
+		/*
+		 * We are unwinding a chain that is already empty.  If we
+		 * got here from a signal handler, two concurrent pops of
+		 * the same signal both decremented "n", leaving the
+		 * dispatcher stuck on a handler that no longer has a
+		 * chain entry: its raise() would re-enter it forever.
+		 * Reinstall the disposition that was in place before the
+		 * chain was built so the raise() that follows lands on
+		 * that instead.
+		 */
+		if (s->pushed)
+			signal(sig, s->old[0]);
 		return 0;
+	}
 
 	if (signal(sig, s->old[s->n - 1]) == SIG_ERR)
 		return -1;

base-commit: f57c9a73884400380bddd172acc88b569834f909
-- 
gitgitgadget
