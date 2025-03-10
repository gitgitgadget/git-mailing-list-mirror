Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A747D1ADC7E
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 01:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741571469; cv=none; b=V9hKO8Oozp/DtrWTJTQqysMHBVXiTtRPsJCYUAmVfMmSRg+Cy1rD+4aCXwgr+8J8dYFRAHFvUapMuJYTb8Xtz/9GEqzQ+YcHE2uog+BIvLxQ2sF25UKWPjhZ7NlmoBcnddGN8cuFKLW4vkxSy5B5n1bsJE8wZhYh4fdNjID7Q0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741571469; c=relaxed/simple;
	bh=0+S9J44UxVFfEKHpKtZkXnPLs3Fv6reDHzvoBWYFpEE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Q1ya9ST4jQXvAujfZNMsfV/DdGKlI8xdA1Njn0uPV7DP90Rhq1GHYgs16W7KmHD4rI25a8cgnxatsSU/s5JM2zWAv2uw9OSU8DY77OWflPib5zDiWbWei352J/DpjQidCPFwzYx0Gdomq221kiWvTrr3yUPe7ul0EXJU4ND2e9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHlOfCnx; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHlOfCnx"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so7023494a12.1
        for <git@vger.kernel.org>; Sun, 09 Mar 2025 18:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741571465; x=1742176265; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgattcnDZ60ck5Q+t39+3mHuI61XIbQw69Ka9WRAf3o=;
        b=KHlOfCnxCSrFjmY8TWY401Nax0rXWVxve1QUzPypsvhdj2/t63cg2RAV8W0VO2a9aA
         NYz6vXWP3vPctzSbOI0nJZeGil5UgDrBPfDqKT0GZEbWd3nMPSq0FOSrbehDWS1qy2Lx
         9dus1O3hCXz+odCUkGNSlUHeJqCvmw2mDZT1PvCsLmifeb9ld+/yPe4onmGF7RDebSgY
         aHZ53MrcFMbh1Gx/usgwB+OFnjm5TgQmRulFsJBZvUxUJNRH/02j6Pw/lo0LA2ujw8EI
         6KFIxheloYysmANotYMs9ZqkzdFemj+a1Bm8nzcTaFR0/m6qTbKgoft1MLD9Af1GMKDq
         koUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741571465; x=1742176265;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgattcnDZ60ck5Q+t39+3mHuI61XIbQw69Ka9WRAf3o=;
        b=XaHy+xhLt4WKjd5oFqjOiztuspwcSPOBHBRDh8po5s48qLtbdbIJ2OofIg6V3ioaJI
         olrO6g3aHm528ZcyWzJGo8YfRxbo13/f3Z7XJ9Gv8i9R9WPuAehSkeYS/w4JviX5lvy7
         r1xn4gl/YX1y0FgY1n+dFBfg/zrdzHQVAReveJljy694VBoc7BODfZtSUkHz8vAj3+Nc
         g3Vr+5Mv1qROTNXBzZIcNUvXUsoL6BPJzL3Zu2iA9oLdI16F5Tjfv9G1AitUjrqJmef2
         FIg+GiuwYVvFmnocDEsGSwDchcoth8tdJ60mEFJkpgMLs9GViLEZtaxkaJjqHYOABpdq
         HjDA==
X-Gm-Message-State: AOJu0YymgnBE/CL9MaZRurK2VLuu+3lDYC0dMZooIhJqRlhI9eDZR/1E
	QhIuvXhNxp5Ax8wovueRthojhFzJAJPuy5/QjMiPy13paafZb7HLHZ263A==
X-Gm-Gg: ASbGnct51PUALRY1WXJzA0LmyFUZFvhYA5RS32i9AxvJRsdt73u7pzDiu01lbvozBIr
	oQ29MwI9HRingiotK1ykljovhX3dmjf1cQB2a/WtUfjWk/JvGXMcUZ2uLT7cse2Ieok7L6FY8ac
	Dorqy2X+MMc/Or6bEEfjMBEs7Ew+4dXrjB7GY/gkb1Kjf1YsOnQPHDzANcfzYpDOn/7wrod5T13
	m9Cf24/aKmcp1wvLL8oceZqPBoDFdTs5blD+IiBdpjUtCljesyvF71QcCQQ+DVycrBVZhvE0FO4
	MZK7cQ/HDY+ho7ctetlpFAUknh/R5+TFXiZ+pxtVNQ5zig==
X-Google-Smtp-Source: AGHT+IFK3ZYRckJ7R+xeYb1WQ+I/Q8h1EcPl2zTIGyqqrRBaqtrztHsZ205gvrpXlQRx3w9IUi1Ufw==
X-Received: by 2002:a05:6402:4303:b0:5e6:44d9:57f7 with SMTP id 4fb4d7f45d1cf-5e644d95a19mr5094864a12.26.1741571465366;
        Sun, 09 Mar 2025 18:51:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c768f207sm6069450a12.79.2025.03.09.18.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 18:51:04 -0700 (PDT)
Message-Id: <cf990b90b34e96428d6b20e0a1334139fe8d3af4.1741571455.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 10 Mar 2025 01:50:53 +0000
Subject: [PATCH 11/13] pack-objects: thread the path-based compression
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Adapting the implementation of ll_find_deltas(), create a threaded
version of the --path-walk compression step in 'git pack-objects'.

This involves adding a 'regions' member to the thread_params struct,
allowing each thread to own a section of paths. We can simplify the way
jobs are split because there is no value in extending the batch based on
name-hash the way sections of the object entry array are attempted to be
grouped. We re-use the 'list_size' and 'remaining' items for the purpose
of borrowing work in progress from other "victim" threads when a thread
has finished its batch of work more quickly.

Using the Git repository as a test repo, the p5313 performance test
shows that the resulting size of the repo is the same, but the threaded
implementation gives gains of varying degrees depending on the number of
objects being packed. (This was tested on a 16-core machine.)

Test                        HEAD~1      HEAD
---------------------------------------------------
5313.20: big pack             2.38      1.99 -16.4%
5313.21: big pack size       16.1M     16.0M  -0.2%
5313.24: repack             107.32     45.41 -57.7%
5313.25: repack size        213.3M    213.2M  -0.0%

(Test output is formatted to better fit in message.)

This ~60% reduction in 'git repack --path-walk' time is typical across
all repos I used for testing. What is interesting is to compare when the
overall time improves enough to outperform the --name-hash-version=1
case. These time improvements correlate with repositories with data
shapes that significantly improve their data size as well. The
--path-walk feature frequently takes longer than --name-hash-verison=2,
trading some extrac computation for some additional compression. The
natural place where this additional computation comes from is the two
compression passes that --path-walk takes, though the first pass is
naturally faster due to the path boundaries avoiding a number of delta
compression attempts.

For example, the microsoft/fluentui repo has significant size reduction
from --name-hash-version=1 to --name-hash-version=2 followed by further
improvements with --path-walk. The threaded computation makes
--path-walk more competitive in time compared to --name-hash-version=2,
though still ~31% more expensive in that metric.

Repack Method       Pack Size       Time
------------------------------------------
Hash v1                439.4M      87.24s
Hash v2                161.7M      21.51s
Path Walk (Before)     142.5M      81.29s
Path Walk (After)      142.5M      28.16s

Similar results hold for the Git repository:

Repack Method       Pack Size       Time
------------------------------------------
Hash v1                248.8M      30.44s
Hash v2                249.0M      30.15s
Path Walk (Before)     213.2M     142.50s
Path Walk (After)      213.3M      45.41s

...as well as the nodejs/node repository:

Repack Method       Pack Size       Time
------------------------------------------
Hash v1                739.9M      71.18s
Hash v2                764.6M      67.82s
Path Walk (Before)     698.1M     208.10s
Path Walk (After)      698.0M      75.10s

Finally, the Linux kernel repository is a good test for this repacking
time change, even though the space savings is more subtle:

Repack Method       Pack Size       Time
------------------------------------------
Hash v1                  2.5G     554.41s
Hash v2                  2.5G     549.62s
Path Walk (before)       2.2G    1562.36s
Path Walk (before)       2.2G     559.00s

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c | 163 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 161 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c5a3129c88e..e8b1b057ec3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2964,6 +2964,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 struct thread_params {
 	pthread_t thread;
 	struct object_entry **list;
+	struct packing_region *regions;
 	unsigned list_size;
 	unsigned remaining;
 	int window;
@@ -3278,6 +3279,164 @@ static void find_deltas_by_region(struct object_entry *list,
 	stop_progress(&progress_state);
 }
 
+static void *threaded_find_deltas_by_path(void *arg)
+{
+	struct thread_params *me = arg;
+
+	progress_lock();
+	while (me->remaining) {
+		while (me->remaining) {
+			progress_unlock();
+			find_deltas_for_region(to_pack.objects,
+					       me->regions,
+					       me->processed);
+			progress_lock();
+			me->remaining--;
+			me->regions++;
+		}
+
+		me->working = 0;
+		pthread_cond_signal(&progress_cond);
+		progress_unlock();
+
+		/*
+		 * We must not set ->data_ready before we wait on the
+		 * condition because the main thread may have set it to 1
+		 * before we get here. In order to be sure that new
+		 * work is available if we see 1 in ->data_ready, it
+		 * was initialized to 0 before this thread was spawned
+		 * and we reset it to 0 right away.
+		 */
+		pthread_mutex_lock(&me->mutex);
+		while (!me->data_ready)
+			pthread_cond_wait(&me->cond, &me->mutex);
+		me->data_ready = 0;
+		pthread_mutex_unlock(&me->mutex);
+
+		progress_lock();
+	}
+	progress_unlock();
+	/* leave ->working 1 so that this doesn't get more work assigned */
+	return NULL;
+}
+
+static void ll_find_deltas_by_region(struct object_entry *list,
+				     struct packing_region *regions,
+				     uint32_t start, uint32_t nr)
+{
+	struct thread_params *p;
+	int i, ret, active_threads = 0;
+	unsigned int processed = 0;
+	uint32_t progress_nr;
+	init_threaded_search();
+
+	if (!nr)
+		return;
+
+	progress_nr =  regions[nr - 1].start + regions[nr - 1].nr;
+	if (delta_search_threads <= 1) {
+		find_deltas_by_region(list, regions, start, nr);
+		cleanup_threaded_search();
+		return;
+	}
+
+	if (progress > pack_to_stdout)
+		fprintf_ln(stderr, _("Path-based delta compression using up to %d threads"),
+			   delta_search_threads);
+	CALLOC_ARRAY(p, delta_search_threads);
+
+	if (progress)
+		progress_state = start_progress(the_repository,
+						_("Compressing objects by path"),
+						progress_nr);
+	/* Partition the work amongst work threads. */
+	for (i = 0; i < delta_search_threads; i++) {
+		unsigned sub_size = nr / (delta_search_threads - i);
+
+		p[i].window = window;
+		p[i].depth = depth;
+		p[i].processed = &processed;
+		p[i].working = 1;
+		p[i].data_ready = 0;
+
+		p[i].regions = regions;
+		p[i].list_size = sub_size;
+		p[i].remaining = sub_size;
+
+		regions += sub_size;
+		nr -= sub_size;
+	}
+
+	/* Start work threads. */
+	for (i = 0; i < delta_search_threads; i++) {
+		if (!p[i].list_size)
+			continue;
+		pthread_mutex_init(&p[i].mutex, NULL);
+		pthread_cond_init(&p[i].cond, NULL);
+		ret = pthread_create(&p[i].thread, NULL,
+				     threaded_find_deltas_by_path, &p[i]);
+		if (ret)
+			die(_("unable to create thread: %s"), strerror(ret));
+		active_threads++;
+	}
+
+	/*
+	 * Now let's wait for work completion.  Each time a thread is done
+	 * with its work, we steal half of the remaining work from the
+	 * thread with the largest number of unprocessed objects and give
+	 * it to that newly idle thread.  This ensure good load balancing
+	 * until the remaining object list segments are simply too short
+	 * to be worth splitting anymore.
+	 */
+	while (active_threads) {
+		struct thread_params *target = NULL;
+		struct thread_params *victim = NULL;
+		unsigned sub_size = 0;
+
+		progress_lock();
+		for (;;) {
+			for (i = 0; !target && i < delta_search_threads; i++)
+				if (!p[i].working)
+					target = &p[i];
+			if (target)
+				break;
+			pthread_cond_wait(&progress_cond, &progress_mutex);
+		}
+
+		for (i = 0; i < delta_search_threads; i++)
+			if (p[i].remaining > 2*window &&
+			    (!victim || victim->remaining < p[i].remaining))
+				victim = &p[i];
+		if (victim) {
+			sub_size = victim->remaining / 2;
+			target->regions = victim->regions + victim->remaining - sub_size;
+			victim->list_size -= sub_size;
+			victim->remaining -= sub_size;
+		}
+		target->list_size = sub_size;
+		target->remaining = sub_size;
+		target->working = 1;
+		progress_unlock();
+
+		pthread_mutex_lock(&target->mutex);
+		target->data_ready = 1;
+		pthread_cond_signal(&target->cond);
+		pthread_mutex_unlock(&target->mutex);
+
+		if (!sub_size) {
+			pthread_join(target->thread, NULL);
+			pthread_cond_destroy(&target->cond);
+			pthread_mutex_destroy(&target->mutex);
+			active_threads--;
+		}
+	}
+	cleanup_threaded_search();
+	free(p);
+
+	display_progress(progress_state, progress_nr);
+	stop_progress(&progress_state);
+}
+
 static void prepare_pack(int window, int depth)
 {
 	struct object_entry **delta_list;
@@ -3303,8 +3462,8 @@ static void prepare_pack(int window, int depth)
 		return;
 
 	if (path_walk)
-		find_deltas_by_region(to_pack.objects, to_pack.regions,
-				      0, to_pack.nr_regions);
+		ll_find_deltas_by_region(to_pack.objects, to_pack.regions,
+					 0, to_pack.nr_regions);
 
 	ALLOC_ARRAY(delta_list, to_pack.nr_objects);
 	nr_deltas = n = 0;
-- 
gitgitgadget

