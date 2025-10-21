Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D715A2882B8
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761081834; cv=none; b=NV/wzFjDz1XEO8v1DJCa0VPrxTsgqoYeBfHQmuOHOz0nz6hzXEdYO1CeWCo+1xgbw85+pF03Sjsg5vP2ODsXfTNLcwfGynEkjVl8MowTYHjUKqsi301cAbiIumCdSzvLFQC8uRRb/Q14/DMYmynmcEwMKuOcds2uQEJl24yy/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761081834; c=relaxed/simple;
	bh=3TcJoVhCMP1MIAe45eF85rAREHAWDOKdD+NtYL6IqhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyH+C1y2OBpRnErpbQm5Yo8+07AGzJ38VdJSlIki8lwHvRHiDILvywOZf5pJ1h+AIKBX5b7niKOoxJbrPsfDpC21XQhbhQdt6mgswot5o1/hTBALGeXYdpLqTGoGSjlZMGxFhbbs6aotlA2Z6Gao+lfVtEIzf4C1sblOsg/lKtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbnVBxgD; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbnVBxgD"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c3d7e2217so8374179a12.3
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761081831; x=1761686631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TcJoVhCMP1MIAe45eF85rAREHAWDOKdD+NtYL6IqhM=;
        b=RbnVBxgD4V6N2lr/OUyZIZ4LBb7UeXK/ClRqYq22rw82J8ycecWUiaJjv+CuObEo3G
         GrS3BrFcV5aQQartsqCBPw1RIP/QR4VL3H2OwR6VOIosesAqvhBmpenG4TqZDVNhOdvm
         7D7cIUn5u3Ge+751bA8MjHDU6brHQjZyD4WYvBTCpFs+3+ibyLS9YcTajEKxQ2OAZLjl
         l2APZ6uosNlT4EB0E86ewxdeuDCXoLAsib8aHVTxh1fU3E0l22IdIKgkRWdGgl85DxwJ
         YSeuSY6HoruwQa0RWhk3paDHj1vwVnBtn6ocvO5qc1MstRcDvTBOF3bvfHy7zJcR4HGt
         oZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761081831; x=1761686631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TcJoVhCMP1MIAe45eF85rAREHAWDOKdD+NtYL6IqhM=;
        b=W7PrMgVanLiG5WKjSyYxkzJ5jaWsKA3/BSwFaT37KAQrvUjA1sF7fboKHwvKyQrHOn
         /1bpjEE3MPFt0J3W3Whys3kcBTQoPrCzxlsu30YnZIGSjnnrWqIQ5DlLhTDihfRohXgt
         DunBLnt/kklyfFOUGk039M1q9ORQ5eL2DmyFwx9aBxmS0EVO+oo8CAJpaXFGLtGod/o4
         DBlKfucI4eVqz1M1QYaiQuQH61fqpz7SMto8Gs2RRWJa9iyTRXFxC60gqTN1EPZORasB
         z5y0hpWHP7uCQZTEo/dirsK7CHuhfNFYUS0/5ZFBtMN++Aw4wneS3veQRZuFDnp0HHeB
         i9Kg==
X-Gm-Message-State: AOJu0Yy3ZT8jFMTi1uTcre1KID9sqeoYpvKzw8TwK8txOq9ZRGSDjPBy
	M74QXcR85VNW+hXo0W44xeTKtbU/1ikZIrZlKYbkpm9hdDBVSgsrEp5A2FC3mSQjwTIXRqubEf/
	oJKPZSsPO+C0nr+zzvXxzntTu5ahOExk=
X-Gm-Gg: ASbGncu7xpaKpmMfCAvfB2TL0qzj/2NTPNwlCj/RziFRglZHtmwOrIsV0wBsOZJ5CsU
	RcW9MtynyJYAEt/r1NFQq3s2zPTfeWAErSB+vog3qQZQMaYfWSwr/ia7J2K2uKuKpmC3Rs3DBu9
	T0cs0Ic6h5aJcRcPPsUVeTmg6wY29+oRfZg0JkuqxJUaE0TYcGeIG9rL50OGtP+HIv0p6kP4ab1
	SEoBy/B2pQm1peotlluRG3sdSaUARvoBJkHzVZCAkwr1ujd0P4B25njAE/ibZYLdfb0q7kjuf+N
	kC/Ud3PasxBBCalwKV8=
X-Google-Smtp-Source: AGHT+IFKMTVMsrKNLtYTNBGOYnk8q6xW09/fNxkEFtyX5ijBnMDn7/vcy1h+UePhDRPLwnmPu+YDSmg/d+9VF3ZjwIk=
X-Received: by 2002:a05:6402:280a:b0:63b:ee26:546d with SMTP id
 4fb4d7f45d1cf-63c1f634768mr17555351a12.12.1761081830821; Tue, 21 Oct 2025
 14:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <94497aac-c61a-4b17-9e4c-8ca9b966829c.ref@bellsouth.net> <94497aac-c61a-4b17-9e4c-8ca9b966829c@bellsouth.net>
In-Reply-To: <94497aac-c61a-4b17-9e4c-8ca9b966829c@bellsouth.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 21 Oct 2025 17:23:38 -0400
X-Gm-Features: AS18NWCQ82DMC_7FdMJbZ9WpkJm7V0-5jPjzc_qJj2TXcdOYdM5dYzViiJqYisE
Message-ID: <CALnO6CAKBB=MRUBSv-_pqWuUgi6d1+o_X=iq-fLzfSkCYMaiPw@mail.gmail.com>
Subject: Re: Migrating Repository without Network
To: Dennis Putnam <dap1@bellsouth.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 10:52=E2=80=AFAM Dennis Putnam <dap1@bellsouth.net>=
 wrote:
>
> I have a server with a git repository whose NIC is no longer working. I
> need to migrate that repository to a new server using a flash drive. I
> can only find instructions for migrating when both servers have network
> access. Can someone tell me how to do a migration without using a
> network? TIA.

Have a look at git-bundle(1), which was designed for something similar
to this use case I believe. Or, rsync the repo to the flash drive and
then off?

--=20
D. Ben Knoble
