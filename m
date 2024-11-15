Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879B7156F5D
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 03:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731642084; cv=none; b=I8wpVgemBWmFEvFpDVidjGB1wJV2nODm8I7p7Lno0evBOyJCbM6SjcGvt1pzUxwApZdIfPDBvEq5P64E9IYtLNW5WLMyq56GZICrbJEQ9bmG2ntRULgFZi6eD1UYB2xIcVoFg1keR54CuQ/liacPomHYCZfXRf4vCqW8wiNoMUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731642084; c=relaxed/simple;
	bh=7Tn5j8pGHfNGeMon8qdxmm+cGDMNUn2tsDCtJbAkkLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1bkFcOgiqdU85Y50cE6gWR5MgNv8OBJJE0SR0e7a01NbfLGIi5W0MN9upXGQis0MJ8fsw3Ya44W7xH0QEj7JKVKi+OApHUg+GMVVhwJLqFbBtokG08x+M4ZSsuVImxCCkaNBmfivTfqHnXnB2rMpCPGVERskc2yYjwIrxk93vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7qJXGS4; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7qJXGS4"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-83aad4a05eeso48314139f.1
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 19:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731642081; x=1732246881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V97BYvQ1S2qj3bGC58D5LaGJgylDQXtdH4Wb4rhsajc=;
        b=G7qJXGS4xBB2nTfTDNnpg+1eliOr+YFeorDuOpUgwsAvKg/RBFNyJLEwaxAcJ1mf7y
         yw80qlF3QVdjbjxUBSA/TZONepKvhcLL+sBW3AOpCqdxwOQVy6AJsTltm0MmF9yRjmtZ
         VG/U8d8TtPxGO7TlIvoCxL8jx2mxX0A4a5jY8KcZ4qDuOtpyqBx2b0w2n7uRsZ09tXvo
         SZH0JjcHP6bTVvq3J/CUpGCNJb1PowqI4h6UZrBu8HNeREein678rZWaG2hxEb2Sl2rf
         UKXLQQI4OiYqO0anBUUAJcpyl5DBLjBiM4n87YRWkOGCo+a/d4gezxoOxz7xjMiupwyT
         q2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731642081; x=1732246881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V97BYvQ1S2qj3bGC58D5LaGJgylDQXtdH4Wb4rhsajc=;
        b=Ckz9ueiBIcFESTuWiFD3rRh52HHci5LAQvB6/SrgMQSlDLu6leOur2EnL/t1POIzfV
         K8lo4+D1EkxSpzlpBmuqHvh8ge0JVl/5fIXnOqpe3uTnALGGgWElp5g/fM0VNFztm5Dw
         xHTtNFek6kDbsI0kvSUxeh7nY8jpZ9Tzgcy8BVuI0Bewf9cd6Z7A+Zt35VuIiDgrL/S4
         4qKC93oY4mOqkGmcQjwMBLm9obub8eV/4NNcwGC/LzCm8y0PRrdGva2/3OuZKKZP6PFz
         5lo6TKfNZdiJ2ENcY+k9Bxs/xusl5JCUEAlmOCMz0wq+s5lZZOLRLv880MUoHvsmf1dV
         7rhw==
X-Forwarded-Encrypted: i=1; AJvYcCW3vzdXCq3ya1ViPieRsQHcKjIzWCkUnsE835OmkiIok61rEwn1NCHWxoDXR1lFr1hwfQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS8Tbi9icd370bJ5c2rXlJ0kzRrrLuLh4OgONCIiWpjsRaAnEm
	32PQ1Gr2rR08gegUkcPddjPsI6B/kGML44nIC+3JH082UPAUnSJPanN2ol2VPISDVgNMxVP67pw
	GjmaiExRy8PB4wcq18u2o8JozYAE=
X-Google-Smtp-Source: AGHT+IF1TvSaF/KM6DF1at2kaf3pp+an2OpxAhkNVPzdtu4KvEFT8Av9CkbJxngsOnsDwRFjPBtU9kg8n1c32nSO8xo=
X-Received: by 2002:a05:6602:6405:b0:83b:2da6:239a with SMTP id
 ca18e2360f4ac-83e6c157bafmr150156439f.15.1731642081563; Thu, 14 Nov 2024
 19:41:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1824.git.1731610074707.gitgitgadget@gmail.com>
 <xmqqzfm149sv.fsf@gitster.g> <xmqqv7wp483v.fsf@gitster.g>
In-Reply-To: <xmqqv7wp483v.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 14 Nov 2024 19:41:00 -0800
Message-ID: <CABPp-BGOLfeUn6H3cdeMf5tZ1gswoaR51J+PDhMB4akR3jG+LA@mail.gmail.com>
Subject: Re: [PATCH] fast-import: avoid making replace refs point to themselves
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 5:08=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > I am not sure if a warning is even warranted.  If you decide to
> > replace an object A with the same object A, the result ought to be a
> > no-op.

Do you mean that the result ought to be that there is no replacement?
If so, I agree, but that's not always equivalent to a no-op...

> >  I wonder if it is makes more sense to
> >
> >  (1) do this unconditionally and silently, and
> >  (2) when we prepare the replace_map, ignore self-referencing ones.
> >
> > instead.  If (2) makes sense entirely depends on the answer of an
> > earlier question (i.e. "is there a reason why self-reference is more
> > common than general loop?").
>
> Forgot to add.  (1) could be done even at a lower layer, i.e. the
> ref API could be told to reject such a replace ref creation/update
> that maps an object name to itself.

Perhaps rejecting the creation or update of a replace ref would make
sense at a lower level, but a no-op isn't what I want here -- it'd
just result in a different bug.  In particular, note that my patch
modifies fast-import to issue a delete where it would otherwise issue
an update instead of merely rejecting the update.  If the repository
had a value for the replace ref before fast-import was run, and the
replace ref was explicitly named in the fast-import stream, I don't
want the replace ref to be left with a pre-fast-import value.
