Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3DD811FE
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718366601; cv=none; b=eq/DooVkuVIgpzYUBKuq64QlAFFN8+3SrXusHPIdbxwNPLk6G/voCjstHoNkGyK+vBnen8vHsB2sVDkdrbUCwNbyVQt1HC6FZcg21ChaofNKGm3aYyErrY6NRRUlAPZq3wafbxDqDH7aQZyMVTS+MCM5RlNRxNNQmktltdykjgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718366601; c=relaxed/simple;
	bh=46IGzdLL5FQQv6JCM9mPUf1ym5YkzI8ccJnQ/ANS+VM=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=XIl2Iij9rR/oh+4jpsRcI2ZpBlPegL8GMdaxUMqm5rzaGcSQ3mKqv2sUOctn73+RT+wTrcxF5BHozDA8jZ2q51VRrSnOTdKDBC9vQe/yeFeugyI7ksEj1DDcWfk0pbL6nnE8QT7QPl7jGfSC+fS6Y8s0K+MPJvNKr+RZSnE9UZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adqmVVWV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adqmVVWV"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35f2c9e23d3so2125621f8f.0
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 05:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718366597; x=1718971397; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YKN03u9g5iT5+/k2BMEzxqxt4fZZWU5+RJ0EOF1FT4A=;
        b=adqmVVWV03H2lIJIISxe1Pa21ZZWppkQF8eGVzTj1BHU3pwS3qLw/QgmAF56rEg+Xi
         lee6pzGst+2ywGyyGe01VWEYI5DuzKVZx9nlHn6DwDsXr0BO/YxUWgzOXrCipAoyMxsB
         LFN/Q4RtmgWS6+rBzKN+wgmp5ZS0HCzeeLkI4IfiSbpGSYoeF7n8v8hcweFIMd5iJekq
         rPkke6Km5ZT7+DEBXFGMcjuQ129sXGwgUWiXZW1OSnLek9dAJMamnaop9BvlRxChEVEU
         xyL8gZ46udsJivBFLFGDe+WlmHIjUBGgM53j/QZjaoNg0pxvgXSZCSOXTuDRXhUmRQYf
         ICaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718366597; x=1718971397;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKN03u9g5iT5+/k2BMEzxqxt4fZZWU5+RJ0EOF1FT4A=;
        b=tCaIIkcpXQuJqteA6I/YgIQz+cAU/x1ORXEa5/UTxTZ18irTMwqnuDS1XYKJj53Zos
         YgqZ2ITXvHJNYzFm0j3bzjpunWTVBL4yptP6qifBXyNMsh6/BH41sX/NDN/JILHwp4zY
         8IGB+YUzjIRfqRitTPSdpnQqRWMPDxkK4zBEPk3X7ylp8gSG93G0DAbskqoqyOCb2jpX
         vjHOKVyDc8oz0yRkV5l5v5MlKL4tzYy6KIxDDAPbsPbE91apbbugukiQbT5oxMmO7tux
         b61aPPvS/PHx7JgMoHkyI3Fu0HOs15ULAJBbFzAklYrx7tBmIiShC8r9r48TCzoUPb39
         PsdA==
X-Gm-Message-State: AOJu0YyklASGZxvFrpRIeMuM6/v6js3IsMrxTWTIJK4Hbf0kZBQy0s5X
	ABb3PUztLnPNdqyeAYiYd69oE22cAbied665O2p/yLGTL2F3HtgF9hh7nbPZJ8Q=
X-Google-Smtp-Source: AGHT+IH48cZi/etrNpMW4eknDW2p/7CMeUibLp6KHAr79MbRFTDcJ22xTlzoL2VLr6bHb9lSrsz+Tw==
X-Received: by 2002:a5d:69c2:0:b0:35f:1c95:4042 with SMTP id ffacd0b85a97d-360718c9d97mr5153745f8f.4.1718366597003;
        Fri, 14 Jun 2024 05:03:17 -0700 (PDT)
Received: from smtpclient.apple ([2a01:e0a:565:11e0:e531:f1c9:c5b7:7516])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602ef0bsm56882955e9.18.2024.06.14.05.03.16
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2024 05:03:16 -0700 (PDT)
From: Alexey Pelykh <alexey.pelykh@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Non-blob .gitmodules and .gitattributes 
Message-Id: <4F3AD9A8-DA3E-43E2-BF9A-9D7458EED7EA@gmail.com>
Date: Fri, 14 Jun 2024 14:03:05 +0200
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3774.600.62)

Greetings to all!

I've stumbled upon a check that ensures that .gitmodules and =
.gitattributes must be blobs, yet while I get why they should not be =
e.g. a symlink, what's the downside of permitting (and ignoring for the =
actual purpose) e.g. .gitattributes folder?

To better understand my use-case:

$ ls -lA dev/shared
total 8
drwxr-xr-x   3 alexey-pelykh  staff   96 Jun 14 11:53 .editorconfig
drwxr-xr-x   3 alexey-pelykh  staff   96 Jun 14 13:32 .gitattributes
drwxr-xr-x  14 alexey-pelykh  staff  448 Jun 14 11:53 .gitignore
-rwxr-xr-x   1 alexey-pelykh  staff  613 Jun 14 13:33 share

and

$ ls -lA dev/shared/.*
dev/shared/.editorconfig:
total 8
-rw-r--r--  1 alexey-pelykh  staff  377 Jun 14 11:53 shared.editorconfig

dev/shared/.gitattributes:
total 8
-rw-r--r--  1 alexey-pelykh  staff  143 Jun 14 13:32 =
shared.gitattributes

dev/shared/.gitignore:
total 8
-rw-r--r--  1 alexey-pelykh  staff  4450 Jun 14 11:53 shared.gitignore

Surely, the immediate workaround is use a "_gitattributes" or =
".gitattributes_" name for the folder, yet if a directory with =
.gitignore can exist - why can't .gitmodule or .gitattributes?

Be well,
Alexey=
