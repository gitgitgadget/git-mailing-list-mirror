Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8F925D1FC
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 05:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749535178; cv=none; b=i8/nTHin7qJ+25jOMVMzBufAaZC+Xy0LZ2OQebBNuJZixmn/jzchMbCR7AIlYXSa38dUPMBlf0CKHQQY0N/4qO2oUIXHpAiWPtU1GXeXB2triNym4s57GZF1VmpjkR5JBQZpGIYxQczHo8Tr6coUBnRfRqDen8PQWJA9cSf/xH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749535178; c=relaxed/simple;
	bh=FAB6wGJrtKY4ZqnTkH8Q9G+0RJ7VI6VR2P5ZYwSy8EA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KjKtwpJwWVqUxOJhJUlfpX5kqSSDizU+ECCcveJmWOKbs6HmvCbVLbioDXmMYkU7oahBMEqFlEMSima6fLtrkj3nFAorJmLDnME3aJxtuUjaajEuYDov6nLbRIco3ZyZuAuwL5jIgCAc9G6NBNNIQbeUQUmjh8Evc6RBZvINXHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpsz3t1749535126t9e737f8d
X-QQ-Originating-IP: nR/sxoi1W6mMeh7vUA4L/VZKa3nAT9O+9QU67PmClTU=
Received: from smtpclient.apple ( [36.152.24.134])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Jun 2025 13:58:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17598127312227430642
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v5] pack-bitmap: remove checks before bitmap_free
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <xmqqldq69phe.fsf@gitster.g>
Date: Tue, 10 Jun 2025 13:58:39 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Taylor Blau <me@ttaylorr.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5AA8E9CD-15C6-4707-9E3A-ACBE0C24184B@smail.nju.edu.cn>
References: <pull.1977.v4.git.git.1748931650166.gitgitgadget@gmail.com>
 <pull.1977.v5.git.git.1749104667618.gitgitgadget@gmail.com>
 <xmqqldq69phe.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Nw0kbJRYVDDK8lLE36c3jF9RszPFtoS1inrztDRiBTNzTNxpPD7AoVHB
	bsr0DCW6Oo2WhLmVndw6y7K2vrbcnueMen1vzb5HtFWP3zk2NDxzVJbZORFF7ZqPyU+fHcT
	I+Dsra6Nl9UI5KnWf/jChaSSgk1tvS1O+Lv9+LaM2GxHKkDZA9MIqfgkNtY1pLIERoqfEo5
	3G7Hvt5Opa39U+IaN10wyzmjgHKsTCk06BkSOvDfLMnjf8ECaqitXmm8s28xtrVRbVV41HT
	UtuwEa91X2jgSBowmIgSiTKoHdHK/MZ1M9VtjglImIHmDW1pkdx3EQG2U4+iCY/lwakRuUN
	L19ca0KzYlzZoelyQTv87EjPClQZL+LROJw4PTBaCEjY3ZvtYYwygi91JCXemZj+Y9IMfpM
	uMAlzzvzL6dfr84T9dUNUxRCG1l8c+HD7X2mT5dF62bd3D7VXEM3HVqz1WGXqRr5v3nq1JI
	qZ6os4ShCwDXyWR6doVJX26qcmWSCylSHSbIfZ8Ru2sdXxtoUGgj3ShmPwO7d9Xe7ggcw/5
	xf9YtNIziUkOEd9l8wBZlqE2TYyptrkMBxJHbEB4m/T2xKykDNIWmhqZ5ZbrsG/VhmtURet
	SF4C0wU5zQLQPTXAxSwxw2xOmoHRMYaStfiCvC9F24sK9Ftt3ocPTTpckKyaj5xLugpm3Cc
	/dtznJoGEQM50sk8G4kwmSOJtF3VGJHAaMZtpW3/Uanm9S2sNV/0Uu0ByL82EfahfFy/nIy
	rf2pb0EfshQy4M+tfPZgvwVNualgkj9MhoRIh31Aezd69rcM2e4HG26VVaP+2JHYJ9tHNMw
	YLb3szqHO7rI9ptoLA7wm5yY8uWLAVUv96Acf4iUkI6Bp36GboYTDHSwUGCwpWe9I7kjkYM
	H5mSHA0M5g6z85TBmTSW1DKz75eCOlmzpCbUDiEQKOuG2VrmzJPUuhcnuA0rrlRBVEE6qd4
	wrF8AOhmw3+KDvLVRcJaqoKTv0p0xyPVr8Ssv3jaIMXjCCRugXC86wBb6zI7vXuhyw1E=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Junio C Hamano <gitster@pobox.com> =E5=86=99=E9=81=93=EF=BC=9A
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
>> ownership. Once cascade_pseudo_merges_1 succeed(), roots_bitmap =
leaks.
>=20
> "Once cascade_pseudo_merges_1() succeeds", perhaps?
>=20
>> And this leak currently lacks a dedicated test to detect it.
>>=20
>> To fix this leak, remove if cascade_pseudo_merges_1() succeed check =
and
>> always calling bitmap_free(roots_bitmap);
>>=20
>> To trigger this leak, we need roots_bitmap contains at least one =
pseudo
>> merge.
>=20
> "contains" -> "that contains"?
>=20
>> diff --git a/pack-bitmap.c b/pack-bitmap.c
>> index ac6d62b980c..8727f316de9 100644
>> --- a/pack-bitmap.c
>> +++ b/pack-bitmap.c
>> @@ -1363,8 +1363,8 @@ static struct bitmap =
*find_boundary_objects(struct bitmap_index *bitmap_git,
>> bitmap_set(roots_bitmap, pos);
>> }
>>=20
>> - if (!cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap))
>> - bitmap_free(roots_bitmap);
>> + cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap);
>> + bitmap_free(roots_bitmap);
>=20
> This makes it as if the original _wanted_ to leak it when the call
> failed.  Readers may wonder how we got into this state in the first
> place.  Was it a simple thinko when 11d45a6e (pack-bitmap.c: use
> pseudo-merges during traversal, 2024-05-23) was written, I have to
> wonder.

I think this was a simple thinko, similar to "we need to free resources =
if
something fails. Since cascade_pseudo_merges_1() fails, we need to free =
roots_bitmap=E2=80=9D.
In commit 55e563a (pseudo-merge: fix various memory leaks, 2024-09-30),
Patrick fixed a similar leak in find_objects(). However, since t5333 =
doesn=E2=80=99t
test boundary traversal, the leak in find_boundary_objects() remains =
unresolved.

