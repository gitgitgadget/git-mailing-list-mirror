Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF27E3FBEA0
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335490; cv=none; b=QtVjodwN+hQ43N9yo8neYtJs8NENb3bcXoC7/KxqhpEgAOZVf2cEPczkiBRpYG23Y2kitqLdA+e/PJ4I1nLjNaVRCh3U2cqhw1p8XOUBYYWYaEwaGc9+pNPrOHe1Lc5r6dxpoZWjJ2Fp2TNDu566oY8uOwa9j4AJWIgorG3QYKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335490; c=relaxed/simple;
	bh=iF52domlK3ndl93LUYyh4qeVX/HASH+7vVHfiZ3H8cg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Aq6F4FIO5+W5DqDYwjNSEsnzIRTjlHObW5vdhA8O3i+AIQ5Sa5Ur+TSbQF+SxocGT1u+vgNIDaS5IfPv32lx5ojvgZsrvoyMntd9NT8k+gKyGskmPgOsB473EhvlooxvrhYJnyg2Yu14emEILwhVBUkW+EkVN42RzR29iXOP4+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RBd6rUaL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R1zisnQq; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RBd6rUaL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R1zisnQq"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 412981D00113;
	Thu, 12 Mar 2026 13:11:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 12 Mar 2026 13:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773335484; x=1773421884; bh=+287h0W+uA
	9q54hx4VU30oqk2Uxq78BI8IGySNTv8Ec=; b=RBd6rUaLSqF+c6S3S7VSCQhXlJ
	tbkvXvMur5IV2hFkeYFU+M7AM37V6IZGEvcfjDob5lYCOm2/xXbWo8R8QCdSd7/j
	AOXVnmnbU/zPa7ex5AklhVZMmEKPlyjVYKXC2LlGQHC78uzzYEjG9A06BQyA/gZ6
	dIxa5/3bP4muC6cfbQPFayKlzf5JzGfNbm8dLQqseeNJzrs4G7NPv3fVwNjbgWdY
	tKS63ArnBjNGq5mPIe9x4dmZKf7JYWFdN3GtIyMsxDTO7Jcj28474SxTsFF5EKaB
	q1cj4H21DUKDRvNbkRSrkvwu5IsjaQVtn5M7cRV0mWdgQu+i11+/HpQAFYvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773335484; x=1773421884; bh=+287h0W+uA9q54hx4VU30oqk2Uxq78BI8IG
	ySNTv8Ec=; b=R1zisnQq1p8gvS81V0iYhQtDEzaqlurPqtOQdHKO5WSOOUYY4IX
	vz6+F94pvkB+UdHxdg1memA3IlG3t1jgf32Zf4BV+M0DbszCrkD0Cmzrnxyq4OpA
	7Rvm07wceC5Wp7mwvLtXgpCNs2qBc5hUayBBKCYP6PIW+L66pnd8+TtvzF0kvgLp
	UTbMfc8Qt8UA6sW+s20/Cm6lP0u2RYeoIElyL6Wpq4M74cZh3U3wfEWmwhCkXpd0
	aN47O/DolZOATHcM9G/nZA2H+zta2ImvzUAbgCLGvvKu22YJpDf0doLz5JL5duBv
	zubJC1aTh1UipGYzLOTC7a88CaJFt8P/jKQ==
X-ME-Sender: <xms:u_OyaTxwGiKlCjJ8WXcEYeniithDEwCR7eMVSHKsFSbC3ff1nmLTRw>
    <xme:u_Oyab8fF1RH-h0KvfZEZLHRicer2GjgBWNKNLQSXcQT_wEL2RiVa2M4HQnj5Zw-n
    oDvYNsLtLBK3uXAl3K4UaonkBDFzfULPrnW9ggydLD0XVSXS09qTw>
X-ME-Received: <xmr:u_OyabjyJsIN2RffOVpJEmO5zrI8vv5k9xlQdlyD_n6I0W9zGMe780wkLnbWGg0Gze6jDONsssSb3VhkVejIuraAG4r_0GFr3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghtsehm
    rghlohhnrdguvghvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoh
    epjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:u_OyaSEIlEzi02INQlIsDPNmVaeghGe3zuFh3GqHlZd3YDSfeV1_-w>
    <xmx:u_Oyaa93myoCLwiVyFQga57ev1FJZkrx43SZ-ffNKcGyqmfvunob0w>
    <xmx:u_OyaZwqdndtE7d97C1TGP1k7BgN8mGuuhkx-j2s32_Zy0xXgcq9VQ>
    <xmx:u_OyaWMK9SquqIDKBLBfgrhQ3cOAJ5zodr2pS-49e67ocSbnzv3A8g>
    <xmx:vPOyae-KapgCIJJzLn288Or6rJKSap4zd-jVi7QTn9vCaNi_Myw1YNns>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 13:11:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,
  phillip.wood@dunelm.org.uk,  jltobler@gmail.com,  ps@pks.im
Subject: Re: [PATCH v2] builtin/mktree: remove USE_THE_REPOSITORY_VARIABLE
In-Reply-To: <20260312164203.964033-1-cat@malon.dev> (Tian Yuchen's message of
	"Fri, 13 Mar 2026 00:42:03 +0800")
References: <20260312164203.964033-1-cat@malon.dev>
Date: Thu, 12 Mar 2026 10:11:22 -0700
Message-ID: <xmqqsea5ezwl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> The 'cmd_mktree()' function already receives a 'struct repository *repo'
> pointer, but it was previously marked as UNUSED.
>
> Pass the 'repo' pointer down to 'mktree_line()' and 'write_tree()'.
> Consequently, remove the 'USE_THE_REPOSITORY_VARIABLE' macro, replace
> usages of 'the_repository', and swap 'parse_oid_hex()' with its context-aware
> version 'parse_oid_hex_algop()'.
>
> This refactoring is safe because 'cmd_mktree()' is registered with the
> 'RUN_SETUP' flag in 'git.c', which guarantees that the command is
> executed within a initialized repository, ensuring that the passed 'repo'
> pointer is never 'NULL'.

RUN_SETUP also guarantees that the repo points at the_repository.

The patch is not wrong per-se, but at the same time, it is not a
very interesting change exactly for this reason.

Where did you read that dropping USE_THE_REPOSITORY_VARIABLE is a
good idea?

As somebody (Phillip?) said earlier, we probably should update
document and clearly say that removing USE_THE_REPOSITORY_VARIABLE
is not a high-value target when done in the builtin/ directory, even
though it is very desirable thing to do for more library-ish part of
the codebase.

> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
>  builtin/mktree.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/mktree.c b/builtin/mktree.c
> index 12772303f5..4084e32476 100644
> --- a/builtin/mktree.c
> +++ b/builtin/mktree.c
> @@ -3,7 +3,6 @@
>   *
>   * Copyright (c) Junio C Hamano, 2006, 2009
>   */
> -#define USE_THE_REPOSITORY_VARIABLE
>  #include "builtin.h"
>  #include "gettext.h"
>  #include "hex.h"
> @@ -46,7 +45,7 @@ static int ent_compare(const void *a_, const void *b_)
>  				 b->name, b->len, b->mode);
>  }
>  
> -static void write_tree(struct object_id *oid)
> +static void write_tree(struct repository *repo, struct object_id *oid)
>  {
>  	struct strbuf buf;
>  	size_t size;
> @@ -60,10 +59,10 @@ static void write_tree(struct object_id *oid)
>  	for (i = 0; i < used; i++) {
>  		struct treeent *ent = entries[i];
>  		strbuf_addf(&buf, "%o %s%c", ent->mode, ent->name, '\0');
> -		strbuf_add(&buf, ent->oid.hash, the_hash_algo->rawsz);
> +		strbuf_add(&buf, ent->oid.hash, repo->hash_algo->rawsz);
>  	}
>  
> -	odb_write_object(the_repository->objects, buf.buf, buf.len, OBJ_TREE, oid);
> +	odb_write_object(repo->objects, buf.buf, buf.len, OBJ_TREE, oid);
>  	strbuf_release(&buf);
>  }
>  
> @@ -72,7 +71,7 @@ static const char *const mktree_usage[] = {
>  	NULL
>  };
>  
> -static void mktree_line(char *buf, int nul_term_line, int allow_missing)
> +static void mktree_line(struct repository *repo, char *buf, int nul_term_line, int allow_missing)
>  {
>  	char *ptr, *ntr;
>  	const char *p;
> @@ -93,7 +92,7 @@ static void mktree_line(char *buf, int nul_term_line, int allow_missing)
>  		die("input format error: %s", buf);
>  	ptr = ntr + 1; /* type */
>  	ntr = strchr(ptr, ' ');
> -	if (!ntr || parse_oid_hex(ntr + 1, &oid, &p) ||
> +	if (!ntr || parse_oid_hex_algop(ntr + 1, &oid, &p, repo->hash_algo) ||
>  	    *p != '\t')
>  		die("input format error: %s", buf);
>  
> @@ -124,7 +123,7 @@ static void mktree_line(char *buf, int nul_term_line, int allow_missing)
>  
>  	/* Check the type of object identified by oid without fetching objects */
>  	oi.typep = &obj_type;
> -	if (odb_read_object_info_extended(the_repository->objects, &oid, &oi,
> +	if (odb_read_object_info_extended(repo->objects, &oid, &oi,
>  					  OBJECT_INFO_LOOKUP_REPLACE |
>  					  OBJECT_INFO_QUICK |
>  					  OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
> @@ -155,7 +154,7 @@ static void mktree_line(char *buf, int nul_term_line, int allow_missing)
>  int cmd_mktree(int ac,
>  	       const char **av,
>  	       const char *prefix,
> -	       struct repository *repo UNUSED)
> +	       struct repository *repo)
>  {
>  	struct strbuf sb = STRBUF_INIT;
>  	struct object_id oid;
> @@ -187,7 +186,7 @@ int cmd_mktree(int ac,
>  					break;
>  				die("input format error: (blank line only valid in batch mode)");
>  			}
> -			mktree_line(sb.buf, nul_term_line, allow_missing);
> +			mktree_line(repo, sb.buf, nul_term_line, allow_missing);
>  		}
>  		if (is_batch_mode && got_eof && used < 1) {
>  			/*
> @@ -197,7 +196,7 @@ int cmd_mktree(int ac,
>  			 */
>  			; /* skip creating an empty tree */
>  		} else {
> -			write_tree(&oid);
> +			write_tree(repo, &oid);
>  			puts(oid_to_hex(&oid));
>  			fflush(stdout);
>  		}
