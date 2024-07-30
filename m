Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEF3CA6B
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351365; cv=none; b=cQyg+Y4367DXfhvrrf3WWmQAb1QcE3JC8URgP1nZ5ITV49BSLv0L3gC9qbVZDus4Y+ZF3OP4dVj9N2H0NtHmVhQqEgbuCRwnziq/8ZL4JaBj62ic2pkX93F72a1S3HRQZtJ1nd3S99uft48RXINo8T/qywLUC2WYbvr9N0t49Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351365; c=relaxed/simple;
	bh=XyGudFE43TNIcatqxUCZLIl71Bv3QFyPz8W0zcOJsMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/365bffUXgD6CyWrKQCrMo1EktpqZr+Vk/47LUCFUxzix8lWtwS45qc1dgUwdNYhi7QhCDWFB+6bgEtuS6ND/+uJ4DWF3vEDvPZ0DtP9Lzw4KvH7UfDQP1SkTDqrNOXsZO2HD3KmCszWg0r9iG71/pn+olYSVgrNqNg+wbKn2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MR1e+uHZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MR1e+uHZ"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d1cbbeeaeso3278566b3a.0
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722351363; x=1722956163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4lYM/qLVzY0YFFbtO6B6KoycnKW3RNtOw/dmSmiyM18=;
        b=MR1e+uHZ2N5ztaDG0oAs/Y6G64uvrG8VePb+avB2K/dofOH+AvUghTjhW7lRepnLPY
         WakTHmMxz+jMJuDTWNMmyb0WEhviG2VGBmbAlxCY0RFA8zJUCJPQzxA/Kyqhp998v7Fj
         nz64m0fYcu6gBz+n9TYLrohZH+bT3oiEYyPlhflFjRx73gZlCB0TDM563B5LrteWQjCm
         6tUV0LMYw0/IFgoyqATcnXUAP+rPTIiBVTqTxfsrbXJJgU62uG1awaNxoJxkQYVOWp/Y
         w6qD1MVBGaczjN5W2lc1iuvji6CEHKwGVDJaQ5jcVzWnIpf82hdCHuaI21X2TRKxtlPz
         Gq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722351363; x=1722956163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lYM/qLVzY0YFFbtO6B6KoycnKW3RNtOw/dmSmiyM18=;
        b=d8hxmjj3iWTN0gEHinCP9ISKXgmT2h+qRs+0zMXcnkAdqPVbhnmU6DYl/3szN7O+i0
         8BfJPaXnSs+AwLyuxMzzPikWd3b2jYQQrqAMxp9hGrT/FY6EwXINNeivvMD7+eKA/np2
         cD1jfSUtTseS3TqLBUMr/adU7e2gL2rjYm9LClO7yC5vlFS/VmBAeKcaXcx1puAvGfVc
         Cw3DYV+16/HWUgAiMR62Sltpt8XAXNl/90XPY/1NA9xqnBtYip4ckp2DN9eib3PUYZ9+
         7bR3256T+E8PrKcYnFns2kTu8FUckQh6RUZgROcyGtjOhprHt3Hqbt0FaHKxeQ3/YkWt
         V20A==
X-Gm-Message-State: AOJu0YyohivMtydFnLhti26dCOy5H9IS6HZ5PAgPx2Wg98xNOWJAqfnB
	M9lLbLhlFM5j+Wt1xbNhNCJ/q+eLd1wrbIHWw2+t1QPtO83G9LSF
X-Google-Smtp-Source: AGHT+IErDjJX9v8WTkbvVKBZRAnxMl5dxh+5xrFFDlnQQF/rX+WUReg+vVrYZaxTvIw0Fr8w0AHDvw==
X-Received: by 2002:a05:6a20:6a10:b0:1c2:8d33:af69 with SMTP id adf61e73a8af0-1c4a13afd31mr10276024637.41.1722351363005;
        Tue, 30 Jul 2024 07:56:03 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f71fc4sm102708255ad.221.2024.07.30.07.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 07:56:02 -0700 (PDT)
Date: Tue, 30 Jul 2024 22:56:22 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v13 02/10] fsck: add a unified interface for
 reporting fsck messages
Message-ID: <Zqj_FmazX6SW98Eq@ArchLinux>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
 <ZqeYhkaArVmMdrnK@ArchLinux>
 <Zqik1JFs-RYCwNnz@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqik1JFs-RYCwNnz@tanuki>

On Tue, Jul 30, 2024 at 10:31:16AM +0200, Patrick Steinhardt wrote:
> On Mon, Jul 29, 2024 at 09:26:30PM +0800, shejialuo wrote:
> > The static function "report" provided by "fsck.c" aims at checking fsck
> > error type and calling the callback "error_func" to report the message.
> > However, "report" function is only related to object database which
> > cannot be reused for refs.
> 
> Nit: it would be nice to mention _why_ it cannot be reused for refs.
> 
> > diff --git a/fsck.c b/fsck.c
> > index 3f32441492..1185e9a8ad 100644
> > --- a/fsck.c
> > +++ b/fsck.c
> > @@ -226,12 +226,18 @@ static int object_on_skiplist(struct fsck_options *opts,
> >  	return opts && oid && oidset_contains(&opts->skip_oids, oid);
> >  }
> >  
> > -__attribute__((format (printf, 5, 6)))
> > -static int report(struct fsck_options *options,
> > -		  const struct object_id *oid, enum object_type object_type,
> > -		  enum fsck_msg_id msg_id, const char *fmt, ...)
> > +/*
> > + * Provide a unified interface for either fscking refs or objects.
> > + * It will get the current msg error type and call the error_func callback
> > + * which is registered in the "fsck_options" struct.
> > + */
> > +static int fsck_vreport(struct fsck_options *options,
> > +			const struct object_id *oid,
> > +			enum object_type object_type,
> > +			const struct fsck_refs_info *refs_info,
> > +			enum fsck_msg_id msg_id, const char *fmt, va_list ap)
> >  {
> > -	va_list ap;
> > +	va_list ap_copy;
> >  	struct strbuf sb = STRBUF_INIT;
> >  	enum fsck_msg_type msg_type = fsck_msg_type(msg_id, options);
> >  	int result;
> 
> It is a bit weird that this new generic function receives non-generic
> inputs which are specific to the respective subsystems (objects or refs)
> that we are checking.
> 

Actually, this is one of the biggest problem when implementing the
infrastructure. The original function "report" only cares about
reporting the problem of objects. So the callback "error_func" uses the
similar prototype.

Problem comes when we want to add ref-related report. In my very former
implementation, I just created a new function "fsck_refs_report" to just
copy some codes from "report" and defines refs-related callback.

However, this is a bad way because we make duplication. If we want to
reuse the "report" function, we should add new parameters into "report"
and "error_func". This is the idea of this patch. However, as you can
see, there are so many "report" function calls in the codebase, it's bad
to change them. So I define a more common function called "fsck_vreport"
function and wrap "report" to eventually call this function.

> A better design would likely be to make `error_func()` receive a void
> pointer such that `error_func()` and then have the respective subsystems
> provide a function that knows to format the message while receiving
> either a `struct fsck_object_report *` or a `struct fsck_ref_report *`.
> 

Yes, I agree with this idea. And I think we should use only one function
called "fsck_reportf" to report any fsck-related messages. We could
design the following callback "prototype".

  typedef int (*fsck_error)(struct fsck_options *o,
                            void *info,
                            enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
                            const char *message);

Thus, we could make "fsck_reportf" generic. It will handle the common
"fsck_options" and "enum fsck_msg_id" and then it will call "fsck_error"
callback. The user could pass either refs information or objects
information.

> I don't think this is particularly worriesome though as it is still
> manageable right now. So I'm fine if we want to leave this as-is, and
> then we can iterate on this in a future patch series as required.
> 

I strongly suggest that we should use the above design for the following
reasons:

1. We only expose one interface called "fsck_reportf" which will make
the code clear. Actually, there is no different between reporting refs
and reporting objects.
2. We provide more extensibility here, because we will never change
"fsck_reportf" and "fsck_error" prototype when we want to add more info
for either refs or objects.

But do we really need this? Junio, could you please give some advice
here. How do you think about this design. In my perspective, the only
overhead here is that there are too many "report" function we should
refactor.

> > @@ -250,9 +256,9 @@ static int report(struct fsck_options *options,
> >  	prepare_msg_ids();
> >  	strbuf_addf(&sb, "%s: ", msg_id_info[msg_id].camelcased);
> >  
> > -	va_start(ap, fmt);
> > -	strbuf_vaddf(&sb, fmt, ap);
> > -	result = options->error_func(options, oid, object_type,
> > +	va_copy(ap_copy, ap);
> > +	strbuf_vaddf(&sb, fmt, ap_copy);
> > +	result = options->error_func(options, oid, object_type, refs_info,
> >  				     msg_type, msg_id, sb.buf);
> >  	strbuf_release(&sb);
> >  	va_end(ap);
> > @@ -260,6 +266,35 @@ static int report(struct fsck_options *options,
> >  	return result;
> >  }
> >  
> > +__attribute__((format (printf, 5, 6)))
> > +static int report(struct fsck_options *options,
> > +		  const struct object_id *oid, enum object_type object_type,
> > +		  enum fsck_msg_id msg_id, const char *fmt, ...)
> > +{
> > +	va_list ap;
> > +	int result;
> > +
> > +	va_start(ap, fmt);
> > +	result = fsck_vreport(options, oid, object_type, NULL, msg_id, fmt, ap);
> > +	va_end(ap);
> > +
> > +	return result;
> > +}
> 
> As far as I can see, `report()` is now specific to reporting errors with
> objects while `fsck_vreport()` is the generic part. Do we want to rename
> the function to `fsck_report_object()` to clarify, or would that cause
> too much churn?
> 
> Hm. Seeing that we have 62 callsites of that function it may be too much
> churn indeed.
> 

Yes, there are too many references for "report" function. That's why I
wrap the "report" using "fsck_vreport".

> > +int fsck_refs_report(struct fsck_options *options,
> > +		     const struct object_id *oid,
> > +		     const struct fsck_refs_info *refs_info,
> > +		     enum fsck_msg_id msg_id, const char *fmt, ...)
> 
> Would `fsck_report_ref()` be a better name?
> 

I agree. However, if we use the above design, we will just use
"fsck_reportf" here both for refs and objects.

> What is the intent of the `oid` field? Would it be set to the object ID
> that a reference points to? What if the reference is a non-resolving
> symbolic reference? I wonder whether we can just remove it.
> 

`oid` is used to be the object ID that a reference points to. If the
reference is a symbolic link or symref, we do not care about it. The
caller should just pass `NULL`. Actually, we may not use this field.
I just suppose that we may provide the user more information. Because
when using "file-backend.c::parse_loose_ref_contents()" we will
automatically get the `oid` if the ref is a regular reference. So I just
provide `oid` here.

> Patrick
