Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFE3194ACF
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727908301; cv=none; b=mr2aaZ1LVtiQ8onzyenZ6/2PRADXQtkDWMPJ+mho1W0E+VDlf0yNjPdxU2VnFBBpj0/cXmhcw4h6lgSdtFAwcoLHRNNx6nBysbQoy7s73EuIP7EBhfYvdKbiV2NW2uhLxbGGmG6x6QIn5sN+vJ4ynDI8H8EOKPdHAPmKo8cyYNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727908301; c=relaxed/simple;
	bh=iiaxPmHC8ULz0b1qVfyMtGPua0zdj6JSTBu4jbDlstw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0Fnjs/Cmnn6zWzc0VP8/+tnqnx+jFp4/ylUw2Z2VBQLEcxeefF2ANdURCGFJzHqLxuQUvSqolej1afHGyUmTw6HRxPk4Lzbe4chkUv6R4uLgnTEDg6358Mzzj4GOsJLONlbzBB5wMutZMPZ7IgXkc1QVtyX4S3tQanhUjsSd5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wyaEiouj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wyaEiouj"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b4a090f3eso36985ad.1
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 15:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727908299; x=1728513099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LK/+BZrWsn8MrbbgQGXNGGnpovw/WMDKvpNYKKiD5+4=;
        b=wyaEioujxnOQVK0XU0f6FgWCPQv87Hd2VJ1+TzdwJzfIiIN2tbxpWuxGKXI7kTVSeQ
         qPQ/73CoRdDA5E0KbUZFgdWzgl+MyW40wv4SJxx1qsg+qaAoJjnwSRqM5HWScgDYt4BV
         DNEUpKczEnaxhwGd/uWJ6otlp+flUmTN7wxU/GyM5JUTpLWyN2Mu1zeg2KMlap2Rvt12
         e5UmC/qmENMniFvCiVU59DAMk1ReWWF573UglJzsBcsRV9PSc4ccB63V/aAtfCSeWj0b
         AASrlQvvJY4k8uR6WBnRBPbDbHZw/3DtnewJt92kSo3Cwo/TMp/aLRwla/8CoFENNWMu
         3s4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727908299; x=1728513099;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LK/+BZrWsn8MrbbgQGXNGGnpovw/WMDKvpNYKKiD5+4=;
        b=YNuAMmtPkar6T4qp0R0IN3Sew3IGf5DhW7GM5GnwdWo9tZkFqZe/w4mgr/ebERTkj/
         zbhPeTGUowbDkQ9Cnkn58eQ0i47ggfFITRuOb3PKN20b3QWBUq6xDnSZ8qoyk5hnBlb3
         IqJyJ9pM7IPFP6KMMK9XUr1N7gSf7Jt1Ia3MrUGF45Gj7WyGla2xokzaKOXmwQIAxvB8
         JlqwAyAhushSQZi+o3fJMQ+yglsGtOqfGBHUhVROcrdv/Gx0E6yLIH0dtG/IUT33ffL1
         +w6thGuJHXYtd3lfMtbMSzQwhWHg7XojHlw5t7exSFY/VP5Da2VzxCT67C53t3M1nEHL
         +R/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUztk1bEfMuDo5oepl8ZrpJBYP7hy65TNopJFrQibG1XttnNKjNYwXb9tyPX5GZrtBx4Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBiuDqp5LmkA1tZJWuZXu9e9PWJkMFgoPYyHtoUcPncK5jHiF0
	SRnkM5NpZBIQcP728SaJfQCbxILu92rwJ7JZDZK/IjihF8wYnb2DFFI/CZT52w==
X-Google-Smtp-Source: AGHT+IFuYHapxh3bvc4NdFDLbwZVKriJjgyG5oNtr+tseDLV12DQNTasSXtP8MpCKqknsl5+FYqr2w==
X-Received: by 2002:a17:902:f948:b0:20b:5e34:1850 with SMTP id d9443c01a7336-20be767be0bmr430245ad.23.1727908299052;
        Wed, 02 Oct 2024 15:31:39 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:2dd:9410:f675:e07f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e61c4csm88920155ad.274.2024.10.02.15.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:31:38 -0700 (PDT)
Date: Wed, 2 Oct 2024 15:31:33 -0700
From: Josh Steadmon <steadmon@google.com>
To: phillip.wood@dunelm.org.uk
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
Subject: Re: [PATCH v2 5/5] cgit: add higher-level cgit crate
Message-ID: <sh6cwo4uzgp5bvlctmdkhwhjum2zc36cpe74ygy725nr3invxe@z6ee2shr4cf3>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	phillip.wood@dunelm.org.uk, Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
References: <20240821184605.341205-1-calvinwan@google.com>
 <9c6d8fea-997e-49d5-9195-e1721a750a36@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c6d8fea-997e-49d5-9195-e1721a750a36@gmail.com>

On 2024.08.22 10:12, Phillip Wood wrote:
> Hi Calvin
> 
> On 21/08/2024 19:46, Calvin Wan wrote:
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> >
> > > before the function declarations. As I said in my comments on the last
> > > patch I think we'd be better to namespace our types as well as our
> > > functions in this library layer so this can be resued by other language
> > > bindings.
> > 
> > Are you suggesting something like "#define libgit_config_set
> > config_set"? I wouldn't be comfortable renaming config_set in git.git
> > just yet until config/config_set can be a standalone library by itself.
> 
> I was suggesting[1] adding
> 
>     struct libgit_configset {
> 	    struct config_set set;
>     };
> 
> to public_symbol_export.c and rewriting the wrappers in that file to use
> this struct e.g.
> 
>     int libgit_configset_get_int(struct libgit_configset *cs,
> 				 const char *key, int *dest)
>     {
> 	    return git_configset_get_int(&cs.set, key, dest);
>     }
> 
> In public_symbol_export.h we'd then have
> 
>     struct libgit_configset;
> 
>     int libgit_configset_get_int(struct libgit_configset *,
> 				 const char *, int *);
> 
> If we want the symbol exports to be useful outside of the rust bindings I
> think we need to namespace our types as well as our functions.
> 
> [1]
> https://lore.kernel.org/git/5720d5b9-a850-4024-a1fd-54acc6b15a74@gmail.com
> 
> > > > +    pub fn get_str(&mut self, key: &str) -> Option<CString> {
> > > 
> > > If we're adding an ergonomic api then having return CString isn't ideal.
> > > I think the equivalent function in libgit2-rs has variants that return a
> > > String which is convinent if the caller is expecting utf8 values or
> > > Vec<u8> for non-utf8 values.
> > 
> > Having both get_cstr() and get_str() makes sense to me.
> 
> Just to be clear get_cstr() would return Vec<u8>? I'm far from a rust expert
> but my understanding was that crates that wrap C libraries generally avoid
> using CString in their API.
> 
> Best Wishes
> 
> Phillip

Yeah let's just go with "get_string()" and return an Option<String>.
