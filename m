Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C64204F77
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262196; cv=none; b=dMlQL89xckXoHl1ddShwBMcZpAlXtraNd6X1D9RWubYz9PAo3/AsOcF7NiS8D0TMUDSn0hA8w0xMFWnBTTas/xs4OdB8RQIUnWhdfsH1UpokAgWj6Ym4IgyCTKZ+IeCz9Q2A08e1/kYdtw6XCq88/VFursW5DyzAEVbI3XnI3ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262196; c=relaxed/simple;
	bh=BroE40RtbDZavwTRswNl3gbidmM1sFCYBZQhrLgpXCw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b019a8sCHZG/R/Hgzq1auXSYSQ1xY6V5TcLocxgbFCXTMDuy/hHZsK2nczIZIcJBJHZFnwKtkHRvW7iI7H+tgBaUGIBnwKWguuOAEP9kzgrbv+lLfXnRTimalJfTL3HFq/ZqpjUFeJTvjMrVS0t0f91MewnqVyNsZGvhPfHscz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YWxHAJy6; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWxHAJy6"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fc4206332bso4975789a12.1
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 13:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733262193; x=1733866993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gEyL3KSohgJ7u310j8UKmLEJ85gu8sPt/z2vK4dEjgI=;
        b=YWxHAJy6yX67NLaSRbRfGOyxRh/P4HuSnaz9jGn4iL5GRwJooWEyciY8EBo70sLtvY
         M9491kGf2JGJxyw3tG8szlSt2lmiNCBRHUTV31hPEiOLVRXgdRsp4IpTYXxZsvP0bUtE
         WQAaMAN5EaaJJg8MwCH7x/7vqK79Ur4uVftFcil04vEzUGXqIGRh+ZCzxKyGzGBK0wGe
         MoOyO+yvrCNHJI3wTpAGrS1FXz5CvJclESifx8/symwnPTVomUPZBLbgJKoTEcp83S3X
         te741tAJb32ZwzRN6TewwQuQqmS2gKb0Q/U1HbgC/BZAOszW2aDB6idjTu4WPYS9wzOA
         2ByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262193; x=1733866993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEyL3KSohgJ7u310j8UKmLEJ85gu8sPt/z2vK4dEjgI=;
        b=K59aIn8CEiDUOTY7Ab2bl777vOO8PXFhBX3A5Zm8NzoRp8IpRp0nvz8efVIbr5RKSJ
         +FWYuB1vZy8wEl8C487WKm7SbT8PfDcod6hbnnvwE5TxqJR4k1Kbdk4XsY9+5yyfbp9u
         a3VAnUnthMBjkU3IB+UhBqhXiVGqFYYzqDL+r6MIXb8URXATeYi/i8Ptypyw4IC1XrzQ
         Lb9ox9VtmwvEGu+q0Fi9DYnmMUmZogH69m45IaPWUqZRvgati+M0At7LPQgiz9ArTOEQ
         7hVRzIEXoiniF7U2fs6DmOPZMw2aaB9xi7JCL8VmR8J8ND0cLTNWRYTyvvNHYPtir1jU
         QRLA==
X-Gm-Message-State: AOJu0YyOlW+7VzbVsOkNCs8EuLpYsmT6jqs1nLAIj4qaP5VPzH5x28aM
	g5UXheQpQ2Dw+5t79F2P0nzsO9wUTsa70GGhbL0KS9cWvOM+L6xFLlaLBNqfsDqiMeFdo61Vet4
	Y+P9ZhoULeP0F6/mfVOEeY62Bp1dzeSOBeI0/kGfwyzwfVgLBml56zU3WVO9Qg+TmYSBBi8RR0L
	rjG55F6xj93/uNr0P8NgsPpv/pM/OwThprMX/QmKwKe+LrDR8KfCch4pTdDBlV+YzDzw==
X-Google-Smtp-Source: AGHT+IEV56MxTYepgI6oXDcS7Oz4zPmagD01iehHm/feR9kEmPsrI5LNmHVoO4n3QE97lKUx8eSNa1tVyQsehqOCrDZG
X-Received: from pjbqd13.prod.google.com ([2002:a17:90b:3ccd:b0:2da:ac73:93dd])
 (user=jonathantanmy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:748f:b0:1e0:ed9b:14f6 with SMTP id adf61e73a8af0-1e1653f3ebamr5854408637.32.1733262193135;
 Tue, 03 Dec 2024 13:43:13 -0800 (PST)
Date: Tue,  3 Dec 2024 13:43:04 -0800
In-Reply-To: <cover.1733259949.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1733170252.git.jonathantanmy@google.com> <cover.1733259949.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <8139325bf221685793ec40487c201be7103daad6.1733259949.git.jonathantanmy@google.com>
Subject: [PATCH v2 3/3] index-pack --promisor: also check commits' trees
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, ps@pks.im, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Commit c08589efdc (index-pack: repack local links into promisor packs,
2024-11-01) seems to contain an oversight in that the tree of a commit
is not checked. Teach git to check these trees.

The fix slows down a fetch from a certain repo at $DAYJOB from 2m2.127s
to 2m45.052s, but in order to make the fetch correct, it seems worth it.

In order to test this, we could create server and client repos as
follows...

 C   S
  \ /
   O

(O and C are commits both on the client and server. S is a commit
only on the server. C and S have the same tree but different commit
messages. The diff between O and C is non-zero.)

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
index 57b7888c42..2250a410e2 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -863,6 +863,7 @@ static void do_record_outgoing_links(struct object *obj)
 		struct commit *commit = (struct commit *) obj;
 		struct commit_list *parents = commit->parents;
 
+		record_outgoing_link(get_commit_tree_oid(commit));
 		for (; parents; parents = parents->next)
 			record_outgoing_link(&parents->item->object.oid);
 	} else if (obj->type == OBJ_TAG) {
-- 
2.47.0.338.g60cca15819-goog

