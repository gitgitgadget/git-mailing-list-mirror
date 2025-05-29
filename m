Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F781D63D8
	for <git@vger.kernel.org>; Thu, 29 May 2025 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748554625; cv=none; b=gMllQQxsvGO9XVA9K5r6VOh/sKmqR6yhZSi2W76+rkHDTc4kM4K/veHhfxQjmDQrZ5iT/jljN73SR3PZVAsEb73yENyI7DUjw3XR1tN5Gb4HI9KcAsA90T8t6PRW4FyZwTQEiXogLNCIFu6rLkcNfV+OANF8014vjaAZ2EFq9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748554625; c=relaxed/simple;
	bh=P0LY4I4fIbX5cDo5kDkOIlif3rFx6gc/jPjFw4aeL5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmJkfX+t7Zn872cGXfwRJRfpkRyZqnXKIma3fBxr/x26d4M/IjV+9DldHR7vVCQ0nu6S0zHQKbSUOXGShmgZGRvVhHfWs90gTbacUOiKZQ06oF/KsgWbrKsJTGaq+FOED9f4ksSE4FslbWGRB1NhwraD8qNZw6SEeVhFM6SCxfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIwXtZYT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIwXtZYT"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad88eb71eb5so164520266b.0
        for <git@vger.kernel.org>; Thu, 29 May 2025 14:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748554622; x=1749159422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P0LY4I4fIbX5cDo5kDkOIlif3rFx6gc/jPjFw4aeL5M=;
        b=QIwXtZYTjii4lnRn7Ki9ELpaSS41g6n3NlqNGockFGQYD4BT0y55EocdcBHcXIMhSy
         chDA71DzK1BEnotx5V0oNgR+J4HJr1X4jaA7OVZD9uxYc59HU734bpmsifkI/bpnyPS1
         xJly2Y9OYME6MsxoABvGqaudn/Fq+DA/xRDB7rrn+s8xcZ+1WCSDtOSZkrv1xEt4k1J8
         ezI/ku2/fhgawRJqQcZ/jsDba2+RmPVf5KyJth3uwfl8BVVDcdHt/RZSNv/csAGPav//
         BaIsYPJJC0jgtKFHgskNSnk9je6IZGCLShxg5MHNepWCLQNin6217V6QkTRVknSEiig8
         EX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748554622; x=1749159422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0LY4I4fIbX5cDo5kDkOIlif3rFx6gc/jPjFw4aeL5M=;
        b=SPvZBaDFyB2ZkGA6R2R+sCwSPENrT1+vkZw02Y0mccuYkkGKMkBMJscBlg0OdfQ9XG
         0pqX1spg/u4w0a0nIUrxxDv7UFZf67tHvU4MxBzipNEJ0npnRoOJL7F6/ZC68w6qno7a
         XlfVclGMiG7AAZPTAw2KEeGR+XO/hFR0X0i3Up84RYr6KBfndGT0P45lK0Jbmx6Fq4eN
         J1f520Ch0iFtBVE2xb60SLUCswQnU8XPmGyeK+CczpXTDokJ4bLcmqz0f/IWuhfpPC0G
         yjh/qQawRlQwrMMQoi5kLMuIHfQn3hQ4BvkjWf4yiUELnm8sJr3S21SHFRjZsFgI7N5F
         h+lg==
X-Forwarded-Encrypted: i=1; AJvYcCX4mlzaazsgE7bzueFzxk4BgILm+DUtYHMEHcJOIjjhueyLdvgOrJ7I8uqfMpgMRsXIL+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvrv3kFwk6yS5YUmwdWVA/+wl/3lZzrzWHgZpMC5XCx2jDUYSy
	426A1gZTV17/+YJD0eZJoSK/BJcXXlSfpidzmdG1pTrLoNbHBebz3Sg6QSbsbKfN2X5exAvYWC4
	ufX/20b3Dt0Conrzb+CWTUNPYgH4iB+c=
X-Gm-Gg: ASbGnctRDPLl1kWHqVBdUJAK3duMNzsarNmLzrtXSz9wF8mDcZaeqOUVLDDStIh3Xzr
	Qi4oWc2XeJv5Wt2LPf+V/WHtDhODiv0p5lcB6YqAI9KplAej1mn07sFIhLcXek+Jzc2IC1twDNl
	WGLuChutrSjVQ9Xd2KllXWcl2Cs04j9T1sIcKk4z9L
X-Google-Smtp-Source: AGHT+IFyAQvoCfII2vEgW3sMVUqzvbN6mWUra4q7Jxs7vl8yk3L33zKVjPuEMOIssWR/Tg2J28UNeBhQQkTAWqXFkkM=
X-Received: by 2002:a17:907:2cc2:b0:ad8:9b5d:2c16 with SMTP id
 a640c23a62f3a-adb322b3407mr91457266b.11.1748554621567; Thu, 29 May 2025
 14:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250525210236.116342-1-rodrigorsdc@gmail.com>
 <385d7189-98fa-4863-8bcf-905c76eccbc8@kdbg.org> <xmqq4ix6rt75.fsf@gitster.g>
In-Reply-To: <xmqq4ix6rt75.fsf@gitster.g>
From: Rodrigo Carvalho <rodrigorsdc@gmail.com>
Date: Thu, 29 May 2025 18:36:50 -0300
X-Gm-Features: AX0GCFtAStUFGSV6vTCcpRcSl2sNHmVTZ77IVAm8YET-ONdAm-EThAiIBeufw54
Message-ID: <CAOeBkLo-Df7p-ndr06vA8MGHd42GEB6X3i66PnBt=MrQk7GJjw@mail.gmail.com>
Subject: Re: [PATCH 1/2] userdiff: add support for R programming language
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > This singles out identifiers. Every single other characters would be its
> > own word. I'd consider this a disimprovement. If you are not prepared to
> > provide worddiff patterns, I recommend to use "[^ \t]+", which roughly
> > amounts to the default behavior. It can be improved incrementally in
> > later patches.
>
> Good point.

Thanks for the remark. I'll change to this approach in v2


> > Please squash the test cases into this patch. Don't forget to test an
> > indented function, and while at it, test a function definition *nested*
> > in a function definition: that documents what the expected outcome is.
>
> Again, good point.

Sure, that is an important feature that a userdiff driver should
address. Thanks again
