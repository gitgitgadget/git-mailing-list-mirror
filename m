Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A774629D0F
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garciapimentel.com header.i=@garciapimentel.com header.b="Z4VQ2jer"
X-Greylist: delayed 425 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Nov 2023 09:44:05 PST
Received: from ci74p00im-qukt09082301.me.com (ci74p00im-qukt09082301.me.com [17.57.156.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8551CD47
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 09:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garciapimentel.com;
	s=sig1; t=1699292219;
	bh=oej3bz/0XHbG6Vx/st6zOBc8rRAmV1nHVygSo5rwwk4=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
	b=Z4VQ2jerVBOhdU+Egv8hqE5fyEOzmTUSZ9vgv5txJMmL81R//l6Th7Rw2f1eigkg+
	 Cv/rlQXTjGyKKfIco2QU3wewxYhbFBWbJgMtP3Ql0EtDLcsta9Z9rE+/b2AAyKiaXt
	 PewWPL5t8jlcDwA3CCershPoprYObMcA4SK8AxWNnNNsKE9dlx9J7AfkO9JcYnFQbE
	 WsR/HvZ2qln1i6397rO8RwPiVT6604v8p8c7qMts9zqHy6kSPHRnOUxizq1tuPXQfU
	 zblY7rp60Va1xmDdpD1bxQSHYJ1OPrYl0YR0Sh34jVMGPFtCebOsei69DuMd/X046g
	 w4u7e4x673alA==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09082301.me.com (Postfix) with ESMTPSA id 826C3F8011F
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 17:36:58 +0000 (UTC)
From: =?utf-8?Q?Santiago_Garc=C3=ADa_Pimentel?= <santiago@garciapimentel.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: git refusing to merge branches when pulling using a refspec
Message-Id: <FC0625CD-D736-412C-A4C5-04F9F41FFEEA@garciapimentel.com>
Date: Mon, 6 Nov 2023 18:36:45 +0100
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3731.700.6)
X-Proofpoint-ORIG-GUID: C9GMDqUPV1M1fXfn-sY4LKWtI-FvTmDx
X-Proofpoint-GUID: C9GMDqUPV1M1fXfn-sY4LKWtI-FvTmDx
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1030 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=700 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2311060143

Hello,

I'm dealing with a small automation (CI) to synchronise some specific =
branches between two git repositories.

I need to sync a branch with other using a user-given refspec. e.g.

$ git pull origin =
"refs/heads/branchOrigin:refs/heads/branchDestination=E2=80=9D.

(I=E2=80=99ll have a list of refspecs, but so far Im trying to make it =
work with one)

When the branch can be fast-forwarded there is no problem, but I cannot =
manage to make it work when it cant.

I just. get the message "[rejected] branchOrigin -> branchDestination =
(non-fast forward)."

I've tried  the following:
- adding a git config with pull.rebase=3Dfalse  (I also tried true)
- adding --no-rebase to the pull command  (I also tried =E2=80=94rebase)

In any cases the result is the same

The issue is, It does work if I just pass the branch names. e.g.

git pull origin branchOrigin --no-edit

merges the branch just fine

Im not sure why git refuses to merge the branches when I pass a full =
refspec. is this intentional? is there some other incantation I need to =
use to make this work?

Thank you!

Santiago Garc=C3=ADa Pimentel.
santiago@garciapimentel.com=
