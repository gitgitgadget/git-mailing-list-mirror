Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FF51D86C3
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738567870; cv=none; b=bwKRcIpX92wmOK8+c0IdcFH0+FYjRp3BwUrvcato+NZ+ualct9ABpt2h7bqA3cuhAKthaeW2UuQkrBvhMRp8X/5YnghGTBP5uWp0mXUVZgr0fbiSHlIqyECvP10N6ay34pLUxqIJBsBApG8A/Zk/6bBXtMyXuNHwR3/3zrIKPJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738567870; c=relaxed/simple;
	bh=/P0cDN/25S44plHOHdIsQifh67h4v3RbaomiaoNjM1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNjn9kydE/9pSlaCQJqSsVVq8lSv/XX6tXWAqHUdX84bXpbk9M7lKiOhW9QQwtB2We0T4teSwvfW68n0+/wD+6hGobxkUj+ks7hFoInFVr1EkGWQwk1ndKf5YBOa/VwMjKFNRm4PPC90bz7bcfqqOhqDXZAA0R3kBc0a06Yph9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XADLzww1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pLB1bIzq; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XADLzww1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pLB1bIzq"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F70E1380843;
	Mon,  3 Feb 2025 02:31:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 03 Feb 2025 02:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738567865; x=1738654265; bh=rFLbSvMvHK
	2+Z0LisM43Ow+uZ0rQZUgYD6J3fVtgetI=; b=XADLzww1fNYpEyfdTGK3WfBU3k
	gBeP234uIgZsWwsZ3/wTkJi6Jdi6Tz6vnSvQGpdceqAeCxtsmLBCHN9N26DdJ1+x
	Asgh5LEHuVxlGPIAabwrJ785cmJH5A8KqcojnEnSkV4q1C98Pxi0JMm16BkISnkS
	Q+ZI1+4o6vjSHATN5gRzfR1jt/I4S91bGDUDiBxTlAMdKF70cYipu3TYTd/SiIwA
	WypO5TOhVtG1Rwostac78HpTvUsiuOvDZkA8X0Gw0CR7kH9Le6FmSR7vgaL+cGKh
	84MjklYbI3XbPeB1meZLOA6iYTxQtvnCEnto3RwE8gayxP6i4KyffxgmqfEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738567865; x=1738654265; bh=rFLbSvMvHK2+Z0LisM43Ow+uZ0rQZUgYD6J
	3fVtgetI=; b=pLB1bIzq4kPHH7nLAGwouCC5rJY+BwObXb3gJs4jEfKLdSUB8Vi
	qdqySX4yyZVgAXA/9W5S+eVFizW5eh/KqW7rTbvqpEMyeJaErAPlkb8iTfcFxmAs
	dz3XRX/VYUCD2NQXqGgLWqWpp17QWArYbLWoaV55x0AoczmvdkEQ76M0xza6uDAO
	yvCRaeB7jH+qnHe1r7HI0VU3RJTEJsg/9HjqDTqhcbscxjmdt09mX0BEHyWooQVg
	ml/92xcAM8JWLl+TBVNr6bHwZRqtUx1oor8P9cbhoKVAoVtwcatM8KwWuYNUcU79
	4EhVQJcsEC4ZdmXLH6TuVUj8U4aW5mrVslw==
X-ME-Sender: <xms:uHCgZ84YzpKkXCoLYWOo_u08nQ0KNey-Q0g1AswjLWFwMFnZIKQlOA>
    <xme:uHCgZ96_53Xjt2VjmcPOyTMrcYR3yaa4ysOSDcBRkoaU2BnrLT75OIQmJGehzcf-_
    KlMkVbjzPAh2NQH8w>
X-ME-Received: <xmr:uHCgZ7d9Fsav5e0stHC-j2ZlTb41MHVMJCAhv33D7m4fdUlqNSRVzmicocl0LdkpRQuw04kpiCtw0ZZUhIYPvxR19K2qtTdYXqfdmYr8QaC-JA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghp
    thhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:uHCgZxJdHWiF97CnnzUbvBVr1Mi2H5SwDGdGoZUh050q5BgakaAhZQ>
    <xmx:uHCgZwKR-lrDfBBM__-Uk4RcMlFAqg6Q_jQ-8qEVDdUVg6yAvy8YIw>
    <xmx:uHCgZywmtsVPevtz3fn_HIDBFtA4aYxo91mam-UGatqrw7gguWeB0w>
    <xmx:uHCgZ0JaB6Ba7tPtPgzNwnZVzJRcH2QTslYhdPO9chqR0wI6MJOTWw>
    <xmx:uXCgZ1EvfZA6fVted449gKUkmOpc93TiPk5MHnjAevkIz-dImdEMu2c7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 02:31:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 536776ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 07:31:01 +0000 (UTC)
Date: Mon, 3 Feb 2025 08:30:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Seyi Kuforiji <kuforiji98@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] t/unit-tests: convert hashmap test to use clar
 test framework
Message-ID: <Z6Bwr6hM54nu8nSS@pks.im>
References: <20250130091334.39922-1-kuforiji98@gmail.com>
 <20250131221420.38161-1-kuforiji98@gmail.com>
 <20250131221420.38161-2-kuforiji98@gmail.com>
 <6be977a0-4bf9-4568-9b28-cdc988a49b89@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6be977a0-4bf9-4568-9b28-cdc988a49b89@gmail.com>

On Sun, Feb 02, 2025 at 11:09:25AM +0000, phillip.wood123@gmail.com wrote:
> On 31/01/2025 22:14, Seyi Kuforiji wrote:
> > -	if (check(entry != NULL))
> > -		check_str(get_value(entry), "value3");
> > +	cl_assert(entry != NULL);
> > +	cl_assert_equal_s(get_value(entry), "value3");
> 
> Unfortunately cl_assert_equal_s() is not equivalent to check_str()
> because it does not handle NULL correctly. I think it would be very
> helpful to fix that upstream. The diff below shows a possible solution
> which avoids any ambiguity as to which pointer is NULL by only quoting
> non-NULL values. In the long run it would be good to fix
> cl_assert_equal_s() to properly quote control characters as check_str()
> does.

That's indeed something we should fix in clar.

> diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
> index d54e4553674..16f86c952f7 100644
> --- a/t/unit-tests/clar/clar.c
> +++ b/t/unit-tests/clar/clar.c
> @@ -754,7 +754,12 @@ void clar__assert_equal(
>                                  p_snprintf(buf, sizeof(buf), "'%s' != '%s' (at byte %d)",
>                                          s1, s2, pos);
>                          } else {
> -                                p_snprintf(buf, sizeof(buf), "'%s' != '%s'", s1, s2);
> +                                const char *q1 = s1 ? "'" : "";
> +                                const char *q2 = s2 ? "'" : "";
> +                                s1 = s1 ? s1 : "NULL";
> +                                s2 = s2 ? s2 : "NULL";
> +                                p_snprintf(buf, sizeof(buf), "%s%s%s != %s%s%s",
> +                                           q1, s1, q1, q2, s2, q2);
>                          }
>                  }
>          }

Would you mind creating an upstream pull request with these changes? I'm
happy to review, and then we can update our embedded version of clar.

> >   	for (size_t i = 0; i < ARRAY_SIZE(query); i++) {
> >   		entry = get_test_entry(map, query[i][0], ignore_case);
> > -		if (check(entry != NULL))
> > -			check_str(get_value(entry), query[i][1]);
> > -		else
> > -			test_msg("query key: %s", query[i][0]);
> 
> It is a shame that we're removing all of the helpful debugging messages
> from this test. It would be much nicer if we could keep them by using an
> if statement and cl_failf() as we do in u-ctype.c

I honestly think that the debug messages don't add much and only add to
the noise. You shouldn't ever see them, and if you do something is
broken and you'll likely end up pulling out the debugger anyway. So I'm
more in the camp of writing unit tests in a concise way rather than the
needlessly-verbose style we previously had.

Patrick
