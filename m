Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD34E81720
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751037493; cv=none; b=PYux7p/YrcHN2LH7zcxHmkZN8/PlPnE+zoipWxYz3PbwXd3p1Kq0fkq3Lo5L5bj7jF+50Pu4xh/7imVbGI2gh3IB/VikbsBkMTVJHvDmzPF2Lr7xC5APx/0EhDhbKeNEaegUZ44WbH8EyroO47A+cdjC7FFoFpTUFz3SfyvLIv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751037493; c=relaxed/simple;
	bh=PrqYIF3kC45X1TJnIUcRv6o2lWM9VWFvFR18lGVgfvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXibWMdS7tjBpVWNvWyHaEs04qoaGNNBW0xKIM4J+s+r9J5pNzGZLp4MYduh3ZbjcUILg6E6ji+ZD95TUoBZtJCWV8zTDHJinl2mRgwDmxIUc0VYkHoL7HKKzXjm+SQID0hnUcOi1eAuMzZZlnzgTmHQ/e+tAdnHAeSxrfzDwqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PI16WaIU; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI16WaIU"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-40aa391ce1aso731549b6e.2
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 08:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751037490; x=1751642290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qK2A0uWHT4yWb5HJmgb7hx7bpTHsxp3Zb2Bp5jnqoSc=;
        b=PI16WaIUfPR12aQrMrFUYpX8WMGUanRCKdP4PFpTT7m8HcnXQEs0X9akcdDDNxgLZk
         kwgzOXVyROGrOzZ6H81LY//plOSEJO/BgUhTzmcqYKanTTm+PgBUrmB+UPyDDQq5wZAf
         /heJeYmdSpXaIAL/B42VFQNK1IcucFzQPLKm3xNFYVldDbIkx0Yc1K4m10Pdcvt4+ADG
         uT3Bc5llZVjSAjpfWeSWxKFbMi3KkqSiUwqzYhkrHHGtB8F8Zk1uri7CkjJ/F37cyQNO
         b4FF43v4YyuFsep1QASuvVAHZetVtDoa1U+ocBfLvw1zh6aTUcKFoOMpN++6IbOPKRet
         Hhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751037490; x=1751642290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qK2A0uWHT4yWb5HJmgb7hx7bpTHsxp3Zb2Bp5jnqoSc=;
        b=l57DN+rhRAjqzOtZcHBDlm/Culto7KwbmltlNdr4B4lyFNHJXsS9UXVCFBEOE9Kwnd
         SsKu0EshWJ/rt2Pq1kfaXF5/BZO0JWjh0DRTuaqd7GMVAL2EzgHeJ0iqHn29HsG3mo4R
         vdsb+nmTBntUjsa3848h+y1T59osgsSKYxLocFdP6sareDkPxT1gdFE9jEBeItZJKnnd
         08HXeT18jDLfmE3WR5DxMn5MUcaHFZheb3MjMxkOjDefJEe0V4qTsknXQYDIN8vuEtVV
         3ir4uxvZcuc+YET7wtlTtNNGuy2+WuHv5hBiTykw6loWEOzLOcQGr9C6KqQyirHcyvDa
         Sg0w==
X-Gm-Message-State: AOJu0YyuY0BNsgbzda/OYsWo3n8Z3p7kZBCU3YavDs4WrDUTuitZuQ6h
	VAMXrwFpwXuh75fsioC9OrfRuuzo3LmFisWDzbnursHMyM1PCahJl7etadXFRw==
X-Gm-Gg: ASbGncv7VbozWC580oi6IgF+j7vv5n3NEMYWsmXTI5b2Y5Saa9o2FxDcxcmdL6lz4S6
	PO2G/d1huSmYv5KM+j8RfxXFpxF4g4XkuF3dhSfQKk1TYTrP2cx5UNLPaqk3/tiMBrxO3GMFSyB
	OzKUZfi3lqLbsrvyInS+wh9s04YrZZeZM4V8JqogxXGbQUcWOJSL8KQ3KsFjFnFXujbUbWhIdyn
	I2qqC89DwyQa9C6vtI+Hn9Y1zj0oXRbn1xYxlVIksLMMjQLSGzPQrCuWFkZYQht/brCTxtPdErB
	AEr98wgbMOyU27kI9oP2kmycTvLmmv1FjI6M6QlqA2qc1fIBKRwxRAg=
X-Google-Smtp-Source: AGHT+IFD+wnLn3X0eLIa2aapmlOC0NTTa1cAJSPfPrHWV5xD3nXs1qnWeSUphsJ0ixKMvzBa/WVzuQ==
X-Received: by 2002:a05:6808:4f54:b0:404:764:f7b6 with SMTP id 5614622812f47-40b33c469c7mr3255634b6e.9.1751037489673;
        Fri, 27 Jun 2025 08:18:09 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-40b441e2ef4sm59894b6e.26.2025.06.27.08.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:18:09 -0700 (PDT)
Date: Fri, 27 Jun 2025 10:12:43 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/4] editorconfig: set maximum line length to 120
 characters
Message-ID: <4xcovwt5f2garsngqtzzcrn7755in4xkq6zxxk5smeo4d2vfp4@l7cqb2lizf65>
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
 <20250625-525-make-clang-format-more-robust-v1-1-67a49ecc2fd5@gmail.com>
 <qxewasf6rxt6mnbwvfhxarcbvfsn6cnc2jskpddsb5fhxfhpwq@5d727iud7wfp>
 <CAOLa=ZR_ZhjxYgN4pZsjOuC52PZjGMCzLJVZbwGQb=Q9W-0HSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZR_ZhjxYgN4pZsjOuC52PZjGMCzLJVZbwGQb=Q9W-0HSQ@mail.gmail.com>

On 25/06/27 01:51AM, Karthik Nayak wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > On 25/06/25 06:43PM, Karthik Nayak wrote:
> >> As per 'Documentation/CodingGuidelines', we try to keep to at most 80
> >> characters per line. However, there are often certain cases where we
> >> extend this for the sake of readability.
> >>
> >> Add a maximum limit of 120 characters to the '.editorconfig'. This means
> >> that if an individual line exceeds 120 characters, the editor will wrap
> >> that line. This provides a lot wiggle room over the recommended 80
> >> character limit.
> >
> 
> Hello Justin,
> 
> > I frequently use the format operator in vim to reformat entire blocks of
> > text and it is commonly configured to use `max_line_length` from an
> > `.editorconfig` file to know when to wrap lines. Changing the value to
> > 120 would cause my editor to prefer 120 character lines when
> > reformatting, which I would personally not like.
> >
> 
> It would only wrap lines longer than 120 columns. Currently editorconfig
> doesn't wrap any line length. So we're essentially saying, any line
> above 120 is not something we want to accept and hence wrap. This
> doesn't mean that shorter lines will be combined together. Wouldn't this
> be better than the current situation?

When `max_line_length` is set in a ".editorconfig" file, in my vim
editor it overrides the `textwidth` configuration which was already set
to 80 by default. So changing to 120 would change line wrapping behavior
for me at least. I could disable using the ".editorconfig", but I would
prefer to avoid doing that :)

-Justin
