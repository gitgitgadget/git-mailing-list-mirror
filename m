Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F58F7E0FF
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 06:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727852323; cv=none; b=ad1amNW3Ye3lxBsMZhTftzgQzys0xM2CH4eOMoQ0Wbm+nUXFYLsWqTlbwMySamYcopwq0WjUtT7TwVWvrhGPgbpjOcxKaDRxx2MDPc37n1/lqi09QnqcYN/iojGf9w4RT9+y3kVobomfKKZQdexzkdF3HKxVwn6VLQl7oGIOYPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727852323; c=relaxed/simple;
	bh=N5JFex9duSEtj2MI3+peffp1YFEXkd9NgarYy8DDR7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boEQizkL8lT0Wj7Ni3AgWixZpKt3BrJM7P90WKq7BCmIgI9tIn0uKN2V8rIpMgSy/QQ+QrIEgAHJa3+xP+/UJEti+nXEABbF54Ao71ohOZcOIIPcJCbSYSF3mYT7TKpTi2KlrdzddxepdR1uORzNnV1WsbIqB3z65bu0/pP1Nu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=HX0IqFRL; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="HX0IqFRL"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6dbb24ee2ebso58091757b3.1
        for <git@vger.kernel.org>; Tue, 01 Oct 2024 23:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1727852320; x=1728457120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5JFex9duSEtj2MI3+peffp1YFEXkd9NgarYy8DDR7A=;
        b=HX0IqFRLokauSs82YReYGF9iEQlHWfpaJAmCRQ9p+uaTjUTKb/k2kXvtiIAIF0OuCM
         CAcMPPgVS4hrPHvEMdDorVaw4IOAmsW6pXoY2M+YCTA0NHPnHueDsS7tzQGY9pUf7XGP
         8E/BqXjGIZvM/NDJCr5DTlhteuU/WRRGFsyc0dL/dnRLKw7xvkV22f7Eh5ty1LEz9nCI
         gJ4jIdDIRFApTWb1+bLIJHDN3QBCncgwLtW6bRGD292NZvEf7/HY0YYegDdLrE6EBVbz
         HH4Hs2W24Cygt1Crs6VYglR2EgUj1jlODn+CK1H4GZHkeGfJ30WkX7lOgAvMd18HySws
         3kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727852320; x=1728457120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5JFex9duSEtj2MI3+peffp1YFEXkd9NgarYy8DDR7A=;
        b=B2eM2XIo5mfgS2MupwPx8rRhoijw6HFSgpMjnY11bfNoPNACZlgVJZDleOCAQZ4QSm
         T9J22RA8gxFxc9KerQYPWmhLan+3n7Ko40lV/1pyeXxlCAb+qrX9YxadwZ4M7cIwO6PZ
         Hee5/5db91PJxYvrjcXByavgeR5FvBilOKq+UxdTOIln0lnRdZ8VluWm8PU8x/HMDREA
         XrfIIHvtwd2B/b1Q5vDuK8hezEmLmsLb3UWPmdQU0T6h4PWqk6HWtQErxfOwMGgqxxjs
         lp2gaL2fOeqgRj5W3qWG/gdHTIebisvm/r2BUVwUJWHe+Bp+7ShtWGOkKh0CIILFCv8i
         dQcw==
X-Forwarded-Encrypted: i=1; AJvYcCUhSjXUTzXgZsm8kX3Gg0NPTL+vvlhX1LW8JJ6f26Eejw/rHPgHq6ccAvZNnzBc+byjF2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7TxPTEHNJvyz/JJV1PDWiCqHYBt94uCCYy0m5fmCFNST2RBA0
	7uHiGyluwA0ab0w3AK4g517lZfiY/RNDO9mhBBClc0rPvtTwH6oSmjdsHQAKSnIHwu70Fb3w62j
	SMbppkYWtYFv6PCSQgdE5J6TEcnOl80a1Ta1SY9xh0mpRqP8wMIlxXkAkObUxJOptetap4qauzu
	jelsOWdFI4SitNLac8SQ/LeGxfqkyG4TftwzkXIaRlVnaEzE2POskvTlasNayMejoLCJ/MESIlG
	UCDwrOD0JfJOzX4Y0sHfTwZ3/i0R4K5WCcwQIdmuxS+8GbSzXBIqfbX3e9lMUhajgl+yJNAKhVc
	zWcBIxqffuE=
X-Google-Smtp-Source: AGHT+IF1LtY0suaXZJtcWaT9JSCkrpUxNpoIZQ/eTpJ3gZixmtb/OxebU5ItxjoYkdSOW5LNMObEU/EJckRDVOraTBM=
X-Received: by 2002:a05:690c:d8a:b0:6b9:fd00:95c9 with SMTP id
 00721157ae682-6e2a2e18c95mr19317017b3.28.1727852320220; Tue, 01 Oct 2024
 23:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1802.git.1727577690390.gitgitgadget@gmail.com>
 <pull.1802.v2.git.1727759371110.gitgitgadget@gmail.com> <xmqqwmis11f7.fsf@gitster.g>
 <CAOTNsDyg2SB-wd+a7vrctXck46jyfqV4uME6nf4YQZEafWbxMw@mail.gmail.com>
 <xmqqmsjnya1c.fsf@gitster.g> <CAOTNsDz=gV1TQ=N+8V+CdhWkPSogNM-42B+vzhDNWdM-Wz9CfQ@mail.gmail.com>
In-Reply-To: <CAOTNsDz=gV1TQ=N+8V+CdhWkPSogNM-42B+vzhDNWdM-Wz9CfQ@mail.gmail.com>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Wed, 2 Oct 2024 15:58:29 +0900
Message-ID: <CAOTNsDygwBkNdFX4K_ixL5kP-AvDxWWVXkvfkmV4Kh04ozdYkA@mail.gmail.com>
Subject: Re: [PATCH v2] fsmonitor OSX: fix hangs for submodules
To: Junio C Hamano <gitster@pobox.com>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Although I submitted [PATCH v3], it was incomplete about the following:

On Wed, Oct 2, 2024 at 3:04=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
> I am OK with the idea that we can assume, at least among the
> platforms that support fsmonitor, that sending a signal to a process
> group would cause the signal delivered to the member processes just
> as we expect.

On windows, there is no process group so the test cannot run
correctly. As hangs corrected with the patch occur only for darwin, I
would like to skip MINGW in the test. Is it okay?

Koji Nakamaru
