Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176F7144D1D
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337015; cv=none; b=XiaS4Bu1m6virEXxY1mXuqKSx/aJvSojE2KIccFe+hM+CozPJ8u+PIfbRkWyNRzdYrLdBMrVOLHJhlp+51/9rdscuDQujcSPlpY3DMpjjg3Dr6MjgFufKHMKGhKNZk742AfqXlw4RQfzg1WBxz36ezUqAMwtbvV+OV867YG5G8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337015; c=relaxed/simple;
	bh=JS8SGxaa4Zri5Y1K9cuLHCcpCLbfRZNNhZaWnEKPCXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jvd0PfAUMPpTZpUnDeTtVzWypo5OSRxyJ8HZpjquJywul+lkK89vr3tx/1QFHwoDn8ObD/Q/URUd8q3bBj46s/iiTvQKedKwDdT6NDtWhSM5lED8I8pYLidVQknv0yLthnvQse3VwPlEoiqVABQZWff4yNRooTCbo41N7f/Cdj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhn+uvjQ; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhn+uvjQ"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7f3cc78afb6so1834139f.0
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719337013; x=1719941813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlLqOP89A3U/AIFS5Y7z0yiuF0F0mi/FnROB9pa6kvg=;
        b=dhn+uvjQWIW+HO/8SnfowvUAXk0shjBxGN35sze7Mhz/rgrmAo1/pRM7Z6oXl315+s
         uLxA7DZJq+GMWpMQKoaczUpZNGAepRYEuiL1AFNs/20LY5A2C8U28VlB4X/ilz4pUW6/
         jBBb/enP6YFA71TdrpBDuav4GE88ELix+EDj6QjGgDIVObVbGfUuA9FFdLSEqayCgB6/
         pTiwkQnVLjkRXW69xkRQ8KJUn4An5a5qgUVxpowN8jPcIouKLxAl2ogMldUo/Kleov+6
         gbOwCV6ZYu2wpcDiTARUwBEV2XtwBIlejHppG0WJ336tKpTk0RD/WCbhD45MdtM08Xeb
         9GXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337013; x=1719941813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlLqOP89A3U/AIFS5Y7z0yiuF0F0mi/FnROB9pa6kvg=;
        b=MfkRET9K0JlocPF9udPxC+FE/nAFt8XcJO3j02bJrc1cG2v/ueL+zhWik9ZAJidKNs
         7b+HmvwC4jfS0ORBE/b20GBXrLrQ6XoHN6gYHFM9mtpcziUlToigcFoQqH4C9nEIVMMi
         CmTU9zd43nWHNqWfrXtr3e0zAGr66LWniliKHZqVNqkWv5GFO0tkdWGtgTuqUjYlYyaJ
         VOMY85IdIij+DDaFFLWvNCc0RgczDNp8Xlo/fou4XH4ehFER6y1W0QZBrg+P5cCHr3lC
         JzKze+X59+LYC0E/5E5TLNUbo9CLOfXKbgfUuw2kIPjevYuw5XGsYXMSk3qQm8JOfPoB
         fUig==
X-Forwarded-Encrypted: i=1; AJvYcCUERuZ8DJ33i5wpWPy7TOgvZbXszZt/nWERKFZiAD8LPIowxAExwr6aGElWSJBVnBEPLBEgOOA7wb1D2AN/cOYNASZw
X-Gm-Message-State: AOJu0Yyo2AmXsMvSK1VZacrQLUrGFl4pWjUiHVVxmHSklRPAJe6xTkkn
	slaH1JpnoauaSny1FOBndndoUNLxFyMUVRE5X3GgorXRVbW1e7Ea/s8ZkArI/JP9NtPCXzhzXWK
	oDqrUHwo4ZQBFGeOiQb7yoU2VNJw=
X-Google-Smtp-Source: AGHT+IHR4AK85FPBmw9sKSFwE1056EAOb0NOEf/eRHGr4Kg/cXJKW9/IOfIAFvvl6K3GaClx1cVbh84AlEZJ5ejXj/g=
X-Received: by 2002:a05:6602:1602:b0:7eb:a2fb:6979 with SMTP id
 ca18e2360f4ac-7f3a4dd01f4mr834998839f.8.1719337013236; Tue, 25 Jun 2024
 10:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614102439.GA222287@coredump.intra.peff.net> <20240614103131.GH222445@coredump.intra.peff.net>
In-Reply-To: <20240614103131.GH222445@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 25 Jun 2024 10:36:42 -0700
Message-ID: <CABPp-BEMQkrwvT7M=QnEzWr-n0Z49AEJU8B-UhUgNDw0HCh5Mw@mail.gmail.com>
Subject: Re: [PATCH 08/11] t5801: make remote-testgit GIT_DIR setup more robust
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 3:32=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> Our tests use a fake helper that just imports from an existing Git
> repository. We're fed the path to that repo on the command line, and
> derive the GIT_DIR by tacking on "/.git".
>
> This is wrong if the path is a bare repository, but that's OK since this
> is just a limited test. But it's also wrong if the transport code feeds
> us the actual .git directory itself (i.e., we expect "/path/to/repo" but
> it gives us "/path/to/repo/.git"). None of the current tests do that,
> but let's future-proof ourselves against adding a test that does.
>
> We can instead ask "rev-parse" to set our GIT_DIR. Note that we have to
> first unset other git variables from our environment. Coming into this
> script, we'll have GIT_DIR set to the fetching repository, and we need
> to "switch" to the remote one.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t5801/git-remote-testgit | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t5801/git-remote-testgit b/t/t5801/git-remote-testgit
> index c5b10f5775..f8b476499f 100755
> --- a/t/t5801/git-remote-testgit
> +++ b/t/t5801/git-remote-testgit
> @@ -26,7 +26,8 @@ then
>         t_refspec=3D""
>  fi
>
> -GIT_DIR=3D"$url/.git"
> +unset $(git rev-parse --local-env-vars)

Ooh, I somehow didn't know about that flag before.  TIL.

> +GIT_DIR=3D$(git -C "$url" rev-parse --absolute-git-dir)
>  export GIT_DIR
>
>  force=3D
> --
> 2.45.2.937.g0bcb3c087a

Makes sense.
