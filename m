Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABAC153BD9
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 22:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749768922; cv=none; b=dM0wZQBgV+njzsJ2biL4I5hNyjCcQSSkZWcDFOlW4FV9lLoh59Ix1v5cF0TB7BNat/EF0mqtk1fxMsjhwPv6byBsei+DE1IBIdNBMqdCR6kM68loeIs3qy0o3FbfHVdRB8kZDYWW/pussFRPLTxIV+eh7ZQWApY8CFjxWKBOkjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749768922; c=relaxed/simple;
	bh=clftN6DHPKEHEy7BV8xjQvOJfqCmThObJelLAY7n+os=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Qjl3soDFbA9I4R1SV34eZ8FUk0CDFxRgXv079EpfZCvsFv68zOQs3h+APdOnQ9CoPikI978CbLuejKxub4L9yPkM7pz5TH7sJIagJgqWVENBlF2VlhSdnW3lOCcF+PbUgZ46t0KKJTR4QOhoJezVCvtyUSy7TQ8snT8GsaGzslY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHCHf2aj; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHCHf2aj"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70f147b5a52so10608447b3.3
        for <git@vger.kernel.org>; Thu, 12 Jun 2025 15:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749768919; x=1750373719; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=clftN6DHPKEHEy7BV8xjQvOJfqCmThObJelLAY7n+os=;
        b=PHCHf2aj984f/brmYL2QYiDl1Kpj4ZzOZLhug7i7n35DMf9uw4tB3G8TwFZeUIAFTM
         VvaloN460wOyju+BZZp4KKrMqOEFwYjVfQ6EIPkeCbmGAi0GjGJEUYN3ycN37Mfkje7g
         /G1KmZaD3IoFSNsGdB06wLX6WXa7py8uqeq0uilBqL7AKlm5RXgsM6eFurNQWaZM2Zo5
         Nlv4Ffs2QBMgeX43dLcabZfwVK/ZNYWi3+Q5xPe6C/G/fxt4fvCmx+tTb2vdoxQoCp/f
         XwE2iBmEpBHc1/QQ/EzLuGjAc7qHfX0Rze43bC8/aVBOxh2unj6xb+loaYb8PYHKzFFb
         gc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749768919; x=1750373719;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clftN6DHPKEHEy7BV8xjQvOJfqCmThObJelLAY7n+os=;
        b=FYoKeRrVKm39J90ToEAhiBzrkWx59se+cPzNP2yfXkw9Oc5CNAvbTSX9OJDaPmp3kq
         dB0bMn4OCsvqeUbUUjNm02V+j3OPH+FWjSgS2FcHR0dkrpoiYSCQAeM97YbIKMwf2Z1J
         xCACb3DoTdK5XYJUR6MA7v8gTxiULBJLlKc3eHituvLUHe29jucTy7LGlbrNs0T+AfzM
         HAfrv9IuMtTiQSdOurxawGMXYFF+/q2hTx0MqK8JjzGRuXpxShfoDLXARVVNux4dZRoZ
         ZLey/OVDQ8Mfvndu2OREDBw/IQrta1pIaaOlTkjHCxjKUcQuPMU/SK+Ea8bUZHFaw4of
         5UAA==
X-Gm-Message-State: AOJu0YxbIGyeeYvxQTaidJvHxSpVSVifynWKtT4yg4MO+daL7Zs8KzeF
	h1NFanp9rLXnsxWKFfnfU9zvGYrrpEq+FWyVn3opva/eW+wRKoMRytMX
X-Gm-Gg: ASbGncuVLoHrccff5k4hR4fAheHwL7j8dIgRJ0QLF/G07irLsCg/fTma/yjiSZLlVLM
	uSsbfsNHFrTm1qxiyPKvjxTE1mvHnQ8jGdQrmqtbFZ+QlKfM1fha1TMArbdsr8LgVthNKfwV6DM
	cci8rEQw0MWuUSFMEsbNd4i+UviUkoMSh8zDvPSr+tbq6xUbO2JGkwAdiGs/U1X6m66jb5Q0s+j
	El1tGKkgRHSEpKOlUF8rcwmF9kwl0fWe3CHirMHFxHFW/2FdBY/B4EIQV7V+8J21EMqHxKSiFnB
	dm2bIeEGL/NsPgmD84hKx/g85DO6fmHBYsspJhGkbXPPgheSNllw5+ezF9+f2WxuA2dDayuQF6+
	jooMskPkWMjBMwROz4IMG
X-Google-Smtp-Source: AGHT+IFiq8BcwyBFxFgXYGmg3sO91NAbuCtPo5io7PTfHzf4VzLVWe8cv6o+cx7+M7kBBAIkANGWAw==
X-Received: by 2002:a05:690c:7401:b0:70c:a0c9:c648 with SMTP id 00721157ae682-711637ab649mr18567307b3.19.1749768919307;
        Thu, 12 Jun 2025 15:55:19 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a6:1600:acc9:95be:dcc7:a4d3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71152795a62sm4410097b3.60.2025.06.12.15.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 15:55:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [GSoC] Blog: Machine-Readable Repository Information Query Tool
Date: Thu, 12 Jun 2025 18:55:08 -0400
Message-Id: <CE4644B2-3FCF-47D2-B869-8926BD58A8AE@gmail.com>
References: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
Cc: git <git@vger.kernel.org>, Karthik Nayak <karthik.188@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
In-Reply-To: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 12 juin 2025 =C3=A0 16:53, Lucas Seiki Oshiro <lucasseikioshiro@gmail.c=
om> a =C3=A9crit :
>=20
> =EF=BB=BFHi!
>=20
> I'm one of the GSoC contributors on Git, and I'll post my progress
> weekly in my GSoC blog.
>=20
> All the updates will be located in the same page, here:
> https://lucasoshiro.github.io/gsoc-en/
>=20
> You'll also find there my GSoC proposal and a list containing
> the patches that I sent to the mailing list and their status.
>=20
> Feel free to contact me if you have any questions, comments or
> any other kind of feedback.
>=20
> Thanks!

Just had a quick read, and one question: in the plaintext format, why do we d=
rop the keys?
