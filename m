Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC18A15666A
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921286; cv=none; b=p2OmC0A1eoPra/jq+NZTnCpE0oiul99g4QRlqAWpJfbeqzLOoWewTj3QeHNFwABvuvkYMPCyBVZURjocfxqynsspx1B5d4y+YT7k202hxP3eH3/I9jitmP27LdITNJsn/26lYCfeZpXRD+2LDXnBTWihOxdfCKatHX0SBEGKSZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921286; c=relaxed/simple;
	bh=NCEQioBk9VYqatLTU4eexcJhIp6noiUkHaoUHltcQ+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=BKiY4MOFn3eMObfUnzi/NZlBoBOn1Xe8KnQp5IqnijxKfIBgHzTj0myKXFpirDY/s4B82ScfYxxzO8nRgRoBdDV9VTOJ3DzJTw2ot3mTyYu8ZNy2YYGQG8CsJHN0Cy1EKD+z+wJGQIcm8x0pwM/KucJC1EyNKyoJN/V/mX00FPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXp+5r6d; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXp+5r6d"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6b0c5b1adfaso3894957b3.0
        for <git@vger.kernel.org>; Thu, 29 Aug 2024 01:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724921284; x=1725526084; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wVeO1wMzfTCkVh/+WFVnhLnV+krfpi+8ChRIx4i8IY0=;
        b=BXp+5r6d/zY8mhmI8CV4CNL3YmCDjeipCAvx8LypkJWNLp6iXRPJq7D77mFeNUdDmT
         FNlhO1F9YTkbv9pFWfgFKKM5L3Y7+MlUqHRrRBmb2P2Oc1CalXRokGIJnuao+f+Q0aZ6
         sCSBn4VZMesvTDeGskffKwjQPWtdbSOh4aY5UnXI/5kuUGtsTJe9Phx6cx/IDdZF4oXH
         wVFHqxJr+wi4JF1yN9Z4zsz2ge5NMqJAj+mlpOVAl0SgKIiy2m1KykDBJAFutKG/oUmw
         Sf+eMlEn0KVAvTMWxRmySebRgiNymvTEwz9QfEpyIGo7UXIev0uS50vxr3ykGgaovoXj
         WBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724921284; x=1725526084;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVeO1wMzfTCkVh/+WFVnhLnV+krfpi+8ChRIx4i8IY0=;
        b=WOB2cnQQiZ7nEdCj7sTLgOdiPT8qHNrTptJiOEAzAtw/vnfDdlu+KIqS6PR9iMvOAP
         X5XUTsxUp/nfN14YMT7uhT4DQMYkbj8vdlXorSNnZnfgga6A0ybK5SvfzxS36wj8s0Ct
         qXC1wRf8twIV9Kkgzy5MraVeYdd9DmODTXHR62Wwo66yKreilcA0YfawtsuxMr0U6hTi
         2a6sqDzeGxWPtpjFaQkte/wZCDzqeKuo52IPBMicfCecnn+EccO9TSmPyxfob2b04pTl
         0mewKKleTO3Z16lQJGSHXuu/JOfMjbQyqP0O3OmjLmMKngsl0N77/1Tcwd/fOqDwjcrp
         l03A==
X-Gm-Message-State: AOJu0YwmzmnddKgxIryLTR9DWKEr0IyN+97fvgMa+ncpTUrXsrAzQf0i
	uCOFx8TLP9WOIe8Qx/W3CglkVBr79foRX2lOn1U5+eBmCDDbBXjEKtHYBDIfaQLSMSsknLWYFaI
	kkaAC2nz84xizFosM1II9pxBnw6acep99
X-Google-Smtp-Source: AGHT+IFHT2U9KcVKkVOXV41+2B6ImnD0nSRw6kZdiD13ZXjzpjPgfy0PwgHorvQWfXjNGCU4L3nV6Gjrx3D1yMy9Mcc=
X-Received: by 2002:a05:690c:90:b0:6af:eaa:3dd4 with SMTP id
 00721157ae682-6d276116797mr25020027b3.13.1724921283619; Thu, 29 Aug 2024
 01:48:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAChcVumj41NCAcjzLyDGAyb+-QuL0Ha1AANe67jKVBT8xDRYdg@mail.gmail.com>
In-Reply-To: <CAChcVumj41NCAcjzLyDGAyb+-QuL0Ha1AANe67jKVBT8xDRYdg@mail.gmail.com>
From: Pavel Rappo <pavel.rappo@gmail.com>
Date: Thu, 29 Aug 2024 09:47:52 +0100
Message-ID: <CAChcVunYDO_KAmEOoWEL2q63_Gzua-Kt3BmE5Snb8==K9Cww1w@mail.gmail.com>
Subject: Re: How to turn off rename detection for cherry-pick?
To: Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

The reason I ask this is that we've run into a (probably practically
rare) case where cherry-pick changes a wrong file. We want to be able
to detect such cases.

Distilled from the actual repo, here is the case. Create a repo first:

    mkdir cherry-pick-carefully
    cd cherry-pick-carefully
    git init -b main .
    cat << EOF > x.txt
    1
    2
    3
    4
    5
    EOF
    git add x.txt
    git commit -m "Add x.txt"
    git checkout -b feature
    git rm x.txt
    git add x.txt
    git commit -m "Delete x.txt"
    cat << EOF > y.txt
    1
    2
    3
    4
    EOF
    git add y.txt
    git commit -m "Add y.txt, similar but not equal"
    cat << EOF > y.txt
    1
    2
    4
    EOF
    git add y.txt
    git commit -m "Slightly change y.txt"
    git checkout main

Now try to cherry-pick feature's head commit onto main:

    cd cherry-pick-carefully
    git cherry-pick feature

With a default git configuration, this should (surprisingly to many)
change x.txt instead of y.txt, which is not what the user would
expect.
