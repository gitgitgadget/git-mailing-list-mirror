Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619A5261364
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829788; cv=none; b=LObNwoKcUVScbfPE4TFhEhNRCfI67P75T7nVK55YhwQVaj1LBXyB16odQHgOf1mVhAvxiAiUXJs4FBKeVjrHcKhR7rck/7LT2/YSpDEGju51QjXB2coxCEsvEBbsIqyXxyJg/CdDvaByfxbDMTj8rWGc3lGytkgGL6WuoCwGn+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829788; c=relaxed/simple;
	bh=AjyPOueIcMFY8CsJz47WAKZGZUkVXWMPpJQCzkBn6yE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=feeEUx4oAJqyKNcORfEBTU8Dt1wT1Yhz8JEirTr2gUi0rvY9uA+AKAmax0TgT5Hv2hhn5JzlcNiLoUWQUaaF4b1xpKiwHykoVzhAxJdvF2L0vBmArsHgvvltPeCiqHYyJ22JG7TPNRNXkJv8HSGmT9W8PprcHfTfHppq0ISHZ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3PQxYxl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3PQxYxl"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfe574976so25945695e9.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 08:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742829783; x=1743434583; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mvp6XFi0TtiqdOiVWMf/O+1axfAUl1/sVST+ohsg4uY=;
        b=Q3PQxYxlBuGp9gE8ny/iRRcJ0z2WxpWG9ono0RZcaisHzdtYHJ4ED4KHcR8Rw3rtHh
         Tq5U6js2F7OluU/yFRXbcyE4a/NvF27g6gCFfxfW2Zb8nKanI2PL7zeDsCr2sAO5VpSn
         Izqxikm+G+LaFIDjupHmeIuJlRk5+iWAddXYYh8/xGNLb1BcmHqf0lz06T0kKAnhbQmT
         DRT+r610z2C2XoU90Xu4bGymARFPV/B6Ow6Ylkxk4g7WMwUF5/ZvdE9s1RpPzoiPpGxc
         E2MudGeEyz9rGBALch+cKf0OfXd6mNkKcVdOFFWxT4NGJ6e8zrM4hQqfgZoe55qelG+0
         v/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742829783; x=1743434583;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mvp6XFi0TtiqdOiVWMf/O+1axfAUl1/sVST+ohsg4uY=;
        b=CKZ4hNeMgCUX7+86exIbLWuOyBI75jFpPNdLC73eaxxi6r6Jfeif4FQ/Orvgr79zPW
         qltoeukhkDrlB5i3rkjH0kHJoRCL5hqP1wqM+8W2ryNCGzHA0iArIRREug9S6cxNx4cW
         Z0cnxn+l/UGsZF1gV6F/Z6n633Egl2o6zOYbZfNnHSMYrgR1ald8mXHKrPsR2HUlgku+
         I8kwUSUX9jjuFXrR6qiGUgf7/P4wReZdVBLoT2n+/d8HzyLqaTNgphHv46PqjvM21paE
         tbxCpKOI5XTxTciLNz8tIwzu7rhU/NRTRmT2otlkRGmGMZIQxpjy6pPpOEAROexZhDD7
         kiqw==
X-Gm-Message-State: AOJu0Yygfdy/0Z8hf4V78mxu7op7HUAFMirPcHtzAhRdanutKxxxWsqg
	rj7MMs51CiKAT1E3O6kkICinKKOpyqQ2vqg0ZWzzfX7iMRHT/746ZWOWEg==
X-Gm-Gg: ASbGncutBGmtF+gh/368hYy9xB5CmkKZe2yTxUbQrdmk7rikOG138s/6hYzwjnltRv/
	t2HXlKfJ5tiGENLXwPgipFZ0EQ+7EF7MXXtQE6szG+Jyi49WaqnG/afm5d/xTLdxCt1nX7Y112a
	dNTkm4EDffbvdVNV2hfVFiMlLoxGZfyFrGR+2zs64BC/dx+l2XqPc9q3hpZkQrmn40g9mkJXkG2
	vwc08q5vvzgUl49v9TkFt+58vhQabtIAkXOlArlfxQTf/5A8XhWZU+gJvGQEVQ6HfdN2y0oLQfa
	RqLCCNMMQZfQ7OUV1MAu0Y2ktXDAZdYnZQLq0pkRQyK9RA==
X-Google-Smtp-Source: AGHT+IE/4F8zL8yLv1zdhoAjFxpcIdHij7q+6SVvBqXy8gg5DJnadpMs4BRwaOU+SU4LpLxmrezUxA==
X-Received: by 2002:a05:600c:3c9a:b0:43c:f4b3:b094 with SMTP id 5b1f17b1804b1-43d509e189bmr122220145e9.6.1742829782905;
        Mon, 24 Mar 2025 08:23:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9ef098sm11016079f8f.84.2025.03.24.08.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:23:02 -0700 (PDT)
Message-Id: <ae73d26319ac5db338507988eb23f1ecaac67671.1742829770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
	<pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 24 Mar 2025 15:22:47 +0000
Subject: [PATCH v2 11/13] pack-objects: thread the path-based compression
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
index d4e05ca4434..2a6246c1e78 100644
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
@@ -3281,6 +3282,164 @@ static void find_deltas_by_region(struct object_entry *list,
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
@@ -3306,8 +3465,8 @@ static void prepare_pack(int window, int depth)
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

