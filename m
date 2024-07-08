Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FD414659A
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456687; cv=none; b=YAVNQUAtLivcxqb/MorxQvLgirR/eaL9x0FDcgVg89Z+suK7QN5rWrKI4d8LtJoO1knIJ9xaoamQTMIUyy806SuaUbmDw7K1EwRpU0pcvUI3wGrGTMWCXdnzeWiInICAkPuLALcQqmaXR3FuMeB9I3jdY/FZMG1SqPEa2+dHHdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456687; c=relaxed/simple;
	bh=C5I30X/f1Hg18ceNpPzyiucjpBG2WJA5+D5/E3W0eCk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ug9sy62IQSt5eQx2o0FXDZuB3/bOdSV/XdGE5QOTSiX7Y8zDj9sR2+ivSpaiGb9BPhUGCLJlNUc0o8BTCAH6YqUboAbaEY825t3HrhPnV8RTT+qjhTLfnmCSLERAec8S96tkoHUI6gsWnKef4P9Eu6Xolcc81cBbL7Vpf0epQ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFY17vHB; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFY17vHB"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e034694b525so3423735276.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 09:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720456685; x=1721061485; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C5I30X/f1Hg18ceNpPzyiucjpBG2WJA5+D5/E3W0eCk=;
        b=WFY17vHBMbIO5x46EAuPML94PLmki4S10lGRBFhT6GjhLGznyKT+OhRN4Imzseu+QT
         VACem3hSd3T3mN3RugenImyCCLiK7krZ19OUdoR38IHDsU/78pAWElotvV/+Q1qwt/Y/
         r6tpsvtGbVQeNlCAxztB7jJliiw8xVnbYFDRXD9HBHzt9+de/OUzlmDnoPQPOn3aOpS1
         xZ1JAL5h9SnjT0nc1LJ1g8G/irII3BBPuNhQLHoPd90uRd/IhUV8zRIQYP5WD4JQ+uWg
         V81DzY6K0ZOapAsxInCaCH8mM0Bv3j134DitDKGIJgygv88zVwWOnlc/R479rNznHvME
         zorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720456685; x=1721061485;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5I30X/f1Hg18ceNpPzyiucjpBG2WJA5+D5/E3W0eCk=;
        b=ooPxVVsV1QEQrai0IWzl3jNS1wJuNozqtkwPWUDS70zVfPFHCoxTJJrvacTEHn0W4+
         tnJOGdn+R7zPVuy7lmT/YvSudMx0UAc9bVziKn3K9wL8h7ytAZ/RVAkI+ViNWDCmKmtf
         Fi1wsf6lvKDk+bKi6WTzg2nn6jOCufmTeDKP/5nO0nhq21bXWSrdWidgOUwauBpgOAZX
         VejPZsP84RDEUOWUxcc921GPwq8ZrNBbB1ROCvl1r5rDpT00Op1dG8sUs8OSbQmcXsH8
         XZUm3rbC0GsOuAxU4wH+KtHuTXA+08xgbZs0p5/HOyGyOxPE9V+gLpnlMjx52K1VE5y7
         fWYg==
X-Gm-Message-State: AOJu0Ywtx7HbwrSrUZkajsssmRbcglFt3a0nPm0F+NmrbMnr50kUtxMy
	CE2GuKUdSCofhYW8JL9LWjqpM3jRd4vp8zseDJ/UikbhdyPzBaIKYgGJDaE8D5eBNMMJtMTzSBv
	tGuB/PIZ67qwdwAEffBdSDatJZjqX6w+6
X-Google-Smtp-Source: AGHT+IGVABDDJ/AsyEh6HzjTGwNv0PlBgBy/ZH0N5Rk3PCPf9/cp4i4p5OLB4WO/3udHdZhfRALvw8CJ6QE6L95uLVs=
X-Received: by 2002:a05:690c:6d8e:b0:63b:b473:1b91 with SMTP id
 00721157ae682-652f6ccafb0mr81411117b3.23.1720456685096; Mon, 08 Jul 2024
 09:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nathan Royce <nroycea+kernel@gmail.com>
Date: Mon, 8 Jul 2024 11:37:29 -0500
Message-ID: <CALaQ_hoDqD6CXEDy0YT8no3SaoJSqV6toMtyRHdJr6h3RZUiLA@mail.gmail.com>
Subject: FR: Provide Out-Of-Tree Building; Provide Cross-Compile Parameters
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Let me know if I should be submitting each of these feature-requests separately.

For projects I built, up to the git project (think LFS steps
(altered)), they've all provided OOT builds so the source directory
remains pristine (albeit those that needed autoconf to be run for
`configure` generation).

They've also all provided `--{build,host,target,with-sysroot}=`
parameters for ease of cross-compiling.

Looking at what the git project offers, and I'm not seeing either features.

Looking at the Makefile, I see mention of `HOST_CPU` which looks
pertinent, but being able to point to the path of the target root for
files to link is important and I'm not noticing anything for that.

Grepping through Documentation for `HOST_CPU` comes up with nothing.
