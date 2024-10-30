Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE6B2141B9
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305175; cv=none; b=kj2R27npOQ3DnRki9Nlm5ZzbhYqzwLljuxJsc7r7Q59l+Y6BDVctBMgPhTA7qvPFNWSuqYr5rZD1ZcRqdWeKy5LDVxVk+MLpzbmHG3jbnAv3A8JnuxTxGVk3anNQYWH0QADATVsauVpSm5K8UicHXfgE+r2p8r69xpXGTN7xK2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305175; c=relaxed/simple;
	bh=OeaaqtTARh9z8jdhv8dOccEJltXXosOwTJsVtQBdDtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hI+sbQahuY9tPBb15CQ4XPqUxsWWctYQMAw/9DpWROC7gF8GJ3GQw60CfJsc49wHHuAvSQS7VKRNhHQIqL0sAuPnE0oiWWx/j5tugLYSp9g/o+IJoeIFz3GUgw1nyjz6JQV4pm0ly/5zegVGmAib71jChTmSGH33ZJNyDqAv2Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nbus5UK8; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nbus5UK8"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-50d4a6ef70aso14769e0c.3
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 09:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730305172; x=1730909972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKaP1KroiSxQiJowumXXtCT5Z8Do18/tdWyw+82Ki7c=;
        b=Nbus5UK82ZPE5ASWrrspfzARKZgZSKf8sVJsTp0RkLWNWk6gM0Vz+WFskDj4pepRf8
         /lETfX9OeKlp5c/DvKViLAf5ierbAr/Uy5CbtVnKmCF1ko8pR1SEtrlDPoPUYs6TIG5v
         RSeLwucQ4iYGeI0hfysGOkG3zTy46HUyAsrvOYdo8Rn003N7e1lM2+x66s4wIBcczvDT
         cwXrA4ylZcKsu+irozhfESIsw9UvEcyn9O9VNukRxuudAvjHn0dI7+3n5N9R0Zg43VOZ
         KEgWo+F1hVG7xb5zBMCeN3gRfMME+zCwPI1IuQXHwCVC3s/9eOWIoQ4dSJuo85rCxd7X
         7Xzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730305172; x=1730909972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKaP1KroiSxQiJowumXXtCT5Z8Do18/tdWyw+82Ki7c=;
        b=HAwIZuFgFlOwnfkr2hGHlmQ82fc2FNp1qJegOWX25vpnlzgn2wl9+UTFmK3q0ZtRHk
         3JAWvLckWCj8B+wz0iVGP2dR+Eoec9dDc26XIwHG3BfW+jtYY4G8SwZhxzc4lR+0DOGS
         zXlwb+4YbxxXbgDirgte8oARakofn1651UdKyAjc1hCueGOahl4myEaSTCh4JiVnBVSl
         3dAN0QqvlGraJWj7WpUpwCKdFPp13MpWKi5yxtRo6OWXspS4EkH5ul/11zyw9p5NovyD
         97FtuMAUezV5kvsZGLIxdAAkPslxwf5x/AAtHLT+IVBhMSWsqwi7dQkWJVfWtPHOKRtH
         SIyw==
X-Forwarded-Encrypted: i=1; AJvYcCUq/7bnyZQ6bWMBg7aS6zCmGp/uJYMKrMtfAFkpS2w+zwAx1FQ9Z7CFCOESW7x8tJyhHH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK9bCp0yII7sovYDfHI28aqrJlCGdZKnMA6dMsrrcwcs5QtBBj
	vl6Y4FLI1Kwvv/DMmPNWObYKngOUPs6lXiWRgbQX7pyEyjydg9pw3QlLgm2py2uzaSprNnlJ/wy
	1iDyX0AuT9cwpX3xG6xdSYeIQasH1+oQj
X-Google-Smtp-Source: AGHT+IEEqlY1kll/JVlbp6vWdbM/mQuQ7wt1h8gNM6/vh115EJAmO0b6nbbkaDl9OB1OriIC0dHuFqJSVIN1Qeq9G0k=
X-Received: by 2002:a05:6122:c94:b0:50c:a762:8f95 with SMTP id
 71dfb90a1353d-510150fed55mr13841363e0c.10.1730305171840; Wed, 30 Oct 2024
 09:19:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com> <5d58c150efbed1a10e90dba10e18f8641d11a70f.1729259580.git.gitgitgadget@gmail.com>
 <ZxZHH-oHE7g09xIR@pks.im> <e4a70501-af2d-450a-a232-4c7952196a74@gmail.com>
In-Reply-To: <e4a70501-af2d-450a-a232-4c7952196a74@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 30 Oct 2024 16:19:20 +0000
Message-ID: <CAPSxiM-X3gk4tsVSJ_dFP2EGWX_dvFnqRp0rTYvhPxqYsUeijg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] merge: replace atoi() with strtol_i() for marker
 size validation
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 3:20=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Patrick and Usman
>
> On 21/10/2024 13:20, Patrick Steinhardt wrote:
> > On Fri, Oct 18, 2024 at 01:52:59PM +0000, Usman Akinyemi via GitGitGadg=
et wrote:
> >> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > These are a bit curious. As your test demonstrates, we retrieve the
> > values from the "gitattributes" file. And given that the file tends to =
be
> > checked into the repository, you can now basically break somebody elses
> > commands by having an invalid value in there.
> >
> > That makes me think that we likely shouldn't die here. We may print a
> > warning, but other than that we should likely continue and use the
> > DEFAULT_CONFLICT_MARKER_SIZE.
>
> I think using a warning here is a good idea, we should probably fix the
> whitespace attributes to do the same. If you have
>
>      * whitespace=3Dindent-with-non-tab,tab-in-indent
>
> in .gitattributes then "git diff" dies with
>
>      fatal: cannot enforce both tab-in-indent and indent-with-non-tab
>
> Anyway that's not really related to this series but I thought I'd add it
> as #leftoverbits for future reference.
>
> Thanks for working on this Usman, what is queued in next looks good to me=
.
Hi Philip,

I just checked it. I will be glad to work on it.

I also noticed that the test used for testing used a different
approach(test_must_fail) compared to the one I wrote which used
test_grep. Should I change the test also ?

Also, when should someone redirect a warning/failure into a file then
use test_grep or just used test_must_fail ?

Thank you
Usman Akinyemi
>
> Best Wishes
>
> Phillip
>
>
> > Patrick
> >
>
