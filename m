Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A7C1FAA
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045513; cv=none; b=YrbXHe+G0spxnIbXKZmw5kLUz3ilO3ux5m36CCfRQLLw48S7hVmKK2qytMBoUeyyanUUQtFsiW5Cax9aujw71Zoep/psd6VlNoYrtJfRf1Xy3gc+6+dhBFhYnopqWm8USDG7SsLft5qiwj0EBGnKj2tCjL8k6LH4OEtswXwh3HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045513; c=relaxed/simple;
	bh=lDJDFyDMr2NXSEAok3nwmHXIOKQzRJCHntZEzOzmKGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3x0hmcqU0DMKR8fJuqueLJUYPTnUmqC+GfTFiHpD2JWSVoRqi3UrBOaCh0aYsuKM49+hhTKnqUCjYWcQZt8Xk789wofs+MF3FTyVHmhoZKJKpPpUyCzgzNAmmS/xFdUruCK14Hla0XehReUUg+nPsI7N3cwq+CqqKS36zLK4Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMpF2dhN; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMpF2dhN"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5c5b9d2195eso2797629a12.1
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 05:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728045510; x=1728650310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDJDFyDMr2NXSEAok3nwmHXIOKQzRJCHntZEzOzmKGY=;
        b=FMpF2dhNdEC+9tGJNRsymmma1j77vsSdSv/Ecf5WKdi6/gO3HNyMu2dVxvNc9d5Xux
         4Rq8BRcm0RGdCVpBeGdBkkgFp/F5/ibpyWP3NvcZcd0iRJcbicHSzmvE4JqscCgglBcX
         uReukR2POiqw9EAE29Y+2q9eS1UCyFQOFf+aLRrIx9UrKC9ZF/z/3xStwMq8fth0wSyO
         EGl/bFTTxc+JkPxonFuDKT9QT7JmQLTdQJvSvGRRKlpS1GzeOpvbNRS3od4F+IiHQa34
         s6EbVyqwuIZt1ThCMo5Q30eQCNcMO7i79jzD9fP7boTA4iZw0/eR2B2Sn39frLZuria9
         DBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728045510; x=1728650310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDJDFyDMr2NXSEAok3nwmHXIOKQzRJCHntZEzOzmKGY=;
        b=QCtfwrHZtehsBUUdPeScyA1vwdzbUO4ZnIwcuG1IE2WHoHtJQGWTP94ZBNEIosp9C4
         MHz0Ka1xPwH8ATXcSh0sFg792gKjYTKP1yZcbRzb7QHfRIp5qabaibWtDuB0q2sLkUjU
         rcLo4xdZtguz4m8q2JCIrLV/gqBxPfDfIyf1UiopYdnpVzhAf9MjjSlLYEjOhvMM+HZd
         g+So55v2UiaDebQmNsa+EHt+TN9tG6fIt/T3JlVifsapWwecWYY8eb5HznmMw4iNBbDD
         r0SI9OlgJwzzN84mULwQJTEOg/SDWqZurCGvp9MSbwLqYIqiDfjBr0a43U6vKE02x/JE
         fW5Q==
X-Gm-Message-State: AOJu0YzCLuk9wLO3OFAYx3eAwpW/d8MXTLCIVPCWjLV42E1YaaYuFtQB
	3VjGqdAHtCp1/1GLLdLqF9YgoUsbpNTMI84bGmyprJxhNmSiFmDEC3JS57mL8UbTSI+7CQ6fcWW
	tFT/2sgKeEf2MSkTf2CywaC4ZCBi1rSerJHZiBA==
X-Google-Smtp-Source: AGHT+IECMLXI8hB3iVS1LeItf0m/9E3Mdb5KOddBn+vaVZhWxcRgGYaMFvcoIxJbtNqJ+lhb7+1khKuLIx0a5s2kBp0=
X-Received: by 2002:a05:6402:34d4:b0:5c5:b8bd:c873 with SMTP id
 4fb4d7f45d1cf-5c8d2e3004emr1595324a12.16.1728045509535; Fri, 04 Oct 2024
 05:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK83d8r6OTX8ThZV=7wmdB1LXKTMoUx8LPin+kKAbhzH560pZg@mail.gmail.com>
 <Zv_IJCNyD0NeeibN@pks.im>
In-Reply-To: <Zv_IJCNyD0NeeibN@pks.im>
From: Ekikereabasi Nkereuwem <ekikereabasimachine@gmail.com>
Date: Fri, 4 Oct 2024 13:38:18 +0100
Message-ID: <CAK83d8pkRwjcPG0jfFvA9MKYXcbtO61=tmrGa9UDvwfL3BvWGQ@mail.gmail.com>
Subject: Re: [Outreachy] Intern applicant
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Patrick,
Thank you for the reminder. I have started understanding how things
work. I have gone through the materials and resources to familiarity
myself and start with a microproject. Thank you again

Ekikereabasi


On Fri, Oct 4, 2024 at 11:49=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Oct 02, 2024 at 04:18:18PM +0100, Ekikereabasi Nkereuwem wrote:
> > git subscribe
>
> Hi,
>
> in case you haven't figured this out yet: you have to send the mail to
> subscribe to git+subscribe@vger.kernel.org, not to the Git mailing list
> directly :)
>
> Thanks!
>
> Patrick
