Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8955349B10
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770226740; cv=none; b=oyBjfZbURvOubWeq3y8KSW9cCwxXXCk9x9Bn/QtiyYcA9/XMyUeA6YT10z+sVQMdirf/FfyvoolnPYf+nDlfk+7ygnnONOfCj+KkTJPRhCTXDFm5mB+0jIAYyyOw2mXvH4lNplOGBWl/1pdfnNHe6ri50XlXe2exPFiYNB7ACX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770226740; c=relaxed/simple;
	bh=5y2ot2GiXOjP/aoUcbak2VyWByp4WqXuz67tB3Odl+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoSKT9x05NdajuYKmgVvaywEYsBRll29jpOw/JnS1/K2TS6NCDXNd4uzYPBM920yxydJ0me6hA1BZ6w6FuCqHOzZ/oILJ00x6HBiXTjLUpuF9MVLSU0PDcBBfsHGXr1mIP/3fSDn1jUKuFrITvm/ijnocwH39PYFB+cWp9wAdWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2DZ21ut; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2DZ21ut"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-45f053b7b90so44176b6e.0
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 09:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770226738; x=1770831538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fsmJFKVxyoU6IdTuB7D7Ux4ksFVgFN/IRiIDwhbVjcg=;
        b=k2DZ21utrdIuYsKIxc/dcrtPLMIY2t8WufzwF8U0Zh0sqduEbckG0qHXwE1HQVnQU3
         rWAbtcMUjrobsr8VzOeinRy6j8HRFlpxM1xoTY1qljC3v/XRGAHufOAimaUmSNBLbaw9
         AUldEGIVjAFIZ/CY3EauWND72z6PQ2bytkPVCXDehCO7cJNRzvCS46GlGjyzr3dYCwzP
         znRp3JA4pVxJe3v7YPvXTjciA+RBqUqhpoHwS64QXEOUsrGpi5KYASzALSfGs4rzOZfb
         DfBGBpNZy5zlweTeoFI4sBUD5Yl/vP1jSgw3aSHDNTr/5hhFWEarsgIE90kC9vvQMrG3
         f0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770226738; x=1770831538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsmJFKVxyoU6IdTuB7D7Ux4ksFVgFN/IRiIDwhbVjcg=;
        b=D/jUSG/1J34q7yYaNce5BtrQFht/mUVmPJUtNqIGCRQYupOSkVqe0VdTx+cNwtVOGS
         wOqbIHScWpG/ctK4dWY+xlZQleY5HZqFxlnGETVW0r94weKEWDu5szPES/vl/Vq3qQjt
         Q75DvgRFIy7uFHqPsuMAfQ7q760JmLe7EFelKZBw1TaOqj99D8MqDhBqMEWOY9yKz8Dh
         moza/6n+iBmHms1XcDUvqGRg9ZcUasivLF7ZS9+ucP8YTlyUcukF2S3aAZHKFcGwEZF7
         Vq996yTPQTcjBVWA4QBDn/jAPXxoMTFEXL4fXw6kudjPo8Z57Ziy9z+ZNiiyXwynxqSr
         uJ6Q==
X-Gm-Message-State: AOJu0YwtlskJ28MZdXevldBI3PrCHEEOVHAtexdp/YpwUug+HYxXHFI7
	PlJalpvF7o3fcZZC4tjHqGRn+lv0qaO4l9KojicLDQsn15DDf5Y89uz77umYWA==
X-Gm-Gg: AZuq6aIplR781Sl7l43p5qPhtH37A4i+rQmpVP9n4QKd1zSryW67B0wQj+rYpC5HhK5
	rjbmQkTCBkXRpnVpXM+e30ObW4n/RwGlnd0moytm7vNzGTVl+XMG6jTvpqfxi1bs7M5JyaJYaSM
	V/M5wGuyQzJKAyNI8uwBShF4RxOEFP6cBQT7n1TFBgoY86xnlkV4VQdzDezdis4/u1J6/V5m4Lk
	x/Y/Jolmb9YC5/WU/b/uAg6yA3UBE4QegCd19xOtktNRw9SbHlY+5iPVluEyDEILpCXqWCJV4Mx
	XWz0weTYgPrHw80ZzmzyAjSkAP3YWBRnGu88GJAgAhusbH20nImWPORNTOlb7BBXi7wpSLVjrIe
	0bzyzLqiYappIZ1RXlQVsXf6tVLkuLNLYtghOdy+YUvCruT5uitnVe0VNwiC7vX11j97VrcoaHc
	0luUAR
X-Received: by 2002:a05:6808:1b22:b0:45e:e1e7:625d with SMTP id 5614622812f47-462d5a53edfmr1790901b6e.54.1770226738551;
        Wed, 04 Feb 2026 09:38:58 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462d66553adsm1678165b6e.6.2026.02.04.09.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 09:38:57 -0800 (PST)
Date: Wed, 4 Feb 2026 11:38:55 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com
Subject: Re: [PATCH v2 3/4] odb: prepare `struct odb_transaction` to become
 generic
Message-ID: <aYOCm3vzfDmnZhhu@denethor>
References: <20260128234519.2721179-1-jltobler@gmail.com>
 <20260203001002.2500198-1-jltobler@gmail.com>
 <20260203001002.2500198-4-jltobler@gmail.com>
 <CAOLa=ZRb1eVSD42Obr_m+3KUy0Bh=0XmOZt8ofrbzy4Mp8xfwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRb1eVSD42Obr_m+3KUy0Bh=0XmOZt8ofrbzy4Mp8xfwQ@mail.gmail.com>

On 26/02/04 02:31AM, Karthik Nayak wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> [snip]
> 
> > +
> > +/*
> > + * A transaction may be started for an object database prior to writing new
> > + * objects via odb_transaction_begin(). These objects are not committed until
> > + * odb_transaction_commit() is invoked. Only a single transaction may be pending
> > + * at a time.
> > + *
> > + * Each ODB source is expected to implement its own transaction handling.
> > + */
> >  struct odb_transaction;
> 
> Nit: Wouldn't it be nicer to just the below `struct odb_transaction`
> here and drop this line?

I assume you mean drop the typedef in favor of defining it directly in
the struct and thus removing the need for the forward declation. I kind
of like having a typedef for the function callback, but I don't feel too
strongly either way. I've ammended locally, but will hold off from
sending another version unless there is other feedback.

> > +typedef void (*odb_transaction_commit_fn)(struct odb_transaction *transaction);
> > +struct odb_transaction {
> > +	/* The ODB source the transaction is opened against. */
> > +	struct odb_source *source;
> > +
> > +	/* The ODB source specific callback invoked to commit a transaction. */
> > +	odb_transaction_commit_fn commit;
> > +};
> >
> >  /*
> >   * The object database encapsulates access to objects in a repository. It
> > --
> > 2.52.0.373.g68cb7f9e92
> 
> Just a question in general, is the idea to eventually also add support
> for {prepare, rollback} within odb transactions?

I'm not quite sure yet about "prepare", but certainly an "abort" or
"rollback" will be introduced in a followup series. This will be useful
as we expand ODB transaction usage to other operations that require the
ability to remove temporary objects such as remerge-diffs.

Thanks,
-Justin
