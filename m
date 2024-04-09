Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC7954659
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712626216; cv=none; b=GJ4vQ8awPiXeAMlaNvSQXQGp7S7MrL7KNIGG+BzMEkG0O9wDJi8AS+ucXZU6+p3IgvMcPuyUiHvyjmxvh/Th6Q+dN2zoATM3Z5ExsWlezc8H2pz9HYNVXKURAgivcDgV3KoWdFWhcBes9t/SG2vDKLMZ2F8nOaYZQPFT/fpApP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712626216; c=relaxed/simple;
	bh=eZIicArIGwmij39nN1PtC/8Dhsj6OoZ2hjbeCWCcUTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvqONVQeLABQ3+/IBpIqYMsAZn1+iuZM0UAeuGJL+XVm76dl+xymmKlXH0DtnRyU3pRRKOVWVxJlhpImYEWBMTRObL5KMoL36YLLm39evmt85AKMSQNkUzQ0b3VxryR69V50OZCVK3nsomdSp6T7CiCxPoaUrG6dy+v9UHYJjz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIq9TfJU; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIq9TfJU"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5aa25e99414so1374041eaf.3
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 18:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712626214; x=1713231014; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aCHvLtgAgUv9iB9FRl7Xq7qrRYhSvpHePuRVir1oZ0A=;
        b=JIq9TfJUlkzhYCIG0L1QrXgfH2bh56zzsAfyUkjsnLqQHrmgPsRl9MPf5NNIG86Rz1
         IW5hC0c70XoMNIXFxK60RcR0gw1wSHczz6tMK0qiM/inY9/AJhxK+49JMgoO+rP21xF+
         WhVUVI59aYyb0vrMg2OYFljthPqcahhgFDu8UWsTMRpCEsPwUdAvPyH5LGtuKrHVLAcJ
         jZaprONbtBk5fu8wv2Jvm/a4xKOV2x8vRlM/ZoEklMWyKkQQO8svcelKEtlSxAH3/Mi4
         KhGyj8/T2XOOUGNbbNhl+nQJH4Crsw8urLHGDS/nv9pYp/bDrqaobmyb3lzAOeWDqTwh
         Rfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712626214; x=1713231014;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCHvLtgAgUv9iB9FRl7Xq7qrRYhSvpHePuRVir1oZ0A=;
        b=Gwh79fTLHgWYxi7gbLJ0W9O/8OEkgmKQbSFQk6VkPp+Rz25+M6quGoCYgmKin1Eu70
         suviQJaBou6UMl/Bag7bGeHkOzjqYu4nM7bkD5Vq6FZlt5vzLstj28koLBWl81DyrqG6
         PYYF/7HlaVvovn78mtERY+cXAbRzpj5erHSiiRgjEftd2OWPRmMs30TIC6AnrtZKjU/f
         fr5U2TTlVgoIw25Ou8ckd4t9dP++3IdnMpy/qo4Nsdz8kMyd00zN728xo6NlitANg/wR
         zAhMNomOVTBCqIdJemVef3z/HZ+utDyrEs7zOhyYjjtSGfe96WxyOmoSsytB4mXCJEsF
         yveA==
X-Gm-Message-State: AOJu0Yw+oWjgw6orqIXquKcIfamVVCEEAwD2vygpPho9n8gu7IYoVd0F
	XpRcnAJxT0Jc412LCG+21bhDpBSlhtZ39M6dJ/+GQWRlGGe305f+
X-Google-Smtp-Source: AGHT+IGRAGGnECKwPzvIwN8KKq73jkbXlPLKJ7D0c8+d4lFpjokfw7gC0ACsiI4sGTlETvw1wd/3Aw==
X-Received: by 2002:a05:6870:392b:b0:22e:a12c:ab4c with SMTP id b43-20020a056870392b00b0022ea12cab4cmr10245543oap.57.1712626213765;
        Mon, 08 Apr 2024 18:30:13 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id s19-20020a0568301e1300b006ea228af12asm208469otr.11.2024.04.08.18.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 18:30:13 -0700 (PDT)
Date: Mon, 8 Apr 2024 20:29:14 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 10/10] reftable/block: avoid copying block iterators
 on seek
Message-ID: <vab3mzg3meohikmfl5v57uxj6w7w2odrx7cvhmoto7am2bl2yt@6l4salel4ko5>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Han-Wen Nienhuys <hanwenn@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
References: <cover.1711519925.git.ps@pks.im>
 <cover.1712578376.git.ps@pks.im>
 <cc5ff0d5988691043206f9e912f5ffa1bcfee94e.1712578376.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc5ff0d5988691043206f9e912f5ffa1bcfee94e.1712578376.git.ps@pks.im>

On 24/04/08 02:17PM, Patrick Steinhardt wrote:
> When seeking a reftable record in a block we need to position the
> iterator _before_ the sought-after record so that the next call to
> `block_iter_next()` would yield that record. To achieve this, the loop
> that performs the linear needs to restore the previous position once it

Did we mean to say "linear seek" here? Otherwise this looks good to me.

-Justin

> has found the record.
> 
> This is done by advancing two `block_iter`s: one to check whether the
> next record is our sought-after record, and one that we update after
> every iteration. This of course involves quite a lot of copying and also
> leads to needless memory allocations.
> 
> Refactor the code to get rid of the `next` iterator and the copying this
> involves. Instead, we can restore the previous offset such that the call
> to `next` will return the correct record.
> 
> Next to being simpler conceptually this also leads to a nice speedup.
> The following benchmark parser 10k refs out of 100k existing refs via
> `git-rev-list --no-walk`:
> 
>   Benchmark 1: rev-list: print many refs (HEAD~)
>     Time (mean ± σ):     170.2 ms ±   1.7 ms    [User: 86.1 ms, System: 83.6 ms]
>     Range (min … max):   166.4 ms … 180.3 ms    500 runs
> 
>   Benchmark 2: rev-list: print many refs (HEAD~)
>     Time (mean ± σ):     161.6 ms ±   1.6 ms    [User: 78.1 ms, System: 83.0 ms]
>     Range (min … max):   158.4 ms … 172.3 ms    500 runs
> 
>   Summary
>     rev-list: print many refs (HEAD) ran
>       1.05 ± 0.01 times faster than rev-list: print many refs (HEAD~)
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
...
