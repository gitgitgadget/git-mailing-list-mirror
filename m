Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00DD3D3CFB
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460996; cv=none; b=d2NCjFQJoMjVhUnDG9/kEOu96Pt+w7BRtXLtmef6ZkttkT8P//LY2M9okgVH4ePXO2MNKbEpL7zZhSvfSOoebgsvNSzpFv30Cg7FCYo+WHcnbJ0NSCr1zfDAJs+TtbUwHko6R+bBPDxGQMp3J8jaYsmONBeZ1yM/dVsUiijWe14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460996; c=relaxed/simple;
	bh=jWAhLLPlfyUJvWrV+0I5JFLayOUtI6+n1lagYqKYHYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/1bo88J93Np0gzw/KGd+8bkPnxUWhKVNrKMcMsU//bRmw1xr2TCXn0sKbsMb6zQBeHGcrr3aJhtXmmgFxms0FPq4LAUAvGXR7s+6por+0Jlsqs4+3ffL23n4xRJJbUQkLVaXmqkRGsRIPwFwWMjpUw0gMQPqI9fuh1w/eeujTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vq+fmAKr; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vq+fmAKr"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb752so2964978a91.0
        for <git@vger.kernel.org>; Tue, 15 Sep 2026 01:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789460993; x=1790065793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MlBYvtz6uTOrCM8SVQRMh9bnlw4JBplbBR7M6t55Sjs=;
        b=Vq+fmAKrNyEdpFBEiiTDeuX2pxYYZoj/t4Q7owMxNIhXy+lL58supxRDMp9VwqwgDM
         Dz9cbykTJzbLCoJy94EPuq2S086FjLEmERK0t868TNUMo753EfJtYxZwxH7MSceCFF7N
         ExFi3gjOd/6cK4niD8bG2P4juKdmRrALRMw/6CXcTb45GDC3UtiKci7P4T4V0fGjycYD
         g1/io8L3PcFJCoJKCoVqb+MnVkONsBF4LvxkcS1wgrscZwWVH0nbFk2AD9oqTJxPu4S+
         Tdr0UEBKaaZqY+AcoWEaRS3XTGYVZLApkWm3DjtzaGyLoHLa8eZ97fyPInDMaDVY6mOP
         90iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789460993; x=1790065793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MlBYvtz6uTOrCM8SVQRMh9bnlw4JBplbBR7M6t55Sjs=;
        b=zBF7d0BHj/3risHFRBSAnZ3qMMCIDYCG9aYOnE5IFgLhaQiilTVYQZnm/EYlHybzfn
         yxhCUIj0v2e2ubOZ2PEhd1Tkuq5KAe3AHeFP1hZwirXQlstPYLEQSaRtu0MIR2+/ESrG
         KXGJl1cOMmREyEcxptaw8o7fjafLlDh0ycHSQfLTmteplI8q47dTmqlrwzw0CsHJS3d8
         0UEcsqAwx7mETMdSZAeIFJif7e/f/yTaQx8wgtjOewwnSby5mqnAFa6/dQbDs5AvXCuy
         o6ZXe2Ee8HGZP+8UJaHqj4HNj2ubD9ByLXWfAfTouaLqlk9yrvEk5HgXySVEmnAcvtjj
         XdzQ==
X-Gm-Message-State: AFuF++n+nBRkrQXkzb8IkJQOLX7gBy9JwpGHlLSgIttTbT3gd+Y0Gmtt
	zHD0udzzGrLg8ODmDksVNNnQMG9ySu3n0xYlnFXq2RyLf+6KpVEhlg3f3f8BP3NJ
X-Gm-Gg: AYBFou02ICYJMLnBx4FW+Ur7drzcSk5BN3qnqG4Su17FetsFHeoUco8l1KQHtc5t7ts
	EKYIExJwIHk2eefY4HoHSHl+ooul5avPdsJKgCN3CN37p2vIGB411F5mFWVUk9XGuiZQQEedVLZ
	YixM7ehp1otZUZmGMD3NhvqHTqcZRHySxe2dtVlZwCYjksouwrA3Jxchs9VMHqBXGqe54kdczhp
	6jVR1vJaib10+Z/9RVsFotWWCumBn0Rrrv7sbryGoTTHYyEqzZ0fSFdJP/flRjXJR85Lf1t4K6R
	8FD1O/iOokfElp+AscxhLH254x9bwbXD0g0tV6ynrjhVx0iYsLz60vs+zzUKb/m3Rpi0lFkWSk3
	V6aqH7mDBcM0K47KdddMXX3ZSJCIBaFXk6O3vXkjB2U8F0zOv2uSBzmqFAJuyeFqBuyT9/VV201
	jksJZD7LY0qZp0XHlp3VM7647eTNCLmF9QF4SaqjnHHiykCl9K+EQiRWDF/ykHiTvIthrYtTp+i
	76Js4X1ChD8XG6T7REaH4q2n0I=
X-Received: by 2002:a17:90b:560e:b0:39d:fcbe:fe00 with SMTP id 98e67ed59e1d1-39dfcbf8110mr7804591a91.22.1789460993264;
        Tue, 15 Sep 2026 01:29:53 -0700 (PDT)
Received: from ksivaraam--20260831-PCX54 ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bc03778c7sm22650851eec.9.2026.09.15.01.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:29:52 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v4] builtin/history: unuse the commit buffer after use
Date: Tue, 15 Sep 2026 13:59:36 +0530
Message-ID: <20260915082943.117985-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.55.0.801.g894675e619
In-Reply-To: <20260910150021.348548-1-kaartic.sivaraam@gmail.com>
References: <20260910150021.348548-1-kaartic.sivaraam@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every call to repo_logmsg_reencode() must be paired with a call to
repo_unuse_commit_buffer(), or we may leak an allocated buffer. We
have such a leak in "git history", which we can fix by adding an unuse
call.

The leak-checking tests don't detect this because we only allocate a
fresh buffer sometimes: when the message is reencoded, or when we had
to load it fresh from the odb (e.g., because the commit was parsed
from the commit graph rather than the object contents). But you can
see it by running:

  make SANITIZE=leak
  cd t
  GIT_TEST_COMMIT_GRAPH=1 ./t3451-history-reword.sh

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
Changes since v3:

- Replaced the long commit message with the concise one
  suggested by Peff.

 builtin/history.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/history.c b/builtin/history.c
index 091465a59e..0e9259b5d7 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -154,6 +154,7 @@ static int commit_tree_ext(struct repository *repo,
 	free_commit_extra_headers(original_extra_headers);
 	strbuf_release(&commit_message);
 	free(original_author);
+	repo_unuse_commit_buffer(repo, commit_with_message, original_message);
 	return ret;
 }
 
-- 
2.55.0.801.g894675e619

