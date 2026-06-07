Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D5B1A262D
	for <git@vger.kernel.org>; Sun,  7 Jun 2026 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780817452; cv=none; b=rbvXGd+u2C1B4tDMFLNWu6PShN5gidZNpCjsIXeSSXkVqA4rCRyQUC6ycrVDX7OLmS6UK85dmSm0CLZKot5V7gqf0gFqfY9m5+Fszk0gePNkJeFJymRjtnl5SVqCwfUPzte4cwcqRKSiVlMYZuB3OGkbf1O7LrNXAu0SJXkaeo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780817452; c=relaxed/simple;
	bh=oKvAsSmOB3P8OBNYoaIlT0ni1hpii/mnEUcF9S4yzQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HuL9idTk6NkL6GUJbmEmgBzdsZqwKvksalnny+mZjKlCHsKaGEIEn8/acE/c6TcXLgryXuPu0NbhmCyQabkShDTLoTz5SQfD/jHjeeeFOht2MW4iC1O6iiEl2OyTOhRzNWb1JI7bg4QIj2mmKh/6TsJh9QDDaDglIXMt2sjX/d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=dV8UbIAo; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="dV8UbIAo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780817441; x=1781422241; i=l.s.r@web.de;
	bh=8WLGoB9O0TZdewtRYScJllAsKHVnRIqMS8ct7qtG2yw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dV8UbIAodmEChaEeDeIEjwfgCXMGD6rwD/V4B4Mlr2ZCdjFzo3ugyOq4r0Z/1nFI
	 m8bmmK3VMVLqDDG5467BR5kNy46U/bA+vEs8D+chwhSmw9F5xVPC8bp6v5XtJT9fJ
	 Nnc0a718QIbZQEE9eKiwGG0DCuA9laui4yr2su+T2xWDVl7bY8smpVP5D+L47ZD8o
	 JCO/L7w3+Xw8j/UyHmXuZ8O8OKzXkiHzjYqEoWSpXg0KUPwicQzJlaVbwYP+T0jY8
	 kBxhF2+SNhvVZBXlbgUwmBlvPJve+JmIskI5U/a036GGvXtHkZfZozmeK76qvKyCK
	 zRQsj4Fi2oVESZh7AA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mhnvw-1x9qVN2oO8-00eT5T; Sun, 07
 Jun 2026 09:30:41 +0200
Message-ID: <fe20bde6-9e86-4162-9bbd-af4d058e499e@web.de>
Date: Sun, 7 Jun 2026 09:30:41 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] prio-queue: fold lazy_queue into prio_queue for
 automatic get+put fusion
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>
References: <pull.2140.git.1780757885582.gitgitgadget@gmail.com>
 <pull.2140.v2.git.1780772477.gitgitgadget@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <pull.2140.v2.git.1780772477.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/+NrY0DqBGpHoAZbpUTHafNU9wpTno/loiZMClhOzlXJSrn479e
 NDizMhkRWxzMYXCJCIBf89Xnasit8yftclaqcPIZa7eg8q3cLkwHZOjoAWTxYI+ZVdAd/nY
 jJDS3UHDgS47ZkRxqB9V+LKSbeT4ii87oUJTe32kt6H4+kmZZxUJbaWdZ5kX5XNfcXToWw3
 YfrBJDCE9u0wfHH7E4S2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hTrGQfBES/8=;yd55qUtEboFw+nUv+mbrmAMxMQh
 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
 wYX0EKR0g=

On 6/6/26 9:01 PM, Kristofer Karlsson via GitGitGadget wrote:
> Rene's lazy_queue wrapper in describe.c was a clever optimization -- by
> deferring the get, a following put becomes a simple replace, avoiding a =
full
> remove-rebalance-insert cycle.
>=20
> It turns out this pattern is so common in git's traversal code that it m=
akes
> sense to fold it into prio_queue itself. Gets and puts are interleaved i=
n
> virtually every commit walk, so the fusion is essentially always a win.
>=20
> This is mostly a code simplification -- three callers had independently
> reimplemented the same optimization, and they all collapse to plain get+=
put
> now. The 3-6% speedup on traversal-heavy workloads is a nice bonus.
>=20
> More details and benchmark numbers in the commit message. Benchmarks wer=
e
> run on next which includes kk/commit-reach-optim -- those results repres=
ent
> the more realistic end state.
>=20
> Related to but independent of the cascade sift-down work in
> kk/prio-queue-cascade-sift -- the two can land in either order.
>=20
> Changes since v1:
>=20
>  * Added a second commit that renames .nr to .nr_internal so that direct
>    access from outside prio-queue.c is a compile error. Verified that af=
ter
>    the rename, only prio-queue.c references nr_internal.
>=20
>  * Added prio_queue_for_each() macro for callers that need to walk all
>    elements (describe.c, show-branch.c, commit-reach.c, revision.c,
>    negotiator/skipping.c).
>=20
>  * Converted remaining .nr loop conditions to use
>    prio_queue_get()/prio_queue_peek() as the loop condition, or
>    prio_queue_size() where get/peek isn't suitable.
>=20
>  * Fixed several callers missed in v1 (object-name.c, fetch-pack.c,
>    path-walk.c, pack-bitmap-write.c, negotiator/default.c,
>    negotiator/skipping.c, revision.c, builtin/last-modified.c).
>=20
> Kristofer Karlsson (2):
>   prio-queue: fold lazy_queue into prio_queue for automatic get+put
>     fusion
>   prio-queue: rename .nr to .nr_internal to prevent direct access
>=20
>  builtin/describe.c          | 70 ++++++++-------------------------
>  builtin/last-modified.c     |  7 ++--
>  builtin/show-branch.c       | 24 +++++-------
>  commit-reach.c              | 24 ++++++------
>  commit.c                    | 11 +-----
>  fetch-pack.c                |  4 +-
>  negotiator/default.c        |  4 +-
>  negotiator/skipping.c       | 12 +++---
>  object-name.c               |  2 +-
>  pack-bitmap-write.c         | 10 ++---
>  path-walk.c                 |  8 ++--
>  prio-queue.c                | 77 ++++++++++++++++++++-----------------
>  prio-queue.h                | 19 +++++----
>  revision.c                  | 16 ++++----
>  t/unit-tests/u-prio-queue.c |  6 +--
>  walker.c                    |  4 +-
>  16 files changed, 129 insertions(+), 169 deletions(-)
>=20
>=20
> base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2140%2=
Fspkrka%2Flazy-prio-queue-pr-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2140/spkr=
ka/lazy-prio-queue-pr-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/2140
>=20
> Range-diff vs v1:
>=20
>  1:  29af24445e =3D 1:  29af24445e prio-queue: fold lazy_queue into prio=
_queue for automatic get+put fusion
>  -:  ---------- > 2:  bb8b0f78f1 prio-queue: rename .nr to .nr_internal =
to prevent direct access
>=20

My earlier attempt in <90270818-c52b-4611-8da2-6cee20628fc2@web.de>
copied the last item to the root and decreased .nr, to allow callers to
scan items and get their count directly.

Checking emptiness by doing the existing calls of prio_queue_peek() and
prio_queue_get() a bit earlier and scanning using a foreach macro are
fine as well and arguably cleaner, at the low cost of having to change
all the callers.

The result is faster than my attempt, but still slower than the current
code in the describe benchmark from 30598ccc4d (describe: use oidset in
finish_depth_computation(), 2025-09-02):

Benchmark 1: ./git_main describe $(git rev-list v2.41.0..v2.47.0)
  Time (mean =C2=B1 =CF=83):     601.7 ms =C2=B1   1.9 ms    [User: 538.6 =
ms, System: 47.3 ms]
  Range (min =E2=80=A6 max):   599.3 ms =E2=80=A6 606.5 ms    10 runs

Benchmark 2: ./git_auto_replace describe $(git rev-list v2.41.0..v2.47.0)
  Time (mean =C2=B1 =CF=83):     618.0 ms =C2=B1   1.1 ms    [User: 554.5 =
ms, System: 47.6 ms]
  Range (min =E2=80=A6 max):   616.7 ms =E2=80=A6 620.2 ms    10 runs

Benchmark 3: ./git_fold describe $(git rev-list v2.41.0..v2.47.0)
  Time (mean =C2=B1 =CF=83):     609.9 ms =C2=B1   0.8 ms    [User: 546.7 =
ms, System: 47.4 ms]
  Range (min =E2=80=A6 max):   608.8 ms =E2=80=A6 611.2 ms    10 runs

Benchmark 4: ./git describe $(git rev-list v2.41.0..v2.47.0)
  Time (mean =C2=B1 =CF=83):     606.1 ms =C2=B1   1.2 ms    [User: 543.7 =
ms, System: 46.7 ms]
  Range (min =E2=80=A6 max):   604.7 ms =E2=80=A6 609.1 ms    10 runs

Summary
  ./git_main describe $(git rev-list v2.41.0..v2.47.0) ran
    1.01 =C2=B1 0.00 times faster than ./git describe $(git rev-list v2.41=
.0..v2.47.0)
    1.01 =C2=B1 0.00 times faster than ./git_fold describe $(git rev-list =
v2.41.0..v2.47.0)
    1.03 =C2=B1 0.00 times faster than ./git_auto_replace describe $(git r=
ev-list v2.41.0..v2.47.0)

git_auto_replace: <90270818-c52b-4611-8da2-6cee20628fc2@web.de> and
  revert of 08bb69d70f (describe: use prio_queue_replace(), 2025-08-03)
git_fold: this series
git: this series and the patch below

My attempt leaves performance on the table by using a bool.  Using
an unsigned for the flag is measurably faster -- but still slower
than your series here.

Calling flush_get() later, when we know that we have items and a
compare function, is cleaner, as we never need it in LIFO mode, and
is also slightly faster (patch below).

Still there's this 1% performance gap to the current code that I
don't understand.  Do you see it as well?

Ren=C3=A9

=2D--
 prio-queue.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/prio-queue.c b/prio-queue.c
index d11ca6ac36..45709187d3 100644
=2D-- a/prio-queue.c
+++ b/prio-queue.c
@@ -100,24 +100,23 @@ static void sift_down_root(struct prio_queue *queue)
=20
 void *prio_queue_get(struct prio_queue *queue)
 {
-	flush_get(queue);
-
 	if (!queue->nr_internal)
 		return NULL;
 	if (!queue->compare)
 		return queue->array[--queue->nr_internal].data; /* LIFO */
=20
+	flush_get(queue);
 	queue->get_pending =3D 1;
 	return queue->array[0].data;
 }
=20
 void *prio_queue_peek(struct prio_queue *queue)
 {
-	flush_get(queue);
-
 	if (!queue->nr_internal)
 		return NULL;
 	if (!queue->compare)
 		return queue->array[queue->nr_internal - 1].data;
+
+	flush_get(queue);
 	return queue->array[0].data;
 }

