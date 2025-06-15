Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017A82E11CC
	for <git@vger.kernel.org>; Sun, 15 Jun 2025 01:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749952278; cv=none; b=Wrz/0H101XG9bVib339zAiCjAH5Y1Rq28CM8Y4DvXNUsGgOukH0aGx5rZWDpsfry4Mf4igyhD8otJ2qMpLiV1SLCMfv25CXBNKa7xPWUp+mgI9y2RhwbrtoU58ClQr8ACqeUinSQEzOEk+Trhhsl9Q5x0upucW77sUtpp1I2dU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749952278; c=relaxed/simple;
	bh=RcChKr6TM/xQQnYe7k7TYgI2uqgm49Jp3vWLBOmP0Ew=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UAhERGSgYcPTysA0MGokO/KcHoR3ND3BIclqujWAZrI6++gsqgfnT8OzbbYJiCEkA0DCKvtRCNcObH/bgfXeCwOqVOs3l2cgX2cDkqZloBDNAt6iBNyy7vbgJe92cs/tqKH8AMaTpOUm4Jox0c0dqEAkU2dfSjOUCP1Wo7Wv1+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpsz11t1749952208t2dcc6332
X-QQ-Originating-IP: FOHDXsihDJFyD5K5GrzCGvscp1MzW2EUB/DGD/kV6E8=
Received: from smtpclient.apple ( [202.119.44.141])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 15 Jun 2025 09:50:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2942277361292971138
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2] git.c: remove the_repository dependence in
 run_builtin()
From: Lidong Yan <502024330056@smail.nju.edu.cn>
In-Reply-To: <xmqqwm9d6gn0.fsf@gitster.g>
Date: Sun, 15 Jun 2025 09:49:55 +0800
Cc: git@vger.kernel.org,
 ayu.chandekar@gmail.com,
 christian.couder@gmail.com,
 shyamthakkar001@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <BE43915C-E780-4166-9C23-81F9A8CBDEDC@smail.nju.edu.cn>
References: <20250612045905.3023227-1-502024330056@smail.nju.edu.cn>
 <20250614050331.304405-1-502024330056@smail.nju.edu.cn>
 <xmqqwm9d6gn0.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NPR7uEA6bBhoRm3Vc2WogyNIYg31Cq1wJtQPjMXUUPHz2Wq1cBS25JSa
	gDsbeRZ2I4YAUJImQzsnQOqtL5NmN5s/KyIAA56efKEiOq5BB4vbm9Bephq2QPG/KHmRsUn
	Fr6GBHrumop5XerKaEvvmZQxv9IEv04+XGUjC7dkJF16X2Ah8Xuu/Mh05tzo7u/hfdxWSOM
	KLm+MthwEi5DKlnKPNy6GXmRgPLEx+uvM8wmTMElZbESA5iKhojaSHr9ehW/pao+OVRPmK2
	5Os5+rke8NZ6317ZIfcriVLJXPENGlXU1CpkzEXk8Hr4/6NL3bEI2t+JFQLzZjvlcTmhlV7
	J0lXKrxv7KHeoCVYmUd5UbZfsDEtWHxM8DVnTYWq9/Bl2i06J2KylAOCPE+qOADgzhTY749
	1ARv3yttdm71AmBQP+AhbIQkJi6Y8lRHnFba6QxN00/YQnnadoqEsZTHmY/d1r6OQ8STvTB
	guzJ3LFc3IDPRfQvqheZ/Mw7zujcyCQ4Y55V+5kuejC1J+YsRr7A/vMjCSdedmTcWY2ckPs
	b/nHIzt8iy9OeHDJc1htTnkW7nEYkBSTIzmFQCz5A3+HUP1O7qXwO8n7CRcvDSE1MUliyq5
	pA/UR10MrR1qRYgKCftr1Sq1FeIxm+ual69id2Y92/ZWp41JsssMGIWVb8fEvh2jGnsB49m
	+EPemqHJ1Qfo8fAc9+2WKRS4Kn8eDcWGKk/OAurqhubStgAj79yvmHAigW9PgFgsu7gSqGm
	ZsUyZ+efJC1QJYK6hVW+5h8cc1QbSLYrQP/PB4rPM9R+j4SXDfmkcPocYGFlidfAYUtJeWQ
	UOt9BxowbjleIx8HEzosoAFlx1Sxq4dTCfFdJB84pn3nCQ9QDwi8+t9wneNyjcoErC4ygrI
	wNE74Pm7H8Jgt/wfX4WBcieSduG7V5cgz3VSLcG35t6XgATEldsB7aS7/0JELmGS7VgFpL0
	2Brkr3xHk8TY8TLloX6qeB7sKUmILTVQyDGkhYTio2PjxkQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Junio C Hamano <gitster@pobox.com> writes=EF=BC=9A
> Sorry, but the above makes it sound as if 246deeac (environment:
> make `get_git_dir()` accept a repository, 2024-09-12) that retired
> get_git_dir() and introduced repo_get_git_dir() was the culprit that
> made their semantics change, but is that really true?  It appears
> that in the version immediately before that commit, get_git_dir()
> was also a reference to a variable, without any lazy initialization
> the above message says that the code tries to avoid, so I am even
> more confused after reading the above.

I was reading the code in master and noticed that repo_get_git_dir()
no longer sets up the environment. I=E2=80=99ve learned that I should =
use git blame
to identify which commit changed the code, so I can make my message =
clearer.

> Perhaps you have 73f192c9 (setup: don't perform lazy initialization
> of repository state, 2017-06-20) in mind?  That one did stop calling
> setup_git_env() and instead force a hard BUG("") when git_dir is not
> set up yet.  And that BUG("") still survives in repo_get_git_dir()
> we have today.

Exactly

> So the call to repo_get_git_dir() may still not be made from this
> code path.  It may not attempt to set up, but instead it would die
> if we haven't successfully set up the repository before.  The
> relevance of the comment was not changed by 246deeac that moved this
> code from get_git_dir() to repo_get_git_dir(), and more importantly,
> it was not changed by this patch we are reviewing here.
>=20
> But stepping back a bit, is it what a9ca8a85 originally wanted to
> achieve with this comment to "avoid calling get_git_dir()" in the
> first place?  Once the guarding condition is satisfied, it calls
> trace_repo_setup(), which in turn calls get_git_dir() anyway.
> Perhaps it wanted to explain why startup_info->have_repository is
> checked here?

Yes, I think so. Maybe updating the comment to say=20
=E2=80=9Ccall repo_get_git_dir() after setting up the_repository=E2=80=9D
would be more appropriate.

Thank you for your review,
Lidong

