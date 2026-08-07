Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227D534216C
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116798; cv=none; b=dRHBncf1iC5LLhdtnvEz4hacQdVRmDuClpZkHgj2FA0n8/M9TV4QIGQon0+z6k60K5Y5ZH+vy0xP+H18wxpt7BeyqT4J4zifnQdWeh3nK0c0x1CfdazAo+mEfuCoe1wmLL60LrL56LH8X1Wph+BBHmzC6btvXIXucnPLV9h4rbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116798; c=relaxed/simple;
	bh=u1myE46IF3KNp5EFGcO5zxEPk2X0Y+Qhj5jDShnrVe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVROlbzDZ+GAVWC+faMAfe7vHe8yh1znIsKY8GQ6F8Y5P/xY1xRNkJMt+X2cA1VTipcGlEzPXEr2KNHKqDpplmXGsVv8rg9XHjTvcbTC56OIO4RajV4bHp7qDNAitVrOw+j5MqX3V9G3zslWGVHhECBUKZrPckwEPdbptk5eFsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tg8o8iBc; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tg8o8iBc"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7f18c0e03e3so1821523a34.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 08:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786116796; x=1786721596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mu9DfOlbuIbBsQqUU6NdAPYaazplVEnq9ZiGl0KcQkU=;
        b=Tg8o8iBcIcu+CuuC926IjDzWuD0TUYtMJS49yEoMkP5gKj7daKWo0OHQJJ9C3jpzc5
         cuyQEiHC2wYrpnqfd+ClNv8wicQmJfag7UZYEmjwWRWf0loYTGyKO9201TQJZ8GInnQS
         mvEjPn2kZqS53hRT/7aFA5bDDDIx3WTcu5dFSrxtQLpbd32sT231063fboRA89UmUn/+
         ZmCwmSPx2XlM5SwYUdzZhjH7tPqvzc9eMtthvN2k+mbSO8KkWKHxEe0htfiQinGYdiL9
         dzZhuYrk1Ms9Puz4C72EYyNdP1s0tQfv7miV/ybQWbxuUiYfiGtBsWxeKxx9sKBfCKL6
         /Kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786116796; x=1786721596;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mu9DfOlbuIbBsQqUU6NdAPYaazplVEnq9ZiGl0KcQkU=;
        b=WjggKMoqwYSVFpnKhN2TPsoyFr0kINHvZ0ah5lLBnP21K5TOIibnp3j3fOKiEdQfUv
         ybtnwl6MtApYcNIrQQhQ8yc49ArCIyPHg1pBEi8euwyo6A+9VnZsaNNsvNBLTW4J5ld2
         /wAcRyqJO+BLdCIlVCRZKVWmF8+NqIcUKiyt3SP+lsYste8J/1bcgeAwleNX9BraoG7q
         E8NmkKFJHaF4hxMgN7SM5mDk1f+bvYp7SVkYw1QUJgcyVnDPcnTovE3yreyMh4uLy3s+
         i9J+8UuyamKn/KL/cWNa4ihY24Wk8N+zS4o23iKB45E7L12VCmZfKkCPTY2l0Xsrg43p
         HCnw==
X-Gm-Message-State: AOJu0YyYwKps9gxQZBUDwMG2Pi7h+34dS/WU+jB9W+7PP+CEF8xehbdg
	+rxsbsW6Frf4422dBezbGuEj21Me7eX40As+2h9bdXdvuuSh2A/aB8FM
X-Gm-Gg: AR+sD10rDMx9SfZtB8ZsCFvJoSf9o3Ac/nEdPQVCgRXaq+Xtczz/XRRFmqbNWW7qu1C
	1C0K009usFpw+pEzH/9rAFDjeHE8DXg8qQXJlH9rZzSa8fJG2MKfXq/XIgYQWPOt3sN0x9BLoHd
	UG42JMIPgy04HSFq1nNXyy/6jPKluq7+XuFfi3XVdvDp5okTwYlxHA5Dp5jMJfqQMi5riocCttP
	MM2Rm090GwB3S+Dc9h8NRS7CoIC4jWi6rAfdwpyvWQVy9GLkTYiGLv6cc7kx8Scd9LDa1py9uLr
	mEQdteh1jEnqpVo2vxzSdORyCFMmWcgb8GTfF0s+U1M7aJ2deKqntZ6PQ1DkyKO/qsCcZwuw9GA
	DupL0YVp6FyOMug55ej67kKZQmdXT/G3lDBSRV2CKxngBzE/zVJWs2ah1PLx5Pk975jmc6av+Sh
	tiE3Hdxy2pSUKDrVnijPuqvdTTK2ASYyADY3STYTZtItT6GqC1GWN+sw==
X-Received: by 2002:a05:6820:1508:b0:6a3:1dc5:356e with SMTP id 006d021491bc7-6ae970ab4f0mr11305872eaf.36.1786116795919;
        Fri, 07 Aug 2026 08:33:15 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f1a9d9b9sm2127604fac.7.2026.08.07.08.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:33:15 -0700 (PDT)
Date: Fri, 7 Aug 2026 10:33:12 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/6] builtin/receive-pack: lift global state out of
 unpack()
Message-ID: <anX5PxN15qvtfFEX@denethor>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260806213859.816157-4-jltobler@gmail.com>
 <anWDSt155Y9hzHGM@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anWDSt155Y9hzHGM@pks.im>

On 26/08/07 09:03AM, Patrick Steinhardt wrote:
> On Thu, Aug 06, 2026 at 04:38:56PM -0500, Justin Tobler wrote:
> > In git-receive-pack(1), writing the packfile to the transaction is
> > handled via `unpack()` which relies on global variables to decide how to
> > invoke the underlying git-index-pack(1) or git-unpack-objects(1) child
> > processes. In a subsequent commit, the `unpack()` logic is moved behind
> > a generic ODB transaction interface to handle writing packfiles and thus
> > can no rely on these globals.
> 
> Nit: either "can not" or "can no longer".

Will fix.

> > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > index 6da854fca2..8c2d6e5789 100644
> > --- a/builtin/receive-pack.c
> > +++ b/builtin/receive-pack.c
> > @@ -2333,18 +2333,25 @@ static void push_header_arg(struct strvec *args, struct pack_header *hdr)
> >  		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
> >  }
> >  
> > +struct unpack_opts {
> > +	const char *fsck_msg_types;
> > +	const char *shallow_file;
> > +	off_t max_input_size;
> > +	int fsck_objects;
> > +	int unpack_limit;
> > +	int reject_thin;
> > +	int err_fd;
> > +	int quiet;
> > +};
> > +
> >  static const char *unpack(struct odb_transaction *transaction,
> > -			  const char *shallow_file, int err_fd)
> > +			  const struct unpack_opts *opts)
> >  {
> >  	struct pack_header hdr;
> >  	const char *hdr_err;
> >  	int status;
> >  	struct child_process child = CHILD_PROCESS_INIT;
> > -	int fsck_objects = (receive_fsck_objects >= 0
> > -			    ? receive_fsck_objects
> > -			    : transfer_fsck_objects >= 0
> > -			    ? transfer_fsck_objects
> > -			    : 0);
> > +	int err_fd = opts->err_fd;
> >  
> >  	hdr_err = parse_pack_header(&hdr);
> >  	if (hdr_err) {
> 
> It's quite hard to see that the function indeed doesn't rely on the
> global variables anymore, and I'm quite certain that I'd not spot cases
> that you forgot to convert to use the options structure instead. But I
> assume that the function will move into a different file in a subsequent
> commit, so we'd notice in that patch.

Ya, that is indeed the plan. :)

> > @@ -2428,11 +2435,24 @@ static const char *unpack(struct odb_transaction *transaction,
> >  static const char *unpack_with_sideband(struct odb_transaction *transaction,
> >  					const char *shallow_file)
> >  {
> > +	struct unpack_opts opts = {
> > +		.fsck_objects = (receive_fsck_objects >= 0
> > +				 ? receive_fsck_objects
> > +				 : transfer_fsck_objects >= 0
> > +				 ? transfer_fsck_objects
> > +				 : 0),
> 
> This looks quite ugly, but it's no more ugly than the previous code it
> replaces.

In a different version of this patch, I modified the fsck objects field
after initialization and dropped the single statement here, but I
ultimately didn't think that looked much better either.

-Justin
