Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F5418645
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073014; cv=none; b=PIIFUutJTgl95WBcebs50SRqQy52FUaqxHLinitVwQGNvZsC3iHNzjG9vSUcFtyvq/J8bIs5+OAX86ioQJeKoGPtj6sXMbNbORO0Kf5kGWiifwTCS1Y1rwmSrwhYQVnhlZbO5evSxPDjfQ5i4LRiB4jDW6XPAKramZ9Wm66LIXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073014; c=relaxed/simple;
	bh=NyukEHyAKip7BavLmoK1714O0IqcQUjbem2YNaRmRQM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YtLa93gVCGVaaB9Ob7N3zx2xjt573Csc/cHkPZsmpPUbal6imPvjZrSmIbmxItMaZlNnd//tUBLQJXfqHK0jvr8FYrCC9EEGK/1aY9Aue63NkK2XcxoSTVrlGC3w3izQMf/dXpzznScBNS9cZN3fFfu/lxtlOaxnakmBfBEUuoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iABNbzfk; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iABNbzfk"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d0cdbd67f0so24599661fa.3
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 00:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708073010; x=1708677810; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NyukEHyAKip7BavLmoK1714O0IqcQUjbem2YNaRmRQM=;
        b=iABNbzfkFKa0uLZNjAXAxH44GuH1jg+Sx6f+lz/rSQFiM72DtjH1bCnAyW4TTjb3yl
         dwwkkyFDvt+9YAi+FE8CGDhGWteP+K/yqfdt9OH2K0bGJ/BLPt/fdq2phO7RGhnMeuDI
         +LI5xPfGlgNZ4aoRmlSQ/dJGsuk2tpta7RAAVv58gthQJD6Ftu+ZRkFBSZ1/dltkC6x5
         fnJZ4+GPRMu4CP2EgWaSpZx8yNBRR+sqTinmF5/IoFvDLA3i03hEiP3zDnOHkAaypLjQ
         FDjGpQXCbNRyUqsHFyt8sNcNWmfemSGkdi63d8QL3js0Jx4q47xXecUhOtEs2XUC9N1f
         nZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708073010; x=1708677810;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NyukEHyAKip7BavLmoK1714O0IqcQUjbem2YNaRmRQM=;
        b=USXPXeiyeGBma52nwDPsBnEhk+GTQhmTn9KgTGMNVMxV65IK3b1tKWfoXlCCz141Fv
         6AEoysYjMpBMr6pgmftTJFSA7Lva3QNRCuvhErS0AKwqKf0Ms4rAanY8uzaSBp6qrbFt
         nRAOs4dzmtlaFF7Ek2zzfpOraOU+SDXXberzCVdOgk23FoyKPNudMJ7HrU2hHthTcYmT
         MsSBEeQ73OVRt1Hj/e+Jbp0W61OQ0PnflstlZFLowiFM2Vx4dHpGhNz2JCCSPzTVLll3
         kgA653Vf9wFo5LclTvVH1qEQY356V0plM0S/ggApwGIv1o+068k6WEu1DYPohYwysApX
         RR3Q==
X-Gm-Message-State: AOJu0YzH2VLCcbKLDjtvRj6EwPXofxv6rvHlpikbAUv8wxABo8McGhO5
	e5IA7EMVJdp0Cda5PHxmMPYT6hdj0fHaS2V+Ryt0Am8ky7edT++qrgPQ8H7+5FPCBpZLaJumwsF
	WkUYlpcOqhvIFn4zeEYJig1reXB5HdbPh/Kc=
X-Google-Smtp-Source: AGHT+IHzVibFRguUe47a3GfUtX5dxOW+B6WmYqqaTaOEG0jn2eQFMI9S4pLapU99UjWCAwUxMzDi5rXsbikSWdfchdU=
X-Received: by 2002:a2e:8ecb:0:b0:2d1:1462:f133 with SMTP id
 e11-20020a2e8ecb000000b002d11462f133mr3335778ljl.4.1708073009984; Fri, 16 Feb
 2024 00:43:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xuancong Wang <xuancong84@gmail.com>
Date: Fri, 16 Feb 2024 16:43:18 +0800
Message-ID: <CA+prNOo56SkNohZ6qgh1TLsDxGr-OTbeP0FhzrJK80Hr4SzKyA@mail.gmail.com>
Subject: Enhancement: `git pull` fails with merge conflict even if the local
 copy is modified in the same manner
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Git developers,

I would like to report a bug or defect in git.

I am in charge of running a real-life study. Very often, I copy the
source files to the working folder and test running the pipeline to
make sure that it does not crash. At the same time, I push my code to
my branch and create a merge request. After my branch gets merged to
the master branch (which takes some time), I run `git pull -f` in the
working folder (which always contains the latest version of my code
manually copied in). This pull operation will fail with conflict
because the source file gets modified both locally and in the updated
repository, even though the final file content is the same.

So my suggestion is that would you make Git a bit smarter so that if
the same file gets modified in the same way both locally and remotely,
would you allow the pull operation to pass? Thanks!

Best regards,
Xuancong
