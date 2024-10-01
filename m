Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB2D623
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 00:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727741683; cv=none; b=FLyR74axlLvMp8AEDEZuE9OddCtJQeq0znjiBRRbOQydafWe2HWqzc8XLl4ZS6svrizfFMuRM4lcd6kdi6Tisd8NvkfZsbjRNxW/D5s74fTveWQ1fFmBaZYONNzl9blfONxFEu6FtvrkN+h2tf9CYeYGORVHoLJSLngdvCGPkVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727741683; c=relaxed/simple;
	bh=1e1itVciRkpt99u/nTRCpOonTqJSrGsNhgGxdDHtycA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ih0fBPk3qjtc54HVpJwVvIiqsAIXoc8aAxxRHTgP9OGt/o/34Dj/r3LthE2HH8F707jchJosUHUd4KzLUDuxFjOvcj3z3q7Gy6pSyv4P8c6pDHeV0xxKTf2aE8iXyTE9jH32IrSHj73jDPws4IWWClk9buzPIr1Jkwa9TirFKxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TeqCxGEw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fcAoTPcd; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TeqCxGEw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fcAoTPcd"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 61091114066A;
	Mon, 30 Sep 2024 20:14:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 30 Sep 2024 20:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1727741680; x=1727828080; bh=oM2vuQHuYeU671uVle2iNGPE1WlWQL3h
	nOHFTfVwR40=; b=TeqCxGEwo8RhKoqn01FEpfn1wqmM71OZJabwfexqdwgG3cw4
	O2rY1GqqOPTQdpYkCzl5st7iLOKYq7OGZPM+YOKxRswusnP/+l28VBANKgRV1T7e
	+nmfgjpot6Owz0mwZBZATnCOIAWro777aClsk4/n4KfnHZoHDmynFGk/8vg4RH6k
	TkJvY+e5728wJ9L1L1CUyExFIK5X33WmsoXBTtQTN8pe4tk6zaLb0NNKw9M7nalz
	qyRvdDkWPoKK0DCB/XGPNqAokt+fgQtqiQTEve1ktUqDlPGZmYit4sEBkjDAZ6xU
	T86HjCltK79+sEutaldi9/J1sraMDueZO7BidQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1727741680; x=1727828080; bh=oM2vuQHuYeU671uVle2iNGPE1WlWQL3hnOH
	FTfVwR40=; b=fcAoTPcdghiqnlDoHIut39//AgVsq97NsLs0Gi9twk96jLqemRq
	uRbcl0vJkdoFxMEfyZOybGCed+0AFA9xLVTvzQ9HM30sbPhijnHTaOdOH7AZyhLs
	4iGdE3TkynTJx1uoLLFxY9T7Sqh6YRpnnb0X3PWsyWuVd76ebH8ZKxgTGkThjFMO
	IseQxKONRfdBRu2jE5poY6c+ezZs4cAaFkHSXn+Gr9/X3yIAigMYNSOOWvOYIYWu
	bZ1lPqn5xnRlk07qSk6U2lgsC+EzMstlAnf7E1DiRgSzP6caowcn7dZFHZl7Eyn0
	nfeKbyCdBbkXlIQr8QZ2Y7XXLFhcsoH3WVA==
X-ME-Sender: <xms:8D77ZkaS9ENs_TRsGhyvfwchvnxMOatbPOQh58NIujehP9Ux4yVt1Q>
    <xme:8D77ZvZHC3__IKQFHxfr0WKhQ8Ku4tQcfKBW3paXWqpw7XX2Al0CF1bGaLGx4kHos
    o88gvHoxdUVbLeXqA>
X-ME-Received: <xmr:8D77Zu__nNzTYqSBpHX0_pDksrvm9JJc71wK6vZvgGDJCuTI-4REPHDNJ6p9sXn6jljyn9kfjDtDDMLng-28u6YVFc2WYQmfpSAN598>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduiedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
    fkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceo
    ghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepledvfedtfe
    dtkeefueevlefgleetieeuffffkefhgfekveehkefhgfetjefhffegnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosg
    hogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8D77ZuoeAXT7vsTCNpxd5q0xJbCfVZH_Hjc9gSOPviremaUa8f3w1A>
    <xmx:8D77ZvopPA7ct7rABXBZiw83cVBoKlIhjH3Y1XMK1KA6Rup1Dot-iA>
    <xmx:8D77ZsQXsxzn1PAo9eHSuewi4x5aFedYzJH1-QDffetd2G1MUC7JPA>
    <xmx:8D77ZvrH6HLHdAxEoPFxK59pDkRgSlAOl7Z7DpUsdtmx30lz3NGYwA>
    <xmx:8D77Zm28wEfZ_1a_Y5bbK0mpr7Ui-kX-F20kbDH3NfnB-sb7-HFEEXEe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 20:14:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: t0012-help on 'seen' crashes with gcc-13, passes with clang-16
Date: Mon, 30 Sep 2024 17:14:38 -0700
Message-ID: <xmqqr0903ci9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I didn't dug more deeply than what the title says.

expecting success of 0012.33 'add can handle -h': 
                (
                        GIT_CEILING_DIRECTORIES=$(pwd) &&
                        export GIT_CEILING_DIRECTORIES &&
                        test_expect_code 129 git -C sub $builtin -h >output 2>&1
                ) &&
                test_grep usage output

/home/gitster/w/buildfarm/seen/t/test-lib-functions.sh: line 1239: 270317 Segmentation fault      "$@" 2>&7
test_expect_code: command exited with 139, we wanted 129 git -C sub add -h
not ok 33 - add can handle -h
#
#                       (
#                               GIT_CEILING_DIRECTORIES=$(pwd) &&
#                               export GIT_CEILING_DIRECTORIES &&
#                               test_expect_code 129 git -C sub $builtin -h >output 2>&1
#                       ) &&
#                       test_grep usage output
