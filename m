Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725F61D04A4
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706882; cv=none; b=H+KMkAWVqQ9eQMdEM8cR0eW6MsPkL/rks5CQUBdXns7rA7c+HlxaHEHodA6nBxJH5e/ONGjMiHhWr0VzqK23/wHI+IMungG5ckmHQMoYXtW6JSWYOxXvel+QmomlXarhtzDBc39oH4YC3M67kwyzLo4SUeiwy09vhjPKOwNwUdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706882; c=relaxed/simple;
	bh=Yf1CxdOtOcmxmY64nnY0UFR8RU6Uc0U6G5uC7ZaY9y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LM8Ja9nU7C91J4yOJF7KhIDwJoJN0auH8yn2gAGbL2m7KyVbOBxeES/Y0XqJg+rMnpjUqBuguKWrZJI5kbV/u+Y3HHlHHQRrlzNZW78l+6LZOzM7LdwyqP0qVLSbN4kCd9eJidLh6nfwvjKLXxRkuTNom+jyiGBSWFutGrrMKF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=T6bXOqzr; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="T6bXOqzr"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e2e41bd08bso244637b3.2
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 11:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729706879; x=1730311679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kATzDkxmkYVxO1o8Q7c0NUcnQZx/ICJwTgITx6SNcAQ=;
        b=T6bXOqzry0MblRybka/VS49hB8yc9n7YmZkFH0/WNqS0wsJhHv4R3nmVIgIXqblJpT
         Z0nt/kc320DuMOn826Cq/Bk1MSCBcXjfXn7gsRa4FBw0TgsGKD/iYZ4JnNV2p6eAnlPo
         0BCXtWxXawmpxxKlcoEWfPV5vEYPPN0CuczZf6gtXT5KbbJWhLZHrOaxJxW57Wp+MTOI
         IA47TfkBudDQ1KXhj98yks3dlXXbRQapGzVIdQdFjHp3hkrfQJGWFLSc9JMjKk2K4Q7H
         pjioMl3qmP3iHY2uLIUGFriV1C0s+hYwObh6+9qAWkU6ngdqyAgHvE8zOetF9UkiQfdY
         rDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729706879; x=1730311679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kATzDkxmkYVxO1o8Q7c0NUcnQZx/ICJwTgITx6SNcAQ=;
        b=BlEwbSJsTLOkF483H4lzCKJKpw1x4ATw1SimvshMpHNJRYvVIdxpuKbMV3NlXjOEWW
         xqw7FXzjHzvq6MHjBvJ+7//SWZwA+BIi4hHlhtWL6sx6dl8evSHG2+wEV/mgbu0qEDZB
         f7nwlm1xos+85YdL2dPsGytMuBo2db8tP0EaH56HbfkiFD9qabkLmQubRJYB+D6J3+NQ
         aIxnutQxZcwFme0FTZsM2DtNKB0fkI1jzg9D256Nz7KJNo5pJ4IBVHUU4w4gT/T4lrrf
         UygDTRVwCOJMkz1UvrKd6i2KcSRX+fViN7+/A3BT8QMi0ArF5XiqhNdI3Wx3OzaXHfsy
         pvcg==
X-Gm-Message-State: AOJu0YwhxXck1yubUXdMstINGGOPbALQ5dERVoQOOpQf5DhjmMjwW1/S
	S3JW4G/awrfAzzC/1hr1tw6spKLC45iNUJE1tFOrqNou57R6cHVdnAQWEUzxShdUvzMfJl8KPkU
	H2c0=
X-Google-Smtp-Source: AGHT+IGQp69dEGU4TMeyp2tMrV1SkXDVMTwcsDA/byMpzhR3hbibyAAFSr37IzzGrZEOM7wl2c4u7w==
X-Received: by 2002:a05:690c:3347:b0:6e2:12e5:35b4 with SMTP id 00721157ae682-6e7f0c2d79fmr41736597b3.0.1729706879400;
        Wed, 23 Oct 2024 11:07:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5cef92dsm16274527b3.113.2024.10.23.11.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 11:07:59 -0700 (PDT)
Date: Wed, 23 Oct 2024 14:07:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] compat/mingw: allow deletion of most opened files
Message-ID: <Zxk7ffCFJI2mGMhJ@nand.local>
References: <cover.1729695349.git.ps@pks.im>
 <3552feddb332b31744c2ab723b112b9b08926436.1729695349.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3552feddb332b31744c2ab723b112b9b08926436.1729695349.git.ps@pks.im>

On Wed, Oct 23, 2024 at 05:05:00PM +0200, Patrick Steinhardt wrote:
>  compat/mingw.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)

Very well reasoned and explained. I am certainly not a Windows expert,
but from what I read the changes look reasonable to me.

Thanks,
Taylor
