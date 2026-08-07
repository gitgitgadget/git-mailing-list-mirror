Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A04ECA6B
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118501; cv=none; b=sDyjsvTnup7W6HNHeB3ldtE4uIoEgVj3PGW2ABeKMXV5cM7RhL6GNRve7r4GcaSRNOKct8smjl2O4ckWujNBcwitz+vq4ZiQWPKJ94WidwCagDf3NQuwjmK5qYjN27oWvQ6W1yvM7NGhdK49LdlTCQPEGapgO+dYuWDoawhoraU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118501; c=relaxed/simple;
	bh=bnPkyD5JpfGj531Jyj+Vea4UmG3JIkFM5UygaTeKnvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQATg7HLj2/n+QZ8XKIDPg8eX489AauAxaQN67LMMVy4HcXd9lYFPQefLvmQi8Unv84IFqH8/OEF0Hnaq3B44NGzfkgXcnM22eUWznfES8mFQwgYOnzNl30/VoxBuQsm3vI/8NXkffnpsP8dcUz8WPfLxdIo86VKST2eknexVvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6v7OIH5; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6v7OIH5"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7eb63dbd229so1586185a34.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 09:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786118498; x=1786723298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iFdxl2hh5MHYmNa8Jp1nu/bV6P0iBUti/97kSGrzxKg=;
        b=U6v7OIH5nRlpEprqmUHPG1Omss8BIqSU2dKK8NRmTQdLe3GKMNFbXHlXBAFiKT3avM
         nkHehQryAZpFdRF/ggSX4IxEk9Y3MVfgCTsK7OJojh9fKy0kEqeY9N5smxCJb0REJREv
         +Brn7BnQRRgNiPNOfAEcaukX97rllo2nYN5BGjeozW8X6wfkvtY2L4gynmv40xa++IEX
         I3NTK5/HK+P+a0uUnFj0RB4rx+RtId89POuIyPhFIgOzVTylCXOJwaEnvxDEyT4vubCz
         UkBoizUMCDUVTPPWVgnSb8ai50f9u9MUlEacRRsXht/HNijIDkGwwYU0oJ+6GJ7MYRJl
         Rjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786118498; x=1786723298;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iFdxl2hh5MHYmNa8Jp1nu/bV6P0iBUti/97kSGrzxKg=;
        b=FqE+DCd25pSjQNMPgdaNQkVEgDN43kZ08rnc/9qurJP0vcYVKUMEGpNhnFuXeKdD5i
         vxiw+/QBfu7NR3+5a/o7xskzxt3KfMSwpOKWPWhz4gH4lC1dQiFGZbgqcE+V7+eBlubF
         BpuAVNthn9BMaZy9d2GKE/jwk2wbtxH6R6wwsJla/D9W1JjbDHtymQelporE+YMTto1D
         rrZ4U9Di9+H/1koMtfUjcQSQsnMEp1/ZLysPbTqXoie4MR7UtPSESzK15l+yz1nj4CX/
         e9ha5eayMtwKyWTw7JywC46pS447HSJz3liX+/HfQccfoV9b7m9xbmUyLlSmJ9EjAuhj
         nwqQ==
X-Gm-Message-State: AOJu0YyCYt9XJzPmONuNusXUD7fRepCPgkfFxAxIeeYqvqyX2lFII0Kp
	4xM0NkThHhK8vEG0FyVhgbM1hU1KsoSA9V/uoZ1/HS5mNlxL4ZG+VppCf0TBRQ==
X-Gm-Gg: AR+sD10TjB+2myFw5U9j78aRhfC0fviErkYiyTiaRva2yIERe/qU7EXNmZQqz16Fty6
	Wv+mDtvi6U1a3NTzTtmyJTw41UaC/mGMy+OGVvuaCcqjqumojMIT1zRIZQBPhO5b1IUI/bwsm05
	Okq2k7Ay9JbImLWnW10BKPkY3yJrE16wkRtZst1KjX3vjT9ArbOfPkKPSq/CyPsV4/Qsg4NjUH9
	RjyBMWcJKxmED41CgWUd3DwqzXlZ0XT+PVhrEM3dGAMIBx6DhPuaCsDoYaEqycRSb8kMQ4Yi/eu
	aQGsOWYVGhIf3r8eVqFGKw2A/FM0+/5ELoeZS60NiLicseC4DycNqgqfJsk9xYChdI7ihHTxdbQ
	ToyQJDfLyVzVZ0vJx2/E+IZfhW903YHQpP8mHu+VcQMFPIs7a7ZXHUxvIxr3IlEs1qOTOTy6vQq
	wDidQXfmdP/8zVs+jtGqHUpnZmM9j0h7tRaUfyeRGmlwhvm2+1JRZ0rQ==
X-Received: by 2002:a05:6830:7086:20b0:7de:9b99:a8ee with SMTP id 46e09a7af769-7f1ff361df8mr2493590a34.9.1786118498061;
        Fri, 07 Aug 2026 09:01:38 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b7c4b2dsm1571801a34.20.2026.08.07.09.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:01:37 -0700 (PDT)
Date: Fri, 7 Aug 2026 11:01:35 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] odb/transaction: add transaction interface to write
 packfiles
Message-ID: <anX7baSyrG2dvFDk@denethor>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260806213859.816157-7-jltobler@gmail.com>
 <anWDVFL6OjX2xdR-@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anWDVFL6OjX2xdR-@pks.im>

On 26/08/07 09:03AM, Patrick Steinhardt wrote:
> On Thu, Aug 06, 2026 at 04:38:59PM -0500, Justin Tobler wrote:
> > +		status = finish_command(&child);
> > +		if (status) {
> > +			strbuf_addstr(err_msg, "index-pack abnormal exit");
> > +			return -1;
> > +		}
> > +		odb_reprepare(repo->objects);
> 
> Now that this is part of the ODB transaction, do we really have to
> reprepare the whole object database? Shouldn't it suffice to reprepare
> just the one source that we've created the transaction for?

Ya, this is a good suggestion. At this point, the packfile has only been
written to the transaction source, so it should be fine to just prepare
that source. Will do in the next version.

> > diff --git a/odb/transaction.h b/odb/transaction.h
> > index ec0b27c449..491026e815 100644
> > --- a/odb/transaction.h
> > +++ b/odb/transaction.h
> > @@ -4,6 +4,51 @@
> >  #include "gettext.h"
> >  #include "odb.h"
> >  
> > +/*
> > + * Options controlling how odb_transaction_write_pack() ingests a packfile.
> > + */
> > +struct odb_transaction_write_pack_opts {
> > +	/*
> > +	 * Optional fsck severity configuration to apply when incoming objects
> > +	 * are verified.
> > +	 */
> > +	const char *fsck_msg_types;
> > +	/*
> > +	 * Path to an alternative shallow file describing the shallow boundaries
> > +	 * to honor while ingesting the pack.
> > +	 */
> > +	const char *shallow_file;
> > +	/*
> > +	 * The max size in bytes of the incoming packfile allowed. No limit is
> > +	 * enforced when set to 0.
> > +	 */
> > +	off_t max_input_size;
> > +	/*
> > +	 * Whether the validity of incoming objects should be verified.
> > +	 */
> > +	int fsck_objects;
> > +	/*
> > +	 * The threshold for the number of incoming objects required to store
> > +	 * the objects in a packfile. This option may not be relevant to
> > +	 * backends that do not store obejcts in loose/packed formats and can be
> > +	 * ignored.
> > +	 */
> > +	int unpack_limit;
> 
> I wonder whether this option should rather be handled internal in the
> backend itself, as it very likely doesn't apply to alternative backends
> anyway. I don't think we allow command line options to override this, so
> the backend could just read the configuration manually.

This was something I was also considering initially. This option doesn't
really make much sense to have as part of the generic interface though.
I'll update in the next version to have the backend read this
configuration manually.

> > +	/*
> > +	 * Whether to reject an incoming packfile if it is "thin".
> > +	 */
> > +	int reject_thin;
> > +	/*
> > +	 * Optional file descriptor for reporting progress and errors. Set to 0
> > +	 * for none.
> > +	 */
> > +	int err_fd;
> > +	/*
> > +	 * Suppresses progress reporting.
> > +	 */
> > +	int quiet;
> > +};
> 
> Nit: I think having some spacing between the different options would
> make this a bit easier to grok.

Will do.

-Justin
