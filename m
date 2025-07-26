Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210609460
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753544734; cv=none; b=Eo6hrA0bqwdUpxa778qCHQIVTig4dSN/VP8+7aKgy5FEzLq/YCLG/gnjHsdM/ioapznlCi5UMEVJEgePwuSHPU6NU4iX4lkqO5JfQ7td4eItXTPmiEuUq+PZDE7a2F0wqOe3OFkQhd2kFDcKjY0BBJ0xK6Kkck/iB/Hrvf8pxso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753544734; c=relaxed/simple;
	bh=BYFJsWTr15TmsgKdizh0mKwOE1fVsxmecJNp0MwHK6k=;
	h=Content-Disposition:Content-Type:MIME-Version:Date:From:To:
	 Subject:Message-Id; b=dpjCO8Pno6J3eqHHrTZ1bWeA/TyJxDsnVWvm2hL7+nArsFtzJBx0+TwZiFZVWILt0+eWhAMfzRxBpYHBOfua8pzgXLd3Fphs3gQXMEIXapP2HPnHEEc1KRHfBFXZ9XTEieCLyYS63FI/jo0vhYs5uLtgD/GvT8YHjydrhPMAL/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSA9rOtM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSA9rOtM"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-455ecacfc32so13767085e9.3
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 08:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753544730; x=1754149530; darn=vger.kernel.org;
        h=message-id:subject:to:from:date:mime-version
         :content-transfer-encoding:content-disposition:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BYFJsWTr15TmsgKdizh0mKwOE1fVsxmecJNp0MwHK6k=;
        b=CSA9rOtML82l4uC7U5U7oIRtBwIxSHZ3QEeXN6NU2fN83bPzqgOnN6/vkRvWoxHkG5
         YCfA8XzTA2aDIvL/IvcTuruFtazkH0eMqVAMR/2ewDrPhh4WQ/rbBt1l5VuRFwl3L7Ah
         PaAFW+sG24lw45KUoDmorIuPT3pFLZwbOjIzGVme+sBbMT052/ZUg/NW/ToCmdt5e31F
         K5pQOIlHI2a4vxG/EW1yNggMwOUlx5A0MTpOfLHySP9cMWLEOR7bQaVE8IVmdL0A/2CU
         c179Z/VOwm43GlJXCX0G0fFGs1w7dq/jj/p2n/862YHk43RaAa6jn5Pf25G95SL/VJNk
         HzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753544730; x=1754149530;
        h=message-id:subject:to:from:date:mime-version
         :content-transfer-encoding:content-disposition:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BYFJsWTr15TmsgKdizh0mKwOE1fVsxmecJNp0MwHK6k=;
        b=dnCZByyl3bTCAT/+khUE+avgOcy7k/3bjOBO1c5av02zm/Z0Zz2q9Z7xq69x1ZNou8
         iciQHSbOorOCyrPDE88ZBZTCyxJCaYboyIkx2cP2uHi5fZm1WoBhttWKOoc4cY9l2ILX
         TeNCzWTeEUFzb8b+fDfUcUcjYOI4bzxVeewuUNqi+KFBjZufu7A2Ghvvuc7ItNS7Mo82
         HI6Az6xTiUUJLCzKdvQ0ryOelcGJYyQpcy8w9GSij5nkmZTwvgp5TYnAQ6qCx0Jxzbbs
         hwMVYSUCrmh523CjRoQWcVUOxmo5MTiQe4VnMgteYz9RsbVF9a4IPIEPjFcDMA+T5s58
         jepQ==
X-Gm-Message-State: AOJu0Yzs/rp0gv1sNzrqDB8Ew6H/JknuWtsiGOy3sY/0BLfn5fy0ATgT
	ktNxljqhzJIgbrz7EzS2q8GWlnbcMJaMmKSWihSw6Bf5YJLaxPnaD587Cvz0wg==
X-Gm-Gg: ASbGncsM8igkxmwBKCrzc4LDGlaDiHaGCaszvIvNwyStcubnW9PYTdfyqy5/Kjbza3E
	K05qIsAGnccOsiK0LxObtYK0voumvpRDe2kqf4WO7GnILKp649oI4e6hqN0TYrRYXlMZR2ycm2u
	RpZ4pLfc2M9IBIwFHSIIwUa3K7yPCz4/uXN/cfJSwv4TC1rfTSHby2STaBYaoNJZYcCpwmSdrx0
	l3DQ7W0PS98NdcY82ztc2s0QPO9niGzCUPwcAEq4N2bTiz6ELeMm0Hpek9WqfLhPzf/rO2i/++J
	O+ke+zGwCAB+2WLwMQ8AIAGfh4iia+T8ztPn3h8BbF3mQLJco6YXTaFfRg+IIb4o2uuIns1a2yJ
	Hl+2iSmVmwnj1iuf4fgkBg/hRtE/D46GK5XPAeaMM0dKJKyUmQ/wS5Fi9werQgNjX1O9tnQ==
X-Google-Smtp-Source: AGHT+IHByQoNKsEKYbrGff3L8nW9tX0xxB2m0o41vjGK8uOyE+5gXSTtsoxJG1jFL+Ytr6IAXvVDgg==
X-Received: by 2002:a05:600c:1d1c:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-45876663f5dmr47024565e9.31.1753544730101;
        Sat, 26 Jul 2025 08:45:30 -0700 (PDT)
Received: from localhost (92-184-97-38.mobile.fr.orangecustomers.net. [92.184.97.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f03436sm3140766f8f.51.2025.07.26.08.45.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 08:45:29 -0700 (PDT)
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 26 Jul 2025 17:45:28 +0200
From: Victor Duprez <duprezvictor4@gmail.com>
To: git@vger.kernel.org
Subject: [RFC] git-secure: add explicit authentication before push or clone
X-Mailer: smtp-cli 3.10, see http://smtp-cli.logix.cz
Message-Id: <1753544728-979474@smtp-cli>

Subject: [RFC] git-secure: add explicit authentication before push or clone
To: git@vger.kernel.org
From: Victor Duprez <duprezvictor4@gmail.com>

Hello Git community,

I would like to propose a new Git feature: a command called git-secure that=
 prompts the user for authentication before executing sensitive Git operati=
ons such as git push or git clone.

Motivation:

Today, Git operations like push or clone can be executed as long as credent=
ials (tokens or SSH keys) are available in the environment. While this is e=
fficient, it presents some security risks:

- Users may inadvertently push changes without noticing.
- Machines may store tokens or SSH keys in accessible locations.
- In the case of theft or shared systems, these credentials could be silent=
ly misused.

Proposal:

Introduce a git-secure command (or option) that prompts the user interactiv=
ely for either:

- A GitHub personal access token
- A simple password generated by a secure third-party password manager (opt=
ionally linked via API)

This token or password would be used only once, then securely discarded fro=
m memory and disk. It would provide an optional extra layer of control and =
security over Git operations, especially when working in untrusted environm=
ents.

Prototype:

A working prototype script is available here:
https://github.com/VictorNafs/git-secure-hub

Example usage:

$ ./git-secure.sh
Enter your GitHub token or generated password:
GitHub username:
Operation (push/clone):

Thank you for your time and feedback.

