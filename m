Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78621B592
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709402552; cv=none; b=GvpwagFN92SLyrDMaAMaCe5ezpF86v+qc8LXxSS/84Tm/h5chYq2IQ671U5bH0qVEiD7pYMcS3LJRApwpSszg21y14KYHr7XQJovyjHtpt4sFoiqAQTKPuQanmymq3wYV306k5t4gmVfSI7n7kIjhH9rM6clpAzJSu0VqwLhUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709402552; c=relaxed/simple;
	bh=yLmSnBiMSY/oxbzTg7objV4kfJV/M7G1mDIudqyCvAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lX980HCK7iAWdMNBCVXdir5G0wS+T2tjM1L0MJdHRdSRaRb7M5vLD7zTKrxmVtiYKP5abvsOJZPUDoexiHfAOGlwEUp8Gvii+stiq50mvIcgBogBnRaxxL+Du8mTVK+BWKFUaOh14t4ey4lW6D63/1nNl8YJx9h31wcpJkF5RpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juL5UBnH; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juL5UBnH"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-21fdf31a154so1755393fac.3
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 10:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709402550; x=1710007350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d71zBoKCyaRHzLgzW9bf6U6ZqlMHoGqpMeIBD4ghE2M=;
        b=juL5UBnHy40iDzV3I9soBbcltyo/TeaBQ7RTe/hzFk5QdVpBLsudJZKSNhgGY1BoqC
         xU83Ai1BEHJq/HkGjWnu07tdWNLAzvNNLqyXlYbMtUikiuth5PYYOh1+/4wmJrmRlNzR
         +yy0yD/DUPDR3sju8QPONF46R/X402FsuoZs9VNIpvvwJJhN4akDoQi7SDvalpEkvDA8
         zJye7HkBdUthzuOyMXIhjR2+RsV0ytkzpQfKFiSnUKUtnoHkv+l52gfZvu7Sek8r98AQ
         QH2TfidOTJm1vkYB3MsgKcnbLe46+5wHBfGKb7wQWlyOo/SIhDteknHFKj2Os9v1CMjd
         Afsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709402550; x=1710007350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d71zBoKCyaRHzLgzW9bf6U6ZqlMHoGqpMeIBD4ghE2M=;
        b=S+aFnIauzbkqKSrUVFBLrhv5tDLJNgg5OfoMzm+waNP3MwJZZE9YBDFlutaaYnu1XK
         G8ASuLiFPR1EqYbwI0Q197cbsAIpxfMvpDK7ft82h2G1s/1ZvIUu397BdJ75Duxt03r7
         oPnRZC7i2UlnOQRNPZP2gqh73z0HwNtGe6c9UNs6/s4mM7e10/Wdy5CRppvQkpAU0DUa
         T+sslfiNCWy3skg51YySuh5INEbSjo8/tvewU5UW771/0LHQ5/e36kHMG7R7iCWG9t7w
         2GCHPU2xXWoxebcE0IRydLRSe0dbHYfvN2HRoB+jyBJFcARiexqESp/lTHHpVL/f/O6r
         3gug==
X-Forwarded-Encrypted: i=1; AJvYcCX1HSjhurh0E6eId+jF8phocdpqs1EPrx/F7RtLr3cYq13pB5hLXMnaJt408ZCeL7hiRDv+ht7gmvZwnEimuMaNstPb
X-Gm-Message-State: AOJu0YwqvnU6BZvDgDXHsyIOJ4Eq1WvxdULldt974/rR/+HzCUas9TmH
	8TVjRkukClo/p27rkTNMXY9vr2IixWLnoQTQaQkHeG1QQPL85jvNKiWSyxDcCTQxiDvt84loSA6
	3FEr1RypxlErXNyRts+O/8RoxrdULFV/GXyRjpA==
X-Google-Smtp-Source: AGHT+IF2AxLAau6kr3PqgVVAFaKElmP7aleis0Evr7ywbFMgYZpQVT+PZpToV/jQhy+ivcvX9/78hNSNFwNtMQYALt8=
X-Received: by 2002:a05:6870:81b:b0:21f:cc34:ad6b with SMTP id
 fw27-20020a056870081b00b0021fcc34ad6bmr6359101oab.50.1709402549646; Sat, 02
 Mar 2024 10:02:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a7be415d-5005-4fa7-9b2e-1974b7439a81@schinagl.nl>
 <20240302095751.123138-1-karthik.188@gmail.com> <xmqqedcszhty.fsf@gitster.g>
In-Reply-To: <xmqqedcszhty.fsf@gitster.g>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sat, 2 Mar 2024 19:02:03 +0100
Message-ID: <CAOLa=ZR6tN8eQhByaUobj3kS9wwYegsOQNT8cjZYA-YATJJt7w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Support diff.wordDiff config
To: Junio C Hamano <gitster@pobox.com>
Cc: oliver@schinagl.nl, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 6:03=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > This patch series adds the diff.wordDiff config option. This mimics the
> > '--word-diff' option of `git-diff(1)`.
>
> Is it even be sensible to introduce this configuration variable in
> the first place?  What would this do to users who set this variable
> and use third-party or their own scripts that run "git diff" under
> the hood?

This is definitely a good question to ask. I'm primarily not a user of this
option, and this patch series was more of to start this discussion, based
on the request. I'm comfortable dropping the patch series too if it doesn't
make much sense.

>
> The usual answer is "these tools should be using the low-level
> plumbing commands like diff-files, diff-index, and diff-tree", so I
> am not worried about it too much myself, and the above is purely the
> devil's advocate comment.
>
> Having said that, running
>
>         $ git grep -e 'git diff '
>
> in the collection of scripts I use [*] to work on this project, I am
> reminded that I may have to be a bit more conservative than I
> currently am about the risk of breaking scripts with the changes
> like the one being proposed.
>
> The proposed feature also may break those who use the git-prompt and
> diff-highlight available in conrib/, even though I am not sure how
> badly they would break, because I only looked at the lines given by
> this command:
>
>         $ git grep -e 'git diff ' -- \*.sh ':!t/'
>
> and didn't check how the output from 'git diff' is used.
>
>
> [Footnote]
>
>  * They can be seen in the 'todo' branch, if anybody is interested.

Having said that, wouldn't this cause a problem only if the config is set u=
p?
Meaning the user must explicitly set `diff.wordDiff` for their scripts
to potentially
break. In that sense, is it a breaking feature?
