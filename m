Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756182141A0
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729106734; cv=none; b=Ql7MfUMh3afkh1Oj/Q0GZlsz4sJQWzJT9UV8npT++ZHWNN35SJfi5MHOIr3FfHmPOqUhncdtVzmgn9nkwr8/N4PCvxc17iSdD2YnforBzu04TE5x8NQxbgsAVerqLuQXbZjygi5RmtGReO/55KGBL5mHoeiZ2rQrwL6qgmegbiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729106734; c=relaxed/simple;
	bh=9HXpLxIq0i6nhp7QhCx4YrmSF2Dj06mn1LfbpJiGnTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKvQVMbqn2KQb+yVVqOGFHu55Or8RnIXHvsgwxwVnjxL3fwYT8ZJduwtFK942ElniHXH7XrdKjFDaZXjjKjnv7G98PqJSHFuJwnj/MucNNwpqUS1P69A/fjRcp2W5Rzl4ipBNdDDzB8RH3utw+NdTaZHfqvoaT2Xi0Itdndv5ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cAncFLqq; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cAncFLqq"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e2e41bd08bso3347897b3.2
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 12:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729106731; x=1729711531; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A70POtILz/88WuoohZSTpMUuUqrP9GKC8OOLbLZ5gv0=;
        b=cAncFLqqz8muDrwjoaKpmqHKrlOGWIzk1L4g24cmM4U0SeOJWducvMNhL/4kT7rpz6
         ch+o4fkqGzKKOTaK5ybqk4REpOGrC/Ui5vkaAfxF1ZKBPJnT+OlKS/DYI9l7Str3Qhj1
         icmYnGgRVpzqZrkLfLVWsVXbiHak8xJFh8nrtcOkQg7TajfVBbwXiGBadkn1uiTH1IHn
         1srpQDDLSuSS3gaVcTeBDrvhj+Cyba3qXIITTG880HA9tq+MkPEV/aWHJJezkzllaY4G
         RYVPkUiAd90bw7IWbY9AjnZYTS+q20J1fHfudFUz9nQufsFsVOrKyQi2MrbIb5/+djV2
         M2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729106731; x=1729711531;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A70POtILz/88WuoohZSTpMUuUqrP9GKC8OOLbLZ5gv0=;
        b=TKfkHtAUM6Rx49c8R9M2dZd6SOHFqLf/Wsc1juzv+05pxFIJrGHnkoHJ8UCwwuKAvI
         jkKIqGrW/Dvzn0ZKlrGUaB+n/68YPcrEnCIv0C3am8KZ0bu5U6DdwLTQQDzyfyejBpyW
         Nbp/WFzVKsG18zGlLHJOYA7mELDiiiUlV46KhVI5Xc6XCX4SeCPjD7J82kV5+0ZFZJlI
         2/EhdsFCixxhJnhixb0g+TEpC6xSsdslRlS78z2FnJJXrToudb7rPzvvrAwwvLOV5KAa
         2tERpYgo3uR0NwQ76Lyr8ZTNmZyr3RNsUaIJSNURuq+aW3n9qsFvuC4AIigdCSs/oShi
         LL2A==
X-Gm-Message-State: AOJu0Yz+iy8mzEelNzMps7p5FftUB/cixbyNE5fs46t1gRjcVBCokX41
	X2O1lSDb78QrDyObMdRsK57yg3KWapE8Ib85Iwz+pY/dAgRv93rKjPcS5Uf/tRg=
X-Google-Smtp-Source: AGHT+IGz46YL2YktnsaebPqCDNLFKHIkKijAUs6WJj0ymQxxDkpLT6r3PFY480FVS90gFD7L+e2IFQ==
X-Received: by 2002:a05:690c:6703:b0:6e3:3407:8579 with SMTP id 00721157ae682-6e3643c9b62mr151643527b3.39.1729106731395;
        Wed, 16 Oct 2024 12:25:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5d4a505sm8157207b3.132.2024.10.16.12.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 12:25:31 -0700 (PDT)
Date: Wed, 16 Oct 2024 15:25:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] shortlog: Test reading a log from a SHA256 repo
 in a non-git directory
Message-ID: <ZxATKIRGv4QCM9Td@nand.local>
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241016182124.48148-1-wolf@oriole.systems>
 <20241016182124.48148-3-wolf@oriole.systems>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241016182124.48148-3-wolf@oriole.systems>

On Wed, Oct 16, 2024 at 08:21:24PM +0200, Wolfgang Müller wrote:
> git-shortlog(1) might be used outside of a git repository to process a
> log obtained from a repository initialized with --object-format=sha256.
> Since git-shortlog(1) has no information on the hash algorithm, make
> sure that it can still successfully process the log regardless.
>
> Signed-off-by: Wolfgang Müller <wolf@oriole.systems>
> Thanks-to: Patrick Steinhardt <ps@pks.im>

Same note here about ordering Signed-off-by: and Thanks-to: lines as in
the previous patch.

> @@ -147,6 +147,14 @@ fuzz()
>  	echo | nongit git shortlog --author=author
>  '
>
> +test_expect_success 'shortlog from non-git directory reads log from SHA256 repository' '
> +	test_when_finished "rm -rf repo" &&
> +	git init --object-format=sha256 repo &&

I wondered why we needed a separate repo for this test, but I understand
now that we need to have a SHA-256 repository to test this on.

I'm still dubious as to the value of this test overall, but I think it
may be nice to s/repo/sha256-repo/ or something here to indicate its
purpose more clearly in the test itself.

I don't feel strongly about it, though.

Thanks,
Taylor
