Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEBB2BE020
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757026573; cv=none; b=kmsEIurDCf414sIgDDxH9AsNde2/oZ8c2+bfPx+Wx5UshDTuld1y1usMCxxbF9bRJVaKl8R+7k6thIQw+QrIbBmk+5pMzR3V9BHVkB+0Ix3IyI6yUXnpINg2nlwMwmmiUT4mqrQrHaiuhhwDDO8xp46KplsaLtv/IO2SIUcHncw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757026573; c=relaxed/simple;
	bh=3ljmOwObkK6rXB6I86ZDePtEOcbWgOSchspsakRhgSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=eM5aoC9rDYoTgRPDCtV5aenzztw+6AI8FjjyYw9dBgOlMrRGPgs4IDYNGRH/jgYw1NVtFapmAhDVd/oOwlxdfyPL9E8zTtl4iC9+wrBdGwPD89F90CDCmUtneWekzcWP7EI5e/n72o3zyabF05kGW66QLVBNlpbHZR62PI698i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhQ8zcCz; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhQ8zcCz"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55f98e7782bso1843375e87.0
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 15:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757026569; x=1757631369; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ljmOwObkK6rXB6I86ZDePtEOcbWgOSchspsakRhgSU=;
        b=XhQ8zcCzcEB7G5ybUSnOr5llGEUr7DOmUyM4RT7fvtjBGVkjKNzVTpYxf+HNsaHho+
         HPPMo19+3wJYBOxr2s9ACBQi0hG3iIuYu2ziLlKrGS7SxWoyNDTfNrVmEHtvZmVVDAJn
         kzWfHUyyQeueo4ygJCgX7b22CSElomhYXCbAnwnUynfvun5d/06y4M4IgGbSO+FOGxsT
         JhenfXJ8rzptRjcuJwwXYu0yKmMrahlHNRfabnyA1j7PBM7hZ+w49fxxcSqzehTMBW/p
         faa9MGkDI1W4qI+x/MQT57A0OmP/Cb8AxGzzTU7G5r2D2m64I6hKKALsvFPqnpaDWyj9
         OR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757026569; x=1757631369;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ljmOwObkK6rXB6I86ZDePtEOcbWgOSchspsakRhgSU=;
        b=qRa8GySpc3JKs3HHSOpuBcsYlRgWYP7qHpHMDzqhbb+0VYJV9mDelCxAKxduTv1V5s
         EcCcbK/CSDZ6YHmD7KcVnThgyQMf4kkMSMpy1Elnp50AvfvVLNt2UGrdcO3hfvev6byx
         L6vJG3qojkaRHt+wBqnLBZCjPvjPoeRHRUWFR+9erDY/rDZ17zOup+NB5c9P52EbxVVI
         GhAfMVVjgtUAIFJOGGPLTFrrSdQnyXp38Wat2FOCAeWHHHZ+qNi9pPIrAnMzImz6aIkD
         x0I/gh4HZCg0B32vTSrjiWFs5sNKsuVfpF40Xnc+nbmltr+BdfitxZ3KPLIGcBbOE4ho
         3dyg==
X-Forwarded-Encrypted: i=1; AJvYcCU5FP3pGzprBLvTPyd41YIB1RShQxSrjss2mGzqLken2snoZ+5MwaRuU4systsinXcGBYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXcdnGYcDsOL4VWIyZLZaH5hKbQGpQWjL5c9hMbz7ilieHSLYf
	rsnKx2fwoF8Y25MmoVymlzq6NULNtOflSPwtTrJo88xUly4zPJXi4tr3bakyubfNxVB1VF0xK4r
	PW3sQwBxnn+NscCvqpHDaNvR45A7yzRc=
X-Gm-Gg: ASbGnctTNk+2BmpXjz0CWjfp2pxmi/smFSf7PhFEBHaGX9nxGQeoPKVbEIS2QBMV8Ef
	aZm43D4JfHCZnkoEgy4i5lGg2ugdr1ZIugPG7yLP5ZNXSD+ctqxpp9RnATah7Bl/W3h9oq4Bcdh
	VVIpljCykje9CTpumRZo6LrNCRs7FOoIdKNF2El1kZ2NQTk7fxCTb7FgW8r0FUmvG2tsPg/m/Ap
	fWxtjRDZ1ZYjEQaEZc=
X-Google-Smtp-Source: AGHT+IFtJ2f8jik2VpCMozGTwyPVMAvqAPL+DxY9IEtBoPBviqLhHx0+/MG4ujQs9QmkqLdBQQro4JmHC14bV36zRE0=
X-Received: by 2002:ac2:57c7:0:b0:55f:5c1d:6cc4 with SMTP id
 2adb3069b0e04-560995d6aaamr289653e87.20.1757026569389; Thu, 04 Sep 2025
 15:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <6d065f550fe871cf010409f7bd2a63438cf52723.1756496539.git.gitgitgadget@gmail.com>
 <aLIG5bLOisbxfn1y@fruit.crustytoothpaste.net> <CAH=ZcbBJV0oT1Ht6qVKmq7xG8ki9Enutq+VNes4n9+2r+0nrvA@mail.gmail.com>
 <aLcdwiRpD1Yo7SKy@fruit.crustytoothpaste.net> <CAH=ZcbCgYEVrhejh66H4xqpuXyZj9jh+JqfH3mYik206-fVTSg@mail.gmail.com>
In-Reply-To: <CAH=ZcbCgYEVrhejh66H4xqpuXyZj9jh+JqfH3mYik206-fVTSg@mail.gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 4 Sep 2025 16:55:58 -0600
X-Gm-Features: Ac12FXwwzBQVAkYsJ9LWWsZESq8xCRnLA-pCsNGcTX344rEx3BoniMxyh0tmy2g
Message-ID: <CAH=ZcbBzqHfikO79JyFRvWVvh+vFQtXmhXViJWuW1yq3Xa04bQ@mail.gmail.com>
Subject: Re: [PATCH 01/15] doc: add a policy for using Rust
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Ezekiel Newren <ezekielnewren@gmail.com>, 
	"brian m. carlson via GitGitGadget" <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:39=E2=80=AFPM Ezekiel Newren <ezekielnewren@gmail=
.com> wrote:
> Actually now that I'm knee deep in adding cbindgen to Rust it'll make
> less sense to add it later. I'm currently working on refactoring my
> entire patch series to include cbindgen from the beginning. I haven't
> looked into cbindgen until now because I wanted to understand at a
> deep level how C <-> Rust ffi worked rather than using an automagical
> tool like cbindgen. I now think cbindgen should be part of the
> introduction of Rust.

I've been able to get cbindgen to work with 1.63.0, but I'm not ready
to release my next patch series yet.
