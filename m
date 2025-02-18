Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A75314A09E
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 21:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739914089; cv=none; b=j8vcRZR7BMpsFhrG0s5mzezWBtPZTzaOnn3MemZxNIpWIFoqD8ZSNVAj2OTsp9cUMnBrZKVhwGILnibP45OLGdq3ImKUUKrk+dIxqxKSpy7tkG59pq3jXQDp4XxJgKAebXaJd3ADOUXocLmvFOZIBLBkgXbrrgXqSZZIUetsRO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739914089; c=relaxed/simple;
	bh=j80yUqCjRzQ4k7qNGwm8gytuVsFqR0yGwQUWumhcnKk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RAm2DQ/lpuABdvvb212arb27b3N5wmZORTtvbUcHM8r+aRPKXkJGIR1YitS5R3y/iTa+8z6AKfcrMvHHdtFXnCIfNwchqolDzlgjarL6/DJ5nXTuJ1mWIBEZQ2YFNvNLf0XC/fhFr5lwwAGDYd4z7/YA6WiFgxQGIJD686L6Ky4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhQxyhXd; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhQxyhXd"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-867120d67baso2035675241.0
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 13:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739914086; x=1740518886; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j80yUqCjRzQ4k7qNGwm8gytuVsFqR0yGwQUWumhcnKk=;
        b=AhQxyhXdmUaGOSpf0hJH49QO9Non8P121uVszWHWj+nCQeLX/ztOBn6muKz1BtOBNf
         e8Scn9kUKva4tuhkD+3tVBmo0l8N4C3RiHuUDoJE1Q6KOPf3lCdMIes1DOwBtGQGbrc7
         eEmsJk5JW0tptPKRwvU4oaHN98oKtSJ0so9QGl/RxnBreFog5FIqiMc0nG5j/DdzueCZ
         fG4PIv1IaSuHOR5zU1c6y4Pe4DNsR0r0uNCghk+HoxwS1rqwVvxZ2zuV1leFo/xckgXl
         XT/KC+Yu6VRb5CmMBiVmP8oRw6LgZ9tOHOXiwjxq2bVCY2xJN3I07DLEzOb2uBFBGpul
         PAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739914086; x=1740518886;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j80yUqCjRzQ4k7qNGwm8gytuVsFqR0yGwQUWumhcnKk=;
        b=JMsbddzyBbKzvse/HADbDKOEJJeAVsks41gvzVstfBVy5NQdtD5UH6vY8MF/vc2awP
         qMO+qIR6kSJA3YpB6Bc7OuYtYZGDOdjnDHpFwrYAcZd2XvZFQHKTsEvyU8HRHWPhTCD8
         h0sRWUUgFHBmiMfC9Z2Qf2aJyiUrZfntCiEPdVYXS2kUY3FHAV3jan91zzBiWEXQq0WN
         9EZqF3HdKcab2JDVRFKqBNjFGoznZeDdMW663DayhEv/xhSn68n/HhI81ImQCOK19mJW
         13iPZHQHiK+GtGQ5hS6Z8Zb1+f4IPrYfOhecmkIxJQ2n7i+yqp+2zdQ9Bsl+hUsJ/WQP
         rWOw==
X-Gm-Message-State: AOJu0YzZoatyDWGRq1UQWtpxxPTEDZPtU9Ltf17Xcud9nxv288vKcBLt
	Rp+VVRcc0ema+2alvc1ui3N1q+DojLpFqnKsbEPLuFtUEk/8qY8uvMJtLP0RUiJv+cW/og31xH2
	mvt8SrDSAQjtVfdr4JXreuRFWLn4tmFtx
X-Gm-Gg: ASbGnctFqih5mstKXbYSAvRApRyM+rFnXWXDfh62yM7V7koFfarram8CiZKWwAzzZxK
	/57Iw+dblil98mhp+6akvj/ewv3o4An7CwGfsIX/jQVXU598uae5ZjY9RF4Nx+h1AWHLNGzWQe0
	U=
X-Google-Smtp-Source: AGHT+IHnA6ivKx6zKK12A6a8QctGpbBu4oRCz3qmDLEJn/i8/pCDXQQTfw1KhTaQFEXgIRWjfSqexoPO/6mjJ5iNcAA=
X-Received: by 2002:a05:6102:d94:b0:4bb:b843:95e6 with SMTP id
 ada2fe7eead31-4bd3fc9869amr8722309137.7.1739914086265; Tue, 18 Feb 2025
 13:28:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bede Skinner-Vennell <bedesv@gmail.com>
Date: Wed, 19 Feb 2025 10:27:54 +1300
X-Gm-Features: AWEUYZnovUEL5emkfcd7830Wq1xgjJilxqpiGwc-aXyessP-K7eHhRPb24dlER8
Message-ID: <CAEiLEbOZ7vGE6U69sf5nK+G86zaeAMRTrjaCr=rF2JU1H1p8ww@mail.gmail.com>
Subject: Incorrect URL for Release Notes on git-scm
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Git Community,

The link to the release notes for v2.48.1 on the git-scm downloads
page doesn't seem to be working.

It links to: https://raw.githubusercontent.com/git/git/master/Documentation=
/RelNotes/2.48.1.txt

It looks like the master branch now uses '.adoc' extension since this
commit: https://github.com/git/git/commit/1f010d6bdf756129db13d1367c888aa41=
53f6d87

Using either of these URLs loads the release notes correctly:
- https://raw.githubusercontent.com/git/git/v2.48.1/Documentation/RelNotes/=
2.48.1.txt
- https://raw.githubusercontent.com/git/git/master/Documentation/RelNotes/2=
.48.1.adoc

Ng=C4=81 mihi

Bede
