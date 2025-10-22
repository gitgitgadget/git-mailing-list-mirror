Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495F9347BBB
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142875; cv=none; b=EKs31daQw9Lt/TUtc2K9/LCtS1uAQ1dn7z7ky7/4nFQQZKfnPG0uxispwPDNj6bqFRw7Oj0gb5lVxX3OzeQfQhNsbIN7SvE8aU0GcPjnHA/DbsP5HKF17ZB8+3QoR60aqdI1Ivq0GLMA7TJSOZjHXoXrLsagz2CS1UlBmgT+WEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142875; c=relaxed/simple;
	bh=6GooiwriCssDuhx5qLAkGfXsxYsbsNEP8wZwmI/RhFM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BJfDBAdkGJmt+3gkiUk9NJs5lfG1uj58+wYJU7lRngsI/HrC9mwH6pHMd8A9m4V6Ukt4ucGX+JM1nb5iwkS3L1ATHuOYNwdxjOoZZlA4Hp/BM1sxvAtrCxqZIGqyf3sXzrmd0XMz3yXEvH0ozfLK8ryxYLEEJFUxZJjSfKMkM98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2BjX9OG; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2BjX9OG"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-27c369f8986so67002115ad.3
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 07:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761142873; x=1761747673; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GooiwriCssDuhx5qLAkGfXsxYsbsNEP8wZwmI/RhFM=;
        b=S2BjX9OGQwBd51U+aYFbAlhPPWb+KIteym2Y3/cMWHGh1PMX2E5DElnidK1ffqoOI8
         Nqp0ZmntOMEX5BC0mwjmwoghpnC3jsHAgGNnhN8cbxAjx5DVBz3jRpmhC8BTLOwb6jy4
         uU42zk8RCisXGYxUnzje5aDH+6XNLXfACZ2BpSLawEg4uIPfPQe6Niewsacg/oIX9XUN
         S6M7tBvy9O/xoSH+n6z17wKUu4yKcmvNIh7ukoOEqwKeHCHhnvnZLYFmET+fPLMmQaNN
         dP5/CwmK4hqlHIRvSr3LtFekzLkP2b7WILGQgyyy9S4ds6EoM4iAi8C3WWb+QaXwtalh
         PYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761142873; x=1761747673;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GooiwriCssDuhx5qLAkGfXsxYsbsNEP8wZwmI/RhFM=;
        b=aQ16Bs4ZZQXKDO/wgXE9uUO9KpbZeXK1bhc0lYjG0hoyrjkvVthWRAt0vGjgiQxEXz
         RzA4eDMgeHLh4LLS1OtIRZcchvexx4rz9tqnvdKFT6JbA6wkajqFPNaI0j8Y+uUVfVCi
         +fVomz2v3Q9KTYZ57PygALo2NGSq5ZMhEKfYbh4BLZHr0Zk74zpkBML99MZL2yTZEgw+
         BaoIqfcbcnXAG6RBNC6Y0AjjHon0I67VZbTTOjqSy4bqVw5hI8jVIL+euhrmlAwLNGCB
         DKEs07WZ3wckv1YwopBP6maOBLBTviGssP/zJ6kgSpiWO2nNzG6EXTIpeUtB2x2KmoXs
         k/Rw==
X-Forwarded-Encrypted: i=1; AJvYcCX6Xus7808gqABThpM04YmORelxIojwpeQIFTx8ykQLLJ7vAmeF6ui21/DGV6DbeyNJ5cY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxOtTK9ZQrX6dL/FUrv9iLwXS8a83Zg4Wa2OnbuaQxTx/oUdyr
	wUJipNnKX3P0090TNKJ6DlfbWDjhxxElOQkB62GNYkzhLYXS07kvvHAeAvCNvX9Z42xt5w==
X-Gm-Gg: ASbGncvBKpgakWE8PZRJI3c0ib7t3LLdLtDZ4z+5Zu5uosCaVxZTUG2fYjTG0CvcsTt
	UYO7j8RXZl8nA7+pKi5/CcY0BHGZQji+tfJhneYHXncK6CzNLDtD2fEGrHUYkyTZZn36IVRfxZs
	3MCUGDvFY0OMYuhR49YTjxyLhWD1jPxVXEzMSD1hMhISAM6mjeb78Iqh328nsBhK+UT8HqB3JDz
	9Fy1Siq0SbagPioCoOX2/PNOXChddt3B8rbxlbiT0bnJjmAWyEgbbm7nw913loxTK/+9irx1NGA
	pLXDXjVqcet3929aisDGLfAIv5ncbSJ+8juz6fwflxgl80h3gXkjlqn8TZEkKI6C4TTuRw9ClIj
	M4r9kqxyYO+IFHcJvr+Xpa/mpThZ/jTNpUCFVwpPhHotIXXz1nYWdhLRfjYqCbqI+zPkS2+n771
	cx8r+442L7yhgF1ZZ02bTupn9VQ8l9RFNRS07v
X-Google-Smtp-Source: AGHT+IHW8odTbWid5SHWICI1RXAAmdM8h0o3ZoV3O2Q/KWp4qFYkaUzCDIffEE12Vnc5hikq+fa2eA==
X-Received: by 2002:a17:903:2310:b0:275:1833:96e5 with SMTP id d9443c01a7336-290c9d3744dmr240006195ad.24.1761142873359;
        Wed, 22 Oct 2025 07:21:13 -0700 (PDT)
Received: from smtpclient.apple (n058152119060.netvigator.com. [58.152.119.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29247219357sm139832755ad.111.2025.10.22.07.21.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Oct 2025 07:21:12 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: Regression in `git diff --quiet HEAD` when a new file is staged
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <20251022091433.GC853931@coredump.intra.peff.net>
Date: Wed, 22 Oct 2025 22:20:59 +0800
Cc: Junio C Hamano <gitster@pobox.com>,
 Jake Zimmerman <jake@zimmerman.io>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <819C2F6E-BE85-4B05-B975-894033E51D96@gmail.com>
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
 <20251017075153.GA4078773@coredump.intra.peff.net>
 <xmqq7bwt1kyf.fsf@gitster.g>
 <20251018094037.GA1060824@coredump.intra.peff.net>
 <xmqqh5vww7xa.fsf@gitster.g>
 <20251021073640.GB259661@coredump.intra.peff.net>
 <xmqqy0p4wcac.fsf@gitster.g> <E76C71D8-103E-4C37-B05C-86DC180BD519@gmail.com>
 <20251022091433.GC853931@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3826.700.81)

Jeff King <peff@peff.net> writes:
>=20
> We probably also need to restore o->color_moved, too.
>=20
> In the long run (and this is the kind of cleanup I was hoping you'd =
work
> on for 'master'), we probably could drop that line entirely and just
> skip running the moved-line detection when dry_run is set. Assuming it
> even runs at all. =46rom a quick look at the code, it looks like we =
only
> do color-moved handling via diff_flush_patch_all_file_pairs(), so it
> wouldn't trigger at all for the cases that do individual calls to
> diff_flush_patch_quietly()?
>=20

Sounds interesting, I=E2=80=99d like to dig into this =E2=80=98color_moved=
=E2=80=99 option and see
if we can optimize some code path in dry-run mode.

Thanks,
Lidong


