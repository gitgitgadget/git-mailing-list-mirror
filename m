Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AEF1DEFEC
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 20:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733170731; cv=none; b=BctA06ndzxvyVPxaa8nCVCLNuY8CJ9kQzs5f5Uqwv0DfIrxpbN9XKojvXlm8ca7Ht7WaE00LgFpBDLqhQuonRxA5qV/SJMCIR6Za+2l704e5cQwKoFEFiPFqKA9cEUkmqesxSfevBF+uW3xr+WQ+zaDXAB4f7mFSLHO1C1taA7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733170731; c=relaxed/simple;
	bh=9lY1Uru6csBWMa7BmPw7olZn2suCdbZXbtEYPAbH/nw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qq4jSoupEqu22Va8IM7oldXqFqNC6j0sioTrJRv5g8X9nxwlaEvkHMDDJogDpt0JpCxqxlnIWRz0Ofo6spX8ma2Of+3QypFTVKWBZoqhI1plJoJVincXXrOLuUQzSowdVT8AyQ8B8jUGMvgFkqmnIDrep9JxdiUvDEJvEkH9ggE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wh0TBrvR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wh0TBrvR"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2eeeb5b7022so742301a91.0
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 12:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733170729; x=1733775529; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+yva30+shWkPJiuBPSI5WLlCeO3wOkqmni5AUcx+I+s=;
        b=wh0TBrvRqkKJM42hjzJEKujjTW4EuMt7L180NSk+uEhPbGSK6Gvi0Hz/XQo9A9ROvz
         Gna3muiyPEZAcIT3Plj1A5cV8l+Zfddn/G9XcKkUsmBXKLWLSNiKVjU2dpMHr7TZrEQj
         y72j8A6lFaZeNn1ythMY12TzAEe/yWDJYzK+SYVY56X6Y6oKtOuqLep8H4rQxjSQ2ztv
         NKYiJyr3fWHGtofo0pVEfZRWSL647NKy+p02jo81Hx71xmCtkKtd2IZWoZ5SWynZH2J2
         +R2eH3DW5aQx0fQuO9IUUcYVYHGBjWWUedDj6Un/6bhI2AGdnJTDNoZJn6OcoSLxNLVo
         HDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733170729; x=1733775529;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+yva30+shWkPJiuBPSI5WLlCeO3wOkqmni5AUcx+I+s=;
        b=FHNNKFBWFI8RfdPWHJ903NPaBweqwMoYrtNrwyWXLTencdPgMHNjR0eA+PBPqvKoic
         Hf/9pagSTAKVSkhkBrAoOjtpbybuJ/SlfsdXj2w/zAGEXKXAlhKDcFAilux7ByuyR/tc
         C8++y7Txdj81z8onZsfs/L4YVVXnqc8pTiitf3modFmwLNINJ8h4/8z5/Ht2oHCTJq8z
         IG5ohc/SXjO27jKvFkrbg3N+pZP0qRc0dQCdq1/ojvXUJxViDGg7FzeR+PG9ngzswh9p
         py2GuXasEUmupl2dOOj6eECnv30/Q6GzWCPhrcgWiUtlzEnjBlcNNbTYqoJxXUqr1/G9
         o3Yg==
X-Gm-Message-State: AOJu0YyvUne2yja++TsI2nSFcWB6fGuG+CJmESmMTXQyqrLJZm8YSqnZ
	LL4BXQW0dCVPXh2TUHgXQV2fiaG2FzSG8WKbBaDCkgsKROHgHONRRAjbkZpY7nkjGefEuVvIHJW
	bfK4F0Olj7gGmdiLpUi3OBGeZj9+u9N45wF7pLdDskbiNXYbpiPGs8XysJHRqvYvJciBZMI/80B
	TWK97sHERElnF0Ro7nqt92soQUJAfC5UIHT6RfMm/H49r+4QIscipTflvCsHwCQRZX5w==
X-Google-Smtp-Source: AGHT+IFHigklfKGIvj9+jfUk+0aEnRPUJw8G7nvLgvBNaLTdjuj21Sln/mKH7DU7uOeH8lJ64WMhGPG0U6hyPAndxwq7
X-Received: from pjuw3.prod.google.com ([2002:a17:90a:d603:b0:2ea:5835:dbbf])
 (user=jonathantanmy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1e0b:b0:2ee:af31:a7bd with SMTP id 98e67ed59e1d1-2eeaf31aa50mr9538974a91.5.1733170729568;
 Mon, 02 Dec 2024 12:18:49 -0800 (PST)
Date: Mon,  2 Dec 2024 12:18:40 -0800
In-Reply-To: <cover.1733170252.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1733170252.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <2f2f0db78bf85c14ef132e1924ab5021298aace3.1733170252.git.jonathantanmy@google.com>
Subject: [PATCH 3/3] index-pack: commit tree during outgoing link check
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, hanyang.tony@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Commit c08589efdc (index-pack: repack local links into promisor packs,
2024-11-01) seems to contain an oversight in that the tree of a commit
is not checked. The fix slows down a fetch from a certain repo at
$DAYJOB from 2m2.127s to 2m45.052s, but in order to make the fetch
correct, it seems worth it.

In order to test this, we could create server and client repos as
follows...

 C   S
  \ /
   O

(O and C are commits both on the client and server. S is a commit
only on the server. C and S have the same tree but different commit
messages.)

...and then, from the client, fetch S from the server.

In theory, the client declares "have C" and the server can use this
information to exclude S's tree (since it knows that the client has C's
tree, which is the same as S's tree). However, it is also possible for
the server to compute that it needs to send S and not O, and proceed
from there; therefore the objects of C are not considered at all when
determining what to send in the packfile. In order to prevent a test of
client functionality from having such a dependence on server behavior, I
have not included such a test.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 58d24540dc..338aeeadc8 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -838,6 +838,7 @@ static void do_record_outgoing_links(struct object *obj)
 		struct commit *commit = (struct commit *) obj;
 		struct commit_list *parents = commit->parents;
 
+		record_outgoing_link(get_commit_tree_oid(commit));
 		for (; parents; parents = parents->next)
 			record_outgoing_link(&parents->item->object.oid);
 	} else if (obj->type == OBJ_TAG) {
-- 
2.47.0.338.g60cca15819-goog

