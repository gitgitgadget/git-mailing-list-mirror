Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7A414A8E
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 22:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758837770; cv=none; b=omp0xwUU695ywdUT02PPTXMSfV5xG/2wvQAZnxpN8Nc436cP23TbTNi7rFCKt3rNdKgQ4j/XehYeOSh2IVpYBE38trzi3z0jX5A5G2SOLn+AW9E1GyD7In5YLLwvOppiY3Wv9k39X72p5nIK93JDxk4fDgFQqLgX9O4/nCT5p5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758837770; c=relaxed/simple;
	bh=HFE5RN+X4W9eV499W4Y625N6dTfbJipSpOe58/yalpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSXd9DdNhN+Noq01Fw7oCdXLjnWQN/vaqoNBrOx3RgF4EK/QHrWIeXTzd5VVTAZtqk58t/BAYq/k7KwB1Rwhy8pkxaDfSP47KNcAOC9bm0wbz1DD8AS10mIb4gv/E+bFViKMGLmM+0Yqq3ufJf/X1FeXuWLglkRTcD9eBbWn5MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWJUSYvE; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWJUSYvE"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-361d175c97fso13813181fa.3
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 15:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758837766; x=1759442566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFE5RN+X4W9eV499W4Y625N6dTfbJipSpOe58/yalpA=;
        b=jWJUSYvE9mVcuaLNscSLSNmd15/gyUHC7qt4JlBXJKmv/JpHK4Hr6s/DmIA1RwhTju
         2a8cR1VeKTHUhI12YkkH5M+C9e34pCxqJEDm81sdcC44OO5l4BWVKlWqv7sVe9uazEx+
         OzJsQ4lCmQ8rkgQ34v8s+90ZzeoxO2ZhQ+/vEKTTSgnvdDMDyYz+/VfBBvJzl9oIgvkz
         hHJkT/981It8i1b/zuPnDBGnmYDr8HRD26lkOQOPs5gUGfs473kQFb1iZLgn2e0ITKWD
         HsbT+G6PzukbjfMtIUoTsPl8NBsLLM5t2coE1vAjZIvsyUG47o7xANF1lW4OGlGQoLV2
         ikcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758837766; x=1759442566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFE5RN+X4W9eV499W4Y625N6dTfbJipSpOe58/yalpA=;
        b=fu4eHTB7vqxmT6miaskuw/SobZjqaEIYW0v6plf3eQrD4K7nPvDT5baHHAYUwQcgTI
         MohS1omq+tRDvApg+ZWNAJoifBUPBgT89fLlb8UV4NyC3ZmRr8L+uRramrBOfcvu3RkD
         Fg/1ywz7kF2K4wbia2nPZhgRyefkdTU9yjQAme+kZLLnBsyysKN6P3m5+/VqF5INny+m
         ZxIH+XQ2t2B/O6z2zDjDwxwV6Pr9ibHH+x8yl0kskClDEOkDiSlqlxtEkWsplbwMoNFh
         85i4+QU6CuIgNTEPJWLU55rpqG6jB0yGGzelk6C8CEzbnc2gK6KMLJxgMZtxFe7pwBuG
         R3Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUnksM/IO1Mfo0Hq7SGxqT0QxLN5c6JwrNzQ9cMT3qmZY9ieXjhTraeEaQEZA+6AbWXqZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAycPytH/dCQ0eBHm7WYN/fT9dLLr8frFT1gPULQ9Td5q1h+39
	q04Arqn45EdM7B2MRrjBN1yNKVCO8DWiV2hh07JMls++mdoJkyR909BQtDsMzDNS4aohvQ90WBu
	T0wrwKts4UZi1xcrcRkGOcVh9Ei3I0jM=
X-Gm-Gg: ASbGncv2RM1SYsC5rzcRWdNAq19auhBPs9mq8bHdLakYtAKNyr7eMjedwgWPVC3Mbkp
	lsgkVIK40Z4/RHEb/NH+KNDi3XJqFYWuPg0wKXRvWWTSp1ywEr/qLq3D/4F3nPc1KTAzFqLSeBl
	O+NrZQGQaUC3dMM4vRTQW3xhkeK+vL4HmgilnnKwp/CVptFqqTWNzSB8k+JHUUyNwevQKKfm44S
	PR2poAh
X-Google-Smtp-Source: AGHT+IHpdjAZIp7MY67jaN/BiZu6uaGbcOkQuOR32UqwBMjDPfc+knJqs5AkCbD7klhGY48OCrdTIQWu1bix6xfrGVg=
X-Received: by 2002:a2e:be05:0:b0:36d:6ae3:816b with SMTP id
 38308e7fff4ca-36f7d6cd772mr14979441fa.13.1758837765620; Thu, 25 Sep 2025
 15:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
 <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com> <7b0856108a29f42e5a4d3faf7489d5522b683f71.1758662670.git.gitgitgadget@gmail.com>
 <0bb4f30b-6737-43a2-9aeb-3903c0dc5ce6@gmail.com> <CAH=ZcbCf7bUTL=BwCD8B6-AVHZg+K3JafvksLQWUx2D-XR58wA@mail.gmail.com>
 <xmqqqzvvn9tq.fsf@gitster.g> <CAH=ZcbAcvoXJYPHE=mcZSqPLuUPxKcSs-vd307X7uXi+aG3evw@mail.gmail.com>
 <xmqqikh7k05r.fsf@gitster.g> <CAH=ZcbAm8++qGNX883epk0h3NA-Z=8+RX1bDJeTe=n2jjSsdmg@mail.gmail.com>
 <xmqqh5wrhutd.fsf@gitster.g>
In-Reply-To: <xmqqh5wrhutd.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 25 Sep 2025 16:02:33 -0600
X-Gm-Features: AS18NWBbkjitE2vrVu0Mvt-dk0EWxVdxa3zq4QHZgLo1j-djZ6RetRvZaFleknI
Message-ID: <CAH=ZcbB8NOMLHqjCGYXFJ6Ms_zc3mMrDSPtargAJ1jcPE8fR7w@mail.gmail.com>
Subject: Re: [PATCH v5 10/13] xdiff: delete rchg aliasing
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Ben Knoble <ben.knoble@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 1:09=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> So, with the same code but with a better justification like "the
> original uses a few local variables to shorten the code, but open
> coding the access to underlying members of nested structure without
> these local variables is not all that hard to read, so let's do so",
> would probably be an acceptable explanation with no need for other
> excuses, I would think.

I've changed my opinion. I'm going to drop this commit because I found
myself using this design pattern in other functions, which would make
me a hypocrite if this commit stays.
