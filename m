Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01203F12C8
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529809; cv=none; b=TJXIiF2t1sAGtCNkvW65y6/lJJD0YzYDOslsozY/F+0ax4vikeiyt9tOlJTFUUs3PwLRdCR0l+6DNEb285L/6Nb036FKvQFBU1bKNXXFw3y8X7ZLuaShH22NB/s/CL60M1TBR4DAIRUjDOA6j/Y2pNPB1soqk227+Nf+fSpdiDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529809; c=relaxed/simple;
	bh=9tJiS2mLtB5VMxzMC5MxSJrWEeefTVK0eV+xkjUxDNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kj4hUEYXMadAAJVniRRYRMsAjHiCR+hzghMevBnHNJh3Oc7+VkLQ2vtz1f13o5BExbb7GXsZKGpFZ4PAYTdXuvJd3Knh1CRhAz2BBYrqJXeechNsIhkPXwhHVuksmtFvzMaq/itUD4bo8s7EnY33EoRRHviJYQWF8hOsiALCRvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sDUzAObV; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDUzAObV"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7eb4d532e65so460235a34.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783529806; x=1784134606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ykV1qPXL/5RTfhpzKzHoTzgtwvITWx+N0GJVrtZRszA=;
        b=sDUzAObVO7yP5Eb+6vBV/vnp9PL6CRp1RX1LdXU1DS+kJKv6Une39iw5Rjhi1SFMPD
         yq7gJj7CXtWjyqiLt6ykxvvy97NdGOzrmazQIqj+uLjrwShzL/iOzDIjJVb8P81D634b
         1sCZtltVtIa+Dnm+9EzTScqSTXmxuOkgA1SEqX7Kme7GkCMYRnPGdUn9HscY9UyqCpZn
         SYfWNtHdTQyCP2yczNfsh8D7Iv84DN/9lECIEoNpGb/SuDwjoZQUhaMxGPwbWRJth0OC
         jL8z8xxEr7/58T0QRCBiPfjQaWFrR1h350fvHnglqlr10ms93GK2x63PGFAcCTNYJApR
         a/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783529806; x=1784134606;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ykV1qPXL/5RTfhpzKzHoTzgtwvITWx+N0GJVrtZRszA=;
        b=knFd/XoJiLRDqdoOJUHcBnyU82NjyOT2Xfdyq7jAmP/hJmGhcMB3cjpMHbvNv6PtkX
         dktRVYpEPKo97Th3/cUtbVOQwnLNHZyhcw0QY6KR9/aGT5/PTANGMT07R5n65ILfYD2E
         AQ7wdbQUNdSXBlu+3xcb+QzMqiTX21Cz46xg5JNcclRFjNl0/DLcRGcdc+IKGTbB9s1V
         2ROwxaAoFrYIbGK8JOoKspnmJ6GoQX4OzqSHw6UnHic14GJv2bAn/l8nJnmad53O39Lp
         QfNO8B7MWafQ/gXjpLCK3v9VyrkHjKKmaOH2v8zaIcAmIk+fFB+DzMNpYGjzZTK3FKCe
         4v8A==
X-Gm-Message-State: AOJu0Yy45aSPGPc3M5UHhyiOBdzOQHPYbtMqBG+jO+Yp5sIktwMNj83P
	T9DHYLv5ShEYts5e8zrUr/tKMKp6BSQq075FxnO/JFyqJ261oilPblIv
X-Gm-Gg: AfdE7cnMryJgHbRr+RRz3rcpa/cffeWqzNmR+WEmW48+VCsd/U2/U/rfDA8Ui0wvqDr
	bYTg/U8KYtAL6btbkPih+or5xCe2zw3qKxqIHJL4xNXEvkw6EXnP/jS1cQ6DymK0smg5J9ukZCZ
	OB2K7ch1iUBf9LDZHuL/WehhPG+JGE3R5DDuk8Ch6EX1YMe93inWXynUaebPqt3DVc7MiN6N9vP
	iaV7JYvILwCursfXAN37g2wq5/WxUsvVYRLDwz9oklyPuKqLGrm7n7QtRC+Z5VTQVZOzDTKPQR5
	5Wa6UrsxRf/zBcYsQPYgFR2CUHDY4zB7SG8yTZ87XJ9dRGQ43ybip0GyGws6Xu0XoJmbtdnycWD
	l0h8BW3XfrXEmLo1fc+JxAKwN+hsDC2NklEX18r09K9Hp2/amuZ6aDjyJdyai5ix09MFVoj+XuS
	Z+6MkJwA==
X-Received: by 2002:a05:6830:2b1f:b0:7e9:2d33:87eb with SMTP id 46e09a7af769-7ebcfe9592amr2089587a34.12.1783529806578;
        Wed, 08 Jul 2026 09:56:46 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcafdf8f2sm2216971a34.11.2026.07.08.09.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 09:56:45 -0700 (PDT)
Date: Wed, 8 Jul 2026 11:56:43 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 06/11] odb/transaction: propagate begin errors
Message-ID: <ak57VEF56HkRKygQ@denethor>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708041412.1157499-7-jltobler@gmail.com>
 <ak3xJFDqTSN1Naoy@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak3xJFDqTSN1Naoy@pks.im>

On 26/07/08 08:41AM, Patrick Steinhardt wrote:
> On Tue, Jul 07, 2026 at 11:14:07PM -0500, Justin Tobler wrote:
> > @@ -490,10 +491,12 @@ int cache_tree_update(struct index_state *istate, int flags)
> >  
> >  	trace_performance_enter();
> >  	trace2_region_enter("cache_tree", "update", istate->repo);
> > -	transaction = odb_transaction_begin(the_repository->objects);
> > +	if (!inflight)
> > +		odb_transaction_begin_or_die(the_repository->objects, &transaction);
> >  	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
> >  		       "", 0, &skip, flags);
> > -	odb_transaction_commit(transaction);
> > +	if (!inflight)
> > +		odb_transaction_commit(transaction);
> >  	trace2_region_leave("cache_tree", "update", istate->repo);
> >  	trace_performance_leave("cache_tree_update");
> >  	if (i < 0)
> 
> Callsites like this really make me wonder why we even care to create
> a transaction in the first place if we basically just commit it
> immediately anyway. And while it's a bit sad that we have so many sites
> where we don't really know whether we even have a transaction, I think
> it's a good change that we have now annotated them clearly. A subsequent
> patch series may then eventually refactor those sites so that we stop
> depending on `odb->transaction` and inject the transaction via a
> parameter.

Call sites like the one mentioned above are using ODB transactions as an
optimization to batch the full fsyncs in bulk. In cases where the is not
already a transaction, they start one to take advantage of it.

I fully agree though that an ODB transaction should ideally be started
at a higher layer and wired down to these call sites. I have a couple of
patches in my tree that start to tackle this which I plan to send in
another series. :)

> > diff --git a/odb/transaction.h b/odb/transaction.h
> > index d52f0533ce..36032a5365 100644
> > --- a/odb/transaction.h
> > +++ b/odb/transaction.h
> > @@ -1,6 +1,8 @@
> >  #ifndef ODB_TRANSACTION_H
> >  #define ODB_TRANSACTION_H
> >  
> > +#include "git-compat-util.h"
> 
> We typically don't include "git-compat-util.h" in header files.

Will remove. Thanks

> > @@ -36,11 +38,21 @@ struct odb_transaction {
> >  };
> >  
> >  /*
> > - * Starts an ODB transaction. Subsequent objects are written to the transaction
> > - * and not committed until odb_transaction_commit() is invoked on the
> > - * transaction. If the ODB already has a pending transaction, NULL is returned.
> > + * Starts an ODB transaction and returns it via `out`. Subsequent objects are
> > + * written to the transaction and not committed until odb_transaction_commit()
> > + * is invoked on the transaction. Returns 0 on success and a negative value on
> > + * error. Note that it is considered an error to start a new transaction if the
> > + * ODB already has an inflight transaction pending.
> >   */
> > -struct odb_transaction *odb_transaction_begin(struct object_database *odb);
> > +int odb_transaction_begin(struct object_database *odb,
> > +			  struct odb_transaction **out);
> > +
> > +static inline void odb_transaction_begin_or_die(struct object_database *odb,
> > +						struct odb_transaction **out)
> > +{
> > +	if (odb_transaction_begin(odb, out))
> > +		die(_("failed to start ODB transaction"));
> > +}
> 
> We could make it a bit simpler to use this function by continuing to
> return the transaction directly. But on the other hand this results in a
> more consistent interface.

Ya, I was a bit back and forth about this myself. I ultimately landed on
keeping a more consistent interface though. Happy to change if others
feel differently though.

-Justin
