Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF49C3D813C
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053906; cv=none; b=ryCFpQqIo46CLntkmPGZPrYoDMjOBZ9T/VDNG27vpTSF6Iw89UDTbLruEMWDSUMOw7HMjZ2beJPEv7Pi/YtMEPuS8M8p7qszwJLl6oS4APu8EYiEbompKB6BH+wmjOH0NvwoL4jlVP6P89CEabsyI64suMjRYqEbkQf06iI2Hfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053906; c=relaxed/simple;
	bh=D27DSrvMJK12a+R5OMJPlzYxFJ0rxDWR7jDw0v65H0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJAk5Qaj1LhktsqadXRsGqcElakeOJZb2KZrwcCGS2dgBXmh3bRm0s0yAgOykpONHF9mBrOTOQUpLXBTzzuV/xJQnvm3DqTqm9oZpTW7sxUW13gwFJNB/QEpR1V94RLaQlKAFWvd5sj36/pU6OvIwU/OZ6qm+USPkO/332hy+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Yrf77oIp; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Yrf77oIp"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8f4b690e85bso3272636d6.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784053903; x=1784658703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D27DSrvMJK12a+R5OMJPlzYxFJ0rxDWR7jDw0v65H0U=;
        b=Yrf77oIpM7qzDgMdipsZxXjjiKqetLh3Q5CwLr9F1MKncANlEjVgiNveCGOpNKGgAe
         3sqAeugzbJ6/XTAUbksamVoUPLG+hCVpnzhYhH2stcmxa4vDBcYeLPtsCYcvI2UXzpc9
         pRR7q0SkHSgPiWcUVH63LcmMMXCAhWmtDHRYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053903; x=1784658703;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D27DSrvMJK12a+R5OMJPlzYxFJ0rxDWR7jDw0v65H0U=;
        b=JlToDhJtker91zNtX5yWMkbmglyU1iuYufD+TfDrcdooRi0bN9/x25k+PAKs7jCkXd
         jg8/ooc+xF1rchFCKZNM5snG+AcTPhJdvNFGeDCcwYnX5xqx3ZWvqbMoWTna1IPCzc9W
         td+rh8ZKcl/ty0JZEjsHAytnXoNs8dAnyWQqs7cxwPvNhdMAXfzid7/llrVzYUYBM8VY
         N/TdOurU4tp++TJXv1Lgg0V1YONhU3T3hnwXRmpDiNRnCLKIERziTNdNtUCoGzQCposj
         mWcqKtmoDkuTD5x41WR8UYpvsMyMERjdsxbSi5GgpRcCI6NvW/qAe/nfuVTfOdUwhm6A
         QECg==
X-Forwarded-Encrypted: i=1; AHgh+RoEPvjcHAYLESZnP90nlUxYgH/VdBhiXKx37nkpuxtL4fzcAZMECDEcW8jOyIe5CYcxe3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJLnmTYzhSUfY8OXCMqvG364u34JgaM7rb1Q2YsCVnYSmRIVve
	c0j8IhcciBBT5D6nqvDBuD0SeR+5a93Fa0nH8KVQauv7MoBrOSezZ3KuiBIwKM52dxM=
X-Gm-Gg: AfdE7cnvek4VVxOvcOefQvqpDJ1w+e63KaajWaGJ+uFc2T2U48A/CjzhSju3Y0CWwOd
	M/1Bq4w0EUQuQUV24Rpw/HR+YZ/j760qBNI6KY5QQxxP9XuHNPckf85TDTpeo/LNNiHfCwk2zRx
	eQ0chMWkzXJTONJzFEUHOsr3QwztKl22rblAWrR+PkpBdxPW83efKnUBGEyd6li1Rqd2W4MBXVa
	f4QUMklCc8Me+QI+58HUWwkpr1i8UoirlL56ofSyEK+5s+jhO4hyjcB4NkKTPU+V1hif85DczFv
	nh274eD27gcO+h6oYfiREG7qEss3vxi6BtVz+4sAtajGJkZe7yrZag9mRWwTAV5YU1+IA4o4vue
	yPJ554HnYfR5QX2QuZZIg1pm3OOS8U2/hol7jKxqfa1q8g8P/0uflfwwGHl5Adt/h5cNN1S62u6
	6jyehaSlf6XEgNSGhTyNS2a4LQsewKTkhkFok8CRizuI7T1iWHrxSbHX7U+HEu3wfCHdGsZTA42
	3OIdPs=
X-Received: by 2002:a05:6214:230a:b0:8ef:4749:b1c9 with SMTP id 6a1803df08f44-9040187b413mr124968016d6.5.1784053903552;
        Tue, 14 Jul 2026 11:31:43 -0700 (PDT)
Received: from com-76773 ([209.249.37.147])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1d3acsm172259536d6.24.2026.07.14.11.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:31:43 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:31:39 -0700
From: Ted Nyman <tnyman@openai.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/2] http: use unique tempfiles for packfile URI downloads
Message-ID: <alaAi4vNwi-KabYV@com-76773>
References: <cover.1783982021.git.tnyman@openai.com>
 <alVn-QmK3K91_tkH@com-76773>
 <xmqqse5mv10a.fsf@gitster.g>
 <alWXwAGWgXSXoRJv@com-76773>
 <20260714052833.GA2516582@coredump.intra.peff.net>
 <xmqqcxwptpb0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcxwptpb0.fsf@gitster.g>

> I share that sentiment. I am not entirely convinced by Ted's
> response, since a major goal of the packfile URI feature, as I
> understand it, is to allow the use of resumable protocols for
> large transfers.

Agreed. I was too quick to dismiss the loss of resumption.

I'll take another look at preserving the predictable partial pack while
preventing concurrent writers, including the handoff and stale-file
cases Peff raised. Dumb HTTP has the same underlying concurrency issue,
so I'll keep that path in mind as well before sending a reroll.

Thanks,
Ted
