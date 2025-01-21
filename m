Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203E41F8698
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 23:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737501687; cv=none; b=nuxfMZdJCfMHXdtDhsp7S41b0yhDGatfFnUZ+NPIyFQoh4X4G47oKXxldWBGfoNaNIz8LYIBEopNb7xAJOdd70SL921sq8euzLVI6jROJ375fcN2KDdVgs+IiGrzaSwtE2N7zCp0rVsODBoXGQ1VGPpTzLRzuK7XSdQkU2ig1WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737501687; c=relaxed/simple;
	bh=oSj431eNmmsisr//K1H9O5fRkmDA8tvqGVXxErAMO74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOAZF1D45mcOmwCBZUhMBscyG43BHFvezA4Qz2KKCoih61Jc7PeRCylSWZeTu03c0FAiyg2ZMf6T6KPE8cv+kxCHvjmw+5fApakNw0kDdKj0IZAI/0utvmSQC2vxrIBix/ELNPCawODtoDz+J6c1Y9ZYVXWD4zyRQywGERMN32o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ji0KXscn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ji0KXscn"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-215740b7fb8so81765ad.0
        for <git@vger.kernel.org>; Tue, 21 Jan 2025 15:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737501685; x=1738106485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lq8Ww7uVxWcIUeCdsENaxra85R39Gyft30w1pU6mQso=;
        b=ji0KXscnZ6K4A3U2s4ui4CVMFZ0HBahQkHcnG/FqFMGeuu1x2HngeOe7eE4hyyM5uI
         2F7C0ijhV32tcyA6OcvHJA4/wY/0rFBHyDDWtQRAqgZr3ugpbGSibHIAKj710xP2sn7W
         uu0RL4EXRzrmMz29Vku5h9vDFaNDbsxwXDNHSYxopbCAz3jzXrQtdKkElQy4Czt/dOTV
         3U1/jl9NglPxy2MPfMJDnqWdn3TiYm44WOe0QU4VsFEsL3E7nqcjer0bQ7UwllMX9oHi
         OO68fUj1qYi70jZrJIKeNheYnU2ApvhVfqgbyhd5U19pjKr22KNhfba3tugQonSHqu0b
         o22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737501685; x=1738106485;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lq8Ww7uVxWcIUeCdsENaxra85R39Gyft30w1pU6mQso=;
        b=AjH58nJ1mYK5DqNsMD6NYz6G6yow4Kk56UIQ8nfUutyD5PZ6FJqYmtIaDjlRkxPQBz
         qMU7JRr/FY5X3AdDdQy4IBTWWkV//gkDXHHKaKwwuhoW2Ucbgmcqm0mAoA48BsweEjqn
         gyfUcpJnjD5sWjR3FslkxxjCVYLyMer1JFSVa/VFkbRupVLuOXjR6N51unExKSPHHgQC
         K6/J5DVu/jyhx21dxPzcI9CGvgznrTP/CmAuzD0w8HEdVXw4wiek4DoqgmdOkcjupW/Q
         GicEzYnP5MkcIQv+9XObw5FlyC/Wp7RC4mlVf0s9kFzNL57Msv7aEfygAOOckd0rnJQM
         Hd4A==
X-Forwarded-Encrypted: i=1; AJvYcCWTtOYF9Ezv+NLxzUOdXLCMb9c4D4rqBpXVOMs7Z3sM5ZrGPnOwx8Kks+EV9K+BfztFX8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOU1N8QEIX0S4eB3Fa/4pwHbU6wvnag1qgTmM2TT7d9btvUnb
	FViNmaW4Yui6J2hCTrmIisVn67oFOtWfXQdrYBDWrgUqsot3Jeu0KVnD1HWkLv8rPSDyDSwn6p9
	KwrjT
X-Gm-Gg: ASbGncuJHTKSehCsdwiwVqm8MqNQHI/PGo/0QDcHQ2ij47llEfMHaLSvfdOYKV4olBy
	8ej/vz7eEqAb1uhDjj6FWwC8NfwW+SVpfrikW3b6EN82LnKrEDkzqk16IZ86hiPQNrni0Ydzn8a
	diDdkolSAbjO23bIE+x8RxQqUBzU0Z8zpQKzDECqZmoWEqORXKFgFw8nzXASSCCP5T0kolXtfIq
	vPq/EQ9epAW6VvOTGHcS6c9Xtz5UtNLMmizEfMrTZMIolp0bVJfbyZd0i2Ee4sEe7rO
X-Google-Smtp-Source: AGHT+IG1apR1vTj+XDY31qMPTLjE6o1mRz1SPCnQsQcDSSadSWHC00DOczAE6znOSW4OrtbiIoSykw==
X-Received: by 2002:a17:903:456:b0:216:21cb:2e06 with SMTP id d9443c01a7336-21d8ed5ab38mr390055ad.19.1737501685197;
        Tue, 21 Jan 2025 15:21:25 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:16d0:c948:f6ad:1381])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ceb9e7dsm83307095ad.77.2025.01.21.15.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 15:21:24 -0800 (PST)
Date: Tue, 21 Jan 2025 15:21:20 -0800
From: Josh Steadmon <steadmon@google.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	calvinwan@google.com, nasamuffin@google.com, emrass@google.com, 
	sandals@crustytoothpaste.net, mh@glandium.org, sunshine@sunshineco.com, 
	phillip.wood123@gmail.com, allred.sean@gmail.com
Subject: Re: [PATCH v6 1/5] common-main: split init and exit code into new
 files
Message-ID: <enua2yv34i26defybya2s6ds2v7ffilk2bljfdyay6pech3jjr@pvwc3iewvhj3>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	calvinwan@google.com, nasamuffin@google.com, emrass@google.com, 
	sandals@crustytoothpaste.net, mh@glandium.org, sunshine@sunshineco.com, 
	phillip.wood123@gmail.com, allred.sean@gmail.com
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1736971328.git.steadmon@google.com>
 <ff6cd62397ec2755d15e9d76f9af8a84b54a36c1.1736971328.git.steadmon@google.com>
 <xmqqr053wvip.fsf@gitster.g>
 <xmqq34hjv5kw.fsf@gitster.g>
 <xmqqtt9ypj4m.fsf@gitster.g>
 <Z4omfC0v_UIBRiNM@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4omfC0v_UIBRiNM@pks.im>

On 2025.01.17 10:44, Patrick Steinhardt wrote:
> On Thu, Jan 16, 2025 at 01:02:33PM -0800, Junio C Hamano wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> > > Unfortunately, build based on meson does not seem to like the
> > > init_git() thing.  Perhaps we need to add some missing files to
> > > relevant lists in meson.build file or something silly like that?
> > >
> > > https://github.com/git/git/actions/runs/12800227601/job/35687658673#step:8:961
> > 
> > I needed the following to get "meson compile" pass in my local
> > environment.  I suspect that Mesonized CI jobs exercise a bit more
> > than just "meson compile", so there is no guarantee that the
> > following is enough, but at least hopefully it would nudge you (and
> > those who may be interested in helping to build a working Rust
> > bindings) in the right direction.
> > 
> > I think it should be squashed into the step these files are added,
> > i.e. [PATCH 1/5].
> > 
> > Thanks.
> > 
> >  meson.build | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git c/meson.build w/meson.build
> > index 0064eb64f5..e5ba28b47f 100644
> > --- c/meson.build
> > +++ w/meson.build
> > @@ -245,6 +245,8 @@ libgit_sources = [
> >    'commit-graph.c',
> >    'commit-reach.c',
> >    'commit.c',
> > +  'common-exit.c',
> > +  'common-init.c',
> >    'compat/nonblock.c',
> >    'compat/obstack.c',
> >    'compat/terminal.c',
> 
> Yeah, I remember having the same hunk while Meson was still in-flight in
> order to make it compatible with "seen". So this should be sufficient.
> 
> Patrick

ACK, sorry about that. I missed the Meson developments while I was
off-list, so it wasn't on my radar. I'll make sure to squash the fix in
to V7. Thanks both.
