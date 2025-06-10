Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CB728B7C7
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749549385; cv=none; b=DqjnFa32SZ3OmtEwzb/kCZjZpZkZg5bhJdDIBrtLY8F7YafQkMsMAxt8EICa8izNOvxGZ18U0omigFstqX6PpQCqxkGfR9/6NK9Vfo5wkruUgZYvee7LhCatrvmCWr6uV2CVtVC40GxIH08T45d8YDY/bjJKvIG97oeQnalnZRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749549385; c=relaxed/simple;
	bh=oYAmXIw1GL6qmx+8Vw9wx7eDsj2HEPnM2+oDlaTIFjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsJCzRtwP6bAcyie7gT+2MtSH1nhOXxEwSbHWxXoXR5G67kRiMImMrQUbp85OLi+X8si5vbrdFTWgEpR3kVPhwb9NtMemYVoUgrpK0e5E0zn4PY6TqkwD79Y2rM+SkwpinlIPfucvr04dMUIzzZzddj37IstnrwjF3UL2tecIHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lqrsc9SE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lqrsc9SE"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450dd065828so35376325e9.2
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 02:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749549382; x=1750154182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYAmXIw1GL6qmx+8Vw9wx7eDsj2HEPnM2+oDlaTIFjg=;
        b=Lqrsc9SEn/dFSoTGakoDDLjk8nCmaUKPNj8eR10m+7wwlJQ6TPuSFXAfQJpPEeaAeP
         PINDa9IGTKFqblVlnuIPg65QCGd7tZpJsE7QV+wL3R8iuE0KI4maUAx86kwlBvG7k9Yi
         21RdJXFKbrC7KZN4KsDyPT4s+NxQSMG+wwGfrNATAkUkKZeP4myVLmScvKk8ZKeLtFYn
         Py4DAHLstrPBdSrHL0La/Gp/FaKa7FdsJr/IqVFhgJ84VEolucSyo05fxotei0Da4g8B
         pA0TkNgABX6kN1YcAnJccuqI85K9hnz7GzW/iI2HGStHbKEyY1NMp9rS8ftvOSIKe4cu
         RQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749549382; x=1750154182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYAmXIw1GL6qmx+8Vw9wx7eDsj2HEPnM2+oDlaTIFjg=;
        b=GMZIJD2A2W2kvskoWLqTbQGW7ETBLhfLrbte8IYyC72jCClfF0mqM0wBVL7u+WRLbW
         BMWlLeg40A9MNCZF0HQxQjDN8Zr8Le+opQzRFSJgomjoXQcRvM1XP1YvBTyBYISJWA/e
         PxKkxQnB37rfVraMS4uJe8r/rvbjrpjy15Nyd/CQZ+3GxZzqcZkU4OuUx8FrIVRodC4d
         uiycZRu1cTRoUrzOmFfQJAhao0AywYJ5dF3U2lRvqhyfqUdpz2wjVTVcJLP52Weawr2Z
         hA4IoMVa+OcPrMpmYXar7BLOOPnDFX9iDxGQb6KnHyw7gFo10NSF1Ukrt95WTirAW4IE
         s3rw==
X-Gm-Message-State: AOJu0YzihAQOaRKeJFb8kUI6rxJCLwCqMSdf8HMWkFEcwSRiq9MANZUg
	c0w4ru8OaY40bxeS89fbIyo1BBLrlFU+Zh714s+ALoZ8GeSQNqj/UAJG0Gmble1jqOokhBe0MEt
	7Vh3rHhmlVDyS+6HDyJdblyqemL+4yAk=
X-Gm-Gg: ASbGncusnkE7gjChcAH8/bpS2vbCff+eKZHbvaPYcWTNXzpzPBB3ZwwHkGamBHvoWyc
	hwBX6J2XDKJH9ry01lWnR7DaA5fGKQGTrooHg7AS9IEYG38S8EZU4eErtXpTq4XANYI6FJwI12g
	gw2093yeWQ1mmvpx6SMBHtyLcA0dbdQoHnQsr9hLvwcy6RxLaDIYBl
X-Google-Smtp-Source: AGHT+IF/pjhZ5P05gucTahyCHJKJRg8jL0ZSJFoUcEjbNuo9XinLJeCtEtetkhtZb56WSHI8Jyt5mLF6jTK75T+tD/A=
X-Received: by 2002:a05:6000:2888:b0:3a4:c909:ce16 with SMTP id
 ffacd0b85a97d-3a531ab6c62mr13209505f8f.49.1749549382361; Tue, 10 Jun 2025
 02:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6292feee7c4347efad31e9fb2a1763779b7df133.1747407473.git.phillip.wood@dunelm.org.uk>
 <cover.1749289514.git.phillip.wood@dunelm.org.uk> <CAN0heSotWpNmqd905aknVTfk6WEcYifAwbXBKYfAWkhzxua3ZA@mail.gmail.com>
 <a66483fb-5bc4-42b5-b361-c900a69015ed@gmail.com>
In-Reply-To: <a66483fb-5bc4-42b5-b361-c900a69015ed@gmail.com>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Tue, 10 Jun 2025 11:56:10 +0200
X-Gm-Features: AX0GCFs-Sy5IiNRGGqvfq7QIsyACX8LR-R8t11MVYMWtd52KsXryBqY-D7aC-No
Message-ID: <CAN0heSrk4osiXTfxSZB9EN3o4NF+zLCBJscrSTa1Rsz+VjzjVg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] stash: fix and improve "git stash -p <pathspec>"
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Mon, 9 Jun 2025 at 11:42, Phillip Wood <phillip.wood123@gmail.com> wrote=
:
>
> On 07/06/2025 13:56, Martin =C3=85gren wrote:
> >
> > On Sat, 7 Jun 2025 at 11:45, Phillip Wood <phillip.wood123@gmail.com> w=
rote:
> > [...]
> > So the implementation under test could bungle the pathspec, query the
> > user for both `file` and `otherfile` (in that order!), get EOF from
> > stdin while handling `otherfile`, leave it out of the stash, and end up
> > passing the test. We could try to protect against this by providing
> > another "y": if git wants to read something after our "s y n" sequence,
> > we'll give it a "y" in the hopes that it will trip things up. We do wan=
t
> > to test the handling of pathspecs here, so maybe tighten this?
>
> Junio has merged this to next now. I was hoping that we would already
> have coverage for this with other tests but I couldn't see anything so
> I'll look at improving the coverage for "git stash push -p <pathspec>"
> in the next release cycle.

Ok, makes sense. Those would certainly be good regression tests to have.
I did some manual testing when I wrote the above and feel confident,
FWIW, that it works correctly as of now.

Thanks for these git-stash improvements.

Martin
