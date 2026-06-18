Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DD330CD95
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781817894; cv=none; b=EXOFXaEtqShBdOlmXYc4OD15HTssAd6GvfZQqFxY6kjSOuIbOTeDZvx6i6YGI2qNZcEisWpUB9sM5ZXIYNgb8lkclM51Qdg2/ad6INzdCVmYO/D8IVaF2wkiKFPUTzDlQeweJkm6TEKfgynfo0B8N5OaIblgldL5K5iJb+J+3ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781817894; c=relaxed/simple;
	bh=lDBxxjch6efZECNvsdngrOjQy7f5D7FOLtg5rLbkA18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fYN0di0Wuusn+Ow2hpdCjYDG1kF7EPeTWshLQ1Nn5vAVtAXWcqGHW0ziCqjUv3n/N54caM0aO+rJllfM45nXjuVejS20TkJ1Oi1kRwxeW1Ps6G/QbMkWdtUmS7o5ypSQ3Abbl5su+yjL/bLn04hlwZsmawNm86O4mtWHjLmvr2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PlgfxXIF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NBcl6KnU; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PlgfxXIF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NBcl6KnU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BF4CE14001AB;
	Thu, 18 Jun 2026 17:24:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 18 Jun 2026 17:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781817892; x=1781904292; bh=pzeUcCbM5A
	I1wrRCh77wZv6ZK96wI++foZIolipshs4=; b=PlgfxXIFnrge2SNCvd2lg82MAg
	ltnUCtKlbTWQCB0yTCi81suiWu9BszTRoSWUGcqXcG2EoQY61FIGyPrOvZ4YdeDj
	1H7Eb1mL9+eyFsKOzuMvhQ06+aeSf0rUSVW9vbqJXp00je3FrA8vvvp09ImC63Kj
	QCdJQvDvpPHeCfLjEzY5XjpiAE5m/YQ+3XYPXz741/8wvP7iYmdCGGcH5FmPnYTV
	QcRukOkT7/FLLP5JYAXozVg/ShP2i0dZ5lJwF6vlhIBkL50H2EeQ46rjJNqQs1oN
	cVe0svhRAobD/Ekiy4GjMseB8erwT2vEXIhwVff2mqOwlP+2HLU1IvL4pYAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781817892; x=1781904292; bh=pzeUcCbM5AI1wrRCh77wZv6ZK96wI++foZI
	olipshs4=; b=NBcl6KnUEnOPC3QovISvt4XFz4KLlIR5JOaxB2cYkypO5qZ2/B9
	hrT4CY+aMEdnRklc42ViuR56DyfBKcDU8QEgHTbNNnK20+8owwpkGdiPJhXHehiN
	DOy+rsQZgorQ+eL/Gnd6H7ncF0i03BJAOhS56D/yXDgDqY0nYzr1O+j871qtQhO0
	aa45LJ4PeIYqjNxrYa/fVL8aRAbzJGVXG5Eewrti3VWHdvkODjZ+0gAV/m5BCle1
	v6NvwFhYvIL1De493DmW0zHoLkur3SC2Jg3H08zYuDFSLPaIMRJ4kaTOk7p/XNYG
	piZP47gLrPceVWJe+AhsmP4re2iwWvxUCAQ==
X-ME-Sender: <xms:JGI0an1FGk15X_fJfpuJqSS5KZLBffQexKIH6mH2Sdtid7lrh7gbkg>
    <xme:JGI0atGkCEcWxE0GV1DZyt9ksjW1ilwtZ3IxsQsnFwv9w0YHkAlqgtnp_PfRAnCMv
    SxECXTddRWbxsyv_W_UKBHKSM6w5msyRhHspELpJDxKR8fcEo4gvA>
X-ME-Received: <xmr:JGI0as4AWJ_f7K2B_U1hbNLwoaUWGKXASd4p7l_TNKW-qpM5Efbvma3kuhxFRrttDGOOK3EW8Z7ZKH8-Bldc5nnYyimI34s0Z9UO>
X-ME-Proxy-Cause: dmFkZTFoSnghlVBnLiHinAFuZfxW1E5sIjdehMutOtOWYi+lnz0eUc0F5IPfDBO15JXRN/
    pUyYfrAF11l/Mjw6lgjHi15BSyo1Ne1sJ+7oIVIDh/jqBcd3Lh+/dPGKCkvv3WZZP7haP6
    k+obfeUhHW08DbnAZz99HqRSl1Eb2QJ17LK6uOPAZm44ezUUZ0zrsyPzjZAGDtAEpy/uVg
    nKcRbgciUEtgoKmRH4cruAufqY1b1Iu8GXDnfmz09z5wOoA1SRhsoZqBAv5eMLXYgroEm5
    3R4QPmjoel5pXbr1sO+VtPvm+f7pKXSPmtFoLFyz+mEIaGXw4G5tpVuIwBpBS5i2g4Gvrf
    dHGJRjjuZzoswiTYmSoHFVEqOxsLOCpHNQm/MGsAhrlRqcAJiba8AylDmZW/qjZq4Bi/BS
    +AdDiM7ubgV0OkV81rA9c7DCe9XOriAyofielW59A9/tP9c9KaCGZPd0fWeOkpfoBEgdcB
    yIdeRap6aqhJLSoqZk/ANXKUvkRli92DurP0xv7HcjyGGVnuSJoZMZUC31O/t1xGGavZgd
    TmZkbIynTIUr902G5rp5Jv8KdZJ9BJj/cMto980E5IMYLpkTRUhhfuBzhKjX+OVfgAJMB/
    Y4HgB3K1xp6Go607JW1+v1Vkcz7qc0apVk+uiDRnf+RxLKso1IRTkiSNi81Q
X-ME-Proxy: <xmx:JGI0art5OSTrRBrXrOCT8w9ym-eontMHgVmVZWl67kzczF68HbUbGQ>
    <xmx:JGI0al4MfB9uAOoLIt_xr3JWKQBnY5Uzq9AScm9-hgMVpKOGh5tDwg>
    <xmx:JGI0auUFLBQxpFwm5XWrAEgKx4KhHQFyPyF2KnYJDlhp0cVlA57P1w>
    <xmx:JGI0av9TEbHGo-Ik7SO18ZjgBcRhHHTXqKawbjUZkCf57N5gvQSfaQ>
    <xmx:JGI0aob0KDpLQxNIM9djJjhSZC3iv3B9YxBbH3yj6oIWHv6Xtn7y3BVl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 17:24:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3 3/4] history: add squash subcommand to fold a range
In-Reply-To: <xmqq7bnvr3qb.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	18 Jun 2026 13:30:20 -0700")
References: <pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com>
	<pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
	<66b2f49fb427c7328136b2d440dc7461b97fb4e0.1781810227.git.gitgitgadget@gmail.com>
	<xmqq7bnvr3qb.fsf@gitster.g>
Date: Thu, 18 Jun 2026 14:24:51 -0700
Message-ID: <xmqqzf0rpmn0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> As t3454 is taken by another topic already in flight, I've queued a
> trivial "rename it to t3455" patch on top before queuing the topic.

Another tweak I had to make was to replace "grep" with "test_grep"
to avoid triggering test lint added by another topic in flight.

For the one in the second hunk, it may be much better to rewrite it
to process "out" directly with the awk script without preprocessing
it with "grep", as awk is a programming language capable enough to
recognize a line that matches a pattern and process only those
matching lines by itself.

--- >8 ---
Author: Junio C Hamano <gitster@pobox.com>
Date:   Thu Jun 18 13:44:36 2026 -0700

    SQUASH??? avoid test_grep lint triggering on uses of raw grep

diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
index 1edd148295..20370c0136 100755
--- a/t/t3455-history-squash.sh
+++ b/t/t3455-history-squash.sh
@@ -150,10 +150,10 @@ test_expect_success '--reedit-message offers every folded-in message' '
 	test_set_editor "$(pwd)/editor" &&
 	git history squash --reedit-message start.. &&
 
-	grep "re-one subject" buffer &&
-	grep "re-one body line" buffer &&
-	grep re-two buffer &&
-	grep re-three buffer &&
+	test_grep "re-one subject" buffer &&
+	test_grep "re-one body line" buffer &&
+	test_grep re-two buffer &&
+	test_grep re-three buffer &&
 	git log --format="%s" -1 >actual &&
 	echo combined >expect &&
 	test_cmp expect actual
@@ -177,7 +177,7 @@ test_expect_success '--dry-run predicts the rewrite without performing it' '
 	head_before=$(git rev-parse HEAD) &&
 
 	git history squash --dry-run start.. >out &&
-	grep "^update refs/heads/" out >update &&
+	test_grep "^update refs/heads/" out >update &&
 	predicted=$(awk "{print \$3}" update) &&
 	test_cmp_rev "$head_before" HEAD &&
 
