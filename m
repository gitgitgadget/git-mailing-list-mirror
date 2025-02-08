Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CE7244EA7
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 22:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739052471; cv=none; b=Uyp5jnGtfD+hnyg+F0VoV9bPUHShPaYQicq1ko2WfCPDSOWKDwFc2qxcy0VYeDFxpQwNa1fKvUfZhprP78ONh36YiWJ29+hFTRug7XBIwHECTWInaKfdm02BrUHZbEMXkQFoekSlh0VusuOUHyUTpo/LrHPeRXOXZox1sImuXhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739052471; c=relaxed/simple;
	bh=YWVCZUUpriJ3Xox9itRp3r7AfmGPh5Zss1gafJAHVi4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B9x2T1r2FEvxT5SCPXA4a340063GP0DfNA6Ln9KzVHVxxQbF2manA00dIbGDwNxtG2cpTI88kKHloHqX01IWXPMYgOknCmxPPVJ7ZX5YB0C5UwIfybCQBmHls84bZStXRCnSklCZOlI3FRX6aEstzy0ZEzhPXqt0QaMiiDcWX6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HMpLdgro; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XavSUo4v; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HMpLdgro";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XavSUo4v"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2B9B22540111;
	Sat,  8 Feb 2025 17:07:48 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sat, 08 Feb 2025 17:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739052468; x=1739138868; bh=jgZ/fe0k5b
	sk/Dm1HoUiXFrOUwktsf5LHbkfz5RiWsU=; b=HMpLdgrogW5nCA7PBztY12U31N
	TQlkJ8ArPlj8PqoQTpT0EGhJ8nL5VZH0mYinVC3ywEVF43nVkPPKV3aTeZ5GVRgI
	iWF8SqmXSDHXjAxN4z6h1lDIEd1IWjsomSKrjz8BKQoxC6p3mthCjYQL4oE3Dop1
	fOOmr4KZUCAMd94cIW0kHpw4m40agkA1NrmuFLu6+Pf7HDu/rIHcNttT2ZeXpfrh
	otgIxbOK+EQ5znknoWhj8TdutdYD8DW0HHux/Eu6McVvEfeoVV2HaOYjzRG92d3d
	fmInowIctWi5eXQ91d/XDTSgE2E3NpG4bZ6aJIWnMtK0eH0qEzty77J5yACg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739052468; x=1739138868; bh=jgZ/fe0k5bsk/Dm1HoUiXFrOUwktsf5LHbk
	fz5RiWsU=; b=XavSUo4vkuHkvwEcyGvrK2Z0UfsPwg85Vs5By47wtO0Dy4lenFu
	+qDT8g831t5hulR09aT/riRzQN7mNig6xkc6q+GLo8MKnoLlsjRZTG9hg5iqalud
	QbLOl8NooR4M9FQ+3pipum/IhB8YTyD0GpAmY3ZIYU8PffbyR6g/Z7WcbOA288cy
	Ynf0IcQAi7/NeI6ZwMh17bMVR6CDQLdFBpmtcPIbhi9auRUpIYTQAxv65KMHdLF2
	WUfMRo4G6r/7dcjdtYMmI3uQifujMY3AsRSpzP4gCdXbqTDPFVzkUK7Pe3YBfyI0
	brYl3LAO2yS7G/fLCH3mnMWYdPpHMa2akkg==
X-ME-Sender: <xms:s9WnZ4hhqeSU2EB3OeaxjYDpsuygPlk30uLyPM3BrcUqszSXnk0Yiw>
    <xme:s9WnZxDTFKsuyge2fA2J1oz4Lu3u1JVopvWx-DtoF9-vKVE5pFKI5gLphDcBL_QUn
    AeVDJgtRR6a2kJjDw>
X-ME-Received: <xmr:s9WnZwGWnvfbxkhebqSlP_NcuX_Eea1MREG_RDU86Iqh5TJRe7h2K80WSwynRUzEjmKQKszo5KvsSVsKBoJT_9Plwh-ZM3vI5Zp3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeffeefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguhhgrrheiudehle
    ehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:s9WnZ5QwGlVY5UD6JAKS8FRaRp7lclT_Vd-gaLPNd38fNfS6lxFjNg>
    <xmx:s9WnZ1xrfyDqF3Itq8V_J-jHJk2dDfCLcBLl_9UmyY4O4ikqf7Tf1A>
    <xmx:s9WnZ376a5JmzzWXjOlaQH-ZHtSslsys3xQzcYMQV7_QJQA4IL-W5g>
    <xmx:s9WnZyxtzP3mmLWfnfnyYhgxEN3T8gDao5EkYIN_kZePvjDgdbcypQ>
    <xmx:tNWnZ8k40j7GHf7A4xA_kX6Ojre8W2YzICLBXXLll1p9oSWDzV3QHCq4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Feb 2025 17:07:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Moumita <dhar61595@gmail.com>
Cc: git@vger.kernel.org,  Calvin Wan <calvinwan@google.com>,  Patrick
 Steinhardt <ps@pks.im>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/1] refs.c: fix -Wsign-compare warnings
In-Reply-To: <20250208182736.18133-2-dhar61595@gmail.com> (Moumita's message
	of "Sat, 8 Feb 2025 23:57:35 +0530")
References: <20250208182736.18133-1-dhar61595@gmail.com>
	<20250208182736.18133-2-dhar61595@gmail.com>
Date: Sat, 08 Feb 2025 14:07:46 -0800
Message-ID: <xmqqa5awdr9p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Moumita <dhar61595@gmail.com> writes:

> Remove DISABLE_SIGN_COMPARE_WARNINGS from refs.c and fix integer
> comparison issues that caused -Wsign-compare warnings.
>
> Tested using `make DEVELOPER=1` and `make t` to ensure correctness.
> ---
>  refs.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

I think this is wrong.

The string-list structure is screwed up in its use of types.

The alloc/nr pair to keep track of the number and insert index of
the elements were updated to size_t in 2022 but that change was
incomplete.  The API function string_list_find_insert_index() that
returns the index into list still return "int", and that is what
needs to be corrected, no?

> diff --git a/refs.c b/refs.c
> index 37b8cfb90c..e5cb7acfbe 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3,7 +3,7 @@
>   */
>  
>  #define USE_THE_REPOSITORY_VARIABLE
> -#define DISABLE_SIGN_COMPARE_WARNINGS
> +
>  
>  #include "git-compat-util.h"
>  #include "advice.h"
> @@ -1652,7 +1652,7 @@ const char *find_descendant_ref(const char *dirname,
>  	 * slash) and is not in skip, then we have a conflict.
>  	 */
>  	for (pos = string_list_find_insert_index(extras, dirname, 0);
> -	     pos < extras->nr; pos++) {
> +	 (size_t)pos < extras->nr; pos++) {
>  		const char *extra_refname = extras->items[pos].string;




> @@ -2304,7 +2304,8 @@ static int run_transaction_hook(struct ref_transaction *transaction,
>  	struct child_process proc = CHILD_PROCESS_INIT;
>  	struct strbuf buf = STRBUF_INIT;
>  	const char *hook;
> -	int ret = 0, i;
> +	int ret = 0;
> +	size_t i ;

This may be OK, as .nr is of size_t.

>  	hook = find_hook(transaction->ref_store->repo, "reference-transaction");
>  	if (!hook)
> @@ -2635,9 +2636,9 @@ void ref_transaction_for_each_queued_update(struct ref_transaction *transaction,
>  					    ref_transaction_for_each_queued_update_fn cb,
>  					    void *cb_data)
>  {
> -	int i;
> +	size_t i;
>  
> -	for (i = 0; i < transaction->nr; i++) {
> +	for ( i = 0; i < transaction->nr; i++) {

It is also wrong to add SP there.

>  		struct ref_update *update = transaction->updates[i];
>  
>  		cb(update->refname,
