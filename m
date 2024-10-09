Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662332119
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728508895; cv=none; b=Jcmbiwh71bfH+vekF+aePAc9+72yy/wWKLVBKvX7ku3ufgViU40C5v1XPI8uy+sPE1Uu4OHm9QlxQBKkEH4zfNCd/8wBeJxUpVG2qbF62cFtQ/AeFLebGiFmKhZQQpCd1JOKzNJeN6dr6nC1S8hfMrqTgseMrpnFvmoGkSuYvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728508895; c=relaxed/simple;
	bh=Fr6uG4bRQStHOyoSQbeg3wxQmYO+ZLRAP4Q+vWRxmMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfrIIt7NhYf9xCB+TwniJuMGq4rwUuNn2tNNsEYOXDBFb/oKGcilI2xQAbg4CzxZllsdYdPBTBor3NkbaTdf2sOsP/+pwcoG7ixrlxdgLbeLl1xj5CHEtSJxK08iOY/4mX0a0ADy06b2FPZHqdcBj3PPD4pZQCyh7wFCd/vexdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dUcf34lt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dUcf34lt"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b061b7299so21635ad.1
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 14:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728508894; x=1729113694; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4l3jeqnJ9A9isjYn1d+AK/rKHYhy0MPhOvdNzV/y0gA=;
        b=dUcf34ltWcEAzIAJ31/j4Io7ukOdGGFC8kcVbIojzfks6MNTv7v50gEpVRiuhm7sKT
         93Mrr+F12KRIlGhTf/AMrVb/EpaonTz68f4czd/jTb321MjKS8kZMt6MLvaznjnE5uNJ
         OZcOcH2+C9nM4xKjBAoJ9GRFvLmJbmJUqGthha0SWXRe8sZQeJj/+wPZ5Z1+31NjETrq
         TPA7kJBguYVi+FWkvBqjhbLNKTwUu3jHwsOa7KUQQtddYW5COr8ic3lC5quwgoGqjYBB
         7nqNjmv+1+pp/DpAwxL6gPdNoy693AnS+jVgWVIqLn/4qAFbcLF5YZa0nLpt74wHEY0o
         DMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728508894; x=1729113694;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4l3jeqnJ9A9isjYn1d+AK/rKHYhy0MPhOvdNzV/y0gA=;
        b=k+VJlTGvygc6Vh9K0Ip/kITrKvzpU/A+V5gpzOnZ7zPgpqk5Lq+gGCUuUMs/ZmcZQu
         OYVhbSCrWMCO/ARArj68UjZ3pS4q2GhC7xDUTdOUH9Lyv4iGbzfpC8DWoz6vzl08hrKY
         2IWGtzLqajiL9Br6nWJZaHtcQ5CWLDUiNJY+1+AOXny2qnySyaiAVW6FPLKiwOHORSZ4
         0is5kVNyF74uVQGaNf/XRln+4LCapkoT9YJmwZNlu07oKPKsXymEA/xyn8h87lPqdtk8
         /woO/TuKiETzADo/a7S6A+I0mLcvwF1pBIURvuQSaPtPrenM+hNloQJssSO7arwQMWNs
         krgw==
X-Gm-Message-State: AOJu0YyeFQRKt0cMP2/Nrp0R31Qk39zp8HJCW8OFI34XZCSVniYUui8l
	T2pR5TNKm2ILCjhHHJ6eHFig1Uu7b5zPW9AvPHf62D77ogPAgBH5eNBmSCUzDA==
X-Google-Smtp-Source: AGHT+IFASCOWz+iO4R/b1UrHJDjtBMKHZ9Nc1gogVGlk0aiAP5GRLgppk2bH62l4HXaznPJHlcmqDQ==
X-Received: by 2002:a17:902:db06:b0:20b:5046:376 with SMTP id d9443c01a7336-20c8718ce13mr265685ad.1.1728508893499;
        Wed, 09 Oct 2024 14:21:33 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:4268:1c66:e2c:2ffb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d65246sm8187519b3a.169.2024.10.09.14.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 14:21:32 -0700 (PDT)
Date: Wed, 9 Oct 2024 14:21:28 -0700
From: Josh Steadmon <steadmon@google.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, gitster@pobox.com, mh@glandium.org, 
	sandals@crustytoothpaste.net, ps@pks.im, phillip.wood123@gmail.com, allred.sean@gmail.com
Subject: Re: [PATCH v4 4/5] libgit: add higher-level libgit crate
Message-ID: <qxlotenjjgmoal7qnxiutxknrcf4sa7mgwxcepya3luuilxdhq@c3qqr7uftz3u>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, gitster@pobox.com, mh@glandium.org, 
	sandals@crustytoothpaste.net, ps@pks.im, phillip.wood123@gmail.com, allred.sean@gmail.com
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1728429158.git.steadmon@google.com>
 <29599e9c7be1737bcf0de0541c9635212a1b691d.1728429158.git.steadmon@google.com>
 <CAPig+cQEE=rOxb49rHHY5sDvSFm4+nU6RdFgXmQyt8EhMpFMLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQEE=rOxb49rHHY5sDvSFm4+nU6RdFgXmQyt8EhMpFMLg@mail.gmail.com>

On 2024.10.09 02:18, Eric Sunshine wrote:
> On Tue, Oct 8, 2024 at 7:19 PM Josh Steadmon <steadmon@google.com> wrote:
> > Wrap `struct config_set` and a few of its associated functions in
> > libgit-sys. Also introduce a higher-level "libgit" crate which provides
> > a more Rust-friendly interface to config_set structs.
> >
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> > diff --git a/contrib/libgit-rs/src/lib.rs b/contrib/libgit-rs/src/lib.rs
> > @@ -0,0 +1,95 @@
> > +pub struct ConfigSet(*mut libgit_config_set);
> > +impl ConfigSet {
> > +    pub fn get_int(&mut self, key: &str) -> Option<c_int> {
> > +        let key = CString::new(key).expect("Couldn't convert to CString");
> > +        let mut val: c_int = 0;
> > +        unsafe {
> > +            if libgit_configset_get_int(self.0, key.as_ptr(), &mut val as *mut c_int) != 0 {
> > +                return None;
> > +            }
> > +        }
> > +        Some(val)
> > +    }
> 
> Considering that v4 finally gets around to swapping out `CString` for
> `String` in order to make this high-level crate more
> Rust-programmer-friendly, I was more than a little surprised to see
> that this function is still exposing `c_int` rather than, say, `i64`
> or such.

Yes, definitely an oversight. I'll fix in V5.
