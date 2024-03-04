Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2386216C
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578665; cv=none; b=W6oWwryQIdZqAr1Vx336xJo1WQBlVfEwwocO/S6gALnbnprt8R3FbUItj72zwovAHEh3g1mA+LfqNvfc3pCxvdmjeRnpjP14mRh15zjEXcIhiBXWUuTCVthClpLoKLtvoJuRii7MDyGIBd2EeeQg0nSqK3B4tuxgQUiiTqCfzls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578665; c=relaxed/simple;
	bh=3r9uGlpCgQ8b6m65sWKadhx5SVDz1zJoVUqBl2FLdYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STlTx4fuYAKO/eAfdnJpsGYxuFPzU3ifyw0797jUGoQF8yEiP/P10ur1ZzJ72wwxC4nNxkXQh+qYQ9bgtXsKGFHbB+1ItxlZC4Ecbrpqq/4eOqS6vNbjjwlLUjLqKX6qopAT4cUVzCGBuAfVEipW0RrA5MigiOXlacbsb6ka8EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uQ5m7fhI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQ5m7fhI"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dba177c596so29772025ad.0
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 10:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709578663; x=1710183463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TXBSLenlj/Jg4hq2tvwL9BGjHfB9i9o2GNMuPb2y/k=;
        b=uQ5m7fhIEavwMoJF6VzZv20q7yNqe6N+DgzAwwMdLBTNQF/deCSiGRUXh8ql63F8Gx
         +9kj6Sfyj4qjYcreqXA/OHuI0WkH6qcwOUOCqzJMLbudF2gHsP8A6KEzKG8FTXHgeHnD
         6bVgCP48k/Zu/tPVP6y1qnjBDeWeS4qYDM6T2ASqWaaM4y84F0a9OlDyUdfhTvTxjIhL
         QGg3y6MsgRh2jJGy2mTLuX6zsifgH/nXmj3Qb+3kVWHr/MaFSCdZRGWkG/bh6i8uHFLD
         CYmQE/2kOxJMbgg1EA2Jh6ximZFEbpHzknV/WqQPGwFL0vPbvPJPaNgp+E5ontg5Xsau
         Q+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709578663; x=1710183463;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3TXBSLenlj/Jg4hq2tvwL9BGjHfB9i9o2GNMuPb2y/k=;
        b=WnfGkAcmwNpQ1EA3/hqE3SVanwPMsB6eyrk4ctZSy7XhBQeIsTnKC4Oyq7tV4LYvS7
         hj5KJ1wq1ccgWwu3TmmIO9acodYqtx875yzpJDyHiMevEZkoyRVXUdy+UpYhguZrA/b9
         AL/ikk29ECGiWsh2DRK1Rp4CPzyGTd8a+RFIXvTHi8e9ZLSXWuLex//YzqbVEi2g+kmq
         5dZeJnxIJQUH44h1gClfpQXu2O4BW8L08ne8QyibtmMyTykVA29pH0X6GxOlAT3daX4a
         3gAprO3FPnxnuzz6Uu35fm8zs73qDXHnSXEqzr6Le9SmVT6qPbp0KbUCqa7J5tsWx53I
         vo/Q==
X-Gm-Message-State: AOJu0Yyobn52yFndOB63RCAlu/T7G1PnVE0vXAENRpmr9kM0pZburVco
	1TQUs64UGrdUxXdxwr7kNfV+jysE7i13r1/vlXgDaqXYd5HmxmyX4UsBuTBzLtByV5RBGSA9v6+
	n6w==
X-Google-Smtp-Source: AGHT+IGCBJfW/kmr56OaocdrZQRty5Tr9z1qWmvCIVsO4cIVm5rssiqCvkN+Hh5JGDl/4kLOL32xeQ==
X-Received: by 2002:a17:903:2344:b0:1dc:6073:a3a4 with SMTP id c4-20020a170903234400b001dc6073a3a4mr431624plh.3.1709578663361;
        Mon, 04 Mar 2024 10:57:43 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:3ccb:2f09:89c5:5915])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902d2c800b001d94678a76csm8874557plc.117.2024.03.04.10.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:57:42 -0800 (PST)
Date: Mon, 4 Mar 2024 10:57:38 -0800
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] fuzz: fix fuzz test build rules
Message-ID: <ZeYZolhLCftYALYU@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover.1705700054.git.steadmon@google.com>
 <9332e225e44b29be25d10229b05f0b9775b85568.1705700054.git.steadmon@google.com>
 <xmqqcytxhrgs.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcytxhrgs.fsf@gitster.g>

On 2024.01.19 14:46, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > @@ -762,7 +763,7 @@ fuzz-objs: $(FUZZ_OBJS)
> >  # Always build fuzz objects even if not testing, to prevent bit-rot.
> >  all:: $(FUZZ_OBJS)
> 
> So, this is what you referred to in your proposed log message.  We
> do build objects to prevent bit-rot, but we do not link, so it is
> merely half a protection.
> 
> > ...
> >  fuzz-all: $(FUZZ_PROGRAMS)
> 
> But there is this target.  I wonder if it makes it even better to
> update the "always build fuzz objects" one?  Given that some folks
> may not have the necessary clang toochain for linking, it may
> probably be a bit too much, perhaps?

Indeed, this would have caught the previous common-main issue. I'll send
a followup to fix this, thanks for the suggestion!
