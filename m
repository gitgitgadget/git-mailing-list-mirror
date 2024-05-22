Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6C3322A
	for <git@vger.kernel.org>; Wed, 22 May 2024 02:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716345473; cv=none; b=aVWDcMFkMUK9poJxsT6XUT92CfXy2WcA0UITOta/NElmj+2urfhsdDvPVqafKqtAQ9UiqP3La8bHgHenSZeb/a7y4eMrdTsZQt27+m4+tS5HG/ljDq99Qmpeivo/McAQ8uNstr4drAk0F9gM1Lk0Nvq+fg91d9cZT65slnt2WLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716345473; c=relaxed/simple;
	bh=qqB7wkY/1vBxkVcDeGFeIcvWoiF1wXtvpHJtajnafBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIj172VVr47+Bh2yivKXtYFvh67qHxWebrV/k5Tqe4oecV0wo1Qhgoei5vJKFdnUC38DEDgkfP77+LealtHz8rBVjzKZSgDAFQGqUijOLfl8Soz1BhUVBE8KYRB24H8NeGx9WLxCi/+D2uABezWNoGwfgP/0/DFDChHSfH2gn64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IK81noUV; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IK81noUV"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5b2d065559cso1958388eaf.3
        for <git@vger.kernel.org>; Tue, 21 May 2024 19:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716345471; x=1716950271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qqB7wkY/1vBxkVcDeGFeIcvWoiF1wXtvpHJtajnafBw=;
        b=IK81noUV70unDlvg5ZK9hxNptNEiftZh1m7Z6xTUFHhQ3iyP2DaSvIjLV31vcrMwTO
         EwTz+WIr+T02kCgpSMsGEIyP/Lu3iF+3KWw5EZXwom/aMcoRwlmTal7dv8LASwBG1kDj
         DQl4IKueIKVQiR1IOv5O4396p5sE5AozVu0vgmIsnTH1GU0QQBbIarONNJ4wX/aQ1mwy
         6mAPYXRJ+OU5XEpa/dptvqtwkHUuwZ8V1xUqz+P4kiBGHFZcWWpnae9IxQZvxDw0AztW
         6L5XpKDGk2xWatUmJ4oYuVtgarihLMIocNN8f5ZincYyvkdX5K+OQDmLMXi0FrfUGflz
         ETfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716345471; x=1716950271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qqB7wkY/1vBxkVcDeGFeIcvWoiF1wXtvpHJtajnafBw=;
        b=Oo2wGbGXwfobVCfK+9kzxYCEi8JaPuvYuQ1orOKq7fwxy8xPP/pN/Vk+ZJxgNsLJsa
         hDRHh/psSgsCrgUKeRGQG/wg3oEyrTPlExXS9Mt8OltO3+lWwGgfiM41HVoK8x/QdgxE
         LZiCRDDU4Tv4A70x5n2XlffdutQxxLTX8JlQpKPJfiT+otqz3Cre6r/5i318iKA6u7eQ
         sg7IyMuILXPxrZznR6YnaGnHAzDv9wFS8rUtjnyu3oZjLGttjGg73zsZLqe4IsRK0Ltv
         BDfyDt1RdINuVmlL3QUoG29rN4gXf2sxGeM/vjU1jcRIcfeqdHA+Zzw3wbVOZafiunST
         hr+g==
X-Forwarded-Encrypted: i=1; AJvYcCUzeKwEWQI+GfuQ5kMsjrk0UIjBdiMtzSOsN/UCPciGRdKAyzWa+oCqJe/JNECLsv2SRjoDZlKRPwfnO/ojenl+SBpw
X-Gm-Message-State: AOJu0YzPbYC4CyGc0itOLjmBpydsK709Q3u1gQvMf7IW4JLgFTjhUHE4
	rr/P5LYEgIT8X2A+1+nbJvns/mBsbIeqtZldCqfeCW9lxahVaC2O/O/6k1sDWyghGgIs1K9mWmk
	nPsOCtMFg3q8Ctp1PRwe8VfwbZRo=
X-Google-Smtp-Source: AGHT+IE9JvQAAidsRpcSV4O/n0cC0g1n0tC4UeImtaIEWc1/AoaCfCzR8gscwFCTGtI8MV0r7/DNnY4OgI383t2wth4=
X-Received: by 2002:a05:6870:7249:b0:22a:9c40:3782 with SMTP id
 586e51a60fabf-24c68adf3e6mr987395fac.11.1716345470978; Tue, 21 May 2024
 19:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKkAvazeFvCfT7tZm3emwA=k-NnzPD7X0v4t2E9Ja4r-GpZfoQ@mail.gmail.com>
 <20240510221323.GA1971112@coredump.intra.peff.net> <CAKkAvaxFbcLZNdz5cdAF8ZFNtVT1qQYKWcmkniQ3Uzu8mdEt5w@mail.gmail.com>
 <CAOTNsDzLAW_2C2vk4y+=GRvsHKZ_C+rEtorFAuoZaDu+jhQhdg@mail.gmail.com>
In-Reply-To: <CAOTNsDzLAW_2C2vk4y+=GRvsHKZ_C+rEtorFAuoZaDu+jhQhdg@mail.gmail.com>
From: ryenus <ryenus@gmail.com>
Date: Wed, 22 May 2024 10:37:40 +0800
Message-ID: <CAKkAvayTe7yU27G3HKZaG0Ch0gGDC50+sxonFQ08cPdDdHsKoQ@mail.gmail.com>
Subject: Re: Error: failed to store: -25299
To: Koji Nakamaru <koji.nakamaru@gree.net>, Bo Anderson <mail@boanderson.me>
Cc: Jeff King <peff@peff.net>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 May 2024 at 22:30, Koji Nakamaru <koji.nakamaru@gree.net> wrote:
>
> The patch fixed error handling. This is the direct reason for the error.
>
> cf. https://github.com/git/git/commit/9abe31f5f161be4d69118bdfae00103cd6efa510#diff-9dc7db77a1c795b4849ac77ac8d618a75c85ff3b2128501ffa647c43df200d60R308-R314
>
>
> Koji Nakamaru

Just checked with git 2.44.0 and it has no such issue.
Therefore this is confirmed to be a regression in git 2.45.0

I'd expect such error to be skipped and/or ignored, or even update the
store asynchronously, maybe with a config to customize the behavior.
