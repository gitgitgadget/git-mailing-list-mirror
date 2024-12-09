Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7039F13C81B
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761279; cv=none; b=kSknp4kd+pAYe45cjahJNLdZgFYPSkw2JD7rUR4k1sDIgkR0kTJB1LwJebXeCHoDd3BbEqQGGQKUvb2v6IxzDUGNxnPoyO4VqFa6VQud0I1slvaDUt8z8eHaM7fU/LwZXaQY9p8HJ2VlqUvgeyXpPKf98B+QZXB6zPXj0Nv19Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761279; c=relaxed/simple;
	bh=91v1o4W1Epz6s/Pdcu+jlVRxw/aLoH9XzVyMjlvYQyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+u3nRkV9/XzoaUE4hnmFq7lM5/MFQCoQAQjwOqeNkd4u9z5H/+mNkpfQSeBbVqT8yaVadUHiGoRDjkNeRtzr08b9rslg2lbvnYKcGI8MNCY4dzhiSALmewn65Jnxt7J5El58MGzHMJtMCOd27iVJG780YFSGvNY7F8qqCjOjnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTlKzMjM; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTlKzMjM"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e3a0bee567cso427784276.2
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 08:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733761277; x=1734366077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=91v1o4W1Epz6s/Pdcu+jlVRxw/aLoH9XzVyMjlvYQyE=;
        b=UTlKzMjMseJ54kOtHrddzswvn6xwfZTY7Z+w2VBgBqjxgyMCbPJ2iDKsqDyNr/GE0b
         ekzBYFE5Qafe8xVmvjKClM+OzHfZv1h5/P4ULhftvaPwSi8v9Hu4OMKokKHFtFnjwyqx
         b7bewha3M8CWWgV85a59E3+Nd26NGqzjPdEwpjR/MNJlAKeUKyXIBxZKnxok03R3j9kM
         mPcGoxOojlY2YnSGeIVQ+1pOOC+VVYr1KnAXa2ctix/4mnbJC24w9wxgXsuBhbJib2vZ
         ZyIM4HfObAxYQxRvHLB+VtEQi7NZNzLRZlXPmv1Ov8iFPD69S5M8wyfUbSOgVWEGg4dJ
         +kyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733761277; x=1734366077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91v1o4W1Epz6s/Pdcu+jlVRxw/aLoH9XzVyMjlvYQyE=;
        b=WGvcXn3CQb7LEgUiIxyx4OjhnPnREtlonMzvmnOGRYmrnRU8V4jVBvq1iGCmPwMN3E
         e8V54mxioRX1HDIu4LjM5ByLoCYMs7N3XXYyAUj/jWcTfHCeaMX2ck+wYu9U9sHkgG38
         eIjn/h3B+EtEYwxI2nyYJR6szwVN5RSsdueJSE7AnhNnYu6BRHYfOlHZp7Yu/DFAUej5
         I4BV/mcrQ4jzIhen6CYzRVUg2WaPE5Y0zy1Zfedq9fxzdU8p1j/j3KK8dsyvtk/XAWK6
         HbBOYXxhQnfIlQ/Ozc0dDRRh6kR8F0RvDwsXnRwetPUm3a5okL2XLc7wp/sDhok37fEs
         2wMA==
X-Gm-Message-State: AOJu0YzJmCh0fTPddL4GVzjVgdH166uMzeAQYwqWsjdiORJfQfhUHlG8
	E4rY4J6j+oo+xv75wsvRYgA8+2wewJU2Q7ScEK1ROEFzzbsFco8VHFed+ga5BcngyrjeDb8yTCK
	aKB5Myj+0Vf78y5cyFdfPwF1aNoh71re7GSI=
X-Gm-Gg: ASbGncvZ8CXph8cSI6w1qM7UKU+SSP42VmpIQ4W0mn23FIeN1rMXLTDmdL+sR1POG40
	UwCgx18zcuWyoU+k3gr00nEZJb+uG
X-Google-Smtp-Source: AGHT+IEY1+iMswhXswU5T6NtUoU1vYch6EJ6ta6wJVXgdchoEfVM8zl6X7A329kqlJb58zGLfu7mZ69XpC/WS71gtGw=
X-Received: by 2002:a05:6902:1b87:b0:e39:8a00:d443 with SMTP id
 3f1490d57ef6-e3a0b6e4764mr4572068276.9.1733761277322; Mon, 09 Dec 2024
 08:21:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207135201.2536-1-royeldar0@gmail.com> <20241207135201.2536-4-royeldar0@gmail.com>
 <xmqqr06jrqiv.fsf@gitster.g>
In-Reply-To: <xmqqr06jrqiv.fsf@gitster.g>
From: Roy E <royeldar0@gmail.com>
Date: Mon, 9 Dec 2024 18:21:06 +0200
Message-ID: <CAOfFammyK1Ef4_gOV+a5hiZR+Xhgu0o+=1Uu4BE2bGUACo3Jtg@mail.gmail.com>
Subject: Re: [PATCH 3/3] git-submodule.sh: improve parsing of short options
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"

Hi,

Junio C Hamano <gitster@pobox.com> wrote:

> As I said in the devil's advocate section in my review for 1/3, I
> often find the value of the variable spelling out the option name
> as well as the option value (i.e., force="--force", not force=1;
> branch="--branch=foo", not branch=foo; jobs=--jobs=4, not jobs=4)
> easier to debug and drive other programs using these variables, so I
> do not mind jobs=--jobs=4 at all, but if we want to be consistent in
> the other direction, this would probably want to be modified in the
> name of consistency?

I find this approach better as well, and I agree this is easier to read,
and has some other advantages like better ability to debug the script.
I modified the script so that all of the variables are assigned values
which contain the option name as well as the option value, and I will
post a v2 patch series soon.

> Other than that, all three patches looked sane to me.

Thanks a lot!
