Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78AC13D502
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 22:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738450656; cv=none; b=UgOLgX2Uh5WKeUAIaeO/+4vvgn7G22Q+tfil54f+5+9IPVF7DFnM5oermuwnXA9ZmYpxqLf1/0cgJasNUFevZneM4JBzlMnmwuw0hF0woh58OBUm+l6o4SfkK6xgaw5zktff4HnlMsJ1PXPylfUmYszypR6LHr3ebl8ne4RIwxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738450656; c=relaxed/simple;
	bh=dbfSRfiL2vrCnguSR7oChsmh8/psDdAh8IO8oUttXc4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Q6ogvULlshn1JbG9T+UgjjvFnvlPgCZ5AnaP/hHzJdR2IgmSrVd0/wv7QyypPurWbOIBcBrcFT7Mg/7aFTuj9+f+bMrM0SeBu5VK/DFvHewSktBAzV9dTXwCLR9i6acuFo0G3/buw3vLX0mV0wRrddGx+GYwRHLyU7jKthvV+Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cj0j2WRi; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cj0j2WRi"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab6d4810332so45792066b.1
        for <git@vger.kernel.org>; Sat, 01 Feb 2025 14:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738450652; x=1739055452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mXkJoqxgwD5+635spElidHyfrp0EQiEvrtnFfWbj5+M=;
        b=cj0j2WRiNPLS/Tef0s0lt5v4mr8NxRzFr8k+CA5/SUrdYK/qkgdxEW7G6LtEOjPP+I
         lbsn1CUFvsQkVhBXvbVQN86siXxEaIlKuf8Beux7uoD9QD0TTDtITlQ92eIsdCwhD+CB
         bKuKNauofXPLKc54J3ycsdcDwyZRoqJApEH4oLGREh6VbUOLdJ6zTAiWbR0ke6u6DDhw
         OP6VzGv+8vOowuKQBgjimEIPQFoBercAHJSbKdSvb62PKE+IkilJgtUv8nA4Co+Rasv+
         gOi8nBpyUlVkfHjYGz/DEyhKvoEgmsCRmQo4t1AO+AS2SNEK87KazjKaNu2FrJrGgkx9
         SgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738450652; x=1739055452;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mXkJoqxgwD5+635spElidHyfrp0EQiEvrtnFfWbj5+M=;
        b=ukOVfGDSWz/Dvt2RiCCBRTLhcIBjL9Qf6lmwRTo6qnoiK08Xo8oDlVewVrb/gMFvfn
         +DOURWcHJtXlt/umdL0rNCdvlP8sKtEQZ/zhqHakngc/zrVAvbKA4Z3XbWc3/3Y4BQc4
         aLR1hdY5hao35ZsdkzLkdwXgqgwMaiFw4K5EAAmDTckl5A4Su6mi2xdHKYDfFKoPn4+B
         Dl+5WHQNv3xh1KiWuW9oDdBv0RHW+u97s+0vBxLqP/AgklFzisJQESBiqcCr2LoD7q96
         U8CH+YZM8rTAfUqaHTj9R1/MQ/OhFjvliuSMicfZtSKfi6y/pa0B2vUPkB/301o3esvY
         QE8w==
X-Gm-Message-State: AOJu0YwSz03J3UNrnBUzgee4twS2GxWGjD7utXqGDBy5Ft3NSdhmTbuO
	GMDNp6bTt6dtynNn66x9JX37gFlbrfq2MxnOuijRiWt9DtxqrFRs6Vj6nYRhoWD2nZKRvlDPipR
	ZLTOVii/ixuHZx3dma6hbyK6ccSK0K8cuBrw=
X-Gm-Gg: ASbGncuHARDT2vZHPqeYuIB64QluxVVbRF9SrUPxN9cq5AClnfuz02waVm7sgv9qOmE
	0CHzwVxXLnZbyZ+gBMFpsOlOlGMzUB9F8BwJX3b6Hz9QthfME4k2B7s2hN0M6LzSYRw2Aqdc/6d
	SYjgyIvntJgIBxNX0P8cgTKPe4U/6Ib5I=
X-Google-Smtp-Source: AGHT+IHZproRL+vuHAuGNF1JLHxc3Pk2oYDgvfSL4psKqbmbyBTeexsSKywvy9kDWuXNgiJXHLj4tM4WJvIzEuUrgSA=
X-Received: by 2002:a17:907:8693:b0:ab6:dd24:3342 with SMTP id
 a640c23a62f3a-ab6dd243b72mr648967966b.8.1738450651613; Sat, 01 Feb 2025
 14:57:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: M Hickford <mirth.hickford@gmail.com>
Date: Sat, 1 Feb 2025 22:56:53 +0000
X-Gm-Features: AWEUYZkpcGFt_CPtfRAN244W_Ps3tfi5h0DSzNSuTTk5PlC6Gvmf6b3sHIQZM4w
Message-ID: <CAGJzqsmmq1R9_q=p_AsuFMFr3UzyQ4H186CpfWTnCoAnHu_OXA@mail.gmail.com>
Subject: "meson test" very slow on Windows
To: Git Mailing List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, soekkle@freenet.de
Content-Type: text/plain; charset="UTF-8"

Hi. Has anyone else found that "meson test" is very slow on Windows? I
built Git using "meson compile" with compiler MSVC and backend ninja.

Curiously the first few tests were fast. Test 20 (exact number varies)
and later were slow:

   1/1029 unit-tests                                               OK
            2.11s
   2/1029 t-example-decorate                                       OK
            1.45s
   3/1029 t-hash                                                   OK
            1.32s
   4/1029 t-hashmap                                                OK
            1.24s
   5/1029 t-mem-pool                                               OK
            1.16s
   6/1029 t-oid-array                                              OK
            1.10s
   7/1029 t-oidmap                                                 OK
            1.05s
   8/1029 t-oidtree                                                OK
            0.98s
   9/1029 t-prio-queue                                             OK
            0.94s
  10/1029 t-reftable-basics                                        OK
            0.89s
  11/1029 t-reftable-block                                         OK
            0.83s
  12/1029 t-reftable-merged                                        OK
            0.77s
  13/1029 t-reftable-pq                                            OK
            0.72s
  14/1029 t-reftable-reader                                        OK
            0.64s
  15/1029 t-reftable-readwrite                                     OK
            0.54s
  16/1029 t-reftable-record                                        OK
            0.45s
  17/1029 t-reftable-tree                                          OK
            0.29s
  18/1029 t-strbuf                                                 OK
            0.20s
  19/1029 t-strcmp-offset                                          OK
            0.51s
  20/1029 t-trailer                                                OK
            5.40s
  21/1029 t-urlmatch-normalization                                 OK
            5.32s
  22/1029 t-reftable-stack                                         OK
           17.67s
  23/1029 t0013-sha1dc                                             OK
           42.50s
  24/1029 t0004-unwritable                                         OK
           46.87s
  25/1029 t0022-crlf-rename                                        OK
           43.77s
  26/1029 t0014-alias                                              OK
           49.05s
  27/1029 t0023-crlf-am                                            OK
           32.28s
  28/1029 t0005-signals                                            OK
           49.83s
  29/1029 t0018-advice                                             OK
           58.71s
  30/1029 t0010-racy-git                                           OK
           64.75s

On Linux, all tests were fast as expected.

I built at commit 58b5801aa9 (The sixth batch, 2025-01-31)

Any ideas?
