Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B45B42AA3
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 23:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781089; cv=none; b=REGnJeiCl7t2Q4IibpMN+MHtbMDWBUYQBsvpIgYBvxAfBjBbsBoMsNwtpmx/c5FEd8RMYnJcFsC3itiilBjhpI4l7R6O2mTSgx6ceAyfGW+Tw8PwzPFGR+xraBQWcgTULZ40o2VVdW1zsbzPdhkeUBIOk6To3a7GpfyLvhyzvCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781089; c=relaxed/simple;
	bh=DNctnYdwSZ5DTiBKD0uoMNyPYGIAAeJhCS5GMDpqoOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HfZO/c6yuHRqKCqQ1HRth8sdoGTRhPsywJhC7BUzFmAAcezvUxObGNPlIlDkvQKKRx6eA45qJ9aDURaFK1WfZ8uB+lTg/ilPEp4HvLrPCRfLUSUgBdHAGakEdindLIvBRbVCROD7kMv4JWWjG+XpadDeLcJfUmwJxRhKg/qitEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5ZRozjt; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5ZRozjt"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3cf9c970d8so13808166b.3
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 15:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707781086; x=1708385886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNctnYdwSZ5DTiBKD0uoMNyPYGIAAeJhCS5GMDpqoOs=;
        b=U5ZRozjtZfG9ox/Ak5RzAYis42Fw2fDJXdStmax6lT+JmGF4/O2DHO3dyJVt4oP+Za
         VpDngbWBDT9fKhqQ2I8S5YH0HIgnDCY6onWqUN8YorSwUIUK4ersgMwmfwa2FTNryVKp
         rvT1+UvYTgT664jMQGfC+jW8hiNTNK8rh65eB0g2D525qOBMtIsU0VEaeHh/CzeFxdhU
         aq+tkw9Vs7SvF6RBAu4sWriMPjTsGlzj3R0/dzGXRdMVn13NfD7J0hXEnd62qL8nHQew
         QaP77XKnlENjYqZcRKU/yJi0OONydYSAAAordonRtBuWh7UWDyi/9V9elEAbrNqP3tv3
         vkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707781086; x=1708385886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNctnYdwSZ5DTiBKD0uoMNyPYGIAAeJhCS5GMDpqoOs=;
        b=bcM74a/bDqHrhYlyLNbY3rbS5MAIr0Q1PG9gtUCx4C88e6YN5ZZWFfaObYIGcmFDtq
         raDz96Qlg51PSnUV+k3OHDSRUArpoqLYFavSFOWiX47u3xMClAgpo1BEJrw28bZM771I
         h3wRgad6F+Uk3LmokEa4glnRvJCI66ptjmxmz5pgmP0eS2bGbxbHcifX1DmcCmPkkjVb
         kQojvcQU8NNpVOGTrzeZzDnk3E7XQFR8V9tquHd3QPNfMGZiPF44Tg8x7tiIYCfj+cHT
         vwI6Pqq+Z1HfBo/0/2YHXi2x/RipePIqv3/WpVAa2HOgb9U2e61VCQ6RhMcCNsF7Yqrx
         SBTA==
X-Gm-Message-State: AOJu0Yw5q9rUW/GhGrVBhxdVGhl++zxoPiwu0+bn2s2V1u/az6n3QgtR
	OZ5fl31qd7m1ePZjACJNQ6mszObHEvgKVFJ6ymWWZP4A0cO4h0jo2opP9mLfW8NDq+XBK9igQVU
	cFKB/bPHYn1SjbXI5uRvfPAsX7cA=
X-Google-Smtp-Source: AGHT+IEi2ospo0uKtbM2G+S/mpfEFvXVvW+EDzvZw3hwHzfkxmYiXvfrX9olxMZWXMPyxOntdXdl3KemfHRehcq39rs=
X-Received: by 2002:a17:906:d11a:b0:a36:f811:1050 with SMTP id
 b26-20020a170906d11a00b00a36f8111050mr5106143ejz.45.1707781086138; Mon, 12
 Feb 2024 15:38:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <a72eca301f7f9016ef3a8063f79790ce00f41ffe.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <a72eca301f7f9016ef3a8063f79790ce00f41ffe.1707196348.git.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 13 Feb 2024 00:37:54 +0100
Message-ID: <CAP8UFD1YaEfdM=apQ7An+GcKV+Wc26StsMqJcd9e5tHJg9U_hQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/28] format_trailer_info(): append newline for
 non-trailer lines
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
<gitgitgadget@gmail.com> wrote:

[...]

> The test suite passes again, so format_trailer_info() is in better shape
> supersede format_trailers(), which we'll do in the next patch.

s/supersede/to supersede/
