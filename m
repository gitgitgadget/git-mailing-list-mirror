Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1C91AC423
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989839; cv=none; b=kgOIxhUcLMXLXTIAkLlquekGyxSiwAWbL0QfjohZhJiGgB4CmFcZHWC7xLT2fMggGOFiU7fmesyiWwNimcJBsiGRYIIzUJNYPYim1ixyXCKWUyxxRCvNp0DMfGDCoLdxL27DCXoOxMVWSP7gaevYdvECcI8/ljR+S4uD2uKaqks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989839; c=relaxed/simple;
	bh=xnlul/ffdtbCf/6mBj6fQAJ9PUIzOaR2GilSGHlU6Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5TnjfvwF4eVNkXTMDzwwRQzD8rx3+O2WQGEggYYKOebMXFR7ztR8LfTQNMm4XwT+bZvezV2j/PHhMa65XndwcTOPvRS6199PL6NlrqL0MPg0aGy4lRpPHodBHBo7hL9Z/rZwa+kBB0CH89jdA8cVCFOGrtyaNRQUJWPzIhhEO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBhRUo7U; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBhRUo7U"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5e1c63c9822so815111eaf.0
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727989837; x=1728594637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnlul/ffdtbCf/6mBj6fQAJ9PUIzOaR2GilSGHlU6Og=;
        b=XBhRUo7Uwv42Z5WiW7LLkyHszXe2flIlFD6vGOKCC+B70KyETCzlpx3qkuq8juhv81
         HM7b4SIwKpw4ETm4ySTQ5ZQ1b1/G7cwIWEQDySUi6DUMZffPVhJPsWTJ1CbeDwLXh5+H
         7Fo97Xmz5aZKEcvwr+pnSG4PrIX5PkZ4kjlYvvrieW3nHtAWfLt4zxFqgfDDjdiol0E4
         2w3UgI7B7VRQJ2YxNvvUq4XS2ps1s5KBcP0U5Ppa/8wYuq7YMn0FjNhq9V7kgUvqFGXP
         JG/+7uASlprObakvxfqj8MKG0zLbF7SACRGf8LbGQScT7i07Rt8xLOzP4+PsudZkETn+
         TNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989837; x=1728594637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnlul/ffdtbCf/6mBj6fQAJ9PUIzOaR2GilSGHlU6Og=;
        b=CTrpkbnkQpN7DVhwRIosZtEHbmT6XpI0QxMPj+WMStNqwNoi5JyY72ZsCEpL2rWouw
         GT07i9lc8dJixRq/xk0QdncmMpy+s0TJOf6YcBm4N5yv5b2r43ogEyrih+rbAOFnveTS
         avXj0tieiQsrzNoHaqdvM7Rl0gB7fRnJIL1YHWamfP/3+ROXEf5MVWdROn2ms6RngYa0
         G8gjdGRrl29CbQGmpk44Bupbmd3brpC5Ojn3TDnma63WnRvIW1iGnRh3OxDrREiPfOus
         4eayg2HntCqrf6DKorTAQ+Yg3EO0E9y31UC2fTyEHdzLIg2oQHYYXkKkCW7inJFpTb3i
         7+Kw==
X-Gm-Message-State: AOJu0Yztj2eu6sZEs7CIpmg6ccrT2AmLmz8wzLJtDy94cQZJRmyf1IrL
	BP1kRiBJ2TlGrXcM9NQEEfQ++kLE9pLbADVIS5Enjyt5vmWqwGODpuhJqFif9wcQdmiIpS6RBR9
	8V6MzGLzKN4cg95b1fnnLgtR1xYA=
X-Google-Smtp-Source: AGHT+IGUg8ISvLLFezrgMG6j/apqQaxuHxlvMqnF0EppqJeS/KlWjrqDugkcpn/xQqKNWx3Sfjo/ncrpyJ168jQLdgE=
X-Received: by 2002:a05:6820:2283:b0:5ba:ec8b:44b5 with SMTP id
 006d021491bc7-5e7cc05e00amr319536eaf.3.1727989837279; Thu, 03 Oct 2024
 14:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD9n_qgBPDQKF=ZEQ6SWvDCmcUXZvz33zSoHFQSwHmQPWS4z_Q@mail.gmail.com>
 <f2ae51a2-95e9-43d4-beba-774d05bfc3e9@app.fastmail.com>
In-Reply-To: <f2ae51a2-95e9-43d4-beba-774d05bfc3e9@app.fastmail.com>
From: Alireza <rezaxm@gmail.com>
Date: Fri, 4 Oct 2024 00:40:12 +0330
Message-ID: <CAD9n_qieu_DNqu-X-gTGua+K-vQysYRoDGzEBgwOhH-w4YU1Bg@mail.gmail.com>
Subject: Re: Request for adding a "one-shot" rebase strategy where conflicts
 are only resolved once
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As far as I know, rerere remembera an exact resolution, but with
rebase you may have to deal with different conflicts for each commit
This makes that completely irrelevant, to elaborate there's basically
two possibility:
(1) a clean merge is possible but individual commits may conflict
(2) a clean merge is not possible which means there may be conflicts
at some point onward

This only creates one conflict off of the latest revision (same as git
merge) or skip if a clean merge is possible
Then each commit is reconstructed based on that resolution so there's
no back and forth.

Hope this helps.

Thanks,

On Thu, Oct 3, 2024 at 11:45=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Thu, Oct 3, 2024, at 21:06, Alireza wrote:
> > Sometimes a clean merge is possible but with a rebase, in-between
> > commits may raise conflicts in which case a conflict must be resolved
> > for each commit individually, which is not quite productive and at the
> > end wouldn't add so much in how the resulting history looks like.
> >
> > With a "one-shot" rebase, a conflict (if any) is made based on the
> > latest revision, then in-between commits approximated based on that
> > resolution. This way the history can be roughly preserved with the
> > same amount of effort while still using a rebase rather than merge.
>
> How would this compare to using git-rerere(1)?
>
> --
> Kristoffer Haugsbakk
