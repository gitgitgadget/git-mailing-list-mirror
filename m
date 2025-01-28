Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B8C13632B
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738096026; cv=none; b=QlxInKx9X3b57J+CaSyZIfSCzzT2njTD6ePUwJZe3/6jV64JExBFCyt/aSoBXQP08kxIcTyCAUlGkK3hpciH4sNLsofaLsh4XLpworHmD3G6E3cT7fSN2Wxt/CJYe3KpUFIUPxkhT7rfszL7jXd+HXVEWS62x97qWgmOVsshrO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738096026; c=relaxed/simple;
	bh=ay9+fgD+p53iOY1fMf7Po3x1gX9BHA/gRMg9rFoss+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o56LAkCF6v4c2EiR3D28vKM2H79k2OTbOCpirJcKc8/CKCHm3vc+AaSalRH1ynO1Sw0Z7bBJvrIcRy1fXTEPnxtf7tmTwkGQt/++qst3Yfh20bK3GPuOL7WBZBtpG/zxU7AUfdj2eWHRgv1M2LNabYevaJaRsGaPigYPwcrcmhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uOn6tWrJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uOn6tWrJ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215740b7fb8so215505ad.0
        for <git@vger.kernel.org>; Tue, 28 Jan 2025 12:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738096024; x=1738700824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qm0YPI+p+oxvRRmsT3njxEpFFe2XMUolq4nwPr3zzPo=;
        b=uOn6tWrJn8ao3fWrciiMxQQtxNRzqZ1r36ujzWBtx5g75PVlJ0qjaQbc7eINoJ2fhy
         fUeb9pCnTh6lJSzNMXSvQZb0rW4Bbh30d2dsdpImt/1gS6x+xtfYT3o40YHlp6joiubJ
         hfuJDxdtVNtl2zBwDNCph13HOyny/Gdz8GkjoMs8vvBgH5AU8yhwN3OODbpJnhhczKZ4
         U5krBd5Z5RzDwanE6V8K/piQoKPcJGreuUFYEw8t2rwm0L8SUGtB7YSLvOWRt7L9frGG
         YRbzjG8LwJIuv7mgIeK2APzX/Jo69hOL7l1IYYuuJaHOQPNmKcRhIlGUUBseXYB+mFqa
         36Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738096024; x=1738700824;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qm0YPI+p+oxvRRmsT3njxEpFFe2XMUolq4nwPr3zzPo=;
        b=K1AmAmoLGIOEwyK0BbyvyBA1Fln3X2PaEdD65YNR4bWnlpGhxFR72OnA5KQaRTcZWr
         4EIzzJ9k+MkF3vEoiwshLKGjMhcJq9CDlKX+BtZpmA7sSKPK+CIPcu598LuDmVu7ocVU
         NdL3g7xfiDIYsnALqIRKBWXRQLyqRzCK1QGE4lwASmwpkQzGYkZ8oySjZ2gveqhn9khy
         pao2tCzbpKS0wIfoEfdcO7i0fLTJXPHJWH86bcSDhWQQbTMoVM0tuYoyl88mLiB2icS/
         sxbMvHdG6LropQcYy8jtW1lWv/zVLWvlnQOPuaO9fQDf6KSu/UzAirFuGi5DD2Ejyj3/
         euYg==
X-Gm-Message-State: AOJu0Yy1BvWLa8XpIJH+oIrc85ZmlRonpRn3m3i4ER33wbFHMQlFxBUA
	rvLe9I3cmdrfPbYG1z/lZM35PuGmsgXjB+KMmz2tpXPYN/zhTRPxaQ6+mVMYlg==
X-Gm-Gg: ASbGncs3K4+hFmjQAHew7MdnMy1Lk6OLx+puDsN47gAjq+xONc4G/QaxkE7ndUWWuvO
	6+cn+mOsjRFjhnocQcVLYf9ZXYQUe3HjU5Lip/C8RamslU3m8CajwoxwT/MFMczyYMirYF77BPo
	LZp1tACxEUeZ78+3zHylSFRiURzzULxDdGQWsKeB8T2X1MkGqiUs8Ljif1/6IJukSx8AZJ2sV8h
	v81KeN5+d8FoH+RihLrFbYGLNK+vGqEa2KpfdWW6ahNihBylHoV3vJLGYQs38Chle/grvxb1ss0
	5SVqA4l0CRsXVA==
X-Google-Smtp-Source: AGHT+IEPB/0IvIJFGBnlywyHdq9W2yUnwsNpLgDbyMsyuMG1PHPzn8QTfGzVhkjXAaIjS+/H/F3gGQ==
X-Received: by 2002:a17:902:ccc6:b0:215:7ced:9d67 with SMTP id d9443c01a7336-21dd8072b9cmr369735ad.24.1738096023808;
        Tue, 28 Jan 2025 12:27:03 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:ad31:b9eb:e4cd:2ffc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a77c851sm9968702b3a.137.2025.01.28.12.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 12:27:02 -0800 (PST)
Date: Tue, 28 Jan 2025 12:26:58 -0800
From: Josh Steadmon <steadmon@google.com>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, calvinwan@google.com, nasamuffin@google.com, 
	emrass@google.com, gitster@pobox.com, sandals@crustytoothpaste.net, ps@pks.im
Subject: Re: [PATCH v7 2/4] libgit-sys: introduce Rust wrapper for libgit.a
Message-ID: <ghkzloozvlb2hx5jxiqjydifppwu5m46rotjqirtedmyqowngv@w3rehiaqhskr>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	phillip.wood@dunelm.org.uk, git@vger.kernel.org, calvinwan@google.com, nasamuffin@google.com, 
	emrass@google.com, gitster@pobox.com, sandals@crustytoothpaste.net, ps@pks.im
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1738023208.git.steadmon@google.com>
 <f1502b85901d81889d86597f31eca40e1965d56f.1738023208.git.steadmon@google.com>
 <3559a70c-7ed3-41cd-a45f-390134218c52@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3559a70c-7ed3-41cd-a45f-390134218c52@gmail.com>

On 2025.01.28 15:08, Phillip Wood wrote:
> 
> 
> On 28/01/2025 00:19, Josh Steadmon wrote:
> > Introduce libgit-sys, a Rust wrapper crate that allows Rust code to call
> > functions in libgit.a. This initial patch defines build rules and an
> > interface that exposes user agent string getter functions as a proof of
> > concept. This library can be tested with `cargo test`.
> 
> It's great to see some tests. This is looking good, I've left a couple of
> small comments below.
> 
> > +contrib/libgit-sys/partial_symbol_export.o: contrib/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
> > +	$(LD) -r $^ -o $@
> 
> This is a very long line and the ones below are pretty long - perhaps we
> could put the list of sources in a variable?

Done for V8.


> > +contrib/libgit-sys/hidden_symbol_export.o: contrib/libgit-sys/partial_symbol_export.o
> > +	$(OBJCOPY) --localize-hidden $^ $@
> > +
> > +contrib/libgit-sys/libgitpub.a: contrib/libgit-sys/hidden_symbol_export.o
> > +	$(AR) $(ARFLAGS) $@ $^
> > [...]
> > diff --git a/contrib/libgit-sys/public_symbol_export.c b/contrib/libgit-sys/public_symbol_export.c
> > new file mode 100644
> > index 0000000000..cd1602206e
> > --- /dev/null
> > +++ b/contrib/libgit-sys/public_symbol_export.c
> > @@ -0,0 +1,22 @@
> > +/* Shim to publicly export Git symbols. These must be renamed so that the
> 
> Style: Multiline comments start with an empty "/*" so this should be
> 
> /*
>  * Shim ...

Whoops, fixed, thanks.
