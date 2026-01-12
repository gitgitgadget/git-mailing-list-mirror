Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76104364E92
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235164; cv=none; b=Aks6DnezeOMuRWuMcFNezsdZyELo2ZT8ae6QU0L3pMVx8+KFhfB7FAlxUBnnqmaOe3R4aIwl8jOSO9Ha4n0hNIg3r7cDz8/jbOzNi4785W3/5eSXl93S9gviz5WDifqlag03LQ7J2A74DXuZbw6Hchum3Ijh39EiIon1bvNAaDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235164; c=relaxed/simple;
	bh=Bbveltq65m7CAJUG79uxScYzRU4XxogkTMNSsygvY0U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8DkOyPdJzrxG2RJ1Anq9fbTEo7scb86GHyzVgDuwSTY/Fw8V+abGR1bFr+rT08uA2IUBe23v4IUmhmx3qezlAJOfcgL4m4hFp3ma8i3o+XnKTol7/5MoF3S+Pw8LloFekOrZgu1d0KLmZ8HO7XZNA+vKinynEFwb9FDINhVkOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=M0UzXcHV; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="M0UzXcHV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768235152; x=1768839952; i=tboegi@web.de;
	bh=NEA/2gJ3ETQV8N051onWM5h4tHZDVKiVm0l5vGrpMGs=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=M0UzXcHV/mg6QhK7Af/gM56UtsyEE8o2dT+uVRD6rcnFbbPBIHBo9MX3Ffy1qOnO
	 /WCOybL7ssMrBY1ffvQePh8LSxcWhoopAH1628es6bKxCqewyBEuawJT3Z0mOuF4n
	 b9dNr60QrDbDeU92WSMA6Dxma9XU6q+O3aJGk1skwjQBMAPyGGE0Dg7t83OepuRcX
	 6/GX22QdSBZ6DSgx1qxOaOdkHzplteCNT/V/ACgNPOUtPxR/kcbJxZCKl+p+Qis+y
	 58rhTDA0Co0w0Qcw1MZ2EEDhvQ94I4JCYvxwnE+Iv4SCHMLncB09huvsYyE/GwNCr
	 Kpp2pcwM7DRp/+X+OA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from susi ([81.224.105.209]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGgJK-1vbT8H3CPC-00FGKT; Mon, 12
 Jan 2026 17:25:51 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	l.s.r@web.de
Subject: [PATCH v3 0/2] Workaround for iconv under macOS 14/15
Date: Mon, 12 Jan 2026 17:25:47 +0100
Message-ID: <20260112162547.774015-1-tboegi@web.de>
X-Mailer: git-send-email 2.50.0.rc0.46.g7014b55638.dirty
In-Reply-To: <xmqqwm1no29m.fsf@gitster.g>
References: <xmqqwm1no29m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kvJRpgWyurpC9iiuh9Ky313JgTH01yVdIMBm/3UOaRAA8IzGcci
 Omovi6/r5TJsfWJHuXWMUo4ya4IDtDu2Q9X2L24BKmKqXCh2CFMv8i/dUc149Y6wf4csvcw
 8P6eY/2606kvMuxWMGvlYk8rJ3kG3tImEszm2o1v4igEzeIor+/995X/wcb+r3rUV1Itxsk
 piqKSqDuvMf2YoRldCNGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M0/598bexT8=;qMphAeaHAr6liA1cy0S85XLnrbd
 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
 HGwYt9mFqY3Y0p0A8=

From: Torsten B=C3=B6gershausen <tboegi@web.de>

Changes since v1:
  Re-fined commit message (thanks Ren=C3=A9)
  Installed a fresh Fink. It lives under /opt/sw now (/sw in older version=
s)
  However, people can choose other places, I did use the default.
  Make more clear that libiconv from Homebrew, Macports or Fink can be use=
d.
Changes since v2:
  Even more details in commit message, and now
  git am works (Thanks Junio for the patience)


Torsten B=C3=B6gershausen (2):
  utf8.c: Prepare workaround for iconv under macOS 14/15
  utf8.c: Enable workaround for iconv under macOS 14/15

 Makefile         | 16 ++++++++++++++++
 config.mak.uname |  1 +
 utf8.c           | 13 +++++++++++++
 3 files changed, 30 insertions(+)

=2D-=20
2.50.0.rc0.46.g7014b55638.dirty

