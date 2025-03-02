Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6352AE96
	for <git@vger.kernel.org>; Sun,  2 Mar 2025 03:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740887112; cv=none; b=P1+FfNCtPoVBmJTEZgxBvk+bjvYpvGkG3HOZMt0FY0GrU31mUpfRS9xAznCCz9pqAg3iHjBX0OJajpzwY/F17fdbhS+oMfGjwiPja5WgNlzwErwVcoj2YZ8nu+oudQd9FFs4lxDmzMiRY52vO/qL81fYFBZ25v/PxMpnojT55M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740887112; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YH+q4KRald5jbxcLhcM7hz3irlOylS2CM6gO54xBqUj5Dzaul8DhHcp1DIqlEUA8biSP5D2eD9KjLllqG9tAYpSQBSlyrzT2XL5T1YIcfwqCKf2LVNc0xfbLUbWD/XnBWxKNi2kxpgpfRhIdOeS2P2fH4SdubSRcBS7A02G57mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5z+GfVb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5z+GfVb"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2239c066347so5976915ad.2
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 19:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740887110; x=1741491910; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=L5z+GfVbI+/BZL7G8jsL/9wk3jJbuVZbTNFYjGbtwU6rm2NLtgVJ0pWoecL5TNWgpe
         ql510YtFF8oA+KFfF1teylB8FsUYRA2LUovbC6Gn9ACk4aeWESM0ATSYKA/rnpp0ck7T
         R8V3N3mmNnxLX/7DY+kqTmXeFN3RPUPjGKnBYacmCmZz/JtPkElBrvtwn8lMxXNlrTr5
         flqkdZQbQxnUbg3lVrY3u06NavaAgw9q0cPEglBUq2V+h+Jj09V+XAG766O8GC+/H6YO
         XS1DbmmBEbFLtrz4I4zA/CYxwbi7y7KacfDyZfDmh+xGquMf6hgbWZumPXuCPb/Jw8Y+
         XxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740887110; x=1741491910;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Kl+8hFrajvcICtUQZN9maTnhxyxS4dJIXU4WyYPxXDM7BsHzApDpcTcueidxAXZuJZ
         mXNHq2zh0TWGCQhjfHzloVmjp/j/bunOcuLK1hQO7zjYINKVFGWkMCGKFQmh14JPlMuJ
         vfpjPXMsZgIkWem4KU2uXD7xpkpDa+/ww+zz2BntcU0o8jVuo0IQRqSyHdSo6SBjx97u
         o1FhfZmQobN8fhLsTn0Vyib0w7sgkEca8pECLOVJw9AVyO7Zoso6jFakMP4/Lu9IL7CO
         h2yJvYzsqZUhaaYcj7eNXc0I+vbfZ0AqHxW6AJOhEo0nHaGs/+xol+P2F3pE8uiu0aok
         VofQ==
X-Gm-Message-State: AOJu0YxMvS2djgPIoVg1eB3C71Oah2NhzIvyUVTafe4xXT6SZ2HU/JJC
	b2V3RHBlZ7sGeJp0t60WHFg4ldjG/RttM+RMbk/qe7PW2y6CJwOfTYZe1PXP
X-Gm-Gg: ASbGncsKCvF55KuoNnvld3ewT9uBSiOttgqmwBIC+5MIX38LJTPUpcWAsMFCvYqcGDm
	TmMXtJrCQxOufGS9d7pDr711GV6z6qSCvj7MYuQtKMGWtYQk6dRhoWKcFc+C+5eIYyCpECmd3CE
	3e6gwR6j0qeSd2WKehzIeJ7qbBq0JwdG+R0u1YnafRgLoufUmdUQY5IBe7cGlUqrYpi/KwYIsu/
	XKmY9LCxkXGZOPnn6C90xJ3hn+WliqiPrBEw3Cl6ezRmTyIdQahMQLryxG3guGwjk4A9kVbAFT7
	S7XFg4Yhen0x9PDQlo49G/dVd8FAFA4smzizEmVlZkbZ/vkBhTwcJO3QAOEcOJSdTe57efBB4sJ
	LaucdQOaQex+csjUOQQPWlhkcDLdBT0opeA==
X-Google-Smtp-Source: AGHT+IGjG5oZ0FTLhcZLQbnNL25cjcNplAz1SmdUE7Y1e6ZLVF5FSad1dudYje320a5KRJkKYCw0CQ==
X-Received: by 2002:a17:902:ec90:b0:223:628c:199 with SMTP id d9443c01a7336-2236926725amr115240135ad.52.1740887110583;
        Sat, 01 Mar 2025 19:45:10 -0800 (PST)
Received: from SEZPR01MB5486.apcprd01.prod.exchangelabs.com ([2603:1046:101:ae::5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c7efcsm55214015ad.154.2025.03.01.19.45.09
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 19:45:10 -0800 (PST)
From: li li <li0371859@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: 1
Thread-Topic: 1
Thread-Index: AQHbiyVu3EgFO7xF1k6waroEMavxvQ==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Sun, 2 Mar 2025 03:45:07 +0000
Message-ID:
	<SEZPR01MB54869F5802EED0CA71D8ED1FA3CE2@SEZPR01MB5486.apcprd01.prod.exchangelabs.com>
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

