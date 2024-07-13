Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1000D130486
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720880199; cv=none; b=gu3LfHq4vLGEL+bo73dhD9bjotRSLwbpBMaCqo3JIATSOj7hc5FuQ8avFKaQjr+8JIKG7SAd0hQmDWGWel78VudeyIbHQl98HgO/Xk30pHqNnpTtpdzbEsJaWCp6yTxHeOC1kvjcWpcNllMwEiiy9oxm6zHjrAX3u91cbaGHBB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720880199; c=relaxed/simple;
	bh=qOaOa+7R0xAYHhymzDvBTpPFuYq4EoMXZjdOGgVOtvY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9qIKMb7x2z9Q6JETLT6zzMrgw675geuCDz2qn0S2EnsbfbCQYUrv8Gho0YXADus7xJYKHwtwWVLCf3D22c1gk/kclcUzHUrFiEbWZJGY3JgsAsEDTKtJ81DFZTiYN063BsVTOGcZOjfwLYPSQovBRxC65XDuVhKQuS/dg0l2dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZetQ3eVZ; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZetQ3eVZ"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-25e150603a6so1455988fac.3
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 07:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720880197; x=1721484997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2+Q2vr9+2f+ZmZXExjqf/ZTKVeGkwIXDsmc/yUrCl0k=;
        b=ZetQ3eVZg1+pkWdzYdS2WqGyrvQavmihkm3GFNGcuRIWpYQ581lfcI7ZlU+L/0K2B9
         yartMRNOyPMMxMDOevWq8vIxTM9aqrNrG7th2L1xfEtUdOGtxY+9OTiyxacgAImB2U7G
         mWdkrUUu5yJN3Sb6TvGnD+LAC1Y5XAFsnvLKblNWoXMhw7g7YMjAHLvibFPVHD23Vmlt
         e4bVD4j9XNOblcQspme3a4cP5hfrwc93N6yfXi/IF2DgxxdnrH1Pd9wVo/jU4lpMlldZ
         8icNnmQopvVuBYk5g/bknKaFX6ke5QP7VaiAZovvx18GmYUFBO/bp+uOJh+0C2TUNUPj
         8zVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720880197; x=1721484997;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+Q2vr9+2f+ZmZXExjqf/ZTKVeGkwIXDsmc/yUrCl0k=;
        b=RC2u4Ut0ZdlnWjWpXoDrh8R3GO8DZC+yvroDDOEAdf6759t0CN0DTF5XZ05DB8C9TY
         re9JrBdLSWcee9e+iJNu9JD68d7Tn5xvfgxCU71AbzFvAJ3ZhUMryZsrTcBineyHoqsh
         ZdjU3XKaXUwAO0re0rId/b0q6kf5kCtVeQKLqCjbUjaWnZccPdibFHxhFVPFif9gHr4J
         b+Fkxt4mO57JmkjKzlYJD3Soo6uCFl0JYbinPa0/kFRyKlVC/YGTTqsdEKYuGZ6HA2wn
         xrShGEGwg72f8kosxRiWw7sj+vfaFicu9sqgbeirdlaSedGxPl1crT+TXGSAFDksiE3G
         4UVQ==
X-Gm-Message-State: AOJu0YxIu2OTe5JPbkjVkN0TCZV/7r5ZApZlr/bqTNnUo1T4Q09sVDZA
	MbekxvZo8roS71mLJXhOQrvPYL2UsFNYmBos/cjbBA0QLWc1cnO6SBsiMT1r8/3EQOpWqTvSXT/
	h65zntJ8uoE9IV8nTw5jiKxhwBDM=
X-Google-Smtp-Source: AGHT+IEeciVfOzJWuCkMK+GeLPt1vxYqB8shPaY0r/9bQBbYiDDq2VWtu2L+QclvyoTmjLAlM8IaW2YCQgIKxV+aos4=
X-Received: by 2002:a05:6871:3b26:b0:25e:b732:a913 with SMTP id
 586e51a60fabf-25eb732a937mr7817578fac.0.1720880196878; Sat, 13 Jul 2024
 07:16:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 13 Jul 2024 10:16:35 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <57402963-a95a-4bd8-9eb1-1764e0611bb5@gmail.com>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-6-karthik.188@gmail.com> <xmqqle2bj0dl.fsf@gitster.g>
 <CAOLa=ZSb_S7X7pdFPp0r5bfNc3o95mGe5pU+rC1T_yM89NRqCw@mail.gmail.com>
 <12830e1d-598d-4e7d-abd6-3349800e277a@gmail.com> <CAOLa=ZSrVOBkziX+z3g1RqudiLp=SN4gW=OL5Ky++KukPF=QXA@mail.gmail.com>
 <57402963-a95a-4bd8-9eb1-1764e0611bb5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 13 Jul 2024 10:16:35 -0400
Message-ID: <CAOLa=ZSiJArgDr6oDTbHN2vaF1mjUjrKbKbw4aDOjMf-bMUFyA@mail.gmail.com>
Subject: Re: [PATCH 5/8] clang-format: avoid braces on simple single-statement bodies
To: phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk, 
	Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="000000000000d620cc061d21a48d"

--000000000000d620cc061d21a48d
Content-Type: text/plain; charset="UTF-8"

phillip.wood123@gmail.com writes:

> On 13/07/2024 13:30, Karthik Nayak wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>  >
>>> I'm a bit confused - what does "allowed to fail" mean? We don't have any
>>> automated requirements on the CI passing. We don't want to train
>>> contributors to routinely ignore CI failures but if they don't get a
>>> notification that this job failed how do they know to correct the
>>> formatting?
>>>
>>
>> Well, it mostly means that the CI would show the style-check job as
>> failed, but the overall pipeline would be successful.
>
> Ah, I didn't know that was a possibility - do users still get emails
> about the failed job?
>

I know in GitLab, users _wouldn't_ get an email. This would be a nice
intermediate step, but I think it is still okay.

>> We want to ideally
>> fail the pipeline too, but I'm being careful to not disrupt things
>> suddenly and I think once we see what false positive rate is and once we
>> fine tune this settings maybe over the next release or so, we can
>> enforce this.
>
> Starting gently to get some experience with the auto formatter sounds
> sensible. Thanks for working on this, I really hope that once we've got
> more experience with clang format we can figure out how to enable it
> unconditionally.
>
> Best Wishes
>
> Phillip

Just to clarify, enabling an auto-formatter would always be left to the
user. From the project's perspective, the goal would be to have checks
to notify us (us as in the Git project) if a particular patch series
fails to comply to our standards.

This is done by enforcing the CI rule _eventually_. Users can also
benefit from this if they use the CI for development purposes. One good
example being users of GitGitGadget, where they would be notified of
failures in the CI. Another example is contributions coming from GitLab,
where our team uses the CI before sending patches upstream.

Since the Git project already comes with a '.clang-format', users can
already enable auto-formatting on their end. I know the clangd LSP
already supports this. ;)

Thanks
Karthik

--000000000000d620cc061d21a48d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bea9710d8ebea59c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hU2pFSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mdytzQy80dDUveHlqang2d1h0K1FIcW5pd25qR1RkcgpaTnp5VWJvMGJi
YjVMS2I0MFBudm5DZDVhOGNsd2FtNGR2eGRUbW04YTRiWEp3OUlxcUIzZXlZTnFOaDdURWRUCms5
V1N6bHB1Yk14TnRBcmo1azM1MWRzQ1B3d2cvbEgzdDZIeDRCSUpyQllXK3dBdTJDTUx5SXZoZmdO
ay9pQmUKUFNtRUlzcnc5MWdjbFBuSkJDd2ZRV0VwbzljNm1lUDB3RHVrd3ZIdTk1WXFTbmxLREFo
OXR6TkE5Z1VMZklBYgpZN3ZWYXU2YTRIWVc2ejQyNjhuTDJMZnRXMlhpa1lSTU9WN1JCZWdJMTNP
NWs2eVEzdVlGa2U3c25obk5ZeUpFCnVhOUhJUk5aMUFyWDR3QURJV083dVpQclhHUTl2azgzZ00w
ZnpqUlc3b3pDNUlnS2kzRG5SUjBTNURiUzBEcG0KY2xIYWNOOXJRQTFqSWVMdlVvK3pTUVlBb0Jz
ZmRpcnZRdldsMTlHUEtoUFBickZ4WUYxamVLc3FqeStJQWpCawpDVStwWTgyUG4zMEpXc1NJZVFR
L1FhTEQ1cm93ZUdtaVVzMVVQcTFVcjB0bmtxeGlQZW5IMFlSdTVRVk9jMHo2Ci80NW9mUEJaTVVa
QklTalBWZEd5R0pLMXp1TllvY2V2Z3pFS2dwaz0KPXhxQ0MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d620cc061d21a48d--
