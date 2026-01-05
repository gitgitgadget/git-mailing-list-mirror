Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B621E412A
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 05:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767592707; cv=none; b=QPRN7YSVMRCfOdf5pFWLz8gSVwQrxMgQ0eBSXCf3zO9nmqv4nmZbAvysx8yLGXhZHq/7EBB16xat/psx7EyOemCkdF2E431UAIJn5NDi3XIVK5QDdlKSIVrLoljg8wcoQj3SjpweG45vYWu6YlB/31C2xrsIdPDy5MnPobN4KHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767592707; c=relaxed/simple;
	bh=ccGx/WNQv8Lu5m+XdC9SaSX+zQOVQS0TUY+t2JuVImg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3YbnB3H7MY6nXR/hJfPdPhZXZrISGAO+gpKFn19JD920ULJV8CecDWDgwNZx1/g6GkUOpzOwIHDBX8YYDSOR5g62pDlNQvB9Qq8paooNd4wTq6YQmBCq9jdqs0O7ptMAm5M/xinb6iPX7ez2A3ZndkSHirBtZ/yZvCROFX5nV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJwFPguJ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJwFPguJ"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bd1b0e2c1eeso10434168a12.0
        for <git@vger.kernel.org>; Sun, 04 Jan 2026 21:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767592705; x=1768197505; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IoUe7+KaRGih3wJ2JJu/mLFUsG46CjTSVYUZTi0dnfI=;
        b=LJwFPguJ2xpSavq9/lBw7hmBLeBk25SATvxe1bHKohahD24pGy6JQqm1qvFyF/++ic
         0i/6UZuThfAz2Dx3Qbe3LkiSZzf1y/vmZxhtApqhKHq/dpcwNfCS/uKyCWXlpmKQ4muU
         xAy6IlFeSmbZrVDFxiSB0K0x0yt1NFvMLKrSeGISuotHHkJemER9TuZdhdPV5PCj4OLw
         pCQXbZkBZaoWGgk58PO7CLWAZQEACs5jhqPnOIsQuLGUzrwb7Zw6xM1mTQecyIl60VYZ
         tXZUDLIT51weW+G7Hd09uFII+fvw9LScCuKfnN6tbHJ+1v1qFWa72M2tMiWxNbtahyuR
         /SeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767592705; x=1768197505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoUe7+KaRGih3wJ2JJu/mLFUsG46CjTSVYUZTi0dnfI=;
        b=TcopkomUqW4QvpvSlWbsPFQgxGe+mLSPvsqHyGcf6k38Djru7ucYST4+ueawhqUSzw
         r79nlAjEE9PqAr+BVnVtliVTVRHwZBFZOGPQFh21cBUUKXYDfnxutpNIDp3sfu75nBpi
         7jsPnHR6JWzgPQhZJ9ZlkCQeFAovU8ElTNjp8h1cguVZ6WnlBlpyAbiY9pU4DDjkU0mj
         2aXEgMPxs3yecasF8JrlHd7VN5Apob79/vxRChbWFvqHNG5DSiJ8NQE2oSYP2ze3ao/j
         iKQvWfYM3DAu16Z+Cdt+QsJbgg+59pdQZ85BR9LbSiOaMkrUSccKHhyDBy+ZxcTjjvvd
         MT3g==
X-Gm-Message-State: AOJu0Yzut/CkHKPsLxYkCmv9RSrEIhP27oPtdJBmLaEDasMpCQZW5LCx
	qFXkTLOOW4P1IR0lXJo8UTdCXyGUBa2YfwGCNdHqLhyZA/fx1J3x0YzM19KyVv9ySH2+sHgDxZu
	a0QBLfUdSksX5vCCM3bgXOVGr7rt2eQjZ0Oz3hPE=
X-Gm-Gg: AY/fxX4LietFKXCsvwaCHOGYk5aTtpjXVeLtAdD6N7Md3oo26jS1GGYCVHmr/3hsUzF
	QMmf/pXCl5JstzqOaim5CBDfQBJ2Uasaftf1w+FMg9B54tbUueVqNtAXP+KIfV9TlGEdH2b83ZD
	QWjEPmGzRkaoioCY3AReuqrf04hr5Be1+zCMIBQ+5tejtgO+Cmhmgt71LiDGEACsXuLK1M3K3Fm
	ngyChSgZS1RHAH6x5WoqJ9ONT46Ox48e61i9AB3FoVd3lilLVaRhEactnMt3PMSfqWVydn36513
	yJIkJ7gpQmk05sNimoMmromnc+lvvdG3ttzIaP/pmuNVcBMbzGmQuQCYeFxV8hVQz4mVP7W+
X-Google-Smtp-Source: AGHT+IEqpqRNNTLecjzQ6LJhcLB6UML3vtjEg1IlTG7SZvAArF1yPaCM46i14+R2ugq6kDzVkuzk0+bLYoazf+lXbP8=
X-Received: by 2002:a05:7301:fd86:b0:2ae:55f0:f2be with SMTP id
 5a478bee46e88-2b05ec481c1mr40481641eec.31.1767592704753; Sun, 04 Jan 2026
 21:58:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229185737.2328-1-deveshigurgaon@gmail.com> <xmqqjyy2dvni.fsf@gitster.g>
In-Reply-To: <xmqqjyy2dvni.fsf@gitster.g>
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Date: Mon, 5 Jan 2026 11:28:11 +0530
X-Gm-Features: AQt7F2pz-LEYK1KHRLcC2-bQdYI7H_UNmIGJ1UNQDZeX9rIdO_6TlakZ-NaOhTU
Message-ID: <CAG7UgEQeOJq0S87btjy8TT9as10bCAJWKEUTfNafa811iM8qwA@mail.gmail.com>
Subject: Re: [PATCH] [GSoC] t5403: use test_path_is_file instead of test -f
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Replace 'test -f' with the test_path_is_file in
> > t5403-post-checkout-hook.sh. This helper provides better error
> > messages when tests fail, making it easier to debug issues.
>
> All true, so I'll queue the patch.  Thanks.
>
> A #leftoverbit is to think about what this test checks, if it
> makes sense, and if we can do better.  The expected outcome of this
> clone is stable, so the input fed to the hook should also be stable.
> With the same brain-cycle to write a test that checks the existence
> of the output file (i.e., proving that the hook was run), we should
> be able to concoct a test that validates the contents of the output.
>
Hi Junio, thanks for the feedback and suggestion!
I read in githooks.adoc that for clone, the post-checkout hook gets
the null-ref as the first parameter, the new HEAD as second, and
flag=1 as third.
Looking at the other tests in t5403, they read the three arguments
from post-checkout.args and then validate them.

I can update the clone test to follow the same pattern as the other tests:
read old new flag <clone3/.git/post-checkout.args &&
test "$old" = $(test_oid zero) &&
test "$new" = $(git rev-parse HEAD) &&
test "$flag" = 1

Does this sound reasonable?

Thanks,
Deveshi
> > Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
> > ---
> >  t/t5403-post-checkout-hook.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
> > index 978f240cda..1462e3365b 100755
> > --- a/t/t5403-post-checkout-hook.sh
> > +++ b/t/t5403-post-checkout-hook.sh
> > @@ -109,7 +109,7 @@ test_expect_success 'post-checkout hook is triggered by clone' '
> >       echo "$@" >"$GIT_DIR/post-checkout.args"
> >       EOF
> >       git clone --template=templates . clone3 &&
> > -     test -f clone3/.git/post-checkout.args
> > +     test_path_is_file clone3/.git/post-checkout.args
> >  '
> >
> >  test_done
