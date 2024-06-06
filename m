Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3535845012
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699496; cv=none; b=ovG60uLu5B7WKAUlMSsBNdnedCZJ6a4HlTbbK7j3eNd5WdfRR0Mb+YiGFB4Kt7wqKyYXj6QOYUbP4PNn3Whi/GL5IGnZdd3Pa4Bw8qFnDmj4UZoVIwTDu5oHMsvxULOIOEjcJVPMjlvVoSQIHn02nx4RW6bRSd0jg39sCHOd+JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699496; c=relaxed/simple;
	bh=yZeubamkncBwXyX0Wv/XWW5drre4jqpUfX/jD70PH/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pAxnj+H55PWiiiyRedV1fmNwVaCd8p+Gac9UZdUKOYP4Rij2RK25Vy+TrhmQySXEIZUj9TFNAuwO8bYdg4p0G+kWoGchj4JYDSQT17APenN1Be/NXGjjNHC3q+e6LA37Y7E5KdaRcPJsmw/BFWNdSfCMJzF9fQf+j3lzlgYBD3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsX3p29O; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsX3p29O"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ff6fe215c6so1138527b3a.3
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 11:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717699494; x=1718304294; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOcmgTwkPTdoyIJFbYWvykp2csUu7/sUywzlx5njKqw=;
        b=GsX3p29O1pnTcnOOiNfAUad5O+EDWnfSovf2AfnucDsmvceAFYF7kDlicC1fJTRxft
         M+flmJcmJod+DY2LVSJA/oaplzeJpa8xe8jOAQ+QZfMB3TI/eg47kSX6TvMor8GfZ/OD
         d5gGxeuW0SLdSfOGDccPqkcx0uc9ptcrc/OC5qI0GcQ5O2asRO2NobWQd6jXqtkYOcrp
         NmFfC7zo+k2DgqkoMilYjEe0E3XoHjgR8Yz7zHzLKhHNOsEiUc0xvl1cbJSz5sSN0A7b
         SgCYHdDvkLxoH2xYKslwOVhJ/g8dwM/W8DmJzsaI02MjJ1ZhIYSqHCZLCcGgi7/sFDJz
         OGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717699494; x=1718304294;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qOcmgTwkPTdoyIJFbYWvykp2csUu7/sUywzlx5njKqw=;
        b=Fy2bWVJ3DqVkjdoak/eyScwC+DpgkNVP5QQ0XEnD++sg1po2TpsAtOTbrY95EHq+kA
         NtKI3IgXBcUqKft874Kp6DpN/ppoK4xiXH7t8GSlZyZK+ewRzov8TsuUn52wJw2uuYVJ
         JIprq7QFnXBrYHtezThAl3rtiMb0+8U877vzx70ZCgxvyaFCe5HJZWnvLDN2hY9bxoZh
         RxaSf7NvecUGoD5/3lvtpMLh4oBqRwilRGi7oqCnR4GgiCRfajgrJFD0PT+S0TE0j+n1
         iKmh/4a+eCt7nXlIzNbQzpMzg8NHF3w2oYhwFBTzmTmJSU2dF36ycfgfy0JCWgC6I35L
         b/Lg==
X-Gm-Message-State: AOJu0YwgsxX0gbs5pnLCra58w8XroiUJnK9qqk8ReLBj0pvf6Bbmjo6f
	JS2BQuycuEQdjGmmiT6lJZHJHaDrDxOXgquTaibFAltEacdMu5Im
X-Google-Smtp-Source: AGHT+IERfHzV3+i/HdNqveAH95P8W/9uK2QM96w69vldSZHB0pWa+CM3sN5wU69JEcLtH5fIGs0ZlQ==
X-Received: by 2002:a05:6a00:2e9c:b0:6ea:bf1c:9dfd with SMTP id d2e1a72fcca58-7040c737a8bmr331768b3a.27.1717699494312;
        Thu, 06 Jun 2024 11:44:54 -0700 (PDT)
Received: from localhost (201.204.125.34.bc.googleusercontent.com. [34.125.204.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd371c15sm1398721b3a.6.2024.06.06.11.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 11:44:53 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: <git@vger.kernel.org>,  Rahul Rameshbabu <rrameshbabu@nvidia.com>,  Jeff
 King <peff@peff.net>
Subject: Re: [PATCH v3] credential: clear expired c->credential, unify
 secret clearing
In-Reply-To: <20240606183516.4077896-2-aplattner@nvidia.com> (Aaron Plattner's
	message of "Thu, 6 Jun 2024 11:35:16 -0700")
References: <20240606183516.4077896-2-aplattner@nvidia.com>
Date: Thu, 06 Jun 2024 11:44:53 -0700
Message-ID: <xmqqjzj1lxlm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aaron Plattner <aplattner@nvidia.com> writes:

> v3: I reverted the behavior change to credential_reject() and just unified
> everything to use credential_clear_secrets() instead. We can rework
> credential_reject() in a later change if we decide to. So the only behavior
> change now should be the expiration case in credential_fill()

Looks good.

>
> I also updated some of the comments in credential.h to mention the new struct
> fields.

Thanks for paying attention to such details.  I very much like these
updated comments.

Will queue.
