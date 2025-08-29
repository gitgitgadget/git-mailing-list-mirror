Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FCA2AEE4
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756427706; cv=none; b=sBtCYQMiB+Vofpo3ufTGAJNDyf113VwTTnsFkuRLNBq8L/+PbgIpCAqB2melRMeccMXjoSEAXBDYZNIWzRg7RnJMYE5r2TH3CvpoYi/OFhh5Vjzh6KtXg8whYRcL6PXKgzMllOqa5eVSyCZZbRwBcNvrvDkArYbjvTAiXMikuw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756427706; c=relaxed/simple;
	bh=sjDLDI2xH5wFbjq4GcoK/fNm40NRAJvgs3ulF+80E2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJ8S4BgtWfhoH6AFS2mVWbpysSjnasUgZOixcENZBwz0lXZLR4w1HIGLc8TPoF+3SBTDTsHUDzcZo6zCV3IUaF1fcuyi4qqpIHxZlLLEFuClkSXG2iuL1CPlJ7MyoOLoKUb2tIbCuefCKTOuECYaB4BLT1cRN3HsOkTFF3/JIao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=eIezYfsc; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="eIezYfsc"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-886ecaf455aso128456839f.0
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 17:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756427702; x=1757032502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=npL5x1Rgkg0Jv1iLuP0CxNXI7tFKvc7tynGtq4QvHuQ=;
        b=eIezYfscasVGWJHtDJBOU1f0fPBcM+xTDPrAK2HY4rDPLwCOBljfA6XX4H3ERraTLA
         jPsrAc9NVgvAwwxGW7m5axJqz2ksQkA9iLOKDNZ4PQd2+RSZoUp5lQhteAxlG4mc2QZE
         QUUQpEaiL+/ZlhkK31bBKXMV4J/XFyaGa/p/6vGxPzr5IofoGHnSPKFmuFx5PgV1NNiT
         wx8aASoqsR9Or+qBcqpYShJ+yzcXe9mKwZZAIRDFoeRU8r0bwN+c4oBXbPMC91XV1HT3
         Osbx2VAj54bRkt0M4+XQcN+UTr8A8qOe1sBO0fMU8dzHQ/yxVpjgUasd5G3luKKsgt6E
         kuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756427702; x=1757032502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npL5x1Rgkg0Jv1iLuP0CxNXI7tFKvc7tynGtq4QvHuQ=;
        b=L3metmpSfYqtqavtarfEiFhVVoM/bOvi/wv/UxwcXUxTi1OJXkMC59ZEEhA6FjC8uU
         qsMLPM2N+QxjPdQtkteOjWBQMq5Hf0IJrU32v+3NNLKWkUoudfebPuIpLePy9EWpuKKC
         aCc+56C10r5qX2zht1j4XecpxFYZCKKQGq2YPWWmphCTcLrZKQNEW9p5I5b/AThYX4xU
         6VYFzUuuXFzrD4SHsMe9sRt07qi+Zmn0z28xpXAau+GjIz1qUqBeD3IKnIhk5kzIt4k6
         7Lb4Yycq8lo+Eh2LUDEDZenhAOEGzbawtESNa7Xvz+Rj3STftZazp57jtblQNkahkTRN
         eYvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL1qLStz2nOwHETL8GdXlaBogqBMaqBEbZh6Bpx99yYY7SOwfiRxKfN2NBSBHGEcRaado=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfiRBOn7JkMoqFbrXzfmhnRCdbdr8koNWl/Cvcy4hqBHHDjcxy
	dnRq2IG3GClTiv8oPWER2nQ4xIZzIAqVuk9iGU+ZN8MzIWFQwieBdQj6SOiNMxGZMvI=
X-Gm-Gg: ASbGnctvXGgbtQgNdCM0WscuB/f4Oy1ukr7zmlh0zzcWgk0K4hx6lxsD8V/GAeecwht
	bJ95ntGLBZyWDixgPO87eS6wivJsQOUtxjT5OUF8Y/4dutj5lkiCLdJ2bNN5qXoHbW0lv6YTFSE
	IlPzYGUNoO8S52frjYHvuxDx+bGW9y/Ep5PliDWjqps/0HOXdpi6gSy+rU4i9G5VuLaCjDKljrn
	lrB7KWpX0EVMuZomRXb6A9uA7/5JYUrS5HBcc+JdMcruwUmcp1rYVCErTCIULF+oRcxTyz2yDDk
	/PzRXGOrZxWdRq7HbglQWvmSmkbZ+Urgty6OSoZdIwCJ5YV03urBUCccX0ncMnewpd3A2mvM+Hd
	BygObRMzSFkpZCcH9BBZqrO5yWrk2rkDhkyfJZBLDTnVpWUtm74B1GfFwANrGilVojUEFQQPpwB
	WsosgP8tBzU7jtiJtoxeZQUq12Pg==
X-Google-Smtp-Source: AGHT+IEHRH/6IDLi3tPZwfcfqWMmuYWJ7jpHo9E8mONKJARRTlgtmGXkjhc9iDCc5tOcu7vZ0WS0jw==
X-Received: by 2002:a05:6602:178c:b0:881:8a58:3bc6 with SMTP id ca18e2360f4ac-886bd16da0dmr2787948439f.8.1756427701772;
        Thu, 28 Aug 2025 17:35:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-88713bc6d23sm16971839f.0.2025.08.28.17.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 17:35:01 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:34:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Toon Claes <toon@iotcl.com>, Derrick Stolee <stolee@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 00/10] midx: stop duplicating info redundant with
 their sources
Message-ID: <aLD1s/LAcYlDujJG@nand.local>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
 <20250811-b4-pks-midx-deduplicate-source-info-v3-0-e442bdf2b4ad@pks.im>
 <xmqq1povt67o.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1povt67o.fsf@gitster.g>

On Thu, Aug 28, 2025 at 03:46:35PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
> > Changes in v2:
> >   - Fix a comment typo.
> >   - Introduce another commit that simplifies the calling convention for
> >     `link_alt_odb_entry()`.
> >   - Link to v1: https://lore.kernel.org/r/20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im
> >
> > Changes in v3:
> >   - Introduce `odb_find_source_or_die()` so that we don't have to repeat
> >     the calls to `die()`, as suggested by Taylor.
> >   - Split out a patch to adapt `link_alt_odb_entry()` and friends to
> >     consistently name the parameter that refers to the alternate object
> >     directory's path.
> >   - Link to v2: https://lore.kernel.org/r/20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im
>
> This has gone quiet even though the previous two iterations got
> fairly detailed review.  Should we declare victory and mark the
> topic for 'next' now?

No objections from me; though I still would feel a little better with
Stolee's opinion on the MIDX --object-dir stuff.

Thanks,
Taylor
