Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D863F2F3C33
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750270855; cv=none; b=seImMaMCIE4QI5TxFGzyv8BQM8sIQmpeagDqe5z+BmEjGisPAyLl2lC8/v5pUTyCMoO86zs4fvD5M3AnuOhzKmJP8RN6T+7YW6eTstkTH2eh3cD4VAis+Mb+Fj2KUxXkRi5bZFk+WuI0aMSg4sqTIbTXG7274jjL9l4ZNXdM250=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750270855; c=relaxed/simple;
	bh=+HbJCIJIucdqk5mmu0Os3Is5aXxLQUBDi7UfF2Hgh7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nz+rEmV2m1cuKWmJKnVjI+UO1FYtVmxNEN0M/5wW6M6WJYAJO0GFDEbA9WmQqUBsb+U+nifHIvpy1eLT9MnfCvFYY3CRVTeSrWKX3X2ztascBQF/c16RY522YOfhQzkMquRF1LEC6uRulpnLQiWCUsYDr5VW+wXijf7F8b2GJX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dx+cthLk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E75CXmWS; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dx+cthLk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E75CXmWS"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id DB1B2138044C;
	Wed, 18 Jun 2025 14:20:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 18 Jun 2025 14:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750270851;
	 x=1750357251; bh=oOG+LC+S4AWSZJLew0jhkv4ggTRgkxJiMUasHz68sPk=; b=
	dx+cthLk4DU8aE8aY7IyBTOO5Xzxm207/JzehHm6Xu0W1LlI3NyUDfhShbkia570
	ThEM7hghGhdKRr0L+u6eQcNlfjvT5fkcYdf+aJTmRbBjEPxmAd2AlorIk0UtiLFx
	vyJWCOCV9EEWn8J/wU75whXhzot5AuI/P70Lsn8oHBVUDWBS52mHequQpbSdTQk/
	eNbm40JVQKq9+p4B3PHwZUZ8CFZnVv2tWbQz6n1QH183ilUv+z9feFD2VAf46NaK
	HiXFl4uDwFoSFf2zLZUk/0vNhedJUYdDen/8fd3lKXrDofO+uBKgsKmnxqBM/sZI
	tH+6SRKoaYJHWsitOFyEfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750270851; x=
	1750357251; bh=oOG+LC+S4AWSZJLew0jhkv4ggTRgkxJiMUasHz68sPk=; b=E
	75CXmWSU5Hgk6GDla6/4EvbRjGBUpQOlf1MUKp1dlLTNS0/immF0XQkCuYDc6dT6
	dND1S7ZKNEThIad90EzsT2QJxtA/ZZlbMWO3EFuvQ/ThWe1MsBZ/ak0NYt2MbhHD
	0uxziYp8snYJVc2UkKjZxdg1/OtIkMTBZ7fHNjU5LvWpg4QMBG/Q4K1aaw8n7sxl
	K+Ehr2Qgg2NBsVPmKMSdRA2itDZ+CIUzfu/WSvil+pc0eZaGS2s3gkVlBH+wJIyu
	ceE7TMmBMHxiAgFRepULw8KnYSDscqSGLX9CyBGFzATlDTNhv3AllWlAl/RoGbff
	hP3EucMmA86+T9uqTCAwQ==
X-ME-Sender: <xms:gwNTaHDp_z9ZGBVKY1L_wWV90WOcK_ss2gGUusjtsFlUs1ydzSTg5g>
    <xme:gwNTaNgg58ZLgtGe9gxEfronfT4gmJV2VuCE-Xe6Q1fBg-2bxD4m2u_rXa67U4nFc
    edc8H4sJWdoFSm7_w>
X-ME-Received: <xmr:gwNTaClka-Zpk25wkFm-kWQy6bxfuCtKaHhzMp1vrRThzQuwycMSo3SQH-ntwsMLoaB6jBLhyuq3rrGQfl6bxNKRwJHYwDc1Z1fV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdeffeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeehgfetvdejueetvdettefhhefhiefhhfdv
    tefgtedtgfdvjeeltdffjeegkedvveenucffohhmrghinhepughifhhfqdhnohdqihhnug
    gvgidrtgifnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    grtghosgdrkhgvlhhlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gwNTaJznZcD3xYU0E_30b_7oL1Y8LhN42a2WFfEfe27p8-cVSFtUvw>
    <xmx:gwNTaMSJjYEid8GcbrUfwKZu1_Z2JS0t9bVn50eJr3Q9xGpvysfEBA>
    <xmx:gwNTaMZcoMzRZ9Nboke2fwvAsCbdgtdG2Y4uA7egJSXwS7qIqrxEaQ>
    <xmx:gwNTaNT1xuBJE0qofuhxXRr79AjqX-ElOHThU6n9kCEou7iWBpu7sw>
    <xmx:gwNTaCcyFcKCDd_hc_87Y2xGCAU5ZqZiMRJTD4qn23buAoAqiCA_kPtf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 14:20:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] portability: allow building in systems without d_type
In-Reply-To: <20250618062331.78059-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
	=?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 17 Jun 2025 23:23:31 -0700")
References: <20250618062331.78059-1-carenas@gmail.com>
Date: Wed, 18 Jun 2025 11:20:50 -0700
Message-ID: <xmqqwm98ewsd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> Since 09fb155f11 (diff --no-index: support limiting by pathspec,
> 2025-05-21) will fail to build in platforms that don't have a
> d_type member on their struct dirent (ex: AIX, NonStop).
>
> Use the DTYPE() macro instead of a nake reference to d_type.

This may allow you to compile and build, but does the resulting
binary do what you want it to?

>  			if (!match_leading_pathspec(NULL, pathspec,
>  						    match.buf, match.len,
> -						    0, NULL, e->d_type == DT_DIR ? 1 : 0))
> +						    0, NULL, DTYPE(e) == DT_DIR ? 1 : 0))

On a platform without d_type member, DTYPE() macro gives DT_UNKNOWN
that is not DT_DIR, so essentially you are always passing 0 even
when you are looking at a directory (in which case you must pass 1)
to match_leading_pathspec().

So I somehow doubt this is a correct fix.

I do not know if get_dtype() helper function is easily applicable to
this codepath, so I wrote this in a longhand...


 diff-no-index.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git c/diff-no-index.c w/diff-no-index.c
index 7c95222ba6..677df91fc5 100644
--- c/diff-no-index.c
+++ w/diff-no-index.c
@@ -41,12 +41,28 @@ static int read_directory_contents(const char *path, struct string_list *list,
 
 	while ((e = readdir_skip_dot_and_dotdot(dir))) {
 		if (pathspec) {
+			int is_dir = 0;
+
 			strbuf_setlen(&match, len);
 			strbuf_addstr(&match, e->d_name);
+			if (dtype != DT_UNKNOWN) {
+				is_dir = dtype == DT_DIR;
+			} else {
+				struct stat st;
+				struct strbuf pathbuf = STRBUF_INIT;
+				strbuf_addstr(&pathbuf, path);
+				strbuf_complete(&pathbuf, '/');
+				strbuf_addstr(&pathbuf, e->d_name);
+				if (!lstat(&st, pathbuf.buf))
+					is_dir = S_ISDIR(st.st_mode);
+				else
+					; /* punt */
+				strbuf_release(&pathbuf);
+			}
 
 			if (!match_leading_pathspec(NULL, pathspec,
 						    match.buf, match.len,
-						    0, NULL, DTYPE(e) == DT_DIR ? 1 : 0))
+						    0, NULL, is_dir))
 				continue;
 		}
 
