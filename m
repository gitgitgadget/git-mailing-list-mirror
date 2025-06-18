Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C95521ABC2
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750277058; cv=none; b=Ye8z7l7pY/gMFgx7oLbc6WhGCMm8r4DEIvI62pj/0ytxfUhIH8HqUmxIMbVMjk5jDRj2sJeioUfuA0BAcJdZEgsUl0QfzLqmtrX5/PvfBaZjq9NRmZ8xtu+lqrTqCzyYR8N8LLDespi0VFEc0wdMZpWz7irmCkSMpj7QGUP52rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750277058; c=relaxed/simple;
	bh=UR0nD+6aHMRzS2hkoCmXOVkoxtiy93rwr4zPb45SjBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ug0BeH5Uzx1lP31MFpAELXghstPj+BM8rSuxmg2E6waAsxPZ4JDWNfFd+zAGUV7SBM1zhV1hsF0QboCgbAWcyCpE42erHqG6oOfo9VKWDxU+FOA+Mpycom6PduG0BD5KJNWsRN3oUX7INAKTUf58OP/82oSIAOxrHnNMo7+ZiZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U12pDEDk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mruxLVzK; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U12pDEDk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mruxLVzK"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BD87111401DC;
	Wed, 18 Jun 2025 16:04:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 18 Jun 2025 16:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1750277054; x=1750363454; bh=6nE5GQXgvYKrXPXvY2E1OnEKUaNY08wG
	I92BbXhihTU=; b=U12pDEDkSXNRYwIWsxkZ3YCEr3IVkwBw5ETZ+u41gJdp7MPl
	v07i22NsASkcJV15kuYNuGsRUfxcHjHbTeO92GVITcrarBdllDvECninHta0W4dt
	TgQOa0JlPdczDPwGFctgcywFB6nzt+HXLxgr3I6aFg203c/E6mzUkGPof+KgFf5M
	8eJHRQowGLAPyXM/NtNTVG2d7Uw9AeA1u8sW5/htqnfJyKYNKFQ3/N5erhGY9Qir
	oOvv9Ssvr455S1SM1UU8SyA8bxSp7jcTzCZzCDW3RD6qfT7bGGvMCrURqUh8Yr1G
	uPHMDiudaIdH+/MVo9KNJDm3fjFYcuKCvSo/Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750277054; x=
	1750363454; bh=6nE5GQXgvYKrXPXvY2E1OnEKUaNY08wGI92BbXhihTU=; b=m
	ruxLVzKKyXwfw7EvSuJgRjnSqF+IxFfiwprXgCq35NU3bQsmB+gQ9n8FvlfkG9PK
	ShP9V05EKAsVvouEVCF0PqvctjoelJj7vUFSE3zFEw5OVllIBrmIaCqmj4AXeI79
	xX5BSuWFK4fQT+7DpJJzrnUk2yyoeJcrgSrqrmmb455bhs0CgjVGEzEcl+8HKc+t
	ttS1xQyaf3tyWn7/2VIhD1N8tlbNU1BedHi8NF4/qDYR5X6O4H8pWvcGn5O5gSqW
	MtgsBgsPb0/dyMXPjlb+UjuFFZ/4MLj2Ovc2n9ENdOScQAZr1RpjeUP/whf/Wi50
	wKMH4vSZYLhjYkE/tDXLA==
X-ME-Sender: <xms:vhtTaEQrv3TgxHqrFZk5JCVUv5ftmuLj852y3Tkrd2zpJMyVY5LBfQ>
    <xme:vhtTaByg6pig-9gdgSsFjVcjqIBsG5LFjTqf2tq8cdnkUUH86WJEC6GNO_ulbi_ZM
    m_wMlE0HGKxiaADeQ>
X-ME-Received: <xmr:vhtTaB2s78Bg-Dq_SpCesw8W1qgaYNDIk-miRAS8F1J3KyzM5zdsj3KwNjAJjLUftcYfci0tZ6-mUKLt0TH4E1yaQhsBSrbfAFZh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdefheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkfgggtgesthdtredttdertdenucfh
    rhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtg
    homheqnecuggftrfgrthhtvghrnhepjefhgfefvdekfedthfejgeffieevieeifeegueei
    hfejleeufeffjeetkeffffejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthht
    ohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdr
    tghomhdprhgtphhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vhtTaIDCTZA3JxId07kaDooHKCzd2nGOkbLG4ueCaqG4Gxb0AAsR5A>
    <xmx:vhtTaNiUHtjBtatGm5Ynq3qNBdYtFZ3NeJj9VpZRPc4ohbVmFnGf1w>
    <xmx:vhtTaEoMxoZDfFfz9dJ0LpJlytm2xUb0eyY7QoAEle9evu-HJi34uw>
    <xmx:vhtTaAhJM0Skj_YxA-_wpnX_Xw_8sHiJjI44eXKrpZXNwu_N2ViF9A>
    <xmx:vhtTaEhPwDH-ZiKcRMSf21ZVP2aBj-BBEnNf4S-2Bba5jmb4LveQT-qt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 16:04:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>,
    Jacob Keller <jacob.keller@gmail.com>,
    Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH] diff-no-index: do not reference .d_type member of struct
 dirent
Date: Wed, 18 Jun 2025 13:04:12 -0700
Message-ID: <xmqqh60ces03.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Some platforms like AIX lack .d_type member in "struct dirent"; use
the DTYPE(e) macro instead of a direct reference to e->d_type and
when it yields DT_UNKNOWN, find the real type with get_dtype().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * get_dtype() was designed for a typical

    - prepare the path in a strbuf B
    - opendir(B)
    - loop over readdir(B)
      - do things to path (B + e->d_name)

   code structure, but because this code path does not use a strbuf
   (instead the path given to opendir is a "const char *"), the
   entire thing becomes messier than necessary.  get_dtype() has a
   short-cut to avoid having to concatenate path+e->d_name and run
   (l)stat() when e->d_type exists and known, but we need to open
   code it here.

 diff-no-index.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 4aeeb98cfa..88ae4cee56 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -41,12 +41,24 @@ static int read_directory_contents(const char *path, struct string_list *list,
 
 	while ((e = readdir_skip_dot_and_dotdot(dir))) {
 		if (pathspec) {
+			int is_dir = 0;
+
 			strbuf_setlen(&match, len);
 			strbuf_addstr(&match, e->d_name);
+			if (NOT_CONSTANT(DTYPE(e)) != DT_UNKNOWN) {
+				is_dir = (DTYPE(e) == DT_DIR);
+			} else {
+				struct strbuf pathbuf = STRBUF_INIT;
+
+				strbuf_addstr(&pathbuf, path);
+				strbuf_complete(&pathbuf, '/');
+				is_dir = get_dtype(e, &pathbuf, 0) == DT_DIR;
+				strbuf_release(&pathbuf);
+			}
 
 			if (!match_leading_pathspec(NULL, pathspec,
 						    match.buf, match.len,
-						    0, NULL, e->d_type == DT_DIR ? 1 : 0))
+						    0, NULL, is_dir))
 				continue;
 		}
 
-- 
2.50.0-228-g6e205fdad9


