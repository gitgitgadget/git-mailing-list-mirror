Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97E364A8F
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759657299; cv=none; b=ZEv7BG+GacrszahMpRLJnp4zeHJvJBj2arWsf4NbB6WSrNLtRXqOJai9emhkroZCX2LPPeMH/ODkxV7aOCldJOy8Cx77GEPn4x2INo+/mbiBYSOwW34Y4OkKc6i0asmGz96SFWAC/6FATQITpjmjDUhE2+1IG7WacG7DLPegmoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759657299; c=relaxed/simple;
	bh=XQ4yq0+KUacqCCDuc33eJSPYcL9mBSNGDQTk4vDd0jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2f7GsAsUNyGD3md2UfrJoS5Zr1Z0oRvI1nyuXFchxKJbp9it7/mIc/4hRe7doCbF95DFoY4gYyXr6UmnnZjW0LwLaH15y4j395S1zkL5nirjRFNCeVQqBm3iVspX0nRHZ60AZXzkDKWZsYZcX90htcgj5D0UKimiHMcwWj6kaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkRRlVre; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkRRlVre"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-8e364003538so2849230241.3
        for <git@vger.kernel.org>; Sun, 05 Oct 2025 02:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759657296; x=1760262096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrAHj4562k+AmQWHP2YqIb1AuQdSl2zL75H7C++uGTI=;
        b=DkRRlVreSlExsWZIzi1ANwfbPmGYQOI2y/5VJ1nwjM9N3G1BJGSTdmvg//3ESaH6uv
         HQALDk0Rt5PhKl8BSoEZd15tfguGi7X8oUOvF7CTqOixiQi/OudLoEpVirchoyujC7qh
         PT2HvtpLMm1mDAfZz4EfTCAgJ2kDyII6UPMMDeOdQW+1OdEpPR8xfRO7ueUBTgPJHxVv
         mXLlj+G+oSUaFPgrzG29TLWIqs1kU/eCaysgtKC5UjDeJkQ6NE4aJlzO7Rw7s9EgFtX9
         d8Q08b/G1FOwU7bzBRpGg1YC3e7sSWZE4BfgHsgYb/9iBXYNCfbQNxW0GF43a+dzCTz9
         VJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759657296; x=1760262096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrAHj4562k+AmQWHP2YqIb1AuQdSl2zL75H7C++uGTI=;
        b=RUOqqenzlIFtdz+2HKCdCMZDOJdd4AK8L1vNVqjWcq4qokjEHXsuUPeKBxOBNbdxDy
         ZSFAcgzt8Al3k4qagpEK9XgLDCptLVZSzkh/ZqartrokMW355BtZTfU3tM60fw5vHYOY
         TDk/ql77KdbC1aIhDWLsWRbhjNkphaYTLTnmPoCasLHOB2c6mPoPc354gSnJ9BHBPgkW
         ZJ15cwN+I39LkKDY3FAYyJgXG+VJKoMsypLGs6tCFE/VnfKSBbgdi1K7g/IqTf00nmsl
         Ztpzxl7cenWbxeyyxw700IXIT6Y+oAUg4grVw13vryh7i8D3Ua3JSDr45z96yAVHTWn2
         xqdQ==
X-Gm-Message-State: AOJu0Yx7vfxZtEcEbpTbgUC8ChG4j7Bppn46ESv1DjvARW9T7/wSRw5o
	5zLhxASNhBtl2hcyVlkhM+xA0QhzsF+8312//Jd9t6eTntElTOoYEXoIouF1w8sPkbREDyUMqys
	7puaBvqjEsR+vmzYRdmobAEimFZZum2S5keQPiqI1ZA==
X-Gm-Gg: ASbGncv+9gxJ7kVTuX66dqAnIQ2jHWBxLBBYGT3+yt+Wy9Dl3Gytb3uVrtxzKb0k2iO
	6sCY9GMo/ehWydz33yOXo41IAGVS890hGFe+5VoLUXcBlD/LmotduW3DfulYiYBWFXDuksJPzFZ
	a1hWm7pR2SwBEawxUESLnLA0JKQIb04ioITx74xSHYFN14Ovu6mqLDAr9h46289MdAKUJJo5RKb
	pGFdMLvpQwcqtuTzqO2JD0M6zGfEf8eDpuLDVv298ymIXGpGSFOqdVA9voP91o=
X-Google-Smtp-Source: AGHT+IHftyusf0tsBFZX5OOuPuyLk/IL/k3tHZhFjIVp3L2SWnFY2kXukegYbF1ijPeiudBYfZIak7/7TVUJtQThjSI=
X-Received: by 2002:a05:6122:1d44:b0:542:d782:2522 with SMTP id
 71dfb90a1353d-5524ea76019mr3556375e0c.14.1759657296465; Sun, 05 Oct 2025
 02:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMWvevL03vRzX35tiRCkoU6CKucKim+GfacEVuN6wwm9r+1a6Q@mail.gmail.com>
In-Reply-To: <CAMWvevL03vRzX35tiRCkoU6CKucKim+GfacEVuN6wwm9r+1a6Q@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sun, 5 Oct 2025 15:11:25 +0530
X-Gm-Features: AS18NWAk7onWCOAB-xanLMQBak8nxXTRIY500IHjCgEHSIc7hFteRU1GS84D9uY
Message-ID: <CAPSxiM-veMq2TRJwzbRPpewrpCPYdieTjs3uR2L4e3ORQDsWgg@mail.gmail.com>
Subject: Re: [Outreachy]Microproject: modernize path checks in t1410-reflog.sh
To: Vedansh singh <vedh2o2@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 11:39=E2=80=AFPM Vedansh singh <vedh2o2@gmail.com> w=
rote:
>
> Hello,
>
Hello Vedansh,
> I'm Vedansh and I'm interested in contributing to Git through Outreachy 2=
025.
>
> I have successfully built Git from source on Ubuntu (via WSL2) and run
> the test suite. All tests pass.
Good.
>
> For my microproject, I'd like to modernize the path checking in
> t/t1410-reflog.sh by replacing 'test -f' with test_path_is_file in
> lines 133-136 (in the 'rewind' test).
>
> I found 4 instances that are assertions (part of && chains):
> - test -f C
> - test -f A/B/E
> - ! test -f F
> - ! test -f A/G
>
> I've verified these are test assertions, not flow control statements,
> and the test currently passes on my system.
Firstly, you do not need to take permission before sending patches to
the GIt community.

The main point of micro project is to get you familiar with the Git workflo=
w.
>
> Is this appropriate for a microproject?

This is a good micro project for both GSoC and Outreach but, the
Outreachy contribution stage
has not started yet,  so it might not be considered as your
microproject for Outreachy.

I will advise you to send the patch to get you familiar with the Git
contribution workflow. The Outreachy contribution
hopefully is starting soon and you can send another patch for that.

Thanks.
Usman.
