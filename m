Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9561F30F938
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505410; cv=none; b=k2sGhd+yz3kfdCNEr0dQZLtplFMCLNyTKxBCiT6xMlkme1PiIgodC+xZ9dfTCTLJ7m+RRHASD0nRIcXlX9oSZXBlfi+pEXk/GJ9yXqxGFZmAVlZehySJjR9Lz5uj6ZAel4oqUjym1hjHr8jVmNEqLISYjXOGCh+Cu5+PCAc8D4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505410; c=relaxed/simple;
	bh=n56wlG37YQKF41/3wPhcKn8zacwCYy2chJFd2KBfFLU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Xq3/4pb/RLhNE0sHdHX5RrDdkU6bOUvnXnI7Kv6VIV6yKXlTeuwILFUS4ipzPK5XJvnrClq/lsXhkzQGHcfmFG6Npf1kMMVSu46VPD0yxB9YWR7NKQQkJUG5hMQ5vNJT5QueoGLUdqPX9QSA0iSuUmyIOc4cIuojpuxO2Q5LK/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pCAj+XXU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ap3YYK70; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pCAj+XXU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ap3YYK70"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 97FF57A0112;
	Fri,  4 Sep 2026 03:03:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 04 Sep 2026 03:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788505407;
	 x=1788591807; bh=4WA5DrF1TEhEyVMK+9xuPl9KBLvAbSTK39EJML/UM7E=; b=
	pCAj+XXUKDnMY4EVx0E6gTYaQbHjU2UCqMYolvBqiiggUv+ptGCt943z0rSkUiFa
	sDFG47DBAV9k13fLzDsinvG6NUcxQgU4T+gSnt6wngdynf3KvrOuZsBn99WcRU1y
	McFzB5RF4qLLoRd7uUHiflnKVbM42b2RwlS3xnlUREWFCqfnMuUJzP0fC2GZ7CGu
	+/zs7jJuNO3UOtEjWO5ab6uvMkdF3ixqMFzOrnDCD+7aMKItD9P5qAoHDfpYcryT
	W7C+8LBCDXeuVMufN3gxI9OKCbOGtyF4ixl7W9qUNn9TwONaG/fTjLy1SRTYYVBg
	ZBKEBV7IOGI8CRcT8OinnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788505407; x=
	1788591807; bh=4WA5DrF1TEhEyVMK+9xuPl9KBLvAbSTK39EJML/UM7E=; b=A
	p3YYK70mcA9X9Th3SIqTx4KT3cbn77lRp0RXddm/IzhZ2qHXh8gucWysgENEST/R
	F4SXCs9F9qhysmyT5ZBbq221j8W+RG62LmbvxHP3Dk/qXTxNghXnTEiP/2oOzUcs
	G2RRnT8XSmx0VZHTjtEYrhwouhoakMrTO37xzBFnae60JoeOVQY3awXgXtmZ/lfv
	9avjWOPvxBYI1ZJNzFv5Kdf5NU2QprtBSqdPhCHcVZhjmwiVBnKkeHbBsCPKOS9w
	0dkWg5HrbZ1hRBBfY3D4FAU9BKRDjVH4ycIW9sakVRZZ/+Do7RazHkl9xIrD+R+p
	e+EDs3wFFcdOsj+i+IBcA==
X-ME-Sender: <xms:Pm2aamHAErJvOvhSk08Z3dohg0bykZpqgSFfosMyjhsS66lzlntNIA>
    <xme:Pm2aalIdX_vj4pzLjAdFYEJP3rHvXAZJ1vq9QclbfHocDb8Kkx3nIBIUUp3ioq4A1
    VEFSnFP2EsjmLM4dLt3xoNsWyHIeS1FgRMOwgdxKfSYPJa3NwjP1_A>
X-ME-Received: <xmr:Pm2aaqldsEz3Oiox0OVBcsO9Z2M_T19Tl0NNNki1bOrH0ws7fUIM54kaRXhz1GiMJFHoTA>
X-ME-Proxy-Cause: dmFkZTEkUk3t8PrQCFPbSwCm+1z+WZGXg2l+fwb5J3RjkV+jKpC6lwPOa+MRtJFC8u/1cX
    Wj9JmUMJ1f6xkOgU5nJB4jCBF6Ja8D8ppC9i8erkOx1T2WaDYbvPSEBxm3O/CSkx6Sc4mw
    MqHQ2qlwvPSf6/qAFfj2U47O0PiuaPqSEileffN6fT98R8/EOFVlQVa7XYH5tvkYyoJNid
    sCUX4hPIKfa4jjoKtdBYUMwvZ1zjIzMlsywcl5xmVILRTLD5VAmdzgERs6Gyuarz984gkO
    ksAFP7Gf1tQDLEJn3fGV/AC9XKBKPAysKK1oPQai+5JBXblTvc0wYQEzSIEyokZFsBa9Qx
    /Gxi8AtnUqEbPP2VOCpAr78ll5obGxB7X6aXnRPsqky3E1IAfVBSEFvCVV3vaKouMpE/4M
    ZF+FmtWJfjGf/Kr0GUl3m4/5+ANPHX5mtn2io2AJP0rCr2MhzRKr8Do2sH82IceBfuIULu
    Hgze8CRYT8f202zkqJ5asQK4XIJBz/92pWYAiQmIjE6C9O7Z3XDSIJjjosGXk80XThFVoO
    j20p27hSVumTBBnXYnojKijiS8s37z5XHKMLOwM/ZRFSwoytLK/tlLP4eb+QYeNb6KdWKy
    FlKiZF4sf8xLMdpWoB+t2Y30P/BbCg2n1FODha+DQ9hExombcFSqxHFQ8qAw
X-ME-Proxy: <xmx:Pm2aatQEoE_cxD9Xc8oCglsy9HYdWD-ozPTGZemGEpzwfM0vbVDv3Q>
    <xmx:Pm2aasKZ0362bHH94JcjHbCY1O-sA7lt5cs6gHB-WRzlEMPQW-0DZQ>
    <xmx:Pm2aajCqQTJzatoxIBU6Sf4ADeVWlT_ekQNnV8zD0B23mo1GNz1BoA>
    <xmx:Pm2aalApL4zpbdE7gK0KsjgP6heKwPZ_QDyCT4S6A4c9NIe4cy8qxw>
    <xmx:P22aareMZ0UGBeFsjAhE7LKFErc7maGRaVMypZcokAPLBu-30er1kIH2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 03:03:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 16cd12d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Sep 2026 07:03:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/2] builtin/maintenance: improve heuristic for "rerere
 gc"
Date: Fri, 04 Sep 2026 09:03:04 +0200
Message-Id: <20260904-b4-pks-maintenance-rerere-gc-heuristic-v2-0-b1691121fe1c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOSw6CMBCGr0Jm7ZhannXlPQyLUkYYDYW0QDSEu
 9viCcy/+pL/tYEnx+ThmmzgaGXPow0gTwmYXtuOkNvAIIUshBIpNhlOL4+DZjuT1dYQOorCzmB
 Pi2M/s8GySBuhlc5FKyGUTY4e/D6G7vWP/dI8ycyxPTr6EBzd53iyXqLv79H1ggKVkspkuVZlV
 d1C6swD1Pu+fwEyQ+jf6wAAAA==
X-Change-ID: 20260903-b4-pks-maintenance-rerere-gc-heuristic-763b0a9a50d2
In-Reply-To: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-0-9929c45a9788@pks.im>
References: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-0-9929c45a9788@pks.im>
To: git@vger.kernel.org
Cc: Thomas Bachem <mail@thomasbachem.com>, 
 Derrick Stolee <stolee@gmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

Hi,

as reported and discussed in [1]. Thanks!

Changes in v2:
  - Restore `prune_one()`.
  - Handle "maintenance.rerere-gc.auto" values explicitly.
  - Rename `rerere_gc_estimate()` to `rerere_gc_needed()`.
  - Link to v1: https://patch.msgid.link/20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-0-9929c45a9788@pks.im

Patrick

[1]: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>

---
Patrick Steinhardt (2):
      rerere: extract logic to determine whether entries are stale
      builtin/maintenance: improve heuristic for "rerere gc"

 Documentation/config/maintenance.adoc |  8 +--
 builtin/gc.c                          | 28 +++--------
 rerere.c                              | 94 ++++++++++++++++++++++++++++++-----
 rerere.h                              |  6 +++
 t/t7900-maintenance.sh                | 61 +++++++++++++++++------
 5 files changed, 144 insertions(+), 53 deletions(-)

Range-diff versus v1:

1:  343dbf1c0c ! 1:  1b0b7a7b9a rerere: extract logic to determine whether entries are stale
    @@ rerere.c: static void unlink_rr_item(struct rerere_id *id)
      		cutoff = cutoff_noresolve;
      	}
     -	if (then < cutoff)
    --		unlink_rr_item(id);
     +
     +	return then < cutoff;
    ++}
    ++
    ++static void prune_one(struct rerere_id *id,
    ++		      timestamp_t cutoff_resolve, timestamp_t cutoff_noresolve)
    ++{
    ++	if (rerere_id_is_stale(id, cutoff_resolve, cutoff_noresolve))
    + 		unlink_rr_item(id);
      }
      
    - /* Does the basename in "path" look plausibly like an rr-cache entry? */
     @@ rerere.c: void rerere_gc(struct repository *r, struct string_list *rr)
      	DIR *dir;
      	struct dirent *e;
    @@ rerere.c: void rerere_gc(struct repository *r, struct string_list *rr)
      	repo_config(the_repository, git_default_config, NULL);
      	dir = opendir(repo_git_path_replace(the_repository, &buf, "rr-cache"));
      	if (!dir)
    -@@ rerere.c: void rerere_gc(struct repository *r, struct string_list *rr)
    - 		for (id.variant = 0, id.collection = rr_dir;
    - 		     id.variant < id.collection->status_nr;
    - 		     id.variant++) {
    --			prune_one(&id, cutoff_resolve, cutoff_noresolve);
    -+			if (rerere_id_is_stale(&id, cutoff_resolve, cutoff_noresolve))
    -+				unlink_rr_item(&id);
    - 			if (id.collection->status[id.variant])
    - 				now_empty = 0;
    - 		}
2:  c8a52f0663 ! 2:  1ceb798cdf builtin/maintenance: improve heuristic for "rerere gc"
    @@ builtin/gc.c: static int maintenance_task_rerere_gc(struct maintenance_run_opts
     -	if (!dir)
     -		goto out;
     -	should_gc = !!readdir_skip_dot_and_dotdot(dir);
    -+	if (limit <= 0)
    -+		return limit < 0;
    ++	if (!limit)
    ++		return 0; /* never prune */
    ++	if (limit < 0)
    ++		return 1; /* always prune */
      
     -out:
     -	strbuf_release(&path);
     -	if (dir)
     -		closedir(dir);
     -	return should_gc;
    -+	return rerere_gc_estimate(the_repository, limit) >= (size_t)limit;
    ++	return rerere_gc_needed(the_repository, (size_t)limit);
      }
      
      #define OPTIMIZE_FIELDS_FROM_GC_CONFIG(cfg, aggressive) \
    @@ rerere.c: static int is_rr_cache_dirname(const char *path)
      	return !parse_oid_hex(path, &oid, &end) && !*end;
      }
      
    -+size_t rerere_gc_estimate(struct repository *r, size_t limit)
    ++bool rerere_gc_needed(struct repository *r, size_t limit)
     +{
     +	timestamp_t cutoff_resolve, cutoff_noresolve;
     +	struct strbuf buf = STRBUF_INIT;
    ++	bool needed = false;
     +	struct dirent *e;
     +	size_t count = 0;
     +	DIR *dir;
    @@ rerere.c: static int is_rr_cache_dirname(const char *path)
     +			if (rerere_id_is_stale(&id, cutoff_resolve,
     +					       cutoff_noresolve)) {
     +				count += 256;
    -+				if (count >= limit)
    ++				if (count >= limit) {
    ++					needed = true;
     +					goto out;
    ++				}
     +			}
     +		}
     +	}
    @@ rerere.c: static int is_rr_cache_dirname(const char *path)
     +		closedir(dir);
     +	free_rerere_dirs();
     +	strbuf_release(&buf);
    -+	return count;
    ++	return needed;
     +}
     +
      void rerere_gc(struct repository *r, struct string_list *rr)
    @@ rerere.h: int rerere_remaining(struct repository *, struct string_list *);
      void rerere_gc(struct repository *, struct string_list *);
      
     +/*
    -+ * Estimate the number of stale entries that a run of "git rerere gc"
    -+ * would prune.
    ++ * Check whether garbage collection for rerere entries is needed, which is
    ++ * the case when there's at least `limit` stale entries that would be pruned.
     + */
    -+size_t rerere_gc_estimate(struct repository *r, size_t limit);
    ++bool rerere_gc_needed(struct repository *r, size_t limit);
     +
      #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
      	N_("update the index with reused conflict resolution if possible"))

---
base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
change-id: 20260903-b4-pks-maintenance-rerere-gc-heuristic-763b0a9a50d2

