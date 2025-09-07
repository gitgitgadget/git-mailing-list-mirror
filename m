Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0002147C9B
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 16:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757263443; cv=none; b=U2PxcsouZnox1cJqUIr3yLOFBh0R0kYAgUA7enJuGX5QMU+LVFBMAf8GRpZHFClAL9ZL+Z/SrSlArEd+fqTUH8tb2e2PqbBNfxnOwecgLTUONaivtKko8Z2nkmj1r6stucc91U5M8voQDFPskr4mMTTPuovOhoCDFfbc80VLScU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757263443; c=relaxed/simple;
	bh=gi/CTksKoOztDwsjCGr0/MKeYxNUXb5puuGQ7zDsFk4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwNKuLsM0mTr4CIQoU2HJOvTXqYqDFO8mN3DKvEQ3AypStW0hn32W3U5iNWchCyl1mqCz9HJcqg8TmOnVLulClhxgVhjdWokjN/0wMLhYC/ySpibVJNvaJ4PMEZdvFDeevqzhjA0BV2HvpPZVQCaHe6ZZE5KhvBTsMSuWmu9xt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNxS7YMU; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNxS7YMU"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77256e75eacso3180864b3a.0
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 09:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757263441; x=1757868241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KOU+BoJgIPFZ6NM0r6FBNxd/1OY72CNjDQTEdNiK/9U=;
        b=VNxS7YMUfsQJd6X1yJjMviq4gavzOzV6zEqdp21Y/G5LcM+x0KMQzvl+hVzWpKUZ1A
         2hMERC1wmqBRMGGKCxm3Y2JIyjH6sQLYbbtNbfrIZlN8kPmQJXu2DO0+SA+cdyjVX9io
         dIvZW4jjpNzvrGEDh8+BlY8gaeEp1c59IhdKvAZuIVzcp/+HwGr4htKnY5IhYZmm5lFU
         f9ftTXBusfgZ4V6mKlaIw0truNiBsA5mWBOjY6zqdsbRx1RBijir79lSIApwGOXBPZq8
         qVuykjFdY+IVc8wcIfnAXZaEjAdrsX/Hu3eRFroieOMqPk3ypfZfLnlY66hdlBLRCFnf
         jR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757263441; x=1757868241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOU+BoJgIPFZ6NM0r6FBNxd/1OY72CNjDQTEdNiK/9U=;
        b=uwiN7Ir0YupkzchVpJbb5EmjCY5DPE338LJsht7iRb2e8mABGmYlGwkQ38HuRtTswz
         3t0oeC8ogu77lY34N2Qt4nUChOeVf6ET7Yw9obW7lFIFgHYGrbyd7eAEyvs6XXQV6JO6
         G0IEycKeLw4iSTQ2Q4XizSjgWmOKsO6DTcmJQSd+YuwD69cKKvKb79vVTbfEzobpGX+1
         b1Glr1go85ngxgTfcsxDn+B1tuRW+P8wCgnV1aNEu4fHuYoc5et9Gx6Od2zeJmg/pDf7
         yRnkQ4Tr9qTucvO3rTzn4InBnF2kv3YluUCj1wt1QTTn+4VUs+Yk4bceTqazWcWJLuZQ
         r5KQ==
X-Gm-Message-State: AOJu0YxR39VWKAeCabR0QqRQ0Grn38PRYKEuseX6XXpuyungESlzWpYc
	GaGWRW4LFZIzHadwE8r/H9GKH8lqhy/cgykOFwYVpuFKpxGVns7st9MqjlQvj0XQ
X-Gm-Gg: ASbGncuhAlvH7lSWTPc28Gi/w48AF10GPk3GSMAyGKtnRta5xoRYqfhO5xTSXFaOWjy
	k5xNmoIMohUxSMO+71E8O2d/0ev6EfHndTVYl/i1h6r3wgN1z31D2SEFwZuamPFT55H171O4A4a
	jDt9OFs16C87K8WOfKMvM9bJOyjH6uc0tayfaI3oezjwrfTBYfEfYpLH5Ghoenuvf3Xwd4X6bKB
	BJlm9Brg2dCN/lDE5edTH+DqAlJvVYbrbIs4FRnZthd8IzksCek+L2ckLE9moTQ96Pzvk3YQwOb
	1TOJB/5SemN8kQ6VZoUNMcKCKjk0ZMaKUXQUzSxQbIhCvvpu9iAtaJAa3dex6hlwGMuGayP4+oc
	cfuoW9I3Hg5N+U1z5CNSDeCOk950I
X-Google-Smtp-Source: AGHT+IGKQciU1Pl2V9GVDsVJHoina5VC6DErM5NRo/wq5sKmcPogeFtSBu3bh1ippiCHKDrpa+AWdg==
X-Received: by 2002:a05:6a00:84b:b0:772:3714:60c0 with SMTP id d2e1a72fcca58-7742de62dfdmr7343801b3a.18.1757263440687;
        Sun, 07 Sep 2025 09:44:00 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7722a26abdesm26691226b3a.1.2025.09.07.09.43.59
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 09:43:59 -0700 (PDT)
Date: Mon, 8 Sep 2025 00:43:58 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Subject: Re: [PATCH 0/4] enhance string-list API to fix sign compare warnings
Message-ID: <aL22TmhBNie3rQgj@ArchLinux>
References: <aL21cEM0OcnrKtBW@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL21cEM0OcnrKtBW@ArchLinux>

On Mon, Sep 08, 2025 at 12:40:16AM +0800, shejialuo wrote:

Please ignore some standalone patches, I wrongly forgot to add
"In-Reply-To" filed.

> Hi All:
> 
> This is a small PATCH to enhance string-list API
> "string_list_find_insert_index" which has introduced sign compare
> warnings.
> 
> Thanks,
> Jialuo
> 
> shejialuo (4):
>   string-list: allow passing NULL for `get_entry_index`
>   string-list: replace negative index encoding with "exact_match"
>     parameter
>   string-list: change "string_list_find_insert_index" return type to
>     "size_t"
>   refs: enable sign compare warnings check
> 
>  add-interactive.c |  7 ++++---
>  mailmap.c         | 10 ++++------
>  refs.c            | 13 ++++---------
>  string-list.c     | 16 +++++++---------
>  string-list.h     |  4 ++--
>  5 files changed, 21 insertions(+), 29 deletions(-)
> 
> -- 
> 2.51.0
> 
