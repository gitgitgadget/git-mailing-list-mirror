Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E122236FD
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327329; cv=none; b=fzcXyuKGzBSa6+CSYyNzboJjEKT331c+IIS11ivvmUsXMSx+I7LmipZQJyA6/nd74hK4UiUFnJr2IeQV6q9A2VdxfyqjLBJwEHf+SStgwTuAeCGHdJx/2qCnoUMG20BXQfuHOrblZ+FxDrpHl2box7cyfx6OF9VzYpSdrI+EKUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327329; c=relaxed/simple;
	bh=pypnZZiuxMezARfTX8fndfnCQqeyaoDU5pleTlcMbJk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=p859akiTdi+Bqff8S6dR7mxYUu+2FE0yALtSCIWxPBDYOXATSo0BHVbDTWNcxgDzAMUSkB7BLZ0BIbs65DMCWlZIPFhNjNLCao2DuRXsW2NgirJsIuUJMauJef2hYYE7TvRY4R3P44+6ZRq1kM6GNN6CwQC5ytoHmtt3YT6FbqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UT3jItFH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT3jItFH"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f97d310caso841559f8f.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 05:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785327327; x=1785932127; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tcNhrA6YxyDd8hpDqltEZZHKhIfmdaxMirxgoqmOvMQ=;
        b=UT3jItFHhSBOW0WqQJ99qH/ClzbBLF2/nNksJbvPBSOS25O4Xp1Dk7e+CBqXR032Sj
         8cvjSONg4lRgZT/j0alJigvXl0XTjH+zZsUSf0rBPxOnJIvmMdSippTyeuqmIQlK1fdQ
         JWvChUnhKbRbdaAGw9KRF+cU99ImGeFzGC/8Slnz22LX7zhgHfGRNi5l4vbe/WNKcDWv
         9xbvLAwEcRgWS+fqS52G4ITeZkVAqqb0I+1XB0TjlMP3JrL3T4H7/diEPr0nijbuNrLS
         9V31iLu1EmKARGMhCUaws0slWcfsMQN3iIFBpLNkYrfGloEsM7nk2wbHJUdIualQ+xjT
         b59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785327327; x=1785932127;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tcNhrA6YxyDd8hpDqltEZZHKhIfmdaxMirxgoqmOvMQ=;
        b=VV0g7lpuCTADaL5weNdTu+LO3k6ycuUImowagkxt5Xm23/PvRao7viWM1boZDqmjmk
         WYloet/rXwhJwpLQbHLlW9Nz09aiAgxx2pRgsvBnzLDSsATU6ONYwe8lBM7yR9U3ltEo
         S8d3JCiQbs2jB/HeBHKqJwXmxiRwERRlyRtB0cYWjwc2ewXyBgUyKHkulzV+2IldlC9L
         h39PYg1+ESxwT9R9h/t2TydijjJ3yUYrC+I5zt7qA7BXVFVwN1UWqCTLHK/lN147jg3d
         83celgOa/ouYcB5gfPVEItaOjvLjGsJstgLmSIbkdX7n3mT+0AY/miiscBEgv72I1dcP
         xtWw==
X-Gm-Message-State: AOJu0Yx8Yc1vSQckFh1b0kfC+N9XqLgA3UEB68TQsuKA4DVrTDpAnbDv
	ZmuomsEci9iEtmxYGe7vuaUB6WVoAIao7aR8bTk3ryMVp9SU0dMoR8rv
X-Gm-Gg: AR+sD11bn20IA1HyeSr7XuC0IG76DQIJTa2sL9+WNim3JorWUPjM7013hhubR3r396R
	FB/fRxDWYsrMFSIebNZUpy7+K5qSqVo+NNTeWrNuKmeUBgAgqvZiKOZ0KyFSwOWSgi3bilmk/xe
	bKBBz0i9DIlZ6zR1V7gSJkiPaSZy3X1ht/rDA9YEJbF5fzsV1DZ+QHQtgNyV3H4+Yie2F1Cw/D2
	P6oXzWK108Bw8UEY/UIlmQYUKydFr0miLS0sjvaSOu+RucaPIadSgSzYEWtbul1HuXXpXpWePUe
	wl13KdvfGpnvM4NgRWrJZWH4TTEnzpohonz/BhPV8CAvOtZFjf8YI/dCkHAWPbWY+js0w6uY6zn
	bBccda7ClCgyJwCm2qFQ88h9HL2+ywLjiF5a9r0CuYQcrBIkhGyRQi7lfB8TLfGOY2Mjd3UfWS5
	UXu7X+zzLeq9x8k5w5iOboQ1BsIrT4ChWzysM+2Yq1bQO1K9JQTgE+gcLAeEZcsSUlxGCXQucz0
	ITL4t9UVgbYpQPkHgx8+uvG9zNZPT9iu6wg3o17ZSOOExiHqi9eS/tHJM4CTWF8qLrXF/qhoXBd
	nnT4SyqvG8IjG38mY1ea7Yf6DVi880LhjUZB6BwjuELMXgRrO1VrqJiOSALvd/efJJ4WcLTslRs
	=
X-Received: by 2002:a05:6000:1884:b0:47f:8ed4:133c with SMTP id ffacd0b85a97d-47fb1ecdf49mr7670956f8f.31.1785327326548;
        Wed, 29 Jul 2026 05:15:26 -0700 (PDT)
Received: from localhost ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b0ee81sm8062467f8f.17.2026.07.29.05.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 05:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 14:15:25 +0200
Message-Id: <DKB1PUMUWM9K.31JZRJNIO79CU@gmail.com>
Cc: <git@vger.kernel.org>, <karthik.188@gmail.com>, <gitster@pobox.com>
Subject: Re: [PATCH GSoC 4/5] serve: advertise type capability
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Chandra Pratap" <chandrapratap3519@gmail.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
 <20260725-objecttype-support-v1-4-2d4ca3bbabf1@gmail.com>
 <CA+J6zkQKHVhDLSXYz=hFtfnACHviSVZEDignagbCVLhEWBZiJg@mail.gmail.com>
In-Reply-To: <CA+J6zkQKHVhDLSXYz=hFtfnACHviSVZEDignagbCVLhEWBZiJg@mail.gmail.com>

On Wed Jul 29, 2026 at 11:58 AM CEST, Chandra Pratap wrote:
> [snip]
>> -# This tests depends on %(objecttype) not being supported yet, once sup=
ported
>> -# it needs to be updated.
>> -test_expect_success 'unsupported placeholder on remote returns empty st=
ring' '
>> +test_expect_success 'objecttype is supported by remote-object-info' '
>>         (
>>                 set_transport_variables "$daemon_parent" &&
>>                 cd "$daemon_parent/daemon_client_empty" &&
>>
>> -               echo "" >expect &&
>> +               echo $hello_type >expect &&
>>                 git cat-file --batch-command=3D"%(objecttype)" >actual <=
<-EOF &&
>>                 remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
>>                 EOF
>
> Instead of this, what about creating a single test that verifies
> 'type' is supported,
> and modifying this test to verify that the other options are not?
>
> That would actually preserve this test's behaviour and make it easier
> to extend in the future. Something like:
>
> + test_expect_success 'type is supported by remote-object-info'
> + test_expect_success 'unsupported placeholder on remote returns empty st=
ring'

Hmmm, it is true that after this test there are no test with the git://
that test for known but unsupported placeholders returning empty
strings, but there are tests from the previous series that does test for
others that are still unsupported like objectmode, deltabase,
objectsize:disk.

I think on more test grouping all the one that remain unsupported will
be good and document.

I'll do exactly what you proposed, thanks,
Pablo
