Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575D02A1B2
	for <git@vger.kernel.org>; Sat, 31 May 2025 03:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748661539; cv=none; b=V4Qjyp9DQgSnmJfTdfb19YsLdtYTDRshCxelx9LbWAGecDluslzfUYdgBmSrAGkWHiIEFb/X013I6XYLRKQWVa/KGbm5xW/JOBrYtF4aBg/MmPQ/7U2HjKtXtGWwnagdXTRhT/xUgwGJquSeiSTTfRDtqPUlPtu5mHuH3QEgPJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748661539; c=relaxed/simple;
	bh=EGNUz9ZfkwAxdiz4v2v3gycQZay6dS/57Z8fufEqnVk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BzkEzZxcRz7wwnXD4jQ9hbSBHOyJ8l5Tri8Dnd1jny22H6cvOaSGgzT28g32QwrXBcPgmBiKTjHaPIlGEAyuC26Si8jMFLj/zFyjyYBeFhdY2y92+U3YNnJbOZr6A1hy4ztF9PvoZC0FG6LcgeZOQvRw70P2DnveX0uVEFwuf/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpsz5t1748661499t16b8d3a9
X-QQ-Originating-IP: zc8DcusQIjd88ORDjNHL9XBfcGDvI4i7uYDMgPLNd2M=
Received: from smtpclient.apple ( [202.119.42.69])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 31 May 2025 11:18:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9556857484843882164
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 2/2] t5333: test memory leak when use pseudo-merge in
 boundary traversal
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <CAPig+cSv8ADqERwZBZ_7OXnedGPR_iwRa0Z-NtEBHxS2Zc8EjQ@mail.gmail.com>
Date: Sat, 31 May 2025 11:18:07 +0800
Cc: Junio C Hamano <gitster@pobox.com>,
 Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E2FF23EF-004D-45CC-85CD-5FDB1E375213@smail.nju.edu.cn>
References: <pull.1977.git.git.1748149783383.gitgitgadget@gmail.com>
 <pull.1977.v2.git.git.1748628846.gitgitgadget@gmail.com>
 <56b24d681cbcedaf5c03c89eee582d554a0894b7.1748628847.git.gitgitgadget@gmail.com>
 <xmqqa56tepx8.fsf@gitster.g>
 <CAPig+cSv8ADqERwZBZ_7OXnedGPR_iwRa0Z-NtEBHxS2Zc8EjQ@mail.gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MxHu/stL3hVPaVvLUWUi0qMfcQwZeZgi5Wc2EwXTrk9LJZwO2VQ7frQT
	b4KUHiXzAKMfWz+0KmDzfx6jbiKVCS9l4LlihyLeWDBOvhYbUtFveMHiw5i8Za1SBsEpfyY
	N2pIRwSV5hkAPlocCk3lJzcPAR+l0/F39Mu59E7AcF3v2LWTtd6fJYyNljsaCvekL+8Qf3P
	XAmntBQOuFGZJ4MJWrJlsSyl6etSZPH60G21R/YupAAqLFA8ESA8EyDKti7l/nYF1ceaEYJ
	J3aKd7TzaTZgboAcJ83TLTGAkjjCdXmJPDMyH+uFCca2KZMpexHpxhf1F2vZ+3ASpkadX+q
	WwLtIFg13DX6R3kLgjlPTN9WjnlQeQpMeRS0XmYQaHB7DJ8p/JQFJ0SzQ7KNchNDKTh7mjE
	TDVyxlgzT197Vk5pUDKgpHD7m+9yyBfAgCud4qeznUnhrrnTSQzDqIcCWlweypPGLxC4L5F
	pMPAlj4gzChQiDkxue+Hf53wQtSpkPAoHbMDly17jqrD4rDE7i3QIJGw8C+b+nrkDAznpFy
	wJaeCYaVNQTa8e5lHCmXzbr2WPupYlkCS9rk45JKwrf7dPLoQl0XUQsiFYRhnR45woXZKBM
	n/71RySZsJb+Nzw3MYVHiBntS20nvqBXsJIY+1wah+blSUzzh/bndwuhfD3mzBP22JATdXP
	HqN8TWbGuLAALkXfFoiLb5gmYGKaREFWIVe8O0WnxWfh3pO6Xy1pjC807MrBpYB4ESVqKs7
	hBU9oGgpkZmwH7zAUceUFMAS+qT9bn2cNdYedh263oyrRwF9+G72/R79EAS2WagBdTdil2A
	yPdAvcnaHMMisa+RvvXN34UOl4qYmEtfDwM61ZDm29EODv06zYutIgoZuLtSS+cxjAevkVI
	8wvZR2i6dpyep/OhiqHZe7KD+xu1xn37pGTQ/q7ajoewNjSyB2UiJs2ATCmsMTY7fOoF3BM
	FsrwB7eDRvJ+S0u0Eq4gCFqj3Uru8MJkCpw05YwQ/p/aqNA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

2025=E5=B9=B45=E6=9C=8831=E6=97=A5 05:50=EF=BC=8CEric Sunshine =
<sunshine@sunshineco.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, May 30, 2025 at 5:42=E2=80=AFPM Junio C Hamano =
<gitster@pobox.com> wrote:
>> "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>> +             export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=3D1 =
&&
>>=20
>> The test linter complains on this line for me, it seems.
>=20
> To provide a bit more context:
>=20
>    % (cd t && make test-lint-shell-syntax)

Thanks, I should run this before submit.

>=20
> tells you that `export FOO=3Dbar` is not portable and that it should
> instead be written as:
>=20
>    FOO=3Dbar &&
>    export FOO &&
>=20

