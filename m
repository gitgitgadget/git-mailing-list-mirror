Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7D41DA303
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720435345; cv=none; b=MzQpIJVZDqXxXuHr/gAbVX+OuIh5I2R8Ut1eRyyMcBcmfmoF4u6/IQudIwdY8Xpuj9+KTvHXUPk92o815ziWGPqLTpfe1/GNRCulg51NZrigBUnOYZ7e4ywWUWRlu2l4sTUCZ8ptkOMNMqgV7lUuw17fidpA9fIGAv8X05Am+wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720435345; c=relaxed/simple;
	bh=gzk2rFyjIkiX5CKV0YHC2owO4NZlbJZ9CHlSab9S6Mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOnEacKo+ISxCDMmy6lgbx4gFqaIHmCgWgyEoyPhkKTJpPP4jypIKqo94qZMERWOB3k+r1dA9TLi0K1TjVeFUYNXScv9csILtziI4CFjXeeWgZ9l5ssSMxRXdaN22bpQ9RsgO7AZhNGlh6M7zqam3ks7JYQAvgZ+P7KBphHOPTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ox71uHdP; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox71uHdP"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58b447c519eso4561131a12.3
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 03:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720435342; x=1721040142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzk2rFyjIkiX5CKV0YHC2owO4NZlbJZ9CHlSab9S6Mk=;
        b=Ox71uHdPFxEkSV2Pa4kCAmZqO6158HohCcrZqFf6M33hd7N/Jf593Ng6QGcSKYFjeL
         LBbdizUWkzrNnrYiEaYBR95xGjSu4voojq1Xt86TNwjr88Ot+jDELEpX49k0VmzjSMsq
         3/v9qjINML3iKP/NDQmRL8xA5ENVLOCYfVpb03GVEH3eO0PpsfVzFKa2rExid6euuPor
         ORPT+yP3drS+404EB7W7CZGQ9a962G2gwf82Qmohu6mzoHGxY5jddGTbLuO4/KJgBy5S
         FJE+8iLjNhn2QuCH4JMYHpN9EO/IPclyYyO+H8tQv83TMOUWvwX3lrVBUAgr8HGf/Q0i
         53DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720435342; x=1721040142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzk2rFyjIkiX5CKV0YHC2owO4NZlbJZ9CHlSab9S6Mk=;
        b=e7srleyzO/9tuP2quEgudjc5pB9gKJaYVgA4oBnjbPx7CZDGmXubb+/qXelcwEk7D5
         YlP+GcLU75KxAaXYuyA+g78cDhyoP7TvwHzHeI+9ItIQfuQ6V7C+GaHCFSc5yr1rHFna
         UgSF7ZVFNu65J0nMC0Pj42yVl0OzbN5uabeVGAZb0OHrFTbh3maKsjUdNPiZISlQ3EVU
         +BuIWgqCUDPt49JA1aJJI2/vSqkumDLaOPmSAGGt047uK+xyNGQHLQ1AdY9FcPe7rK6l
         HjqQJr/F7isb66wHbZ97Kal56vQ5Tg/fG/f/EewTc6pWidwRji5Dq5hTL7JA93IjCE2s
         7+Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWrTwIbFykf8/2oWwiksJCfuuU9IOm7bi4LASgLVhv6SbMH/ngqGPF+WwrZKwDFytnio1ToKG54o5vxDRpk3iQAlin1
X-Gm-Message-State: AOJu0Yy37kOpuKii2EglIk7d/c6zSg+r374Ypj5qA8zrFYnD3qAmQ5cM
	PZxTqXnYy5FW7ph44iAUmMY1ZHJ7l+uWfjzLoh7tqQ+ix/nNMvomomR0SSZnwsS8qWaQ7d4jbNQ
	pxB3FeXQPWVZKiwIsmHj1ICat9A4=
X-Google-Smtp-Source: AGHT+IGC8I6W2EDw10Xjz/af0KH+wnOf63QvH+mHBIVCed86jcItxKhud5oqeixrmoWUtrG+W1hMS8HGGdl7SNu8sCU=
X-Received: by 2002:a17:906:245a:b0:a77:eb34:3b4d with SMTP id
 a640c23a62f3a-a77eb343d7cmr278932966b.13.1720435341780; Mon, 08 Jul 2024
 03:42:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-9-karthik.188@gmail.com> <CAPx1GvfkC0rv_8_q5_HfduhuKX4csO+sBZiZqV+Sh+Q0dV8+4w@mail.gmail.com>
 <d3921679-eeb8-4cca-bc0d-967e9e567fd4@syscid.com>
In-Reply-To: <d3921679-eeb8-4cca-bc0d-967e9e567fd4@syscid.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Mon, 8 Jul 2024 03:42:10 -0700
Message-ID: <CAPx1GvcunqYvZtkSJ0wDd4802VPEyRzDJnZmfoGh6L1rFof2vQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] check-whitespace: detect if no base_commit is provided
To: Georg Pfuetzenreuter <georg@syscid.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, jltobler@gmail.com, 
	chriscool@tuxfamily.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 3:35=E2=80=AFAM Georg Pfuetzenreuter <georg@syscid.c=
om> wrote:
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html stat=
es
>
> "The XSI extensions specifying the -a and -o binary primaries and the
> '(' and ')' operators have been marked obsolescent."
>
> suggesting "&&" being preferred over "-a".

That's annoying, I wonder why they did that. It does make
the "test" parser a bit tricky, especially with empty expansions,
but empty expansions are already a problem requiring careful
quoting in the first place...

Chris
