Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB238945D
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379226; cv=none; b=RfKczNz2ixf8wXBQz6LAsnkTuxoigWJjl+rT2akVpoTcsluc0tnQnb0w/JDCiExkhGNBavHGEpQTKTmzOQADlVJewYASoduxbqzUA8gpYElR+x9G31mJAKCp1FdPmSF1Fknc12UTlwghftnN5bZo5mfojjvLASDzNWUy0Wb3X4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379226; c=relaxed/simple;
	bh=zQnGBk6jLv8y6nhWiIGyr4QYTvNDkWhDKkjtRw12lbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dScoSk33zYaMnsOZn5D6le8VAyi8Um3IpXV6rqEio6i6+GJ4ly/1wD7PF2VT8degdkST5Yc4pNTIo5v/tAf7h7Vq8uvzEHEuTy10P/MnM9iIKiaEjG7kndW+AWhAhNx+U0Rh75HCE2vKSE00EVAG0AOEppmYeJis5OmNjc1SRJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l7PkyIY8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lYCKLd6V; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l7PkyIY8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lYCKLd6V"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id B282D1D0011C;
	Thu, 25 Jun 2026 05:20:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 25 Jun 2026 05:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782379224;
	 x=1782465624; bh=Rr+8rbYtzcZ3OaSOg+SqRlPOo3vmK942WvH5x0tVTTc=; b=
	l7PkyIY8e+3K/ULteTuAyJCs5N5eTR8TA3t+s3G9xiBrb2rB9CWpxATIDqRVPIhk
	/XZPu+wUE9oig48lpyX057Ihbr6iK3TrtukIg1nOF1yzAki86Y4cXQZ8fzggesxj
	3meDyDdULJiZXGMmDt0maYXVaNX7dY5r67seU0oFLDJIMOSUOPRBoiEHVu7kvegG
	UUuBUxKvYFMsm4nLqIr4GclcMahrGya2aAS9C71KgXqVJe/JMPLGTaA+IIDFT49V
	Ac722D7+XU1aMAa/Svmduu4hjphI0/oUDP+0Qri9nQ4oj8GYVxZLzJ8LuaxrncyG
	BQ4IrTRjmeDM5wgHDmJxHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782379224; x=
	1782465624; bh=Rr+8rbYtzcZ3OaSOg+SqRlPOo3vmK942WvH5x0tVTTc=; b=l
	YCKLd6V18un/LecZrPROgLb6qTffMCxlNSHamDqx505ZHTB4ByZmX89Iw+yzMkrV
	yZ8KNxvOLoQIxycuWv3onxRfTBznUZbQMOQlO5FdryID/Co9vXCmR1IHqGr+Xm+O
	wc6kLw692nWh1FjOzYwbrFsrl2Z5m9s3ZlO/sw/JVZVcySx2L9v1Gj/l0LfCBy7V
	362+J7DzADpvM+ajrTJwiHdhJlFDS4+pSWZ5MTn4xqNKV8P76nmanTJqSA0x08lJ
	1rkJLg6HHugj3dSQx4sNOy0X2BOcg7vqmTLnsNzF+8AV6IilsHC1T6Nz905zHJa4
	B5SJpE3o8J3ntKtEOkQdg==
X-ME-Sender: <xms:2PI8arImfaEXSEENCfFZE5yCWNv8at_36su69qW9ZQpeYrZT8iKwpQ>
    <xme:2PI8amImVJ5pUJt-yt_06FsgnMHoOmKx7oTySusnB1xMM3HEwwfNznl8c6AsI5z3L
    pDAdVuTv8Ee7i1x18m3SHF9hRdPime7ex4y-6Gjbu9P2a9SkIGTdw>
X-ME-Received: <xmr:2PI8aotxktDoNn2AmPqDYlbaxWx82McEltw9SFlDqAiPBGekVY5KCJyqbPxCExATyKQ2YGcuKdvMGLbm61VBal3eT-XKjN64nKdeXEVKcA>
X-ME-Proxy-Cause: dmFkZTFzlA8/OYSAgubyOyvTi8s6d2UvRcFBbO172JGf2lUIYBi3Bjy3bbAc+CJVkkpsop
    Nt5MeLo5oesKQJ+hXo2hdMucq8hcHRBXJ3LyGZglRB0OSIuXjnKjKj5hmMQ20PR6ACg7QZ
    oPgkfrQHzHENmmz73M6EBzmbXrtWS2QLhKeRWeF5A7q4YolgUfS+XLyM6mtvvUfercYV8z
    qh3+ypn2rGiKjowp38FrBu+6pVjbXpUnHq05yC/MaCCr71Wru33YjS5pjAqw9i/t6xtq+T
    SgcooDrkKUH5rMdrHwuIRBczxDOm/JuweZ8wOpTFp8TbRo3vMXcQMyvckdItvX33iIJQfR
    UnkZmSvG/58MXj6ICiPDY8FR+mgy1eG62gHo95cssYOEz9q4h9iZBWCfLlCygtzNHRxmoo
    XqLAnZRw0Y0vpp0qG8g8em9xJWVf861Zgtki8T7qU59f2sRATsWRq01l2j69aI7MF8vqrR
    XYPa7VC5X5pSwcTo9n1EdH9gslp66QN7ol5gEwmU5Qrx04DHH2k5e6lh+oeKeOJgrJKOsb
    sztbE3oCnmsNy6lvb7vRwkoLLZ9mDQg8Z6hplHB9QVx1vx/7jP6UqPdwYHwzMFwfRpBAmN
    ij5+qKOmjkBu1CPkC6G3Oa5ERg3A/T8yMleKYXOpqHhVs0bM6T7pw+xLh1tA
X-ME-Proxy: <xmx:2PI8ajRIoW92f7lU_M0JLadEbC_zJxZ90RLcmQqNyKBGbx_76LGfvA>
    <xmx:2PI8auOru8Pfzd35C2M6LFd3q65q6uWAnj49Hz5EMmGC1mJusrrxrQ>
    <xmx:2PI8aoZvMJF6k74MiKst7NkdGRUST9b8sr-x6lU6lgsrA3BbKaGg3g>
    <xmx:2PI8aozzROHrxh03NLetXy29vnb_-sBsxVN5Ca6gIU9NFBDgJgVg6w>
    <xmx:2PI8auy2KPO0K1pkt_zi2f5f5ZgszGKInVTOlNlTCgRHIF1sJOP-jrD7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 05:20:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a4882106 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 09:20:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Jun 2026 11:20:04 +0200
Subject: [PATCH v6 06/11] repository: free main reference database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-6-41fbca3cf5e3@pks.im>
References: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
In-Reply-To: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

While we release worktree and submodule reference databases when
clearing a repository, we don't ever release the main reference
database. This memory leak went unnoticed because its pointer is
kept alive by the "chdir_notify" subsystem.

Fix the memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/repository.c b/repository.c
index 187dd471c4..e2b5c6712b 100644
--- a/repository.c
+++ b/repository.c
@@ -421,6 +421,11 @@ void repo_clear(struct repository *repo)
 		FREE_AND_NULL(repo->remote_state);
 	}
 
+	if (repo->refs_private) {
+		ref_store_release(repo->refs_private);
+		FREE_AND_NULL(repo->refs_private);
+	}
+
 	strmap_for_each_entry(&repo->submodule_ref_stores, &iter, e)
 		ref_store_release(e->value);
 	strmap_clear(&repo->submodule_ref_stores, 1);

-- 
2.55.0.rc1.745.g43192e7977.dirty

