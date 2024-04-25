Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78163155740
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 21:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714081290; cv=none; b=eSB+eNlcOxLJqMGNG3Av4SLqwZ2x056G13pbq5AKyaVHJiKmGY22e8ApUtcH5tU5i8RFQr6EinqZy+W8IHUoY8bk6Oge+veL79DjSB1brzTOifQSeOKmr0KcU8qyZ76YCksIPEYnXua7ZefyEP0Tn7Q5ujrRR+V/Tp1aG5EbgA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714081290; c=relaxed/simple;
	bh=UyRw6gJf92zRylCn36LN+bAnS45P0F4roPoJ8OoENzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aP9PqaKsVFB6HEF5n7UmvJTJ6dpAkAH0fUB93oqCe07z9NgkGoF5xFwp0zwQyItBTIYcmaSzCli/Pq5rU0WTzBJRJPmFg+6FAbZXuV0YyNsz7R0dVJ3avJgRGQ2RSxWpV7V0/xNt5oLC/tz55tOdGOw/umssDbaTNI+aIO/MkX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Urw9n2tT; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Urw9n2tT"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ea2436de79so809984a34.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 14:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714081288; x=1714686088; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aJpr9Ai5bUaIAQru14aaAMcY5LLQRycgtXD3uJuA1qs=;
        b=Urw9n2tTE7gLU4wUBiO7ANAvjqqQyMdIFIi7xPEDYrvDosw50SKf69gKo05LTPU9y2
         enbIs/tZAUWPJ4P6UQ4ztnJdSaZI/CE02IsxEy4b69Kad0+1Yr1Hpaao4p0Ul0E062Mt
         RDwxGPgBOcpEly7NcedIdtholMVFufWVirnVEXfk0hbHnGFMpx5PAt/Ich+AexhRZm74
         TXy2UQAZlV17ef4YJ3BngxhsQBQVc8w4AUCISLH0Db6D0oX+5J2oudkvKoAtdN/WsU5V
         aO32A+uP1hvSg1wNGrrsJPEpXVLxR/h5eCmF5NCYv23hrjx2j67i2bWJPBneYJCt6gng
         c4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714081288; x=1714686088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJpr9Ai5bUaIAQru14aaAMcY5LLQRycgtXD3uJuA1qs=;
        b=YmCU6LoA3xUcsEUW7xxmAfEjEMmOyChHkNL/0mtR65ocNU/xzdv+ywnVS/d/vMdAk2
         lsNp5yXr4YYYNwRFmBpZAIIN+x43bopkRST5NqXye/rBfEyAP30yZKQlxik2o2a82aWV
         P4knSCkjJrY76Onmc8XlKllmozOSGVI54dKhvpw2s23bvXF/1HXPsR9yX6ueVuAd26vQ
         Z+/3mGlu03uqRuGbKkaTk1JY7XOK5ToLVl9kHqkjbVUaN4P+HfctelOCULqR16fbKj+5
         1xKiTuYkK5t7wQy0+exekkjy1ECn5twcD/ShCM3DpKrPRJcT7uLBQkZ5R0HKp2fuSuZV
         QATQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN/fF2oWYCE/G33NxGZfmkCH+J6I9dIhwo+0ranVqdOgyaq4ZZbQKKRMzRrCiIdYq5sC1JkG5lDTcUvOEvRx2NxqRu
X-Gm-Message-State: AOJu0YzuW/jfroHxw8x6QYr63Il1/u1sFU2o5nRFwvvoscnaa/5MGOsd
	p6Xjxf2svir91J7xdgnGjM0a1M96SASY6dPqrn3WbCghaS6UPA3b
X-Google-Smtp-Source: AGHT+IEQbIRlS53XbPnam36FwmjpcKawgTcm8W0EXPqxc7b58zFo9PGVeTOlTgJGIzmHtT8DxRSuzg==
X-Received: by 2002:a05:6830:1e90:b0:6eb:8fca:c5ed with SMTP id n16-20020a0568301e9000b006eb8fcac5edmr876196otr.13.1714081288448;
        Thu, 25 Apr 2024 14:41:28 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id l43-20020a056830336b00b006ea2b07e6c6sm2762391ott.1.2024.04.25.14.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 14:41:28 -0700 (PDT)
Date: Thu, 25 Apr 2024 16:40:15 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Roland Hieber <rhi@pengutronix.de>, Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] completion: add 'symbolic-ref'
Message-ID: <prwckjhoktcmdgl7637jekssonghcjcbsyuivwzq6w6eqvl7g5@nfumrglobhyl>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Roland Hieber <rhi@pengutronix.de>, 
	Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
References: <20240425101845.708554-1-rhi@pengutronix.de>
 <4ea09a34-bd62-434e-b893-8e3780aa915f@app.fastmail.com>
 <mg33zswrxwxrlbzcvxyssxpqty5qxbezw43rwwnkepskne6fmh@3fypf2gskbyh>
 <xmqqh6fpgzs6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqh6fpgzs6.fsf@gitster.g>

On 24/04/25 09:42AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> >> (I was going to link to SubmittingPatches here but I didn’t find a
> >> mention of it there. Apparently I misremembered.)
> >
> > There is a section in the MyFirstContribution docs that mentions it
> > briefly:
> >
> > https://git-scm.com/docs/MyFirstContribution#v2-git-send-email
> 
> Thanks for noticing.  
> 
> We should improve the situation by probably moving[*] more from the
> latter to SubmittingPatches so that people do not need to refer to
> both just to find out the essentials.
> 
> 
> [*] If it is small, just copy; if it is large, move and then replace
>     the original with a reference into SubmittingPatches.
> 

I think this is a good idea. Submitted a patch that attempts to improve
this.

https://lore.kernel.org/git/20240425213404.133660-1-jltobler@gmail.com/

-Justin
