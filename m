Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796AB18892D
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865323; cv=none; b=szUPFNlER3rbIblQ0BkuXK2bHP8N7nlNad0onMeQdq0zLOvYNBPU/27gxQevu9gvNe4g3eRRFY+2bzqXjwug2wbNIEm3zWdXGFvBhGJ4eRrkgo3oHm+dIybzc7w6uyjG4H1fKQSfG3ww8UbVNyEB03nzy2W5ayivMcu7nG1POlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865323; c=relaxed/simple;
	bh=qTFKaMi2GquE6z5rr/6bFJsdTQ0oN5HK8ZxjCc7fpdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGQKCPVtcx3vqW9o4i+CsLk8iwxXs/rI0k4gZRIMZ7uSgkAlOrQUVl7A/JxcK0/17kDDADduVTuR+TaQ4//aBuNGvK2f0baxFdPnA8Huw3b3uVgrp/zJ3h4JBDUDnv06rHMWDtTg6PWz/E7Ozthdy/Mx5WLWDSREsVKQ3qGGtfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxj6D1k0; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxj6D1k0"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-854a68f5aeeso27757439f.0
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 10:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738865321; x=1739470121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=108ZTw5qgo3cGhdMQL76zfhzQ9cKMRFtv0LBGmFZtko=;
        b=gxj6D1k0PFDZqVCKSKkSSMy2iuqgn+nsXMZ3BUSzp7vZKCIWWFUaJ428Q1GiFmMsEe
         mcQk2JVm0K5U/JREvnC6W/x+Ascak0hjDsq3LPd+qjXIXtV7azK5L9WzOwoNdrRlX+jg
         ZMRKZ8+RfM3b8GxFbv4a2lM3A3Ige4LdFXAChw124L8nKG70vWzXFnjuy7eW2hTfL44O
         PFjrJ5eFC9GMZmpxB2ODgNnMIfQL3vqEymJ2KeOe6HQBa0LiZ0GZCDWF+W1rRDq8XDO4
         2XTAVWeel7GWsvdOboJPMm9poYqmHWQq2Eua7TWMg6Wl75Htr/8tXbnz8IcXVpTwC9gV
         +O8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738865321; x=1739470121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=108ZTw5qgo3cGhdMQL76zfhzQ9cKMRFtv0LBGmFZtko=;
        b=hDKupmXI0XtpCFkKWQ9v7vvW+rrvng1h1zqJtvmp7k9p/TaZMyv5O6OflOPlIjYkeU
         JB1dtKr3DMbDpW9XsQ4fPsn6DtkVbystLAOM6L+sajrZdhJ+IiTyyPmKATN1c7yq5NQA
         SXQX6KiUAjk5508Rh4T5EmzvgwYABDdYrx7ZBH5Mvk7UbJm8qlDTxG+lbTxZV6BKK/07
         9ZinlghNnE4SAs+zJLnufhM1iLHerUdPUYTfdyybRDify0ZKr8Keuh2cLHurp+yRkc+U
         dFjCGfavToyd1HGsvhrUi4OYkMkLgiZ8C66v8H2A4zbdXWogrqwyse4X3swVDnm5PS/j
         qbqg==
X-Forwarded-Encrypted: i=1; AJvYcCXmvzMZtHdHHigfu8vQJV+2golXK0wsVSSUck9W7K7S28SKAVq9M1X2qgqQ2KSCcEwWZHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7SlwcLeSRJ2MW8zeLz9GFApZHr+OQxDOQajJCOVJjIMbC7Hpn
	TzWWbDWctz1Yt49iCmDuw2s3ctnwpQTaAAa1c9wAfB9S92k9awk2gSuygbampWg4dqy2l6z+urE
	AwaaHXqJOqI3+gCIvK4/kBhqSQVA=
X-Gm-Gg: ASbGncsCT7dooKN4oSUehy08ERHmToOFcZOQkrN/+YULQz7pzhVobsmI+UGzyHDzEMS
	jcCOsTS7ODCU+SBQMkiX6Q3L+gw8WxUccpKyb9DinuktFV1Pc7dvyMVINnSMjYoHNUOXmL15IAm
	VfaKU4uHZqoe9BTSQQKvwp2Z2cnGgr
X-Google-Smtp-Source: AGHT+IGVccxLCeU3mVuNBABG5LNK4a7iJeAAy6WuG8wnkwzp/qFSLDyKuye7h4yTrGNdbaaoKJZFI2FSORyZBF8NRZI=
X-Received: by 2002:a05:6e02:198e:b0:3d0:137a:8c9d with SMTP id
 e9e14a558f8ab-3d04f422693mr88799635ab.8.1738865321437; Thu, 06 Feb 2025
 10:08:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206042010.865947-1-davvid@gmail.com> <xmqqy0yjjix4.fsf@gitster.g>
In-Reply-To: <xmqqy0yjjix4.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 6 Feb 2025 10:08:29 -0800
X-Gm-Features: AWEUYZnx34WmoA6UZkWjRRG0PR9jhbzQ--o43JM9ZRjm-ZHXP6XoY17vHd_dZrU
Message-ID: <CABPp-BHpqSRy=G4HB+QtbFuP8Bohw6Cd99va2++PawehCDt0Aw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] difftool: eliminate use of global variables
To: Junio C Hamano <gitster@pobox.com>
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 5:34=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> David Aguilar <davvid@gmail.com> writes:
>
> > Move difftool's global variables into a difftools_option struct
> > in preparation for removal of USE_THE_REPOSITORY_VARIABLE.
>
> Both may be good things, but I am puzzled by the "in preparation
> for" part of the above description.  Would it require we lose these
> three global variables if we wanted to pass through a repository
> instance through the callchain instead of relying on implicit use of
> the_repository?
>
> Aren't these pretty much independent and orthogonal?

The declaration of 'extern int has_symlinks;' in environment.h is
guarded by an #ifdef USE_THE_REPOSITORY_VARIABLE, so if you want to
stop declaring that, you need to both pass a repository through and
stop using that global variable.  (The change to trust_exit_code and
symlinks vars do seem to be independent, but kind of make sense to
handle at the same time you are changing how has_symlinks is treated.)
