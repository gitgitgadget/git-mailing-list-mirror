Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D58041229
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262783; cv=none; b=tsUk1k8knQIWSwKvV0aE9g1+sUVuiL2W5+3HERgsSLF9ffRsQ0wzYb7Hv41klHH7KuNFZmKOdzMPDvNe5KIoj08KIWDgyVq89RdBWA1SAWc9OCZAyhVWuqNsDjo7BuSFEGOmQcNYbpP0xf/oLSccNSQkA1zj45pvRD+Xn2wTncw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262783; c=relaxed/simple;
	bh=EfX6XQ5bS0CFf1/5bDZIm7zDC/aTYpdQQVLvbzkNVKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xuq6my8jID0mACPrOolKYvRPUx+8eHNZC2NIeARbH+wO9g04McRiTNUZRcWGcU1JvqMJ3jgvfqMt99sxiG3yEAQb2zYvq5ke/SioYgoBoWTeCv+K84V0cGQbZV7qKET4DKRBjtt9UZoCf8cCVksosVqXXi+SNMIzPMh1LsNK3Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QACjKB4s; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QACjKB4s"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-29e545838deso2724514fac.1
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 13:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733262781; x=1733867581; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BiyqBenQ2ZAytpRyyCPj+mZFnL8Cfy8LFiYYVEk6jLA=;
        b=QACjKB4sZFXZxaUKS8ovnLGE9950gJEYiFZsJPTZV8SeRESt70SvMAMhhPHs+zV2XP
         pdAh+PrYr09qeXCpDkB+qTaqLnNHpazBYl701YSU/4a/xLkkORnMSpfYJgkqgjeYajRw
         8eALKjBBEgaGgbkd5oI1tP5KFdZoOmuTFjuT/uJBGD6/0XX5rTmxv/ZaNKFHs4siVgdJ
         rHc5Pu2vJbubIQiKF8eAsCeScHLyMkyJE/EY6ynY4uVbFPwTPeMTeFVw487ZmgeYBgk8
         SLW0QNCuzEF8bb92R40ToYrqPNK0of/9l4QPwPQE1n4wboiIqh1DHxmrk+jNIvc+YOur
         j9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262781; x=1733867581;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BiyqBenQ2ZAytpRyyCPj+mZFnL8Cfy8LFiYYVEk6jLA=;
        b=w5T7qvFV3pXDJQ7EvxWFzqfWZYWMMN1AgAx+wcQFZAHMKHSKJ5BO0UiECJJlPnyIuy
         25dODYgPtOiNQn9q533rNg7ugPQTzS9Nz+nPzRBWHAhyNLvDb1tqGbtdyyqjQQSA0QIw
         R7VW3xguJrRxzhJFFbnCzNBVY1DD/XxHNYJHMaClpmzJirRmAOD2/TXQlU94DHUU7tw7
         Qkwf18PvWj64hZn0fB2eVzseFrQCAz+uw/1jImWXJcI8OqlyTt1yaTeu2xNM0Rq/cQ/7
         wgJtoFNAfzm8zid+bts7HvfVgP0AUHq9yo6p7oCdJned8jAfUzIGwnaLr1JgpJEnXIsU
         RLWA==
X-Gm-Message-State: AOJu0YylewPcVxgIWYH9rkCFZmEYCgMCroRhwheBSWKj91zUu0KWQIXV
	2Dk3btxHSpPgLaBueQ4mzdRhSwD6eWslZ9PCnMI38TNGDCHEyvd+2V0GKH2gOU3DEqV/cVbvlb3
	z/DtJ+wJyh/rjx6lXcrSnZacBhvfvdRFZNgktlTUq9wf+h5k9V1FS/Kz6BCL4xz3dKmZZg8p/X3
	f2kOpa5BvoNmxWluVrFrdVqkVRIn01coU9WvH0XG35B+hL1K+Wts0GpUoM++DgGjULJA==
X-Google-Smtp-Source: AGHT+IGJdrXqs470LbpqTh1L0Ye/c+EhhRLhVkh6UXVyue/8ZsGVmWa29yYPPQwSb2v3+AYnxeMxNr+5nfopqvhRlhrW
X-Received: from oax14.prod.google.com ([2002:a05:6871:a20e:b0:29e:2809:d878])
 (user=jonathantanmy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6871:2312:b0:29e:311c:f51a with SMTP id 586e51a60fabf-29e881ee49fmr3589880fac.0.1733262781184;
 Tue, 03 Dec 2024 13:53:01 -0800 (PST)
Date: Tue,  3 Dec 2024 13:52:53 -0800
In-Reply-To: <cover.1733170252.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1733170252.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <cover.1733262661.git.jonathantanmy@google.com>
Subject: [PATCH v3 0/3] Performance improvements for repacking non-promisor objects
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, ps@pks.im, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Apparently I did not save in my text editor (and didn't notice because
the code comment was still valid syntactically, so everything still
compiled). Here's a version with the updated and correctly formatted
code comment.

Jonathan Tan (3):
  index-pack --promisor: dedup before checking links
  index-pack --promisor: don't check blobs
  index-pack --promisor: also check commits' trees

 builtin/index-pack.c | 103 +++++++++++++++++++++++++++++--------------
 1 file changed, 71 insertions(+), 32 deletions(-)

Range-diff against v2:
1:  7ae21c921f = 1:  7ae21c921f index-pack --promisor: dedup before checking links
2:  5a63c9a5ca ! 2:  a1d2a20203 index-pack --promisor: don't check blobs
    @@ builtin/index-pack.c: static void record_outgoing_link(const struct object_id *o
     +static void maybe_record_name_entry(const struct name_entry *entry)
     +{
     +	/*
    -+	 * The benefit of doing this is as above (fetch speedup), but the drawback
    -+is that if the packfile to be indexed references a local blob directly
    -+(that is, not through a local tree), that local blob is in danger of
    -+being garbage collected. Such a situation may arise if we push local
    -+commits, including one with a change to a blob in the root tree,
    -+and then the server incorporates them into its main branch through a
    -+"rebase" or "squash" merge strategy, and then we fetch the new main
    -+branch from the server.
    -+
    -+This situation has not been observed yet - we have only noticed missing
    -+commits, not missing trees or blobs. (In fact, if it were believed that
    -+only missing commits are problematic, one could argue that we should
    -+also exclude trees during the outgoing link check; but it is safer to
    -+include them.)
    -+
    -+Due to the rarity of the situation (it has not been observed to happen
    -+in real life), and because the "penalty" in such a situation is merely
    -+to refetch the missing blob when it's needed, the tradeoff seems
    -+worth it.
    ++	 * Checking only trees here results in a significantly faster packfile
    ++	 * indexing, but the drawback is that if the packfile to be indexed
    ++	 * references a local blob only directly (that is, never through a
    ++	 * local tree), that local blob is in danger of being garbage
    ++	 * collected. Such a situation may arise if we push local commits,
    ++	 * including one with a change to a blob in the root tree, and then the
    ++	 * server incorporates them into its main branch through a "rebase" or
    ++	 * "squash" merge strategy, and then we fetch the new main branch from
    ++	 * the server.
    ++	 *
    ++	 * This situation has not been observed yet - we have only noticed
    ++	 * missing commits, not missing trees or blobs. (In fact, if it were
    ++	 * believed that only missing commits are problematic, one could argue
    ++	 * that we should also exclude trees during the outgoing link check;
    ++	 * but it is safer to include them.)
    ++	 *
    ++	 * Due to the rarity of the situation (it has not been observed to
    ++	 * happen in real life), and because the "penalty" in such a situation
    ++	 * is merely to refetch the missing blob when it's needed (and this
    ++	 * happens only once - when refetched, the blob goes into a promisor
    ++	 * pack, so it won't be GC-ed, the tradeoff seems worth it.
     +	*/
     +	if (S_ISDIR(entry->mode))
     +		record_outgoing_link(&entry->oid);
3:  8139325bf2 = 3:  f9f9969a8f index-pack --promisor: also check commits' trees
-- 
2.47.0.338.g60cca15819-goog

