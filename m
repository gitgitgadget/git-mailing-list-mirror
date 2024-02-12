Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841F14C61B
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772533; cv=none; b=WvmA94eJIAsT9+q3ieIDX8Wd8KmtDZEONwAgPeYBcNKX9oQKimVJThCWMMqoct/hiiU3EOQTGeD5N0nBM6QtlHq5mpLv5lbc3F8sHQk69FnRiDFpHCYcgQTTus6woSbci9t1gKryB8zNpBGZCdNt8bNfD/3fzG1sp1ERBxgwgns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772533; c=relaxed/simple;
	bh=Gw9+ElWowHSia0rktXvYl5BnIC3LZTRG0CafC71R7K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mv/cZ3xiThXcrWvii6nQP6P3rSz7I6dPAUuGeMCDRvx1cQ7/iqyUn24w+8X6exy3yI7T+rub5mlSZ6It2CeDc8hXKOaZFHuoOFKXUlIleOq+jc3i+UHAyJsWtb9pTSpR6RWAqI+tay2CTbChY0JXttFm2h8o0SzakH5h/qBfdtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C+3aDimX; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+3aDimX"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so2855690a12.1
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 13:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707772531; x=1708377331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pC7L10pHVRSvlofapo2bsfefvklc9WCPF1nQgAFaMjY=;
        b=C+3aDimXKLrRxiSi5s9wTodYZLDUMjkfYvboaEngew3xnMUpHeWoXvF5bkiDNfc2EP
         9eCF53vt0M3e2Cx9MAXP/uTQ5RgikMYVrRTBleHOhxXEYwCbWxjtoePh0UljjCu6TfYg
         BXjFQ6Lp8UI/kXxdIAHBytsBaSe8gGB5HxcdhyMNXwrfBDKGUPSowb79iZAvkqULL1t7
         aE1MHTDx80xIWqoyapOqN7MNyCwKURJZCH7I85Pn366vWq2fZCEKbT8TbjmdfDGJcF4C
         kagEh3q81AZ1hRqC2wqqTLYZa6jYGiWyjp8UBCKWEDgGgHnFfUXw+Byw7PmQ4Hlkzqtz
         ny2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707772531; x=1708377331;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pC7L10pHVRSvlofapo2bsfefvklc9WCPF1nQgAFaMjY=;
        b=PuWhBRNa6lZm80aZklewAhlFaRU/BL/zXzhPA0eAU3x3ouRZvpw7Ug/Zv/xPLkdnNO
         tjK4lEYg/KetjA09tJGxrDJMVcmhdRSQ6ujMtwNPs0cSq2epST9oOCwBu5lK+0Wu4vzU
         9gcBQtX5v8e95At4VMs0hp9ot+ISbY87qlNOcuapjDMYAmJJYUaswjtg6qRdHWtEaNYA
         PIdhMcrPVCtQkMPU17diJYvSYNu4EFT/+bOGRyfuCdHEYWbZTgFYFOjgzcwfthrlTwhm
         c/i9W0ZRZ8Wd9kEODIyY3Fd0vmRRMznrkFPS6HVmSoKwZyYpuKeksttbHsSZaEmhQ+zd
         db5w==
X-Gm-Message-State: AOJu0YwLmwKKyR5lGIDSyLYzb+o6zCl1LITZDzFJQsfZxLR6Zjilyf01
	by28ijyN/8GI222XIStzcXYIp2fGTCTlMI24GEmgugzKtsTD2CWTuW7CYu9KX+jmL/rjfHcKAxa
	49w==
X-Google-Smtp-Source: AGHT+IFiJQuoSCuo3leF0o08w3GtdYGgDi53tr1kSDKbDA1ZQNSq3D/wX3KZs92WSFaQZQpMhE/Q2Q==
X-Received: by 2002:a17:90b:4009:b0:295:ade7:cdf2 with SMTP id ie9-20020a17090b400900b00295ade7cdf2mr4586077pjb.13.1707772531099;
        Mon, 12 Feb 2024 13:15:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZWml4ozd4MIZmO2frn4S96feLRtzI/AtLx8NhGASSFr6SzvcriZRytUXQiFguL6DsoFnqTeUSLjPXDwBizd4HoUft2rzRoDNt91uUoSQoblZrwBM+otAfS+5L0IGAyqJiR4d96Ung3p45Ces=
Received: from google.com ([2620:15c:2d3:204:5bb3:9725:3d2f:4438])
        by smtp.gmail.com with ESMTPSA id lx4-20020a17090b4b0400b00296ba96cda9sm964449pjb.55.2024.02.12.13.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 13:15:30 -0800 (PST)
Date: Mon, 12 Feb 2024 13:15:25 -0800
From: Josh Steadmon <steadmon@google.com>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
	gitster@pobox.com
Subject: Re: [RFC PATCH v2 4/6] test-tool run-command testsuite: support unit
 tests
Message-ID: <ZcqKbV37GDfNb4oF@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	phillip.wood@dunelm.org.uk, git@vger.kernel.org,
	johannes.schindelin@gmx.de, peff@peff.net, gitster@pobox.com
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1706921262.git.steadmon@google.com>
 <b5665386b56df91fa5d95ee5b11288b5853546f0.1706921262.git.steadmon@google.com>
 <4e2cbadd-1e0c-4526-a50f-9ba8600e7788@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e2cbadd-1e0c-4526-a50f-9ba8600e7788@gmail.com>

On 2024.02.05 16:16, phillip.wood123@gmail.com wrote:
> Hi Josh
> 
> On 03/02/2024 00:50, Josh Steadmon wrote:
> > Teach the testsuite runner in `test-tool run-command testsuite` how to
> > run unit tests: if TEST_SHELL_PATH is not set, assume that we're running
> > the programs directly from CWD, rather than defaulting to "sh" as an
> > interpreter.
> 
> Judging from the last patch in this series it seems likely that we'll want
> to run unit tests and integration tests parallel. In which case it might be
> better to look at the filename extension to decide whether to sh as an
> interpreter so that we can avoid having to use a wrapper script. Then
> 
>     cd t
>     helper/test-tool run-command testsuite 't[0-9]*.sh' 'unit-tests/bin/*'
> 
> would run the integration tests via "sh" and the unit-tests directly. We'd
> need to figure out how to look for tests in both directories as well
> though...

At the moment, I'm not planning on trying to make unit tests and shell
tests run under the same test-tool process. If that is a valuable
change, hopefully the Windows / CI experts can use this series as a
starting point to make additional test-tool changes. However, I will
probably not spend any further time on this area.
