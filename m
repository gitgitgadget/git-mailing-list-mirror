Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A7D1FF610
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744815000; cv=none; b=lnxMqlKd2cZX1qrnts8KImCFaQ+8BotyL7pyhbt/DZHUHkt8EzNwijAFYMA0ZzcL6iA/gsn8eJZYdChCoeqQ81jcZecLQA5ScQKiBstBsQoLD5k9p/WuRfO61EyHd6WwiHiXxCTt7Wyy+LAiyfbgGGB42H/J0+wQUzFsEObRoGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744815000; c=relaxed/simple;
	bh=rb1GehSZlmSV22cyjn58zxkAvkMBLr4evypRjgi4qkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q04FfGiBKXuDM/pd4stVAXm71ZdGHw86soXpCeitklRfb1P2rZme+o+vAzVQZXNl69TYl8RJNp1jOp8mBjS+8FNUZJdvgm46FcjClXYHdVYLIBre1YtlkIDEJ+xddeWgwCmVBg9iHrhJCUSYHcJhzBnBOld2hBW3B/W8AgrKKGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlIOxDBo; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlIOxDBo"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47663aeff1bso61068981cf.0
        for <git@vger.kernel.org>; Wed, 16 Apr 2025 07:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744814997; x=1745419797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDKXvCAlgMRYhMB1mzigiLYjrnP+FLTWy8Wjk/FVHqw=;
        b=GlIOxDBoTPt6dinaPPBzk+ptPnM6MtAXmLBUEFWyi5Y1OH6nSeQ3TkrByrMvTOPKa+
         m/SR25ISUlvDqRw/r0BYxZ/Ce/Xicg7A06IZhC2OgrQTJa5xEz8mnAdEpIfrR0YRU8dg
         dx5KbGhJQ6Vz8Q3aoUcaaHEC85ba80pJ+6eQAwbFFyHN+maaFltMZbY9DhzMiKsLspcI
         /vWp2TeqA7ZZbrno3O4Ld/gkZ+wWnc66e5Y2DcRcH7Zso0yMRXxyroRRDUpnCXCs2GA2
         SJgRq7vCbodO0Q1slafcueSelvQFq3MpdR3lLz1fD6G5W5pzdVJeop80XURI/SYDme9Y
         s2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744814997; x=1745419797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDKXvCAlgMRYhMB1mzigiLYjrnP+FLTWy8Wjk/FVHqw=;
        b=lZBdO/QNOkUMIBMjRbOl39sRbjFZHLr5EJbMHMpSzeVQlpXUmE1t2vKOFOTQwXVcr/
         9D8D7iupA0UFLruQDbpUvjKYyJIKykiDm/MnInezuLUYlikVSYF1Q86FtNiOJhQYfWHi
         E/+EgvRoAQGVdbDxmF8fIzCNOOR1YFXhihpbues0xWHtHoi9HU3m5tkuX/ORHrgW1Q3t
         MBgjBVUo7uZUlFSuevyMpIcvlygLIVE9TAyoIvSqoEL5aYoER8MfLlORi3M4dz0fZ+vS
         uyogBBCCCVWIQ1NfRrXIFQuDMPDSdfgNQhoHAOOk/06k3Hc/6p7C2UdpSdXG6Rji8kS5
         f1cg==
X-Forwarded-Encrypted: i=1; AJvYcCVtrZveVgQw+fEW6UQHVYkMu3ZJi1rakMy2f/ouXWmOMNzYnFdvI0sWXOSbIJhHG9yZeeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0bqZwkZE/09L5OLWGgattE0DnUOlOlDGSlTTmATLAQa60hdbY
	qYMqZvweV+n4RL9xBXucB3kF1WbCd0q7IKZyersm0fOoApyXGq+3YdYyht7kvoKJdSZAr+pemJ6
	8U+z+B4l9/m69JuVk+lpLQIWCyEE=
X-Gm-Gg: ASbGncvhw8tS+oI0Kd4XJL7EYZkWT/gUzKCRYw0MGpWmdD16VC8VCcxwnu/ZfuV64JA
	zw3tqD1oZVT9fVeMALh7i560gfZKyzyGGFXBxQQ/qVVEbS3i6La9Qd7h5ANHmPJeKrB3DTsa6Pf
	/1fSSlMPcRsOy9SqiDmWaowzdxJ8QQPOjUyOmxZ6wJXDfnWa0urZx4Frs=
X-Google-Smtp-Source: AGHT+IFs5R1KD0Sz3fI1fqyLKph+ptNAKNVoCICrHcHeh59LwrtPEtWM8/WkoFT/Sry0/3es96sw024elMzmwH1Wuk0=
X-Received: by 2002:ac8:7249:0:b0:477:5c21:2e1f with SMTP id
 d75a77b69052e-47ad810d6a4mr21764481cf.34.1744814997644; Wed, 16 Apr 2025
 07:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412094607.236382-2-jayatheerthkulkarni2005@gmail.com>
 <20250412174051.780148-1-jayatheerthkulkarni2005@gmail.com>
 <Z_7ekhsBzXK6LKuV@tapette.crustytoothpaste.net> <CA+rGoLfAidyuomeNym5WX8Bo7-jPcfHx35wDeZ7W2aorAN-B7g@mail.gmail.com>
 <xmqqa58gjlnk.fsf@gitster.g>
In-Reply-To: <xmqqa58gjlnk.fsf@gitster.g>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Wed, 16 Apr 2025 20:19:46 +0530
X-Gm-Features: ATxdqUF-YPtCG9BFZfy687Bpb6aVjRNb5W_0Vk8su3GAKBfzjKKWpSWLtCbPZXg
Message-ID: <CA+rGoLesZ3nSjruJ8_XRWVsFpMu8mo_4cCOdB-GFHU_qXkXDCQ@mail.gmail.com>
Subject: Re: [PATCH] t3706: Add test for wildcard vs literal pathspec
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, peff@peff.net, 
	piotrsiupa@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 6:42=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:
>
> > I think something like git commit "*" -m "Test" also would be a great t=
est
> > or even git rm command.
>
> Yes, there are things other than "git add" that  take pathspec (even
> "git ls-files" does so), and demonstrating the blast radious of the
> existing "bug" you fixed, with how they behave differently and
> better with your fix, would be a good thing to do.
>

Yes ls-files is also a great example, I will add them in the test.
I think for the pathspec and glob specific commands almost all the commands
share the same code, so it should work the same for all.

> But make sure you follow "dashed options first, then other args"
> convention.  I do not offhand know (and *MORE* *IMPORTANTLY*, I do
> not want anybody to depend on) what the current command line parser
> happens to do to
>
>         git commit "*" -m "Test"
>
> If you meant to say that a pathspec with glob, always write it the
> right way:
>
>         git commit -m "Test" -- "*"
>

Ok, it makes sense, I will follow this format.

> > About the windows question, I think I will see if there is any common
> > ground I could find
> > But until then I think prereq is a great option.
>
> The FUNNYNAMES prereq was invented to mark tests that rely on
> filesystem being able to handle certain letters, so that may be a
> good thing to use.

Noted will add this too, I'm still finding all the possible files and
how they could matter in this test.
Once I do that and check if the CI works or not and if I cannot make
it work with both platforms
(Which I think most probably will happen) I will add the prereq
FUNNYNAMES as intended.

-Jayatheerth
