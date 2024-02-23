Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E22924B2B
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708728367; cv=none; b=a+LUpt5s8tN5YG0JLwzi2y2VAA9amMoWdPing9pJ8nh3m9Q9CMMeFmxjmJrnn6K7fihsV7niuca1/ykYJvcCpCpNiWuTPoJfT8i3f0TQeTXZlofTeIstDhdb60Qbd5Sj+zJbBBNXBTHVZxVnY2GSITd60889h263qIQbXRI3JMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708728367; c=relaxed/simple;
	bh=OO9HQIzXMZQWbgJZ+gF5mV/Vstxk90QRcHXQq/3ELjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOOxyF6YJzAtX1ozh/6zOFCzX6Tr7tLVwD0lt9rtSFT6KakirLNd3g4qglIj7gnmF1i6ESIKUYFDhi5o0dGuN/zSqFaOkX5FbODQywtNYj7VLAv+8PJ/+EH98VFQTByZORRlbFDk/xhEBRMbbQJmB8+cBu5Qt2cJbkGhm4ZLmLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aPkMB0pW; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aPkMB0pW"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso775281a12.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 14:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708728362; x=1709333162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utKCE2sdcG2GoVuMU1fE4LdoHcLS53ZQ+ckMpDv19Ic=;
        b=aPkMB0pWirhvIq0PyfTH4mTs8AVT4AQhfnvpkCNayop+t08wySo771eFY3gDGoqVkW
         wzMAIMN1xpFMajCFIT98UBz5y7nBHdv+yVQHwi7Vh1z1hf5nkNZ+0688NWNWUYBiZqJ0
         5EAtzfXWtx0HDKDyb2Tr4fM7M1U3N7Jj4CvHaJXD/l2ZRKPATEXDVfF3iiQu4Ibkuj9y
         koLNQF5jHr0pQzwXdubBkAIOVEZE71EpSEDYG2FmpZ2Hj2fA5s782yAiIyO+SfAVMI63
         gYawJ/Sw2V5puWupFz9dZIBD5Kw/o/qvLwpJWWhHqs+n2OpxEzaFmsRkFipbn4b4PP49
         gHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708728362; x=1709333162;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=utKCE2sdcG2GoVuMU1fE4LdoHcLS53ZQ+ckMpDv19Ic=;
        b=XWL2tozwg6cebRVDxewTDqjzNRjJEDAysaWzd4ZxEWuzSzvxh+9AL9sAEPJ1Ia4RRI
         k+V6okDCJ7xZ31J46Xdn5z9h/Cm8UmN0NRgKT9ZLIVK+6380I3+sVe/M/cZdD+kHXKmA
         8yxLWqhKASd/6LRf8PxEWuxZbdLwhQaZuEM8a6Obsx82RcPvgGoeMvREZqwg5BMf0au9
         xHJRDt0XX/5fjZrYylNUJkSmDFB64ycilVRWgNk1jvLvkDcs0+pj9yBKRlv4Q9dJx+PX
         YRfIkiYXzCor5MQEvk72S/ytLlTpCtbJGkDbMgHXosqvua98jgGgvzQQf7kPzd4PPJwh
         vwUQ==
X-Gm-Message-State: AOJu0Yz1IC86XxJnsmWwVbba9RjzRvKOB2u1UlYeIPXs0ffXD0U/DQGt
	7rV8O87X27inCvCLGqOSZxuiS70EqCUBhcDiFUHNO0+URGu6FkzwzwUbeNLB2i+piQ2hkEh59pl
	S2g==
X-Google-Smtp-Source: AGHT+IGdPp7yz5kVckJG/11crGc6sCLoDnqXqNPZ9zFuIm95tSYJCN/zCbeCTqvDta6Nq4SMUKo1fA==
X-Received: by 2002:a05:6a20:4390:b0:1a0:e80a:b79e with SMTP id i16-20020a056a20439000b001a0e80ab79emr1794739pzl.14.1708728361792;
        Fri, 23 Feb 2024 14:46:01 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:2fd9:97d1:a490:26b8])
        by smtp.gmail.com with ESMTPSA id fn15-20020a056a002fcf00b006e324e33ab8sm12841064pfb.218.2024.02.23.14.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 14:46:00 -0800 (PST)
Date: Fri, 23 Feb 2024 14:45:56 -0800
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 4/6] test-tool run-command testsuite: support unit
 tests
Message-ID: <ZdkgJMu3bddMmdbd@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, peff@peff.net,
	phillip.wood@dunelm.org.uk
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1706921262.git.steadmon@google.com>
 <b5665386b56df91fa5d95ee5b11288b5853546f0.1706921262.git.steadmon@google.com>
 <xmqqbk8s80hh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbk8s80hh.fsf@gitster.g>

On 2024.02.07 12:48, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > Teach the testsuite runner in `test-tool run-command testsuite` how to
> > run unit tests: if TEST_SHELL_PATH is not set, assume that we're running
> > the programs directly from CWD, rather than defaulting to "sh" as an
> > interpreter.
> 
> Hmph.  It sounds more like "the run-command testsuite subcommand
> only runs programs in the current directory", not "assume" (which
> implies there is a way to override the assumption).  Not that the
> limitation would hurt us in any way, though.
> 
> > +	/*
> > +	 * If we run without a shell, we have to provide the relative path to
> > +	 * the executables.
> > +	 */
> 
> It sounds more like "If TEST_SHELL_PATH is not given, then we run
> them in the current directory.".

Reworded both of these in V3.
