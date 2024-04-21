Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075C61B806
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713714353; cv=none; b=dNHx6guHiKxuHIo5yF6xsm8xN94jhlqRuMilJ9y/CkgcHNqc65W4k8YfFOYCSrQT2YAALm3fVlQ4Ue7gRZU0Nx/YAFGxlxRiaZWzqNd6FXjxNK6Pok8PkcCVNISsgUL856Y3W3r7v7k4sUe5x50Jjcc+S34ekSYixTxSH7oFZrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713714353; c=relaxed/simple;
	bh=bbPF2QEzf+DWbY+ZW15GbZDN77y/WEzEF0orcroKSN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imZE1D5v75zl2/LGhLtEIt8xmKvIqtlREZGgPH62cVa/G0usHRVPricf+BNetA4pV2D4OWNeu+9cZkMOcJ/76+j7k0AB2DMX4FAiUNeyJlgYPYxJFhfFjkCjfXN9zyVrB907PSR1+ttBpBTghuQnZ6g1+gUmH8iPfi3dED7Wo40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkMkT0hn; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkMkT0hn"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a55b0213a0dso46296066b.2
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 08:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713714350; x=1714319150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CG3uKISfp8ouFYMkhXdgTfDAYQaKzqX8W6qxFPNd7Q=;
        b=nkMkT0hnkG8HcC3JnP0mS+Xr8GYCGmMPOHg+rGKUNvl7dzDESE1W8HNAlUto/tLt/z
         vYlE5k6m7hlJ1D/95LGBc/odSGQWNKvBV2Qlf8fA1foU3zH5UcYtoSI64+UCD/XdTQkI
         mBeWYeU6HPPYSEbXRDXBaPof5GEogNpV8WHhpgdNlQo7+eHT4JYZGZdrG1EjfiYG1hfw
         BKNXqny1wUmvTsaDmjHSR2pDc3eY66URjzqkVeAzAgI4I9k8ukKZdfeJDxUJ9uCFcvjp
         NNAlXX/xFtoEDwGSFObKxODQ93377ggNPF0dzH2CIPUE16epNbuffGtdrto5tSQUV7zV
         AliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713714350; x=1714319150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CG3uKISfp8ouFYMkhXdgTfDAYQaKzqX8W6qxFPNd7Q=;
        b=XDRAsdGdv6wlF2xSMF6Y0MNWEpIY3ir3Y0mVB0lLk1jiX0JHwaSdLokG9a0P82Gff6
         3eHET09fqL4MzL5q55ZDIkReWm5DNkjQlTqjs83CmZKSc9CLu29F2qrnla64JAGtJ7Pw
         3KR3Yf5YyJs1irGie/FCuez10cHGYxCpZnJ80tg+fuvGjN2XruFUWvd3UMtMkKwEl4+L
         JwE/ih35KuGcgnKM5KN8zsmKCayS0wjg5JTL4rJ5oDz/4I2HUxfl4+SK/bmTOrBhfU+O
         eWRqpiAFIR+UDZBmEsV050Gn7s+nd80M/HFktwokePFKVHBGsPdjsLMsDalivbFke/kP
         C24Q==
X-Gm-Message-State: AOJu0YxRdHN7jjIye3TasUEhHfEfFQSqb0Rj7LhSkrIuwp6uBNyfw9gV
	dL0cvuQOtbmu15obOlTe4dHGgUzW1ACu3lOF6nDUm01tj1TugpqsgnAbSTThkmKTw5quxhLiRv6
	RLSp5X+ZLLLZ6j1EV0VQza14N86w=
X-Google-Smtp-Source: AGHT+IFOfyDF7ubMBG4n9qfgLzBeoVo3w7VGbXo9Fh1SHgedhJT4Try26yHd579P78alr3Yp5uQ40BK+imN7PJ6UQdE=
X-Received: by 2002:a17:906:39c1:b0:a46:3ce4:5acb with SMTP id
 i1-20020a17090639c100b00a463ce45acbmr5020384eje.75.1713714350038; Sun, 21 Apr
 2024 08:45:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <65f32df3f49341bf192b606914d44cc937f7971a.camel@intelfx.name>
In-Reply-To: <65f32df3f49341bf192b606914d44cc937f7971a.camel@intelfx.name>
From: Mike Castle <dalgoda@gmail.com>
Date: Sun, 21 Apr 2024 08:45:38 -0700
Message-ID: <CA+t9iMwX2anANcpPg15MHwdh1377zMb-k9kCt3jVx_-ggJy=sg@mail.gmail.com>
Subject: Re: Building with PGO: concurrency and test data
To: intelfx@intelfx.name
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 5:53=E2=80=AFPM <intelfx@intelfx.name> wrote:
> I'm trying to build Git with PGO (for a private distribution) and I
> have two questions about the specifics of the profiling process.

Generally speaking, there does not need to be a lot of execution to
generate good profiles.

Execute the happy paths and collect data from those.  (Which implies
that unittests are usually a bad source of profile data.)

Many folks use performance tests to generate profiles because they are
already written, but often, they are overkill.  Depending on what is
going on in the real world, more resources are spent on collecting
data than would be saved by the resulting optimizations.

I'd say, don't worry about it, and just go with what is already provided.

For tools like git, each run is short enough that improvements are not
likely to be noticed in day-to-day activities.  It is still likely to
be IO bound.  Most perceived performance issues are more likely to be
addressed by algorithmic improvements (in general, not just git),
rather than feedback profiles.

Now, for any busy long running servers, this can make a bigger
difference, particularly for computationally expensive operations like
authentication.  But again, IO is likely to dominate.

mrc
