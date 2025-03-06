Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BC525A652
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288473; cv=none; b=HWZ2nDxnUw98ZnAb4zwDzNAOVqsXbA5+bxi+rY8uN/o0NDPYq3TpbAFGTFBth8iraMHlJsq6EfCoOJZFrOVxJ3hBxRM0QPEV4w9zoDXNEazQSF6jcOG03xwYCZzeZC6sqQBUDeU3PlWBDFD08GxVk0YQ1YodztqYCavPSZIWt90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288473; c=relaxed/simple;
	bh=rCyHb4HSdLcusXnH+o7n1/MjC5QiDFeTNrVHZ5+GS3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oWvmmJyISUHpMTMrbBGQvp7o6+OY3KFNW3JGWY7iwI8XQUxkPHQKbH4taMFEDLWbntvDXD3zS3OxWneR8ClWoxt2jfrH6g2T2MD5yBIRPZb7o7ZQiCRMjbxyGWeq/Vp2k03b/c5dfaO+7j/SuzFvZJZAfwWTahJ0lSdQnqFBrdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i5dGIOLy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SU0GU9gX; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i5dGIOLy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SU0GU9gX"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 37CEB11401E4;
	Thu,  6 Mar 2025 14:14:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 06 Mar 2025 14:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741288470; x=1741374870; bh=nzu2BJR2aF
	wBhU6JPKCue7L7ds/k8CYGF1jxTyN1jCQ=; b=i5dGIOLyaWcpcnGjBajtae4xat
	pMxJyrx9NkjGSsaFjgmr+eOH7vKh+tPIZEbEDdnc2tlz+rVQT9CohXVRhh52+47r
	n0y5wQzRAiTRsdlLcEpKjdY/oZ8GApsydMRPCw3uwJh+oMzaeyYXdC7q2Voy9+7W
	8a+4Wv5QRZnkO6NchCeehl8U7lp6tUTBU9kJhh71MOUGmIV8snphoAz26WM/zi3D
	XFuHn+XDMrfvJeHz3yEwvLJs/smkaNHww8QLIQXpLnIh754VlbJNr9ZsrQLsjVY5
	SR05PKbTsZCNkgPbVlU//GSuKwhGkW7F7btzDNH+aoyvzVWp6iZX0gdLyvJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741288470; x=1741374870; bh=nzu2BJR2aFwBhU6JPKCue7L7ds/k8CYGF1j
	xTyN1jCQ=; b=SU0GU9gXPc+bINNRzCzzal0rXhlCb0SLPZ/VC7FKTdArkUlkHdQ
	R627rQJe28O/7W9NM7n4CuDLjJBAH7YVV5d7v1FawDqX7RhhJlPtr/OYBhIjm5OO
	OcuolTI6ezU8s+66o5v0LkyfQBHC5lnhuYtSNS3Q4lhFGsKld0DwvMSAlHYh2kZc
	wdyAAi371/mkwfqBl92rvTfe6xaRzpmrgZ1AwhCIGYTi1BlOWTo/Fgp6dR3kvlV0
	BqMj+GhnsmsQ9MDafcCS28J1BUERMEZ6R7OWc/TEcYj18fWyer2kUCawRXHXAK3b
	Uh6U4XIkGW3UtBaC43lLWh5tEZk3PNDtmCQ==
X-ME-Sender: <xms:FfTJZ4nZbfpXe1v15AoxNHQv9hOKMRZr5E-fNqK1uFZb2fCYhJZVbw>
    <xme:FfTJZ33RePKxX40VINIuyvPrC95nB__OaIPi1J3enUOvx84RiK_I85uZEXFb9ogDk
    NJ-nKtS24TxRUSKcg>
X-ME-Received: <xmr:FfTJZ2rYQ0YELodYeQ2mW1wafJoYQ4dYyLaqptWQvrIcuv3zqppG8Gx4TSEz0NoDu3_-hZOL0sS1RZ8UtqwoIFDyyFCjIl4UUS-R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgs
    lhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:FfTJZ0nN7ZGOZV8okRRS3dlKU_XcN4Q2QnL-hksnfFHj0rZsX9zDiA>
    <xmx:FfTJZ23CP5JvtDZ3oSniaP_lHonyHprh1gzalWMYYZPhJlxhzS2Dcg>
    <xmx:FfTJZ7tSNtFcidundLxQcWqGBzDozbJaGZ7oSnz3A1mA0JV9cQ4YtQ>
    <xmx:FfTJZyXNdsNfJ13QMeOuo1IVyzoyPyuHAyhVQ8u_IHa_OhpaH653jQ>
    <xmx:FvTJZwqzGA-0ZFFM2__Cnxqs_MJZOQvGa14VrR7yzxAXORRlBTPoS7Wu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 14:14:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>, Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 12/12] hash: stop depending on `the_repository` in
 `null_oid()`
In-Reply-To: <20250306-b4-pks-objects-without-the-repository-v2-12-f3465327be69@pks.im>
	(Patrick Steinhardt's message of "Thu, 06 Mar 2025 16:10:36 +0100")
References: <20250306-b4-pks-objects-without-the-repository-v2-0-f3465327be69@pks.im>
	<20250306-b4-pks-objects-without-the-repository-v2-12-f3465327be69@pks.im>
Date: Thu, 06 Mar 2025 11:14:28 -0800
Message-ID: <xmqqr03ageej.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index a4431429b7d..2d2e90bc23a 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -234,7 +234,7 @@ static void show_submodule(struct repository *superproject,
>  {
>  	struct repository subrepo;
>  
> -	if (repo_submodule_init(&subrepo, superproject, path, null_oid()))
> +	if (repo_submodule_init(&subrepo, superproject, path, null_oid(the_hash_algo)))
>  		return;
>  
>  	if (repo_read_index(&subrepo) < 0)

This has an obvious semantic interaction with what is done in
Usman's series <20250306143629.1267358-7-usmanakinyemi202@gmail.com>
where builtin/ls-files.c claims that it got rid of its dependence on
the_repository.

The resulting ls-files still calls null_oid() here, hence it depends
on the_hash_algo hence indirectly on the_repository.  When these
topics are merged together, builtin/ls-files.c again needs to be
marked that it still needs the_repository variable in order to see
the_hash_algo.

I _think_ the subrepo is not allowed to use different hash from the
superproject, so we can pass superproject->hash_algo instead in this
series to make it easier on the other topic?

What do you think?

Perhaps we should have hidden null_oid() as requiring the_repository
just like the_hash_algo is guarded like so

        #ifdef USE_THE_REPOSITORY_VARIABLE
        # include "repository.h"
        # define the_hash_algo the_repository->hash_algo
        #endif

in <hash.h>.

In other words, I wish we had the following patch already applied,
before Usman started working on the other topic.

But with this topic getting solidified, it would become a moot point
to do that in the longer term.  This series removes null_oid() that
had the implicit dependency anyway.

diff --git c/hash.h w/hash.h
index 4367acfec5..3c9ccb550d 100644
--- c/hash.h
+++ w/hash.h
@@ -340,7 +340,9 @@ static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
 
 const struct git_hash_algo *unsafe_hash_algo(const struct git_hash_algo *algop);
 
+#ifdef USE_THE_REPOSITORY_VARIABLE
 const struct object_id *null_oid(void);
+#endif
 
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2, const struct git_hash_algo *algop)
 {


