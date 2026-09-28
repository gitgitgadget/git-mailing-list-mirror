Received: from mail-oi2-f42.google.com (mail-oi2-f42.google.com [74.125.231.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217F8503BEE
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790639045; cv=pass; b=WUD1CAjx00cKpCnHb2oZnPZkgDSCvFuz6pBczc9wvVxjDCF5qbE4WjPsjccYwUZWGqMCO0nBTBnhRd+6OxJRYMUUYAqTNsLDd9vMsmPtwdGsrDuOYceEL0kiqM9CHidkKercjaWEwXnxO4cnm652T13pTuzUMCVaUV95mBWd7tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790639045; c=relaxed/simple;
	bh=Jkt85lMNVgC4x/TWhZHilcVkN63s7YTHfioPDUWOtQk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WxOn0y8UKYKgkugFLOLATbPVybUVflpK27pf6lLhZ69XJNjVn9f+zHBNl3W0+gignSWHEH+ZB1nHAHbJOJCa8X5d1g8uMiWLRdjj2GHchwOOtOpMEqQjBkTxETF+XYiTk213sLrDdA9nm2aiZr8z8qO2KYRl5zjQaCKVZerQmKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RX25Ygen; arc=pass smtp.client-ip=74.125.231.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX25Ygen"
Received: by mail-oi2-f42.google.com with SMTP id 5614622812f47-4e7b5de66d0so1508446b6e.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 16:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790639043; cv=none;
        d=google.com; s=arc-20260327;
        b=J61jRz0rxl/UndfpCN96m6QhrrKsCGmFVPY72/y5mqEvaGor0TO8c31rzHaMakSids
         374AGnE/ixuMrz7XnYPD3ci8mKKmraj4F6MpMnut+ul/jvFWmo6j2WoVZi3LUHIRXNAn
         pGqH0HKE+wmHpSY0F9dQMy0XrAItdY9/VbBoO/G3ENIHV/5OKm2C+MZMOktZ5ZNZePef
         kUnz8/F8bO8cOXkKVi8h/ez4fWjhLyyokUACDGdCI4rB5ZoLmREJdmHjswlPzyNgCYBC
         4iUvnFRaXRpwHVWORPQvC20sIVQY6erOCwzZllCIDqGGql5+nsDUvDjWMSOAi4OzyuvE
         LWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=INCn8QWGmLCIx42eZc+610eraCD3AuKD3uyoM8b/shA=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=DlcvDHWRzCZLVeqACJ77BiQMSloTSc9wczdFNFBShHsI9RC03oJDZxeHk9W/9CrUct
         3hMP2R7XQkD+xHZR+pxme/M+KSnDzb+VrwAqdmVn0OZA8zMBxxa0A1b1Ajerzp++nAur
         U3gk2U2rfm0HS3Sf0328hb/CR70sbroU5IcBdZQA6qCqYzZP6Rqto+cfov2rsO5D+uLA
         9Viq76maTWE2A4oKFwlNMoqOLu64jD5bboen71FaMwfv8oSeLjk9LCMJWGVv9b3EaoMa
         oc95svAncc/+K8gy3ghZt2retFUoFpcryZAjT8W6eMILiBHnmXhnIK9nIN3BJsfdWTg3
         ozaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790639043; x=1791243843; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=INCn8QWGmLCIx42eZc+610eraCD3AuKD3uyoM8b/shA=;
        b=RX25Ygen1PUIkeeyGtmrgHLUBbbVBeDaEFgdOkQ1w8jdrbjmjkqua1wa2UEMoRSPZ2
         BkgaFX8afalIEC9PJn89KZ/EiHaSx1VdxvOl1Q/J/Sg84Xeeez3maaRPYluLI3e6X4oF
         EaayHGx0JtyJwy3znGuC/FwimGLwDW4xPVmDWjBC8fXiPFlJA40NK8N333R/vFiQrdYg
         giocdIMYFQhyvpQ+NrpYlxg/8i2Azelk989ml6qDroZ0Ps+VTCOt2oF1krI1PxyBGuHc
         ykMsOB7F9OsgS8w7N6jR3aFVZqajZE3ONODFbgLqBWuqdaaDWI0Lsx0FNvm6E3y3OIfM
         xE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790639043; x=1791243843;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=INCn8QWGmLCIx42eZc+610eraCD3AuKD3uyoM8b/shA=;
        b=N9SnxFZRuosDj2WGAYLYqiWqm/PvYq1x4VofwQPzwaPmv7WFX1rQtHQii/0RUOMpd7
         FZ+vizvE+3FPRG4YtQGwG3Lbej25iLRqy9We42IsEoXFkvr4ftw5KMZOYRwMiX395ua3
         yH7M9k90zf5cq73BT6thOu3M3elqyol1Hs2Dcm6VM/Mj2IGa8iZ+fh8cZpZHlmjuKVUO
         Fua6YOxaHuDoQJ5mapTfOL8qJTsevGYj/jJapVdu3ksjhhWtimYK2h427f9DaFcEcbZ5
         Fi9jdX5GM4Bucci56vkBW/CpkY2P1MJZMo84vWvslCiOsPvfsBfusWI30WOGFGzWFtzK
         kWRg==
X-Gm-Message-State: AFuF++m1dnPGzCrSCKVjD9OQ+KNrphwNr25WQ/bIFHs0NeHYJ5+SSe94
	9Le8n6qAz3S9PGiAU+q20ThG3lhm8arHO4uETTCJI5byYk553SSNuqX1xn/7vTZkr2OmI2WYJyq
	w7dGLlVhQl0XMbh0nHFoMPgZyVIel4lCBDGDVRds=
X-Gm-Gg: AYBFou1SOngld0Lt64sv6V8+vF2vecvv6vvmS/mIMYR/IOpQh2xXAEoI0ot8nPj1G6n
	lGHHbdpt5tEz7+rkTzWS+Gl5fRRBtEK5mRKerxKbkjkeDteMDw0tMmoBgQ6rBJgD2jYX8w7RP2e
	dOBHqoeKFsXLRDDzyzZjePZ0uMCOSQzj+EwwcEOe6JdxbiF6SwxeAqLugYS4W+JGn1oTpzcoDEu
	BH7wib5vv1ORJKmaY98lIQoepxNTX507jERMLOqodfko0nIVJIfDTttfkdXnbEldNLFr4kRopGP
	msZEnxpmrxJpplxlHJmvgKxl+z3fmfl3S7LQMneEW9E+IcALtLHQ+2B6E0SqyeR9aus=
X-Received: by 2002:a05:6808:23c7:b0:4cb:f21c:a79a with SMTP id
 5614622812f47-4d72ac46340mr15317355b6e.34.1790639042901; Mon, 28 Sep 2026
 16:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Isabella Caselli <bellacaselli20@gmail.com>
Date: Mon, 28 Sep 2026 20:43:49 -0300
X-Gm-Features: AclHuK_Y6UEIhhVhHMg89L1_ZLTq1z0OlTFNOgQ-pWGElnwd7YPBMzNPP0O6PpI
Message-ID: <CAK4AdTRdNEU8cLFQ_7A=CUUL6u6dc327rn_H-SeBBD_dD-K7PA@mail.gmail.com>
Subject: =?UTF-8?Q?hostname=3A_includeIf_condition_=E2=80=94_anyone_already_wor?=
	=?UTF-8?Q?king_on_this=3F?=
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm looking for a small, relatively simple first contribution to Git
as part of an undergraduate thesis on community/contribution barriers,
and I'd like to work on the "hostname:" includeIf condition requested
in gitgitgadget/git#1665 [1]: matching includeIf on the machine's
hostname, mainly for sharing dotfiles across machines, e.g.:

    [includeIf "hostname:laptop"]
        path =3D ~/.gitconfig-laptop

I found a related proposal from 2022 for an includeIf condition based
on the operating system [2], which stalled over disagreements about
naming and case sensitivity. My understanding is that "hostname:" is a
narrower, separate condition (machine identity, not platform), so I
don't think it needs to revisit that discussion, but I wanted to check
before starting:

- Is it still relevant for the project?
   - If yes, is anyone already working on this issue?
- Any objection to the approach itself? The same machine can report
its hostname differently depending on how it's set up =E2=80=94 sometimes j=
ust
the short name, sometimes with the full network address attached to it
=E2=80=94 so it isn't obvious whether the condition should compare that val=
ue
exactly as the system reports it, or normalize it somehow before
comparing.

If nobody is on it, I'll put together a small patch modeled on the
existing onbranch: condition (dispatch in config.c, tests in
t1305-config-include.sh, docs in config.adoc).

Thanks,
Isabella Caselli
[1] https://github.com/gitgitgadget/git/issues/1665
[2] https://patchwork.kernel.org/project/git/patch/pull.1429.v2.git.1669058=
388327.gitgitgadget@gmail.com/
