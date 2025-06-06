Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9264E10E0
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 05:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749189024; cv=none; b=REWk/8mdCDPtP3OHDvbVWuWAM522xisEsry4CftVFzMQ5JGRc9oxl40glKTeKtZM3yTZ9ogdeEI0/jVSBt1/+qZKzCMW3yicWGMp8hBp3QyS3PQcLpwhAZIbWuTtEBksGOt6xsfyERvak5xBrGNcFtuoqqVR9lYeZPAGrhhTF7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749189024; c=relaxed/simple;
	bh=OnYzGyGgoh2neJFWCNoTsbQrkrRS7PwcHsOiqi4T+3w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RmDP1b4J/0adHdbRuqo1XuRgRXgc3vTIbFb5FFF1xdRIXL/Xy6XUAAgodBZeMIsA5pZgtaqFZv9C+cC+GRcGzaM6Hc0y92wsUhynnRjDVDe3ocK0KKMoODQD8rhs3/gMb2F/5/tQCbIHrih0aRp4WAmy3TSI1/4UQVD85JMXZCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpgz9t1749188974tb63ca647
X-QQ-Originating-IP: Fbjs77KZcH7FnQekzYrTw+YpcZK6QEySWHMzJK2/XTg=
Received: from smtpclient.apple ( [36.152.24.182])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Jun 2025 13:49:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12450379250851108544
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v6] pack-bitmap: remove checks before bitmap_free
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <xmqqplfh64lc.fsf@gitster.g>
Date: Fri, 6 Jun 2025 13:49:23 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Taylor Blau <me@ttaylorr.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E2C28248-2486-4E2A-846E-1C6233E7CE6A@smail.nju.edu.cn>
References: <pull.1977.v5.git.git.1749104667618.gitgitgadget@gmail.com>
 <pull.1977.v6.git.git.1749138820241.gitgitgadget@gmail.com>
 <xmqqplfh64lc.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NDtUtlvFer7vzFJn6YqnEUEfC6qt7tBD74FTMz4g5m08V7MEH1oH8LhB
	pa3ZVVkr+XT/tGPBHubOjqTqm46lXLg5RdfOMqwNryjtEXK9NX7kb7Ozjubk4kqzMYOepuq
	kstoabZG4iXLS42LuCepso6SkHxcrZbYZ0v+IRlR+BlC2uqB4BMngeGSgi29YhRA92CA/RZ
	FL9lF8yiU0zeof04iuS661df84WHd3LJcGehCY4vYmoRFDykNxfGEICvQll3w4fnN3YdnjM
	xkG3keZZ0y8JdGw3VT/yKQHDKURMkUteKwbzRCxwILTmpycfJV4CdDoPl5l1u7IpHO1PXLd
	YV46E4z+CZr1V6BICJj938EKicTkaP/iRuv0PBAkk+/e+o8A4F0Oy+P4kFcf4LvGh81cfZc
	N/mDLg/Pou7fwdSA+cJpkouiLtE+up4qdmaNYLX833iXf1Bztd3KpoowUe7G+jzI8y20eo6
	RvK3Pn+BEr02wEikFoqQh1ehLXEKvHpFZlAbOkgfmrGZk+If+Np0U+AWY5fbx9HZZK3nAdD
	IMEbeCDHV1fwwZ4KCXlmWoNAK1aPwosh6TzCP1lJPp7SeE6JzONVV3cgjewmNP6HS1VjSyT
	nAyIyHhn7LM9a1boLfnDBoWPwGQrV093z2tLzRRhWA2m4KyCmf9vw65ITCw7fTpbRQ17Olw
	eaboRbHPkCqCcXdQW5D6d3VgqfZe8FM/+TAJ6v3i8FiWTtjab8teOXKNu1elaW0XFtP44qR
	mSJMmqMQhkv3VDEIHExQYd3pM9O1KG4siz7Oe0HmdXhxvbXisex+aSBl+hqf2Qn3rpeNMCV
	Sr70Tz7ymNPJVxV2PKjfQrdyzsQKQHoACDxU/W+KwjkQep0efXXA8oTWhtL5S4rFDZTjG0D
	TXBabjMC9KKeKW47NO0ZTcYR/C7ovisk87TP3FoGyUgQDl0TL2QQvF25atsiGhbj70vEqmK
	kndPX5Zff8NPxeHn0WwoqRyro1xMtjL4LTOgyI0DjRIFm+cVCoXsu2WgS
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

2025=E5=B9=B46=E6=9C=886=E6=97=A5 09:28=EF=BC=8CJunio C Hamano =
<gitster@pobox.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>>=20
>> In pack-bitmap.c:find_boundary_objects(), the roots_bitmap is only =
freed
>> if cascade_pseudo_merges_1() fails. Since cascade_pseudo_merges_1() =
only
>> use roots_bitmap as a mutable reference but not takes roots_bitmap's
>> ownership.
>=20
> Sorry but I cannot parse the last sentence above.  I would have
> expected that "Since/Because X" to be followed by comma and a
> sentence that describes the consequence of X.  Also "but not takes"
> -> "but does not take", probably.


You are right, I should use a grammar checker (chatgpt) on my log =
message.
How about
=E2=80=9C
Since cascade_pseudo_merges_1() only
use roots_bitmap as a mutable reference but not takes roots_bitmap's
ownership. Once cascade_pseudo_merges_1() succeeds, roots_bitmap leaks.
=E2=80=9D
->
=E2=80=9C
However, cascade_pseudo_merges_1() uses roots_bitmap as a=20
mutable reference without taking ownership of it. As a result, if=20
cascade_pseudo_merges_1() succeeds, roots_bitmap is leaked.
=E2=80=9D=
