Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156F0BA45
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 02:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759630525; cv=none; b=RMvIhygdomun9Zk8ytFp3NpsuVLxOQ+8fQLBi2XFrSY9+5oKuCe7FUm/DeK/5xTcJuJuKaZp5fUMMRodazd7nYjFIWLa7KAd9IwzWeTVH8aoV9Q/YD021tN+mIbfC2DsPA/q8dz9kzzlzCZ+v3CWrFhTW5/Zuqa411GXqcf3DEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759630525; c=relaxed/simple;
	bh=czU59HqMUJCDtUtPZru+ssC0cqohnv3VAF4JkkAjTdU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=TKq6LhuXqc8Gtl1KUQjadnw2PxPWxFJxINOsHnhKgK62+MhE13uepaZ4bBTk3Qu0uNaWjqTONWF2eAPS5oXystlq33aGdkN/s8iwcyZ0IjA6L2ik7XnA+VoMkmlBVWRfRqtB6xKOS2ahFmWzpSSvmGVIeBmnYdA1PPZyNno9rA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVr8xSKs; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVr8xSKs"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57b7c83cc78so3509271e87.1
        for <git@vger.kernel.org>; Sat, 04 Oct 2025 19:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759630521; x=1760235321; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AmYxJ0nzTclkolRUCMFvkvpceigF+5nCHx2S2127tBs=;
        b=NVr8xSKs/T+uRbC/7lRjoZP9zpXIpAdsXqJmV+9C7mEF6+Y7moW8BxnUox8E1J6+wI
         fgt0cw1m/0K0CHT9Cwo9AzOzFa1FDCSth6SZb4UxKPXBbv9YG4utKjLLeXEZ0hZzukAI
         J4Zn34fBxyOz1y6NYH+2IMhF4Oq/Jt/REpifErcXmZWseXWPHwLNdIpE1+AIlYyj9ZpY
         b0MbLdppNHCEjzIQMP82P3e8BLewNbxK9+ftUt1ZVVt+iFoSrLtYQZip/W+M/QPtiUDj
         gzSA4/+FjUCN8li8nucRULNaQWBMBr6mU4yeIfd/wmjRpoQaEzgbMeJ9lEsGNERfEj3r
         DMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759630521; x=1760235321;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AmYxJ0nzTclkolRUCMFvkvpceigF+5nCHx2S2127tBs=;
        b=jtqb9flh/vbEE3foJLTyfiwmDzbdxI2LpgdpOEmkEWr0Uc/aZxvnaWUh2Ilpp15SWi
         GvvrCN4Wr2dgaisTiZehThbrS3FomT8pjZdMio5MsedVTLjZ78ShgDJpRVEzpk2WmV1U
         xIEwrKJTGGqymWDAuDzH1sBJtXruU5/4rlD8OI4pi9WGCs/kS+4zFfwAd9fboKXerdXZ
         jajkeajiyFYUs/5Egp7iPTSUViQhbT2x+Uqn1rcH67zYlizvNeQB5Gwl25Dx/V6tunsh
         jgOUQHOYwIJfcwQbIOq+yk23ja44C5NKUbVJmtSd/+7sZS6mr1GJlWfGlq7e5WGFamSM
         E3hQ==
X-Gm-Message-State: AOJu0Yz+TUlWIRelHw9C0EHE+HPEOiNiEum6bQw4OKIEZQZ0WrCu/qeK
	dKEOxnKSwyeB7uTCbtniyRXXoyPIIQ7jfKbvizalgHBIr1MQsoRneIca3zVrBd5ALg7bzA0Zf2b
	e8H3lonozydzq1o7RlYYhK0fzhur5qKkUL05c
X-Gm-Gg: ASbGnculV6Sglvy9ehVpuWTVL+SZ/ru2ppIUokqHU+kAGq6jCYlKsTUKCDATDD2Pfzl
	Nf2XwOliguX0mJtdR1E8iHEkLcrAuNwYSy5slAa0aQoK59lMH9XeJtBUYS3g+67xBisUm1fA6D3
	h5RFa4TBJBv+VCiz5Qj4b35TO8U5mbtSvc4FY3RQinAqsjnSUqcBR+RiJ5FRxy/wZOFvEJWEDB+
	HV3HKeHmERR2K76sEKpQwWjUBs25KRI4h+WUE2M0JwaCMptevwTXuZiKniHXG/1+lVuvVhBKxqh
	1jMl+fAXpHQ=
X-Google-Smtp-Source: AGHT+IHBEzE/OtglKBOQPm+frFqUvT6YLVmcvFIGIYBBiLSR+xzPcSmr6BvC/6G9weDTv47HzBVcslNKZmj2NzGwO1o=
X-Received: by 2002:a05:6512:3a85:b0:55f:6cc3:45a6 with SMTP id
 2adb3069b0e04-58b00b9590emr3738429e87.13.1759630521147; Sat, 04 Oct 2025
 19:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jeffery Carr <basilarchia@gmail.com>
Date: Sat, 4 Oct 2025 21:14:44 -0500
X-Gm-Features: AS18NWBIqd88zYani5cx26YvvVo2JC4TQ3APkJ7r4m6jUzyic0LDgHUAIEXhgmo
Message-ID: <CA+Hr9go-jyDeau8HVi+fUuiTTgAS_SNgyGL9x660+GzGJZJBEQ@mail.gmail.com>
Subject: git whatchanged -- yes, I still use this
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If you are going to remove it, "alias" it to something.

alternatively, I guess I'll make "git-whatchanged" binary to do it.

Can I ask what the problem is with it? The code is a mess I'm guessing.

I'd also suggest, instead of the message:

'git whatchanged' is nominated for removal.
If you still use this command, please add an extra
option, '--i-still-use-this', on the command line
and let us know you still use it by sending an e-mail
to <git@vger.kernel.org>.  Thanks.
fatal: refusing to run without --i-still-use-this


add to the message:

<run this instead>

love & respect,
jcarr
