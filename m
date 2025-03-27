Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7256921ABCD
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743101893; cv=none; b=ETDciwCb2Mc6EpAshpGz+hLClJE2l687f5EPJySRqm/G86qLCBSRhpMzaOTGcFDs3dehx3Pnf8huxQ3xx7R4lTq5c692WPF36NpR+va1R2PCgfvgwwZVn8WtmQbfic1H0LIlDtKggCuJblAyi01gvlB1mBmz3cA7sri69h+pp+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743101893; c=relaxed/simple;
	bh=k5Nf4Q3d+0z2ydj/42+zHhrFT9qp7psfctivHh1vCTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F11aawPerm24YoKaak6a3W54wTeh50casR726o0t+uE8mkwL5WhJJxyYOA4pa1TNdA7TNwGq//hD0cEZOZzbLkG87smszJzch+6Y4GWn2Jo3gfOdXrJTHyFoMn2p2wlrkqrtdj441Hw6yxCK1j0T0feLmaonwNeNJxDf4dO13Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YQmysDvR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YQmysDvR"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2264c9d0295so34745ad.0
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743101892; x=1743706692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQ759PmXeoBI4N8GmmhHLEUevgjWX3Y/pqcFggUC1X8=;
        b=YQmysDvRSshOxPO9twWy3zM8LgvtwZMcTc9md+hl/020Dg/C3DNEdpv3bJGUZD7rsH
         +aJThtaIBskRkNZfgMTQTlqQ6YLWg5nLR3HMjlnVsQGVbyK624t5iYBkoeJs/eWQtqq6
         BFfiFC9Vq/jMMoghKlPU3v5U0y65tEsp58Ygb2z8PJnn2RAm+D/iSCMMWpkdwGS9s/1E
         r4vFiJlxSd+M4/vUlE2NVgKlqQpbEU9D/yxYVUr32iF5jbf2NI1nrw4hIHU/1C9r1YGU
         skYa/wWQJVWRS28PT6lZ/enzmFHLIQatg8ijqGiHS51JZkZWRHv5OXeJiOVl+67cZD1/
         uRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743101892; x=1743706692;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQ759PmXeoBI4N8GmmhHLEUevgjWX3Y/pqcFggUC1X8=;
        b=c4CrV4tPN41LE9UDiBZedkcIQpzuuAfjMRiDk3ljzhhXRprYhzuJC0puV5VSqKNAfo
         yNt1ZZcjuGtx8f9jujBVQVMQh0yn0hgcaLKDVQ0Az856+UA5Obci4IpGhB7dkuC/Wx0t
         2QxNA0ZX8KYt/aHsIgRR4Mb4gg56A8LWd5i1j7et/LUnnLg8JNxgSqJt26K/NC6GQ4WG
         EkdChkxs9K66vtQ/TBKPZ3UPcBt3rwt3fPNV44XQODy9Gug0wt1+0QeRUj4fRQNH3ekM
         oog29t338HhUiLyvMTO4GaiW+hw+aqAHBBuUVyfc0WexuxC0CNocHH5ynscuxbeBQsYj
         b7EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY497H/gu9jpP/RkFU8pRCliJg0Aa0MvZzPf8NBHRNbkjbmQDvwOLSkW8tk7LudWL5HRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM66x2phuTyj4NoxOShdQxVa8O8Y4vXxAvw36q+pSybD8kN2J1
	5TV8T1BePWrwrPZrZOr9f34VKa6JmeRlu2yDZaZ5yR/FHil2xaTIHxcoglRwBw==
X-Gm-Gg: ASbGncugcXvIABqUJ0KRGCDYs3McitoaNPi6NjGYSG7bt7rxAPXJBBzU2G2RUNTUwPp
	2OCXfbhIJlG3VeCeikLvkgfZP5r1C8BdHT8nhep+wxYx76+4gYoBKkHe4bZaEaCFp/A2h08NyIZ
	a4vnG6okPCrnepZNrVYq5Q+T/pNyGofL5k45UN0skaqb8Z7EA6H+z8n3j6wtWbGHvBJxgZ9NBES
	dqexeIeqhOetNQpafUK37LwDq5hMWwIW8FQsvS9BX974OK2X/7twI3Z9mukm77mZs79Pshmy3HC
	t1FacmZv+BOxQF7kTTnpL7u2g+Hb1U+TDEACTDd+SBU=
X-Google-Smtp-Source: AGHT+IEjpKiCe9s1O+lx0oNJ79ovdauVDCAw4rzVR3CdITDuYG5SIetmqqB2JeyTpBrikjNfH0ZGnQ==
X-Received: by 2002:a17:903:c08:b0:220:c905:689f with SMTP id d9443c01a7336-22920f444f1mr294365ad.25.1743101891330;
        Thu, 27 Mar 2025 11:58:11 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:70cb:7011:dcf0:4c01])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73971073a9fsm174298b3a.92.2025.03.27.11.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 11:58:10 -0700 (PDT)
Date: Thu, 27 Mar 2025 11:58:04 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/5] libgit-sys: add symlink to git repo root and
 build out of tree
Message-ID: <xnjgoym6makh7q64sp5efvkmcubslklkjeidja45rtl2wjm4jd@xfww2a52hj34>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Phillip Wood <phillip.wood123@gmail.com>
References: <cover.1742339107.git.josh@steadmon.net>
 <cover.1742594960.git.steadmon@google.com>
 <6befc95a2d0893aa269142a18d60ad07e79c6e88.1742594960.git.steadmon@google.com>
 <CAPig+cQ+05r0iJO3me2=yz1KWaU_S_WQmbeciOqZGxYWgbT8dw@mail.gmail.com>
 <xmqqo6xqo2o1.fsf@gitster.g>
 <5qvxvuquk2yuyoyoctz2ji6sj4yld4ridig24elpoiytghlovw@a5hgdufrchwr>
 <xmqqy0wslndp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0wslndp.fsf@gitster.g>

On 2025.03.25 16:08, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > 2) keeping the top-level clean of any Rust code or configuration.
> >
> > If we're willing to have a Cargo.toml file in the repo root, ...
> 
> If it is more like adding a new build configuration file whereever
> we have Makefile (or meson.build), and is not like we are adding one
> new file per one existing source file, then I see no reason why we
> want to avoid adding a few files to the root-level.
> 
> > ... we could
> > create a "Cargo workspace", but I'm not sure yet if that avoids the same
> > problem with accessing sources outside of the crates themselves. I'll be
> > able to test it out later this week.
> 
> Yeah, that would probably be a reasonable thing to try.  Thanks.
> 
> 
> > If the workspace approach doesn't work, the alternatives are:
> >
> > 1) avoid the issue for now; anyone who wants to experiment with
> > libgit-rs can do so by building from source (but it will prevent them
> > from creating their own packaged crates IIUC).
> >
> > 2) move libgit-sys and libgit-rs to separate repos and depend on the Git
> > source via submodules. This is what I've seen done in other -sys crates
> > such as zlib-sys (https://github.com/rust-lang/libz-sys).
> >
> > Of those alternatives, I prefer #1 for now. If we build enough momentum
> > on libification and expanding the coverage of these crates, then we
> > could think about switching to #2.
> 
> Yeah, or putting it another way, #1 would help us gather enough Rust
> minded folks who are familiar enough to come up with ideas and offer
> better ways to manage this part of the system.
> 
> Thanks.

Unfortunately creating a workspace doesn't provide access to the
top-level source. Symlinks seem to be the only recommended approach [1]
for embedded crates, but since that breaks Windows CI let's just drop
the series for now.

[1] https://users.rust-lang.org/t/including-files-from-parent-directory-in-package/88969
