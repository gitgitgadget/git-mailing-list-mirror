Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BFA30E83A
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173876; cv=none; b=EgBs6MI9DZg6hYpng3EHpp84K+Dn6uAP1G8gJtjyuDtJe0/4MP/VBbjTOTnnTeHXasKsJwuamvGzfya1j0LNa1sdM38Wjtp/Itl3oNEClmu7QX0w/Lnh+mODDy1H4AaS1DcYW5BHF9Fio62qMWNuqtVrcDtfCEDLABTrBqkkZvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173876; c=relaxed/simple;
	bh=c1BrV6tifoFcAmxoVj2LGKsKPR+6R9ZS1tto4qz/3Yg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AqxONBJ346C9sbWjHpZoYuo79tWCHEPxQNZc4XhoS+9/7gn37HZNs/yBr5oAaxshWGYuYDn7smu5ISMbNRTpZS2TS70NDgNXsdGKrhMcNsIkYi2LaL22HANiBFw58YUu7Hdgio4Rd7LSA7vHE/wWho/IFTTQDt2PrVVE3vI+py8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nPZ3l2Yr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kJ592uSL; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nPZ3l2Yr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kJ592uSL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D298E14000FA;
	Wed, 26 Nov 2025 11:17:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 26 Nov 2025 11:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764173872; x=1764260272; bh=w4ipB/Xxt4
	dqWk8rRaSML/fbfkihzinY7/VmGLckesA=; b=nPZ3l2Yr+cfwJe87ueg3UGXLYL
	9mJXCAj5vG7P4tvXroIZ01Eo8LOoTbwPJD8xleK4pVmcRcu++QveCtmXVzppkqXj
	GNxXO9nTVR/plU8zdKJ3dUSlSBlvaxtc9bH5ekse/pGjochrHmukbWdKP2FR9jAJ
	8mPABhCw7Z3C65ioI+tJlqpKHsq7gExvAR4s3PXDH4u6/iJECFIG6/cTbpTv+S4N
	ytfV7cquZtUg/4R7wIGrxIpOlolspql/8blV36eJKsGYGej/qL6iNZ4oyWjvPaCd
	16ij5ctWbB3UhlDGTmTdR/hWvhefoDz0qW+kLZIMR0SO7RwzwWzMElDiW5Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764173872; x=1764260272; bh=w4ipB/Xxt4dqWk8rRaSML/fbfkihzinY7/V
	mGLckesA=; b=kJ592uSLdWoqkT4KiSmNeJoxbj0rpHuFTAC2uvLs1Ii0ykCObGn
	tMHuo25b3J0llBCJcs0DUX2haTz6NREHk30RV2DXlha44jOBOo4ti+nnZkTX7gOW
	39swvxK2nfErNpJBbAy1DrttteHRyUzv75xXgevUpFVlwehp+bE4Dc0hIbIlI+VN
	zBeGgbzVlrxIY9k0WLIvDhyiMSzV13E6NA90vTXVh2WTPURJtjbu98vK8Uunnmmz
	wwdLNr99dC5tV9ZHdpl2DwMHvYN3uptPLkK+/p7zsDBnPAd8vTLtZF8KtUX570y+
	M7yBZWRUnOeFRRIRhi9u1wmAOv6pBkqhW/A==
X-ME-Sender: <xms:LygnaSKF_SySCTmr0UanS6QKE34s7XLEEwxQJ-y5pGhBoVUpatN4Ug>
    <xme:LygnacY_tCNh-ysK87RuJXbMtVsOYn_bFC_Drb-cAiuOni0urLdfkQ9u-MLrSabQW
    qRbK9W7jPqRdZiocpIGDuLBNA5D7z6PmBDcrGexyiqvYP8Q1AaIEQ>
X-ME-Received: <xmr:LygnaU_n1o4B83gPvGUsCzzYlimGBnSGy393oIZPmZ-s0HE5iYvrv-PiaVG-eT1C0xIrUterbb0HJMmAn1z7PrwFlZgPkMY9bd11>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeegkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttg
    hlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Lygnadbk1DImfnPai7oejHJcFxybbBF8OrjXldvB9Z6e0DTSriz8Kg>
    <xmx:LygnaYOHOrvXYm98xmge5V8VrfgNG4ZGvHDip1HOJA0aSDnMppOBQQ>
    <xmx:LygnaZDEvCZ2u0K_r3BR5QtjbqSuaHaxLmRQ64rcWevzXpb_XHKGZg>
    <xmx:LygnafJsk58MBTl_KXbFURZgIBUqYg3k7FGlqkAdLlwnWbEVkVXNKQ>
    <xmx:MCgnaVlYBPlP8yhr_EN-DyevFM8T4OAYltKpdPIUW9IcBA1oMTOxVETH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 11:17:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  toon@iotcl.com,
  sunshine@sunshineco.com,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v2 2/2] refs: add GIT_REF_URI to specify reference
 backend and directory
In-Reply-To: <20251126-kn-alternate-ref-dir-v2-2-8b9f6f18f635@gmail.com>
	(Karthik Nayak's message of "Wed, 26 Nov 2025 12:12:01 +0100")
References: <20251126-kn-alternate-ref-dir-v2-0-8b9f6f18f635@gmail.com>
	<20251126-kn-alternate-ref-dir-v2-2-8b9f6f18f635@gmail.com>
Date: Wed, 26 Nov 2025 08:17:50 -0800
Message-ID: <xmqq7bvcpy35.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> +`GIT_REF_URI`::
> +    Specify which reference backend to be used along with its URI. Reference
> +    backends like the files, reftable backend use the $GIT_DIR as their URI.
> ++
> +Expects the format `<ref_backend>://<URI-for-resource>`, where the
> +_<ref_backend>_ specifies the reference backend and the _<URI-for-resource>_
> +specifies the URI used by the backend.

It is more like "<directory>" that specifies the local directory the
backend is told to use to store its data.  It feels way too broad
for what the initial implementation achieves and what the design can
potentially include, to say "URI-for-resource", I would think.

> diff --git a/environment.h b/environment.h
> index 51898c99cd..9bc380bba4 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -42,6 +42,7 @@
>  #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
>  #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
>  #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
> +#define GIT_REF_URI_ENVIRONMENT "GIT_REF_URI"
>  
>  /*
>   * Environment variable used to propagate the --no-advice global option to the
> diff --git a/refs.c b/refs.c
> index 23f46867f2..a7af228799 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2186,15 +2186,73 @@ static struct ref_store *get_ref_store_for_dir(struct repository *r,
>  	return maybe_debug_wrap_ref_store(dir, ref_store);
>  }
>  
> +static struct ref_store *get_ref_store_from_uri(struct repository *repo,
> +						const char *uri)
> +{
> +	struct string_list ref_backend_info = STRING_LIST_INIT_DUP;
> +	enum ref_storage_format format;
> +	struct ref_store *store = NULL;
> +	char *format_string;
> +	char *dir;
> +
> +	if (!uri || !uri[0]) {
> +		error("reference backend uri is empty");
> +		goto cleanup;
> +	}

Equating !uri and !uri[0] and giving the same message would not help
diagnosing an error, and not _("localizing") the message is of dubious
value (after all, the message is not being given to somebody coming
over the network, but meant to be given to the local user, right?).

If we remove the !uri[0] from the check, shouldn't the later check
catch it as "invalid format" anyway, and print '%s' it to show that
what was given was empty clearly enough?

> +	if (string_list_split(&ref_backend_info, uri, ":", 2) != 2) {
> +		error("invalid reference backend uri format '%s'", uri);
> +		goto cleanup;
> +	}
> +
> +	format_string = ref_backend_info.items[0].string;
> +	if (!starts_with(ref_backend_info.items[1].string, "//")) {
> +		error("invalid reference backend uri format '%s'", uri);
> +		goto cleanup;
> +	}
> +	dir = ref_backend_info.items[1].string + 2;

Two questions.  (1) do we still want the double-slash after the
colon?  (2) if so, would it make it simpler to string-list-split
using "://" as the separator?

> +	format_string = ref_backend_info.items[0].string;
> +	dir = ref_backend_info.items[1].string + 2;

These two lines are fishy.  Perhaps leftover from an earlier draft
that did not have an error checking before the previous 5 lines were
added?

> +	if (!dir || !dir[0]) {
> +		error("invalid path in uri '%s'", uri);
> +		goto cleanup;
> +	}

At this point it is very unlikely for "dir" to be NULL, no?  Even if
the .string member after splitting were NULL, adding 2 to it would
not leave it NULL.

Being defensive and checking for NULL is good, but then exactly the
same question on "NULL vs an empty string" applies here.

>  struct ref_store *get_main_ref_store(struct repository *r)
>  {
> +	char *ref_uri;
> +
>  	if (r->refs_private)
>  		return r->refs_private;
>  
>  	if (!r->gitdir)
>  		BUG("attempting to get main_ref_store outside of repository");
>  
> -	r->refs_private = get_ref_store_for_dir(r, r->gitdir, r->ref_storage_format);
> +	ref_uri = getenv(GIT_REF_URI_ENVIRONMENT);
> +	if (ref_uri) {
> +		r->refs_private = get_ref_store_from_uri(r, ref_uri);
> +		if (!r->refs_private)
> +			die("failed to initialize ref store from URI: %s", ref_uri);
> +
> +	} else {
> +		r->refs_private = get_ref_store_for_dir(r, r->gitdir,
> +							r->ref_storage_format);
> +	}
>  	return r->refs_private;
>  }

If this mechanism is for consumption by "git refs migrate", is it
possible to reduce the blast radius by giving the command a command
line option to do an equivalent of this?  I really am not happy with
this environment variable that can change the behaviour of such a
low level layer from unsuspecting programs that are not ready.

Instead of tweaking the behaviour of this function via environment
that can affect any programs, can't we give these callers like "git
refs migrate" with specific needs set_main_ref_store() function that
takes a ref_store and a repository.  Then they can use to call into
get_ref_store_for_dir() to obtain a ref they need.  "git refs migrate"
already takes "--ref-format" variable, so all it needs is another
"--ref-directory" command line option, right?

If the ability to set the ref backend location for arbitrary program
proves to be useful, we _could_ give the same --ref-format and
--ref-direcctory command line options to "git" itself (like "git -C
there" runs any subcommand in the named directory), which does the
the get_ref_store_for_dir() plus set_main_ref_store() dance,
modelled after how "git refs migrate" does them.

Hmm?
