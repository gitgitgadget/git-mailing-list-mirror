Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCB3349B00
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 23:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772580566; cv=pass; b=ZOrXSVzxA085SAvbuWQORDfSLkV7RMMPrydknEWnWgCrFg6QnXKWTfTJNDA/iFXVSjaR6m/cHvT/nchKOB5MsXnoFDoG2LQU/eV6ryyDqnC1kWTgqp48nDyCOLGhy7z3r04NSOEUaqNA5GE3PTKSMSqYWNkjtJxkYxanIKDd694=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772580566; c=relaxed/simple;
	bh=esJ+fS9HuZii79O6e1vhoaaRGpWGL4nlTUrOifrurgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFYiU8/iBYakENsCih+GxBtmj2b0gp62Cg6jyTB/SF+TaUptMX9iYpzmnGZoHgss6X8NK9SbRfYx08sO0noj+NB+sPktHKpsqgjhDZmoZ3w2r5rABCleQVzR87efyrjfmNwaEknOjWiWmuVvQj2vSpInWBnA2JVi3trsgk2CJE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ihqSzk6k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dB/e6Pa9; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ihqSzk6k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dB/e6Pa9"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623HBJZh2786792
	for <git@vger.kernel.org>; Tue, 3 Mar 2026 23:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2pEaDOQQ8erMx8snhDuJ4jZuS1rvv6+eOHTybgyW2Po=; b=ihqSzk6kiu1liMm/
	ITINBSmsZd4x5cYwcXM1NEHn6A4x/BzekyJ8iPPukDybmq8GjOowOO4Y2PEQnnxz
	EanU1OQP0NmKrdVA1yIK8B31+RnArMQyE6nRwyrlR+y6vcCrBHvJPOoQJdqT7K4w
	orfn2Jm3NARx1jgZkgBxAqeKdnyeNe7UJiAFzCgJZpraUh566eojaKPRfNm2HZck
	cGBdhkypQnpugB/tM3Xmydj1TB+288FNajV4hbxFHxzaGB/b7+GyK83a8dsllKMP
	g/ATLns/V1vHX9no9dTcUo0pGtt3rDNQDZq9aanVZJ0YrCgda7BNQA+mjvHuLXeW
	8auH4w==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp3tvh85y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 03 Mar 2026 23:29:24 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-64ca99235cdso9294449d50.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 15:29:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772580564; cv=none;
        d=google.com; s=arc-20240605;
        b=SK0MjCucxqNCibFr8KIl56W1SwOOR661CS+sgynHEvnNc2oVeuSDPgC8LH+rVB8XIC
         aPBbDk+f7pyctkMjoxV8z6ZtsbnlP3ml8x4uzi8dKsELH9OwguD9ZLUVB58JfDFaCON0
         uVo9mGM84dvMeJ7UUxeVFNhBI3YdFzzID0PlWQku0uxK1NCH/Mr6ojUP6oQ9lgsIepp+
         5g+DZci1Dxgo/VS1FAWbncVhCfumORx7SfYds1/AlTFG9b0xCtG2cYejL8efXI3Pwnhm
         JdsZD076lO9qPltiWIaBMz/Vj7ve+XQcaeJvm1rOQ7A8CT/Zb+Ub/qrtByg+AwSxsMBo
         22MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2pEaDOQQ8erMx8snhDuJ4jZuS1rvv6+eOHTybgyW2Po=;
        fh=34fN1F1Vi9HSO4eloA9+NrC7PJswblESbBKqTZRWYx4=;
        b=PkRwi/vNpFQJwYBifIjsSwloLdftm2zCcjenrcSXioYm+TTAteGlyY1oqOOa07oKD0
         /WPIW9Pg9FH7KecGroTapsJZLS4fa7V8Hc1bewfmNUOA6UGUuymrVNE9vUkG39/DTlUc
         jynVWsnMh9iUp3UDKgi50ILDkk8/g2gZkceQEczB5J4VORcZqXJdzv5kFJ1d4KaDA32h
         oDp0alTQxqYYESTzS4b1SW3kDHn/j4AHiYQodNrHJbhaHENFPRYWhADMxnc7r+yy+Xm7
         o4XM7X95LQ7dkcvkPlCQ2BzTQY1WKKKSe/xioVy6g6pVgHKI3jAl/DU5Kg12ka+ERaQ/
         OaWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772580564; x=1773185364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pEaDOQQ8erMx8snhDuJ4jZuS1rvv6+eOHTybgyW2Po=;
        b=dB/e6Pa92LcgmPcM5oG3DX5rzd8Rv3r3HoSPl2eSfyTZl7l3GRnVdmUE+/3XJ9jYsS
         QwTatx6nCZ+kGklrjoJkGHHsog/jfUVeX7EXq/wbcJ0qgMs4L4QIszeI/pIc4SntPd1t
         VAtnZo2955sbp7ty3lG1JeEckYqwlHBECCuxLJtOPp8Wvk3hoI5ucn7e+ZHFemcz9Tzd
         pG2Q7d4uKguDaHnkZHe4CjriAAVD4Wkc37b4U+G9wbeNqSZvTPQcPC9M2rcW3updH0FV
         /npV1yyhg7AxSldwFifrGrCjDREYSKPAUpIQJ2XLZR/qCaV92JQKOx/jUm6f9Pg7OPAD
         pXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772580564; x=1773185364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2pEaDOQQ8erMx8snhDuJ4jZuS1rvv6+eOHTybgyW2Po=;
        b=mbqUHPqKEp1Q75UFvDr8Ti/C7RVzOfwFthDlVmkIkRCs2ScQki1wdOoBZre4tP1pqw
         /d5ySDpLu/pYqr9fCsNPgvrO0x4mtBnTu3+tUL6wymbR7Lp76anhnceMYnT9It+5EBsi
         d7sI12/Tb3uIByuYIBdB3GacQn1hrczvzvP1aac8O6z5Ze03slaD6JBOllhZ0q5A+FD6
         FEchTl75VHwrsu/r5KATduF7ZuVDfbqLQfkJeOK7VNPKNztKHtLEfIq8emqLs31Phf2X
         /ydnEgJoMWd8DNhW9Uo1IH0Asu5t6fsRr7FnWdXsUgXcilzs2IU9P8Ord7hDjMOd3SZg
         Uirw==
X-Forwarded-Encrypted: i=1; AJvYcCUQJgJGdoqdE3OcGisy6AiPcsKE7ZQdAOGHolxZqMdf3xz4S93oj5i4a32shBe/N1w5mN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMKKrJB8vrMbxuo5M6TUa+imhdj/75Bp3wzMMqlK2a0taRgvjJ
	z73VbKPfmZ+C+9FhhmxcSNf9ZNtGUDTfWYJpKJDWLrE+7yHuzZiSALTvY2hzDSoPv27cYct98GF
	gsVbkQ+z6qKKtkK6M87mQeCpDMkGjcyX+3cJrk1nzcpqOwvuJTJmNuTAJtHaX1hN17WNfRzq0m9
	D+ThFZzahJx1aii/YlzlFrBbXlzjZH7Q==
X-Gm-Gg: ATEYQzxLFLbdL7NWX2TgF8I2flPKcBNM9885YTrp/XbEAMI166Q/8ZpsOwPC6u84VPz
	LeIxWsStrdAxhG6+8Wa+KCpQ5mAV7W6sAVMXp+4eAqTlr5tchU8tJt1L151xek1Az2Qlp/zALdH
	FTDVcEUePs2R00MJEvZhTYmndMPDTQaeMQdFQi+fqgB7GVRQrt7HhzRjDXNQsT2A9RcbgQ8nRWR
	rsMmAo=
X-Received: by 2002:a05:690e:1a52:b0:649:c7dd:d2f7 with SMTP id 956f58d0204a3-64cfa0561a4mr141962d50.87.1772580563949;
        Tue, 03 Mar 2026 15:29:23 -0800 (PST)
X-Received: by 2002:a05:690e:1a52:b0:649:c7dd:d2f7 with SMTP id
 956f58d0204a3-64cfa0561a4mr141951d50.87.1772580563588; Tue, 03 Mar 2026
 15:29:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301025327.3845292-1-nasser.grainawi@oss.qualcomm.com>
 <20260303200906.4118348-1-nasser.grainawi@oss.qualcomm.com>
 <2e62dc94-b821-4815-8dd2-f806580d2027@ramsayjones.plus.com> <xmqqms0obo5s.fsf@gitster.g>
In-Reply-To: <xmqqms0obo5s.fsf@gitster.g>
From: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
Date: Tue, 3 Mar 2026 16:29:13 -0700
X-Gm-Features: AaiRm52eTgW_Pd9goEq8H3Nkcd6EZBPrFpqtpGwOnnOZYFqSTzAj9tIdNHvjeyA
Message-ID: <CAFcKa=_Ovs8bZmx8K4VFYKgV-_sDTWMsaCmQCC8J0LAEGTg9vA@mail.gmail.com>
Subject: Re: [PATCH v5] submodule: fetch missing objects from default remote
To: Junio C Hamano <gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
        "D. Ben Knoble" <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE5MyBTYWx0ZWRfX1I0uuJ6J5Iu2
 rNokaUcyowey4J2NxRYIQoYGRhGIX/on4/VWbMMb1w4JoByY3i77iygkcihCrkcqM3ZwZtj+8qp
 BMTuMukIo+KZ+C7NWnkjcPnjEyLofRbaDQXLhRgp9gY7jXUeETs4dv6vunxRSmrUNivtjjvTTQY
 yCsxz72hhBoXNyDq/vYWHJeaOZF9CaOGJtSibGuOXp/tPhF1mzhL8h8xg26Ka5rgt3ztdWBFiQZ
 1HWRLvWrQgACIsACH15qMnzKrjWObqisZilaekP4hVxgrlWpfT4gMyGdRueqniCFcluqocm7XNW
 jBliCt2+IFSZJATUK2uJ5IZWyPw90oJ0q7aeGJX52a1LJNUGrSWmDLW86FffsbMeC6QJGuRUIQT
 J0vox7vMqlHqqrEVFvFjm+VGjsasNPvUsH//GqoSQsdqiwQC1qFu7ohWVGKZNXn+lDNXRflr95S
 l5kB6tRuwkUiDOCiSjg==
X-Authority-Analysis: v=2.4 cv=VYv6/Vp9 c=1 sm=1 tr=0 ts=69a76ed4 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=ybZZDoGAAAAA:8 a=EBOSESyhAAAA:8
 a=Drkh5fC5HhFBoS8f7C8A:9 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-Proofpoint-GUID: 31sqmlnqJvQUPDYszaoB-bef1JT3ZMR1
X-Proofpoint-ORIG-GUID: 31sqmlnqJvQUPDYszaoB-bef1JT3ZMR1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030193

On Tue, Mar 3, 2026 at 2:26=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>
> >   + diff -u expect_fetch_custom actual_fetch_warnings_removed
> >   --- expect_fetch_custom 2026-03-03 20:35:13.949600802 +0000
> >   +++ actual_fetch_warnings_removed       2026-03-03 20:35:14.150601532=
 +0000
> >   @@ -4,9 +4,9 @@
> >    Fetching submodule sub1/subdir/deepsubmodule
> >    Fetching submodule submodule
> >    Fetching submodule submodule/subdir/deepsubmodule
> >   -From /home/ramsay/git/t/trash directory.t5526-fetch-submodules.stres=
s-5/./sub1
> >   - * branch            43c17d99ab9d4fcabf7107e36660b27113b54663 -> FET=
CH_HEAD
> >   -Fetching submodule sub1/subdir/deepsubmodule
> >    From /home/ramsay/git/t/trash directory.t5526-fetch-submodules.stres=
s-5/submodule
> >     * branch            e38933e027ee8a2000f603124aa899302a09a51f -> FET=
CH_HEAD
> >    Fetching submodule submodule/subdir/deepsubmodule
> >   +From /home/ramsay/git/t/trash directory.t5526-fetch-submodules.stres=
s-5/./sub1
> >   + * branch            43c17d99ab9d4fcabf7107e36660b27113b54663 -> FET=
CH_HEAD
> >   +Fetching submodule sub1/subdir/deepsubmodule
> >   error: last command exited with $?=3D1
> >   not ok 44 - fetch new submodule commits on-demand outside standard re=
fspec with custom remote name
> >
> >   ...
> >
> >   $
> >
> > From which I guess that the order of the output is somewhat unpredictab=
le.
> >
> > Also, other test files in that patch didn't fail for me with 'make test=
', but it
> > could be possible that they are also flaky. I didn't look.
>
> Ah, looks like the command tries to fetch from multiple places in
> parallel and it is up to the luck which one reports its result
> first?  We probably do not want such a "human readable progress
> output should look exactly like this" test.
>
> Thanks for reporting.

Yes, thank you. I'll drop that part of the test and just keep the
GIT_TRACE check.
