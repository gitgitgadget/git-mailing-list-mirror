Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023FE3515CE
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050417; cv=none; b=RWS8PAw4E37/Zd+n0HOCoz0Y6e6aKs8xZUo50LaNFRjdvZaHo32D7oz6f+xewWc9bfk4IpO7wgMoo5re1DcwRrQDzxpnw2m7rmKRO8CHDVG5rdT9g/HkhnN/LiPH9SkRgQ4441lCqv479fLmj7kuZCawPKhyHR0ysO46wCCStcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050417; c=relaxed/simple;
	bh=6z0yTRruZzkvmOJeyEIf/ax6HoCH/5BX1o8SxwOM+68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0so14N58CjlNXfR5kYqtv7+bL8/6bYDwn0K2WEIhB0gDO+L7tvGfYwzAXyK3hfQnVAh4R7giUTvyBrSBQ7vmeswJpBqM32ahSzeNqO3rwBwDv8b3pguSm/s7ZQmzD33IByJYmaiaPG+7BB0E2/6uzsa4KzXYrwJLIBFcrgopzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j0mweXRR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=byaSIgCU; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j0mweXRR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="byaSIgCU"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E1571140005D;
	Thu, 10 Sep 2026 10:26:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 10 Sep 2026 10:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789050413; x=1789136813; bh=h0reputw9z
	0torsT5YoEX9bkTpyTjuXk58aoCxWO+SI=; b=j0mweXRRPpKDzH/JPUY2nIUCl9
	DSF7MbBGu9y6HfaMxBD/5JFLA4mN0P7/dvzJiQJx4QnKdT+pccn4UluYaKXmomgW
	cbiD01jqac/z8F3EOr2fGXQlv5YTrnavwmQ0r4n+CeLrlYjr2Dg+hlOx6td1VkYF
	H3JdjwzJ+cb8+uw0DjT8S9MwC+oJ4TLpDS5ihXof+NoklZw0SRzQ4xCNZhcsM140
	XL3s1ApvxDM43F7FsY3LycFIimH6loTyi4Hi4cMmaJohKYkw1ONxiJEA5febqWrf
	kUnxIEDWAHTCVEjpbPWlxatOJ/uOVUt+x/3Yi5f68JV0WTTJuyospTeq6ZUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789050413; x=1789136813; bh=h0reputw9z0torsT5YoEX9bkTpyTjuXk58a
	oCxWO+SI=; b=byaSIgCUPSKvMtjLRoRBKywQrJFzjZh1ZNjKG5Mcj7CXMwKEyCC
	Da4HYjJm1vQVquXZRZQKIafQSBtNiFXQnGsg7pMp08UXkHoaMiEtDDwlsWkrzF49
	DuJB5vuhbkxfl+6hKIYzaIdkxP28+IYZyCPCM95Vqen/hQfsgnOdvt6F55ecGzUt
	0ZGdXLpt2aHC+vL6NZ8pjVJ+GV+5zW7dgbv+eBJQdA7F9AFgz35AAVSLNMu9rARu
	H4tQEF5bAU7OV27apUndXMPq8adzXqEOFyDmuaYFijGXjyCx+avJ0Qljx4lCtANO
	b4gmE6h5ygFf4ambHCPk25Wxbk2yVVQJxmQ==
X-ME-Sender: <xms:Lb6iatth8XfBFvegzeHL2fqrg1zqf521SlxNkKoHj_O4MZFdVkrzzQ>
    <xme:Lb6iatVSwiqWl-a196HqF2mFkaJMC21oTMsjmSHw5dHflNvx9uVwTw9_ym3RvuC1D
    KZfwCBL2gApktZ9Jjyn1NkIcDnF3ezi_Mf8J_9RyhLzUOvv8xRSjX0>
X-ME-Received: <xmr:Lb6iapE1l4At_jTEwXYzog6QUqZ92EARd6RXyzQw6JCRXt5UxkY7Cg>
X-ME-Proxy-Cause: dmFkZTGEP2cImBJzuW9v0KesgF+w1wMpVZ3xulVTy7KD/2Xd/qcAIepYSmd9Qw+51EWqNY
    mqFE6w99UhzPx2D23M01xLeIzhnpTDMVcfKLzyPI771OmpmUNjFybzbJC+SjUg1+rY/j/l
    9B4JOQi2oi+1Rr1iSwsb2a22SYP5r0PCWlrCz9ri2USCJ8MsXceNWgYkH8bfcZnksn5oTB
    wZ98VU/TkEjnxUCH+u2zyya7qqrSlZ4Mh3qNf7v6xEYaye1DV6ADXrBU2Me0SKEBYr4vF2
    Yw/d5+SP0F+Wp19ySgQJjGopqUoMnghkMSRKn0hvemJiZ7Zb+v18YQWtnNGSMQ01bzMDdU
    JHfs7s99y1SiKH5EXO+WPP037M1WNQFuxREVvzWm8p23EoxWWKamvOF8Ap9LpydtZfrMLv
    oDXakp9UuDrXzkwq2tsW5ncDzmmQql8tVMonaKU3ziVNWZb72kIU0xH8VGsqg6QDwioWbX
    b4NUe+hnjcFwJLyxbvIMdQHgcveqL276uX0vRgMGJ6J54HhAxsDItxBds1K8eWwZS+ttxu
    kFuNHI55im9/pdQ8zz2EJQNeA3E9Xloie9gRuKMUWCy0iLroIDzDpUOnAOu9bN7r7EKsSu
    J/EaJMRGtF4TOFsPcKXaB+QuWzsJBzSc31KcgW0XckxVsq/OSo3CyXtf119Q
X-ME-Proxy: <xmx:Lb6iav0-zz9WxjSmREgc9z_eZj_OaSxLqlgDn8zheY2JGsrP0L148Q>
    <xmx:Lb6iarPcJgo5kKyOrFFw0koWmxUvhYVXdXvPf8ZFPdBT3iAxw6cbxQ>
    <xmx:Lb6iau4j1e9tpo-XzQapl9MZgTLsaXVVSvSoBCdrJRY_f0WqUZ3yTA>
    <xmx:Lb6ial1oqXVXZFbD6l6OcjN8Ya7f0zbf9yVvr1UCVNl9VJZTwuHU9w>
    <xmx:Lb6iaqTkVNKkvYR0zZRRXxluuqIzdk1rCuIhtH8OATlBvA9GlhnuvpG8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 10:26:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 12b26035 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Sep 2026 14:26:48 +0000 (UTC)
Date: Thu, 10 Sep 2026 16:26:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 4/9] builtin/clone: refactor handling of
 "--reference{,-if-able}"
Message-ID: <aqK-IYVKCKp9ExmY@pks.im>
References: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
 <20260909-pks-odb-write-alternates-at-creation-time-v4-4-d8a78ffc32e4@pks.im>
 <CAOLa=ZQf3XcX_G1H+vNSQtpU-Oj56pda0WcJAORw-kQMEPvTTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQf3XcX_G1H+vNSQtpU-Oj56pda0WcJAORw-kQMEPvTTw@mail.gmail.com>

On Thu, Sep 10, 2026 at 02:37:31AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index ac5843d7b9..8786a49332 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -154,24 +154,26 @@ static char *get_repo_path(const char *repo, int *is_bundle)
> >  	return canon;
> >  }
> >
> > -static int add_one_reference(struct string_list_item *item, void *cb_data)
> > +struct add_one_alternate_data {
> 
> So this is `add_one_alternate()`'s data, was a bit confusing cause I
> first read that this was information regarding a single alternate, but
> then it also has a field called `alternates`.

We can also rename this to `collect_one_alternate()` and the structure
`collect_alternates_data`.

> > +	struct strvec *alternates;
> > +	int required;
> 
> Question: here and other places, I see some of the boolean-ish fields
> being declared as `int`. It doesn't matter, but is there a reason?

No, there isn't. I'm probably just still getting used to new fancy
features like that.

> > @@ -218,14 +220,20 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
> >  	fclose(in);
> >  }
> >
> > -static void setup_reference(void)
> > +static void collect_alternates(struct strvec *alternates)
> >  {
> > -	int required = 1;
> > -	for_each_string_list(&option_required_reference,
> > -			     add_one_reference, &required);
> > -	required = 0;
> > -	for_each_string_list(&option_optional_reference,
> > -			     add_one_reference, &required);
> > +	if (option_required_reference.nr || option_optional_reference.nr) {
> > +		struct add_one_alternate_data data = {
> > +			.alternates = alternates,
> > +			.required = 1,
> > +		};
> > +
> > +		for_each_string_list(&option_required_reference,
> > +				     add_one_alternate, &data);
> > +		data.required = 0;
> > +		for_each_string_list(&option_optional_reference,
> > +				     add_one_alternate, &data);
> > +	}
> 
> Nit: might be nicer to read
> 
>      if (!option_required_reference.nr && !option_optional_reference.nr)
>         return;
> 
> The rest of it doesn't have to be in the `if` block.

We'll extend this over the next couple patches, so I'll leave this
as-is.

> > @@ -1339,8 +1348,10 @@ int cmd_clone(int argc,
> >  		warning(_("--local is ignored"));
> >
> >  	create_object_database(the_repository);
> > -	if (option_required_reference.nr || option_optional_reference.nr)
> > -		setup_reference();
> > +	collect_alternates(&alternates);
> > +
> > +	for (size_t i = 0; i < alternates.nr; i++)
> > +		odb_add_to_alternates_file(the_repository->objects, alternates.v[i]);
> >
> 
> So now adding the alternates is moved out of `collect_alternates()`.
> Nit: might be nice to mention this in the commit message.

Will do.

Patrick
