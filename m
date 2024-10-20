Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E98194AEF
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729431835; cv=none; b=GZCt4j7D203/ywbsAQZzaimyE3iQcJ59M4qt0QbSy/lSxtojWN4XrDuv36ZbT5patWqMu6hCk3yL0UMuES5zapJQqlJrAE0ook7+RAdBrLsEEWw8xpvGWAmksvuKbqg8uq3AMkDpXe9bANBitK6l6UoRLBOhXflK6jzQtOozeKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729431835; c=relaxed/simple;
	bh=W3dIN+fYcVQrtENdk9zQ84ZavEZjc7N3Ex8z/Q/+j1k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mDKxhVb8f0paNw3U3HIr8hxLRbqWFzp2OepTHrUrG9yxBlHITZA2ey0WJrwVKuwZv0FSabdOWKg2ZjO7dWbrCsZHrYF2iiv6BiUqZ8wEKCCSbtAZECD1+L591FDvCyHYM6XaTR3PSIWPLHC6QpcWcXzCeqhfYSd7e4bTXAsQpRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnYfAUK0; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnYfAUK0"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso5613475a12.1
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 06:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729431831; x=1730036631; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFB03ca0qGa+EdRB8Si2Om62y23+GkAn5U7iAy/2ab8=;
        b=XnYfAUK0rkbstCNu4nknFDGLauMS/DkIsbxYVY6a78yO/BF8l3gWTrLf1HBnfAcQvc
         43Qp5yBvFtvKkZ2D6P7uaLmxkVmj8nI9DBFAvk8dPRWsdp79aZXgO5c637NcoXrLiJCy
         4H6VvUZ6V55bnDAEkxOOywzoTn8PFuanKzxFSZCFGpcClCxfP7RNirUlZNDL2tezf4jn
         d+lxrx+vaMJn7XKOzvNn1V3QcFxu3vlNkgy2Q/turDzrpT8y9jMYaZQV1CZ+tI3AOkIE
         tw74bF7nhVHsVIeueS4q4zT3tzIJpT31Iyy2uNpAxKl61yIqsnH0Hgeq+A4R8xd+sGfv
         URHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729431831; x=1730036631;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFB03ca0qGa+EdRB8Si2Om62y23+GkAn5U7iAy/2ab8=;
        b=Rci2lDfrr5YlkXqzrvXcG9pLHSYtLlwZH3Qmo+KI/bGexWeqi0wIwaC5nPI3G2120q
         HRbthr3CAFNF7Oa4JxA7voCBlv/5uaCDmWuCFYDoo/dk1p6C5B74TAhqWenD5OH1kYNo
         3eGtc8Mx+NNglokdSUGdnjBQY7ta9UURYftWrasFyFJlrgbVneqzARIpob6yOJ3khPWp
         9MpJvLJoTMajf2KEOch6+TEqBYlr1o8iLcQX/6ZxQdrKKfuPXzeIvvHe4uimORTyWz6C
         Q1vWzrpxFg5/O29D9qOD+IwKL9BLisN3qsH+gPIJu3wrgB9K1SfORT7P4GoVJIveGgJ5
         l0FQ==
X-Gm-Message-State: AOJu0Ywk8W8RKdPci5h+ZV79epUjKkqFOhKiti1jLlGd0qfhQLYRBdf9
	Vto41zkjTbU1zIhquLPbMZg3pKGxGGAxoIoh6NLaztDMjqn8leP0S6mg4Q==
X-Google-Smtp-Source: AGHT+IFQo7/6O5EF+rtjwKi+u9V3ktwy4d2DDjCrQubG/E/r7+oF7w6maiADq05eU5RM6LueFtvl6w==
X-Received: by 2002:a05:6402:5021:b0:5c8:df99:a6ec with SMTP id 4fb4d7f45d1cf-5ca0b0f4b83mr9402947a12.14.1729431830615;
        Sun, 20 Oct 2024 06:43:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66a6a734sm912659a12.58.2024.10.20.06.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:43:50 -0700 (PDT)
Message-Id: <fddc320eb0bc07b1f8314a07cdda1cd8fbf77e9f.1729431811.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
	<pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 20 Oct 2024 13:43:30 +0000
Subject: [PATCH v2 17/17] pack-objects: thread the path-based compression
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
