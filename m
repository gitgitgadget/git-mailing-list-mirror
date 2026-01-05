Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E93348880
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767622424; cv=none; b=f97FP5W8iwqwy4DFJrtGn3ZIC6dq9KI6X4x+Hpeu4MwCxbBMFytCtHeKUlg9Ht78DFVMaN3dNqqeROS/VomQ8IHz4VkLXJ7AJsZr3jRiFBTei55EOYu92T6ayKcv0+riJjFeY7ObauGIBPBwm/q0agcg5ylHIIK3u/YVnfGGeXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767622424; c=relaxed/simple;
	bh=lxDYIym1x/IRZhW/hC3wcN17P6xiDFn80tDfrmdA2h4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFuOR4zkMrmBb0H0GCXe645UTZnVlHkrDAqon1SdylfgU23hvEYRCl2nckBTtmyYLxw9xuUGMDHTgmxGFYc8XywUSS6kqcs7NGnlFypaex03uHQiHHRGaIG3B7XkZka8tz+PCblWvUYRpxK9XV9LmFosEtrJXMgtPCwzXOdXnno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbbreXjc; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbbreXjc"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-55ab217bb5eso1560840e0c.3
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 06:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767622422; x=1768227222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxDYIym1x/IRZhW/hC3wcN17P6xiDFn80tDfrmdA2h4=;
        b=NbbreXjcpjsNtqekVncbNqL2zEtOjebnxwX7ijkQSBO+AMdeP+GaYihIScTjKC3A17
         B4rpa8g4e5yXm23Cmor7HJ97D0K2T+lWk5Kwe9HjAoKIURZAMGcmaAcHybrroCs1N8yT
         Ooo6pfFiIJmFI3Xi+FIhX//K3glkKPhbzn5oylM8ly1MSN93uZrKfxDPQA33CLgBI4N+
         cOHgudN8hp/wfS9bkUDOIVZkdOhJGmltM2EyZKYMwzcaNYugeladVsYJjkwqTuVXseA8
         IKQmlChlc9OIE8tWO/+uDPCY6fqwgwM7d7RZQ+KCQXDHBzFHL9YOxmer+jdED4ocCmIG
         O14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767622422; x=1768227222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lxDYIym1x/IRZhW/hC3wcN17P6xiDFn80tDfrmdA2h4=;
        b=piMfgFi0JnDkujrB9PJbmAnqMribYhXRuNKAOvKPYirajDp2lErgHHx2/rrwWSUzvw
         CnhUSm1q8PyA8k2iHA1Vqw6Dg3OARvIxDmzhB8swlART9shgZ4VbBr5aK7SjS5ZTLd0D
         S8WItQoaTeB0FSpa/RJK4xI06x2EDDDPgqrv2W6pLMFtRWY5TY5furm+yBis212R1rN3
         qc8O589NN/sO3R+TVkhWhkHIj3ENeDz8EHuu3f3m2iYDxucTSN5G9DYVqO9QuYwKEUji
         TlWMagK6ib2ZfvZRqKxElOuoLMsgElqrdlysqx4XIunxMIKzDymn82BKFH3TUysZrh2t
         p25Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkgjm8suBiZPT+ueiq8r6kT3evYA3cb+Oz1EWgXxX8JYYNwtmUxhFPqMhAQqQyolBdUqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymZn5/2WwDpKKpzLzPUGIMXMC1dtizNR5NWgaFsnF2985nU5R4
	PyiPzXD8+rF0UQdUW1ErZ0WDrkjMzWHJ6v5WEPZeETeHPVsRY2W0MPK/kzOAulRCWL+KQB8tQZQ
	nmuImhHAR+ax2869ZrpdbxspEAF7jZ/o=
X-Gm-Gg: AY/fxX4ZThybDeNjHjYosAfEke8Rv7tTNaZSpebTW6rbqwpde2UoLhrATYDr7OMeS73
	CeRT6pxhGVt3UjC2fiPT9Rue6jNdG1OD2inPTuTTVR5mCx54s7Ide7QiYfoi3QX/Gi0c4a98fEj
	ycdC/MACPVaf/Y0iZn/VIUDcxdglIGtJ7PjH/Ooua+RzrgWQpmIdgYtHAQSoj6YGHVD45CduqrS
	KyPqeb05nPy8Pm2tb6oBdWe+lOSeTUn2rmG0jX8vuEMZo5y9l5RCmmOcMn1clIeBRPCvOY=
X-Google-Smtp-Source: AGHT+IFvHf4hOtenqsqhoO3PUwgHQE2epUY0i1sLH9CV1sJTTLQYI+8zcHXDeL/LnzeDBBLT3ocXKP7n4owN+vzcpo4=
X-Received: by 2002:a05:6122:1b0f:b0:55b:305b:4e3a with SMTP id
 71dfb90a1353d-5615bef38bcmr14002641e0c.21.1767622422146; Mon, 05 Jan 2026
 06:13:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104124255.15609-1-pushkarkumarsingh1970@gmail.com>
 <aVqIjHIi6aKvFYXg@Adekunles-MacBook-Air.local> <CALE2CrQoXZjkpd+Lswd=qME9nkmUGu3HK8XacZ+Xz6Y2w+=t3A@mail.gmail.com>
 <CAOLa=ZQOryB1nf86BUkmL8JB88S+C4=z120uoExO7t9wmMP_Ow@mail.gmail.com>
In-Reply-To: <CAOLa=ZQOryB1nf86BUkmL8JB88S+C4=z120uoExO7t9wmMP_Ow@mail.gmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Mon, 5 Jan 2026 15:13:43 +0100
X-Gm-Features: AQt7F2riKa2dmnm66OEE7evEk-gfpyFpku2Xo5g7Jdc13hVR_jdO7tMcNI-lVjo
Message-ID: <CADYq+fYW0oY5yRLNeqveZqrT9-p_t=ndTZveEwGRpQ-JfYEH7g@mail.gmail.com>
Subject: Re: [PATCH v3] t1300: use test helpers instead of test builtins
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 11:55=E2=80=AFAM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:
>
> > Hi Abraham,
> >
> > Thanks for pointing that out.
> >
> > Understood. I should keep the commit message itself focused on the chan=
ge,
> > and describe what was updated between versions under the `---` section.
> >
> > I will send a v4 with the commit message adjusted accordingly and inclu=
de a
> > "Changes in v4" note below the separator.
> >
> > Thanks for the clarification.
> > Pushkar
> >
>
> I also find using b4 [1] to be very beneficial to handle this. Where b4
> provides patch versioning and you can simply worry about your commits :)
>
> [1]: https://b4.docs.kernel.org/en/latest/
>

Oh thank you very much Karthik.
I will surely look into this.

Abraham.
