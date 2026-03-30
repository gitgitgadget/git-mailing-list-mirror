Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA3A3DD523
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774891675; cv=none; b=S3RhIIFZYIU8c3M3lwih885ByFC8xtglF3TOrPGT8vExrBhgFeemCEyoJG9+U/o4wX8xo+IpUqVlJXuESwjJK+dGl2Rj5zJB7yxJ7E7JeIBjDZvhYJ4T30DKlejUvc+eoweWEFQC2ECyDmz6x9LtSv2J+vcaLZqrAhSuitSSBrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774891675; c=relaxed/simple;
	bh=eEY8bioPC3rdg/MshVXKCXmj7tG9yq1bi4orV3KXpCY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XK1Too+Ln5CRUxvhLQZzGHOZ7nfdrIwPN882gKIXAALsBcwF6LCQMqsj/tVHDzzyZpmnxf5hddmE0bD3d7d6xfrYEkMU+R20vkonDB4T7AXzuI8lATrSxWO0MCUdDDNNn5Q/d3FPHenImwNntoMzdi/z5Zw3qQ5Qz9/Vrd4eRLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sQswy1CP; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQswy1CP"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12732e6a123so74515c88.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 10:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774891672; x=1775496472; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WswM6YAsVsW/g4Gm1jHiBLbiYXqEJsI2DQyBBbhDuWg=;
        b=sQswy1CPS3PA806M6XRLDK84g+IkxmPnAldod07BBenLVEU5XFwBl22SAheN4lmA5Y
         YbT0s1ss8DyKgBFFpjclMPLMfO4YDYBx8paZQNdxVHH7lrpjCar54JRXFYi0EKx1qeCC
         MlgrHMYeVDLM/dge6mplJTFkag1W8y2OMqw2JKrUTR6TLTuNZN5v8yVWKY1MTWJbN9Pg
         sWjpCggCMGINDEfUqsU4ygIf/k0/byiDm42roon+vt7vo5qwzdlLgV6sOKsqnXO0uO2I
         37vzZbeoT+aNRAvbqtoASMZc+z+1+fIHYVG2UpFF1H9mzuTEHWN99VUFjS8U6pP+OFUu
         jqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774891672; x=1775496472;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WswM6YAsVsW/g4Gm1jHiBLbiYXqEJsI2DQyBBbhDuWg=;
        b=YAfIuPtteqD4nog1yDdtDn96h90RT5pDC1PEzBw0WuN0r68B0ochxTpAbNPNnPCvZE
         jnK6v5yKRWsjzqc9W+Z57uoa+mqUZc237YWDrBZQXvoMG3aGnys2X0LvsHLUZKL+kavu
         /RtaMt2r/0cmiKFNc/2YsWb2VG3ZWuehQZGk72GZVSDFBVN/mHCuNPWt0Ou4yZ7cWHRB
         AZVqp6pWSQ2vxPFbrHkMdzsPCZ5yIOqkwy9T6D5CFRjVWH0i/ZK7a/3jquJjHdePtEs0
         /EzHCq5ijwy9KDGl45c1Kq0HjWJqvYoeXxso3UjklAvkGKOjWIW3qcZ9W9osoD1NaW+r
         29bg==
X-Gm-Message-State: AOJu0Ywsop7ayv8++bnyUIggnWe05EHC+OgUPaBBiM+gudxzKCf4tyDE
	snLfYpPuv74VnBMfIAUtobVGTzYzxIh0hp8T94DdXOkLg/ifMQejKwoZI9ykzg==
X-Gm-Gg: ATEYQzwvNYWLanL4AfdyjnNfUXjc7LP56kW1k0UvJBONaEg46WPuJJyU9CVEIyutS2N
	8HxhFAY8CAMEzlEKLmIB4D+f4k+fkCGgXFkBWP6hGCIfVh+E27M59eWTy1JxhuPtMkf2oXBQ1WB
	B/sOqj4onZK+NVH9G5rM/EE/YpnNflSLsMszIM/NIRvagIBmXA+N9vHd7pZqfWyD522d5xolQ2e
	Ct9Lch1F4sTaLTrdalY2oKalkCGoUCDZqoHxLC/ld0mXPp24YLQTv6In5OkuKsfpVgOWk3L9t5s
	2L0WbC7yR+vl8TPTtlmb0U0ixRc83kpL+B+60WTYJrdgwbMsqZ+s4E1z73z/VxM461EkntjPp57
	5Qo3VOY4UAcgVBAgLv79kdTCmOHKeJqCeKoI+8/GaY2kuu9/v3FqD8E0ZtmVzxII1rAdcwCg++M
	3vw/ey3Tjsajrccgtc1tRBrNr9mQ==
X-Received: by 2002:a05:7022:e982:b0:128:d714:3ca1 with SMTP id a92af1059eb24-12ab28a2141mr7252373c88.5.1774891672312;
        Mon, 30 Mar 2026 10:27:52 -0700 (PDT)
Received: from [127.0.0.1] ([52.225.73.164])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97cad88sm8311942c88.1.2026.03.30.10.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:27:51 -0700 (PDT)
Message-Id: <9bb6d0fa01d083daf0570c0c33a5610f51796497.1774891667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2253.v3.git.git.1774891667.gitgitgadget@gmail.com>
References: <pull.2253.v2.git.git.1774682046750.gitgitgadget@gmail.com>
	<pull.2253.v3.git.git.1774891667.gitgitgadget@gmail.com>
From: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Mar 2026 17:27:47 +0000
Subject: [PATCH v3 2/2] read-cache: use istate->repo for trace2 logging
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
Cc: Jayesh Daga <jayeshdaga99@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>

From: Jayesh Daga <jayeshdaga99@gmail.com>

trace2 calls in read-cache.c use the global 'the_repository',
even though the relevant index_state provides an explicit
repository pointer via 'istate->repo'.

Using the global repository can result in incorrect trace2
output when multiple repository instances are in use, as
events may be attributed to the wrong repository.

Use 'istate->repo' instead to ensure correct repository
attribution.

Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
---
 read-cache.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 5049f9baca..b1074fbf06 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2309,13 +2309,9 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	}
 	munmap((void *)mmap, mmap_size);
 
-	/*
-	 * TODO trace2: replace "the_repository" with the actual repo instance
-	 * that is associated with the given "istate".
-	 */
-	trace2_data_intmax("index", the_repository, "read/version",
+	trace2_data_intmax("index", istate->repo, "read/version",
 			   istate->version);
-	trace2_data_intmax("index", the_repository, "read/cache_nr",
+	trace2_data_intmax("index", istate->repo, "read/cache_nr",
 			   istate->cache_nr);
 
 	/*
@@ -2360,16 +2356,12 @@ int read_index_from(struct index_state *istate, const char *path,
 	if (istate->initialized)
 		return istate->cache_nr;
 
-	/*
-	 * TODO trace2: replace "the_repository" with the actual repo instance
-	 * that is associated with the given "istate".
-	 */
-	trace2_region_enter_printf("index", "do_read_index", the_repository,
+	trace2_region_enter_printf("index", "do_read_index", istate->repo,
 				   "%s", path);
 	trace_performance_enter();
 	ret = do_read_index(istate, path, 0);
 	trace_performance_leave("read cache %s", path);
-	trace2_region_leave_printf("index", "do_read_index", the_repository,
+	trace2_region_leave_printf("index", "do_read_index", istate->repo,
 				   "%s", path);
 
 	split_index = istate->split_index;
@@ -3096,13 +3088,9 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 	trace_performance_since(start, "write index, changed mask = %x", istate->cache_changed);
 
-	/*
-	 * TODO trace2: replace "the_repository" with the actual repo instance
-	 * that is associated with the given "istate".
-	 */
-	trace2_data_intmax("index", the_repository, "write/version",
+	trace2_data_intmax("index", istate->repo, "write/version",
 			   istate->version);
-	trace2_data_intmax("index", the_repository, "write/cache_nr",
+	trace2_data_intmax("index", istate->repo, "write/cache_nr",
 			   istate->cache_nr);
 
 	ret = 0;
@@ -3144,14 +3132,10 @@ static int do_write_locked_index(struct index_state *istate,
 		return ret;
 	}
 
-	/*
-	 * TODO trace2: replace "the_repository" with the actual repo instance
-	 * that is associated with the given "istate".
-	 */
-	trace2_region_enter_printf("index", "do_write_index", the_repository,
+	trace2_region_enter_printf("index", "do_write_index", istate->repo,
 				   "%s", get_lock_file_path(lock));
 	ret = do_write_index(istate, lock->tempfile, write_extensions, flags);
-	trace2_region_leave_printf("index", "do_write_index", the_repository,
+	trace2_region_leave_printf("index", "do_write_index", istate->repo,
 				   "%s", get_lock_file_path(lock));
 
 	if (was_full)
-- 
gitgitgadget
