Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52D11E47A8
	for <git@vger.kernel.org>; Fri,  2 May 2025 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746178485; cv=none; b=mPyQG+6fhhk3qEdJ0pBIeeQ1eFqOzatreIPCGUKijy6/rZK4yyIJxKnyolkvLoFF8JYnFTb33H6iOIF3E6QK+7IiTl/1uq6iUbGRJg7gKlUs2VqvyWNiZkxHKTBWT7yoY3ftAJ0oMjgi3X1TVjVaMJs28g3xLdsQJHqJEx7NiEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746178485; c=relaxed/simple;
	bh=RrMq8UKOhm2w52swfVnEm10eqSwzt4svc6CrbuZzHiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AcewIIIZjv9C1wPvVxuTXTElDDgtBn9vLlv11Ig/3n3fdjA1Z9nc/xp1VHU9F1RWjzquShaUK82fOTLgu2Ffi487Pgdj4PZfNt5HP8Rles3qh3lk2kTa6ihEtjrkT3ILX/zpFvO2A2oPcDkN2vTlYpZFz65t2nvMwFt4np+R1oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0+2XzhU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0+2XzhU"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5f62d3ed994so3282733a12.2
        for <git@vger.kernel.org>; Fri, 02 May 2025 02:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746178481; x=1746783281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrMq8UKOhm2w52swfVnEm10eqSwzt4svc6CrbuZzHiY=;
        b=c0+2XzhUBMHuqE+9E9XATXQxd/Z7PxFR0FYSOHQ9tsdlhplO96wWRLbCVyUQ/IO3BY
         MkwBFQS5XecHiGiWVTGcg9aI3ipK3yEbvB9zz3XC4153RCuGD7Dz06G+VZIJ1RoTgThi
         P3fqwfAqJKS87l8ZCJ19QyHtxxawPWNivus4wTzPTp/CtgzC0Yqf9yRL+S15lr8m05t/
         tQPMvlKlR96VmB28PPG5zQcT7+e3PEQNseqzu3c+kv250Xt3VN9VCGCHH9dNEBGcryOp
         fVXwG8grGENREv2c9GTf1sYjUT+lcStlKysSA+kdY11LmdWjYobHbIC56Z4ckj+uSyRT
         yLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746178481; x=1746783281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrMq8UKOhm2w52swfVnEm10eqSwzt4svc6CrbuZzHiY=;
        b=wg9qhdNoPSfZpUcMth/RjSDrLKowNIZCwMjYJBbm3DxC8NU8IT9XEp0IWjDSONyrFp
         YmmIPcnNR+mDWSUjCAPTOyVsCZpeIaLx/t0DYBBYxzFU8hHfXK1pFaD3RKAkIarV2mHb
         PrH5QneNfGCqbpbrIv7YWl1oCUOj+7jxpdF+B1The3k5ld+LXc6kPfryacGUIUxhDt7Z
         KXvEpY9iOUVlYlr9WxWLtHvxXkuCDv2bWF7UQWDAdxUAYHUwycePuaRAEkYd/s4PlMq2
         lRIyMnbh1k4OhrveK+0bJ+04XMUjwAaDEVtZ2BANJzUCwRFRPjOoohmxShj+fhi1R8Nj
         AxAQ==
X-Gm-Message-State: AOJu0Yw7OOXlHkIR2YipSegGPqocuBhSNj22A7VQ/7TOsJwzwYlyRLhF
	6MxaQ0hoHCpEmUPTQsGAplISlxDFZ/+QyXw9z0lAUyR8ocuJ64jXTX3+cmLzo4iExI/f/Y5hlFk
	sCYYIA3KBSfIMXWOJ8dOaY8sug8sDcZJT
X-Gm-Gg: ASbGncsarQk8L7lVEBlGvM47Z5KR9alqe2IyvCjNIvizddJvcGdccLERg/t4Wnm31Gb
	HB4KpgEDLNMNb34r2CSX6ikCgETbx4G+OqKX2hJykUkaTWWQ80SSWoKbHQGrR2+39zFYAU4lcnj
	jchCHxPB7/cUmqBCIdTX0lcsZvEfA8xTZvsel+zXs0ZhFpFV8DCbuSpsLWV7zDjZcv
X-Google-Smtp-Source: AGHT+IHWbjRKRreNZ5VpbuVdMEwQbb3BRBsBhiRUFuplDBuWe0oO/og5dzj0OqNOFRzlCgU1lpj+Wu1NIBj83A6Q0Hc=
X-Received: by 2002:a05:6402:510a:b0:5f8:6096:7758 with SMTP id
 4fb4d7f45d1cf-5fa7804e8f0mr1487163a12.16.1746178481232; Fri, 02 May 2025
 02:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414160343.2216312-1-christian.couder@gmail.com> <20250429145243.992252-1-christian.couder@gmail.com>
In-Reply-To: <20250429145243.992252-1-christian.couder@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 2 May 2025 11:34:29 +0200
X-Gm-Features: ATxdqUEIf5rK57dRqeUhxl4gmJUtpinO-Of59lehVkEXlTsIHWHgFCrhaCX5VvI
Message-ID: <CAP8UFD2LzijGsU3-aO-JBPtEfT+UtR_X_mqcdVigoOfdVAg1uA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Make the "promisor-remote" capability support more fields
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 4:53=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:


> Right now in this series, the fields names (like "partialCloneFilter"
> in the example) that are passed to the client are compared case
> sensitively to the local config keys. I think this is a bug and they
> should be compared case insensitively, (while values should still be
> compared case sensitively). I am planning to fix this in the next
> iteration of this series. I am also planning to add more tests then.

Sorry, I should have removed the above paragraph as now the field
names are compared case insensitively.
