Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49DA2F49F0
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767111187; cv=none; b=AySSrKR4eM9AwwvCghOuo29HhhJySYablKqN6fR87xgj0OdwwDawPNAhJucRtavvyXdU18Ep3rDZ0Yn8CeZ19nIa0sKrgvwvFfXujtGMt9Mg/zRuDAG7xAlxY4MqtU8CVst20h2UqMY/dCjwXGohlXUNYDJDni7bx7US0evK228=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767111187; c=relaxed/simple;
	bh=99Fyr6/HYU+Zp2cw0no87TzAjnk8xncMpIZvmTL+LWU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ty7L0pYvAO6slmPANdQWL2gHep9D9ewgAEsbe8X1IW2psPxN6PJso06jU6YywvJ3FWUgW7JaA7wRzQOAmPn4jn2wfCvKDNrPoHBTMe1r/oTae3GacrVsY9ntr5LjqfirNtEWzM9p0fNFww19mGxN0QyNhHRbp3l97OJ/Yx1NiMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZLNPEtB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZLNPEtB"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a097cc08d5so25081735ad.0
        for <git@vger.kernel.org>; Tue, 30 Dec 2025 08:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767111184; x=1767715984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dk9ZuM3G5phCb1dgA/X8SZWAYSLfk1dpkiiVrt++Gic=;
        b=AZLNPEtBj33Ik5Dxadv7NROaxPxCfBx3HxWHXHi9zQ5f0GodiAMpYVYEKpZdyQq536
         TywuWbzBYDdXhapdshWf8OEcTveD966S9Zkq7eB54f7N4aon1DBTZmzXTHQg67C3FcXz
         K8GyLHu8laudi2CG8LGygP0Ql41odFZ2W8j2ECRGyGkr3IjgvtBCT1NzjafLp8d3TWsB
         8dK1odPcdzFT9xb1NmPq2mrDvnGzX61jALaQ6X9DVfllUZ4FdJ4GoTPo53U1Ut5RLLEY
         /u+oNMLTlUk8RkXZExhD0t0R+l+CtfP84d32P0DxA19SHstMy/ambWjy2MJeLToxTAA6
         k8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767111184; x=1767715984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dk9ZuM3G5phCb1dgA/X8SZWAYSLfk1dpkiiVrt++Gic=;
        b=Crx4wj3fFHDT9NGn6wyQgVnt5U6klcB1M+05wsCBTgOrKZBsRux/Dc3KmqFi9Ju+BM
         YHSBMh579EFrQWl8x7n6WC7nHkjH+ldkCA6U7Gb9uzMTOZNH+TYWt5t/bnFNV+wAJ4vl
         5teKOKrryB9rjAQsL1ulBBZxLN0tRfCkqyM2blqiwnXsTasrFkKHy3m/JVziqe1yQFMY
         LEPtb6ACpWd8HVWcFAOBWEj/kRSumUX//7/8fDYBdQsMBiGE3aDUmStmqZmdI0KKNVzB
         F3cjgLV3poj40quSVR0uQLNIihy+kqhD+FgRUJBWj5trbhEMPUQw3cs0Ygc9iK8AKl3n
         N02Q==
X-Gm-Message-State: AOJu0Yxz/hhgUlxyDP/z7sGEkxdAjbRvITO1HpTzgEETPCG2LzZC9Spb
	eAi5vowkO3sRBGjiGzs5A0+s0vlzj/Jo1JEJO0Kk7hPMY0IJSyOh0TfrtHMBpg==
X-Gm-Gg: AY/fxX4W5lmG1tmXF4DGUM65e7btDppymwY8YKWoLTk1E1conN2GjyQcLXk9dUfYe4S
	zB/2iYbICs29QqIf4EIidGjwbtoK/TQZnvfr8GldlqiFwtPFqoVeVFZ311H3+4GVP4nMh4MsDc/
	NBjc3zJbXcYJGXsb2t2tam9P2Dr02mQ/Lz5f5FF8u714S4h2lxqzgGSlDJLVhc8/CTqE0PW0PXW
	/hrga+j3cDrAbFd8jNC8Gver92KaK7lFl6+ssiFR6w6rC28Mc29LogQraRixwA7mO73seiVNxwz
	2/1XvtaWO9Uw/Ke+u07005YSPM4/fun08tadb27tyfRRB2/CSCQSpoQDCkalbeVgDCUQhLDH3rL
	qYSi/U2wMx80pEqqP7EwaTtmytM5zDYo7fJcpfcyX6QJBN+FVv4hHy9TmVPxNyyj/W6gSGjc5fa
	97gCI2JmG+HvRGwnxI
X-Google-Smtp-Source: AGHT+IGEevCxCEFCliMTjypJGkHkMlxUgfvi8UT6LUdV2NTnU+5t3li+03PHq8OqY4LClkVtvcxXYg==
X-Received: by 2002:a17:902:d2ce:b0:2a0:de66:49f1 with SMTP id d9443c01a7336-2a2f21fc6b8mr238601065ad.1.1767111183493;
        Tue, 30 Dec 2025 08:13:03 -0800 (PST)
Received: from fedora ([2409:40d4:1068:3606:2e00:3502:91b0:a7eb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d76ceesm308119215ad.91.2025.12.30.08.13.01
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 08:13:03 -0800 (PST)
From: Kavyansh Bagdi <kavyanshbagdi224@gmail.com>
To: git@vger.kernel.org
Subject: [GSOC] Introduction
Date: Tue, 30 Dec 2025 21:42:24 +0530
Message-ID: <20251230161228.61455-1-kavyanshbagdi224@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

I'm Kavyansh Bagdi, a thrid-year Computer Science student from Udaipur, India.

I'm currently exploring the materials mentioned in "Hacking Git" and setting up the repository locally to familiarize myself with the codebase. So far, I've read "General Application Information" and "Sending Patches by Email with Git". I plan to continue exploring the remaining documentation.

I look forward to learning from the community and contributing.

Thanks,
Kavyansh Bagdi 
