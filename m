Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE271A00FE
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736341625; cv=none; b=UE2nS9jVzD8WWLgah+U2Le3k4tsPTdPbSc+rCw4pjWXLxIpttXRtgGfiRyDxGC2K4SgXEvG+cynrfnsEnZM6aAUvtx9y9MMxPx9hvV+7KPw+qk5DE2iTFFnok55B46AxWyhPbbzRHU9zsrDzh8WJHWWzU1LCm3+UGXSHYJErZ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736341625; c=relaxed/simple;
	bh=cXuTx6+wCD0AcLFURzYkBYkKEMH0Xn5jV4tHR/7P2oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPKynJd/V5w9phkwwaXEM/D6VK5FINc1rEAdKeX7IG2m6jdlMjSrhUooGDqSXa88fBOFRkdYRo2/072eg38/POLWEpo3ub3GKwAyQzXAKlnw8y3n3wtABCa0TwB/g2nSYvTRwu/W224mFGLgXK29VP63UPBKUQWhcf3ut5Rqiq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzKVbgju; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzKVbgju"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4afeb79b52fso4762054137.0
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 05:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736341623; x=1736946423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6kJ6x1Fomniq12SPhKB0f3jlqVUwiDYKdnCgtwHbhc=;
        b=kzKVbgjuMdj+3AGQfEuQ7upyLOQbqfvVvDlOF86gtUvbNZ+3yQv7lLAtRkPgvcE/Ej
         YRiClbV5xhAuuBctUcMF9c3zI8FgTwxKnf7zorHK33GjJ9YaGkvTQ8BcQpsyMdgLnNPG
         BIFcSnq+zS7lpdi71bFG8KF9rWOSz7tUsF8AuKLEs0Qb4UL33w0fSpgaYeQDePK4Kozo
         akCaLhs+VKC7WVv8cGV9EJZSi44aVXpiPVlfEUg8iAvyfGV6k8IgdyFzZpgvn+Wt3Fvk
         zQg+1pcfTPaF1SXQTHrdlb2pdfwQ2r00+j4iM6OcQFJGYk0QfPxPq80w5waXXg8jueYw
         dgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736341623; x=1736946423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6kJ6x1Fomniq12SPhKB0f3jlqVUwiDYKdnCgtwHbhc=;
        b=aHCetjRNjxHWvqtJO5r8j00scgM5rAGZj3e2QM0zB8TDHwPgooIorVrriI61JWaP5M
         VzKCxRf9m8tACOwHed8oxfL/OBrgVC+gOV76lWQAazgbXQ2cdOU2IIJG6Ejat0n0XLg0
         fUW1YGASOqo6tsTjm5hbmd57r+IVYZQ/WBRRxATYnYknVW0g7De9qeOsvAYnu2EXrkE9
         wN7NQFbth/sJz5JlSr9N6ZpKW+WQn2lorZF04dFQMUGQAwhFAwfOP1x90n48T1Mjwl6q
         MfET2vPidqVsahYdSqz8uAblRUXpglfosXDD3QcjwC9nQZ7DThOwDmdozjgRqc3ehey8
         v8lQ==
X-Gm-Message-State: AOJu0YyRDQQ3gM8gafRu0WjH64Vt0HjLtP3RmEni/o/aiX9Ojs2yVZ/g
	FVCC16tySu9dzXcX2iFUNi2gjbuFtSnHC65qhaoRLNpIXu7zymZ9PEYvPD2jZUYENIUXhBfE7HO
	/ot4pWQ1ErOhcQGYIJbN/Z2hHLEE=
X-Gm-Gg: ASbGncsu4i9CtnZ4VmW5EudtiA1ESBzLWJlYSEnimlgMkohd316SpPVcjvYD+/gLSau
	h3eRKBbK7zXwWy6e7c1PUxwD1oO+Zdd51qIs2rg==
X-Google-Smtp-Source: AGHT+IGdffMVkebA1H9+KqPXtoHeycAp87k7RlT+7FwRZKrp2foCvl9YLCowfKq2F2qQINWd+AYakHUm602KLzUdOT4=
X-Received: by 2002:a05:6122:1acf:b0:516:24c4:963d with SMTP id
 71dfb90a1353d-51c6c4303e1mr1744667e0c.2.1736341622989; Wed, 08 Jan 2025
 05:07:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250106103713.1452035-3-usmanakinyemi202@gmail.com> <xmqqv7usylll.fsf@gitster.g>
In-Reply-To: <xmqqv7usylll.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 8 Jan 2025 18:36:52 +0530
X-Gm-Features: AbW1kvYXo6UXuUOh5j64VrXu6GMAURJEGQyi1MomxCSIbkcB8OxuxZWkAB5Qqkk
Message-ID: <CAPSxiM_Cc+Si1Qoygn7me9jAqfV+B-s3p1uP6=qApnk-Q4X+wA@mail.gmail.com>
Subject: Re: [PATCH 2/4] version: refactor get_uname_info()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio

On Mon, Jan 6, 2025 at 9:34=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
> > Some code from "builtin/bugreport.c" uses uname(2) to get system
> > information.
> >
> > Let's refactor this code into a new get_uname_info() function, so
> > that we can reuse it in a following commit.
>
> This does two things: refactor and enhancement.  Shouldn't it do
> pure refactoring in a single patch, with a follow-up patch that
> extends it to allow the caller to hide the system details?
>
Thanks for this, I will split the commit into two patches in the next itera=
tion.
