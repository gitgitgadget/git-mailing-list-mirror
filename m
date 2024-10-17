Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC2318133F
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729190493; cv=none; b=pJ98cxPEjAm8J6KbMmcIWlur0ZKZckMOTQrLOBDkcWvBIe77lGZL94+oNYMlpJ9V/nhPr5A7iTCFHb09q4oHRHJVEqMs5hjL95MxOlUP2b3H/hoJqhqXwGA66+BO4YyiK78WVpyTOPyXmVmfwxDoVYv3hBEyLRVolD1aYnJvTXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729190493; c=relaxed/simple;
	bh=iRH/lZ3CrF2LD9oitoSstGN4+8ALbE/1UY0SU4rGG5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gofirVBrTiWs/7jNeMLF/bHJeob67kHOImG7t2YH5C4RpYpBbgOnfKEFcHK4zBz7VePENhwhYmGxlh1cGfcxA/Z+X2H/zOw0HvAmzIhGIsLQjQLM6Ffb3TRMXVQIVGra1Ll4KmePABv4nKlIcS7oHxHeaSyo9nmABT420uHJmb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jkZpCPWE; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jkZpCPWE"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e290e857d56so1330046276.1
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729190485; x=1729795285; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iRH/lZ3CrF2LD9oitoSstGN4+8ALbE/1UY0SU4rGG5I=;
        b=jkZpCPWE+fdTcqoCOjrBqoIE/PUFp4IMrhzIZ+JCSmsPUn/X+tfwpRyYWvXWA9YVGt
         zOeP7LpnCii6qZlRXQt33lAZILOzU/mkCDKPpgnbKNrPS2cNQe056edyeuQR/nzVeEuM
         10IapjD8dxKB/ErXkP0xL5HHUzsr9ED+KfDiMVaSH/HfyxnX9CO18Ht6+zgNM5SeP8/V
         v1FwpzYjLj9N8tevqqT2B+fTMRw19ALTuRJ0e2nFzTIV20XK2calwZMARMCk+8VAskTO
         tNz0F6pSDroNQreB71x79AvtCpxIYIrvyJwEOXHGYNVLTXb/oJ0WvWtnisocMEYufSNy
         UYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729190485; x=1729795285;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRH/lZ3CrF2LD9oitoSstGN4+8ALbE/1UY0SU4rGG5I=;
        b=FREGf5wnZtDadmNerXCNZwFYKPuJO8ipx2R3F+2q9jUKDgUxxVd9wrgUWPBmp4L+PH
         HXw4DKuRZg7KWx1Rg7LMfZ2wuVoceHxlU5zFaLC8AAneZouJfcSbafJcFkg4twDFyYaD
         +ngpzbqagGeANa37joGstekWtSydAIvqLgUvNHXLlMr2ghkkBnelJu21ZXGdiubirsTf
         wgAc7qEIMI9QO7HZfupTHApjm6I3AV5FeFMSVDNTC6ydqZM5+5790M+55jyVuVSZ8HFT
         9D2H+U4mf7H7mnhNtdgcEhqVEtaNrbuY6keZfadSeH5Y7ZdW77JNGbx9gui37A3pEq5o
         Ex4A==
X-Forwarded-Encrypted: i=1; AJvYcCXU5t54qBNkylCmQKSoPDoOLxHf0UWvYX8DSrWXpMsmvhomWWIj85s/30mcA40dyzuBk54=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE42xlJKtAIsWsE09h7MaMBCrBKbrf0pwzsK4QZAPZVR7B9L4P
	nj8xpnhr9cUmqZqv035+2iSyW6az4n501K1sIWG11zN5cRp8qcKh95Z2M1NegwuLXNPnvSgJEfp
	A
X-Google-Smtp-Source: AGHT+IHKiO8YsfLQdMoxi+knQF7EBH5lYlM/9ffUqeCu+XiImbhnRIuYYl2DoG89HaVxq0ZT5YOtiQ==
X-Received: by 2002:a05:6902:1286:b0:e29:2f00:803e with SMTP id 3f1490d57ef6-e297830e9cemr7912878276.33.1729190485369;
        Thu, 17 Oct 2024 11:41:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bb03efddfsm3146276.55.2024.10.17.11.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 11:41:24 -0700 (PDT)
Date: Thu, 17 Oct 2024 14:41:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Dario Esposito <dario.esposito@electrolux.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: fetch and pull commands not working with latest git version +
 BitBucket
Message-ID: <ZxFaUnQvVwaoc+pw@nand.local>
References: <VE1PR06MB707063B6C98798EF8AD9EF00E5472@VE1PR06MB7070.eurprd06.prod.outlook.com>
 <CAPig+cSzkWfC7WSrT-1Kdm78PU3EPNj25+FV4gZfERQLOc6U8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSzkWfC7WSrT-1Kdm78PU3EPNj25+FV4gZfERQLOc6U8w@mail.gmail.com>

On Thu, Oct 17, 2024 at 02:32:40PM -0400, Eric Sunshine wrote:
> On Thu, Oct 17, 2024 at 8:49 AM Dario Esposito
> <dario.esposito@electrolux.com> wrote:
> > What did you do before the bug happened?
> > I updated from git version 2.46.2 to version 2.47.0.
> >
> > What happened instead?
> > Git fetch and pull commands get stuck and never complete.
> >
> > After reverting to git 2.46.2, fetch and pull commands are working again.
>
> This sounds like the issue reported and resolved by [1].

Thanks; I was going to say the same thing ;-).

> [1]: https://lore.kernel.org/git/9d2d6e7b-9691-4c9f-9b13-f1019cd1c491@gmx.de/

Thanks,
Taylor
