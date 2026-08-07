Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC5D3A6B81
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 04:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786075367; cv=none; b=tHgJa4hr1s+pkIavh11NOMS57lWELzWUKYABkBjNIrEryC1QjJuOPuLHqKhpmYDZmplee0ZK9ZksMxcRwXgVul97k+vrmZ6cd/IxwxJDeoADLLiPLnbVMckbfUXwbyMP/XR1LxEJtnUrZvqc40r+W03T80VLjrZXude6ytU/EnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786075367; c=relaxed/simple;
	bh=7ZTCyAjTfvNqqx3EAxnBt01DydBb7kj6WglX+u/kTAk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f9jf7WULPZ7fy3gZZ73drtP7pYENhDv9YmgckKM8h9pvajN/u+qgJ4j4q4xttMCtPdSDOAAQ9Rb556BTzzngVPD1/cEqCh6p5qVKy8IX5FWHm8qyI7uZsrTovV+qOo8lfjnJnCvVksyU1JL7iDc+Mt50ikBwGpRCOIXMhuqmoG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O17If1uO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l1d81mwW; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O17If1uO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l1d81mwW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0542B1D0006E;
	Fri,  7 Aug 2026 00:02:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 07 Aug 2026 00:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1786075364; x=1786161764; bh=5w86eBCUCqzGSRtH1f8vSGWfC50kGmqS
	gf6An50RAK0=; b=O17If1uOejB/ZvGsEPepWnLNhvPAUzIBjn3bXBHfOddlO5ja
	uCPhvGHT3/P1cxTYwCZqYC19Ld32TGN0gjeGPQKC6X7KnmjYm5ekIdxIhYcrCgt3
	NvarCJrDW/GPBVcoJwDdpVOZtbDPz1MHRXJbx3mtOB16x1UtNkaZx0tQmQnJ8W2U
	8igmHQJvtWOG18KPxh72/uDX+BFR99N6qqHtr5ULc48fK77rkVIl83VDnjtaOovs
	EgAFngER5GACLrkji1kcXsEFIYLH7i/7NpQSi36IZkxsX41KUmb5yNjB8kvz68Mz
	G/khhjxHzVh81RMRiRKZzi2//GknMbOeWn027g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786075364; x=
	1786161764; bh=5w86eBCUCqzGSRtH1f8vSGWfC50kGmqSgf6An50RAK0=; b=l
	1d81mwWCyQrwtuSB1/xEDK607D89ZK/FtcASNqVMqBqfp/6VqRRuOcsbMITLQULb
	CJb3ZegTFbznNXuOUSNO8j8N1lKnqoH6ywgjKVTvH0QyBQ6XOI0KbHvob/mBnhVs
	+8UNnUiQv1jmtmvjtfeTiKw6qGYaNbU64LLETsoPdzLoKJvpv9JHisINZhSp+muD
	a+BrLUJn0Z6GOqN19sqGJ6wUM2aNKr+i21wTFqpLzNLSPMv3Krb/VoozTMR+khOM
	IC+scTd48FjGoGYP0ttzFWynR+tK21cwDzUVVrXPG00caUl+1/xt97vbm0K3sRdb
	w81W1FYCgpqDfPkESFKzg==
X-ME-Sender: <xms:5Fh1am4_Ccv3kHIxnVJikzm0eytREWJX7efV5xpjojRfwo3GclyGAQ>
    <xme:5Fh1al516HeFtPGFu4GkaFYqNiJubF_AK1DIxYvICUXX3yHfaI36EbF33aCTHK70E
    VP-StF4dYTkX4UrSIGjaJ0Aa3czkLnAvAxWWcTScPzDGMjbOBtiTw>
X-ME-Received: <xmr:5Fh1ajFjXdIfnIimixjVIRQNoKxB_njqoQRhGHXyC69EBcxT-DWWgKjufkdRv8ah3J-mKz5A4u-H38PjeLcH4ev7F6BQlsN8Ug>
X-ME-Proxy-Cause: dmFkZTF7Y4l6jgj9FCdHUILYr84NxB1DMmKmvryVOCACEqybThzlK5Td+LSggLuxwRyinD
    ozx+Ag0BfbSJ8qey47LHN7A5xztZ6chC0eURJ+9NWQ2XkGxS85/k/lQybndllhKTqmIgyZ
    XFis1kdMFqHIl19CrE9GpvwKMhSoetG0cIi0u2MmToumt2IRXAEmQ3vH/6ifHc5apqcuIG
    LVvmTB6oSKCjBvSIJHacCTbMIxu8AjTktkUVB5XKXAuorDFkntJUwdYG6Vp4/AylTjjrsc
    c/+Z1XvA7pj19drso4Hq0gQNllJ18+/wSziM0x9KczQzEL3QuSUfPXBlDmbm+REjQPQZCp
    9S5rZ0gC7yYdhJ5wR8t3tKOslmR1mFyLQpi+4GcBgFUqh88etBBds1e9fbjSNlwFHgRnAW
    S5I2jWf3llm3hA+AM7NKK11csAcNC4QpAEXgC+Rvyjw97Avq1U3o0olW9tnrff8XBbtuvA
    yXxDXoLAalUjPDrbXaVmX6zSQwN38Qt2swoJiT0Wk24gth0akVSyf2UGmLU7CUx1T71b1u
    IRVdtTWsoM4L+6OLr9ZDupsog2fBiYMkA2GFMoQexEFzhYC/VCRmyWaYWmhgXWYqrmB2hW
    HkhpSYpcJ+8wIAxemJrIwApF1a0K5B5Fo7+/iuuPASrRoIZQaASSqwCgR0bA
X-ME-Proxy: <xmx:5Fh1auSK54-Efn8GvzHZnoF7f6baIoz640y_OTnVgjBVVRgY9JMOsA>
    <xmx:5Fh1ast4VfiaHVtAJQObGHYAUkhM455bR0IaW7n1VHRvQmYEb-w82A>
    <xmx:5Fh1aty7polalwwv6TFMYe0r7N5nEOQONkQg8GK2qX-ksNnD8UiugQ>
    <xmx:5Fh1am5XKjvtw_BpzrcKKHlPkmHfNMgsrBLCivyKud0gnPDeeUMYDw>
    <xmx:5Fh1aqScyDNMetSwngz69xtXvDLsAjyHNqXRFkHNNJtcTfioKvvRzz0z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 00:02:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Can we do better than "git checkout/add -p"
Date: Thu, 06 Aug 2026 21:02:43 -0700
Message-ID: <xmqq8q6ih924.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I am doing more "git checkout -p" (selective revert of local changes
out of the working tree files) these days, as well as "git add -p"
(selective adding of local changes to the index), and what I often
wish is to have _both_ as possible options in a single session.
That is, the local changes in my working tree often fall into three
categories.  (1) One that is clearly good, (2) one that is good but
not yet ready, and (3) one that is bogus and should be discarded.

"git checkout -p" is a way that is very suitable for (3), while "git
add -p" is a way to deal with (1).  To (2), I say "no" in "git add
-p", but there is no easy way from "git add -p" to say that the hunk
is (3).

My current workaround is not to use "git checkout -p" and instead
(e)dit an undesirable hunk into a no-op hunk.  This is serviceable,
but with two caveats:

 - The underlying 'apply' machinery does not see a truly no-op,
   context-only hunk.  You'd need to pretend removing an existing
   line and adding the same line back.

 - (e)dit applies the edited hunk right away without giving the user
   a chance to proofread and approve or reedit.

