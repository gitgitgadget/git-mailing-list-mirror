Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7214E258CDF
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630189; cv=none; b=PbPFcUcpEduhWzSN++Pg1UYAwkteAV2/YI+x3til5wyMgmYRDUMBKJQ+2s3x5wphw5KaGdc73BiCR7nouqc7XEanVLfl5ih5h2oAKIKOFNPdezvcAFu4g/zRjIUKBphuz7YS6IqlGGcihV9BFFIly7AIzF6HGiGxQFBK/tf00F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630189; c=relaxed/simple;
	bh=e8XETyCc67vrWgEGsUgAHhhv3etl9HbjpsffLP1Ocj4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Lbo1zfZYi/Fn3ZQq820COUh/dpPbWkVqGp8B8S6EG7jYIA2aYJWDFuNf9CZI1dHNeht5z4OqRAfAaSGwnZSeS4Hry+wyGJcL7HuQI2gUvRv258zQpHb7FkQPx05saFsvMYlQ2h8sUlxQ/4RlNFx1/ixeKfmoN1DjbMMYUN2MiC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzwZECNx; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzwZECNx"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7927b1620ddso59315507b3.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 01:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770630188; x=1771234988; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e8XETyCc67vrWgEGsUgAHhhv3etl9HbjpsffLP1Ocj4=;
        b=NzwZECNxw4/pP91u5wT3gw53atMvA/kpozbqHnv+Zbdk/OHNNQ2ygh43zclKhgk1R6
         rlgpsG/WSsddcMGWidaWo6FGFBz3TsHChJz2QsgNAywy6Rbs+hDoXctBbz+BV6WQkPLJ
         GWPqyQCuqGr3Tu3lWehwEmPh/FtRPesw+/0IH04BPMd7aJJarRKSa/p09R4C0UO08vtN
         ZIEWYGQIllmz33FUioOlpz/CVJi1rVq9H1jpEOe3pxRMZ6ty0EGTLATnmIn+orM0b6pu
         AYjRXtcocH64DMApEmyYBkOc9s9MxuC9tK2F2vTI+6Alu+80CEMNpIvtgmeKCxEiDiyf
         u2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770630188; x=1771234988;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8XETyCc67vrWgEGsUgAHhhv3etl9HbjpsffLP1Ocj4=;
        b=D5yMay3TrF3B2yktu0VeVDPqYr2HjWV4EthQfTNhVVjAVkLmT+IEhmAmxA0YniFrNP
         hEkvN07rsYmqlqsm04QpL76fnE1ctRr+w0+htn2lkYpX/q5N1Tzwv+G4KOihBWwtd46S
         hsYTfJZnMvoaSZ+lyKRKmScH+f6zXBQVSq0laebKLP4moQZX5In6FSG3qeq8ZDGoj5/c
         GR7Qm/9eyibUtjqydST653p+6Qwh0YCvM0pSqWHDFPekPohqZ2g8JGJwNt/ctHpJhEhD
         sD6pla1w1bcxjH57ETB6NiTQo6oB6nckv1b4wKSg/zYNBIFQGpCiqGuoZMj7h18UeBM9
         Nnpw==
X-Gm-Message-State: AOJu0Yx0FLUVD7tR8+3IzSwhxRl8fJ2Y+gPA6eROeNoi3WyAq/dVxQBI
	V3Xxw3lvvjLB3kdH3K1xtuwtJVTLebp/GEs7MoL42y0kUaXm6EInQW6C60jPF14d
X-Gm-Gg: AZuq6aLEyZMOaV9HaxSTmARhbI8MIzda3jGGt84nFn+nLZwmGhTplMyIcwVuFAv6Vog
	UDF7L+Yre14oj0HNQLyrJA1zU/ICgjl+ihsfxv26rBpRn425I0ho0FqYucL/WgoAqa2jRyyli0L
	6K4Or19sOXIQgxAm9Z15GB7wS2p4viteFI7JnubrRD2Pa9Tq7rwZzgaG3hsgmBd0U3yo++guja4
	SpkNYL2+VNLInpGHAe8Y2jR3skHMmCFOkx3XpORhlGmBhWcF4cE824Xusk1BpDRLg/4K2nRqzRS
	aj6LniSR4ooU7n8ysexrWHDnQf77D1v6s3GcZyvhtR4dYbFVzhsjvXANKDJEEH3JYd6GSSjPdM9
	W26XNZZJkhkSzZXLd/7o2BweuJpcFs+0vLqvEXuAhLTLb+SRFtlCnLazzAtJIsLi7/edwc3XPlV
	+S5JzkPtVxdPaI6xhqgb6lar9R+7sew0Fm25BzfgkYrgiNiRaCv9kVkFLS/ZgPvhpjuDtHIEcP/
	gHNlguG
X-Received: by 2002:a05:690c:660c:b0:796:357a:9acd with SMTP id 00721157ae682-796357ab026mr54942887b3.12.1770630188119;
        Mon, 09 Feb 2026 01:43:08 -0800 (PST)
Received: from DS0PR03MB7290.namprd03.prod.outlook.com ([2603:1036:5:36::5])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a1dced4sm86672037b3.31.2026.02.09.01.43.07
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 01:43:07 -0800 (PST)
From: Ryan Johnson <ryan.johnson.code@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git branch behavior after git init needs fixing
Thread-Topic: git branch behavior after git init needs fixing
Thread-Index: AQHcmah5FRw8CFJMyka/q6Hy7NhAyw==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Mon, 9 Feb 2026 09:43:07 +0000
Message-ID:
	<DS0PR03MB72900848B03D2B87A6846DCAA365A@DS0PR03MB7290.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Immediately after running `git init`,=A0Git's `git branch` output=A0is empt=
y.=0A=
=0A=
This is problematic because this implies that there is no default branch. I=
 am told that there is a subtle distinction between an already-created bran=
ch and a "promise" to create a branch upon git init. The "promise" of a bra=
nch is not exposed, when it should be in the `git branch`command.=0A=
=0A=
Hiding the default branch name from git branch is inconsistent with the inf=
ormation reported by other commands like `git status` and clashes with the =
availability of branch operations. `git status` reports that the repository=
 is "On branch master". A typical user will need to rename their branch fro=
m master to main to conform with modern standards, so having no branch show=
n is confusing and quite frankly wrong. In the interest of fixing stupid UX=
 design, make `git branch`produce the expected output, regardless of the li=
teral internal workings of git.=0A=
