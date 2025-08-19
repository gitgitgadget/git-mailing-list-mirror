Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD14E56A
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 03:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755572458; cv=none; b=jeI0Ai5PS3NZY01fWFLepd7Wgrmhy2/HwlHaqfw09Xk6FJkJ4I8Dit9MiyY1WoYtCt4lW1JQy6TAAJ9LdulognteN7HOZ4K5THaa1BffDKKc1sNsoQXQndUCIS4gudUW4Cgw9cvEVfHHK7T50jdpZ0VC6EZTaxvhD+Fj8BPIEoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755572458; c=relaxed/simple;
	bh=TGn52zCK6TlvGv9hdwYr6QJjmVehE/PI8FP7WN6mEhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDMM7F7ctrZvvbynIn+JC0kl+CzoEXDXjeCVDpIOnAIL9HDL1bbLcoKO9Yns1Ab9mC1u2hMcIGNyGnLBLi/245mCehvfO5EZwwdnLcRdlLENkHApwbOM+TFpPlmPzb1n/fcHU0/cDPFjRMcfziHZrLZYLnuNf5HWppV29L3YxO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGxYYH3W; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGxYYH3W"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6197efa570eso5485056a12.1
        for <git@vger.kernel.org>; Mon, 18 Aug 2025 20:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755572455; x=1756177255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vrofzzrsvt6RYbvBYtutwOFQz4CEFX7ZegD5Dsw+Tb4=;
        b=CGxYYH3WUjddqtN+Q7jAUwdQUPvAkt1RjOPQ45cK0b5Lq8YTBDUgxmT3PGZooVRWgj
         /Lzj5TDNVbdj9tzrFzB/OfBqizTE53mjzQdTr+5F1dHsMdi0vS4aPvr2Qk1SObHu3xab
         SNfwR51CE46PSI3QS8WbISrUv3FdDMHI8kzQGbtY/n3I9FkNn1X/UonRDrBOViT9z1RI
         2/EQHJZuJjJyItXVDS5IFGiLA55Lz0Pp/aMUjJ+FUAjxH6qH4AZhMYvMWLTDvtw08MrI
         WVYf8p8BHybgwPc5RUKJ7F9m6OXfrsCYVkfsPBOSUFZefDTssCOSDbFi80jws6yq2oD2
         pizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755572455; x=1756177255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vrofzzrsvt6RYbvBYtutwOFQz4CEFX7ZegD5Dsw+Tb4=;
        b=auaxnPV88hkEOaw6PavgKzXDdQ/Y6q0P6JrmNy4Yx06VCtvujZqD+7WHNffh/xb9W0
         2f8fTVo35fz4ILkwjgahxNl3e8HcLQX0kfCnnkXIvPbPITHgdRClNOqDyKxe9jo/HGLL
         eEfleGAMXHTWxFexUPAQ1ea+QfXQacl4vhj6tN+0UHm0oRum9S28R0v7tDmZY8NSB7MA
         rZeXgN6mSY+l8gtLa2ntnhvArvATi6nVv/CYRFvPlmaYXT+10Rt/usfqmRIgVxzK7RmT
         p2m5S552Xwv4RG9MxCk/Kel1l8z4wQDo25mW/P6ITLtNKY8LkwOiU/Yd+oCY3itgvEXb
         rkMQ==
X-Gm-Message-State: AOJu0Yzz9OAPwuyumNrkPTGmjJN6MyiF1n8LFExifs3bw+INRAzYFBkN
	fTJ10G8sgysQZRKuj9dw346SL5ND7msqz44khYLlmI2QBvSW/VILHJs0/M61xXLE12gycU1Wlxy
	6D0HLreXK1wN6cFOxruzcttM/3Ju7N82GFZKK6rM=
X-Gm-Gg: ASbGncs3DRA4EWICdJoYrttbUCivfQXbRcyoQQ9QwXCePJxdxwknjEow0AIpnzL960s
	Oat4wFNnYPZm6tEB+qRmFhd27lTjLT5iXCfaB7G5k6D9jugbCUdBId2xXai+oxzdu4dV6q+HnQx
	RfOOFbASb80fdgZRyiL8aHX5KdnY1DGBW9d8DXKwYFZ1bTGCAMfsKusG1A3b/tJ9S7rLNSBdhZJ
	pIZ8gn4
X-Google-Smtp-Source: AGHT+IHf60cNBycMwpf47XQRaG3p3zlj9uLUFJiOPlcnAxJg+SrFbnt9n82zFqxiYrPJB9N1xCULGroOB5LXmdAGvZ4=
X-Received: by 2002:a05:6402:3550:b0:615:aec5:b5bc with SMTP id
 4fb4d7f45d1cf-61a7e48656fmr684710a12.0.1755572455266; Mon, 18 Aug 2025
 20:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO49JtHLs0yCAmNX-2VO=0mC-u4JKPWw86Lg+xe1pV6Dr6YZWw@mail.gmail.com>
 <xmqqcy8sgjs2.fsf@gitster.g>
In-Reply-To: <xmqqcy8sgjs2.fsf@gitster.g>
From: Mark Waite <mark.earl.waite@gmail.com>
Date: Mon, 18 Aug 2025 21:00:44 -0600
X-Gm-Features: Ac12FXyDSjjnWPCSKYm6mtXly34OHLUk6P-xfT4vmyCsLVyWwMv9RUy5BOqX1EU
Message-ID: <CAO49JtH0GaLVJ+WY_E1JQ863ad2JeNwhzvOd3Gz3cZiJFUkbDg@mail.gmail.com>
Subject: Re: Jenkins still uses 'git whatchanged'
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 7:52=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Thanks for letting us know.
>
> Please note that "--i-still-use-this" is merely for you to buy some
> time while you update your ware to rewrite your use of whatchanged
> with something else (probably "git log --raw" with some other
> options).  When you update to Git 3.0, whose release date is not yet
> even known, whatchanged will no longer be available with or without
> that option.

Thanks very much.  The implementation is looking good.  I expect the
new release of the git client plugin will be ready this week.  The code
changes were simple and the test results are all positive.

Mark Waite
