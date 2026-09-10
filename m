Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B0233CEA5
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 08:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029073; cv=none; b=YGSll/EdhuFXfq9OxEaD0kKNbbWA93jsilAef4oLeuxoz+o/kMWI7Hc/rQ7ug97kRcweypoktydL7Zq8ZP8WuJPzK2dlPyIxtj4lyLHT64FgHTwagjANmmag2l4JmOAVQl0f7ThotOz1D1UGTlxIhafZPase4B0YP3Hov27xK6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029073; c=relaxed/simple;
	bh=6F/n8hbPu7W+dP/vnWLh5Ezv3d7WhD54GPXLHU5EiA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxLb9fc5JvhBQjJhNAnPQel+Nb7oo439eNIx6+e9VBl3cD/ik9RILmWQFWu1OMHHyRMKMeS4+Jdg8dnN0wzg+TFxsuAEoT0u6Ke4zWkIvyX8A2DvkD1zZm60ppxX35pYWjhWXC0aslgDfMIm+Mifzbl0RmxD3Du9mQ3sYoV7o5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=HD6ro/Vd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="HD6ro/Vd"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso64795325e9.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 01:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789029069; x=1789633869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h08FIf+FQuNwNioBm0jVgdWhDq+xYashQ8AarukCBVU=;
        b=HD6ro/VdxX79173fLfWFg/jAUoUINmIadqloZtATn91Vn2XtWJl5LFOUkSGiY24XmH
         PGW3yqe0z7sv4i8DOYq98OiHhicSWHQgiB2JiHHBsHvhyRj4pRqp11Em8Axxqd3y5uzV
         2JJfDL7J309fH7sMozHXpgF46L5YkvTeQn9OEL/dB9+ugmvz20pZxKZFM1Kr/+jMUCX+
         QGhZuFG0zv1G0OqXOQrOrnfWtXdWoUWP2qbZw5a2xmcu/8wUXnERjtQp1uHdAZ3RxEFW
         ppvfylu4kVnsOsCQPe+yT0Xj9+QdNngpaMM5pvFKBXhwLv1c5yIPexOtClOCJjN+d9tG
         XLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789029069; x=1789633869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h08FIf+FQuNwNioBm0jVgdWhDq+xYashQ8AarukCBVU=;
        b=SArEVPLgKFB73QV2MPEbfSA38vY2d9ODO+9vHJ3v1H4o/uYMWDjr67zG37Zo+mihf4
         sTzFtn2KF5H/4tbKKggdo/2KqON8oHcvUm2dm+hI0IhCzoNAv/vG/zpacwWPQjqCSChc
         mIBUWui5yuSDab0u6PfecihPvuJwJBVmzOb7fUgpxBu0SjkQbeexsyHZvC2GRj1aT+sQ
         BCG7CO4fNTGh5r/WRg1S2wrCu+mTYbTHuwyVhOMEAeM2omvrnEAHsmI/NV9oLT1NyLHs
         jvh0NbcQHyyovvLziaCyblVZvb08wC6vVtVYQNTdZvPLsa0DY2Jqf1f9MPC7IeICHtSb
         HqDA==
X-Gm-Message-State: AFuF++mZwkFJrMa9H0yK38Z1F8hIoHbATCbM/Q7u6adHBho5TXb0O6R0
	6+3VPR+CQkkv2SnSGF/1xoHqffSlxdqiLVyXluqCWG9dJGzuLxsk51eoeKg5bA2MatLViT3D11v
	k5CZ7bgg1V/+V
X-Gm-Gg: AYBFou27ij324qzU7oqH+sOR9JWiIDMx0FTeR/WkLIXALBKhOMq2ZbdPKEf2aOGRDrh
	C14d6K+W9uMnSgpY6P/bTBlH5rEwocdUyaRFOYlcqiPAAPJBJjAksdQxLkTmowTO/O98qfvAbHP
	joVznOTzIVJRTNjnggIxRGfXgnP2K8FSBa3Z1SWg8Xlc9IEsLSZ7ySP3jrLGgvrefVBqgceFedH
	RrAkIYQyrg//gWvqvl1mXfzB/pI3oBa/0EUVXzAU9id8S+SPNEW6oH7upD9WNRZDpx4ROGtgBCW
	uCub4dBR3+5JSbDLK/5yUosp8CgIOAxoY0cFQMTCVZdxlPMPUya2gMSQXDkFM6UlWWp2KmZPRiB
	UMHC9AdUvSj+4i8KRYG1XzpaDXJbh4an3oikjkqbQBJCw0zGdoLLQ7dmptRLagi4rcvxUzdymBo
	uBcVAl7/Mh4l/7wIWDgRo9t2+YkCi8reszB7vzhQGBIhigZmLWNuAxmarCAhx5UaU/QIVgrkijl
	w==
X-Received: by 2002:a05:600d:8498:20b0:49c:cee0:f383 with SMTP id 5b1f17b1804b1-49cf828c65amr283348715e9.16.1789029068854;
        Thu, 10 Sep 2026 01:31:08 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20da3354sm92699575e9.2.2026.09.10.01.31.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 01:31:08 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Aleksei Sviridkin <f@lex.la>
Subject: Re: [PATCH v2] push: fix --force-if-includes when remote-tracking ref has no reflog
Date: Thu, 10 Sep 2026 11:31:06 +0300
Message-ID: <20260910083106.88960-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <xmqqv78dordu.fsf@gitster.g>
References: <20260903010547.85469-1-f@lex.la> <xmqq5x0mfgyh.fsf@gitster.g> <20260904124433.12840-1-f@lex.la> <xmqqzexx58hc.fsf@gitster.g> <xmqq33vn5hsq.fsf@gitster.g> <20260906165052.21780-1-f@lex.la> <xmqqjyowz9oq.fsf@gitster.g> <20260909065639.47316-1-f@lex.la> <xmqqv78dordu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:
> Sorry but I am confused.  Your sample below is with 20000 local
> reflog worth of activities, which is hardly a "quiet repository".

Two things got joined there. The 20000 entries are the worst case
for measuring the walk's cost. The repositories that keep entries
older than 90 days are ordinary ones where "git gc --auto" never
crossed 6700 loose objects, and that needs no configuration.

> Doesn't that mean it is more logical to use the default gc
> expiration timeout than year 1970 and in any cases using the usual
> gc expiration would not waste more time than using 1970, right?

On time, yes. The cutoff never takes longer than zero. But it saves
time only by ending the search early, and ending the search early is
what rejects a valid push. Same repository, matching entry 200 days
old: the cutoff rejects in 0.086s, zero accepts in 0.322s. Where the
cutoff cannot change the verdict, both take the same time: 0.070s vs
0.069s after expiry, 0.319s vs 0.321s with everything inside 90 days.

The cutoff is faster than zero only where it gives the wrong answer.
If that trade is acceptable, gc.reflogExpire is a one-line change,
and the commit message should then say the fallback can still reject
a correct push when the matching entry is older than the cutoff.
Your call.
