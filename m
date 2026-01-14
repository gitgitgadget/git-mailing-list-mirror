Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B14329E6A
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768418603; cv=none; b=NgGDvE6qCU/gkL3t1rUp8Qycuy7LTAbRDdWYHLGjK8M6/S1jTuXRDWxZofYO9qwLY2lzfKT3nrJfeV4WxINNNZMlfMA8u2zkgzQALxFpKibik7mveW8B0ALfln+Fui5RzH7fw26B26MrjRjT5Oa1Y09WTxkth4/Y1gybGoQAQQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768418603; c=relaxed/simple;
	bh=hC3yHW/k61oUcnbXIyCBW6/XLwmpf1v7VRc2xeexKqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWTbL4q5pTgf0FkpHJ+I1fNzNZ5xZRgS2Fw99ztmUUyboVCduVITnnalN8llyBUHVelrc4/lMoVkRg/3KKTeMHfvss0Dfu8dkKVSrFC1Kn2SSHR8+jPTKut0y/e/micF8QniKkAMSa9gpchR2B5SCNIglC2NCbCvXBqxdSr4MeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QptHgdXS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eZHi4L2y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QptHgdXS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eZHi4L2y"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60ECriVX2735988
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hC3yHW/k61oUcnbXIyCBW6/XLwmpf1v7VRc2xeexKqA=; b=QptHgdXSGqOaPLzS
	ZSiyKRyDSC00A6eERgJKPoxHEgsJ0pHEKvpzhZSPOun6rkf90Lj45q4RrKa7RllN
	74ZrHMFtMs7J4ITHCnrVRoxpezJmrmfKBXoQB/bTu2HLq5SSs5wcMiOsaZ89+mEl
	9jqHQiILBZFO0yg4OoS+ak8v2iPkV+FofivLc1uG6ZaYMrkIKJg9rdPcPWluLUNw
	6UfJMtRuON1PhSV54X+F87WNeGWcg/qJ6K3E6ixZ/kJP/4iswzNuaf6ZvByu2N7F
	VfhnRW6+HoQntHJZKEO3NhIvJIr6fdWsK2j7LW/nIMTy6UNdnT9lSHDo1gTw8iKw
	aFJU6Q==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bpbj5hcgm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:23:20 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-6445cf02fcbso127980d50.2
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 11:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768418600; x=1769023400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hC3yHW/k61oUcnbXIyCBW6/XLwmpf1v7VRc2xeexKqA=;
        b=eZHi4L2ykIRVxw8VOhMke3ttzfy/Ll0dZC0NF1o7ExGxTWngoimZL4SOQzQL9AZxi7
         YKYK5L20CIpZ6+kxbd9aMXYsxNcE02WRJAXBAEai4GiD1mdqfBJeiaXoIM/L0SmzEabr
         Qbe21xkQlH63zrifHnFJ9sLZgUrIjkylARQM2tXCJuVRZUJg47GKHlhl0q9lyX1UFneX
         tJ/hi6gItIkvdozIAnFE8D2dko4tQpuXz56T1Wrhw3VEqnjljrIAxR6Oh4oo6aXoPsY3
         QCxVaJaAwg9CCMgWH0LSBpp1oDiUOg9J25FpSZXpgVaiJlNNo58lNnlaCA33A7wgdCL9
         WlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768418600; x=1769023400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hC3yHW/k61oUcnbXIyCBW6/XLwmpf1v7VRc2xeexKqA=;
        b=IdkhchxhLiymTEFjhNpzIwB8W/7hshyHi9Cpnh9mNphe5KpG8Uh97eevLMG1OyFUDY
         GtsZi7xe3e91rhjngaW+ZCR6DI1xbB3FDCd8LZTuVtaaMeT9XGPi9tT9F15YjAB9VYf2
         O2Fq/I8aYbhJkX/cm5bViWaWvnoh658LdIie2xaZB494+jDB+KqOxOgNgwNsvRM1iCRJ
         nriaGbzE586XmYPOLOxkNqQS3HsiFVD4tJcdtoGpXygG17aLD4U00MxSD86ydrzBjeAz
         XI3u9xS1pqeglqpQ/7tvF1lNro7gNLjTCukRqnEAVAvlnL7sKg6Nu8QSDxpHtPXE1pVU
         gdQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuEe0fL4JJFb7NcMcqLVN4Vhvtx+05E1d/xJUcuIk+128P9zGiNdcoWOY5UGCt5doRW/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5N3L9ic8ZpcrWyZenDuuBxFOIwkF9VOU6IlrDtzJvF/IVIVTw
	CbEAyG7N7jFym5gdpgKe7BVfQzjVwCaZTGvSm1MwtKw5DE0VKaya90uGbvY3hUjct9ZEFOSl+y6
	pnKGl/YqtgkInLqVc1zvf+cPofN8J15fze0XWcAiF0AkY56r4zt/wkuVGf3pFo80Q6lzUBg1qi5
	zXb6RwTRrvipmfWLxbS8g941AW4ePOow==
X-Gm-Gg: AY/fxX7//X2ah76kJjCy+AFBDaDbeaL5j0nzh/GkWfjv4d8IaOfezcAP06vNnFLEbXi
	+XXn3KOuUzzvhkIKvppNXhoh9kkHnbZfCAWeHagqsfK0RGAsVDLeUS0UKi1OdrMF4/U4LEP8Mt+
	9kHCg2Wx7shJXlUEpi/hK99P0LqA44WlCrckYEM9Hx6h8ekIEW82S4M6cYibIPL/tCSBM=
X-Received: by 2002:a05:690c:39a:b0:783:6f8d:e7a6 with SMTP id 00721157ae682-793a1d87aefmr67776647b3.51.1768418600312;
        Wed, 14 Jan 2026 11:23:20 -0800 (PST)
X-Received: by 2002:a05:690c:39a:b0:783:6f8d:e7a6 with SMTP id
 00721157ae682-793a1d87aefmr67776197b3.51.1768418599776; Wed, 14 Jan 2026
 11:23:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112213612.2761854-1-nasser.grainawi@oss.qualcomm.com>
 <7FB6BFD0-4C54-4924-851E-D4B5C574D7FC@gmail.com> <xmqqqzrsguh5.fsf@gitster.g>
In-Reply-To: <xmqqqzrsguh5.fsf@gitster.g>
From: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 12:23:08 -0700
X-Gm-Features: AZwV_QgG4nXT24J82uMXsVL0zVTHFw_NcJaXdYTyMTQLMLTOBMeHrzPpP9L9uD0
Message-ID: <CAFcKa=8RNxQz--RwLiopuQb9_Fy-jx64ya9vcA1ygcPyYswJ_w@mail.gmail.com>
Subject: Re: [PATCH] Fetch missing submodule objects from default remote
To: Junio C Hamano <gitster@pobox.com>
Cc: Ben Knoble <ben.knoble@gmail.com>, git@vger.kernel.org,
        Patrick Steinhardt <ps@pks.im>, Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE2MSBTYWx0ZWRfX/cp5bwp4e43K
 BVJFVbwHcqrouY8Bo5NTB2jF3vtQzqP6dodh1aeYxuPU3hhbadvaw+lkOlnKFYdfn1L6j2Z52Eh
 g7Cag79fgfO1MRMoC/cO7CVFKCQKOGKaDMf3j8SsyFnpyijnSP6xn+nvyCYrn3wSRWYan/RunqG
 nAft13ZQN+AcUV91/yiCvZU/YGkmiD+pOn5OlTPZYYUUt6llvKNZZcLs0fU7nvBk9XvvK6DJGJQ
 guQZUTNOYc500kTefnx0/0pybVeYzv6TNxmHC17gUxzUudRXHgE8Wo5g2VhQlSg0O+ZomMkPIej
 SwMVg7BXdhBvttetihpTKFTk3YyiV7FA+F7IWNgeZ5i64NBYAFXzScqYEKHv2YPbBdeS6pOAM+Z
 bvML2ggS2uX2GXoiF89KApZRVkdHrG6udM9hz2G1AOMEsAiAifenOwKESXJNIDzjSps48K+7k+f
 R1ewObaSYZvqqpqHxhg==
X-Proofpoint-ORIG-GUID: 6IlyeP551AwXfvYXx9nKzL-n6bMY6xz_
X-Proofpoint-GUID: 6IlyeP551AwXfvYXx9nKzL-n6bMY6xz_
X-Authority-Analysis: v=2.4 cv=aapsXBot c=1 sm=1 tr=0 ts=6967ed28 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=ybZZDoGAAAAA:8
 a=Oxbu_6LmIt5bKB0bthMA:9 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
 a=0RhZnL1DYvcuLYC8JZ5M:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_06,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601140161

On Wed, Jan 14, 2026 at 7:05=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Other two conventions violated that you may want to point out are
> (1) the commit title lacks the <area>: prefix and upcases the first
> word, (2) we do not use // to introduce a comment line.

Thanks. I'll fix those and send a v2 with the commit reference fixed too.

Also, I couldn't find mention of (2) in the CodingGuidelines doc. Did
I miss it or would you like a patch to add it?
