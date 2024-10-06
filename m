Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DB8159568
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728217721; cv=none; b=HCUZBH8p2nEqXUvlDaaI5SyaooPOvJcsnZ/hRTFWMEGFtuTIRkC80ynoRRyJXz238HYGaQYJ+5K+X5MnpTp0dWOJbiq7jayCKnmRPyAOZ/S4xE5SJrBdLWLs/dI+TXKqm+awqwnV7Cb4AMGbjomZVLY4eapy3nO2MjazfcXoxtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728217721; c=relaxed/simple;
	bh=wQqYcJ4xRD1wIWc75MVa6LJ6JzkHzpU/h3VSWZi2nsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BD2w5pFZEFPHgv4ntuf0sAQMN5RSw6DWq4cDqyThbjjbcgtCsme+t5/7Tbe2ZCmQPQAEcJVbTSUgdLVIHp8JN4moIqybQ4JJLpjXxAVCeV0YGvckBGlo/v9pgV5cUwOUHsCstCHm2lpnLvIKjr5pbBFBqL2njkE6KTW4B15tE4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWSFV8xc; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWSFV8xc"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4a3c6bc4cecso972601137.0
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 05:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728217718; x=1728822518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQqYcJ4xRD1wIWc75MVa6LJ6JzkHzpU/h3VSWZi2nsw=;
        b=QWSFV8xcCnUyjmRt/yoXttBDwYQo8zrBNp/LQTUb0Ciy4Sv8OwIJ3ojLiv76dbdor+
         f4EX1U7ZWsCMC2v1BaFDusXtg2bGiykdT3XtSCZwKG+B/BM8I96hAmaVev6JPejIRWwk
         cJg4ACEFLmKjCyCKjkRk1kWLmFZwJ1CuY+WS190Tmg4th+Rx0gomo4Hg6Md4QOMTqjoZ
         rJdnNov7F/kQCDfaysYxquUgCAtWIvShlXv4HAOcEuWXTx+St1m+Kk07Hhr7AZMECigg
         d9kQRrmcCvFe2DEFNLQ1pE4i5/lFw6STTPSHz9RFcEr2snlHOUG+c0FxTZnXGw69FXKi
         1E2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728217718; x=1728822518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQqYcJ4xRD1wIWc75MVa6LJ6JzkHzpU/h3VSWZi2nsw=;
        b=BlrdQNjKkQR7o0QngvmrcofX/nW3qQHvZUh2yFQoz4ZC74DkZXsh0piXqOQfE35QJV
         SbHhB7xrZ+knKYpa0IGt2IefpZihtmqblAp9B3B7oC0obUhO3BHDQQ3GSWgu+HrNttuc
         TJUK3CAwxNeez4K9mnIkrt0lhckYf6b7K13ia9o11k3qc50bBZTETcrfTGY5uq19j4x6
         qCmgz0j/lFHK0/1htkfWi/iEEpcsxTkVxetSx4PZEGUDR/KDyYbc54YQv9rY8fpZDJoy
         XOyPZKl8EMw4sSQ2JhVrYSxtQQJu57tYtm69rwKWv8z08xna0ujC99FNi0mBULX39iak
         FsaA==
X-Forwarded-Encrypted: i=1; AJvYcCVAFaTQHfa7SqF/CfzNqR95k4/xs9nBSYmcOhweaE/CCpFI+NLlpRWuMdoGYbGlBQIHjUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/YDcLnXcX+HOnv4nl5IIHih1NYP6A7Q0dOU/ayY/EXTb3HlSh
	X4jjCWDY4EboAOycy5yScFIyaQYwiX8LFhE23B95d/RGhbkK3Hyms2FgHBVICAwwykPoXBHE5TG
	evqayAWePM6DfuhNVWqw6rEOKiLA=
X-Google-Smtp-Source: AGHT+IG1f9DBVBVSPbxveZW+SXAMM1I+H/IvjomLTkVIGodE3t3w3syYM+p1j63al8ZxM5Eq41KxScNJtX3KgAHV6dY=
X-Received: by 2002:a05:6102:32c8:b0:4a3:e3f5:2757 with SMTP id
 ada2fe7eead31-4a40575868amr5663072137.9.1728217718550; Sun, 06 Oct 2024
 05:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com>
 <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <CAPig+cRePbX6OyE6WhFp1GEZenZyC7HFeA3188F_nErt7Gin6A@mail.gmail.com>
 <ZwJwsuf5ZOKiWbS1@ArchLinux> <CAPig+cTVf=W5KXkE2iTxCSPmZjOSbmf90J_JugDuTH_xudcW2g@mail.gmail.com>
In-Reply-To: <CAPig+cTVf=W5KXkE2iTxCSPmZjOSbmf90J_JugDuTH_xudcW2g@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sun, 6 Oct 2024 12:28:26 +0000
Message-ID: <CAPSxiM-bx7KdhP0OyajfiTczg-WqiJDPso1EAxLzntLqcuOUkA@mail.gmail.com>
Subject: Re: [PATCH v2] [Outreachy][Patch v1] t3404: avoid losing exit status
 to pipes
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: shejialuo <shejialuo@gmail.com>, 
	Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I really appreciate all the maintainers for their help and time.

I am a bit confused now, I am already working on converting the
test_line_count right now. Can I update the patch or do something
regarding the first patch ?

Thank you.

On Sun, Oct 6, 2024 at 12:06=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> On Sun, Oct 6, 2024 at 7:12=E2=80=AFAM shejialuo <shejialuo@gmail.com> wr=
ote:
> > On Sun, Oct 06, 2024 at 05:19:13AM -0400, Eric Sunshine wrote:
> > > It probably would have been helpful to reviewers if the patch's
> > > commit message mentioned that it only converts some of the
> > > instances, but it's not worth rerolling the patch just for that.
> >
> > Except that, the commit title should not either include
> > "[Outreachy][Patch v1]" here. From these two reasons, I think we should
> > reroll the patch.
>
> Your observation about outdated/confusing "[foo]" annotations is
> certainly something the submitter should take into consideration for
> future submissions, but does not seem worthy of a reroll, IMHO. First,
> `git am` will strip those off automatically, so they won't become part
> of the permanent project history anyhow when/if Junio picks up the
> patch. Second, asking for a reroll for something which does not impact
> the correctness of either the patch or the commit message just makes
> busy-work for the submitter and wastes reviewer time (which is a
> limited resource on this project). Third, the point of a microproject
> is to expose the submitter to the workflow of the Git project and to
> the review process, and for reviewers to see how the submitter
> responds. That goal has already been achieved in this case, and
> rerolling for something so minor provides no additional benefit in
> that regard.
