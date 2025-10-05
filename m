Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79372773D8
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759663651; cv=none; b=bl72KLweGD5Nu0kZMgd9+IGLe54SZHVpPDJUHGMooyGQExzzg2uF6v78rGUcSPMWDQmTTbHGwwXFtg/6Yqj5LrzDX5iboNKhLpn8L88vVKr8hXIie3DAmrulEXCK9lTtq87KYYiUpg/bKDlWvDwSe1ahgDGuxoAjm+Bjba4bVXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759663651; c=relaxed/simple;
	bh=2vyNNcBeDHiaI6sQzgNEMxSPiZ7jy/a8mdbQZ2Be8/s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UZcwXHjCyxPIO2ORGCyUyyjzB0bThWNVyT4mfI9N63H3dxLDPQp8gb2pRWNFtogGhdhhx1YcsRuJq53uTZs3jpT/TBjDGS1J+MUnEI81xxrkjlil3RGw61nWBclzg93mhJNzFxovLKcosAMiBAXMUPBxuu+1coHL0kH4DjZrdVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BD16xC6T; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BD16xC6T"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-36527ac0750so37288261fa.3
        for <git@vger.kernel.org>; Sun, 05 Oct 2025 04:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759663647; x=1760268447; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2vyNNcBeDHiaI6sQzgNEMxSPiZ7jy/a8mdbQZ2Be8/s=;
        b=BD16xC6T4mEvnHGt9CV/BHSK/La0SEXLLGuMEeD4vRmgkFECyUUs+5loMa6JisLfb+
         Hqeo1QHAGRezkCkkigeeo+qIyOKmBbggcQ9lUgpRFF8hEoz+HqiKABPhxhaY8ILz5H61
         PtxJPxyX54CYfMDMh1YLXPSdt36c0Jr1flSvJ32mMj2yITtb4ZHWevBsuKlHDpJXBLnH
         s6qJwC9MqnNPGdvJu9mhSRhCro8SZwG2Gp7Q5hJ3FhB1h+RH+Z8w7+vV7GTgngy4ymQt
         Ouj0l3iQCsggUhyBPnlo/UWqpn8Ks2xpKxek5ya8cEu6AioFr7VFZHeYPo0aZ5Jt4qr6
         EdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759663647; x=1760268447;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2vyNNcBeDHiaI6sQzgNEMxSPiZ7jy/a8mdbQZ2Be8/s=;
        b=E7oI9qUTAQ8iL7+rmxUc+cX2dsrcKRS0RlEz6o0BYqA5GuFChAXIPspXoN6Iza920G
         8y0get+Aa5plRFagy212pEm3J6Cv84WUwPusgrE5BYR/IYkCJzTRwb345YZ4mIOAn+vX
         4AxR+xd6tBWzPxyJqD+1BJaSoQ+JvPfQ7Oh4P37vZZNd3h3kLspW50l63Q0l2ijakoAE
         66EVbn7Lj/UQ1ezsqFWw0T+3AptGAJzkcZuVfLF4nFNeis8HZ8TZp/AA+0ruwKAZkAI0
         yHSIi2t6QDLkNEMbtK8Xle5/uN/vIWbxGaxs7yUht8zjZ3a35T2KA63McnrMlqtgUdaj
         EEYg==
X-Gm-Message-State: AOJu0YxbYafk31GI3Lyed4QU6VoasWVpINEAM185NVBXAymQ5XgdHK8F
	edyDaIxN1640/+r0KS+2/sdQd97962P68Pu4R4SsdnpS0yd6fQ9N5YcgDAtR9C3lYsjrKJPXoga
	FXjN1LyREjHKDd32Qu/UvQ+lBhnq9KQNRnxDR5RE=
X-Gm-Gg: ASbGncsvbYber0ZjKC1uTRM1kX20FthjimDUEQ9hW0sxyt7leoJSbO3DNmK1jXTcjLw
	vpcqNK5NRVVxUkELkYGk/mKmiZtO0gjmspnualjimZ5rwkt9n+MK9RShVnKRXbR55sw68RrVO/n
	95Lkl2eh9yZLj8qqfYolJiKLiKvvI7/EsdyRYzB6EEsX1NXGm59phWpPDaQ3IfCx8frSmsNNmsH
	iWPOTmNdL6hKzbWSoz6pR/nCwka7F3EMtcjjiE=
X-Google-Smtp-Source: AGHT+IH54xpxX0fNrd8Lb4LRxrFw606gPWox/dJ2wsDgiNFAaJ9RvnkLVD80CVFecmWJ5+aSufswo8TY2oxJCcgH5qE=
X-Received: by 2002:a05:651c:2226:b0:36d:9ea0:e164 with SMTP id
 38308e7fff4ca-374c36c4a13mr28942321fa.1.1759663647172; Sun, 05 Oct 2025
 04:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Devste Devste <devstemail@gmail.com>
Date: Sun, 5 Oct 2025 13:27:15 +0200
X-Gm-Features: AS18NWBVKkRdlziiyle7uq5xrpZZIX2nsmHyXNRMZDtWlTbbCyArn4CCHtcoI6U
Message-ID: <CANM0SV0R7OYJKeBAs5-WY2Wqp7VxhKv5=LQ4cuDd6MaQwNqGNw@mail.gmail.com>
Subject: git clean deletes negated pathspec if directory causing data loss
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I am using:
git version 2.51.0.windows.1

Run:
echo .idea/dictionaries >> .gitignore
mkdir -p .idea/dictionaries
touch .idea/dictionaries/foo.xml
git clean -f -f -d -X --dry-run -- ':!/.idea/dictionaries' ':*.rej' ':/*/*.log'

Outputs:
Would remove .idea/dictionaries/

No matter how you specify the pathspec (':!.idea',...) it always wants
to delete the .idea/dictionaries directory, even though it does not
contain any .rej or .log files and is explicitly set to excluded
