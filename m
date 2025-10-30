Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9371933F8AC
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838046; cv=none; b=C6zpQYTtoNoSAMG0gVoa22NXIDfi62AT3S07SHxB4A//uvm904hHdteV5pMVMXvyGyZHBExgS+tT0VqNTqCYZnxkZREpCqV0VwQfnpSzIiYN1sAbh0fifk0PE/Hf69WK6QVuU1Jy4r8UsVrTYXQVojtD55xKUj2qOqKDgA/gPOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838046; c=relaxed/simple;
	bh=lTei4dl3Fd2phAXC/AbaIgUscYEjn6Z2Oir9Lv3NCXM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OpNSGsNsmoz/p23VswhGX1mGQxnNsdCh32Pw1q9LZgwiANrwrueihgETtOAgN7bHbVS0x2S5yo6qQ8QlaI7HVslpHyqdqX4S8rDXvkL0MILw6NVyR/fOM3LdiuQ/aEHrRQvzMwnwh+jI0ScTGqjUQpugRlc/DHpQwTOeacOuad8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XP7fvtoP; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XP7fvtoP"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429b7ba208eso569246f8f.1
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 08:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761838042; x=1762442842; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lTei4dl3Fd2phAXC/AbaIgUscYEjn6Z2Oir9Lv3NCXM=;
        b=XP7fvtoPkagXm8JLfnaGf/S3/G9bdMJ/bHNGlG4rDOmqPbpfood6gCPB5hM/fcRbIw
         RWz3p2CCRcyxfxz8xT1MEXoRXMVlSvRUI31oOOP68JJZ1QYrzoVlyklUDsNOOECkHp4A
         7LhBtnjL2xRVo7CZEorxnFNsIGd2ebUcIr8Y4jDxbn22dm8hHtMR6eIR1A0ShaTr8F0K
         AlCQD6XcP/IzYYTyot4bUkvzGxQph7/IOR1ZdmYJ9GOfAq3eIEph29GfKuy1xjfUgTCV
         HVkdGNNKd4XQUF0tvf/PrJbLI9ihx+AGCrWxE0xY7GUsOyj/3mrPEvv4GGpRTZzEaYTK
         QrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761838042; x=1762442842;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lTei4dl3Fd2phAXC/AbaIgUscYEjn6Z2Oir9Lv3NCXM=;
        b=IhIBjuw40/yHJTqkRJwUV5NLzcx6SlePMKGyyihgF/iChmFLQtKOhPybwagJffBV5G
         CL/wWiZYE3GiLuWJ802qsactrtzU2oUQgxbcS16sp4YjKwzS/0YeIDiZYwbE572YJSsS
         cty9mYM0RlntjSKT/vTZZ2KezYuOvtPmvHa+VnyKCESyzcrkqmZk+v1/H9sl0KctGZ4n
         TuN5/VWUflA1vJZCIsm8SKtGQM/CgV9llLlwDYX2nPHKKAxf0DpWNV5Mh9SlQStpPSL3
         UIjqEMTVdBfW+LVlyrQ5Mvf4aRm/lH5EI9ProBohdBlwNn8fK+VfUf8RiKWKKN6Ac5En
         cBjQ==
X-Gm-Message-State: AOJu0YzA/A+Uxw3/tLVtxddleeSBS09rXk4tEeBLIkHfGPYXxKhHhO3n
	RvlhlbvyJ/zmYu6Z70uK7SiJpKf02A/ChTyPiQFB/nh3nZA2j6YRbZtVSOLc0BeTc+govD5VIzc
	R8ckdrYRQqdIKZAzhijVlDIad4HNwMOzBl0lFalc=
X-Gm-Gg: ASbGnctCrGFftkOh42568yLhvZP2pUHgwuTu2t8ZiCFQ9Fuh5utICmR26GOKOW5tzN+
	la5OI5uX6xuatcn7QvohIIa3J/ny6iaX/Xj8NBXmdtFDAoLhw1+PwKehzrXyu7K4auhDrbaIMH4
	zu5EpQnhqGyNVRVCIzCUGZCqaInZam/c3PNsD08lT9ACkvjKASGiCvQuTKZn9khfOKc84UvxGR5
	eLDsY3/0z5Yy0hFveYiso1nFkZN2U9vOSZRj+Sg260RIWl5zVnQ8YabdacxIzt014CUxislUVy9
	YGWHjqug1NlvehIDhpt1Q8eLGe4J
X-Google-Smtp-Source: AGHT+IFmGe0SW6x5ha5RBc87sC40/IG9Z5+4dzaI7ZnG17AQcfnTTzrt3+4Nxo7uaCHExkx1y4bH1cv7z+ic/4bYL1w=
X-Received: by 2002:a5d:5f95:0:b0:427:5cf:a284 with SMTP id
 ffacd0b85a97d-429b4ca313fmr3311671f8f.60.1761838041938; Thu, 30 Oct 2025
 08:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mark Bauermeister <warfan2007@gmail.com>
Date: Thu, 30 Oct 2025 16:27:10 +0100
X-Gm-Features: AWmQ_bnH596bz5wo3xGWFp4u2Trj-YNV2LUlLUuM375eb1NVbpGBbhl6pQmsR1o
Message-ID: <CADanQgA3h52hax-mdSTBV-tNDGvNRSxLU217aVygj7Cs7Lu8Bg@mail.gmail.com>
Subject: Cease and desist for companies and government agencies misusing git
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ok, this post (as well as the title. As much as I wish we could
prohibit such institutions from using our products) is partially
tongue in cheek, partially me venting and partially asking the
community for ideas on how to properly educate the vast masses of
"professional" developers still unaware of the soul crushing damage
their workflows (that barely work and definitely don't flow) cause to
others.

Earlier this year I got hired by a Swiss government agency. My late
mother was incredibly happy and proud of me at the time and knowing
that I just got bullied out of that job and finding myself once again
in the unemployment line is weighing heavily on me.

Long story short. The guy who was responsible for my firing spent a
good 4 months journaling my work and harassing management behind my
back only to blow up while on the phone with me, accusing me of such
heinous crimes as sending a PR from a fork (at a time I didn't have
write access to the main repository...) and *gasp* REBASING.

This dude is convinced (to a religious fervor) that Linus Torvalds was
possessed by a demon when he came up with `git rebase` and that in
order to defeat the devil, we need to plaster merge commits
EVERYWHERE.

His workflow is thusly:

- Create new feature branch based on the master or release branch (this is fine)
- Make changes
- Create PR (all PRs end in a merge commit, btw. This is fine but
makes his git behavior look even more unhinged)
- Check for changes on master/release and create a merge commit on his
branch (there's no logic behind this. He isn't creating a "logical
checkpoint", he just generally runs merge every time)
- If the PR doesn't get approved for a while, he'll keep creating more
merge commits
- Rinse and repeat this for every single feature branch under his
control. Merging merges into his merge (insert Pimp my Ride meme)
- Once the release PRs have been completed, merge (with a merge
commit, naturally...) the release branch into master.

Today I've counted 8 merge commits on changes that amount to about 20 LOC.

I don't wanna live in this world anymore. Beam me up, Scotty!

/end of rant

Is it time for an online campaign ala "Merge commits considered harmful"?

I have nothing against a merge commit being the result of a successful
PR but people spamming merge commits are ... something else.
