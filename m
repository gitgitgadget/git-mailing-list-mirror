Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D09D1514CB
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728912858; cv=none; b=AWpdTyz1PSXYpxcoeSuTx97anRBubarH9aetGy4235dP3jnRn9srsW1uas4YlMgmj1ETl9Wx7J1Nke/hdD+q236aZP7bF92Ym8HqwKgbos3uTvZ6BQxBBG5U3abvEXUiIAKgbpB3rDdMOBFjFY8tdjcPnOoC3/l4UkjS69rYwDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728912858; c=relaxed/simple;
	bh=DSkbDEKJE7bI5tlEaQG3xMHyzDv8OEbiPUU0CmLrkHw=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=KChVRB3E1ViJgqPKwB+siYC07BTdg/tZHWeYTf0KHmldxy1gAHe2DFquLntp2bOyeGJ+vw58NiDkCWchX7mTerzKyLGs1QU47P0/fBl57yf8GaKuReKs+lrCfiVua+fVMvyVTk42AlUzHJnh45B0A446bNV/1i2we5O84M7SC8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=ujqe6h1A; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="ujqe6h1A"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d518f9abcso2312622f8f.2
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1728912853; x=1729517653; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSkbDEKJE7bI5tlEaQG3xMHyzDv8OEbiPUU0CmLrkHw=;
        b=ujqe6h1AxCzfKjfDwspk+vMMm/yveySlxTonJFTsIWkcV+dkh4n8Q0GyofzBZz2Y2O
         Ms4Z9SwvZGKrPPcAK01RFbSjUEBMHYo3d9AXmgldHKZdm/kss8gsPFD/eOEqpDQqLoEV
         yHMOkDUKblinaMtrHylOHVl5HnmcsxcAezvIIqSMNui+biEumUBZ90CZf89XjLwa7abk
         NKE0+JIp6xe9427oCrbe8XBR1G+TPax0fJ1o8QCM8IY7yuxNo8J/ZKx4X4fc4nuGwwk0
         eYvZnnqVbdMqQR4WJvV1pjI1ucSuWubW+D9+L9Z3MaZ5d7rSc9bIyLAk3VFn1xMcbGzK
         KEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728912853; x=1729517653;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSkbDEKJE7bI5tlEaQG3xMHyzDv8OEbiPUU0CmLrkHw=;
        b=X3m10k/u5v0EBuzmwQZRy1PEamjWqh8Y4NlosJGaoditvrBgO7UMXQCq1wyrhurOAm
         ToEFAB/l6mF52gm+ax4RHJHMj0muj2XUASWfxbpy8ySISjmi+0nEXczUj+RAEC6+f2FP
         Hxg00RJAP+ifMGFm7Bmkp6Ok5LqTPwhYt3siKRNnq3O3d/VwiHZfoGsogaFM7eOs+tQ/
         tWoBKJ3SmLCBZUlAzkU90fUR0K9ahT0jeEdptnS3DC3iNZWydcMMrIDnn/xjBO3eQhu4
         agZKQXsb+LNA/wT748aHS27Z8bRYrq+EI1ZLj9cnnWBiC42LOEE1vwHF5RAMyNSKwUAV
         5SIg==
X-Gm-Message-State: AOJu0YxDX41hPKdUjKc3GeMDvVw2zMStGvHBz8OZTJBY2fwSnyKda6Bk
	tpp8LeEbfpF2OjWEXmucEHPlQvrp6+PoAD9wR9mEbDWKFoyOKwxl+mNhmKT3nMir39dz3LT2sm7
	I
X-Google-Smtp-Source: AGHT+IGjXTwQ39Aq+SG8VohJ+msJIqEkzbmVdjRKIMWiKmWLLA88En6aV0IIyUxdisHNzVDJ8BrQrA==
X-Received: by 2002:a05:6000:10c5:b0:37d:4fab:c194 with SMTP id ffacd0b85a97d-37d551ed80fmr6701730f8f.25.1728912853093;
        Mon, 14 Oct 2024 06:34:13 -0700 (PDT)
Received: from smtpclient.apple ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ef213sm11366152f8f.99.2024.10.14.06.34.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2024 06:34:12 -0700 (PDT)
From: David Gstir <david@sigma-star.at>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: git grep does not find all occurrences on macOS
Message-Id: <771C9C4E-45F1-4F71-B3A9-4E8E4A9CAC1F@sigma-star.at>
Date: Mon, 14 Oct 2024 15:34:02 +0200
Cc: Richard Weinberger <richard@sigma-star.at>
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3776.700.51.11.1)

Hi!

I encountered rather subtle issue on in git 2.47.0 on macOS 14.7 =
(installed from Homebrew):

git grep will not find all occurrences of string patterns containing a =
=E2=80=9C.=E2=80=9D under some
conditions. In my case I have an ISO-8859 encoded text file which =
contains umlauts.
If the string I=E2=80=99m grepping for occurs after a non-ASCII =
character in this file, git grep
will not find it.

I=E2=80=99ve put up a reproducer here =
https://github.com/iokill/repro-git-grep-issue, but the gist
of it is "git grep quz.baz" on the ISO-8859-encoded file below will not =
return anything,
when it should return the line "quz.baz=3D3":

-->8-------------
foo=3Dbar
umlauts=3D=C3=A4=C3=B6=C3=BC
quz.baz=3D3=20
--8<-------------

=46rom what I=E2=80=99ve found so far, this occurs on macOS, but not on =
Linux and it has to be connected
to the regex matching code, because the issue does not occur with =
--fixed-strings or --perl-regexp.

Thanks!
- David=
