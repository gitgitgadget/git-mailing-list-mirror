Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD96224AE4
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 22:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744841267; cv=none; b=p+dqaKkOqDB/dsHZJ4Cp6lQHgfDDD97YZFBkJujhRjD+89He40j+BP0l2ntIFp7h7gSWU4M2cchSqPUXpQnEI0oom86dKLymS4hqxVEi6Ax3r6sRtH07tH4C1NQGfnN5IP+Y2HGKb4DmL44iGzwBinKPSz25nRzXqj2LSh2hV3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744841267; c=relaxed/simple;
	bh=jnSiE24GVUQGGxamdrcjXWY3Kb0ubxupYABhMQO+UBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xn8uYST7SeZWZ7GQ62+C13p1tMPkqTmw7DoyOaShqBWBcYNBe5D8Ai9B8q6ommB5aDfOrIlpLA+EGM+5whI3AVJ/37AkhlRcXDIg0k2cRVIFlrxnAuWlaIoSSYR92OiPkLcfSwkbu15onP3QTH42p74SJjKoGNiGySKac57lDXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=VgqEmICc; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VgqEmICc"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c546334bdeso5887485a.2
        for <git@vger.kernel.org>; Wed, 16 Apr 2025 15:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744841263; x=1745446063; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ygIo1KSXtCiQiDpM+QHUHxyLOr8++yYpDuEFQWrJJc0=;
        b=VgqEmICct6EUplDQDWqSinBSu0BdhJpV4lPSxzu6kC8Qm5PWfoLOcbXBf51+b/ZWC2
         jAOQL9IVw3f0jBMXjqZcBCRNHGcbaNEHYadc7T5rFSOOGrNGp9atuJ2xHnOmQxi6hSHx
         wZurUVdWqW94cNAuVLtcuoo13CD7Co4rj2jpkBtBAH7ayxCS9rMb4w0AR/bUbyQ+TEsh
         g9qD7iw7xQ7oHlo66oaUH+JmS15N8EsBWGdOgzX9XKFmx0mOGVRQMNrK2dlNk9Y71GN/
         VnjYUP5fYyzGoP6O/jrAxWlR3b9885hBYFIdsWC2KExy/gpEBpUMEvgmn5v2fFxd3Mvm
         0+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744841263; x=1745446063;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ygIo1KSXtCiQiDpM+QHUHxyLOr8++yYpDuEFQWrJJc0=;
        b=XKGZOtTHpQl0y/1jeQcnx8MQRxstLuUEnSvopempoucn4VYd1oSFCgph9fFoRfNFN3
         0bV22ZuWf0YcCY/tIUOqXkWddqLqWXeVgxWUlSLV8DklzWsR77YNBZH+WObp4ETH6dTo
         2xqm3c5zYfSjN0XCtbFAB81h59vZnPR6vgC9qcNqqDPdkubpnk6831g9zoto2IC73lwx
         vJnhjokZw61sFkEurB8DmMPpdoQLDmL/ves9Z37+M0kXoSV1Z0yiRQ0I8THHRXJtw1pY
         wO/CjVKPVY7X8rIzLe7DZKMMMvVH2rYBCAkOLY9tG8Mt4hVyjc28WXLdc3iiQS/htou0
         NQoQ==
X-Gm-Message-State: AOJu0Yxus/m1o1GM5ZzORI+sMJ4Y6od+0UXSQKSJ27ej8KG2BwVpmiaP
	xtDLyC6Ii4jF6L//n7vpKYSy7LafFq53Hr+XYvJuQlU4wkXbQCW7tCH3/Z8dDR4=
X-Gm-Gg: ASbGncsUzPTa50zjJfyDVGciVTjfr+RYbuNiQiBaT0xXcBh/7Edjmu3WSAT9jfa26Hq
	vlpCM25i/KZlzQfntDx1VqS0VfXUCSoOns4jHP5xDNSuFX78Ja7WK28RiETPuyyWW8vVcZZk33L
	q8N79XvzHIuCurdZ8O48LH1RrPMqkOhhaaqlatuyQTEDlJ5KHrpqhfnnvPjiT9mjNy/ImRBDewV
	KxOT/8PX+z8eTJlMgRthky1fuZkdKKJBf8ArrBd+xZzCIugtjvy7/9KmaVMKnvmOVo3AqiPbM4v
	1u0odzs/XalCMGCMojnJlml5ATwId7r7u/Dv+q+VoXguqdyxbO4LbgUYmI5GBBXoYtG5xHpHU6Q
	fVwIX6q7qdjTw
X-Google-Smtp-Source: AGHT+IH9HQlFA+U+XAO5TVPU3JjSwVyNFeGmLjLdeWDzkPKvKxQnQODzdC+dQ55EISvZghukdFRIZQ==
X-Received: by 2002:a05:620a:28cc:b0:7c5:4caa:21a4 with SMTP id af79cd13be357-7c9190838demr580824085a.55.1744841263004;
        Wed, 16 Apr 2025 15:07:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a8943af1sm1123509685a.6.2025.04.16.15.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 15:07:42 -0700 (PDT)
Date: Wed, 16 Apr 2025 18:07:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/9] pack-objects: limit scope in
 'add_object_entry_from_pack()'
Message-ID: <aAAqLWx7dJIgFcr9@nand.local>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744757204.git.me@ttaylorr.com>
 <986bef29b5f33d32fd366aa9370d439175a9b605.1744757204.git.me@ttaylorr.com>
 <CABPp-BG-=6uRtHXrzSOMw=J2Shg_vfXhLzwWDREy7OAQg_Ak6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BG-=6uRtHXrzSOMw=J2Shg_vfXhLzwWDREy7OAQg_Ak6w@mail.gmail.com>

On Tue, Apr 15, 2025 at 10:31:26PM -0700, Elijah Newren wrote:
> On Tue, Apr 15, 2025 at 3:46 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > In add_object_entry_from_pack() we declare 'revs' (given to us through
> > the miscellaneous context argument) earlier in the "if (p)" conditional
> > than is necessary.  Move it down as far as it can go to reduce its
> > scope.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  builtin/pack-objects.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index 20dd870bbf..4ab695a3aa 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -3490,14 +3490,14 @@ static int add_object_entry_from_pack(const struct object_id *oid,
> >                 return 0;
> >
> >         if (p) {
> > -               struct rev_info *revs = _data;
>
> This change is half of what you mention in your commit message.

Yeah, Junio noted the same in his review as well. See my response there
for a cleaner version of this patch.

Thanks,
Taylor
