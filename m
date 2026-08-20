Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113DD37FF42
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787238816; cv=none; b=WWFrIS8a1UmqQDxlf1IAodeqefpvcGLkmWpjcp32gJhDOYfLGrKpM2WI0x53YxnIPtreoHwmptiNrgvHqSHF3cvu5/dprrriUQwiSUhmy1TosHQj7NJQ0EraMdw1d3hNECDm6QNQ+gyoNTj1+dO77z777G9s3ByTDb/1An/j5ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787238816; c=relaxed/simple;
	bh=S3MWBBpo00Uslbi0mIw+yN3WLUymLAm8Nsc/5X/xXfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJtqKtKuIQWK0rfgawhmER0SiwW2Qv4B/3w8CD+QhXkcodEmSp+EMYdZ8oG/13xlc6A09BuNJegoylSPnjyXwJACgd3cDgkybrprAuclblLWEL9XtXBWUVaxUOalctbhNYzdAhB+P1pDr+ByADihjkEP5MB1zSWW96V2aYcaEKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCMjS5Qh; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCMjS5Qh"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66c7e3a2332so1904482d50.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 08:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787238814; x=1787843614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S3MWBBpo00Uslbi0mIw+yN3WLUymLAm8Nsc/5X/xXfY=;
        b=fCMjS5Qhc2wAalotjBLbAknsmEx11kFxJt5RUHy35CqZ4rImABytU+LcEht3sUIbmF
         2fVT6NcxUa9Sk/8EyjOXbwu2iKV3veXvaiAls4nPtXtwrTCMl0egRS/+GxhDuddUmPHq
         2DnHXDcZgYMuMlQZzrrUStZujsQx2wYFkohpoFhFIzUOoeX/6vUWqIJU+wb9r5q5QYY3
         qXq1ybhsbMhQCMAfg53rDAyqeY2tDJ3u8Cc3duusELfEX1ruIpj5Fw2F/KlgyS4peeAx
         3uSmDzD2GqMvdH/h87++6HG46r70XVGZ9NHbrSttCjx7oC0NwUAH7RYO3/f3w5pGBch0
         7zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787238814; x=1787843614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S3MWBBpo00Uslbi0mIw+yN3WLUymLAm8Nsc/5X/xXfY=;
        b=IGujKoHPY/Of1OvUqf9NT61/+F9BNSctL2cY//2YLZRChMwqMieBC+IzdvJAxHQmpL
         cuZuyS5TTsPmx3RBlvz4Cf//FxzIa/ZtzoUtZkv183UGdGFBTjnTXk4X4IJos5ornZRW
         ke1fXmWpXFwgdGjZ4Hg2TXri+y3i/hfbPnZXEl3VTjwkU7f3WL+4Bi+UQ6OSlHvmtaCi
         CRmdcu+Omo9HKxC+4qlnqyyUM48Bd04ujrFJfZPxU9ZFnDe2l3o+F8Bbx3+9NxcGHzgb
         lkd2Gv1yD1UQ8XwyedARzUlNj935+UT4A6kc9onvZKZzoSU1pafC9xC3O6TG85WtGIId
         rpAQ==
X-Gm-Message-State: AFuF++mD4YzwZiBbvXxHDx/kKsXxlW7o2uVk1EVr8f6zyeKcSSQYydDr
	6I+a4pTvI0ME47OkGP+VdrfcQtlEthU/qm9eH5jc9WTJxAFOLM267L5IzJArfw==
X-Gm-Gg: AR+sD11D4GShRR/xcyPMqcIzSQqDDIYqQShRrn3Cfi8HuSTopSLTb6dZut+XY3JI4YH
	KU/pzkZ/LZg6M0+bpM1MjSzjjGF4P7S3ckdID6XmJdoF7lSw4GN5Yht22yG1U0MNiIZTvC/66F3
	gz1bmzEWHu7DJ47gaqggXG6lgrtw74GE60lPwevTyVj7QoUuG8ukgZfHYWDoM4uGP/0eQ3P+NtN
	LHjYtT15Q2IJU9SFJ4gcVZpi56u3D7/sFUjaeESB1c/BSMY6awPW4DXH/Pq3CujnAsUvjjxKW1j
	axCQW8XQiLbuMeo+ydYoVcrDYMY/X+RekKlTPCEz9O9mmxMHxmFVbC3o5VQiQAM8i9Eq/1trUiK
	OUsU3lbGz86Q14+0bebyY1UY73fllUiUPEl4hrdJsHU8FFTOPiG5JNcbCRQAoAcA7FgFQti79hD
	0B21eDInNFFar3K0kzLynVbmOegsYbK7fI2CBbt7LU0c+VdULQFhUW0zZ6yRp7EtXfWb3fZqwyC
	3fyZPowseBOhNVb3X5ldGOPZR69dRi8JE2LehuNfRZBXqxkf+CFxYRWRZp2pI3fQDN0K4Jwgv6E
	p0j0DIQFGMr4SQVEsVCP+UWSCqLgSYl1lQP7iVg=
X-Received: by 2002:a05:690e:1a59:b0:66c:71a4:6ef7 with SMTP id 956f58d0204a3-66ccb662938mr3405047d50.35.1787238813847;
        Thu, 20 Aug 2026 08:13:33 -0700 (PDT)
Received: from localhost.localdomain (99-71-100-228.lightspeed.milwwi.sbcglobal.net. [99.71.100.228])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66ccaffe261sm2751499d50.6.2026.08.20.08.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:13:32 -0700 (PDT)
From: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1401: test symbolic-ref exit codes on a non-symbolic ref
Date: Thu, 20 Aug 2026 10:13:19 -0500
Message-ID: <20260820151325.58087-1-nikolauspschuetz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aoWSqYvANg5AmuCi@pks.im>
References: <aoWSqYvANg5AmuCi@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Out of curiosity, what made you address these gaps in particular? Is
> there any motivation, or are you just picking random things to work on?

Not random -- I've been going through git commands, checking whether the
behavior their man pages promise is actually exercised from t/, and
filling the gaps. The idea is to pin the documented contract in a test so
a later refactor can't quietly change it. git-symbolic-ref(1) spells out
both the exit status and the --quiet silence, but neither was tested, so
they stood out.

> This is testing the status quo, but what I think would be good to
> research in this context is why the error codes are different in the
> first place.

Agreed it's surprising, though it's not unique to symbolic-ref: git
rev-parse --verify --quiet does the same thing (exit 1 and silent, vs a
fatal 128 without --quiet). It falls out of how the two paths report in
check_symref() (builtin/symbolic-ref.c): the non-quiet path calls die(),
which always exits 128, while --quiet can't die() -- that would print --
so it returns 1.

> Do we also want to verify that stdout is empty in both cases?

Great idea. I've revised the added tests to redirect stdout and check
for empty stdout in both cases.

Thanks,
Nikolaus
