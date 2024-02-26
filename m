Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D572EEDE
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 03:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916656; cv=none; b=epLfcRr5RqEGnHQLWTCxTFkwCIAyG4/LJnwQWECGFTixhM6gzfBKCQoBzYrBzRBlq/aoQENsdv2f9S84TSIUQTvigyNVgaNHL9U3aU2SxXgAErC7J8+1O14QZI/mwIXgHf/4SInmCTx1FBSwEf42jHGMHFuO5KbIgTRvCpSqouE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916656; c=relaxed/simple;
	bh=nbMwr+dpXr2AktYTHWwbEAnj98ljlJBdKU77BEFAOa4=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=lhS0VTV/oUgEpd/isABTLiXkfovgmsOTfAlMFysYN/9cGPz+VXP03A/gzjZpUsUXgjhYwTd/vc7cgGCwI5xdSstkxhBo+KGtJwJmX0x2EmFoVNyUVzWaXXVAa19qlzje8TfJ0cVwNrVGjwRIH9nubrbtnOySh9NjxfYEcIJirrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEITTe71; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEITTe71"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c1a3384741so231127b6e.0
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 19:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708916653; x=1709521453; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nbMwr+dpXr2AktYTHWwbEAnj98ljlJBdKU77BEFAOa4=;
        b=mEITTe71odqHo3dkpEeyqd7p+JD3Mlr2uBUJX4Z4lEw8HidixfjXWfhnUfGBQ+2STL
         VHXs0ECvDNvYT/WccTvJFgBAanH9BGiLtqVKzwkEPtHUXoONEAs5B5rtXlHToMBFh3F5
         EyTzrkoByXah4JAw008wLiOx0vkKZKRtdQx3aZPOswwCRoYhG6T/HZOTTSTodbl8vxqZ
         zLEobSrd6SX4LDjnahu70vsEQqTTgISwgrUDCzMAtUYQQTTnuQe5gikPMqpY7fZSl94C
         hsPVvhuVeowP70j6yATyq3G+pBdroA+bUSp/lAbqsd64zAlwzYfkBbMIt5lPUZvHW/qM
         IetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708916653; x=1709521453;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbMwr+dpXr2AktYTHWwbEAnj98ljlJBdKU77BEFAOa4=;
        b=rR7qnUPo9vpNjjYeciqtfYJJWuAYuwCuDaXdhfqCz7CR3BJdgIYZBOBvI61fVX7vVi
         +fAO3BN/qPQaJAtnj/XOeb3M64JVP/6HVmN5ndf4Q5uTgwOfhOES9xbfPmfUnZDwy2xW
         GvHXINpZP3PpbzRF6JdsEIdq+BtYXg56+39ry9I5DYpYqcVPIxJUD0I6PpfEnbgU1F35
         pW0jJZERWVH1BfoBGd670Vyl76acWhLygvfed6y5rejqP0NbADfH7XTtLZ1Up2yFIjFP
         NtdChnDzHXnPRjp1vZ5/+AH35v00BxpjY/Rvk9UaII+Htj1N8KTzKsyBVy6zbEsnFqGI
         I1Jg==
X-Gm-Message-State: AOJu0YxJGRx8Nlb+l+5wxUHwRxzkU26+XYHeV0t5cgc0UKLG5O/Bi5ep
	UGa4kHVdVDiah81sMjeBm/PbPnsUUfIKgkWzVVy1eLQmBWllfUH0JTN630T9
X-Google-Smtp-Source: AGHT+IHqSxwAXCduOEH4Sq1jl8vFQaNcGQAqinReDVvCVYvC44dMTYnD9vmLeo2vGfQT2n6t0KSYtg==
X-Received: by 2002:a05:6808:21a0:b0:3c1:9073:1a50 with SMTP id be32-20020a05680821a000b003c190731a50mr7480682oib.29.1708916653145;
        Sun, 25 Feb 2024 19:04:13 -0800 (PST)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id lv4-20020a056214578400b0068ffa2c0e19sm1512478qvb.114.2024.02.25.19.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:04:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: <phillip.wood@dunelm.org.uk>
In-Reply-To: <f10cc07a-0e77-462c-bc86-ca0452c20a1c@gmail.com>
Cc: <git@vger.kernel.org>, <newren@gmail.com>, 
	<me@ttaylorr.com>, <gitster@pobox.com>
Subject: Re: [PATCH v2 7/8] cherry-pick: enforce `--keep-redundant-commits` incompatibility
Message-ID: <17b74aa40b428632.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Mon, 26 Feb 2024 03:04:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip

On Sun, Feb 25, 2024 at 10:58=E2=80=AFAM <phillip.wood123@gmail.com> wrote:

> Hi Brian
>=20
> On 23/02/2024 06:23, Brian Lyles wrote:
>> On Thu, Feb 22, 2024 at 10:35=E2=80=AFAM Phillip Wood <phillip.wood123@gm=
ail.com> wrote:
>>=20
>>> Well spotted, do we really need a new test file just for this though? I
>>> wonder if the new test would be better off living in
>>> t3505-cherry-pick-empty.sh or t3507-cherry-pick-conflict.sh
>>=20
>> I was modelling this off of 't3422-rebase-incompatible-options.sh'.
>=20
> The rebase case is more complicated due to different options being=20
> supported by the two different backends. Thankfully here we only have to=
=20
> worry about options that are incompatible with "--continue/--abort" and=20
> so adding "--continue rejects --foo" into the file that tests option=20
> "--foo" keeps everything together.
>=20
>> Additionally, I do feel like these tests are only tangentially related
>> to the tests that actually exercise the features themselves. Notably,
>> the setup requirements are drastically different (simpler) since the
>> test should fail long before any setup actually matters. For that
>> reason, I think a separate file where other future tests for
>> incompatible options can also live does make sense.
>>=20
>> Is there any particular downside to the new file that I am unaware of?
>=20
> The main downside is that it spreads the tests for a particular option=20
> over several test files. There is also an overhead in setting up the=20
> repository at the start of each test file.

That makes sense. I'll move these tests into
`t3505-cherry-pick-empty.sh` for v3, along with the corresponding
incompatibility tests for `--empty` introduced in the ultimate commit
for the series.

--=20
Thank you,
Brian Lyles
