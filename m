Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0B62144D5
	for <git@vger.kernel.org>; Wed,  7 May 2025 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746620404; cv=none; b=uwCZHCi69hW7yIMYL2sWupI7BKL913oDIgplHBDZoLMYDQHpFxptud/KQF8qWnkVt1gA8P2s/cxQBoeiAXlis49xWADniK9iDJ9WV1s+Mb2sPTiueK/yr7GJim7GuuP3PeDgHxMBpXjXRIqaIa5keqkfnxOktZmJk0HfnJXEckk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746620404; c=relaxed/simple;
	bh=yD3J9rG8GTgCWJo8nkXbM7Jemtl7cPJFG17Z8jhZxGs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dmHcwbxj4VodT7Ltc4Wjfp+89ThQGNsxpAtPUtfG/v/CoD8A1lRCS1GiekRF3wKywPvFuQIT1fAtRMd3xki3OI2y2S3ndBoyQTM8BXOo3o398rMzX5yEQe5TYbixuREU+s0Qco1shcBmcibprigOWHpUL0DveRfpsKsmkB2QGhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpsz21t1746620381t94bd310f
X-QQ-Originating-IP: CAjaY87w+T0oGtBTKS1PYcCww39WbNL2ew+KMaF8fx0=
Received: from smtpclient.apple ( [202.119.41.249])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 07 May 2025 20:19:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10806601035236810137
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH 3/3] fix: use strvec_push_wrapper to prevent ubsan failure
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <aBsR0CUusW0Fo4Ef@pks.im>
Date: Wed, 7 May 2025 20:19:29 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1CEABFA7-474C-4253-BB92-E3F153213F5C@smail.nju.edu.cn>
References: <pull.1954.git.git.1746585203.gitgitgadget@gmail.com>
 <a9cbca6bed308f2b563eca5d7707c6bc30aa4603.1746585203.git.gitgitgadget@gmail.com>
 <aBsR0CUusW0Fo4Ef@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MIXpHopat2IaxLJ9SiOkO6X/oS5KSLY2Lvb6wDv9oYBKjVEIGGFFcg1y
	LUEgZBbmH3z2tsatMRDz8oNsGCf44Phy0IDWdCG+ow+yPOZr+gPDOLZGAtokFMR8gYtVh+i
	h9cAoSzXDO+pxhteaiVXfJAgfdw+nLdhnsVh7trfLF40l/pe62Qvf0dKfQYDfLJJuEDyBJM
	sUVU3z+v1f74xg/c56DnyP4Actf9/2W4aXCLugrpmP280KAtuzSF0Zw5SZ3U+VNcDx91gXP
	GFp1P6DalB19bCjFdYtIaAoI9Jm/0LxDBAgI3rJaYVE5W4qYLF1sougArsTotcp71smcLGV
	FAIqdPJCVcC7O+Kc312J49omTsFf0gDXqtrMDkCpPjqTnUUDF0fxc0PBw3VmoalL7wAgSZg
	xF7KiFxyl0OUtgXgA4cR2lytfNNq8zFOfQi7huWfKOUTlSXSAdl9EkAzAEcU2rhAJIbBKFL
	Z+iOS9P14DTypS+EMvjyTzhQVV6d5IwQnYuQR2RJZ8qdwt3MAbddgG7m+X9XzGIRmBSrKow
	IgK1PPaVkjoU/aTSz4DUMvgr/72Xs2TokwjS1ALEnT3XSR1ot2DPOGgoFR+6pmVZr/LsXQ8
	kxQoTO9GYQ358g1BN0LzIGbBKKlb5QKkX0hZ8fUJ7bw7EQVSSkbGECdkfkWQ2hlD6z+Z65B
	LsT+4rZQmryeWYmpdQ4rDb7qxj2hDieGWe4f1gCqDqTe1d91ZP/GVlBUUDBXH4MjuiMb1kQ
	zJLZ1MPvwF8EYCtrCNlLqQog9baqf4Nd+f/jaWnK4LOLWaOV1EQHvTWJr9xE87CnCt1oSua
	ehubjZANuJFJzCaSSLqam5m1j/Kf6j/rXqqaM06ALUNdIUGbIALyuU1j04PpxwYC8D+5tue
	y5E9OszJ2+TDEttZjYLuDFJfElDaiX2oKrJ3wgPom7tp5HKg1bz8kyDWkWBQ345Fj6zrDNy
	Q4ZFyEua1ggUaD6Hgx8mCjzEIyCL/FdgzH+Nyqr47iyFStyWOlRA3RFfikM+UP7QzO1nIN+
	PN4BMci26p4h2WGO8WFYTwdERaniM=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Thank you for your suggestion. I will squash all the commits and include =
a detailed description in the next submission.

In short, calling parse_options may cause a memory leak when =
encountering unknown short options. To fix the leak, parse_options can =
use a user-provided allocation function, so that the user can later free =
the memory and avoid the leak. I also defined a macro called OPT_UNKNOWN =
to make it easier for users to pass in their own allocation function.

On the other hand, I think a new file should be added under t/helper/. =
The reason is that this new file not only serves as a test, but also =
provides a simple example of using OPT_UNKNOWN, which others can refer =
to when modifying their own option definitions to avoid memory leaks.

> 2025=E5=B9=B45=E6=9C=887=E6=97=A5 15:54=EF=BC=8CPatrick Steinhardt =
<ps@pks.im> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, May 07, 2025 at 02:33:23AM +0000, Lidong Yan via GitGitGadget =
wrote:
>> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>>=20
>> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
>=20
> This looks like another fixup-style commit. I assume that all of this
> really should be a single commit, as the latter two commits don't seem
> to do anything new compared to the first commit.
>=20
> Patrick
>=20

