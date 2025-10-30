Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237042820B1
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840316; cv=none; b=BVwPftv1JUV9NGFh/jmZ+kqYmr+mThnyLpiAQJswPpRjzFrvnKpME+MJjBqtdeJAq+24GtaQYjP3OUhfe3I9QAvIZ5tyacWiT5Ys9AceXp1snzxepBpenqOki2uDh10/8IC4o0OYJI6FgqjR1hFYG8JUnyy5gAIz8aTqNT7VaTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840316; c=relaxed/simple;
	bh=x3eHPEIzq83Ll6dBprnu2Q6SA48fxQ1LnAdTouhuTm0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=GMcuKvbI41pb0eNRvxlLczCo23IpHfYCFbCpczR5MVd7kFcxXL+2ncFkxJfyPqJ2ttCidswmWdHfOJQsoiFDW+9Ljr0qYxCoGRbJ0gvwtk9jWTi9yXPg6PtN8AGHqdv1J80X8pF4Z3mPJWAO806B/RuIugbCXPmUeIKM69nryIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9+AIbke; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9+AIbke"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7814273415cso12106387b3.1
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 09:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761840314; x=1762445114; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQfBcviIx9Rkp1kq91yG/Z2QXuZ9nhU9jrDzkn8kTcU=;
        b=l9+AIbke+fJg4wv1rHe0Llz/wkh4yWu/9o0AQwCRsseO08EVGHnq7XTgEi8pcaB9ep
         YlmIUSaytimKUp6uJloYoIWobpqvCOLSUmcTszZB1mnoOVadlgukspUldEZk/jgQX9/D
         h6a5KSBRpNEGeVveIbEkqtRBkz2QOashKIk2zZzMzpR7f26vXSjsnlxJTmWh0LHdq+hH
         8FSihRavTpxLMJQmB+ATc+427/15HccpLNYAnGV6zTPDPePOehoE+PzJrA2/vOEnZGRa
         7jR1VC1hZeLQcnhJrrXlAIZK+a80FkzqUCsF6zNKCHS5kadnM+5HJX8TarYwnEWiAhcJ
         RzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761840314; x=1762445114;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQfBcviIx9Rkp1kq91yG/Z2QXuZ9nhU9jrDzkn8kTcU=;
        b=pNiqPCJSERCjfxqKMKAROxXr7pS/TZ5+7n2Ij8Vr660D7JQzgboSAOHasWkIP8pp6V
         gcyd2WhOsCaXISXC8/pct7Ay9I7u01kTAARre4/hj95skhW4dEhYtJZ72N2xeBvoBUF8
         FPSVRrjRQt7GfjwQE66Hau1FH6pc3d8ecCNCh+zE9e0onFS7VQ5ffMl/CveEvm41qHeZ
         8izICt5I1v1AFucK0RH0ngVUNF5B8THvgpnnW2E4BwE6XNyvA5L4NM2nzGlLz+ZSae01
         nEz8fu5e9Djilfo3T3i3B3Xi+c3ZOOr/VUq/9tXZIbNAemuNalB3UWaUBy3oYH1Say1b
         9jhA==
X-Forwarded-Encrypted: i=1; AJvYcCUbc0FXc8xA+sWh+4L2JunQV9eKaQ8Z9u6DVyDblUySMChPkNirOrkvx7C+0qjB24qGyf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6VwtWo4HuoWE6mx9j3mcIpgCKfReZ+4g83TEsuX0v8en3Fkis
	Xfghr3kWs5EKF6UFLEUgXvmppK3F08YxOqGm3pHHsMo/tIb9yq3GUumU
X-Gm-Gg: ASbGncsgSSxp/WTb8hMcnHjwCX0WuXCA1lu0joI7it6YysVjtZ4+c+9JuOycOzp/hB1
	+YZxllhO2dfRZuV1V3+ABngkLbCeSEheLA1UsCZ0C5Ihe45GR6hz7Yp/GkTPGFQD7+fHt/dmiyD
	uVJIYYCaL8ldPwgiwSINGa8zwGAJDUJB8GSWDOWqYqfnCtQcCvrBelMOZ72y2T6Ja01zwfeIH1Z
	ZVOaHzPc5pBhD6Oth113JMb5ZtjgtAKOUqmJTIakcz4tUJEPh/Sb9MZ5SyxEhDIumDQis+IQdRk
	mPP5seMDCYycvRTk8W7XcrCIEi1h1VmnU7cUrGto20WUBhK3e6cpq+OgdeMCj3Dun8Tba7kHD4P
	dYpAhenXTU9ngP5NCIRHznaRCnOlr0KnIyfVot1p5PkJmfCZABz5dAFiXWl6zts8osTKb57vc/8
	ME4el7EG1ueXBUFKYM+DQDvVFAnV/J
X-Google-Smtp-Source: AGHT+IH3lK3e7uAm6Gc605ahP9Hg+YCV9kEErDM9kMAfzRobtxFif48f7ZuhLe4fL3iSrYcT5WKi+A==
X-Received: by 2002:a05:690c:a045:b0:784:8c2c:323c with SMTP id 00721157ae682-7862900f362mr62452457b3.36.1761840313646;
        Thu, 30 Oct 2025 09:05:13 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:fd05:d5d2:f908:cb7f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed13f2e7sm46252567b3.3.2025.10.30.09.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 09:05:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] doc: document backslash in gitignore patterns
Date: Thu, 30 Oct 2025 12:05:00 -0400
Message-Id: <3F5E99CD-5EE0-491C-8BFB-ABC01922073E@gmail.com>
References: <20251030150814.GA1275070@coredump.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
 Sruteesh Kumar <sruteesh.oss@protonmail.com>, git@vger.kernel.org
In-Reply-To: <20251030150814.GA1275070@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: iPhone Mail (21F90)


> Le 30 oct. 2025 =C3=A0 11:08, Jeff King <peff@peff.net> a =C3=A9crit :
>=20
> =EF=BB=BFOn Thu, Oct 30, 2025 at 09:40:36AM -0400, D. Ben Knoble wrote:
>=20
>>> There's also the "pathspec" entry in gitglossary(7), which does mention
>>> fnmatch(3). Though it is even more confusing because of the literal
>>> matching that pathspecs do. I don't know if we'd want anything there
>>> (and I kind of doubt people get as exotic about patterns there as they
>>> would in gitignore).
>>=20
>> I certainly wondered about the pathspec case, since the commit message
>> called out the difference in behavior. For example, at least in this
>> one corner, we can't reliably use Git commands with pathspecs to build
>> up example gitignore patterns to throw in .gitignore?
>=20
> They're close enough that I suspect people do use them interchangeably,
> but there are definitely important corner cases. Like the anchoring
> stuff below.
>=20
>> BTW, is the literal matching intended to be conveyed by
>>=20
>>           =E2=80=A2   any path matches itself
>>=20
>> ? If so, I'm not quite sure how to interpret a pathspec like a/b given
>> a repo with a/b and dir/a/b=E2=80=94do both match or only the former? I e=
xpect
>> in combination with the 2 subsequent bullets that only the former
>> matches. Conversely, with a pathspec "b" in that case, I think I could
>> read the docs as suggesting both match, when IIRC none do. Hm!
>=20
> I may not be the right person to ask, as I wasn't aware of the literal
> match behavior here until I tried to write that wildmatch test, and then
> walked it through the debugger. ;) Finding the documentation
> justification came later.
>=20
> But yeah, I think that a pathspec "a/b" will not match "dir/a/b",
> because pathspecs are implicitly anchored to the start of the path. So
> "foo" in .gitignore will match "some/dir/foo". You'd need to "/foo" to
> anchor it to the top-level. But pathspecs always start at the top-level,
> and you'd need "**/foo" to be the equivalent of gitignore's "foo".
>=20
> But even that's not entirely true. We allow "*" to match even directory
> separators in pathspecs (which is what makes "*.c" match anywhere), so
> "*/foo" is enough.
>=20
>> But this is a bit of a tangent, and the pathspec entry is already, uh,
>> complicated [1]. Without a good place to leave extra notes for cases
>> like this, I'm not sure what to do. Certainly unifying the behavior
>> would be incompatible (if obscure).
>=20
> It's definitely complicated, but I'm not sure which of those features
> are important for command-line ergonomics, and which are just pointless
> inconsistencies. I'd be scared to start changing things and finding out. :=
)
>=20
> I certainly don't have any objection to improving the pathspec
> documentation if it's unclear, though I think that can be done
> separately on top of the patch in this thread (and I'm not planning to
> tackle it myself).
>=20
> -Peff

Agreed, thanks.=20=
