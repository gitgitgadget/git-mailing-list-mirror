Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A18E2F3E
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 01:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731807124; cv=none; b=ukzrPcokEZ6gUVLaXpc2KlHaMGLnv60b7rhYh45tkw45OYHRIVQj0DGu484Qdm8uNnF4qsT6yxU0yGzd8paylruJbvvbRhUwIXfuL7MTWrJElciQFdbMw0IokWKIC7fRcB6nUt0HZzjTcVKSvJMBoEUFrVnsk1QJj7K7dTnViVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731807124; c=relaxed/simple;
	bh=n1MWy4k/LdeD5EGiZ6Bgk/m0xBWfnzrleRmrl+B1Rjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkns633bvaH7wZV6hfhuFayEY2LjSTTZnZMxxNwNXzJl5tIRtbdfm/KK6A+uFbx+EfSfAy2kKqUZWOzs11gJiWyUKLgwIesJn1KHlJQvdYds0VbDm35OzF8DcBHkxEAdJfmjpNKzQxTHoTNkpSeH+vm0YXOY0uMbhtBGStxdYic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=l0rTxc+g; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="l0rTxc+g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1731807115;
	bh=n1MWy4k/LdeD5EGiZ6Bgk/m0xBWfnzrleRmrl+B1Rjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=l0rTxc+gIaS4MWR0Aj4qPrEW4iB1LyuojKuCDz/0w20AgDlyvCR8yk08Ga49LNwwj
	 nBeDhrIV/PwNnm6BtzEAQ3iFTyBqdMFm3BQw1zfGxv1TfRkIM4rA1zeo0i7UjZc5Pg
	 B7cFbpJzQUVo9S7c7+aZi+Uo6Q5l+0OryWB5hwUtHtGyZUfPryd3sLptLwDyJZpw72
	 uXFgeVSn3z1y921jkHtYFchMQ7BMiDgFWnkslCRLKCh8KLnRkcZlhOcpxcnFRRVBYi
	 +NV6J7DnbZs23BHKjbdEWKX5Fm38C8K0/0BDbrk5MhHK9g3pjiDVS63OQ2OWcJ+JZA
	 p6ON/M3x56EwW+oAZDI54tQvdpE2R4onmF8IR4FlIwbJsnqEnLB1X30iBgYkb6rMkI
	 hS29QgKeD0gjxuT5Lb+ozCHm0XOJVfQofp4STabFxpaC+u8qH0igU8qF+8AkG3R+AE
	 HVp2zDG3rEsabebNo7cHWpFoQXzXknidFoRQsRXYzKHm62mlEmJ
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4E82F24447;
	Sun, 17 Nov 2024 01:31:55 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sam James <sam@gentoo.org>
Subject: [PATCH 2/2] reflog: rename unreachable
Date: Sun, 17 Nov 2024 01:31:49 +0000
Message-ID: <20241117013149.576671-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20241117013149.576671-1-sandals@crustytoothpaste.net>
References: <87ed3apy2u.fsf@gentoo.org>
 <20241117013149.576671-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In C23, "unreachable" is a macro that invokes undefined behavior if it
is invoked.  To make sure that our code compiles on a variety of C
versions, rename unreachable to "is_unreachable".

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 reflog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/reflog.c b/reflog.c
index 875ac1aa66..aeab78c9b7 100644
--- a/reflog.c
+++ b/reflog.c
@@ -210,7 +210,7 @@ static void mark_reachable(struct expire_reflog_policy_cb *cb)
 	cb->mark_list = leftover;
 }
 
-static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit, struct object_id *oid)
+static int is_unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit, struct object_id *oid)
 {
 	/*
 	 * We may or may not have the commit yet - if not, look it
@@ -265,7 +265,7 @@ int should_expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 			return 1;
 		case UE_NORMAL:
 		case UE_HEAD:
-			if (unreachable(cb, old_commit, ooid) || unreachable(cb, new_commit, noid))
+			if (is_unreachable(cb, old_commit, ooid) || is_unreachable(cb, new_commit, noid))
 				return 1;
 			break;
 		}
