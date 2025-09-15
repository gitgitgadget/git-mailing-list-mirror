Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C349F280312
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 06:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757917661; cv=none; b=WfSjlY5gWUMXlCXwkmuKzNt3MemSJa2NL9XA+zYOpmhRGr31i7PRr3oT/LiPSkAkpSwY3FISdph/bUyS6grITLnxswdIayZ3Ies7WUfVH8gTncqb358UD7ePJZyExAzEo7CHavvHMdTaO3wkujH4V06wC3sCygH1W+f47p6ROsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757917661; c=relaxed/simple;
	bh=5IHUkZPH5xi5PjpWPHZSBu7SIiZigx/999NYmwPkrNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/vOWpz9sGyEw2NJEMIudCO4ZCmcrdepb0ws4bYcjNKNeruX2HYf2bHUZhUlSO5AzjZdrZTnv1OJQlIpYdIliB9kkCAW9l1S6ve4ExVxCKDAcEm6WYCCzaoX03f2TocCRF3VSUaicwmPe7OBj0Tk+IZuKz7TWv6RZ9vXya+cGvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BKm0UvKD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cv2QbUTD; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BKm0UvKD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cv2QbUTD"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C452D1400174;
	Mon, 15 Sep 2025 02:27:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 15 Sep 2025 02:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757917658; x=1758004058; bh=13oDpv64V4
	M0K/8NUcYn8sqPmYTn0atp4bpFcL80N34=; b=BKm0UvKD/eD5xJy18+UT2cRZNF
	xtQkARYIndw4HPEjMVw/uAYJcpt6EmE6aUPjH08PEMSzkYj/2rDFBcgXw6FjGnhp
	rzYOgeSPyVybeff+UNz0u7DEOBQiJQFussJl8HNvAUuTYwnDlhrv9Vj5wED3DzZE
	ccABOZG2R9CfozoyoaeYMoZHM/S1Wjv5s63GziAgiN1WG7huqKApiY9m8wURLnnX
	UNRTSDLGp9jHekPcDOkUf38sDkXdaEdyjyNrknn3jvWFOdVCMmalvELs3SG8gR0b
	ZHo5+6VQJDMwgN8QqTQEQT/1HX/3NYbTSQ1iIvU0TZqNl44+ZHkaU5SW6Gdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757917658; x=1758004058; bh=13oDpv64V4M0K/8NUcYn8sqPmYTn0atp4bp
	FcL80N34=; b=cv2QbUTD32XK5d84ANbQLZEmuiyboquhMowo04d/Wr/5Q053Lp/
	aE+LkeICAdjETvAfXwV5rglv1pVdwQChnQH8JwCK+73riEE5Hm3hvyfwmb/XSdi+
	SF6g/3DzBNPQEldTwTQc09Ctz/YQJ/dfQzFO18spEsc+6EUS5kSXpgagF4V47Q/4
	OFOLDcJfRig6KMcUhAB048knbKlyuO/tdaduQOfqGVDwOi06QTrCAT4gQftQ4rMu
	py5H8p00KLhjHjHGqhYLrMSb4RY/faAjuPpC6NBzUreZcyBggQiSh30zP9Xh3k5p
	WYo2fywOx3K1DpP1N0G/sGjdAsFajdpABlA==
X-ME-Sender: <xms:2rHHaK2eNNFELbZrQzQSVROPKyzHTaVZIPcbKa6AznK0iSNVbVDn9A>
    <xme:2rHHaKC7_zrZYezLsYG1OuJygS1yqX_T8zm-wh_Swc518Dx7kQBtW-eomuB7GxnUo
    _by-ei0b8YVfjAwKA>
X-ME-Received: <xmr:2rHHaOjA3Q3g47P7iRwu2Bkr5ffdBjQ_mbFFh1-zJYci8UCq0BZZJ_pu4gGNHFcxu7GIUdLNZKuln8E8mM1mDnyEclKuV7lZdh-HCqzD-3ISMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefieeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheptghhrhhishgtohholhesthhugi
    hfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
    pdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvg
    htpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2rHHaEMh2lBbDAgCLBfyeld2sSzVHQGCe2i_KSF64dq0Lbx0mIOCvw>
    <xmx:2rHHaG9ZPgtxef1IJ4KP3nWz-MkbnWI-fdV-tV1wVzpx36gsyRiNOg>
    <xmx:2rHHaNce_QRrCw6Z_19KGlMLUfrfF_1z-XYtih7PiW09YYT8pm8DmQ>
    <xmx:2rHHaNwrY5xMOS1JeCdk0gZTZI5t3YuhZ8QLtOeN8HrdhSldLp66bA>
    <xmx:2rHHaJ33_iRQjKzKeqUV8EINuyjgYz1jFZc8C-2Tm4F5dudDYkv-cqar>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 02:27:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 61ba76a9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 06:27:35 +0000 (UTC)
Date: Mon, 15 Sep 2025 08:27:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/2] fast-import: add '--signed-commits=<mode>' option
Message-ID: <aMex06JNPVeHaw_d@pks.im>
References: <20250912124042.2523683-1-christian.couder@gmail.com>
 <20250912124042.2523683-3-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912124042.2523683-3-christian.couder@gmail.com>

On Fri, Sep 12, 2025 at 02:40:42PM +0200, Christian Couder wrote:
> diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
> index 3144ffcdb6..90f242d058 100644
> --- a/Documentation/git-fast-import.adoc
> +++ b/Documentation/git-fast-import.adoc
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 2c35f9345d..890f05de4d 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -2817,19 +2819,39 @@ static void parse_new_commit(const char *arg)
>  	if (!committer)
>  		die("Expected committer but didn't get one");
>  
> -	/* Process signatures (up to 2: one "sha1" and one "sha256") */
>  	while (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
>  		struct signature_data sig = { NULL, NULL, STRBUF_INIT };
>  
> -		parse_one_signature(&sig, v);
> +		if (signed_commit_mode == SIGN_ABORT)
> +			die(_("encountered signed commit; use "
> +			      "--signed-commits=<mode> to handle it"));
>  
> -		if (!strcmp(sig.hash_algo, "sha1"))
> -			store_signature(&sig_sha1, &sig, "SHA-1");
> -		else if (!strcmp(sig.hash_algo, "sha256"))
> -			store_signature(&sig_sha256, &sig, "SHA-256");
> -		else
> -			BUG("parse_one_signature() returned unknown hash algo");
> +		parse_one_signature(&sig, v);
>  
> +		switch (signed_commit_mode) {
> +		case SIGN_ABORT:
> +			BUG("SIGN_ABORT should be handled before calling parse_one_signature()");
> +			break;

Let's be defensive and convert this into a `default:` case so that any
unhandled value will cause a BUG.

> +		case SIGN_WARN_VERBATIM:
> +			warning(_("importing a commit signature verbatim"));
> +			/* fallthru */
> +		case SIGN_VERBATIM:
> +			if (!strcmp(sig.hash_algo, "sha1"))
> +				store_signature(&sig_sha1, &sig, "SHA-1");
> +			else if (!strcmp(sig.hash_algo, "sha256"))
> +				store_signature(&sig_sha256, &sig, "SHA-256");
> +			else
> +				die(_("parse_one_signature() returned unknown hash algo"));
> +			break;
> +		case SIGN_WARN_STRIP:
> +			warning(_("stripping a commit signature"));
> +			/* fallthru */
> +		case SIGN_STRIP:
> +			/* Just discard signature data */
> +			strbuf_release(&sig.data);
> +			free(sig.hash_algo);
> +			break;
> +		}
>  		read_next_command();
>  	}
>  

Other than that the patch looks good to me, thanks!

Patrick
