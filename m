Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECFD387363
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605845; cv=none; b=hycIk325LrQkMCtU5oeszHWr+OUUJr5kRDORhEMgwxJdu+wsoPBXdQ5BV0HmCT2WtSvbzYOpFR3B7SMr7hTuJVP8D3nxPv0acREMajbQWg0A1KtM02uJ04V7nyiKlh567+lCY0ewkEDc1deAs0dmaeesekQe4Gj/W1E/l2jF5rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605845; c=relaxed/simple;
	bh=jDrJqkQD/vpTrFPDTc69V/S0X6IMU6xM4k0YAK3te4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAQwEZETPg1Y3pdudEZ9sgcJFczRqgL1ubSDpOshkwT0P3GUhHwTWw0E3Q06s5TWG9zUWLGIgyIKk+TyoJouH4Tpb9VJ3bA9hgc/eHc9sGCPGjZ0vY3/jJjGfgaIf6u8Vsepxemm+be7AU2jRNEKsOC/tj2bC3wNQgHbE3g6Bn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OR4WlQbw; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR4WlQbw"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-495b250b01cso1415533b6e.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 07:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783605843; x=1784210643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t6bjH6eB6FhJ0Fp94eJtZ4d48uVAnKgch+M9HljhFJQ=;
        b=OR4WlQbwi10qMQ1W0qkgBlcZX68yZwoX+hm1k+zrAqog6LuLg9COIK2h+KuCG74DCP
         knvJb5fHEMg4hUMT4zfkZxh4GkugrX7JSF9Y4Kd52/+GSRp8VRK31W5VEux4okwqJqmv
         0bs0GFzxXEWdICnardh09NXQqPbkcGbmPviIX1LkBupYtc/2YFdaz+N43SgeetK0u4ii
         MlhfCjlg7bXF16YaR9B7uUZYTqlNsVZGmyKxXyJwcFs+bWdWjBz1Tppp2zYEwA/JAOcd
         JAjxb/P7tOE9IDK7PqBqxIvhD7r8WdJSbDXYSQVrpvB5ygwe5LQnUF2khSCR4QD+CUdR
         jW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783605843; x=1784210643;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t6bjH6eB6FhJ0Fp94eJtZ4d48uVAnKgch+M9HljhFJQ=;
        b=XS8lPSFD9BKiVsJL7n6c5YEgpXyqcvRuGpVr1y+wNOvwcHgMvGVzZoSEBEEyxxRqE4
         rzzeF6hi29MDiVC0KkVbCS0/VSiA6kTuvgbtD2BT8OdTLLqSHynBKfiKHrwKW5O2vyfT
         gHVCPWrO62z4PUeWzSQw4dRuTsJCSgXO9JjhlUbqIOI0N8gFtK8aaOHhwe8yXJVwoE9f
         dDBzKnoFsL4JWQQCQ4Rl+R+/jEbBlbUrj/cX2YzGQUDQKkSD6HnLfh6uhOjG7F92OBCj
         Hh/IMqHJXUhrWmDWl706U5QyCV9ksJhkwBPzU7cfBxYgvHlZHFUzBB4JcsIldhxnmo+3
         BAYw==
X-Gm-Message-State: AOJu0YyXC4tfYAk5QYlwL6+JUqAIv9SU7JdkazXPGTNkkQ3qUqU1wL/n
	dAPyhMcvo4VXG9yCFZEHKaxeja4Pl8rAWsj00vtpzVBBzZNBS4aFMWpX
X-Gm-Gg: AfdE7clf43xiE5Rx3S83/Um0egx1FpkJ0C1dMAraMCcfoZw0070/FJdsl1eIDzZ6dE6
	iwg2jEmVZLOOoaXZUwEaAIeBR1Lyq34OCVpIyRBKmFmlLMohyDfIcHziFoTWdwJM9iYYaUJbae4
	dEuDhMU63ff2jNy6yOFkIuYSAa1LVwsFOIjHa9mc9uWy4zAkQxQwh1S6Qae2GCaAfdvXzRc1sbN
	zx2stPy5AGXKuAx0Nr4ttd65S3ddHEg3DlR+sRJkpyQTj340Fjcj/gvFvPR+LtLL38LAQpKlFNR
	Dx0JfdP0Zf5iNzzvIPjKi3To+wM3KxKhrMD8jd1urNLo/cqiDcGO+GNJTH65w4I5bVwfN8Q7rH+
	3Z/4KjUPaw8kYWCupUIZ+ZjyQk5L9RxHbNz8BvdCv59QzAfRK+oejeVVbZ8VUzraYZv2FfLYA3m
	q2Wz6SRg==
X-Received: by 2002:a05:6809:303:20b0:4a3:2bd1:5216 with SMTP id 5614622812f47-4a32bd16148mr2104149b6e.43.1783605842989;
        Thu, 09 Jul 2026 07:04:02 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1afbf92b1sm3555948b6e.10.2026.07.09.07.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:04:02 -0700 (PDT)
Date: Thu, 9 Jul 2026 09:03:59 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v3 06/11] odb/transaction: propagate begin errors
Message-ID: <ak-ntVKQ8XqMr6zv@denethor>
References: <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708235925.3992097-1-jltobler@gmail.com>
 <20260708235925.3992097-7-jltobler@gmail.com>
 <xmqqjyr4rg78.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjyr4rg78.fsf@gitster.g>

On 26/07/08 08:32PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > When `odb_transaction_begin()` is invoked, the function returns the
> > transaction pointer directly. There is no way for the backend to
> > signal that it failed to set up its state, such as when creating the
> > temporary object directory backing the transaction.
> >
> > In a subsequent commit, git-receive-pack(1) starts using ODB
> > transactions and needs to be able to report such failures rather
> > than silently ignore them. Refactor `odb_transaction_begin()` to
> > return an int error code and write the resulting transaction into an
> > out parameter. Also introduce `odb_transaction_begin_or_die()` as a
> > convenience for callsites that do not need to handle errors
> > explicitly.
> >
> > Note that `odb_transaction_begin()` now returns an error when the ODB
> > already has an inflight transaction pending. ODB transaction call sites
> > that may encounter an inflight transaction are updated to explicitly
> > handle this case.
> >
> > Signed-off-by: Justin Tobler <jltobler@gmail.com>
> > ---
> > ...
> > diff --git a/odb/transaction.c b/odb/transaction.c
> > index b16e07aebf..a5fba7f908 100644
> > --- a/odb/transaction.c
> > +++ b/odb/transaction.c
> > @@ -1,15 +1,20 @@
> >  #include "git-compat-util.h"
> > +#include "gettext.h"
> >  #include "odb/source.h"
> >  #include "odb/transaction.h"
> >  
> > -struct odb_transaction *odb_transaction_begin(struct object_database *odb)
> > +int odb_transaction_begin(struct object_database *odb,
> > +			  struct odb_transaction **out)
> >  {
> > +	int ret;
> > +
> >  	if (odb->transaction)
> > -		return NULL;
> > +		return error(_("object database transaction already pending"));
> >  
> > -	odb_source_begin_transaction(odb->sources, &odb->transaction);
> > +	ret = odb_source_begin_transaction(odb->sources, out);
> > +	odb->transaction = *out;
> 
> Can odb_source_begin_transaction() ever fail?  If so, and when it
> fails, would *out be left untouched?  

In this patch there it not yet a way for it to fail, but it can return
an error later in the series. When an error is encountered though, *out
_is_ left untouched.

> I am wondering if we want
> 
> 	if (!(ret = odb_source_begin_transaction(odb->sources, out)))
>         	odb->transaction = *out;
> 
> or something like that.

I think it is a good idea to for `odb_transaction_begin()` to ensure the
repository transaction is only set on success though. Will update in the
next version. Thanks

-Justin
