Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310E728691
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735301965; cv=none; b=t3Q2WFW254SP682xM5DMZc1dh+r0Wmzw++17hPNZbOv75G/FqVAUHZBfswVWEyHalE7KCEaFm9Cdk6Mug540cbGevu22Zk3HDliC1f5kvQ3fztnElQe8rJConU+SE7eUhEdFZm/CWFN2S9/DkQpxoFj24n9dtOAjSfz7EPEFvVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735301965; c=relaxed/simple;
	bh=8Aglu651e0HAX289ABGPcjB/0SsA3a0aBVeN4oD0OLo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Dsxy09oR3FZ4RPRn8ztTMWGFACYw160HCD8juTdNEuxBH+MfftaaeHYe9hMetZ/yKQ1APVLlYZ88a+abGixMB5yP504nYUGDgUnNyad/nQv5StMSELx2lvdn5PC1zflNRra2Ss0WqcgzwDpHM3JYMvgdKW5eCNtxGo7K6hCqOec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aP/86584; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aP/86584"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216281bc30fso101313535ad.0
        for <git@vger.kernel.org>; Fri, 27 Dec 2024 04:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735301963; x=1735906763; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Aglu651e0HAX289ABGPcjB/0SsA3a0aBVeN4oD0OLo=;
        b=aP/86584qIK2FEU7PWy+Caij3fGUNJwZ+VpEIDq7fEboga/PY9LNFlQEhguS35FNeM
         YDh8m+78WApXsWPaRuDnkFomXAurouIVJ5Gtv4q6sD4tmOZ6eM+QDOqAVM6oA1PQhrpf
         9arpd6lULOaooCD5aY1xJY0G6ElfF+XIQZmA0YNwNmnOUfzn0UAugZnnu9iQMONCeRaB
         Dn7TX0+1BCAt0xdyxwBQyxm2aaEpSncUY0udaABy5rgyjQEbnqMTsA+hOj2Tpfe3B1xt
         8ZwGyg/TTwIJsnFxYYRhA/Ply3RkG4hiMayHR8fIyfSMos+SN1NyOtxewe0DMP37EQV4
         +jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735301963; x=1735906763;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Aglu651e0HAX289ABGPcjB/0SsA3a0aBVeN4oD0OLo=;
        b=JAizg2mUXcZ9LmdoYXtn1siZeCpgqbspqKF8AGYVjv+u4lj4VIeJRX95YhN+Fa6G1k
         FhX7/KdvUBrUrrzaRbf2yOYEK3FKQh5xYZuh0n+X2kRJVmwygFdAi94AO5eBJWWNXSqC
         xVlyXQuuSMIR86Gvwg6SWAffmy8BPUNvrBOpXPuvRQDXuWnNbMdwNtngRa/lfagT3Re4
         PjLCq8wmVjzLqrr4d5rYkAkbZTv801ysITokCNeLdGBP8tLgQY+BaAECMH0kP18yGpOw
         pHk1+xfFc7Dap/3It1BpQtxpc2SGxzzePTCLFS1sBpw/WRHzxybKjuIRPccXYyD/EuwP
         XGfw==
X-Forwarded-Encrypted: i=1; AJvYcCVcyIo9HLChtECTUs+A7X3sz89x1QB4ohbXONff9FmF3Eqz9wBR0AmE6pbtPF1CxQfgqCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwohumZQCvbRlh4MDjqxPHBYuP2tEoPyzwt0Ha6KvR7y2wSO9vc
	t2JszAZIs6JveHuIa9Ig8vV8RZIXJfVMnr3Zm6XGuwmto/CbPyZa
X-Gm-Gg: ASbGncsCtssszh2mZIMsOdz5ThNzTDlYaPycD/68fumoyLITb/7pfhBmnSuH5uDa9m2
	wOUoXy0azlU8xszcmKFN6poU0s13dIa3ge64kXyploCvGcwjUInuhjMXHfKXOS4Zm4cEeVFK9PE
	ddZbx8KLFW1zljWbUb+6kCo+4AkilAKioR1xjyehsnlzuO020smi7X0y+dyOAkRepHMd6Eq4FgF
	b2XPdTojVUaAlM1/6lJkvKz0RTsSssTjTQ1d/7Xhc1QD9pvXcurdNFxVD607oI2NytHIk4=
X-Google-Smtp-Source: AGHT+IEwMyyaMgWxtTfEyeC2obY6RaNA7hQf23LeKsmchwxx7HeQIls9qzbYQeQcZHnjywSt5FP3Nw==
X-Received: by 2002:a17:903:320a:b0:216:4cc0:aa4e with SMTP id d9443c01a7336-219e6f37f88mr395596565ad.47.1735301963254;
        Fri, 27 Dec 2024 04:19:23 -0800 (PST)
Received: from localhost ([103.31.220.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96e76fsm134583385ad.65.2024.12.27.04.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2024 04:19:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Dec 2024 17:49:17 +0530
Message-Id: <D6MH7E17E6I0.3IG5103E7XXP3@gmail.com>
Cc: <christian.couder@gmail.com>, <karthik.188@gmail.com>,
 <kaartic.sivaraam@gmail.com>, <ps@pks.im>, <shejialuo@gmail.com>,
 <chandrapratap3519@gmail.com>, <gitster@pobox.com>
Subject: Re: [PATCH v3] t7611: replace test -f with test_path_is* helpers
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Meet Soni" <meetsoni3017@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20241220130632.11826-1-meetsoni3017@gmail.com>
 <20241227105345.10184-1-meetsoni3017@gmail.com>
In-Reply-To: <20241227105345.10184-1-meetsoni3017@gmail.com>

On Fri Dec 27, 2024 at 4:23 PM IST, Meet Soni wrote:
> Replace `test -f` and `test ! -f` with `test_path_is_file` and
> `test_path_is_missing` for better debuggability.
>
> While `test -f` ensures that the file exists and is a regular file,
> `test_path_is_file` provides clearer error messages on failure. On the
> other hand, `test ! -f`, used to check either the absence of a regular
> file or the presence of any other filesystem object, but looking at
> them in the test individually, all of them should've said `test ! e`,
> i.e. "there shouldn't be anything at given path on filesystem."
> Replaced these cases with `test_path_is_missing` for better
> debuggability.

'Replaced' -> 'Replace'. Cf. https://git-scm.com/docs/SubmittingPatches#imp=
erative-mood

Other than that, this LGTM.

Thanks.
