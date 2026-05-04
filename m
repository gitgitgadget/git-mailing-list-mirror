Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF913E4C66
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916656; cv=none; b=sYtEItkBYtWjn696NKYgicqau/lvwal8vtHjffCOKPOefVS2WrJoHWUftMK7eJPUtV3oKBrfFaUHAgW6o613shJEO6wp17Ede786l3tiZai4N3A38jnbuffE739Z/8QNnbHE7ipsilolAkg1XQPu4PLYxMaIGk6BIXDsKP4nzrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916656; c=relaxed/simple;
	bh=Bd9D1VtCumIWZbzUepcLIdYdQCzftsWLcb8YxD/j6tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=spxojTzvIOCObISbe3m9Aq5KPPtFxDBX2UYEU39zg4UaSMS0ZqotAvvnIL+vSeX4wXNT0Ouzd4wETAnjG1b6NevOEsSvwHzdBasEedfj8RaQdiSG0hvuy3zMn0Mmh+O2i9eDiOuUy/frVEXjlRwOG02qhLZuFf5gzkxd0FOv1cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oHzTRaQq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHzTRaQq"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48d102471a4so9933215e9.2
        for <git@vger.kernel.org>; Mon, 04 May 2026 10:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777916653; x=1778521453; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqxDK3F1izkzYs5hfLTq/4I57uRGE1Q5vx9FCq5CFMU=;
        b=oHzTRaQqX3OAy+0NM2QplxRie4qwN/uQiUs7EBnzTK4z52sihopDs2dRHJiLZ5mOat
         h0aR5Zt4sqYHfYZBhSi6YdadARmNNeLkUh7AGOM8mIaSSQQY0mD0ImcucPRyyUU87G1R
         3ipdTcfUjY13XV1rwAMOqFMRjG0n7dd4QcEjLRoCc5+t9e0niWN1NGAF7cePj4yFy4x1
         W7ZHH8hU2iqoSFpnaVibJH9dLYdBoFMuJ1zyc8/vvyPqzkw6ggfOu7PqN6uXag6jdp+6
         udl3GGwPF7rFZ+umwgTuCbLMivL12mUJheZXPdBhjJclx9sv9tt+Yaqn6urJlDGzY0YB
         3YMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777916653; x=1778521453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OqxDK3F1izkzYs5hfLTq/4I57uRGE1Q5vx9FCq5CFMU=;
        b=fWtz5Smyrma0+Q9ewU2lN7AsOUk37MJ6peqNoe/NfihUV55rUKhSLyh36sG9E7kbsb
         K/yCFC1h7XlICeN7IDeJpQ+Ix1WB/kgJlYpfX9gklfxLKABOKmPMqu4YOP7ptuxCNmCC
         fZGBLB0GHg6FliHGGKQMn14Wx84xR5gNZf0IthED0r15gmJ2ZiV5tWd7XmkEBqCGjbF8
         eZFzoQQHazZfdYCajjrRJksfOzgSwf/Bzj7aTn4cqPEqIQ0pgb8/2+B4DlHWTdKxmp8v
         7UXLtffXHxFONzk53XqfEsNGJdTjXarfsqk0MChr3ZyORGeXTsgGxdzbvUSyD7+kT1h8
         V3ag==
X-Gm-Message-State: AOJu0YzvNKmGDCNxldo5ezWbqjHH5raZxW/2OcwDfAlXlykXBWrM0oUj
	hCpfQWRso+Af6S0yq3zuaBUhGA8BQN1Dmjc3bKOv5pIbpz/EDkIwwf9M
X-Gm-Gg: AeBDieuw0pdT9lsIVmql+W+qdEQttmsckHDRqGupYzrhw1ylqihgO9n8QnnZteHIrRN
	tsYVK6e//GQ9/0/vi7mbnd0MDzxuoZTScHTk484at7hy/b+/unZRuNMrPCnq3vV6Vs4sYNJ3ov/
	u3g8TUdTN4hXVpr4U1pZNJ1K2OppOjg7rFu+/Ns7MsS43e7goHLFlr3Sg+sdXgDUjrAskMOlQS6
	nZ7+CRevz9byak8kJyysjNeJwfuPveIxDh26Ng5hQK/H/3r5D6ydLkYQ0YmBDCzI9EeZLZhkTFZ
	VmKpyQWXGzY/g1Xc6V/9pzQRansPwkt7vedCeZ195ObZ9pOYEFI6xiGlePWLgd3GpZiw1p/4N3j
	C4KcVpWaZrT3PCbzjziS5+wo8uh6vK2IuvvS7RwEyi1z1pkyraAyjNjHMUSAXSFK5sYU6lUI7W+
	+akpOydP5557OtoJ3MjYHXstZkBOzTVZeGhnxqmpbR
X-Received: by 2002:a05:600c:6215:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48a988a9c49mr160815255e9.5.1777916653370;
        Mon, 04 May 2026 10:44:13 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1f8b:93fc:106a:20a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb75fc1sm299297675e9.7.2026.05.04.10.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:44:13 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 04 May 2026 19:44:05 +0200
Subject: [PATCH v4 1/9] refs: remove unused typedef
 'ref_transaction_commit_fn'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-refs-move-to-generic-layer-v4-1-936ac2f0b1a3@gmail.com>
References: <20260504-refs-move-to-generic-layer-v4-0-936ac2f0b1a3@gmail.com>
In-Reply-To: <20260504-refs-move-to-generic-layer-v4-0-936ac2f0b1a3@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, toon@iotcl.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Bd9D1VtCumIWZbzUepcLIdYdQCzftsWLcb8YxD/j6tc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGn42ugnOJ+BL/pSThqnPmJxXCF8adSBa6mfh
 a1OVDfB9kTRn4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp+NroAAoJED7VnySO
 Rox/o4cMAI2mtQ8sr3X46th1LbCGH0Y07WcbA6Q8iPvTtRWDH6co3h9UriUBHwolGwEUqrWWkmT
 6ePDGOzaau2bNtxtr/KrqR7Y9Z5ezanND2xGi7iS2hMa9b36hTSdbyr2sgcI0X0oHMeSQIMF7G1
 TzIGxXAqD1+jcjdb4ZT2OxPMF2G4VVhI0s4hBumrSQZz2QugsU1hWSAgtJAazIGNmN6ly6fQRX+
 e2zI0Pds88DytyzAbjhEie4tMHfl1MgznBbIfqGSSPCMzU07b/QQHcyfbnQRyjNCBESB9BwZYeY
 TI1ggCDk6JTxu3EiqyuP+x2zBvwK45HqdkOcdmP1JsZyw4m2R2ow1Nqj9d+eYcRQQECHO4UD02u
 xbtS8PNzcgwb+98y7Z3JmbdYkB6l1bAieqcZRiyCZQEYDzsCl+FTDQCBCvE0t0Z0xHqQoEcuhT3
 4kEoPKIpDbFY8x/05SLiDZcfiBryeQFYucl57egjzUskEamGpMQZDXFN3aKZXzxkBrM+ZRfbBY5
 LE=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The typedef 'ref_transaction_commit_fn' is not used anywhere in our
code, let's remove it.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/refs-internal.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index d79e35fd26..2d963cc4f4 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -421,10 +421,6 @@ typedef int ref_transaction_abort_fn(struct ref_store *refs,
 				     struct ref_transaction *transaction,
 				     struct strbuf *err);
 
-typedef int ref_transaction_commit_fn(struct ref_store *refs,
-				      struct ref_transaction *transaction,
-				      struct strbuf *err);
-
 typedef int optimize_fn(struct ref_store *ref_store,
 			struct refs_optimize_opts *opts);
 

-- 
2.53.GIT

