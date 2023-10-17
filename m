Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484B32D7B9
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 20:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhI0QWtT"
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DAB92
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 13:59:42 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-581ed744114so237589eaf.0
        for <git@vger.kernel.org>; Tue, 17 Oct 2023 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697576382; x=1698181182; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GdLfwAdH3kMzXK017jS4tt9bftY2qXrKLHVRaXaRLgc=;
        b=EhI0QWtT2Be4myMkZkmxPw+uCryhqCsozTPt/YkqMsH8/7huGRZ6J5unPyEHoCYp0C
         CLxMg410y65DDzPUsI4J4KGZ3976kXLom8ELWxzcg2mhyDc/sMkqej70zTvZUAuJE7sS
         3v8Uy17Smg4lt0EIDBatSxd64juTonlT100tjYz8viUbgVthMEqhpHqF0DN+X+8hJpzl
         /NO7Ka82W9XvMsMuCL+IFQTAlTLpLbG+QOFNLgY8cPTgpvyRDnJciDdlvmVLWcK+2YKc
         ajnX3YItnje2FIspe+00CGN7lgwA2xbHRiQw+W7fpuE5DcfelALtN+MRUbuNhym+acXg
         WufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697576382; x=1698181182;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GdLfwAdH3kMzXK017jS4tt9bftY2qXrKLHVRaXaRLgc=;
        b=obmnbOS9Coq/hq8Ak5METbP62ABij7Wzu3sRIaELJ2bLOCX9POiy9pa64HEHQX2b6P
         YvkvOUJUNH+f8HS7n64UPIXyoJSrPVtcDCD/4tI7I+QCxfNmCxlvmj0M1J2pIWmPDNDG
         B7pCm47rQvqlhRRxnHXTDPW/xRrdaAlWBiC0IIBiwjRZRlkPZ7ix4qkaVg4hLHTGiZHa
         QVdNacCjfFOLhHMYDmuHIFUfurf2et+9QHEk9RCd0dD5J4/3Wg48a/IVXPAQrxfNO8Bi
         Xf/IhSSX8C907QBWZNpuZ48UuRGT+wCltJ0bALUHXkUZOj2chtqZvpj26fBR7gfwAesU
         IT0g==
X-Gm-Message-State: AOJu0YzzhVavdyVA0t+gHaC/7L4U0zjlbt1OsIuFwAbHYk/sKF3w6ptY
	ZbGvdtVcqPmkFZphT6mdLr4G/Mjz09Jnbzd/V9uN3NGpJw11rMlv3tR+fkyI
X-Google-Smtp-Source: AGHT+IE1QYt4njnVJs0mJ5NK27X0Mcn5iyXH3bVFu5nIeBttSPLrus2+v3OsmiNg5Xe1FDK40opvObd0dpYASqMg3R4=
X-Received: by 2002:a05:6870:d107:b0:1e9:d830:160b with SMTP id
 e7-20020a056870d10700b001e9d830160bmr3718039oac.10.1697576381670; Tue, 17 Oct
 2023 13:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Joanna Wang <jojwang@google.com>
Date: Tue, 17 Oct 2023 16:59:30 -0400
Message-ID: <CAMmZTi-xOWxpzL1SvErgri0_gwvED5Vu2NfeGVcW7jCN8gyEDQ@mail.gmail.com>
Subject: Re: Supporting `git add -a <exclude submodules>`
To: gitster@pobox.com
Cc: git@vger.kernel.org, Joanna Wang <jojwang@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> choose among attr:submodule, attr:type=<what>, attr:bits=<permbits>, decide what keyword to use
Whatever we choose, do we want to block these keywords from being used
by folks in their .gitattributes files?
That would break any existing usage of the keywords. Is this a concern?

Option A: To keep things working, we could add this support for attr,
but then always prioritize whatever is set in .gitattributes. So this
new behavior would only be triggered if the keywords (e.g.
"submodule", "type", "bits") aren't set in .gitattributes (or w/e list
of attributes are being read).

Option B: Or we could add this new behavior for `attr-bits:<permbits>`
or just `bits:<permbits>`.

I personally don't see big UX differences between A and B. Any opinions on this?
