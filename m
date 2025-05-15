Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060E51F5827
	for <git@vger.kernel.org>; Thu, 15 May 2025 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747340780; cv=none; b=MbL2XGaNYBSLtidjy2MovNE/GCAKL+aoG6I6ZFJjTE3AJVsNgmc2EmlfG7YEq2T6pJMe//O6H9aWvsQ1vhYwDCiWcxYjjo/wfjmX62atC0fOe8SguEzV1B0mRMYYEyDpiCnMat+t4Xj6hQ78m3ZAidLjFpYUdBnuivF0MJVPN+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747340780; c=relaxed/simple;
	bh=2wzMvShOvidqejk19bUD56PeOXafAowvqH8N7mKzgzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SUjXLXkDkK+yOhxktz6EeJkmwxUHJPz7TKh580sJ9EMCSsa5hDac7wo5yW2zV5PtmE+XvOeiRjYcBardF89GUvirdj0eD4hxmAJwJyAxzQjTu/7SDxjnHoUnMIpl5HN7YAl3luW4FQgcvYtsGNLk1PKOTzURxSAuNPtCvsvwZ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nNzG7yi+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=In/26c+4; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nNzG7yi+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="In/26c+4"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DE2EB11400C0;
	Thu, 15 May 2025 16:26:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 15 May 2025 16:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747340776; x=1747427176; bh=OuKZJkC8F3
	/Pjuu5x+LeacqTjSN5oNMsj6M6fBYNrw8=; b=nNzG7yi+/M631znfxx+Mm4pBxv
	UOH+HUldUYlUwxYBO0gahvAB8ksVNdOwLYgfuNtdnm8sOOor9byzhRs1MaTHb/bw
	OuuM2CRzHRcoRoXJdVZxh6SMccdUiIFnOOw8VJlZ6vA6+oXAcvNq/0TstpQXqeZV
	wqcPnshDgXUOMlQ8/SQChZn39NzuKMBxZUkYE7JQYWSDAyi8NUXNAxfP67SU6DMt
	JNvpVOHQ5LaipuXyzfyVEz5wLnQjCZvN0cJbj09fvPGosd6ZcvCZZxQvm/X8xxNU
	HxbwksAlndcNfJMcNtk21PPTH2fvl7Aq6CacyngfMx0pkjxecQzi6vLJfQMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747340776; x=1747427176; bh=OuKZJkC8F3/Pjuu5x+LeacqTjSN5oNMsj6M
	6fBYNrw8=; b=In/26c+4SvUVXeDG9qNHbb8FkhkrgfKBEZokeCnfJwUNh8LzQv+
	lEjCm5rgrQZhwsogoUiqhw09RnpPmsxZ63vQ5e63ETAaFqra/9CHkusIcEAz0VcY
	edJLiKdvzHE1qZFKgLs73ZiBX3qrNjRSqSs6e0E/HlmpfNodNsqatQxyd8+pJgDZ
	YkLiKr8f9/IhPuLn5zhIiTumnEhw+J1d2WtHJNQG6LN3vW6SBU75hkHXXMccFaQ+
	5CXUn5n2PqlFGOtVgu/l+BldqBzeIRI8u2uvhng5D+6PzI/VIcLgV6QfO1ysLTAh
	4+sIQ4Ss7k4Rfl7KEbuvQwTeal62u4R7+bw==
X-ME-Sender: <xms:6E0maCsEReggBAXOlDAP3uY3GwtgOJhyci-t-aVU-UYiXInDQIG7xw>
    <xme:6E0maHeEu1AqGtBC4BbDapBvGWS9rOnPr9cxr_MvHR9nTxNDT2p5iIcaT18zkinOO
    lzuLyiHQ3g6vxVOsA>
X-ME-Received: <xmr:6E0maNyo7h-NW2ZjjXIL3xBnJh1Pau1aQfbzuehik-9eIPqRhOgwmVWNr8YbY9czTHQP13MVmOj-cglj8YUf8Go2YoUXZdb_vfeShiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddtkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6E0maNP5Brxi4PKPXCq7YKQD4wm9tucyJV_jC-H6eVB_TUGT1FiW0g>
    <xmx:6E0maC-1M9g-H03upm7nevPAlJfRUUS6kDcg-CoKXsvJ6y-oclzE6w>
    <xmx:6E0maFX7Bs30nsUd58daFLge1nS2t-PDF6Q8nHWI7kCWYuvNKHCAlg>
    <xmx:6E0maLfywGxJ1qdaw_aN9dRoUPIPZn8gTLKEhl7BR8TVHYh0zOTwvw>
    <xmx:6E0maK0711jZAKrWG7tuNFOQ3V_d6e1vziKcDrlSUhmTgIaW4ysf89t->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 16:26:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  toon@iotcl.com,  ps@pks.im
Subject: Re: [PATCH v2 1/4] refs: add function to translate errors to strings
In-Reply-To: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-1-80cbaaa55d2e@gmail.com>
	(Karthik Nayak's message of "Thu, 15 May 2025 16:07:25 +0200")
References: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-0-80cbaaa55d2e@gmail.com>
	<20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-1-80cbaaa55d2e@gmail.com>
Date: Thu, 15 May 2025 13:26:14 -0700
Message-ID: <xmqqbjrtzkm1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 2b1e336ba1..09b99143bf 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -575,30 +575,7 @@ static void print_rejected_refs(const char *refname,
>  				void *cb_data UNUSED)
>  {
>  	struct strbuf sb = STRBUF_INIT;
> -	const char *reason = "";
> -
> -	switch (err) {
> -	case REF_TRANSACTION_ERROR_NAME_CONFLICT:
> -		reason = "refname conflict";
> -		break;
> -	case REF_TRANSACTION_ERROR_CREATE_EXISTS:
> -		reason = "reference already exists";
> -		break;
> -	case REF_TRANSACTION_ERROR_NONEXISTENT_REF:
> -		reason = "reference does not exist";
> -		break;
> -	case REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE:
> -		reason = "incorrect old value provided";
> -		break;
> -	case REF_TRANSACTION_ERROR_INVALID_NEW_VALUE:
> -		reason = "invalid new value provided";
> -		break;
> -	case REF_TRANSACTION_ERROR_EXPECTED_SYMREF:
> -		reason = "expected symref but found regular ref";
> -		break;
> -	default:
> -		reason = "unkown failure";
> -	}
> +	char *reason = ref_transaction_error_msg(err);
>  
>  	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
>  		    new_oid ? oid_to_hex(new_oid) : new_target,
> @@ -606,6 +583,7 @@ static void print_rejected_refs(const char *refname,
>  		    reason);
>  
>  	fwrite(sb.buf, sb.len, 1, stdout);
> +	free(reason);
>  	strbuf_release(&sb);
>  }

Why free()?  Goes and reads on...

> +char *ref_transaction_error_msg(enum ref_transaction_error err)
> +{
> +	const char *reason = "";
> +
> +	switch (err) {
> +	case REF_TRANSACTION_ERROR_NAME_CONFLICT:
> +		reason = "refname conflict";
> +		break;
> +	case REF_TRANSACTION_ERROR_CREATE_EXISTS:
> +		reason = "reference already exists";
> +		break;
> +	case REF_TRANSACTION_ERROR_NONEXISTENT_REF:
> +		reason = "reference does not exist";
> +		break;
> +	case REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE:
> +		reason = "incorrect old value provided";
> +		break;
> +	case REF_TRANSACTION_ERROR_INVALID_NEW_VALUE:
> +		reason = "invalid new value provided";
> +		break;
> +	case REF_TRANSACTION_ERROR_EXPECTED_SYMREF:
> +		reason = "expected symref but found regular ref";
> +		break;
> +	default:
> +		reason = "unkown failure";
> +	}
> +
> +	return xstrdup(reason);
> +}

Why can't this return "const char *", without xstrdup()?
