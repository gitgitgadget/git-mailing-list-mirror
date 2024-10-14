Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6722D4C7C
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938110; cv=none; b=iCkssvwcfVvHaCywPPsSL8+nz40cRG6O5mNH6ZoyfFh4G55RiDtT3QpujexBZeW9SCaMQ+Cmhx+vaknfV1cGuDL7dA5f1b3phumJjhkij5wIafW4rhuuHY3cOQWp1ZOyji3o2tbNMC3rYm7odBDDrXBEXqvIDgRkVSwkgMeT2Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938110; c=relaxed/simple;
	bh=vY1I2hNG60z81fFHc3M4051AM9bVl1ZmyW/7PNxwc30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtmgOZ7m5GJSxIPo0sWoE/ZHx3LgEiOAuEX7R3ozN/giWiWT+dBaq0118LybddDKzAZYKJWZk0NWRMNNlb8c+viYXV1eTXR49vUzrBNMMT4Awn/s5ZVCEFankOas4a/gm/FIVS5A+FQDqLt86+Rq0T1lBXtNlaOl+32DMmU+D7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WD3BuRHf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WD3BuRHf"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c8ac50b79so325485ad.0
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728938109; x=1729542909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rjr920c3aiMMz1TWsbmJ2QFf5YXcRVh9DraQXAryuvA=;
        b=WD3BuRHfIlIyWqcY7/bBK6A23+4h7hwLVMwFXfbmV4HlWUBBZj1zofWfZLcAcaS4t/
         wwcBEL690UydqPt0CFsUPOTqwdbSwN97jJa2lwlZgZ9k5coEIqD8WLm/aHqI1wrsuF14
         TdtfbvtmD+miTxXij2AMntzTcV7bxAuDejyZt57qxbUF1FS4eXuS8synZ2mgQit54x8G
         6Ehder8o/xX8RSqpTUG1c4OgSCPZO9TXTP9BEsnO1B/0E+XWsQ8Ud5W2wiHW9UjV6go0
         HXSzsNblNyCxnBWy5RMjba2wXnGJjiSzESBmF+CzsfAUUNDkIyx6yj0dXRBvSI0TworC
         GTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728938109; x=1729542909;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rjr920c3aiMMz1TWsbmJ2QFf5YXcRVh9DraQXAryuvA=;
        b=JuLNF87KHkLBBUH//wXop2kP+BrHXgrOzJBhtlI1JecU63JmG096QnUSoa7fluhHAG
         KKMClezKRQtX6Q1wfUzCEXwx1pMgzHABhz6HyT+fORReHmkxDtS5E7ezIdcnMuPWw1/i
         rWzPXpP6/wEhpSl7TDvE+/d1gVv11XHIBJ54KIxXB3XrwIK8k0SPgdQpqxvhSNBykF9q
         dIojqPuRyY0nJKOgukxp/7YYbR2PwJrK9SsIx4+o9izfHIe2RHVXQOqvbhB9dU1IcHv7
         8g7JpXtlwmTu9wR+9UmctGzqRg9qCmdXngG+zCPobSN9eZRs3uT9ISO50AT88SX2Kg8A
         raKw==
X-Gm-Message-State: AOJu0YxNzZH/GjdRSLhIIDsd4zzrV/JbPus4M+dWHy5jaiJn/6RakzPW
	8OQKB2rhtXTN8FmaHkx4ggj3DjFazkN35k01dDNdareYHvh8dmi0izWjHNuB+XK1gNgcZDG0pRA
	43A==
X-Google-Smtp-Source: AGHT+IF/hK8CRk5+W8XRxxIuiM8d1Wagu2r1vFJXm7O6S4MJvVTzp4c1Z6zp02EErTjUjIASDRoaGA==
X-Received: by 2002:a17:903:2442:b0:20c:769b:f04d with SMTP id d9443c01a7336-20cc02bd0c7mr3809995ad.7.1728938108323;
        Mon, 14 Oct 2024 13:35:08 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:2a9b:d27f:d626:2e54])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea76808b86sm3699621a12.32.2024.10.14.13.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 13:35:07 -0700 (PDT)
Date: Mon, 14 Oct 2024 13:35:03 -0700
From: Josh Steadmon <steadmon@google.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org, eric.sesterhenn@x41-dsec.de, jarlob@gmail.com
Subject: Re: [PATCH 1/3] fuzz: port fuzz-credential-from-url-gently from
 OSS-Fuzz
Message-ID: <qno6z2tvnx44qvcz3s3klldpshszfw3d6zk5io6chsg4mz7t4v@c7hfalghw56u>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org, eric.sesterhenn@x41-dsec.de, 
	jarlob@gmail.com
References: <cover.1728594659.git.steadmon@google.com>
 <625b8d607ed2c95e396e7794616d9f290f23d15c.1728594659.git.steadmon@google.com>
 <ZwjsK-uprX0eUAl5@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwjsK-uprX0eUAl5@ugly>

On 2024.10.11 11:13, Oswald Buddenhagen wrote:
> just some nits:
> 
> On Thu, Oct 10, 2024 at 02:11:53PM -0700, Josh Steadmon wrote:
> > +++ b/ci/run-build-and-minimal-fuzzers.sh
> > +fuzzers="
> > +commit-graph \
> > +config \
> > +credential-from-url-gently \
> > +date \
> > +pack-headers \
> > +pack-idx \
> > +"
> the trailing space-backslashes can be left out, which would make the
> code less noisy. then the variable would contain linebreaks instead of
> spaces, which the for loop would be just fine with (as $IFS contains
> LF).

Fixed in V2.

> > +for fuzzer in $fuzzers ; do
> > 
> the space before the semicolon seems excessive.

Fixed in V2.

> > +++ b/oss-fuzz/fuzz-credential-from-url-gently.c
> > +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
> > +
> are these seemingly redundant prototypes meant to suppress compiler
> warnings?

Yes, unfortunately we get complaints without them.

> > +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
> > +{

Thanks for the review!
