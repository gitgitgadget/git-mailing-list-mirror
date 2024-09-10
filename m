Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2F017A922
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995117; cv=none; b=cEZV5qysvAiLXAONojDhV5nrSrM+1NNqvzrWhsq7guO/gNBCnm5fhKC9J/7oEYvpgZ4hhiI2fvKbtJQ0Q10i4LsGfb2f6MRzOdpilSBO55DvNMOQdH3eI/0sVmfDHaVFCMIw6vWspgAHmLDDJlnkf7lOmStCEna04LZE1Ap4BjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995117; c=relaxed/simple;
	bh=coW1vHzqLk6MolYDrGkqLqou2tiWwDiiODwvEX1eBTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCGNwDdb/sezq11JQd7GAL00jdGQ7rJLxKuhKsUSKUbW4UE04cGElJvkaHt6n/FcvIHrc7IaysrsJTQotZviGsSwX3D33Swz7OxEsrEM0C54LE28vV5Jj4K7HqsHyLZhlH2UDmGxn5Zd+OSpNtP/4DtXET5KBfrsvJalzhaAuvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TIJ5yZeh; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TIJ5yZeh"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5356a2460ceso32893e87.0
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 12:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725995113; x=1726599913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSOH2HjqpRAgBDo6dqIRwY2i5KQo5hp59czk5hPW3HE=;
        b=TIJ5yZehmTlZ4UGXQStBcNJGvCPRMEizutvZgQwa7skT6REbH3jAKa8Pbm4OXg5mOd
         CMeztwnFYnkuaIv1hrps1bUw0cdlcmVY/d/us7+TzpBU5qAQ5rg++ojOT0SDgsCUINfT
         XkH5uqdUDhAv0jUvZsNKYFdDTvkxldh18OAtHmBQua+a3mDXZBet3YLucDrErQjg7SuX
         6ylmeFCx2M8GDH0iYoBSjodQzAn8dMijgWcNxByD7PCSb1IgbQcuO1m9M8QG6VNL3zlg
         PUjp7vCORwY2TcM7DF82t48aSt93exifibCYjyFfiF9xkQ6mS/zeh4I2vQNQswOEdjkb
         0D5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725995113; x=1726599913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSOH2HjqpRAgBDo6dqIRwY2i5KQo5hp59czk5hPW3HE=;
        b=uccT6NH2o7gjOsAK1+VcliTNgCD1nFajJIMg7GPKtfzxBVkB6sAGezQNnLakHkt5dV
         sqKPScgV6KTOZOzgas1Q0/3745fDeqH0HnDKGIE881m2MxyhdpEgR+fZNdfEsR76+/AH
         3DOOCAHtUEhYvox7iIE7bRi5ZmoIGIaVhO1+PV/tO2hRqEIjapG9WJEXEsyThNImI+8+
         SKnmyqcyvA/8YzbPnGlIAKG0RwOuHlJj9SfFzoFwxG+sWP7lGu377Czcq47oNhWp/48M
         yk7LyVvVjAvbBdONeP3FsAINfztKIVYjPEeTeDk1PZ27Rw20dkJPKkGwofetKwDZlf18
         Rw5Q==
X-Gm-Message-State: AOJu0Yyeb7sxVVTNv9zC5pdxsHJ+lIDwsK0zz6EBhfBFfxdpk5TWhkY/
	g5z5lAN/lHCPLebhmLm+uSgshQb+2BQd197JqYbxCCs9YI+qMjDwvQ1AW1SdDbIAngRgUt76SNT
	0Oyn3jbm4Vb04dcBNP8/QgW+uArMl3yayAeaQ
X-Google-Smtp-Source: AGHT+IEEWj8UfLthZuxSRvfCtltecj99oeiHX9ZY24uSvmItf8lbGHA2MOJNw/oKhccbvfTpXGXm+6g559PnwfFtnf8=
X-Received: by 2002:a05:6512:ac5:b0:533:4620:ebe6 with SMTP id
 2adb3069b0e04-53674398d03mr56060e87.4.1725995111558; Tue, 10 Sep 2024
 12:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906221853.257984-1-calvinwan@google.com> <20240906222116.270196-5-calvinwan@google.com>
 <xmqqv7z8tjd7.fsf@gitster.g> <xmqqcylcpnah.fsf@gitster.g>
In-Reply-To: <xmqqcylcpnah.fsf@gitster.g>
From: Calvin Wan <calvinwan@google.com>
Date: Tue, 10 Sep 2024 12:04:37 -0700
Message-ID: <CAFySSZBECCQafaLEv80WoK6SMovwC97-tf9gh_btPc+8OuP4NA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] libgit: add higher-level libgit crate
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, steadmon@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com, 
	mh@glandium.org, sandals@crustytoothpaste.net, Jason@zx2c4.com, 
	dsimic@manjaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 1:47=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> >> +struct libgit_config_set *libgit_configset_alloc(void)
> >> +{
> >> +    return git_configset_alloc();
> >> +}
> >
> > git_configset_alloc() returns "struct config_set *" while this thing
> > returns an incompatible pointer.
> >
> > Sent out an outdated version or something?  This wouldn't have
> > passed even a compile test, I suspect.
>
> The "shim" layer should hide the details of interfacing to the git
> proper from callers, as well as it should hide the callers' from the
> git proper.  So if you really want to hide "struct config_set" from
> your library callers, you may need to do something like the
> attached, perhaps?  At least this does pass compilation test.

You're correct that this is supposed to be the shim layer, where
callers aren't supposed to be able to directly interface with the
config_set struct. From Rust's perspective, all pointers that come
back from C code are effectively void* so the naming doesn't make a
functional difference for our use case (and consequently these
warnings did not show up from the build.rs script nor did the tests
fail). However, I agree that the public interface should pass the
compilation test and your approach does that -- will reroll with those
changes and I believe that we should also fix the build.rs so that
warnings also show up during cargo build.
