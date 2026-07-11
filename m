Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072084499B8
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783798015; cv=none; b=Ih5Pj4+wrvAua9fs8aRBeYgWH3gwz5X881cWi5NyaechyKRO1oqsLRDVPAOnwEaZMqe9coO0bwk6AjtdvQ/grzyqI8YIRH00Q3vBZEEFOfCQC8PQYO/v+KeQFD76iH993PTv+h83FpUd/fNhZWBLhf7DAol8LA07/gRLdXq2Ztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783798015; c=relaxed/simple;
	bh=Bqw+Wn+nSP4rPIVLTcgZ+zp/eHF9slqaFU3UMh+WbHE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dQWygKc916h/05sawQ9ee19rMI7B51mkxIRzT33PLSamxZKCc95EzOcQQ/i31QTvMxjtARqC63BLz0FVtor1vL1V4a8ucr0Eoi7Ky2URkQMskLT0oQ3Vuo4gdZvKfrt6S+Pft1J3KLNiBnwnomXQXAgq6iwteQc2m92qd7HGv+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H2qiW4hL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QpicrC+0; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H2qiW4hL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QpicrC+0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4DBD0140007C;
	Sat, 11 Jul 2026 15:26:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 11 Jul 2026 15:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1783798012; x=1783884412; bh=yiaUm9SQLJZqw9WJzqowM
	P53oH/6DANFHI5is6Dn2Xg=; b=H2qiW4hLOzlO9MlHosH13EgeXaCyLEsrgBZhn
	DiEgJRsSdycex1KlRlb2QoelMc+oH/rd3k8C5OnlKV0oWb9Pf6rmTLO2UaKLJQFm
	+ppSd/1lkdKIyWvUW+UUztMvOCRFy1xoz2lu+nBTMR9Hc/d+0HsWvTjPcl9PEXKc
	bl3+wx0NmA47nivDyWrqi8CddUi1siKlgqTOn7LZEe/VUF1xO+Dz6qw4PdA7mzho
	6n/PVTwmukoMeMPEXHzYvAMNBFwueRiomMqFADwyKMEiXb/rGfPfRRvjkVxIKFF0
	h8wiet7JV4/jQ2937zH1KU2kqhvXwKyyN90y03SBnF13DktUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783798012; x=1783884412; bh=yiaUm9SQLJZqw9WJzqowMP53oH/6DANFHI5
	is6Dn2Xg=; b=QpicrC+0Js1CP3gq4Oh7+BGGuXKl0nzIBL7P5ozWe7PF48TTnBd
	TbcZ2Ciji4OTkaa8zL4wdLJCylG4FlHAlNgEtvE95iNZLxajjtNhyKnUHgijj1ir
	kOnCeDhR1bxoRWca92UQWnCYLl4S3lpILsxk68eW0kqm4+6Hp5KaTvrGX8WhX1ou
	s7UYc3j4G3tAsB/Ed1xvtbdewfdmKNsSUTZ5TXtQY3i0dfIujtGwmWusZJYMnVep
	CV/eNG+mb0W8wpjYgpzaVE5sHiZmRipgUnCcCMDO8D9tbm0h/CzCLDCMYbOyTkRV
	5B23CXjdkZuFr5AhbuDZsW/uhb7jY3bK7yQ==
X-ME-Sender: <xms:_JhSakQGBLT5_qzlsnmQ06a9cBCuV4r8wZZKpDbsMqWWbr152Bl68w>
    <xme:_JhSanxim9o5hNNfu6iQZtskeNuf-mSd5C6nCxZQqG6KbKgEAfxfx3Lq59Lc8pzK8
    NBvVJfH01WmhEm5bvAjkvLLmKOhlG9hdi3YmLmnY6yISCIAHYDg8Q>
X-ME-Received: <xmr:_JhSavdMPTWVQfszUMt1w6j_Cq5DDOyWOo0-Jlh49X_6yPLJbFoYWTF_G8yxeeDy6-eIKX1vEwDVRCSiQ6t3UDpS7F0dagzYhnUNfPU>
X-ME-Proxy-Cause: dmFkZTFRgsnzx8WmYMPtQ/VfHNfWCkNiL/FGzQvjjm064xjxl4lbqdwIFf7B2PHPLNuWrI
    IZQ/+OxjhovKJw5izKzft0CxbauwcTwpbo++k2FhpKpddiujWKwmxNIa7aOFjsmXL7t/u9
    Tk0YSGLGTm9gK8xcTVykCjQ/ZnmUEcwdu+B/AClnqv5yVUa7vzeS1MRGmkGWn1fmCVdxJS
    dikLiWgskxDG1xr8ZiANWwznmAsyNuqhG01RV7hpNr56OVYnrT34gGR/Ql+Y/uyDjtKdQ1
    vN+XqcQR1j7eHY5DV0jb1JqRizyfZ9v1T+OZVe3rrx8ye/Z3nSX1IStXRN2C5bVnuPTpeL
    N2uX0GKtEa9lDnbVc6VqFtf6WI7HvYtxvwvs1LzPTvppaYEsHIJIRJ1f0M6o991hjhvz4i
    dS1jANvROYLmk4xZfO784/VRkz6tCWWy1YqLbyR75e9PkpZ9o8mMgif7Om0SsZQiAhtgcF
    JpvQBTPhwIra9CRFURKPR9IXkQNzT2xZQxzHRhkWnysT3cnUkVD3BWWP7hDWddUlHHWVKP
    NXUJ4ESsTeVQhfi94m+czc2W4GKgCGVlIfFgy1L02wq5tqIaYY+P+p0TK0nOKtd81qMBCd
    EgsANdaRMBC3S0ERdLJUTqMHye7PiB0+pKt6Om2i1YeWdgVw4VCrA8RQ7NCg
X-ME-Proxy: <xmx:_JhSajL4zQt2dbf7fY1G8gSL32Z_Q0R_7Dz-JkPMW0W3Sk6dj0oHCw>
    <xmx:_JhSagEXjic1TTT2YS9oEAiBpbRw1BK3bxOI4TXaUIaKZfEiYK6LKg>
    <xmx:_JhSatqcrjCceFFndy4ZtqfZtWWxl8MyHm3pRqBhn6CewOHsl-0cWQ>
    <xmx:_JhSapRX0RtxR475VcD5mvu_mopoGFOM2c20dt9oYlQfywDgGZBPNQ>
    <xmx:_JhSanqGzSFkMHaLJAQ9yrPsc8QpFJNAJzJYSpP0d_3aPalA1dJ3pBZx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 15:26:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/6] Update Contributor Guides
Date: Sat, 11 Jul 2026 12:26:44 -0700
Message-ID: <20260711192650.2417665-1-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-391-gdf86bf5712
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have been tracking the rules I follow while updating the "What's
cooking" draft, which guides my daily work, and noticed a few gaps
in our contributor documentation.

* We often tell contributors how commit log messages should look on
  the mailing list, but the language in `SubmittingPatches` is too
  wordy.  The first patch in this series shortens it to get to the
  point earlier.

* We recently updated `MyFirstContribution` to advise contributors
  to pace themselves when they find mistakes or receive feedback.
  However, we lack instructions for when a patch receives no
  reaction.  The second patch addresses this gap.

* There seems to be some confusion regarding when contributors should
  add `Reviewed-by:` and `Acked-by:` trailers.  The third patch
  clarifies this process.

* We want to ensure contributors don't walk away once their patch lands
  in `seen`, as that is merely the beginning of the story.  The fourth
  and fifth patches clarify this point.

* An experimental feature in `SubmittingPatches` invites contributors
  to draft the description for their topic in the "What's cooking"
  report.  However, instead of outlining the expected tone, we simply
  told them to emulate existing entries.  The final patch remedies this.

 1/6: SubmittingPatches: clarify expected structure of commit log message
 2/6: MyFirstContribution: what if I don't get a reply?
 3/6: MyFirstContribution: carrying over trailers
 4/6: MyFirstContribution: clarify that 'seen' does not mean acceptance
 5/6: SubmittingPatches: clarify the meaning of "Will queue"
 6/6: SubmittingPatches: clarify the writing style of whats-cooking

 Documentation/MyFirstContribution.adoc |  53 +++++++-
 Documentation/SubmittingPatches        | 171 +++++++++++++------------
 2 files changed, 135 insertions(+), 89 deletions(-)

-- 
2.55.0-391-gdf86bf5712
