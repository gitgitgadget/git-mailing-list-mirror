Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4A518E022
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723497853; cv=none; b=jqpvKMpWUOl2eXaiWniBcABPn+mMU1UCLHxaYRE41UV3L06B4OXCb7RfPkydOhKEcLEpN8m8trdot4J+1pFb3hPY06olWQdh+S/6q8GX2Fj2JfGkc7XXiA+tsmwBV9E/wpaS1uolyHt3gM7v3x4xGbsEXwWEwG3Q4fPEPaoIZ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723497853; c=relaxed/simple;
	bh=wAx4zfTz42mbDHuPCFf4j7z2h3140mF5rui84T4EkXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVpb+gHO4QLa6bCDQYz2e/f86IMj9gHQvyE+db+TLfkf6vNVhYF+yN4QAz9JaNwtjLfYWvsCquzefe5NzuJMkrpx8wPTNMohACaeW8g5rLdoSnxJ9Uu3lUGyqbhsW5UvsSKiAbXXRRGHtdfM1nsciiQKE/ANAcuhfqGbT5QddGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L1BFMUxK; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L1BFMUxK"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc52394c92so44515235ad.1
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 14:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723497851; x=1724102651; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xMXsx43RuddhjGn2jAlPQe8eORNhMDHuDWypdcY2smA=;
        b=L1BFMUxKxU5ZAVbZI+waMVG9kefjyFnmfjvsLwvA9LqUanp9AKKthKHue9ilpkCZPk
         gWuGRrowfyzeFncsz/0TlHyqDwW86G10WC8Tkn4hsMYC9UrS+naMXcZyaTkGNgcXL8jc
         Ox0zyRYwMsO1jkzfaqQJR2nIeBQf6OEvdihJNHwU1E4i9H7VmXIqMlnc90ZAERFw+vid
         XtvFqyhJ9n0pe9sbi7EevcMZ5/VM1cnTPUogYfoRpbjD2w7GeVZKOGJqsApd3E+xd1K2
         gGHnOU9kIrH6N29CWpuZpxFyJAqBgQfOCIIm9MuH2xIffTqPa4T17OOR5KWglIH+4leP
         56fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723497851; x=1724102651;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMXsx43RuddhjGn2jAlPQe8eORNhMDHuDWypdcY2smA=;
        b=pT4iBO5Aq+5YUBD8Radn4ndSu+mwJRKhCpzYcXG9cDFE/9TvXuvAQanb8HjGGCEgiH
         qnTiolEP+G999WeH3fVV7oa5PRHkO0d2d+QcYbjhRQWze/SLWIfjHkwh1G1sS8LTYsX8
         MaEkNBqI5Buvur8/NUwsFIQuNxGMynJIjk+Db9SeIZA+vjqOkC5zTCCGBz6/Ct6+JIIG
         RGqssoUXclYKBhFjqG5oIVTN2Z9gLOkGEmU6/yx4a0gbHmmSQnTvL+EPVbZjOmn5w0OB
         pPdVUr04mxGr/HD4hYzOklpAUR35i38Q/nNqUenGPseBAwa6aZDWFZCPAA8CmG2kXHPt
         uEhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUds2h6U9aKzwmduXwwUPJW3EFH4ph8rz2elCphFt1NaY0JXsRPB4lNPzALu9MmpwXuF9JUo0d2aEoQQuoJ3YCg87S9
X-Gm-Message-State: AOJu0Yyo+ceZ2i9PBzkHBWmoHK9Ou7KwRtGwVHGTPqZu2ldgsH2mXvR1
	e0U+57h6m7CxDgsAdf8cAYDGZu+fI46TkSPub5ya5/xRqb9s+Hv45+yT5/XR/w==
X-Google-Smtp-Source: AGHT+IFBps3cvjrK3YTM9ysh16RZCOkht0Jff/lgEquo8QHsTssj1f544klunxvIpqh38PVvDTSyGw==
X-Received: by 2002:a17:902:e88d:b0:1fc:6c23:8a3b with SMTP id d9443c01a7336-201ca13dabbmr21828765ad.17.1723497850445;
        Mon, 12 Aug 2024 14:24:10 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:4c2b:85dd:6293:a02c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1c79d7sm1222005ad.247.2024.08.12.14.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 14:24:08 -0700 (PDT)
Date: Mon, 12 Aug 2024 14:24:03 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
	Dragan Simic <dsimic@manjaro.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, git@vger.kernel.org, 
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, mh@glandium.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH v2 0/5] Introduce cgit-rs, a Rust wrapper around libgit.a
Message-ID: <rt4ruismrzhtkbry4kuube5fwf2zprajjen7wagl5nyyjivhvz@xuxq6paidcmr>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Dragan Simic <dsimic@manjaro.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, git@vger.kernel.org, 
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, mh@glandium.org, sandals@crustytoothpaste.net
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1723242556.git.steadmon@google.com>
 <Zrdn6QcnfmZhyEqJ@zx2c4.com>
 <6398d60387a6607398e4b8731363572e@manjaro.org>
 <CAPig+cSotr8CNZLy4xnm4qyJsuQsxjzsYMVU5sf3eeoEiE8aXg@mail.gmail.com>
 <xmqq5xs688cz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5xs688cz.fsf@gitster.g>

On 2024.08.12 01:15, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > On Sun, Aug 11, 2024 at 1:27 PM Dragan Simic <dsimic@manjaro.org> wrote:
> >> On 2024-08-10 15:15, Jason A. Donenfeld wrote:
> >> > Still the same name for v2? Cmon.
> >>
> >> Yeah, I was also surprised to see that.  This _isn't_ cgit.
> >
> > Josh addressed this point in the v2 cover letter by saying:
> >
> >     Known NEEDSWORK:
> >     ...
> >     * Bikeshed on the name
> 
> I do not quite consider it as as "addressed this point" to just slap
> a NEEDSWORK label and doing nothing else, though.
> 
> The original iteration had this:
> 
>     * bikeshedding on the name (yes, really). There is an active, unrelated
>       CGit project [4] that we only recently became aware of. We originally
>       took the name "cgit" because at $DAYJOB we sometimes refer to git.git
>       as "cgit" to distinguish it from jgit [5].
> 
> and then now they as well as reviewers all have seen the tentative
> cgit name, saw the reaction it caused, and now know that not just
> potentially confusing other project _exists_, but it does matter.
> 
> Reviewers already have spent some time on suggesting that "git" part
> should not be "c"git, as well as "rs" part may better be "sys",
> etc.?.  There should be _some_ response, even if it does not yet
> propose a new name.
> 
> If it acknowledged that the time and knowledge reviewers gave the
> topic were appreciated, e.g., "The proposers of this topic saw THIS
> point and THAT point as a input that we WILL need to consider when
> we decide on the name.  We acknowledge that the name "cgit-rs" is
> not ideal and needs to be changed.  But we haven't reached any
> concrete alternative name yet, so this round still uses the same
> name", I'd call that "addressed this point", though.
> 
> But just a dismissing "Bikeshed on the name", as if they do not care
> to be mistaken as saying "those who complain about the name are only
> bikeshedding and not worth listening to"?
> 
> We should do better than that.

I am quite surprised that people felt this was dismissive. So to be
clear: yes, we need a new name before this lands in next. I thought that
leaving that as a known needs-work item was sufficient to call that out,
but I guess I was wrong.

As far as proposed names go, I am not super happy with either "libgit"
or "libgit3", because that seems confusing when we consider there are
also a separate libgit2 and libgit2-rs projects. I know that we're using
"libgit_" as a prefix for visible symbols at the moment, but I plan on
renaming those once we have settled on the actual library name.

I was avoiding addressing this topic in the hopes that folks might
suggest additional name options, but as it stands right now, I'm leaning
towards just "git-sys" for the low-level wrapper crate, "git" for the
Rust API, and "git-rs" for the directory in contrib/ which will contain
the crates.
