Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017892032D
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 03:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719546239; cv=none; b=evyVHhdH+4VVoJ0lpu70z1SF7LgDeo6bVjAGkF9CUbgHrcMlH799/mMbbwZurBUNKDWxLXWbyzcOjzNYRdSBGmnf1B/OQLc/w4ziUkyt1FtGYQK+ZE3RtUMkOf1lBesujkbZ6laoBwdbhzcxLdcYn+qI780wXFdgp4EsMutmBb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719546239; c=relaxed/simple;
	bh=zJ4BAZ+hajQJTtSxmG6V5b2rJcHk4rxnbJKhLR0wPoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hf3GpeZVRjJqJYEWuHFOMbWn8ZnutZhtiJSG5lgxSQ/6iAbCPoV6IhRBqSYgzTekZLQL0ew0NXSzHyNGdHC9fHKW7x9i8Xw3doGjCn6tOhJy693M9PZRukufQHYwQIVDkmNYw0pytrEOp9lUB4Ew70MRoNspFVKfXZICjqqLft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0rwZQ1J; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0rwZQ1J"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f4a5344ec7so1348235ad.1
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 20:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719546237; x=1720151037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=amPr0hVhEk7QlAaRXLKrv1DNHteqxWdeVESWhlVczSU=;
        b=N0rwZQ1JJ7juGcfXFi7QCOegaD/ix41jbvB1S7j399wuKGdEvtzaSLKuOKThreuzZ4
         RNeyYFrDIbZq0GHC3JFTSNTO3KcSCk5xLPbe2Phi4tNCPehMDU/1XMFUynuc5V6JDexq
         SJyLLqhwY5lA3EZgqrIdZq1cKPos/xMXHmjD1BICWzS5kYbepMU8JCtJ2fufPxFMwgis
         bUlak7y1k0f0d5DADmu2EWTL1mx7reo3Kc4j9tiKtnxcqBiVLHvxTjpLUTkNGOIHtlwh
         WI++DVnB+GoPDSE9JFKimsSU4kE6Yv23eIu3hAmYgwDeN0+HLOG6mfaTapFwRv/1ifeD
         VjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719546237; x=1720151037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amPr0hVhEk7QlAaRXLKrv1DNHteqxWdeVESWhlVczSU=;
        b=EH9XByCLBimALfLmSCGzPkWLhDcXKEhEo2gMD2TChZiXS1ZK3C8Dv5DV/cgAo0fl0U
         2ULhrXNCnIo7XqHXcYbLd/YVysDO8aQDzYRSfGW6dbxU53SO4QkxcUVFcKmFH96Oax3S
         mEzMiqMy7qFZZaTd+/jeiS+We5v6BeGJhll348+KKCnhUx+I9a/8l0rDDbDw/8U2l9t2
         V0Ppn2D9kZp4nw0LjQ+5DKX+8w6koffJ/Y46zVVJWQoq2Sa+Z5Hz86zqxhJfe6W7S0/q
         lZu5+QSXsIsWaUdcAKDQEmHMpZl8bEhp3cWHu4WZrylAmrPPJ2I5V+JmphR3II3eEOVM
         wRyA==
X-Gm-Message-State: AOJu0Yw5rNbCncgbR0ceX1lGOA9mOO2/JjG2FhEvQBmdRrg9wDT1odZe
	5DNlDAbva5rnoLFpNJXZougCYHdBpjQ73wS2rYzH2xFSm60Ur73J
X-Google-Smtp-Source: AGHT+IFmSM97q1Z9+evnqrkvrQ/qw9xJSccOXMY7dZJwnz94yWHKU4QwVhtQUgByFk21HPUeVVrjAA==
X-Received: by 2002:a17:902:ec8c:b0:1f0:8c5e:ffdd with SMTP id d9443c01a7336-1fac7e729a2mr6131585ad.4.1719546237089;
        Thu, 27 Jun 2024 20:43:57 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e37a8sm5426915ad.88.2024.06.27.20.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 20:43:56 -0700 (PDT)
Date: Fri, 28 Jun 2024 11:43:54 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v5 01/12] fsck: rename "fsck_options" to
 "fsck_objects_options"
Message-ID: <Zn4xeoqhCeBCSNvg@ArchLinux>
References: <Zn2Ah3WDhtOmzrzn@ArchLinux>
 <Zn2BXRatUdX16PD3@ArchLinux>
 <xmqqa5j6rs03.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa5j6rs03.fsf@gitster.g>

On Thu, Jun 27, 2024 at 02:32:44PM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > -static int fsck_error_func(struct fsck_options *o UNUSED,
> > +static int fsck_error_func(struct fsck_objects_options *o UNUSED,
> >  			   const struct object_id *oid,
> >  			   enum object_type object_type,
> >  			   enum fsck_msg_type msg_type,
> 
> It is curious that the addition/renaming of fsck_objects_options is
> presumably to allow fsck_${xyzzy}_options to be added for different
> $xyzzy (the first one being "refs"), and this function is only about
> fsck_objects_options.  What name would the corresponding error
> function, called by checkers that take fsck_${xyzzy}_options, be
> given?  fsck_${xyzzy}_error_func()?  Shouldn't this be then become
> fsck_objects_error_func() or something?
> 

Yes, it should be definitely changed here. Will improve in the next
version.

> Having said that.
> 
> Do we really need such a parallel system between "objects" and other
> kinds of things being checked that you are introducing with this
> step?  What benefit are we getting from this additional complexity?
> 

I am agree that the most simple way to handle for this series is add
some ref-related new members. Thus, we can reuse existing code. However,
it makes me feel so weird when implementing the code using this idea.
For example,

  struct fsck_options {
    struct fsck_refs_options;
    ...
  }

When we create a new "fsck_options", it will be so misleading that the
caller may think we will handle both refs and objects checks by using
"fsck_options". So I just introduce this parallel system. When checking
objects, caller should explicitly create "fsck_objects_options", when
checking refs, caller should explicitly create "fsck_refs_options".

Because in semantics, we introduce a new check here. Combination means
we will check the both. Although it is simple, but it will cause a lot
of trouble in the future.

> I would have expected that adding ref-related new members that
> object consistency checkers has no interest in to the fsck_options
> structure would be sufficient for the purpose of this series.  Or if
> we really wanted to prepare for more complex future, use of the
> "union of variants, switched with a tag" pattern to arrange the data
> this way:
> 
> 	struct fsck_options {
> 		enum fsck_type {
> 			FSCK_OBJECTS,
> 			FSCK_REFS,
> 			...
> 		} t;
> 		union {
> 			struct fsck_objects_options objects;
> 			struct fsck_refs_options refs;
> 		} u;
> 	};
> 
> would still allow functions like fsck_error_func(), and
> fsck_set_msg_types(), etc. to work on the common "fsck_options".
> 

I agree that we could use this pattern, using union will make the
semantics more clear.

> I dunno.
