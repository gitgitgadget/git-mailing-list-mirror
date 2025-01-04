Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE023136A
	for <git@vger.kernel.org>; Sat,  4 Jan 2025 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736004975; cv=none; b=NcuQgBY5U4KboRQnwmfK5YkUCj7IDY9rGhYBBT0hOq4+eF83Wvc3BOfLH15yZH26TvTdg4NpTcamqYotXI0f4iR+pB9JbmrpjHE4npSnLRYDv4kmEM4z0UpE9nSpNvZ3yh6L3r3idFc56fM17CAorDDrlUBavZSgZOf4lW04kis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736004975; c=relaxed/simple;
	bh=Zn7eY8sEwTYQEKv5H1rglsWoEBNdaPqK47f8kppwZJc=;
	h=From:Content-Type:Mime-Version:Subject:Date:Message-Id:Cc:To; b=m6pbastXd1NTfkZI6BUb32ansecrVoDnH+bNMEZLTynxz6aR2AoSUX6QPcIDlLHu4bodKPZl4RnWaJZ4yt+S/O/ebtVZgIGSMQj1s2HOBmyJHv84i1DWHxk8lb7PEduaFDYjSeIGgmvPBQAylVPwJXCI7p9L6bMjTq//nkz/OGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmsJ7doI; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmsJ7doI"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6dd43aa1558so90439006d6.0
        for <git@vger.kernel.org>; Sat, 04 Jan 2025 07:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736004973; x=1736609773; darn=vger.kernel.org;
        h=to:cc:message-id:date:subject:mime-version:reply-to
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zn7eY8sEwTYQEKv5H1rglsWoEBNdaPqK47f8kppwZJc=;
        b=fmsJ7doIw3IxYO8rxX0vASdu1u8/+yCKiZ1N9pVki8LxsiC63CwWkyCUnH84i+nmvo
         W69ZswWC9ZEwN5o0XdBmAf1K1DLYmn5A/7UFhP1jxzpG2VRCG15hJkXslEzwyREOtEDs
         /PhEMD+zSwNDO1Wc8e9Y5eAeOM0IfQ23kA4uzO71hYh+PIPAxHvRN4eSeRerQlaJyUay
         S9vF6wHIqk8c4JigRupi7JU8ijNgYVunFENkl+Ccq01/J21jZBLbkixJW4oKJTBU6Jt5
         t6IXwr3Tx/5jW6F5rY9KmYEC5eSJxHCsvR3uzXrf7oOGXFv3lbkruLp9AM/GhvABWz+p
         8iAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736004973; x=1736609773;
        h=to:cc:message-id:date:subject:mime-version:reply-to
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zn7eY8sEwTYQEKv5H1rglsWoEBNdaPqK47f8kppwZJc=;
        b=uC2a1GtddFpTW6L7ThIS4Ezr3dxvVb7SGeUx77jqiyjagmf8P19a5gE94UsUFVfirA
         0eD/B2Tz0ibKkjzAOZiYdP8XSs5j3KkJG80MvB3p6/7GBIjBfBO2IDgfYmJIwwmHrhcA
         24B1PkRf8WSY8VQDXvHk9KhqvpS8vQYvjRmKBveMdNFCNkHBPKgWz+OTiz0Pe3y6nK9M
         LNiqnLWL7S+VD8pvD+UVzrcs9PFK60YKu8CrLW4M9MYGmZI3JIdiONKYgu2pvAo5WABF
         eCyV1XETgQnS9aiYZ8OKA8HJZMhLpP/FA+syzetp/IvSHj0IOfnKbwCq+tI+NneD8tuK
         jVyw==
X-Gm-Message-State: AOJu0YwhsKMScSYgp9usHZgHenGGpH8D7VpHFNb2JAiRU5xCUWKqxNes
	ew+TRVn/sf0VkCByl9MFBkTf22LFLxJVOCjlU0YrtWdZTNIR28kMPd3iNx+1h8Q=
X-Gm-Gg: ASbGncucq3to5VTzm9HD+2iZrWRGzlpPLZPv7uvp64bX22Puf9/Jgdc4QiYbce9ge3l
	MRv30p9Ei62r906G+jpXuxem1BkpH7Kvw6ZMVhgp4Dnv+A0EsKDNvS5o4MLrgBc3E5HEFqnCxHL
	Tts3svZJUAJ9S0rMYcYSgfGMjQ5GgTqrkHv7Ep5EhpwyyqlIZFooALhzrX9HtU/knIgKWUOAibI
	jep+H8fnZHijAjTRNU/aUxDzmqSHlVmqGX9ceymZLvqN8WRf/17yyB25uuGCojJ4qDqFziKCZ2R
	iZ+C
X-Google-Smtp-Source: AGHT+IHlq38yHbt9pteY+UwX1MyYI3TJbBXGZVubJAl0RfZcLGvbCbJgrYG4kMnuytB2x3Lq6dP5rQ==
X-Received: by 2002:a05:6214:3001:b0:6d8:8742:137c with SMTP id 6a1803df08f44-6dd2334bfb4mr818091936d6.24.1736004972869;
        Sat, 04 Jan 2025 07:36:12 -0800 (PST)
Received: from smtpclient.apple ([2601:5c1:8380:760:46:1c0c:da58:46a2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181bb4bcsm151684956d6.86.2025.01.04.07.36.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jan 2025 07:36:11 -0800 (PST)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Reply-To: 20241211-pks-remote-branches-deprecation-v1-5-1431e2369135@pks.im
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.10\))
Subject: RE: [PATCH 5/5] remote: announce removal of "branches/" and
 "remotes/"
Date: Sat, 4 Jan 2025 10:36:10 -0500
Message-Id: <0F4D68EB-27F9-4638-98CD-02515969D677@gmail.com>
Cc: Git <git@vger.kernel.org>
To: ps@pks.im
X-Mailer: Apple Mail (2.3696.120.41.1.10)

> +As our documentation mentions, these directories are not to be found =
in modern
> +repositories at all and most users aren't even aware of these =
mechanisms. They
> +have been deprecated for almost 20 years and 14 years respectively, =
and I am
> +not aware of any reason why anybody would want to use these =
mechanisms.
> +Furthermore, the ".git/branches/" directory is noadays misleadingly =
named and
> +may cause confusion as "branches" are almost exclusively used in the =
context of
> +references.

s/noadays/nowadays

Is the first-person intended? "I am not aware" reads like editorial that =
doesn't
match with the rest of the document (either "we" or technical-passive =
voice).

(PS hopefully my mail client will get this to the right place)

--=20
D. Ben Knoble
