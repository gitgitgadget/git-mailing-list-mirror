Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFB71E0496
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396744; cv=none; b=VRkJnLsCGShVoiG3G14vk8AGvg2ksOL2Up0M+xO/9sMRTVtof+aiQuvxU0wHcZedlEnl0kKHm4YlS1bp8CedTM/UpbXBoVIs4+KD4nXFj6b9QY9IWtDytZoQGsC8xzvdpVxHwMvKp7QjZPtvOqOsjdWujf9H65fYeOHdVgdZUMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396744; c=relaxed/simple;
	bh=W3dIN+fYcVQrtENdk9zQ84ZavEZjc7N3Ex8z/Q/+j1k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jnCqqoJjkOnLP6CwisHTVFsMtdiWWe/vQ0lE98EeFTn7u3mM2JDFcRmeEqIJHMnUjyVB7g/xpLpeRv4VQFRSnvlNzDTn11TmrjZ3Ig9f0d0UDX1VJ3G1GOKM/R8BEKDFAMm8WXgYqqPtFOSD3HalJHHOwCvunaBvQk4BJ5O0k9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTWe/L6l; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTWe/L6l"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fac47f0b1aso67538221fa.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 07:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728396740; x=1729001540; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFB03ca0qGa+EdRB8Si2Om62y23+GkAn5U7iAy/2ab8=;
        b=PTWe/L6lwjMc1MINP59WQUsAgsvhpqebmdVtGynthIpX9d0dKaZmfiF8ZVJ7QypQV4
         u6LDqBSq5lyp4cy2IiJ+6fLm7dEpPdg8sT3tDSi3TfRgibhyUpyIgzRHVXooqkSebrtQ
         ncgxJcxxkV/OLqBJtc+JIUys/0IYDD21xtTBAqXaille7AzWTdM7dhPxDBLy4kPOW30B
         DaJ+z+9RCzJwHbqtdaB94G/iA4HWcdjDRIF+zzimKDG6V2LBV8arj2Ny2ujwfiDEd5zP
         t83rra27dbJkRsUVX8x+XwSbTyL+ga3GaySXlgpCYyV8E1WdU87HsWuPS4bVtJ3dCp41
         dIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396740; x=1729001540;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFB03ca0qGa+EdRB8Si2Om62y23+GkAn5U7iAy/2ab8=;
        b=h+2pHllKVXFcPmq+AGABWaWMfRCLfW/kJsC6JmScu52Rie1XVz4sUAqjnVlv0ts57/
         TBVp66BNvRKJAibS8ZWJtq8301v+pkaCDejqcRBJjn54hbK48NkMEldgpXjAfaMnGp7T
         VdVrDOgCaz796sbffBDZlE2j+Uz0eLzYE0HjO28bUWtFM9maX/9BoLZFZOT3VdnN2WXb
         Db3wO+Kb6hP5p7/icYDViK+oGhyVR8Bo7Puml4ApzoGIdG8n6kweG6yHATexzye+y/CD
         CX54LNvsbm/RRuR39pShwJVfnVp+2Ypo+LQmy64cpUvGYjwVk1DpeL5AbXsPr0YHQc0h
         cZEw==
X-Gm-Message-State: AOJu0YyPwkwFBcaXIKYda+6M9NyntxM0/ZLX3T1i7GxvSr8RSynvZL8o
	O4KCUl5SQN3LqxlOop5G+Xh/DcOnf89yxj4dZhVhWZZgAVSV+YTjXVDIsQ==
X-Google-Smtp-Source: AGHT+IHvgNitFi9N0Tu740M55DzYVW3MnthHAl9EbCq5bUkJHgtQ88dQfXnJzPivZifzxn4KIiMniQ==
X-Received: by 2002:a2e:b8c4:0:b0:2fa:cf73:a2fb with SMTP id 38308e7fff4ca-2faf3c011d0mr67789221fa.2.1728396739874;
        Tue, 08 Oct 2024 07:12:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eb34csm4342360a12.59.2024.10.08.07.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:12:19 -0700 (PDT)
Message-Id: <264affbf058e01450722ed68ca45e001c67cf190.1728396724.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 14:12:03 +0000
Subject: [PATCH 17/17] pack-objects: thread the path-based compression
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
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

Test                                      HEAD~1    HEAD
---------------------------------------------------------------
5313.2: thin pack                           0.01    0.01  +0.0%
5313.4: thin pack with --path-walk          0.01    0.01  +0.0%
5313.6: big pack                            2.54    2.60  +2.4%
5313.8: big pack with --path-walk           4.70    3.09 -34.3%
5313.10: repack                            28.75   28.55  -0.7%
5313.12: repack with --path-walk          108.55   46.14 -57.5%

On the microsoft/fluentui repo, where the --path-walk feature has been
shown to be more effective in space savings, we get these results:

Test                                     HEAD~1    HEAD
----------------------------------------------------------------
5313.2: thin pack                         0.39     0.40  +2.6%
5313.4: thin pack with --path-walk        0.08     0.07 -12.5%
5313.6: big pack                          4.15     4.15  +0.0%
5313.8: big pack with --path-walk         6.41     3.21 -49.9%
5313.10: repack                          90.69    90.83  +0.2%
5313.12: repack with --path-walk        108.23    49.09 -54.6%

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c | 162 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 160 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5c413ac07e6..443ce17063a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2935,6 +2935,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 struct thread_params {
 	pthread_t thread;
 	struct object_entry **list;
+	struct packing_region *regions;
 	unsigned list_size;
 	unsigned remaining;
 	int window;
@@ -3248,6 +3249,163 @@ static void find_deltas_by_region(struct object_entry *list,
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
+		progress_state = start_progress(_("Compressing objects by path"),
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
@@ -3273,8 +3431,8 @@ static void prepare_pack(int window, int depth)
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
