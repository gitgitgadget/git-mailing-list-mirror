Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B45457CB9
	for <git@vger.kernel.org>; Sat,  4 May 2024 06:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714805510; cv=none; b=IxjkoZNBB3UYDueYRhQGLkVyDUoD8y+2NJGCGtJLxyamq5pQLYk2DmMnQFjXtqD+7ohSSbkMIljlFbwd23Asey/UjiZt2UteJyzLjTsJwKdFMMBmQyL+1dKkR7nd/B9WUxlrhfGo+w5UORFJgNA6SQAGExfjv7K7G7zuNlw7kMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714805510; c=relaxed/simple;
	bh=UjOsfcYJCkKQq2c0//2yfDqdDpX1adsj+Sxjg+g2Fno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDTODsCtZ0e7IGiT3f5DOWKwRY+RXWaTUOcCV6EthZzMnbSrBjsRqJbBcv5BiVMeNP0x4bwl/1qGozm25ELUWyZsWZdQknSLCWLy8pRBBlSHgZRL9nnJcdOIYe9cAD3RC4yvhud0LiMYwf54Npnh7tt5opOVhZgkSkwzUaRzAdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+ETeAI4; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+ETeAI4"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59a64db066so61221266b.3
        for <git@vger.kernel.org>; Fri, 03 May 2024 23:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714805508; x=1715410308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjOsfcYJCkKQq2c0//2yfDqdDpX1adsj+Sxjg+g2Fno=;
        b=k+ETeAI4eoPh7+NZC0EiSlGdsXJElfpprQutU3r+DhDown7+SgyPUe3j55bRL3K7Uv
         8Yd4fSrFCzwJJrhmWM2X7BlhSPT1dBve6eXZ26ezgfD2ixudC0DwftPzvEEcQpwR/CBh
         Jl8BeS88eeh2lpJ3GH8nJq9oG2+88IWNYWzESpLkLtR71ptvsjvU2d/HYmMtHgsm6Qpe
         KmEPmsicjrlgLvbG/LHiNrnb/DrlL9ycS1iiQS7ceXzm60bPncQ3yjqeAELAAgPGjSRl
         E7+6SA0IvPaXOxXwLn2jPnSk6yHXnGTPVIK8vtT0Zesv+yIidPxLE0tNvXvW8PZ6NYzn
         Z5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714805508; x=1715410308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjOsfcYJCkKQq2c0//2yfDqdDpX1adsj+Sxjg+g2Fno=;
        b=Ulwbm4gAI7Mws8o6RGsOdYDEMxZh8uzBOBMpJFe63fexnPuluEbAU4CHoQVtQ6U5M0
         oFVjtZFEd8G0OmugZpfLdRcHZdMvo0YCRhKfzbOSxTxRVZe3jdw6inOq1Rp0JoE7FF/N
         VfpE3D2CJiTqN3b1oW4o+PdQslXVFSPA2Et0pAmRV+S0EaKmo/qcnAfT6WXe4GYUIGK1
         UGxqko/wt/uP9OV6Rl2F71ZrkDZF0W6szOgr/0cwJHh6Rq/Q68S7LoGHQFOIZuXOjySC
         axtv/GDekYshk2EfgcUHhE9fcnWIa0wLeaVTe2XmuGOSVPfh6kJnRdJnQzFm7R+3zvU5
         GJUg==
X-Forwarded-Encrypted: i=1; AJvYcCWd1+yOMSjkH31xkKAglyx2dr92j9YYxLQmKr1bgX/IcFMWImMOTgQkvbmYq+PQ13qFFjaGriprCpN16Iao+Ag65Fag
X-Gm-Message-State: AOJu0YxiY7X4KQVpKkzFw8BTrLSpXzCytJQh6n9cvVCdjNAo8Yx4tIGl
	1Bz2soEi/pa1po8luRiF7eIbHfvi1H48bXcjnb/qfe4C2YC9Y9g0ihrHCmvzunIAq3s863Znzgw
	HyPu2+Sl4TLFv/R3heYsPpz3DlSk=
X-Google-Smtp-Source: AGHT+IFCOWUdau0ImviX3x2Ht1XfYPoBNF1o+Ov7qmINCIRaG4jGRbuwUI2IK+HWZWkUtFMZks4hoobP2JYh1U6gW8Y=
X-Received: by 2002:a17:907:9952:b0:a52:13ff:5317 with SMTP id
 kl18-20020a170907995200b00a5213ff5317mr3269037ejc.38.1714805507498; Fri, 03
 May 2024 23:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430003323.6210-1-jltobler@gmail.com> <20240502193840.105355-1-jltobler@gmail.com>
 <20240502193840.105355-4-jltobler@gmail.com> <ZjSKqaJxd55328Fn@tanuki>
 <awbex2f6p4sqdneevwrsba4gayidhvxrdyqjqffcn7ub5imcmm@t3wfqe5xmytv>
 <xmqq1q6ialiu.fsf@gitster.g> <ZjUmEuKZB1xwAPo7@ncase>
In-Reply-To: <ZjUmEuKZB1xwAPo7@ncase>
From: Chris Torek <chris.torek@gmail.com>
Date: Fri, 3 May 2024 23:51:35 -0700
Message-ID: <CAPx1GveuQMeKt0_ZuY4DN0_tKrLBjXpWLngxYTtbzV=iHYT-QQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ci: separate whitespace check script
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 11:27=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, May 03, 2024 at 09:49:13AM -0700, Junio C Hamano wrote:
> > This is a question to Patrick, but what makes it bad to assume
> > "bash" is in "/bin" when it is OK to assume that "env" is always in
> > "/usr/bin"?
>
> My own bias. I know of systems without "/bin/bash" (NixOS), but I don't
> know of any without "/usr/bin/env". But you're right, "/usr/bin/env" is
> not part of POSIX and thus not really portable, either.
>
> Ultimately I don't think there is any way to write the shebang so that
> it is fully POSIX compliant. So I'd rather go with the option which is
> supported on more systems, which is to the best of my knowlede env(1).

The various BSDs mostly stick bash in /usr/local/bin; some versions
of macOS did not have a /bin/bash either, as I recall, though my current
mac-laptop does.

In any case, #! /usr/bin/env <program> is pretty darn common; it's found
in a lot of Python scripts, for instance. It works well on old SunOS, on
the various BSDs, on macOS, and on Linux, provided of course that
the given <program> is installed at all.

The *most* portable method is generally to use only POSIX /bin/sh
constructs, of course. :-)

Chris
