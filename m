Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15F41DDC34
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270126; cv=none; b=LTPCBy7Kr6LXEVmFo+Goer1QQhqRa6UkPjELREoS+6sP8bQBwUoQh/7784LpNJT6tV6/8RVnqGwneRUJmCk5p22Z4i2F5hiM3Q9xryPQXHluR8Wi34leM23Tk4yk0SBP5XwJ2Wo1YzHg2655cP9+edxCuw1a2IQknjOCCANjirg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270126; c=relaxed/simple;
	bh=d6sdkK0ux3KtPyDTPF0HKqRy1C23oH3A4/6G/7oeEfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyUd4xbaSIKfljCf5yfUzNid7UlUYLHT6ZW7i2VAZdfAIaQuY4DkjTHeMTL12x+AMdBu8B/+mr512nXCn56YB8sfqnNINXk70wt3EuzlmlEzCNKK0sSs98WnSvn7jpN2sacG66jXY5w3QXKY7fEoN88r5GbnF8nGpmw8EOrOa1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ad55nWb8; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ad55nWb8"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb6110c8faso20660001fa.1
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 02:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732270123; x=1732874923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=At6YYIJXzeWa4k6EzUBy/H2J9gDE5RLV49DvTQzUKE0=;
        b=ad55nWb8KV7w6IW1xzIkivtNZexdjzA9n05I3jzkdX2v3e0U1/NlCKLQ6N/Z76/7hR
         nKBR83arpqRDVoJxA/tIkylaxxEixiolvPj2d6Hp+rrsem7f2DNbgCfj6UJC4xYGM4wb
         vht136Zy40SHtvMg3iZWIJyZKPm+tu0a2o2KcDUCmQOZOggNkOSaLF6oJMZq67KV9cK3
         LbTivzIlur7lzcr48huz/oorySkTGsPFbHog9KIbZXU0UtfSdyajFMIi7IWPVrYboDCW
         WzwVSgPbRk68YJSaUbrrMOkN+yGb/qEl8b76XInxnkqv3Vsirgji/EEW0MJ1Fvidnp4G
         ihbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732270123; x=1732874923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=At6YYIJXzeWa4k6EzUBy/H2J9gDE5RLV49DvTQzUKE0=;
        b=YCW/YAiZXJxNpDkkI8nAn5LXUGZ/XoJXkMEhksXo2cKakZXdtuCT2VU4fWRMKwEbf6
         FwLPV7l76oofCmuNYeYq+zALPt7IFTpOG7gwRb+7VLsT6/EGa3Z4l/Ch98ctpHC6E9eN
         XiQeCT45M8Xl88wVy2JpKyqgQ+LS25Oc1yJrfZBee9h3jf+LR0pPw0vbRqzlSxCcSpol
         /vFi4WyWxZU7F86iJXs+nFDTsoY0lcaB6Q+BqxUzeKbSbQSNC0sW4DMmOrbRsDMq/j12
         BBFTmqoksjnJ6X6eonNA17my1CDP9BD8tmAYIamuC+l0EPo66DBGArTDno0eEy6r0Fgw
         p5Bg==
X-Gm-Message-State: AOJu0YycRihuv+Cnd1sweEJtFR4PgM7s6n4lJdrBz2Jl96WiVgyscuk0
	i1hLyc4otGiVB3INvXynwwr3dZeJAqw3XJZfCJ9jDHDzQD+Kmr2YEDAYA/GS
X-Gm-Gg: ASbGncsOgsSa+zrmSXGnB4ejjIKeKuNgFv25O0WvtGO2u3CRXQ/X4Z+7rNhpVcJ5/G9
	RsBDkKxWpXMyrhqplLePmHbGJZ1KJCQHaVzdcHj30UFJ3dQgvY21VgNctUFv0XcZS7DvDpVR4ui
	hpa8xjM6y/bc3XVhjsrE5og/xJDsFdd4TFNthZqLCfwcQkLCdJHT1sN26Vk3176h6WjmFd+Ohrk
	7xI1nocgiF0W9bgrYHcP/vCCgigsNmW98a3zFUUI4KCUhLUkbigL40Flmeogho=
X-Google-Smtp-Source: AGHT+IF4+g2FrZigPg64oXeudKJc2QD9+5C5OCiXL5bEj2eQ9hsXX3YWpocuYm7sbTEvuP+Vjf48Hw==
X-Received: by 2002:a05:651c:12c7:b0:2ff:5645:1265 with SMTP id 38308e7fff4ca-2ffa7206d75mr8752551fa.41.1732270122774;
        Fri, 22 Nov 2024 02:08:42 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3b0b50sm756849a12.30.2024.11.22.02.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 02:08:41 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net,
	gitster@pobox.com
Subject: [PATCH v8 10/10] packfile.c: remove unnecessary prepare_packed_git() call
Date: Fri, 22 Nov 2024 11:08:29 +0100
Message-ID: <05989c2e2702226d470047c58fb0e0522df8cdba.1732269840.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732269840.git.karthik.188@gmail.com>
References: <cover.1732269840.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Taylor Blau <me@ttaylorr.com>

In 454ea2e4d7 (treewide: use get_all_packs, 2018-08-20) we converted
existing calls to both:

  - get_packed_git(), as well as
  - the_repository->objects->packed_git

, to instead use the new get_all_packs() function.

In the instance that this commit addresses, there was a preceding call
to prepare_packed_git(), which dates all the way back to 660c889e46
(sha1_file: add for_each iterators for loose and packed objects,
2014-10-15) when its caller (for_each_packed_object()) was first
introduced.

This call could have been removed in 454ea2e4d7, since get_all_packs()
itself calls prepare_packed_git(). But the translation in 454ea2e4d7 was
(to the best of my knowledge) a find-and-replace rather than inspecting
each individual caller.

Having an extra prepare_packed_git() call here is harmless, since it
will notice that we have already set the 'packed_git_initialized' field
and the call will be a noop. So we're only talking about a few dozen CPU
cycles to set up and tear down the stack frame.

But having a lone prepare_packed_git() call immediately before a call to
get_all_packs() confused me, so let's remove it as redundant to avoid
more confusion in the future.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index 2e0e28c7de..9c4bd81a8c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2220,7 +2220,6 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 	int r = 0;
 	int pack_errors = 0;
 
-	prepare_packed_git(repo);
 	for (p = get_all_packs(repo); p; p = p->next) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
-- 
2.47.0

