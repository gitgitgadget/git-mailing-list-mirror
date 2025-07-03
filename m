Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449D62DE6E3
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751532495; cv=none; b=cvRkTBIFfZB2WBqsOtMpHOxq2kpE132Ne0fsZnLPdSgpuRECsfGoeOYQ2SE3DnuZVRmOQ26YoDfPXsKpSIP2I4vHs/TZYqzKrU2u5D88zoU3nKMaBc0lOjmqe4s9qVFJxHTKxfy2CVzadMk/xlSwgfMce2Zsq7PI3X6rob6mU88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751532495; c=relaxed/simple;
	bh=FSTyyjpJ0GfC5ArjaxUmekKZ/3DGB8ht9RjemAq7NOM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFAthTGE1xi4NGSNddmoQ9T4p7YJ0irHTwOIBYF2Uj2M9khlKnZR6CrWkgkZ4nRQrwQX3nLJD/XdewlU5BZcn/ZKxBAODoXGBLR8QFKJ85/m86+Xo6G54IGy6cneXp8CnqAAHnHsb9REzQQJ92ITX1FAPQAnUSe9VPwpqOAYg24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrM4TUAl; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrM4TUAl"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4e7eb3fad4fso4510382137.0
        for <git@vger.kernel.org>; Thu, 03 Jul 2025 01:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751532493; x=1752137293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=34DGTAdrJbwZMhrgcsI2XQprbGJPAoPq/bz2RlqwBBE=;
        b=FrM4TUAlmwgY/SsOu34lzgSj4RJQg0loqWehrlwSaL3gyxaJc05ZM7o296+W49IBJp
         C4u4sRIbyotSo6slQwuLkqA6EQR0chJ6vzNBdBBb9t3olriAcz+X/EBjdF91XH6bI7MG
         zIrj6i0F/NCs5zpzj5HeYmyPmCH66tiX7ObhVPfsWgLwryjU8HCSq4UOKAUFrVJdsXbI
         jqNMbrVB3AWtwhOmUAKb+E03T34cE4iO4RfGxzRiWc7qgzOOCpQqENMAxeTdvOH2bMKc
         +OTN9+UcLvaUFX9H2dRsPheVCw9wDDaRD2z4v5HfTKXerImtszN4u6+1Gx2pg1byWK8U
         VF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751532493; x=1752137293;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34DGTAdrJbwZMhrgcsI2XQprbGJPAoPq/bz2RlqwBBE=;
        b=QyE8Kfi5iL1mqKDwtt2IkFuWPPhaXLW9oiF2Q/51Wb1sT+mGGlHdaxGatKGlx4LOiK
         t6u/OlEBcoef7UYxpnlT3bJ5E5ILZIDs9Rco/fW63QOIPLYYG2G/A2O2A1+LJr4wZPH6
         uLGps4j1pdwjpHhV47HOGFRHvgeMRXJPLk17cPSVn4n3GXkKyKQIAo3q9yFiu7fh6PCA
         n5lySUQii28TQnjxO3hlSuYfwaUn2itJ/m/w80qrmqPixAFez2rTLbjcc5A16T0/Yi0v
         YQD5OggHJ7yVwRHfLcwXV91mZawkxuF06MFEnczAKA1B6JjGyB9JdOj1EFVFclBg+D67
         7X0A==
X-Forwarded-Encrypted: i=1; AJvYcCWHvanikT4PfptNjwhDPx85EStZn36b/SfVPU5ItvasSDt1T3m8nmxDPrfojVwCFo3MVEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxurDJibfONX5x5H45Y30/aub3sJDTCoPWmqAggpx2I4oZteTD4
	BGLlUFbCvJviq739bXlVpMgMck8Cl1hQTcWTe9Y7YGzWwFUhFqLSCciO+R+uT++/dAJlVx0opAO
	wsgi8WxbeSDE1yt7VF3M0xorg8GuyvbNSEg==
X-Gm-Gg: ASbGncuzS0Ond8gLF2UCSgvajk0ZgeY/9ZVBCylozwiWqWq1LQtDf2GRz37AJRdNnTj
	lRkInMZe7FLADLH3AX2bJmpyPZnzuULjEkYlWtZw2uF1YfDFtl8KEkMMW7w7fLICZRYy6mCUJO+
	hY2vjrEhLIrfVop3IwObE8Xg3l1WhfsXZ+1bzvtOyPARBs
X-Google-Smtp-Source: AGHT+IH4vMWAncsvdSBduQh+VfWKEhvyPXD96mN/KXU85/X0njYz71mBUgvN9d+NzSJItssDQRBXwefvaBiNtTChAcI=
X-Received: by 2002:a05:6102:a4f:b0:4e4:f503:6675 with SMTP id
 ada2fe7eead31-4f161199cf0mr4168903137.18.1751532493114; Thu, 03 Jul 2025
 01:48:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Jul 2025 04:48:11 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aGY9AyJ3c5wXpKaX@pks.im>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <5e9b3ef1-931b-4b70-8275-5aed5da3d6f3@gmail.com> <CAOLa=ZTwvOiCnYK18GTEUkcW0-YLHkJ=MBggdzOYsbTT+OHPwQ@mail.gmail.com>
 <aGYSjf5H_ZBaVVJm@pks.im> <xmqqsejdbywt.fsf@gitster.g> <aGY9AyJ3c5wXpKaX@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 3 Jul 2025 04:48:11 -0400
X-Gm-Features: Ac12FXyOi8yjinJ41PJFkw1E2YoYciEuAGHHsQLYFaFjpazg7Anw37_yspmZMGI
Message-ID: <CAOLa=ZSN+Fvr0ixQWV0Becj-ELMRSkhm+POKF=BQ=F615sSj4A@mail.gmail.com>
Subject: Re: [PATCH 0/4] for-each-ref: introduce seeking functionality via '--skip-until'
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000010aeb6063902707e"

--00000000000010aeb6063902707e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Jul 02, 2025 at 10:56:18PM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > Even more importantly though, a numeric offset would be invalidated by a
>> > concurrent write in case that write ends up inserting a ref in the range
>> > of commits you intend to skip now.
>>
>> That argument cuts both ways, no?  You have shown up to some ref
>> which you remember in the last cycle, and then while you are
>> planning to formulate another query with --skip-until naming that
>> ref, somebody removes that ref, then what happens?
>
> This ref was already yielded, and it wouldn't and shouldn't be yielded
> on the next page. This works as expected with the proposal, as
> `--skip-until` does not care whether the value itself actually exists.

The current version of the series will include the reference provided to
'--skip-until', if it exists. But your latter statement still holds, if
the reference doesn't exist, it will still work by finding the next
reference in the default sort order.

>> Or somebody inserts a new ref that sorts earlier than the ref you
>> stopped at the last time.
>
> It wouldn't and shouldn't be shown. When I have already yielded all refs
> up to refs/heads/something, I don't expect to see any ref that sorts
> before refs/heads/something on the next page.
>

Yeah, this was my thought too. Another way to think of this is that in a
cursor based approach, a particular reference is guarateed never to
occur again, even with modifications to the repository made between
requests. However in a count based approach this doesn't stand.

> Patrick

--00000000000010aeb6063902707e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d4207e037136e038_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1obVE4b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meVlnQy93TWV0TzlSZnovMVVDVmRJaWpIcm5RTXI2YQp1SGtNeXZUUVJy
ckhiMWdnM2JGb0ViVXQ2QXpsVEVhZzA5bHhWakVwdWxhQXVzanZjT2dQN0NqME1MS2VYSEg0CkZB
Zkd5Ty9Vc1VEMXlJNGRYL2tpN1hPTXYxY3orTllKNllUTi83TzNiVk5UTi92OWFGU2hvTFloSENW
ci9ucHUKbEJpN2FQdlkwRWFNNHRmb2ZFeVVpVzlVa1NhZUx3T2hERHRkdnJ0RFlCeXVheUt1NDhU
YUpLbEhFS3NrYzNrRQphZ0hMcDl0QUw5MDAwOGJBQmdaY0RVdkVldzJVM09Rbm93elpSeGxLUEJu
YndUd2xZeElSV0xhdHo0cHhDRzNYCmd5Zk5mWG40bHdwUElheW9jOThoQ2owS0w4VzJIUzFLYm5k
RW4raHErSlFja2w4Y3pNcDAvM24wU3N6bTRxR3IKQzJKL3BWbE9hMzZzNXZyNUpmT3FReGszUE9t
WmNhMzRKZ2xiSUI4aDBYT0ZqVEJqeHUzelRqZ3cvSUttM1BCSApic1RreC9vbFFWZzRDdDYrdHpy
QWRhUVNGd1RiQUh3Y09DOW02OWpPdllDVnEyY1RjVzNsUGNTL0ViWkhmNEZkCnRCM3VPcVhwUDU0
VUQ2S2cxaVNocE9ScnF4SGpSRm1QOTNyeng1ST0KPXRJTWoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000010aeb6063902707e--
