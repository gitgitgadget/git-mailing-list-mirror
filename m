Received: from mail-il1-f193.google.com (mail-il1-f193.google.com [209.85.166.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7E2A944
	for <git@vger.kernel.org>; Sun,  2 Mar 2025 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740911704; cv=none; b=mWxKoYw0V8Cg85KQ31h0FfUHErzNaVFlNxSoez/+sDqchSr5kArW4XBcB7U73qR9gn53+As9dl/ZE28dIFcFcUXDw7C1JHsKOOQqZOfjW0ibU7xXSqNbPk4E6EGIM/MNmX1e8GsN7q9BtaHtO0Wh2L9+GWokUe+PaUHr52E7t3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740911704; c=relaxed/simple;
	bh=3Bk8MHrBJsR2XaptRNYWBSybSxAJ6sb5L8OlyRqwsRM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=swe0OzJpxlSlf+3ynT73M3oEscsr3At+2xHSH463pWks5CzCiHSHCnHuWcVace/vV4zh3eZc7dR0jZub+h1SN+BIJfSjFL7yW+4j/dDF9DUKT/ssw9agHim5MVpdcNbT4Wejlv0sJoCUjflwmiYKcrRA5hvuXNJww6KpFR5/F4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoWkorYg; arc=none smtp.client-ip=209.85.166.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoWkorYg"
Received: by mail-il1-f193.google.com with SMTP id e9e14a558f8ab-3cf8e017abcso16084645ab.1
        for <git@vger.kernel.org>; Sun, 02 Mar 2025 02:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740911702; x=1741516502; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Bk8MHrBJsR2XaptRNYWBSybSxAJ6sb5L8OlyRqwsRM=;
        b=RoWkorYgTl+KZnaPrHUSUE8LCx/IOdgVFnOUCZcmTc+9K2TME/ctWgGgjoccZ/d5m5
         0xEmP/RbgkwR+XmW1mR+DQ0GDX8pH69PTjxAHIDshBKMMuK/UquSy3aHq35LWEkxUgAS
         yKasU9JUn30NgZ6uuOWHBPvP/+kRoqZVoNuUU6PZt3uGp5ZloWUjF4vjZSmwki59t01r
         frTKMh0idY9amiwJn4Gd4ew8YGl+3Pii5cnHrgOFWykO3al4RIYaBOOpzqdKHxpT1AN7
         ZhGtrkjWG72wsDCNsffnI/0XyF+6K7ZQAVDDoU34uYQaWNZrB5gmMRjs5qx9BCAYOc+7
         u7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740911702; x=1741516502;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Bk8MHrBJsR2XaptRNYWBSybSxAJ6sb5L8OlyRqwsRM=;
        b=E0RO8OFhoMq6kQ7icRvMf/WbDz5Lotkhs7MZnhOL3Qwqv7hHEVIRwfKC+Www8b2bgZ
         +ltkA94bNOUy3+r1fxS93KAZdSThNIs8uVA5pmezY7oJ4f6na0A4NN/rLFd6EXCd28W4
         ob0BB0tYyvjrV6TIYMVCMdPxiATFGK5e3RKDfDjNFQjJOvj7KjDVRqlvqcjwEwEaVlcc
         N9NU28aL6c05IvzmG0mIqGOILnWii5MbpgIobAagY11LFpXOKtj0h415pgvIwjowR0Jz
         16EkcH7NHpxbzmw8a4CgWrcw93ZW6GpOreX47Llc2XsiHfRzR/BSrRocedPVIpbqO6wj
         tEaA==
X-Gm-Message-State: AOJu0YyryMnzVF4LtSrq+T5l056ZaSFAA0Xmd+cLjTgWPT6Cyvoob8jV
	9YbY1JcfqHrdrjePZRutJIb2D3t/yDf2RoeZMZU6BNbrxEqTQ+25x/qCv/24d7Y=
X-Gm-Gg: ASbGncsXLZ62mBpQbOl7f23jy8bh91GAyZcE9fa4Mc2ip1nOuyV5/FBTwmsyCtpxcjT
	/qIFC30xZG7R8C0ivq0UyWWSKZ/4rq7Kcium+XTKrCe0YvWUdnjK39STC2yHOovf19BBGfHAiS/
	EbEFKHnayn1MOjBxkKoIsJ9VpHq+JMaLs0omVydJ8tvEfaOIPwJgd2jyz66pTEgC+mQcbJMZgeE
	KS4nzUfTBzY5pmZ1hd+jiK4lggk8te4Av/up4kL7QhRUfHd2R0FfEbbtaG7zz6xzwuyytU2ATZX
	Z2mpLidvD5oCGiA8bf7a65EJmJZPM0bhOB0M+/Bk0cMgEOhiftVKFmUScf5yyJ72TdiUxfkRKbe
	SXFW19IKg6tjqJkwOjBT7wqibtZsqUiD0Tg==
X-Google-Smtp-Source: AGHT+IFbRhr9va/azTR//7gX0dkSSBmfF6gvRHO2RFDR5x0vflexGJ1VHgD6XDdXvr8pBeChFe5kqQ==
X-Received: by 2002:a92:cd82:0:b0:3d3:fbae:397c with SMTP id e9e14a558f8ab-3d3fbae3a9dmr30370035ab.17.1740911701894;
        Sun, 02 Mar 2025 02:35:01 -0800 (PST)
Received: from SEZPR01MB5486.apcprd01.prod.exchangelabs.com ([2603:1046:101:ae::5])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f07ee58d2fsm847756173.82.2025.03.02.02.35.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 02:35:00 -0800 (PST)
From: li li <li0371859@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [GSoC][Patch] Does it have developer documentation?
Thread-Topic: [GSoC][Patch] Does it have developer documentation?
Thread-Index: AQHbi16IyDo96VDYbkekCR3sDmZkAA==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Sun, 2 Mar 2025 10:34:56 +0000
Message-ID:
	<SEZPR01MB5486585EF47B99A59C7E9F4DA3CE2@SEZPR01MB5486.apcprd01.prod.exchangelabs.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

CgpEb2VzIGdpdCBoYXZlIGRldmVsb3BlciBkb2N1bWVudGF0aW9uIGxpa2UgaGFpa3Ugb3MsIHdo
ZXJlIHlvdSBjYW4gcXVpY2tseSByZWFkIHRoZSBzb3VyY2UgY29kZSBhbmQga25vdyB3aGF0IHRo
aXMgcGFydCBvciB0aGlzIGZ1bmN0aW9uIGRvZXMuCgpJIGRpZG4ndCBmaW5kIGl0IGF0IGh0dHBz
Oi8vZ2l0LXNjbS5jb20vLgoKVGhpcyBpcyB0b28gcGFpbmZ1bA==
