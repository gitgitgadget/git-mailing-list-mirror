Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882A319C540
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097274; cv=none; b=ocIymeSdgMA+Xs/7DqV+vpEl8LQQCJfuEH/z/BrZz5PfTSjUK46RDX4aCEpnHvZmHlju/6to2+Xbga+12WlF8Zm50jrjNk8CcfbA+lxUo3nPOQeHnIAbEgIYoYcDaJCmmdCmgcn0XpMMoO9z29zQAB6vn3FXs3xSrzNqlFV4AlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097274; c=relaxed/simple;
	bh=V6NSSyE1scrw9Tlh4erfRo3Mha0b/hB24vROxZ5SiCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPqJ+1WmHJ1l2u61daVOHgziKUmNT7PPOUmUpDyVyLLWNWBhNY4BSgpm/hudCoSN3I4xu0X03oHPQ33QcRc6Pw9oKDdDzdN1MelMtrWEZRzQGT8bqa3TvwA9/88Y6K7iObv5BxQKZ3eGonOh4L/gfXdj+F6cOCw6HTbgfKGZAco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=gwZnxSt5; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="gwZnxSt5"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6361a421b67so3698379d50.2
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097271; x=1759702071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OaURRWGtOk2+WfLrByK9nMnZQCj009KFKOEzJTomQAE=;
        b=gwZnxSt5UxZbpSn0WmrhRz+G5bTxiBJVMsTNyoeQ6i1wIvISXhwT/mhkm57Tj5dTft
         JK8/4d3desNDxog77kZqr09JHHlf+bRlKOu/l9MgY3Kn0KbjGuFcEfGiQswHXU1JEsZ2
         Kw9y4k+T/RtIs9AFGHUHF5j6sVz1HIVr4BoOuu9Mjb+OXq1s6/n/SCnKnrf8GBQJK2mq
         Jt5PlCYOMHykD07N2wyid60F2sbc1japP+EUJAyM1xwdg/kj5S4sSTNfl+kiu3jmKWhO
         EuOaXK5/W2zHUg+WwkcXe+1KQdBEbmkxCjRsTdIDseUF5W5Li/86HkVBcYZrAq9Us7b6
         A3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097271; x=1759702071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaURRWGtOk2+WfLrByK9nMnZQCj009KFKOEzJTomQAE=;
        b=vKajRb0B83gmOD8To9uwTPsEqc32DImIpunW0F0AX/QlEXl3/UeFz2ivDOmvMQQNzi
         tlm+kIPr6VSAdBbLLbrnIICxI8jabfUkrvLVRdnKS8VpAP0k+IDAipV2IZUczUaefvTA
         1chyTnwMhOH8Xzpq44eyHxCDIcbA1fN4OlqBRZ5oBCVlbPzOB+p8XRM6aDzxkH6B32bD
         9KPIbuGyA3XQJApr46MjfdK/j2WUqboxu8Ama6HG4CHnXY4Q+VZ2L9DOAw/+9xaT7uLJ
         jMyslznH2Rf50RcapKYsPe6oQ6cW0VluTPwmL4EEPJnUon4tbISW5fpHqcpF02RxPvWd
         65Xg==
X-Gm-Message-State: AOJu0YxeuCsNWKXcaJ54jMHNpCKPmoAVl0QfUNziFQjcvkhI1ItBy90H
	87Uow7by6TwEPUxOpZr8hxmIyO8Gr1Bopb9VEpbJSrkgFiRSWOIY8fcynxttjZtdKvg2OFOnxyB
	WmN8Tn5MhMQ==
X-Gm-Gg: ASbGnctsAg7YtkxUDsG9rcM0S4Jpr9gdHUh2nnF+Kw62IAPfPBPe9gxDCHZVZmIAxp/
	+o03+hjAzQVLvlivOpD0/q7jzep4EhsQYk5QE0I+wInKRtRdC7zXPz8wI1vytN6uWYMA3Ol/nhX
	imnJORY1Nll/BsliC6GrPJa1SAnhDFMmflBfd/ymfl/UGGIEQGgDEE43yHuFY++bEHd9X5M6vQ5
	p7Bmz/tU7QJl1+db1doE9ygdV60VMh8ICOgO8lxLI+UD6hNO1R+msot3hntmJM3zi4aNNYC1wvU
	SyY6nqn8mJm0iJYIiQtJsTvMdDsoZlEEkbxoe+XNllQ9Ffu+ZIObwako46YiKbkwOdZIu7P20a6
	GEXQ+vCqkRSAJdw06ziJFroJ4vwt+JTMj4c4LW6vTcLyyMcrYiFfMOf7J7708lZx4p90dU5yYYR
	E8XniyX3m5FLxCWgUdCFS4pXqEyEWpRCGwXdcW
X-Google-Smtp-Source: AGHT+IEasjRZAa9uo+8jcgn976Esq4z51DJx0NBJYvp8lHsBQm0fdWuv7YVk6CkM7Pr9rqe6Gy2K9Q==
X-Received: by 2002:a53:c7ce:0:b0:635:4ece:20a7 with SMTP id 956f58d0204a3-6361a8500fcmr15349255d50.44.1759097271345;
        Sun, 28 Sep 2025 15:07:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7741797531esm9369167b3.48.2025.09.28.15.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:07:51 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:07:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 10/49] builtin/repack.c: avoid using `hash_to_hex()` in pack
 geometry
Message-ID: <de4886466cab65dc72c5f800d680a610dcb0563c.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

In previous commits, we started passing either repository or
git_hash_algo pointers around to various spots within builtin/repack.c
to reduce our dependency on the_repository in the hope of undef'ing
USE_THE_REPOSITORY_VARIABLE.

This commit takes us as far as we can (easily) go in that direction by
removing the only use of a convenience function that only exists when
USE_THE_REPOSITORY_VARIABLE is defined.

Unfortunately, the only other such function is "is_bare_repository()",
which is less than straightforward to convert into, say,
"repo_is_bare()", the latter of the two accepting a repository pointer.

Punt on that for now, and declare this commit as the stopping point for
our efforts in the direction of undef'ing USE_THE_REPOSITORY_VARIABLE.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a043704aa8..0d35f15b4b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -683,12 +683,14 @@ static void geometry_remove_redundant_packs(struct pack_geometry *geometry,
 					    struct string_list *names,
 					    struct existing_packs *existing)
 {
+	const struct git_hash_algo *algop = existing->repo->hash_algo;
 	struct strbuf buf = STRBUF_INIT;
 	uint32_t i;
 
 	for (i = 0; i < geometry->split; i++) {
 		struct packed_git *p = geometry->pack[i];
-		if (string_list_has_string(names, hash_to_hex(p->hash)))
+		if (string_list_has_string(names, hash_to_hex_algop(p->hash,
+								    algop)))
 			continue;
 
 		strbuf_reset(&buf);
-- 
2.51.0.243.g16eca91f2c0

