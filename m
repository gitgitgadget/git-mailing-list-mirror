Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A39D3BBA0B
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792188164; cv=none; b=mIQeUfHfKUFzWWkn/qLuMnTw+Drs9LkQohlDd+IEXjRFvqirhCt+fYq8yxcF65HG7gfvOEj8shYTbguyg6c0rDTkWrwv+h+3zEa2QUzYuSI44ICN9LGDSt2A12UhzjKmBboIdtAPS3Hfxkjh1qIvIu3Bu8J5Nmwp5gTPUULcI6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792188164; c=relaxed/simple;
	bh=d95QkDu89UoG08FjEO5Wsowc0Ieepz5x5GT4DhAWgaM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EZtRVUI1vN8xtW76X9Lb+yYWZ2R/tnotWYOJlMJWE4jxGZr1sxknq2a+TY7vxVb9RDKjj0dbVTGzhMmRDzXXXSJou4AL9vA+XvCn8c5SRHFaUC+ahwYxmLAc2hfgEPqJ0smHXjQ2wgwGjMmGSS3gsyw5PvVVcsdOH0vIqG5palc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hYnX4Dya; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JwjPPQSk; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hYnX4Dya";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JwjPPQSk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9FF3A140014D
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 18:02:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 16 Oct 2026 18:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792188162; x=1792274562; bh=zopd88XzVJ
	WzZ6ZzmlhjeK89iZn0rtpdSRbxZ9sQX9w=; b=hYnX4DyaWQyoX725N3hwlrQKnm
	HlbylpRKy/CP5LqI2h7MrbwdosS8kkbbQ46os0DWNYyfk4E1BHPUsNM318qy04pR
	W5RjdnFri1rgSHv8X9YVSUumqfArYJHBMVQZ+I3LQsQk8MEZ1lmexeS4fOBv/w2r
	94ugnKDadzVZ04ODryYCFFOE8NGJRiLwQKkOyo/YZQdAr9QHW+M1kP0n47B3GH7j
	AHzqENCxrNOvC2Mm1Wdvp78LV2fZFAAfF/9xxT6NSgnHN59Am+ZJwViRiexr1fTV
	cc2g5st1IsmKaGO2MNOGpudjpEEOCfaDOLwwsS6CiTdM+9y9jGTCwWX7Rh7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792188162; x=1792274562; bh=zopd88XzVJWzZ6ZzmlhjeK89iZn0rtpdSRb
	xZ9sQX9w=; b=JwjPPQSkQiSXsBqlodRDLeSft9o4Cf6L5CIo6vo2ZUFpqQmBDvn
	SyUxutWxhNv3YbZoYQ5SGxvfEi+ZgHvSkqUsp9KysnDrd3aVmJUqdxg8/AV9WYdV
	Q5xNqUBPTBae5e74B8mBVtUPnk3hF/dsOKQRekTlCBJypzi2obHXC0h5mdmIRGp8
	dXXq8SXAFfooljLJtD16VT7V8M6S1SfeYv8sREg3vAd/d7k9CAKlpZgAPVGLxP/O
	3FCpNO0e8XYMsFX5dCT5uyrN1m5sP4SMxxYlIuL5EbznxBqkKdyo49AUR8h3pMiG
	W9Edoqo24XIawyfdX/n1fj5fmCpIUa+GPwQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792188162; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ipN2S6WKC+XM1Zb3C1Z3yzASh/y1+E1BVd2b62PvVD/ertt
	d3BBywU7PLKgLs9UJmLK30Z0OB+f1cHa3rr8SmiHBOq30PO6YQ9O1KMME6LMCjv+
	YNEW1CM7BF+Sf1BKmr2nwE9XC2ZA3KKojdcIcgJKkhDiE8BE80NDuMxZfnT8rRmB
	dozuhD4hoUpwNSngikfUKF69IESs2zqD16YG1whh6SN1oCe4HLecYcOiTiWPrPUz
	iDgQLrMbpE9expt/3cEm3B2NrD5EbnpWiwOgJwDH4EEElIuQI3zahBiNxQPsVT9T
	dUf1p/uoK+QE18Tx+EZ6lrMmzV9R0/ppA/LAusw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ZWX1GTN3yzpuTNnMgwQwdUDCEZfefl1mDo5A7jvE6Ds=:d95QkDu89UoG08FjEO5Wsowc0Ieepz5x5GT4DhAWgaM=;
X-ME-Sender: <xms:Ap_SalQS4V60ltsOVCjKCRTYx4KRPZB7xcbtjHurJex6-q_6XcLkOg>
    <xme:Ap_Salos6XRtLk3YEfdZh2FrA_2fNelwnAJI7-A0V-WKlnO6H5qJnzrH7Cl7vaGFk
    X0kZzPF0mCLSXnvkDeKob70xU__WZSDXUlQb1YtAbnOFNzFud5QS8s>
X-ME-Received: <xmr:Ap_SajJRK9fz1DpMFppJ43G6zyIpfXZyBNtZUXRZE0xGfwP33sIe-2GeyME3-Nr2E0kNO9zTnFq0PNzPT2ypPu3PvvnJv5FCX4Ph>
X-ME-Proxy-Cause: dmFkZTEbzQVja77NX3qNNQlsJd/CmANLXIIGyhlCbY73G6WbSensdZCPGNuR7WZWQ0lhmv
    Mg2Py/XRKDKZSh1xQ6W8dD+1Z4ODUPluRbHbpbEvNAv0Mfsoy8l0db7BnngfXfs5LkkTgU
    sgZIaBXT1O8LWBwv7WCe3E1DmdqKacM+agnzDEAgAnTXPqpVTknKkM9sbri2v7djrObJ29
    DW7RyFSze2wywzJyUz3VIa29Jk4umh6HjENj9oHJYQOAYcci16vRR2RdwVtNRhD4JkSYI2
    kwnx/eT6uDa5bpfIJHxGj88mtmt1uBId5KWSdgPcn5HPKnLGjhDdyi/om06XMjYb9Kr/NM
    zLcwE1/Tipiw7u45QVqsv1341TGxsHFxlfm//lgYU/4pIuJVOLZcpQN4ZYT9JWJUk913gt
    bc8E4JPzLEwtKj/l4l9f0+PHOZQBxo6+mq+j8TLiKp76AhC/zwTs+sOHYff009OnU3dfe1
    bDrog2ACUa45nt+ftPY/hCfiMSXMf7BayrTEgzTIzZ5ymlbWQHZH/cFvk5PCBMQ+QHiKNp
    MbHKC58xSyH7LiLWCNhoDEe92lZ9L9Do3yw9s2OEF9KDn4yrvNiKbIQy3pixdw56nu6t+e
    G6UoyazBaNP0A0plkNwRDXrQ28cLlFXmQmq3IDaMm5HCLeccw8ti6SYxFERg
X-ME-Proxy: <xmx:Ap_SaoqoHUTUDLI7L0x70Gg0Qdm8VtU3VonKIGf5cLzvIWD7ZUBBjw>
    <xmx:Ap_Sarx7WuZGSOvFKecTsC0s62QQ6Lj8TdZVjh_In1JQz4oeAJIoiw>
    <xmx:Ap_SasPw_Xwdkdb2B-_EGg6Dawii936YvzrZGIxf7S4LIOuGMsMXMw>
    <xmx:Ap_Sag79a8KHDaLdnv8XLS-JxPbv4ImhAwrFRBI8HJVltqC127imrQ>
    <xmx:Ap_Saj5b5lqaciOStetJSyge9kZbHcG3e3kIo8Nux40m3Yekc-fj3IbA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 18:02:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v4] doc: checkout: rewrite detached HEAD state explanation
In-Reply-To: <pull.2250.v4.git.1792177409868.gitgitgadget@gmail.com> (Julia
	Evans via GitGitGadget's message of "Fri, 16 Oct 2026 19:03:29 +0000")
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
	<pull.2250.v4.git.1792177409868.gitgitgadget@gmail.com>
Date: Fri, 16 Oct 2026 15:02:40 -0700
Message-ID: <xmqqse25cni7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  advice.c                            |   1 +
> ...
> diff --git a/advice.c b/advice.c
> index 401d047391..8d2c1ff1ee 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -291,6 +291,7 @@ void detach_advice(const char *new_name)
>  	"\n"
>  	"  git switch -\n"
>  	"\n"
> +	"Run `git help detached-head` to learn more.\n"
>  	"Turn off this advice by setting config variable advice.detachedHead to false\n\n");
>  
>  	fprintf(stderr, fmt, new_name);

This breaks t2020 without an accompanying change.

You can squash in the attached patch to unbreak the test.

Since nobody's terminal talks markdown or asciidoc, let's use the
vanilla single quote instead of backquote while we are at it.

 advice.c                   | 2 +-
 t/t2020-checkout-detach.sh | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git c/advice.c w/advice.c
index 8d2c1ff1ee..3238e9b866 100644
--- c/advice.c
+++ w/advice.c
@@ -291,7 +291,7 @@ void detach_advice(const char *new_name)
 	"\n"
 	"  git switch -\n"
 	"\n"
-	"Run `git help detached-head` to learn more.\n"
+	"Run 'git help detached-head' to learn more.\n"
 	"Turn off this advice by setting config variable advice.detachedHead to false\n\n");
 
 	fprintf(stderr, fmt, new_name);
diff --git c/t/t2020-checkout-detach.sh w/t/t2020-checkout-detach.sh
index 28bbbe6c05..804dc2a67f 100755
--- c/t/t2020-checkout-detach.sh
+++ w/t/t2020-checkout-detach.sh
@@ -228,6 +228,7 @@ test_expect_success 'describe_detached_head prints no SHA-1 ellipsis when not as
 
 	  git switch -
 
+	Run ${SQ}git help detached-head${SQ} to learn more.
 	Turn off this advice by setting config variable advice.detachedHead to false
 
 	HEAD is now at \$commit three
@@ -310,6 +311,7 @@ test_expect_success 'describe_detached_head does print SHA-1 ellipsis when asked
 
 	  git switch -
 
+	Run ${SQ}git help detached-head${SQ} to learn more.
 	Turn off this advice by setting config variable advice.detachedHead to false
 
 	HEAD is now at \$commit... three
