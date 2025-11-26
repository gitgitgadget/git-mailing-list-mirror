Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976E31D390
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764155458; cv=none; b=YYNy6T6aHsm71EhY6I0P89yuYjXcVqlgWefnS+SvR39kb06fY0d9+iW/pb17lBpEDNDCXDKDC73zZsDvfh9KuAi//Pjjcf1d6ZNR+BDeiM4qS1icApNJt1E0yp6Qe5CwmHbJRiZth9/7ikSX6QK4rSvY4Kf9uXFgZdjB6ZGYC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764155458; c=relaxed/simple;
	bh=hbVCCo9XRKEUlAciB0g6p3ryQMFxBOjsn4VrSoPWe0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CjRA+gxWPXbH8H92VCCCXV2Fz7mpesnsFrJeI+y5dgrWOgZatITlPDPBCDVn0h7UHbgkWb66dNVDo9hlatdHIXf/lwIGd+cjgNwRrlnMEL1oLy4XwxfabvrJnpC3x23Y1iUnEDDKCsP+yFRlCu26DyGluVFkNLb8FYZE+2VkpSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jY0Qa4ql; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jY0Qa4ql"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so5415240f8f.2
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 03:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764155455; x=1764760255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wyVjR2Qrq41uOBaHwDpzVCe3kQRfWR4EORBbI2bP5a8=;
        b=jY0Qa4qlVrBJLFLzkj8k7tV+fwCzaFWj0CBHyUD+44yYUG9EboYoD9fyc558L7DIAR
         Tehy6XEUr+qvsDB3G1A9JypT0K0/ldDxa4iHuAfxzbLTp3OTwlnmc9/bucQxlQ8g6m+Y
         J3cm1/gb5VNsA6m57RfJFVWQstRQhqR/xWixFlaTBUX3zPxPyC6fy1+H9uyvfRQo+mR5
         Y0IggyAeoCZ+7wJ4ebuTNA/Spy7lEDF/W4UlXmyGKqABsaRtRpWMH031H0pbLAhq6uXY
         a5HnTnclD8+BWJpQDGlah9ZB6B7J6WvjugXbQhnnA2P4d7ibVFYyNKpttvHSN3XLxTk+
         3frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764155455; x=1764760255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyVjR2Qrq41uOBaHwDpzVCe3kQRfWR4EORBbI2bP5a8=;
        b=SLarS+2kME35Pn1cw635VoB7UXGhK1OnmVtbC+peFXgD7aHL7LxZA35pC1vhvSc8E+
         hecHBRsVBDasHnnYD/bvhPDXUhG1+pkJk9r1rPCNLw78Hdhxeb7UcCzRloFv5vWatNIx
         GHrOCMJAEgwHxtEzpAmQK1Y/BUuWp/96SIX0K5zTkRBmRIX3Omf2d/zj9oJB6UscA0AB
         5K2SUqZ3AkXUl6XafXnlwTVy7pB2eYDJ4L+PACYKG1pA8TsKLMiNEicpsidYKe9NaOF5
         b5nVibvltH40rgZiloqAYSqwuG/6ox1rd4/sCUWvzbFus7ADrF2NjvVAg2JjXkwFosAM
         4Ssg==
X-Forwarded-Encrypted: i=1; AJvYcCUvntzJerk8OKaCZGeCj48VCs33cmCNKT8uRZLHnWX24hhQXcb1AWk/uvJuc7ktWbdM3jI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQmV18QpR9sak+xPaBU7P/61MPv01qEvauyd+BRd5Aj/+KWCj6
	W91R7c8DGpKigdJHsiIGjy17njYSQTuVUzHSYO/a3925/Mc5GgAPuGzOMVdztA==
X-Gm-Gg: ASbGncv+XGcENejEprKy5Cv1IYPXW5s+eEMzJt5gJlDgJwHdD2p+pUaYWWZCx3XjH3X
	mR4Ua59AQjdOrqJ5Vchyr96wxviWA/nGG+sJydtKAXlp66TcNEd0Kv78dKjBOTtozPDMSSRw/82
	zN97KzaDNqOzDUoXV0NxKLVd/y6uDxACbl4cvwo2oevynhcWKLsV3OnF7pFSfBcywYkcRtAlEh+
	Vf3kJ7xue88Vd77223aRhRFv68MYTBfo93LsmcBWr7b8R8ShuksvxIRiwpX5hvPKthjcwocl/8C
	cyvj49yB4O5Joe+eXTjabIK4/u9rb01N+0FRvXv0xZNdU6XVMm3kNOGUKcr6Ed2gvn8EdU7QwhP
	JmxXayvE7TI3dLBkCJ94m5e5ptDIZvfTiNuFHqKk6NLJiqOGaoUXWr2ZCPlmY8SeQlMLoiUHPn4
	HZllIcfIJMtoxt5Li/svSGH/0aLEauapCVKYD1IRqy2ePDAtKL0Fkt4p8RpayYvq0=
X-Google-Smtp-Source: AGHT+IECsTniNrF2k1ELZWGyR6Hgj4sInHRtEvFR7ohlM1odABN8yly1S+Pq5coEU5vePUPVwX4D6Q==
X-Received: by 2002:a05:6000:310d:b0:42b:2e39:6d58 with SMTP id ffacd0b85a97d-42cc1d51a80mr19071457f8f.51.1764155454962;
        Wed, 26 Nov 2025 03:10:54 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9022sm39953720f8f.36.2025.11.26.03.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 03:10:54 -0800 (PST)
Message-ID: <d563b68b-e01d-4b18-bd84-86f36e61a70d@gmail.com>
Date: Wed, 26 Nov 2025 11:10:50 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] replay: add --revert option to reverse commit changes
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, phillip.wood@dunelm.org.uk, karthik.188@gmail.com,
 code@khaugsbakk.name, rybak.a.v@gmail.com, jltobler@gmail.com,
 toon@iotcl.com, johncai86@gmail.com, johannes.schindelin@gmx.de
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251125170056.34489-2-siddharthasthana31@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20251125170056.34489-2-siddharthasthana31@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Siddharth

On 25/11/2025 17:00, Siddharth Asthana wrote:
> 
> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
> index dcb26e8a8e..ad7dc08622 100644
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -54,6 +54,18 @@ which uses the target only as a starting point without updating it.
> [...]
> +To revert a range of commits:
> +
> +------------
> +$ git replay --revert --onto main feature~3..feature
> +------------
> +
> +This creates new commits on top of 'main' that reverse the changes introduced
> +by the last three commits on 'feature'. The 'feature' branch is updated to
> +point at the last of these revert commits. The 'main' branch is not updated
> +in this case.

I'm struggling to understand when I'd want to do this. Why would I want 
to update 'feature' to point to the reverted version of its last tree 
commits rebased onto 'main'? In order to understand I ran the first 
tests case which does

	git replay --onto topic1 --revert topic1..topic2

after fixing it by adding --ref-action=print the resulting commit log 
looks like

commit d337fab78e90008835f74e890039b464a0308cbe
Author: author@name <bogus@email@address>
Date:   Thu Apr 7 15:30:13 2005 -0700

     Revert "E
     "

     This reverts commit bceb3acd81ddd36ba0da391fffa48949a1337276.

commit 47f0cc1c1f1911c0047a4d79d79f7c19c6c7151a
Author: author@name <bogus@email@address>
Date:   Thu Apr 7 15:30:13 2005 -0700

     Revert "D
     "

     This reverts commit d953cf2dcc1da8b51934e43fd83dac72d0e267c7.


The commits are empty because the original they are reverting each 
create a new file which is then present in the base revision but not in 
either of the merge heads when we revert. This suggests to me that it is 
not a very realistic test and I'm still scratching my head to see where 
"git replay --onto <commit> --revert" is useful.

If '--revert' does not make sense with '--onto' then perhaps it should 
be a new mode that takes a ref and acts like '--advance' but reverts the 
commits rather than cherry-picking them. When reverting a range of 
commits it would reduce the likelihood of conflicts to revert then in 
reverse order so we should either recommend passing '--reverse' or make 
that the default when '--revert' is given.

As you can see in the log output above the new function to format the 
revert subject lines is buggy. If you had used test_commit_message() to 
check the commit message, rather than just grepping for ^Revert the 
tests would have picked that up.

Thanks

Phillip

