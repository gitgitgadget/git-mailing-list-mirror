Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96482176AAB
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720803252; cv=none; b=eD27i2KWMFto9XGllYPgs16LYF8718icFfaiWI8zy9wmuxjdc1/x6r7L1+cVeUeddA0OsiQiSK6y7EVdE3JnOJA/fI6gXQVw87EKN2HUp8Ms4t1ayEQP3b4MYOTi+NyUGtO/2XMv5M9y8n17wIjq5VG3LQWA4c8qNzVp1YGlthk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720803252; c=relaxed/simple;
	bh=CUIvv4PygKhEvjbN9L9WKJ0UQVALUvZBm+82Y23+awc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQoYEcSiyRGydElqcBnBWuaCwBsqPZSvKqHe+UnyWwrCEdI8FvtO43KVgQ3nKDzi9F/pn8L+9Ne26j8351zjO7aTlUrLfBlFjeXSF+45fYnOOLmSN5Gjn1hUGGB8VC0bRXOfGSBee7VQxtrMIpU1XLYUvGcGEVkT0dAuaShB60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79f18509e76so136145385a.1
        for <git@vger.kernel.org>; Fri, 12 Jul 2024 09:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720803249; x=1721408049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlwArA8VvvNnND/QBRlFj2EvxcjfE2/7EP5S3vwekdE=;
        b=xEeT0PDqCZJ6yvAuF4ZN4tf8i2SDYVEcVMqVfJ2xu/tPBAlMx10FN+9NMsUBBnVRRY
         qJeidy0wtFwvChIm5zOSu/NN4BEK1Rbzkj28KAI4pLStd9rhJBBGwo42sxc3XJGgDk+1
         hB5EMcwH8O6s1lGxVP2melmm0oGTJLkgEEXEIPqCOBbZ0U8TnUPMGezBEereQGR7zAdH
         Iz0PvgQtLB/SXyu7yjin+v8JkUeYeNc84hIB71QyKLh10xJDARfbRoFW4bduB3ImZ3Iy
         /i5xIFaH2ILaOnPo3K5fIHEZzqBg2zyKH72C/BDBo+1bx0APwucXfEzkNEgBcuyzkK7j
         LQNQ==
X-Gm-Message-State: AOJu0Yy7mdUVhKW5dla/jMR9VuA6X4nVy/r345V6bE7gBjeaKBYC1x7J
	rfLpaJeUyrjeIXr1XuEEalAvpuO+WfOHfRfHNosWaqTXYvvsWYXiZbRvZIolxHeeIj6Mz5+udhk
	t5tvDy/C2x7WEmGjUy827859VWZw=
X-Google-Smtp-Source: AGHT+IHdW9haZUPGVwpAd6077Y7OtOnmJtgVUaXG/4lKud3ZgpCcjlWR9NpnNJNfxa7dQHyvRVyVYpRxk8Hh4waxRlE=
X-Received: by 2002:ad4:5f06:0:b0:6b5:7fb9:747 with SMTP id
 6a1803df08f44-6b61bc7ef9fmr139163276d6.2.1720803249504; Fri, 12 Jul 2024
 09:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712142326.266533-1-abhijeet.nkt@gmail.com>
In-Reply-To: <20240712142326.266533-1-abhijeet.nkt@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 12 Jul 2024 12:53:58 -0400
Message-ID: <CAPig+cT+X2k4RfTb_mjErQ6reXk44SzbTaXpzQdgLJ+TugtiXQ@mail.gmail.com>
Subject: Re: [PATCH] show-index: fix uninitialized hash function
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 10:24=E2=80=AFAM Abhijeet Sonar <abhijeet.nkt@gmail=
.com> wrote:
> As stated in the docs, show-index should use SHA1 as the default hash alg=
orithm
> when run outsize of a repository.  However, 'the_hash_algo' is currently =
left
> uninitialized if we are not in a repository and no explicit hash funciton=
 is

s/funciton/function/

> specified, causing a crash.  Fix it by falling back to SHA1 when it is fo=
und
> uninitialized.
>
> Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
