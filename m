Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2190819994F
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757700411; cv=none; b=p62rGEQ6C3q01E5Jj4nj53Qh5kb0f+fBQhJNdaDRG6Rua6klk1zj1UsYeG8jaR91Eh9zrcixvM2YPjqfrLPhE+r0OW07G/8AHD89yBX+7AkUOH2BYIkh7ns9FrvQebNO6cHJDGz/uZPKuAjJq9weN/ubdqE9tFtqUrPbS7gc4uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757700411; c=relaxed/simple;
	bh=5cVneYgshvIbRR0hukyeug/6oKr8ISngo6ocyNjQzWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJfAPvsSxYyO5Vt34wiuGUW46wgHBE1/ug3KBT/s95FZ8UlveUUaAYbRLa0aIYdIF7ky/H3SrkaduO9dWMsHdcbBiTQCjX+6gXOPOoMcKOpPgceXFpWdYGN6SI0EMy2PTjttHvtlBGBpcVjI1wRetMlzJDwW8tYOw1kJAQHAArc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxJdNehL; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxJdNehL"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e98a18faa35so2231799276.0
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 11:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757700409; x=1758305209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwC0u7/hHYyGV6+mjhbbf4ASwlzdDn0X/3b7jZMhB3g=;
        b=MxJdNehLQilxWBQFrAa7ZDYTqYrORAhEhG6Q2OiWwW2fV/8Vv2lLJMqmvIrGiJbrvi
         GxOuSKpvYRMSd6g8Fy34aDCbhTKe8/s072gsaK9yVk520gU5bZJwMNgBZD0PmjHpMTRH
         E2lRWtticjwzUqSmWVq3ILxFOVI0TLHvcTF6NaVxW+0+6zoBPX4rMgderuLCr6bw7ku8
         WVMbnLutOvP3Bj3DjiXqaQL4mcEjhT065LwHJYBCGMAqncVkMgggJPRW2O3MCPaArJD+
         4477KcNak5zwqznC2Wz2Z3qa8T4dMrLkk2Nsa8pi7Jl4VeI6fO9zQ7YJWkTv55mrey2I
         gL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757700409; x=1758305209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwC0u7/hHYyGV6+mjhbbf4ASwlzdDn0X/3b7jZMhB3g=;
        b=eZpAtucw03CkHnvrkacRVEdQqbVWk2PlBK4rhMTzu9PjB+NXw3HyUy6JrY/ICD6MHH
         ANGin2VLqnXWbygLJZ/KF/IgNgQMOuANdzon7uFeINEhTVD6bvljbdOmKZFH8lhCbaLp
         Km+mAb1I22t6IG1OxVfEzaBwYMRddBEelNIPhI+xuzqNctkkLaadZaKY3Jm/NIQXnuqi
         qAz8tXL1l1yT+SzXI6AO4W0WxBRs5NT5LP+ct6JDEOoOnfDtRObbaea7eyCXDgEWCZkP
         WTg7E273ZiVVNxCsmr7hGqjPPPCCS3V6va1aRMKMEdfBmqWCoASy0ABM5nLff2nhnCRJ
         uNkg==
X-Forwarded-Encrypted: i=1; AJvYcCV7/QybXy5WzhCsdnkbOtQH8rj/XaGubSqVLuueyNhX40PDK4Ek7t0U075NioLiMWA/CxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMKVJfoMsr8gRkNl1KtkZxs3dPbx/Zvb1zyvJtvmJijIKDbLSv
	bcJctuW7eU2GZ+T9dsf0dpnCVWedHQK428RciPKWKXKLsm24xrc72XnAIM8Ff8foKbSYlvx66uB
	xPJrRwI7WRtpVOOWMO1z9jo/ZIwkPsZp2XJQg
X-Gm-Gg: ASbGnctYCqNGMNQH9qQ5rcW1fsEXXCBW7M2iVR5KKJ4+UdLzhXYd3gi/gd86AQnmoHm
	veD+iAwPy+uzG2qWyq3Fdvu9DAWr2YWL1BrAXdeumP2ALXbH2M5AIlfZK2WCVs8eTs5UgjITj3s
	a07wngO2kDJDNqt5NNsypWZLzXqMi9Zdf0rucOK82ecSomUGvfqSz34BL9E1XpWWtECg2DIJpvZ
	BJns+nGSl6FNCCqD71mnkdr3Z1lug==
X-Google-Smtp-Source: AGHT+IFAvDTgMlIWh/ffaluRMMBzjRAO1fchvBWYpi1akAAVSXYrUVZ3ZNw6jH4HqmzOcNjPrCknxnmSJuAd5H+9mIk=
X-Received: by 2002:a05:690e:154f:10b0:600:f8c2:2264 with SMTP id
 956f58d0204a3-6271e757025mr3042179d50.7.1757700408860; Fri, 12 Sep 2025
 11:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJKmQvf-sLxowLJLitvqDmyL1BXXDK+anDE2jaBSEabApMNVoQ@mail.gmail.com>
 <071101dc23f5$fbf06e30$f3d14a90$@nexbridge.com> <xmqqtt17my71.fsf@gitster.g>
In-Reply-To: <xmqqtt17my71.fsf@gitster.g>
From: usharerose <ushareroses@gmail.com>
Date: Sat, 13 Sep 2025 02:06:37 +0800
X-Gm-Features: Ac12FXyyej52JC4tlyVXNQi2oSyP__jie1nh_fpeieBYmRH_PhDRJWZwrM3-WZA
Message-ID: <CAJKmQvd1r3NvWKnswHFBf-HJ+H63wBhKF-Q2VABZAbvUXacUQw@mail.gmail.com>
Subject: Re: [DISCUSS] validation on git config user.email
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 12:29=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> That is a very good point.  We need to remember that not all users
> use the value of the field we define to be "email" to send emails
> to, just like some people use "name" field to store something that
> is not their name.

Thanks for your reply, Junio.

My intention behind the original question was not to suggest adding
the feature of validation for email legitimacy, but rather to inquire
about and understand the rationale behind the initial design decision
to forgo strict validation when the user identity feature (user.email)
was implemented.

So, is the case ("not all users use the value of the field we define
to be 'email' to send emails to") more of a case of "exploiting a
perceived backdoor that later became justified" or "a thoughtfully
made design decision from the beginning"?
