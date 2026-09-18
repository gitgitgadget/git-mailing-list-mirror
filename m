Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A112849F10A
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736549; cv=none; b=oIUCCVlFKuQ9YoWcPdLLMYs3AQ9gsf/iAg4C+byfvlv67HPC55rBYnsQgUui7YBRBaTHOax08hnkhkmNKn/UI0xsdKerfosMSX4FeAmqAlh/urXZs3aqLyk9kO8tB3CrGVUJsyzj6xVueJPzwchIcOw7VRhbcwdTxm/P0Gs/tU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736549; c=relaxed/simple;
	bh=usgNzh6O9VGqkPRJ26dlfCua+v6owo/tbQwE3a/2D0g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BnA9MUXWN56RAUPZwWDqcOgEb2+90cdz63Odx0lMCN1EOJeVGceEH+/LfZd90PCNo4lKGAMmINmvNGekxjOJ3uzRO3EAvrgzuP/pSUNDLVFWtddoWA6+/+BouAxEIbXuOwdRhwCUjwFQ/+FL6fCvS+97H6W47aYTM8zC0h7b2EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJNdWnBn; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJNdWnBn"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4aeso525655a12.2
        for <git@vger.kernel.org>; Fri, 18 Sep 2026 06:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789736547; x=1790341347; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mjNeB5X5AnxVwbeYyuIi0gysO7viQTYLmXYqYaAxuTs=;
        b=EJNdWnBnmmknGO6lHWXxwInTCG+EDcjqbOOVq0tCI69uwvUQ404plO3v48sAAeH6UJ
         3STXATvVg0NmAqIErcQimQuAubEYTy6PBJetGjypo2GdWhcsZDRCWIP9dTYMfkQI+uTs
         EzRZwChfRo7a9ZNzPiVwmyKT3VIi2RAf0H1s5oK5q2cukZ0pqFyWHerEzima8pYMaF7b
         /deq2IbNuNmu6EHbC/B4O0/mastJ4LhFHUABbcrtTTO6U1PTe+/dtH9TYP66BX+1HIo4
         70CEt4540ntsFoHIqA7PJU/ppio852H2ofQ41ee7xfPjI1eHmdYMhqrU9bwmJNGcNdJh
         mytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789736547; x=1790341347;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mjNeB5X5AnxVwbeYyuIi0gysO7viQTYLmXYqYaAxuTs=;
        b=rvqyzkVb/CJ7vLA9Ob06IP++k1sYiNYZg9opa9MwvoJLE5oLCL+/+AqPnvQmjUoo0b
         3WqAD1h5r6Q0QMLrW44RPewdpftkh81XjN+IntThakZY0TCL6raR5j8dB2DdzEjmCW6M
         lqz/7QYd9krQ5wlnWS+x0rUiv7RdTHjHraonEBrkhUnGEmctI6JXWxOxGCwebQmrPImL
         RIUOHcjnQwhVqy1lY5287bwqrGgvJgwX4JwuEr8MR5ybryyonXm+7ocEN6aCQnTZBYHu
         2+xqdhqvBzD+OlL69Upykygh9QTwiDLUBkhKtZk82lRWxCAyuYwN7679j9mMvjYxuVD9
         R8dQ==
X-Gm-Message-State: AFuF++ne7wCd1cxpkOSaHtUl+bIT0RCk4ZRHJivjDQLqboKeD0k7qoIE
	qqtTOJsbpUlTIYRq4TVB0tIs/DNsU5dPxR6nNqFPC9JKrquWnX8ywSEs/U6EEesS
X-Gm-Gg: AYBFou0cQiVtt1Dzh2SjaBn+0f0HsBmyW5n3ptraPFbRC6HEi4P0JWEF/SsUDqt4+iJ
	+hM8/GG66v1LFjP/RmV/2dvh0GcGC5PPTBoz/oqkfSe4STSOZfIs9Q1ZlFal5ZXfweAGCu4gAog
	6CQwU51L7jIjts1flukbZbYstFLLVw8500BV4qB+8OVtCj4l/1NEMSmbkoEamwd53YvTw0nhgfj
	H9Hz3OQeKrpWLlndtrwFLnNru7R9LdO4bNIRMlAn2+mV+0Qu6uunM6weanYVL77lVS9ib/HMclx
	fPyUbu6FSES/IdgjJ3/DvfzH3H2d5iFykjKm8YsrtNgPkM5acNwPzSm9gQX+aysji3+Deapu+HC
	SVkiXlnr4pz5r4G0T/WU7tUPF239Idn/q56IQ7TrRdJx30M14VZgj3O7Kc2ZMv2RvUo+DA7nL4t
	1REvyLKDW17Gbje9fseKVvsy1lBQPoyxatoLKxgSJzhjQP++wv1pn0pWZQuLC0q7F2MPsZwx1y
X-Received: by 2002:a17:90b:1647:b0:39e:4498:4863 with SMTP id 98e67ed59e1d1-39e54f4187emr8543021a91.10.1789736546761;
        Fri, 18 Sep 2026 06:02:26 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.95.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e361b7266sm10498815a91.13.2026.09.18.06.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:02:26 -0700 (PDT)
Message-Id: <3b3c67243d200a42aa105981b64228e2cbb35a6c.1789736540.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
References: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 18 Sep 2026 13:02:17 +0000
Subject: [PATCH 3/6] wrapper: create safe_memory_limit_check()
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
    peff@peff.net,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The existing memory_limit_check() is used in many places within wrapper.c,
but because it initializes the GIT_ALLOC_LIMIT environment variable _and_
can call die() when not in gentle mode, this method isn't appropriate for a
safe API.

Modify the implementation to be safe_memory_limit_check() and to keep
calling error() when there is an allocation problem. The original method
calls that version but will die() instead when failing and not gentle.

The one potential behavior change is that when git_alloc_limit is unset we
must assume SIZE_MAX instead of loading the environment variable. Since we
load this environment variable proactively in setup_environment(), this
should only matter for that brief window before setup_environment() and the
safe APIs that call this version. If such safe APIs are used in that window,
then they should allocate small enough amounts of memory to fit under any
reasonable values of GIT_ALLOC_LIMIT.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 wrapper.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index 3de6b21cc2..97a29bda75 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -30,22 +30,31 @@ void initialize_git_alloc_limit(void)
 	}
 }
 
-static int memory_limit_check(size_t size, int gentle)
+static int safe_memory_limit_check(size_t size, int verbose)
 {
-	initialize_git_alloc_limit();
-
-	if (size > git_alloc_limit) {
-		if (gentle) {
+	size_t limit = git_alloc_limit ? git_alloc_limit : SIZE_MAX;
+	if (size > limit) {
+		if (verbose)
 			error("attempting to allocate %"PRIuMAX" over limit %"PRIuMAX,
 			      (uintmax_t)size, (uintmax_t)git_alloc_limit);
-			return -1;
-		} else
-			die("attempting to allocate %"PRIuMAX" over limit %"PRIuMAX,
-			    (uintmax_t)size, (uintmax_t)git_alloc_limit);
+		return -1;
 	}
 	return 0;
 }
 
+static int memory_limit_check(size_t size, int gentle)
+{
+	int res;
+	initialize_git_alloc_limit();
+
+	res = safe_memory_limit_check(size, gentle);
+	if (res && !gentle) {
+		die("attempting to allocate %"PRIuMAX" over limit %"PRIuMAX,
+		    (uintmax_t)size, (uintmax_t)git_alloc_limit);
+	}
+	return res;
+}
+
 char *xstrdup(const char *str)
 {
 	char *ret = strdup(str);
-- 
gitgitgadget

