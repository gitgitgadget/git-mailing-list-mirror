Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C555248F72
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776455455; cv=none; b=lJWSXJZQHTtiUgqo49hhdFZwyvOVfxr8puAzsc9ibDhEGCGp1UTt+D74o6V1mnDGNPqxmnej6LremGag/3r5AwvNw++xZWYpkPuRgyUChH5hJPDEWJTGx1k/yebaW9WBrnMhcTeu6X+oa7IZ3KFbSnB/IlCL7qicBFPRmE6y2SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776455455; c=relaxed/simple;
	bh=3h7B4CrM02Aqx/lK2+0FNIu3BnYac+UK11eBaYBEVi8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rYagAJPCTnVrffNxZR5qYrYjxF9k/WbH/egTEVsCT1ciBYDeCfB0J31mAzYqz1FI6YyZa+EQ0eTPu381sbsLLURpPLxDvm5WBxfGpGFDo6d6wacZxjUQzcyiEq/IYCPUmAAPrccU79NJsVci/c9DeoaUlCBznAv9gPFyYRgQeUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dWXibXoq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qzXhA3qf; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dWXibXoq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qzXhA3qf"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 634F11D00178;
	Fri, 17 Apr 2026 15:50:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 17 Apr 2026 15:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776455452; x=1776541852; bh=qy4qKCnhk0
	PjuUEm84aHH/sLJOnXvGBlRBo+CBcamAA=; b=dWXibXoqSnl2OQciHuwtsh7p33
	9IP6CZ1j6mmWHzIyQdYHvrvLVqJp76bshWCaASOnOZ/+varvusMG8dFuql8KM+gU
	dOoRzoIFsBSKVUFt8/oPgNvK5+d+lT5beAvw4x1qMb+nVA6g7k8PqzXiuUyxYL9i
	pSXm4lummXzYG06I3QGV4T3Q0dM+8Zw3LjFWmeW8mXnKxZ3GyP+AWhWSbrX56f1V
	wORdLmAZ89BUhfYI3DgOIGoakqRi+qV6j00Gtw1eoenh22M8Ke/3tB3lDQ8ZC9dz
	rvr556dQTuOz/eJtI0CGkjj9ctFea8cR1W2/VBTkn5qLyG8yJQVo6putd/GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776455452; x=1776541852; bh=qy4qKCnhk0PjuUEm84aHH/sLJOnXvGBlRBo
	+CBcamAA=; b=qzXhA3qf+hUYEcXUZ4Nnit+hJBMO+oYD9nEUourZZPP2TwR3Us7
	Z9Fk3RMAyIRrJFb+JDA4vsycnAjfTWKRHg3n1KPFS1pYRutKA67EIkmFLNnXb+M5
	MJ+g7IVuIJXD86MHLqFGxOmutyG013/3d56nNVtYPnbK8saFTqSihSSSyrQ6bauo
	fCWlEqkWzXL5ZYyw3Y2u+usNyToXIKCKnL0U99SHpyeG9sJF0aAi2N4pejidCDpO
	i1RTqCtvH/MZxDvaqqlZYGgq+husVu1E5NJ4gKdH9oUr1NZ57pvXMD9Ip/IZzN10
	5Qd1gPK9RFyBcNaZxd9QTnZK0i2yCevJvkA==
X-ME-Sender: <xms:G4_iaZtefX6fQEXiFb-DDzWYlchg3e1mb4_qJ8FzPTw0O4CCqv6ZjQ>
    <xme:G4_iabz5MQOEzgABbMBmozfWyyxAUUVTh1mGyr4nnOIyMIFDF83PuLukMTP0ER3jD
    Ku2boqxpG626q9zobZWb_ZpXXjrjjT0zk4d5nS4S7j8lNp7fH4LAg>
X-ME-Received: <xmr:G4_iaUAMbOogO7hIU6he4gtjsTp3-wefV8pmlIqqxLS0qlMbersI-J_dWANSBPosrgah-wF0h3kiqnHAZ9QTrqlrIt3yNXQr1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehtdejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkvghrnhgvlhesshgthhhlrghrrghffhgvnhhlrghnrd
    guvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheptghhrhhishestghhrhhishguohifnhdrnhgrmhgvpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhm
    rdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:G4_iaRfWMj1tkgvEQnloFOYXXFdGpVGcfXi-uHiFHo96KKJ7K5Xrdw>
    <xmx:G4_iaWlIOhg5oof-OGkQyEC0FZatEsgesHLoheaOfO1eOVDq_ILN3w>
    <xmx:G4_iaQEveXv1HU2O1o_lInmoB3RICx2gDPUw3Ab3t1rqyEpkozOatA>
    <xmx:G4_iaW7FA5EqAFG35t-VwiBuWWhifvONnT6cDnKk3zsEnH6hrda3_Q>
    <xmx:HI_iaQzGNCVhu6IL9Nig0D7uA-UXiEtIbb5TJDa6y6DtgwuSVBaYC9Cu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 15:50:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jonas Rebmann <kernel@schlaraffenlan.de>
Cc: git@vger.kernel.org,  Chris Down <chris@chrisdown.name>,  Jeff King
 <peff@peff.net>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 1/2] bisect: use selected alternate terms in status
 output
In-Reply-To: <20260417-bisect-terms-v3-1-d659fa547261@schlaraffenlan.de>
	(Jonas Rebmann's message of "Fri, 17 Apr 2026 18:48:30 +0200")
References: <20260417-bisect-terms-v3-0-d659fa547261@schlaraffenlan.de>
	<20260417-bisect-terms-v3-1-d659fa547261@schlaraffenlan.de>
Date: Fri, 17 Apr 2026 12:50:49 -0700
Message-ID: <xmqqjyu5weli.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonas Rebmann <kernel@schlaraffenlan.de> writes:

>  	if (!state.nr_good && !state.nr_bad)
> -		bisect_log_printf(_("status: waiting for both good and bad commits\n"));
> +		bisect_log_printf(_("status: waiting for both '%s' and '%s' commits\n"),
> +				  terms->term_good, terms->term_bad);

I think this was new in v2 (which I somehow did not pick up).  Good
finding, but not limited to this one, I wonder how these custom
terms interact with localization.  The 'quotes' around these terms
do help by hinting that they are not a normal adjectives given to
the noun 'commits', so that might be good enough, but that still
assumes that the .term_good and .term_bad, even when they are not
'good' and 'bad', are good adjectives that can apply to 'commits'.
I'd expect in most use cases that would hold, but the command does
not prevent you from calling more recent ones 'dog commits' and the
ones before the transition point 'cat commits' ;-).

Of course, rephrasing the above to

	waiting for both commit(s) marked as '%s' and as '%s'

would be ultra-awkward, even if it may be the safest.  So I dunno.

> -				error(_("unable to verify %s on good"
> -					" revision"), command.buf);
> +				error(_("unable to verify %s on %s revision"),
> +				      command.buf, terms->term_good);

And from that point of view, this unquoted "ON good REVISION" might
become a problem, because it asssumes that .term_good would be
readable as an adjective given to the noun 'revision', which might
not hold true even without translation.  The command.buf contains a
command with its arguments, and .term_good contains the custom term.
Perhaps both should be placed in '%s' quotes?

>  				res = BISECT_FAILED;
>  				break;
>  			}
>  			if (rc == res) {
> -				error(_("bogus exit code %d for good revision"),
> -				      rc);
> +				error(_("bogus exit code %d for %s revision"),
> +				      rc, terms->term_good);

Ditto for quoting 'good' that is no longer a normal adjective that
adorns the noun 'revision', in the context of a translated message.

> @@ -1314,7 +1317,7 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
>  			puts(_("bisect run success"));
>  			res = BISECT_OK;
>  		} else if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
> -			puts(_("bisect found first bad commit"));
> +			printf(_("bisect found first %s commit\n"), terms->term_bad);

Ditto for quoting 'bad' here.
