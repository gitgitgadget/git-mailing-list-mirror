Received: from ci74p00im-qukt09090301.me.com (ci74p00im-qukt09090301.me.com [17.57.156.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50B42F44
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 03:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727062125; cv=none; b=Y1zia4yVf5c88JnKDwpVGDdxUBdV/xZvaJQZDM4VeDisn9fHbdS9C8o3f+7XgVYtoqCTY9LakxuLgTsCLS66SBpspe93cvZmgZCEYSIcpiANXQkOKDunxjxsr941EoHdsR7XGXGr7FcPEc63i3Lud4VDSj/dx5XpJVHInYQbsfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727062125; c=relaxed/simple;
	bh=0i6Xp+hefopB/EdRuqXOkFfvh8l1L23kk4b54C7y4w8=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=nx1hifw3uhjz2jtugJbnIlQ5FnXiyD0uTHZOXhTeOw/BnvVOL4LTkERB6uANu6lcFxh4cgMt1LjPY4+TxwCVSl4zp4yz/FZdlf2G0Dre2PqhVHtL3hZ3U9J8RaeyZaQqM2VZM9qAtDHvYaHWV9NyZQkGvbCeGRpY3nY+XmPcuzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mateuszwielgos.com; spf=pass smtp.mailfrom=mateuszwielgos.com; dkim=pass (2048-bit key) header.d=mateuszwielgos.com header.i=@mateuszwielgos.com header.b=u/e1TuLz; arc=none smtp.client-ip=17.57.156.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mateuszwielgos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mateuszwielgos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mateuszwielgos.com header.i=@mateuszwielgos.com header.b="u/e1TuLz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mateuszwielgos.com;
	s=sig1; t=1727062122;
	bh=0i6Xp+hefopB/EdRuqXOkFfvh8l1L23kk4b54C7y4w8=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=u/e1TuLzuw8HisK1cv+m3jibSZKP2YY/Ub4gCxeeln6+A5xvbz7Nx+vpGmeG3Oq0Y
	 FPTyrEbASkO4vhKU0QlOSbV2jIyAIkwH+3s6YQi3CPeKd6eiV6F5+7ZaQlq0a3e2a3
	 TJFOmEhca246Ijjp29WnUnsii3xvAvrC+YU3QRaM+r08MBHVYrkqHuCD/BGgCMcmJm
	 2fKLRzgc2BS+14PJsFLRYsdbHL5ocFtoNA6pqXD5pK94cOrEDUOwnUVpGsBZTxJqVF
	 5vuUMAHxZSmG9imiDihIy4ACqXTZ+4y85FAMX5Te8DE8vozslc7WiC8JuC3o9Se1AG
	 umRPU7Q5JBlUQ==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09090301.me.com (Postfix) with ESMTPSA id 11F29112027B
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 03:28:40 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Mateusz Wielgos <email@mateuszwielgos.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 22 Sep 2024 22:28:26 -0500
Subject: Using Git as a Database
Message-Id: <4B2B1EC7-6B08-4B57-A50F-702C031C2792@mateuszwielgos.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (21G93)
X-Proofpoint-GUID: swnJrLduZeNzxOzMyXNncLzr9hy8ftBq
X-Proofpoint-ORIG-GUID: swnJrLduZeNzxOzMyXNncLzr9hy8ftBq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-22_24,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=767 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1030
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409230024

Hello,

I would like to use Git as a database of sorts. Let=E2=80=99s say I want to t=
rack weight of something in a file. When the value changes I can commit the n=
ew one. I can also figure out all previous values. That=E2=80=99s awesome.

What I am having trouble with is=E2=80=A6 What if a measurement is taken but=
 there=E2=80=99s no change? I want to commit a file that hasn=E2=80=99t chan=
ged.

The only workaround I figured out is to toggle the executable bit.

Is there anything else?

Thanks,
Mateusz

