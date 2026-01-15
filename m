Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30153793AA
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768481586; cv=none; b=R57jJcigaEMMueJ8amonS2aQxADWKQJLZpgKtQ4LM9qJbT3j5pEVfMWaAcfrPxanW88iIJJ60xBqJbygDSW+oL5MGR+pIMtno6C/aRPwDzXqDcfZdlW4yEF11J981Yb0dSTgcdYtnl0RbGH2pSPS+nerGQE5rrWgyJxhm0CNs/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768481586; c=relaxed/simple;
	bh=yjUzDi7bpN/dCVjGDk45JZNnu/qKe8vhAvS+Nawuksw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaPoqsN4mzk0C7RdbkbP2wYZ7NOFkBX4DThlrrgKyXpSzLhgCCKiY8b3h9jKBfH+eJ6YsEkO6GaJc9SmPCfWewtkMfDpo3E2v2ast/RVnmZ1Z1htzwED0MGFPLetsMlAaSmkyEsNKiPd8mc6IpUG6B9PcG8ftygnPHUUAOS0Sa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b853xnYc; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b853xnYc"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1233702afd3so1021059c88.0
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 04:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768481584; x=1769086384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ehC4aSBk/iKw+4Vq/T8uRM6KFtY4/hJ55OoenNxJnYw=;
        b=b853xnYcq1Wj3afeDNOPMWrktq1xka5Gv5i2HrXIcn3jrEfBmT8ryqK1vf4btwocsS
         8QEYUHJkXg/0SnHOTWDCfppwL5/RVt5e5D07R65f50KFSEGyQaGbrEWADYuLDXOfwuPH
         8RJz2SNaR91GCOGmyAnjKBGOTJfB6jrORCbetq/+UbvNgK+Y9UWXYkCJvo7iWn4Safrb
         y7ctxMRBf4Nhs4Ehi4EbdRGAPAoIHvGHjuXj7p4BgVk15HJ84+pIKUwejq26XHKXlGuv
         MuoR3sPPApTKfGiupftcmL0UsloiM/y2alDlsQ+HCiDVTdpglS7YGF9Ol84XJQsfWxb9
         L9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768481584; x=1769086384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehC4aSBk/iKw+4Vq/T8uRM6KFtY4/hJ55OoenNxJnYw=;
        b=QJpULTxKL6i2FGVgFCBNio4srWvKeQzR6D1dbAPFVGn3LrH7FSfEeKgXMqnMvoH6n8
         wKCVTU5qbwKlFrsDgu2nntazP/hP3bFnxiaVYtrd9ZP2CO2I4cPx99kLGRqL9RH7LLhw
         Md9s+RsAewhi1b7W8J8PcKNSpFOvigjMSD6iMxQ6I5g13S9ekrYqfyNAa6FZNjsGclCm
         jaLs6WXsiVLSNDM48xiA+BoaxhgCbvjtXJL34Y7pgbqYaBz/fXz0sUPrV5YkfxeWD3Wn
         nEP9wlTQZwmhpZGI6C1oaC0ceOKL/eI4GbOzTKZUhnxGRFEh8WufN+FpzGpL3avVqoux
         pl+A==
X-Gm-Message-State: AOJu0YytQlA/YHGPYbm6WQ6/0dAcQloy6YZzwqp9mK3HBaPcrN8dttVa
	PpbgdtfxH6jh62npFREbApd78KHijdJPGae7vW3TaNRU8QQh6hfJN9P5
X-Gm-Gg: AY/fxX6kvLJpZI6l4HCCkpJSbRXDFTHf+DIaTLa1YerasFtmy8JcGE49/ChM6yAIj7q
	CjzArVl5LJha6hsVUCAkLbcPXDrQ+31ea9Lf+1BtDdxSbUwaxxGsuYH7h/PZ9cuSMmeGJr6cPIr
	sXWgeuUfgia5I3H5PnfNI67hLMggNfWbonXjuoDOyQtbl/7WLgaKeP7FArldj8WhQaxYLHukB6X
	QePcOySll3ktVPj0IvD0qPw2eTSMR0hdgJfrvAuQa17aQFnCCk/F1AdZCAIcUARO7eiOGO2YEU9
	05m1lQEyl8n8YwqA0M/H+GOsloMppZAyvPcEMhKXvr0n/KAcg/Y+CneAYRYpreXx4684Xt8sKBy
	45UDmZd+3QKE3e68Z1ki+yWM3wTaV2Qv1ELqJsTYKTJjI0FzG43H7NJkDHVQzCRl1gnR3cBe2K5
	+hti07NA==
X-Received: by 2002:a05:7300:e8b0:b0:2ae:5b71:d233 with SMTP id 5a478bee46e88-2b486dcab0dmr7889104eec.19.1768481583656;
        Thu, 15 Jan 2026 04:53:03 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078ccf4sm21702980eec.16.2026.01.15.04.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:53:02 -0800 (PST)
Date: Thu, 15 Jan 2026 20:52:59 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 16/17] builtin/fsck: move generic HEAD check into
 `refs_fsck()`
Message-ID: <aWjjK8fmf8L7vlNi@ArchLinux>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
 <20260109-pks-refs-verify-fixes-v1-16-3587dba18294@pks.im>
 <aWJUm-hrPquegbdf@ArchLinux>
 <aWSuObEsFaxi1NAf@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWSuObEsFaxi1NAf@pks.im>

On Mon, Jan 12, 2026 at 09:18:01AM +0100, Patrick Steinhardt wrote:
> On Sat, Jan 10, 2026 at 09:31:07PM +0800, shejialuo wrote:
> > On Fri, Jan 09, 2026 at 01:39:45PM +0100, Patrick Steinhardt wrote:
> > > diff --git a/refs.c b/refs.c
> > > index c3528862c6..a772d371cd 100644
> > > --- a/refs.c
> > > +++ b/refs.c
> > > @@ -334,8 +334,18 @@ int refs_fsck_ref(struct ref_store *refs UNUSED, struct fsck_options *o,
> > >  
> > >  int refs_fsck_symref(struct ref_store *refs UNUSED, struct fsck_options *o,
> > >  		     struct fsck_ref_report *report,
> > > -		     const char *refname UNUSED, const char *target)
> > > +		     const char *refname, const char *target)
> > >  {
> > > +	const char *stripped_refname;
> > > +
> > > +	parse_worktree_ref(refname, NULL, NULL, &stripped_refname);
> > > +
> > > +	if (!strcmp(stripped_refname, "HEAD") &&
> > > +	    !starts_with(target, "refs/heads/") &&
> > 
> > We would first check whether the current ref is `HEAD`. And I am
> > wondering whether we have some common APIs. And I find the similar logic
> > in `reglog.c::is_head` like the following shows:
> > 
> >     static int is_head(const char *refname)
> >     {
> >             const char *stripped_refname;
> >             parse_worktree_ref(refname, NULL, NULL, &stripped_refname);
> >             return !strcmp(stripped_refname, "HEAD");
> >     }
> > 
> > I think we might just extract this common logic to avoid introducing
> > repetition.
> 
> Hm. We could, but I'm a tiny bit worried about just calling it
> `is_head()`. It might be surprising to some callers that there isn't
> only one "HEAD", but that this would also recognize worktree HEADs. If
> somebody just goes like "I wanna know whether I've got HEAD" they might
> not think about that at all.
> 

Make sense.

> So given that the complexity is comparatively low I'd prefer to keep
> this as-is for now. On the other hand, if you've got some proposal for
> how to make this interface not confusing I'm very open to that :)
> 

Yeah, I cannot give some better idea, either. Let's keep this as-is :)

> Thanks!
> 
> Patrick
