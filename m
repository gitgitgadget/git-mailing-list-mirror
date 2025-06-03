Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4871F125B9
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 06:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748931784; cv=none; b=YsjZdcgpkd6YDK4pDIIgohTEzZiF2SRMbfdhhPcE/78rGfG95dYwgq0HuqBRVcFFu/GnrUom0nEtA234btCW1sLtCjkfCA+cfCHecVDtvO6Au9wMTl+6zTONnanS1O4zF7dSzDo7L41l9EZA4mZEUGE/yMTBbfqmcgXkMCfeDuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748931784; c=relaxed/simple;
	bh=bLklumOYaKtYw47bWp/sqlqXypLCR5LgXfwnI5/14aE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CodbY8cAJlAya/tnRtWB0W+fVNJBKh+HnNVSHuhLrRQPumpmZIIyPTF3qQNb0QL1vbu0UA9gOcXPkRfsqJJ2ArcHL4hT4LXW4FRHt5VvuUBcTz+2QZ45L4FbyPasb1wM6WK2SnDfl0V3CGblie0ucrylefNeueQYepHO/BvMZdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpgz6t1748931741t3edc2f9c
X-QQ-Originating-IP: UsdGkSFuNmq36wShTgQ8i1m7XtdyNHO/bK3XCKUUUcU=
Received: from smtpclient.apple ( [36.152.24.158])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Jun 2025 14:22:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8944345138388384496
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3] pack-bitmap: remove checks before bitmap_free
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <xmqq1ps1s698.fsf@gitster.g>
Date: Tue, 3 Jun 2025 14:22:09 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>,
 Eric Sunshine <sunshine@sunshineco.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0BFD6581-2BB9-439B-9837-767FA98900C5@smail.nju.edu.cn>
References: <pull.1977.v2.git.git.1748628846.gitgitgadget@gmail.com>
 <pull.1977.v3.git.git.1748915181113.gitgitgadget@gmail.com>
 <xmqq1ps1s698.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N0mS+7D7RQfjyfk76+YTZgQMVzQr/tA73RTZgxagEisuqjXYX4mm38x5
	jBGJEbRbdZDTAPz55/RFQTo6qKcOvg/hPO9G8kwRvCh7Ssbe10jy22M2fbbzg0UyTDd8kIs
	E0h9SKZxtV5KbwA5aOhwz+97LhavHVnA9oNtII74BtFDA0inysiCdXAnTxI/vkgre3c7VwR
	xMn1NAjvgL01C2d8fnY8Hlzi3yDj5TJKrH+h5JV+DancGd6nUq4EGKDKnNe0+x7NSyV/UBp
	oPZlppCETnZzW9BRQDy4m/FgvQjYhuc7crbTPmuXCwo1Df4XEDwwJcRtbGt3jgwp2y6y0GB
	t0oQvx8+NTjp+9WaVP5pYIL2t0KnP3sKbIhKniLarHPrtTpt+XZRhG00b1nBKSPBLOkfkOX
	LHRCkicvEv+SvTyHGpmLaUjfDpatyvF+ueUnx6/CvDSgMV2OetOG8iQHfPvp7FXJ8GiPXUM
	JaDUyCwB2qQeJrEPq7eNxLA22HhukJK0w36QdSq9WNZzCe6iEYgaI2Zk7Sfsur+XQdUVCKT
	TNSNcJkXDIg6Bj0+qYP4kyeawqI34p8ijaNpZsO1bDRxX48ghFhWgHzEAc9IIWczo3+vHN/
	cuy8auzbGGnq9OOY9NRHcMLITzG09hLXKHAtD7i/tM4kKJXT1Nig/vkQsauEzi3EWvW8oYk
	9cjljZK0WZXCQINyjQCVgnTTdlaqW6jH4cNr8ZSni8cEDRdyfETYDywjjm69nLFbC+JhEbn
	b68JyquvtHNbDgPsp6nMy1xx0w9WlBIDvh5BVg25IAREGIGUNwZ0GPumL06BTWv854M506Y
	06S/Chz4soRPHGCpXHeRBvwd+nnSoUfd1JamvjEG/eENc3/piDPGIEjOdaMWz4FZ8uDI6vm
	PQHBY+NLEG/sGutghgjdhjddHwbiQ6S4KYUG+Yf7Td0DGYLKen7rVOI3SdIpDrGRZABZdJR
	Aav8gMBNg/zGLcRwegy/rbMDtDNK6yrBN668PEeXQIWOx0vNQaxVAPwTMf9DcGlr1thDhup
	ZvtWiudUrVRZp/OoW3yIB6q1Yt+LM=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

2025=E5=B9=B46=E6=9C=883=E6=97=A5 14:12=EF=BC=8CJunio C Hamano =
<gitster@pobox.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> +test_expect_success 'use pseudo-merge in boundary traversal' '
>> + git init pseudo-merge-boundary-traversal &&
>> + (
>> + cd pseudo-merge-boundary-traversal &&
>> +
>> + git config bitmapPseudoMerge.test.pattern refs/ &&
>> + git config bitmapPseudoMerge.test.threshold now &&
>> + git config bitmapPseudoMerge.test.stableThreshold now &&
>=20
>=20
>> + GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=3D1 &&
>=20
> Either before or after that line, don't you need to=20
>=20
> export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL &&
>=20
> as well?
>=20
> And if the test passed without exporting the variable, is it really
> testing what we want to test?
>=20

Sorry about that. I should put =
GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL
In front of `git rev-list =E2=80=A6` so that when traverse bitmap it =
enters `pack-bitmap:find_boundary_objects()`.

>> + test_commit A &&
>> + git repack -adb &&
>> + test_commit B &&
>> +
>> + echo '1' >expect &&
>> + git rev-list --count --use-bitmap-index HEAD~1..HEAD >actual &&
>> + test_cmp expect actual
>> + )
>> +'
>> +
>> test_done
>>=20
>> base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
>=20

