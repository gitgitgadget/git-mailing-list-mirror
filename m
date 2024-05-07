Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FFA6D1C8
	for <git@vger.kernel.org>; Tue,  7 May 2024 06:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715062812; cv=none; b=ewdrV6eZ5vCue5G5FGS0k9T3tw0X/8Fv8CgjBAjmxY0jJQOquqTX0unKopOzGAobkXgYRghZJSNqS/KmoogYO4fapJRkhtOIXo8nfZG1r428uWYQbdz17UQRufgvyG+6Kw/20Z61izUkh/4i93zZyf3QlH2N2WW3kR2/AC15uWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715062812; c=relaxed/simple;
	bh=zUcQThhRRIHYWkcSevtkmihMQnlvxFnrFD1Oe5BTHB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=obaEKeSKnZFXYUQLlbPGB0Qje99VsChG+V4Cs5Q6bNTrBL1gZzJ2pC46mTwRMXQx0FFD1S4zGFClp+2mkQ1An9jqC4Ox6BYiGV0phdd2VFrW11nwJfpfx60c8JpHA/PTs6dv7lm+mlpuFozzgH78ImYOqKhD2ZytrVkq5HpIM2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KUee2gfl; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KUee2gfl"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C49812F0DB;
	Tue,  7 May 2024 02:20:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zUcQThhRRIHYWkcSevtkmihMQnlvxFnrFD1Oe5
	BTHB8=; b=KUee2gfl/DCCodPUBQo42Ypb4QDE5AtrqsM7cleqINxa2i9ZflHQAk
	lCJyq0KcJ9kbSPsPVsUTruF/mEbe8DK8/qbep/c7mW5Ls1KFdP3NU/QdIXvV3HmY
	+xBo6ThZRGF078Vc5oZ5dViRV2e+aQSBlleW2Zm+8ky4CLgiwrgBM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BD4072F0DA;
	Tue,  7 May 2024 02:20:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 371D12F0D9;
	Tue,  7 May 2024 02:20:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 0/5] refs: remove functions without ref store
In-Reply-To: <ZjnCoaVP9_wuYiHh@tanuki> (Patrick Steinhardt's message of "Tue,
	7 May 2024 07:56:49 +0200")
References: <cover.1714717057.git.ps@pks.im> <xmqqikzu95cf.fsf@gitster.g>
	<20240503173553.GC3631237@coredump.intra.peff.net>
	<xmqq7cga7nzo.fsf@gitster.g> <Zjh8XWwJKp_I1dwE@tanuki>
	<xmqqseyu3ojk.fsf@gitster.g> <ZjnCoaVP9_wuYiHh@tanuki>
Date: Mon, 06 May 2024 23:20:05 -0700
Message-ID: <xmqqa5l2ta7e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D96F981A-0C39-11EF-A7B5-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> message. The best I could come up with is the following:
>
>     #define REPLACED_REFS_FUNC(func) func ## was_replaced_by_refs_### func
>
> Which results in compiler errors like this:
>
>     bisect.c:712:6: error: use of undeclared identifier 'read_ref_was_replaced_by_refs_read_ref'
>       712 |         if (read_ref("BISECT_EXPECTED_REV", &expected_oid))
>
> What is still missing is the bit of informatino that you need to pass in
> `get_main_ref_store()`. But maybe this is good enough?

What I had in mind was a lot more stupid like the attached.  For
illustration purposes, I just did only one, but you got the idea.
Thanks to "#if 0", the compilation will fail, the compiler telling
the developer "resolve_ref_unsafe()? what are you talking about?",
and the developer will grep for that name to find the hint at the
end.

 refs.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git c/refs.h w/refs.h
index d278775e08..a7e1c261ac 100644
--- c/refs.h
+++ w/refs.h
@@ -72,9 +72,6 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    struct object_id *oid,
 				    int *flags);
 
-const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-			       struct object_id *oid, int *flags);
-
 char *refs_resolve_refdup(struct ref_store *refs,
 			  const char *refname, int resolve_flags,
 			  struct object_id *oid, int *flags);
@@ -1054,4 +1051,15 @@ void update_ref_namespace(enum ref_namespace namespace, char *ref);
 int is_pseudoref(struct ref_store *refs, const char *refname);
 int is_headref(struct ref_store *refs, const char *refname);
 
+/* The following are removed - rewrite your callers */
+#if 0
+static inline const char *resolve_ref_unsafe(
+	const char *refname, int resolve_flags,
+	struct object_id *oid, int *flags)
+{
+	return refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+				       refname, resolve_flags, oid, flags);
+}
+
+#endif
 #endif /* REFS_H */
