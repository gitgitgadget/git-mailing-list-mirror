Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3281FAA
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419159; cv=none; b=RCMPw4fb8yUF5i86H57wsdk9xXEAfrzp2LqIW/8A0L/7s+mabBnecClaTP839bv+zr97m8BHVuHrUO6Hcasroeb5AOH4ZMOcOnx8oQ1OTEL3/oi8/rXr2GWmwS9TvktSSRmS+BUfE6JR0UrXvpAt1jRtm6AdeXyU/aD7bYot7Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419159; c=relaxed/simple;
	bh=OcMe92oijd4gUoyyfsnCqe92jxpMcFr+6XO1BNBVI4I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UHrJBLWkaSKaoC0Lzxh7aeE+GzuGEkQA0AXWsRZjV+CBJzIZxblcWOlbqNr17O5GAXez1rrAy+bb3YKrG0NjEVKvdyN5L06xXqTLwBSi1yaxilVYUk3qQAzdvdS0rXKCDtPHht4jce02naQh7DLcJkMGnjisfbtwF/UMybj/TvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ox6KQJLO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox6KQJLO"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so19485675e9.1
        for <git@vger.kernel.org>; Fri, 16 May 2025 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747419155; x=1748023955; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cikyuY8O6ttmQVDs99zNH0qAI/ApSu2tYqjXcVNoctg=;
        b=Ox6KQJLOQ/BrpYotEhQoMOARBxJ0QN6UU51vCuxxQHb0dOLtfS7EnikN3upJy6iLt0
         g8RsXRgFV52C8Io1BK7tlZEnZE7j5UuVW+HRIykYxkIqWDSvPhgB5EKH0nsd+0ans7Dz
         /gyfTvSbjzOAJuFpYbbG+oyEcsN9Apf8Gp3TGtSSz39CfmkG2vRBq4pu/uoVfBXhd2cm
         7nSgDQ+GBPgIlSodtCO1coH0zJO66zHPECetgG12PHUibdGU6SZC3QnUgoyvjnPFT75M
         XVGLnRURoowLZWxaF9VYRA60ph8Biq0E+ABBZHGd6e6dmfo4GmPP575k8e229+bKyOmy
         7GyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747419155; x=1748023955;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cikyuY8O6ttmQVDs99zNH0qAI/ApSu2tYqjXcVNoctg=;
        b=WBkqnTYalhW/z+NoW5LhCuFRrqC7uI63IxVPsLFHIsNYCiHavxNSXnwztP7Tkdoxex
         6qPf1+1fIIlhmFwnYiJ+/xE1GdITshx8cUX93Hbcaas8MGaoswZ7pkdhagY9Q4AFB6ot
         /jwdLcMesWyqPaHZzzeBILQ+iIgG4eT7LemlRbBBjkQPM+LQeQ3bZZhbQB0+fh1tPwhr
         RV/ofCKJbvV9xeAyd09llP/eLs4LSLgeqxqFGIlOnfYMA6g/phGv2Hd1D3K8vnRZxqYB
         HuOeIh25OWllpPmQ7D8kgB0euuLpGtdhEn4O7WQgvxlmHYbMjPtz2QpBQdjkLVifhqXb
         SOJQ==
X-Gm-Message-State: AOJu0YyHBhCyJhTRgt+GM+IZ9gg3NEJ/2582J7vY1Cpsb75ZPMkj9ScK
	btVRd9GghKebjxqal51wZPPdN1ly7/SNtd5+S+KyWu0Vw5JQuXKmPXTnYgZcBA==
X-Gm-Gg: ASbGncveRnZJpK7lCowEe7JPYRdRg2VpR4+h4+0lcoZLDMlqBGGw93NFrnr39qhsXLz
	1Hgb2Yx1jj52mpUIMeCXdkn8k5hfseSMaiLQed84ERwHahfg8l1qy8tcviR5n39Uv0306Rg9sQ4
	r54NsvIvkoDHE2kD/VBHQpTpTbwlmeMgGvhow1j6NzYCUgHIZbRDZWGl720Cc5xOsO+65UBdd2M
	McbtgCWz4um41pUUplpWYxa0mRAR6yX3kV4RpZtntdvh5ioIrwcTWfOMGBy1WAd8II1sRj2tjYF
	j83FVDKRvnrcdJZ7TsE8GU8kc5wzi1Aj2tXkYScHc4nJ6g9uVkmoTD+53m5W3Fc=
X-Google-Smtp-Source: AGHT+IHz9aVwzFkJaey/lpd/OHjnuqe52Bq/N1nhYgQ1eKIAI2CnEwNy3bMyRdI9Qa2z6AKYCMsHag==
X-Received: by 2002:a05:600c:6285:b0:43d:683:8caa with SMTP id 5b1f17b1804b1-442fd63c726mr56324785e9.15.1747419154979;
        Fri, 16 May 2025 11:12:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd51531dsm41251945e9.20.2025.05.16.11.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:12:33 -0700 (PDT)
Message-Id: <623913f284eafae7dfb8b87f1183ef141cead62a.1747419124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
References: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
	<pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 May 2025 18:12:01 +0000
Subject: [PATCH v3 11/13] pack-objects: thread the path-based compression
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
--path-walk feature frequently takes longer than --name-hash-version=2,
trading some extra computation for some additional compression. The
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
 builtin/pack-objects.c | 166 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 164 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c7bf3fbc0267..df3cca0a668a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2965,6 +2965,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 struct thread_params {
 	pthread_t thread;
 	struct object_entry **list;
+	struct packing_region *regions;
 	unsigned list_size;
 	unsigned remaining;
 	int window;
@@ -3282,6 +3283,167 @@ static void find_deltas_by_region(struct object_entry *list,
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
+		fprintf_ln(stderr,
+			   Q_("Path-based delta compression using up to %d thread",
+			      "Path-based delta compression using up to %d threads",
+			      delta_search_threads),
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
@@ -3307,8 +3469,8 @@ static void prepare_pack(int window, int depth)
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

