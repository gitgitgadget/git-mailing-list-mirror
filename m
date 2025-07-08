Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42165226CFE
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 02:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751942874; cv=none; b=P6nw8w8lHgO/1KQTys1GEkt4og4EVdO90GJOxc8jJSR1LXNoG5VQXJy6ev28QB71ie+ACfOxjKkqcvQyGD9UZhUlqZpFQjIbzs5Loq1iSXxBU5Uuc7+sbNTenFffLqwJ2+wW7GbyirTZ6BGN3ED078BGKTR5hAFfOM2wwISQrxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751942874; c=relaxed/simple;
	bh=Hdjji6hGTaX6IgepML2wfa95xXgjPqMSDyyubRYH5tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YK07Tz3W0EpLuTbk/1cptwsUjRaVLnPCrEXlp2ZFjWDjHELXFkKGDHQf0xskFrXCZHT5WUtEZbIgdDFRJ1TWvL7bTe85BR8ZZthommQT7oQODvCruRVSnw/faem2Ni38HYzdqkQBzhIiOvARNlbkCWAAJoJnnVWzJQcpCu1ZRnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lJhX0gQV; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lJhX0gQV"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b3508961d43so3004859a12.3
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 19:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1751942872; x=1752547672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hdjji6hGTaX6IgepML2wfa95xXgjPqMSDyyubRYH5tw=;
        b=lJhX0gQVqzfbILr1I5BqaLeSbLwHnpXLz76ZPp8Tw2y6G1u94l0EQaz4sr/nIExjzH
         47SV5Ai0V8uV+oC+3RZcTdRfjhLsdps55t53FAqxYvG6gN0lqgGgfB4KQ8yByADZFrWl
         ycK9M+SuUwAtVLKI6tejfSAWl1c5n+yKVQdeiArgYxl4BrqV6m/+OFy/BNg8JRQj7GDv
         V8+QiUbBRa2q/Kn9PBvcJ8mreD+bTG21OWVvEeo/7q2trPxnAJIYl1V4eGMLynjbdSE/
         n2HkbH+NuQ1EecCeSWARV3aV0ACIN94aHdbizuW+LrLn+nVjJrdhVOx/AkaebYA++AFW
         5NDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751942872; x=1752547672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hdjji6hGTaX6IgepML2wfa95xXgjPqMSDyyubRYH5tw=;
        b=e1Ws82XcdHNvI5RZnuPzyzGfqERox9Gx5dw2seF0rtBikQr3bphgTKmeWUVcxFWjNu
         qRh2egGbdfdj5OyzHK5W5kwIx9+c680ZjwqsJd6TaBLze+oc16fKW/IwyF05GXojWhG/
         6SkmU+szCYInGDUBUKD0aJOmvIgsh3Pn7Z8hUBB5DAuFOq9kEcPQffzmHZKCeqkGRp7B
         ZqUfhizW9Olzs/Ff5jgwM7qVSXYdfzaDSawuadevotLWRa5Lpng6W7ib9DI1mtEDc75H
         kL7opjyFivWa3Pe7zeKlOeq7CyylhoWzWXUdX5MkpP9I3M9lrpAkdNlW6fn7sbVVwQp+
         eRiQ==
X-Gm-Message-State: AOJu0Yy5evmTNBrtjZgcuGI1fz+cw50nyj7z8pL0WOxOcefCc7cLcpvt
	C7ERINTpD/uGd81HZ7kX24pKXTvERMOhGYCbEevxjHHlYMKt0UfXDJhN7WaQvvDaaglMmfptFF7
	e0Kn9M8Mz9W6Un17IsfO8Hg74ZMr9NmL8HFLVGYfCNw==
X-Gm-Gg: ASbGncujdJrgkYnuE9np6hoPFHJNir9pWhCYgRoMTXQj4/bW7dY3nCTuUgAjmRnKBur
	bflVxQJ5OyNHCMAX66iXIJvF1kEBIIGlG2BcngYyQpd8S47qR0g+Ev6HB7WUh0sK8kh+8u29wBq
	+xWDoEj/0RWAqPHx4K+lGbDxGx/sz/WdpAGbuxPSXHIZTtvXXdQH0Nfd0t
X-Google-Smtp-Source: AGHT+IFP48i4DvHY0sYX8Gc1VMXsXOkwBoCyj7E4049ib3hf4jBvwmyEhd2bf3elwjXIR789qDZ0dFhO2UHg/fyCP9w=
X-Received: by 2002:a17:90b:3b4f:b0:315:9cae:bd8 with SMTP id
 98e67ed59e1d1-31c20e58391mr1969171a91.23.1751942872378; Mon, 07 Jul 2025
 19:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701115719.85226-1-hanyang.tony@bytedance.com>
 <20250703074502.45593-1-hanyang.tony@bytedance.com> <xmqq8qkz5193.fsf@gitster.g>
In-Reply-To: <xmqq8qkz5193.fsf@gitster.g>
From: Han Young <hanyang.tony@bytedance.com>
Date: Tue, 8 Jul 2025 10:47:41 +0800
X-Gm-Features: Ac12FXwG8Uj9g0dM7lbLhJjp0Z11oPBubn-lWAJMnXcZGHks3avb2R0rq3YbjBI
Message-ID: <CAG1j3zFz0RQ3mf=BRAQhCDWucOR0J9Z26Wmmz8G6+9dMbNO3Ag@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] read-cache: report lock error when
 refreshing index
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 2:01=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
> No need to resend, as I've done so locally while applying.

Thank you, I'll be careful next time.
