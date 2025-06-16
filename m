Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2FF2E11C1
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 05:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750052246; cv=none; b=bYkvtXVSIyyE9N3T19Yv5h+ObWgj3xStZiNfOw25upjssLDA88wUQs/P0xa5hRVxK0XSMSmQKnUOet+3yKlmNVx6pTO+RkF9lM6pcHfFmWT9ejT/OWXwbY/2WnOE0SWCVdFuJ/3D/t+rRmGYROsSEy97gfnFLTIlWVbpnck9BPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750052246; c=relaxed/simple;
	bh=9lqEmROsbqKZyvzHMCMNWcMLzjX5JVZuCL9aAlDS7sE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tK9qJwJ4GhNcKH5T4cRa7iajgO4hz9TB1ZGw/vJbOYr3TgDooL4pQYli8ybjP2lP1eXZ4UHj3r2lqbQ+hB9kHnrmAktaQYLRqSVpEcXAl13ONJco8MnXW1dUEta/2/OqGNKRpKkrneVSPpa5FH3vKCNvC4jFa19VJ0pmCjQVoo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpsz11t1750052214tcd086a9d
X-QQ-Originating-IP: J3QEyGLKZAKuZH1FHoIVLiSq+J/p0Z+zemEJF/rb2nM=
Received: from smtpclient.apple ( [36.152.24.169])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 16 Jun 2025 13:36:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10189126166806215705
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
In-Reply-To: <xmqqsek04id9.fsf@gitster.g>
Date: Mon, 16 Jun 2025 13:36:41 +0800
Cc: git@vger.kernel.org,
 ayu.chandekar@gmail.com,
 christian.couder@gmail.com,
 shyamthakkar001@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <191FDEFA-786C-4CD7-9D4F-06495FCBDDA6@smail.nju.edu.cn>
References: <20250612045905.3023227-1-502024330056@smail.nju.edu.cn>
 <20250614050331.304405-1-502024330056@smail.nju.edu.cn>
 <xmqqwm9d6gn0.fsf@gitster.g>
 <BE43915C-E780-4166-9C23-81F9A8CBDEDC@smail.nju.edu.cn>
 <xmqqsek04id9.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NHHBtKpbeb7pEm8CkaJiGXA619w3NcuUx5G7Kv0bJMLtvN014AJC43SZ
	LEP4HwXSeAKEu5/tAgMWIRZuZxzufjZ4KP/29V4YxgJDoJCvGOLVqcGqKni+uq9kUQLIapW
	ZuTvkUH9Yx7zruVz+CO/xajUNJDHzjBQPmfC5r/Wqgv7Mgaf08YyL0Vup5fbqGTtWGfn/Wj
	L4z1t/iXCYixAFV2VvLvNJ6n5sHKoxShCwkjP6NCmdH+zcCOE0hMDO3lliewkdkcLH33reT
	5KE+v9JaCkR+IlQe3oVD53H/fYQ25U5Cg9Ed9mOYEYsY5oPEdoTyMjkiLmyPmBsv8lVpdKp
	fPWXNiPrBKnxyPrA7K9DgYGA83xvC+9kpiyCOOmr1Ykwh1aq+gyjY0k+7H1GCzrGniconwt
	xQaBJceN7U7rqhpRXqBSjKEfgkT6tqlecJr+97P0eAPfuCI9StOWzxDbtDdRdiXI8++Qq1h
	HnsM81wq0uokKfvW7h4tsU05lkYE9+DnMK8tu0UGg+tqPL0B0Oi0BeN3WuRmBMNGN7ywtVB
	DQVZSmIVhOvAWvYuhEXrMgdYbFdg1ZLhUJyutp+LDqZ34mXneRVFYmDwAL8bE4WvVVoagFq
	0uKBIDC4+GDgdd1IuU+sISlFOgRdUOFDvL3I9gLYI8IPQ/qLxGL1MF7fmLlpUjOXGiDQIhO
	UboxsBMipM20yj0bzEcFiX0fAgtB1Y9ughqRXCh+u+A4gLCiLhvvw1n+i7SvUIMU30ZtCfr
	rh3wOi6DNOHJQtlR2xeFLsWCcjq2vG3qN5oxkjOWc3wTFpezphnnNk9XQPiMGzhABW/ydFU
	DmtRN8SzEudWSRC+eTQpa1LDa2VybCRi8N57/euVo2+5AV/oqLSDfIlIT0Hxr/rEYFQCNou
	FE6DrBNINEsQ0rteIqUoQocTY/5I6LRVYvY2Izj4P9/ceRp2Ix0dxCFYXKyXU3UllFdzcds
	BJHOLgVxtbnzoeAVQedyB0cZm8vFtV8QFKlMOK01tLFlXkM6NtnXbnaxIuA+1iAYarnnxbW
	1P1OdVOg==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Junio C Hamano <gitster@pobox.com> writes=EF=BC=9A
> e5b17bda (git: ensure correct git directory setup with -h,
> 2021-12-06) unfortunately moved lines around and made it look like
> the comment is about what happens when the if() condition holds, but
> if we look at the way how a9ca8a85 (builtins: print setup info if
> repo is found, 2010-11-26) initially placed this comment, we can see
> that this comment was to only explain the reason why we look at
> startup_info->have_repository there.  "Only if we know we have
> repository, do the trace_repo_setup() thing because that one calls
> get_git_dir() that would die otherwise" is what the comment wants to
> say, and if we revert the moving-line-around done by e5b17bda to
> recover the original layout in a9ca8a85, I think it is clear enough.

I=E2=80=99ve changed my mind. Layout like

	if (run_setup &&
		startup_info->have_repository) /* get_git_dir() may set =
up repo, avoid that */
		trace_repo_setup(repo);

Looks unbalanced, and git-clang-format tries to format this code
snippet into

	if (run_setup && startup_info->have_repository) /* get_git_dir() =
may set
							   up repo, =
avoid that
							 */

Which looks even worse, I will leave this comment intact.

Thanks,
Lidong

