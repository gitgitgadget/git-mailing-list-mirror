Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1144641A501
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925476; cv=none; b=ddC+h9F3vWwZAX0koidPDQnpkSZFjQ+VefAT1OdX+oRva2IUHLLDgU1Vkp+3J7g641i6ZbC/GXcICkXWDb8d7plrlsTiUpwS5MUSNiyhpWP3Q+MoaByQWyCYr0B5MyVWSVO+1bsfHR4O22VSp7rMNFPvh06OuHlW16MJdQPvIVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925476; c=relaxed/simple;
	bh=39TXCXEkCMEEiGU03ErCwwivIropYU9EI4wiJ24BHm4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=LlsItedwQ+F/N7I28QfHffHRCqd2kUlxdEXz3n1A8Dxyw84I8tQrtqTaiiTVAC5BROg/2xEoZHlvfxhahGNngn/ZaVFBJRA73pb6rVTuRIbMw7wyh6V68NyAYlZsNd/MHDVgiXEEYIlEFlWn6sCTlQ4TahzwA/nDG1vFDyY/hhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zp8dEmSQ; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zp8dEmSQ"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3410209aa6aso897919eec.1
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 00:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790925474; x=1791530274; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kDRLPp8HcPn2n/LDX91pDLL0Z3+J/U6YQx4f8i1pbjQ=;
        b=Zp8dEmSQ99TXCUqo0f7ndqCyiqqJYetUEjQndAF/Nl/AfcAupZ51xraRQUFBlHAuO/
         KRqLXD/YI2nNE9s0hUlJftI5luljNJ3a+hFvv/4XRz34W1LDc+MK4UaX7HBWjAhqh5zW
         pOYNK+I/9sfiR95Y8H2vVYS8dD6istDYy9wcd4qqpAOD0W8ulpsVfcAD411oDZyN81XC
         9BSD4QjQeaXH+WuCu1JNeDKhCyL/meLbFgRqAtTsW4ili1FOWQWJDYjDBo+wBkOG3Lyp
         2uhAsg8khNbwWYwJUy5gRfvM4V5Ac66oUvQ68pXRMpyKb0uXMVEKIOGPl+zA+pdYIeeA
         VdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790925474; x=1791530274;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kDRLPp8HcPn2n/LDX91pDLL0Z3+J/U6YQx4f8i1pbjQ=;
        b=OXNzxKRCItPtQk1whZHBsaoggWGe4z5k3DX2wAgTSVuRzqaRnSQw/VQTLKQo4dofqE
         B9Iwytjy9HncIo9DpBo9+xo/HCbfCuz0XVOOLHBZSX5e/HwKbVZhOWGt51Yk0VAf+tal
         aFLDW2dq+aVIqoKGK2E4WInlv5v7WivPiS1OTK2l2tNNE3fp1Bj858R++UlcjwFwS6DI
         PrPXAjus1Ter4LpYwGAxF+O8gfn1Jyg/ocZ+6Hk4XV0BVWNAboedC1tBX3ldRVzpRUsQ
         16EbBCfGn1fts9AsgxSxqu7eMk+FaXTDvP8n/DbQhjkzy6u0Mc55TI/fdmOgSEg3Ik4g
         tG7w==
X-Gm-Message-State: AFq9FYISrM+4N+xJ07lZMb9WBB1FZqSa6EPs68UoLO0b/soLLEl9a3Id
	lw5fHSQ2e/v+zyZmwpVZJpY1htxZ9e7saz61a8H7Iv/JLKyWBijZnHiIuVTV6Q==
X-Gm-Gg: AYBFou0waSpq3J1LYCQ27Eztd+y0vmwJnMasFeG7W01g3fuZwj0fGiuZH4lJYHttBci
	DPme0JWZPqVb1OMsWpOcBAPMWmRnEXPVpWZ5zp9PyHCB7zMJnbVY9ZLoKBFqYl+b2vegGgiMnyx
	MxPgS2ehG4gPD5fbXkb8gXhx9aGuZrRfMPLEQ+HgNpNzjio6NXTntwQoMaDoU5+SS2dlzubpoNi
	ZtV68Mg23UdAgDLQtV2DsT/I6lghi+I7w2e6hFXmRNdGs0ZYH/y6VZum5sRG3gnSbsHSG9Qs8wX
	L2W6cpu7QaJbvVujsKDlNWwuPTH8FsHXJJ2BT1A+JDrni35JC2bzq1RfImDwPWBy9ayP5EMfqdp
	4Gwn5gPyXJmjhKkDCRYhfbDmP9Kg5lR0ofQzoLGV+VgPcZntoJigW29IU46ssd9NIYbXC9VVgg5
	Km/N+JAW+kenWxBBWab7vzxriiEcQpMAAMa7EI1swrCtN5FQLb83V2zDDf7qs2hOwb1UlBSOtgA
	w==
X-Received: by 2002:a05:7300:d08a:b0:339:851c:4c1 with SMTP id 5a478bee46e88-34db6bfe0e0mr5067499eec.18.1790925473809;
        Fri, 02 Oct 2026 00:17:53 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f9f2afsm9584282eec.18.2026.10.02.00.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:17:53 -0700 (PDT)
Message-Id: <pull.2423.git.git.1790925472.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Oct 2026 07:17:50 +0000
Subject: [PATCH 0/2] remote: allow a list of remotes in remote.pushDefault
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>

Let remote.pushDefault hold a space separated list of remote names and push
to the first one configured in the repository, so a single global setting
like fork origin works everywhere.

Harald Nordgren (2):
  remote: factor out lookup of a remote by name
  remote: allow a list of remotes in remote.pushDefault

 Documentation/config/remote.adoc |  7 +++++
 remote.c                         | 54 ++++++++++++++++++++++++--------
 t/t5516-fetch-push.sh            | 36 +++++++++++++++++++++
 3 files changed, 84 insertions(+), 13 deletions(-)


base-commit: 0f8e75abebff0877cae681a3d5ff31ac47f54220
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2423%2FHaraldNordgren%2Fremote-pushdefault-list-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2423/HaraldNordgren/remote-pushdefault-list-v1
Pull-Request: https://github.com/git/git/pull/2423
-- 
gitgitgadget
