Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67670394466
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137188; cv=none; b=eMZ6EwbiooaRDwE9H2e5J54q7iDgKSKMGGNBClYz1furjZO55eIIIirBjqFOgo0yMuLGMOttoTo8XwYxUxU+d7xz9IX1FGWevjnRtJklbzNRA0z05xM66k0cof8eNV4bkH6wA9tGA8USWJpBrZKM6VrEXpm6mLFHHXE8X0IpIF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137188; c=relaxed/simple;
	bh=kRJqPHaIwgBZjifaZtB28cTl/jreo/4ZVMWwMj96Zu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lI30Q/G7APvZUcnTdQxTuP1Q+95r1M/ewUUlKEi6Yb4iqfU2MZ9nU/TzR/oQduE3SvHhp8XDfOIZEnUxw/hSCv1tBTXtG/zYi2lrVpzgznxgVRb7Tjtzm5O5BxVcnAqcAnQpIQoleveWLPA1ENxIrpjB895RmXcZKvoorqgGUaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4Tn2SaE; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4Tn2SaE"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d196a2334fso2175a34.1
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 08:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770137186; x=1770741986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rxEae6Pe/Mb4iyPPzwPmNBdYuIhNaejLutRqrXPNOYw=;
        b=g4Tn2SaEGb+Nh6iVh/GXUD0+Q9PuTXr3zp9d3x7aH/egBzpwGmybuUnhU1aeFC8I1v
         I+M6Q3LYhMPgQzFGWf9MbEoaGPK2y61wrYxTzHup1O0U/Lcfd9CycHnSRmNLXYxxeeYQ
         9g3a4Xdgh4nRD7POgkFqwPixIBC03qoH1lOqYAngXwve2Ta7UV1/ZYcQ6DVCja4PYMIg
         zHRrUfRVcQhiPe2DIhhJAAqoOoFpRE2TszR0EF8Ct1+SNVmn9kPXtV1eUfxK2kcKGpJS
         iZW6PXmRGdR0XCLyoBt3kRc7JFWWNyhgjIkRdox4lJZw9zAl+wijDRGx7uiwJiWXPkOD
         8cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770137186; x=1770741986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxEae6Pe/Mb4iyPPzwPmNBdYuIhNaejLutRqrXPNOYw=;
        b=iRa80b6CoKYIsnq9vYq019nS16wMtzU3fIMILHiGQtDWxPbdeVj8wqpQ21wuPE9oVp
         8ljmH46eJDDJG+98H41d+NU/yc0vYXDpZGrz/y05O2yqh8yagx6FBQU63eHHSaAFTHss
         RjfFXvn8d1DbokkkUnR+RpAMu7/H8ysmWZ9G9TZfwluh3DfQTG9wES+Miyb+/9ISAa10
         /LJD0ThGjFSLc+ORB5yteffM07B8ayBS1FYC3+NwbCQOizX+YI39yiS/UgON0hwC7Q4O
         ltRyJqz3L/z6FxsSWDtj+WTUtViHYgzO/e2tAy+tZRzmKlf5ZaIxFS1lWdPlbYr3wIAV
         fHaw==
X-Gm-Message-State: AOJu0Yx5P/X7sQ3v/PAayrv1IW8WdduSzVBLTc0rDtIKYRoCB7zIpx2j
	kOYqfBaMBPBXwNnDq9CfGe5+OEi0i7gL8OjtZnARWHqsus6BDRK66Jgm
X-Gm-Gg: AZuq6aJNjVz+rsn9U1/uE386lUwA4BGn/znCP+3p59Q1H9TCx/VN6Fg/2fHa7p0YedJ
	NcfKlwZkYe9NxVDas0QecI00utkaDLgM4pSQM/TO+SM0CjPKdbHy+pJ/b1G6Hr2zPXJqvu3k6Ci
	7LUToZliYKKm4t0OfvT+aySNNxUO4DM6yW/AU8ws28JOc6A7KrMb2xti5pvVlgMgF70I+tyFMky
	Lc0rhpd9Jkijmz20yOFYQ1QRwh8bl+I8UaJYY5Q1SfVHw+XI1b9EwQtaN00Jsdi7bsy3fOGswH5
	D3grOgi9JjvqPlNeS0RkMZbVJmyl/Q5dkvwE+1YZoy2MMhbUAFzTDtFlDdBFl0DAkL+dgZJXW24
	xdKhBOEOZgmG3+LWQxp6nxiw1Ta4NsaCD2ecbFbH25FEdFGHH9JitKVANuZzPzZFKvD8d+SHj4y
	UaENg2
X-Received: by 2002:a05:6830:d0c:b0:7c7:68d8:f70f with SMTP id 46e09a7af769-7d449286610mr34324a34.3.1770137186138;
        Tue, 03 Feb 2026 08:46:26 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4491ffb19sm29503a34.18.2026.02.03.08.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 08:46:25 -0800 (PST)
Date: Tue, 3 Feb 2026 10:46:22 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com
Subject: Re: [PATCH v2 3/4] odb: prepare `struct odb_transaction` to become
 generic
Message-ID: <aYIirIQveQiNWzsx@denethor>
References: <20260128234519.2721179-1-jltobler@gmail.com>
 <20260203001002.2500198-1-jltobler@gmail.com>
 <20260203001002.2500198-4-jltobler@gmail.com>
 <87o6m5rff8.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6m5rff8.fsf@iotcl.com>

On 26/02/03 04:54PM, Toon Claes wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> > -static void prepare_loose_object_transaction(struct odb_transaction *transaction)
> > +static void prepare_loose_object_transaction(struct odb_transaction *base)
> >  {
> > +	struct odb_transaction_files *transaction = (struct odb_transaction_files *)base;
> 
> So you're assuming `struct odb_transaction` is the first field in
> `struct odb_transaction_files`?

Yes, `struct odb_transaction_files` contains a reference to `struct
odb_transaction` as its first member which is the "base" transaction
type. This way we can easily cast to the containing "concrete" type.

> I think it would be safer to do this instead:
> 
> +	struct odb_transaction_files *transaction =
> +		container_of(base, struct odb_transaction_files, base);
> 
> (this also can be applied in a few other places in this patch)

So long as `struct odb_transaction` remains the first member of `struct
odb_transaction_files`, using `container_of()` is functionally the same
thing as casting. This is also how we do things for `odb_read_stream`
and `odb_loose_read_stream` so I don't think it is too big of a deal
either way.

I've made the change locally, but will hold off from sending another
version unless folks feel strongly about this change or there is other
feedback.

Thanks,
-Justin
