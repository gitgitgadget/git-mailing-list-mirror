Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356DB1FBEA7
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262788; cv=none; b=H1klCVif9JoCC1QxJOaGd+MZ3h7A8s52YRtrV6nGQyVi4Wu7++lBFArF1jixZ2eoolbBsYT4UGxg9VfCSC4I0NJhq9pIuafg50/n6Kjvc4Pt/s7hJ71y7L4uJUAPdB6SnMqEPacua3tQ7PAfNWKErtIUh0L2mBeT1Y8IuTTMvkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262788; c=relaxed/simple;
	bh=qRXNHc3e9qElHF+XE3Rmr8l4+eLxZnEpJc36Ach+4S4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mg/oHbeIfD/D8LAwCS27lHYBiMCVobiD00fZfyHp9ev84GEkCqjDXM/co4p7RZoLqRLvCFMWETX0HhoYX3ENgGHgo5V/EVKX+nBTZoVdLl8yb7GNMQOyQgT781DV/nCg7H3knTapAtDbWmbj1Ic4O15ztOkgX2vNqJ/QTbVq39c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jKXm4czn; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jKXm4czn"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7ee3c2a2188so4488967a12.3
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 13:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733262786; x=1733867586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ci6rzfBnd5EQ5ISlpqG5ZO5OAcQKCvNSZGqaRLwh/HQ=;
        b=jKXm4cznPGSNRug0Kjlq1T2HXWUQH8vBmzM6TGTgZ9tVSXfUseF6QYr8Rro4KRbKJr
         YUXpofdK82gxlFvTdw2Z3MXmHxzJWt7/qM2j4JfngixVkgMv76lw+1xCvz6dmRtw8g9r
         flW7kVhdzSUtfEfshxGqS6kEmQtGWp3efRJ+Wrtm7Xj60HXn78c/1bvGbHhiobTywPeU
         ycY9ildyBqN5lvESMkoUn2a3LE3iz50TQ9CBEHop5+xiDb8c3Ool0ruzsc/qEQrZrXJL
         vPaAi34n9pBdOY3sakHDNMRjBggkzXkrVe4KB7jWUFjYo5+tu23YL/BjwFFY3VkprcX3
         XZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262786; x=1733867586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ci6rzfBnd5EQ5ISlpqG5ZO5OAcQKCvNSZGqaRLwh/HQ=;
        b=YRxXMwFf8/Yfecve6HsNN2LMIABi0FW6jgSDO10lKYEzFoZFKdEnFmbPv5nT3ttfSR
         7kh8QcTkeXclbcw7wlTwNWfeEVa0ZUrzPKuMzGdsCjsK/3c8YakD9KJgFWYAYM5WjUn2
         tLe3MOgXWaaXpFlggLKe7WZcD+/hKLJIr4btvl/P1WH0Z7OKJ9ZK3ewxLaZUxLeFPS0Q
         bdfLFqwFoNpfNFxo9CjdsfDKlnsM8It6LPOcxntqoGcmWjfC0FmiSwPeJHbbxoWwAzqI
         ysbYUnTBw+AuE4nCeUItWFix4Qcxg4vQpHB96j/PnQ/pdiZxbnXLwrc+ikwDBcif6Rw1
         I2mA==
X-Gm-Message-State: AOJu0YyVH3WbgKV9+hbL5YSQNf7rFxPKWmcnb/7rWJYmcOQ4xgehSK3X
	xTW4np14fwxlHd4DPf0X6awzfdyMhhKeHAltg2Hntlg28LVozsXkOIPHTfjE5btDy6EYpUizM5i
	QqTG+ElSPDUAoupMA0Be4uwCUwuZuKAykbS5IKAOV7EkRAAy6Klpcz7D73UXqhfGp3RbhbyvH6f
	ihrNjNHQDWWqJ/GoD1QMK+XJsK+eGuOzbCxyNqoqPhlUhKj5Bk9WpPJCnKGNM4DQ0VTg==
X-Google-Smtp-Source: AGHT+IHSi+ScM7xkX+aZUq2QmZJBHF3UV9Ra71YJ1jmhYGcTBKa5w89HyJBfRF3eSmqS+dqfJq6+TPi32QRwSxJIJRPH
X-Received: from pfbbe16.prod.google.com ([2002:a05:6a00:1f10:b0:724:eb96:cf5c])
 (user=jonathantanmy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c947:b0:215:94c0:f6ea with SMTP id d9443c01a7336-215bd1878c7mr38472465ad.56.1733262786352;
 Tue, 03 Dec 2024 13:53:06 -0800 (PST)
Date: Tue,  3 Dec 2024 13:52:56 -0800
In-Reply-To: <cover.1733262661.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1733170252.git.jonathantanmy@google.com> <cover.1733262661.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <f9f9969a8f399fda701b0ccd44dd124e953bf36d.1733262662.git.jonathantanmy@google.com>
Subject: [PATCH v3 3/3] index-pack --promisor: also check commits' trees
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
index 2e90fe186e..1594f2b81d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -865,6 +865,7 @@ static void do_record_outgoing_links(struct object *obj)
 		struct commit *commit = (struct commit *) obj;
 		struct commit_list *parents = commit->parents;
 
+		record_outgoing_link(get_commit_tree_oid(commit));
 		for (; parents; parents = parents->next)
 			record_outgoing_link(&parents->item->object.oid);
 	} else if (obj->type == OBJ_TAG) {
-- 
2.47.0.338.g60cca15819-goog

