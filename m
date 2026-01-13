Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF03C280335
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 22:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768344117; cv=none; b=XsPPI66VnCG4BPW2rpg1EveCw+X1Pglyh+z98H7pwZjKkzldUctEsZEVshkToPky0x+qfyfUl8V57Is8CCYM3z0/aY6YyrASRxSsgGOMufGo/QohQ8niaiqNeZX0UvIf9tXvd38ArN7QzDWOEWL0KHXs6jNt+KKmwREH6NTABv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768344117; c=relaxed/simple;
	bh=GW8tN16gtM198ZPy6/oW/tuKN+RxN0JyN8/wvo9Ot1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MascGZZzznq57glWopkf0VY7Ya0meEkbhEgIgyQhthpKXx25Cp4e1bLzvb6/COfgYpHNMDJNebByXVayfrlrYLYHq0j/qKn4e0QSR227GR2YUngY+0j2ViXt+Dg6c3DMA+izSfFw2LMzTK6tfSarEetei1Cc8zXG48YsgNIEgqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fY5CYu8+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AbEWOZkI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fY5CYu8+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AbEWOZkI"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60DLrMF9662242
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 22:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GW8tN16gtM198ZPy6/oW/tuKN+RxN0JyN8/wvo9Ot1E=; b=fY5CYu8+bcYou7J3
	7N3vq2F4mLeKuxfPRX6Ek7RdWvpZtsBDExsXb6tU1R6gCNn7dk+1rGj2f/8lj8e1
	p4BxbHhTFEzlRBR97rzHQM8eQwkqdlo9TJHsb8FMMVgv5hHpJ/lsSb5S0PT9q5o5
	lzmTAmP+q08WSThRH6GA+EUEE5Yry+uoRxDOpzJw9O34vNWJRde9mCUIL4Dc+WYl
	yc8CWXgc1GR0qg7gci64gMSmvTUPGrQ7PktAuqqrULdl1lZPTRrbBBpGu4RJiDxv
	y686vNkjTdiFt9we25HJiBgseIFDtidx+V9MEhFtzAGWauj9c07IebymWVXgKjnH
	ZywDJA==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnsyb91t1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 22:41:54 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-78fc5b493c8so106763607b3.0
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 14:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768344114; x=1768948914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GW8tN16gtM198ZPy6/oW/tuKN+RxN0JyN8/wvo9Ot1E=;
        b=AbEWOZkI0M0jaw+OKgENcegjfODugvsazp9LaW1EjvXTjIf40ND20r+1pqLdOgD5C/
         IazXpr+5BxMDWrf3l+YzpoPOtkwpsmsqJfanGio0FPYtBDTnrdcL5LUd9gVs8EMcmbiJ
         VJ+15pNWQRklFEbiNBWxf81ny/9YW8w6Os9pAH87bk4ZzI8KG+ISm+WeujecRWCPccyd
         BBxcXWfvPmA2/KWSFx1iYigvwuXPPm6Fkh5nKHPtnQYMk0BwpJ+suDtPgaMm12rbFtRo
         c1j9oyrGcw+xVKsZHvTkk+yGNSwsxuwb2X97UqZTTZeICovr8uOxQPb6WhWJKXDwG3GG
         zDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768344114; x=1768948914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GW8tN16gtM198ZPy6/oW/tuKN+RxN0JyN8/wvo9Ot1E=;
        b=aBsxvP9AlFXER+UEs4DRjjfLnzj+UZJc6f5ZyCR0U9IVxFfi+D0bqAARQNPbmqCNEt
         hHLpkx5kSv9h2oT3a5aM2qETO0KeqSKgaVgBhhyXBECSTEqVGoH3lJ/uIkaqJlTFNEfn
         sRsJgLjft6ur8T6D7bXTVXXPr2vhCEq/Xgj1IE3QSOossl4A6NrLf6Vf3v41d6e6bwAd
         YzmPun2pu9G87ogYvJdOf+cor0QfjQYsHvpounVEzV2e92wKwudWUNaFEUAgEMgmDmEj
         HXtYor/szYVVkcWkZtRBmCdwTWs1+XRVLRN8Ewi2OAvl5+SeJ7Hpnwu50dankoQJhu5t
         hsJQ==
X-Gm-Message-State: AOJu0YxydPV5NXf+uAZGukzouA1DVejOdGR5azFqGwrx75WQe8BX/4eB
	ALJNbklya6XD2Aldjlrwn+fbo2dBVY0hk4IFJV0jlTdkmtpSiBsHGhofTFWB9IWATPY299+U9o5
	C/o3nhgz9WaPi3U+pWslwZ9SDzEk/aRXbjFEyO+KxoovivhhmP62b2EDcz+3QpQGSVkGG9IGOJs
	+PyOm5j6KtFN1hs9tBLeAavKukN/HElg==
X-Gm-Gg: AY/fxX6Pnnq8zw+5MuO5PN/LqzaXyjoY5ik01ibFjx+9vQEPWVuyfOgrrd5luibj1lD
	W3BSGGFbnU/Ohaw27AvwmnYhG4sCAnriOwew/rKhAFEDzvswNPOdbK6tu2LYNDiPPR6yGBtj5zo
	yRZ5+cA5CgpU0ehTUUrFrY+eShmb1pna22X2qhblY5/6tTreC7puss7enPBSHfenuSZDqq
X-Received: by 2002:a53:d704:0:b0:646:90aa:bc3d with SMTP id 956f58d0204a3-64901abce81mr589204d50.31.1768344114147;
        Tue, 13 Jan 2026 14:41:54 -0800 (PST)
X-Received: by 2002:a53:d704:0:b0:646:90aa:bc3d with SMTP id
 956f58d0204a3-64901abce81mr589190d50.31.1768344113765; Tue, 13 Jan 2026
 14:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112213612.2761854-1-nasser.grainawi@oss.qualcomm.com> <7FB6BFD0-4C54-4924-851E-D4B5C574D7FC@gmail.com>
In-Reply-To: <7FB6BFD0-4C54-4924-851E-D4B5C574D7FC@gmail.com>
From: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 15:41:43 -0700
X-Gm-Features: AZwV_QhevjGS3JdyWYRTxW64pYpTTXhgCo_707V1srtFitVD1smPXQmRDkgfEgw
Message-ID: <CAFcKa=_P8kUXvsuneQsoi=Bwbmc8U1kBv68fx4yq81vKBLkFEQ@mail.gmail.com>
Subject: Re: [PATCH] Fetch missing submodule objects from default remote
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 05VA6cICZULtrUxrZVLs0GMuXChdCE4m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE4NCBTYWx0ZWRfXxshCLk+nFZO4
 TeVI/lSse1w/+0WmHIeDqdo0B3XHpdT0yvBhK4NmmFpTyFXc80INzwQPedRhb+gWbQbPWP4hoqP
 n//WEcCR83gdDhGoPzXFAwspFWNG/qJPC3VJOv/GhZIkgSkbCG4hKDzjPmh6oqnZ+CDMtekXjxy
 PvZuQO+TqNuW5+oqII+LiLu6Xmt4Ff04nrFlwOKOtigxCzVbTXgaWDtldMP9l89cCBAIw5DMaH4
 tPGD94j92UOM3c8XDKlGGWrfyoUgj/nI7Fpmh2zP3qs07KJI2nJqycF0JB4tHDy4aE/9/BnQWSh
 8FL6V4YMYBOSHgy1wFDWS4K+1bBh+xspUpmDmHP+rNaplR6JejfZJPgzVk3b7xpg3EfPAuPFJ70
 AXAH4cUzDKXrrEFvmZIVqnxdBINrMJhUWVfyWYDR6QhJSI/pg1zLXkqBRfLeZL1pDZQw19DzbOx
 nkvDrrPJ1shdVam36Rg==
X-Proofpoint-GUID: 05VA6cICZULtrUxrZVLs0GMuXChdCE4m
X-Authority-Analysis: v=2.4 cv=IpETsb/g c=1 sm=1 tr=0 ts=6966ca32 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=O_en5bQr-zblU-3xDYIA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130184

On Tue, Jan 13, 2026 at 2:51=E2=80=AFPM Ben Knoble <ben.knoble@gmail.com> w=
rote:
>
>
>
> > Le 12 janv. 2026 =C3=A0 16:36, Nasser Grainawi <nasser.grainawi@oss.qua=
lcomm.com> a =C3=A9crit :
> >
> > =EF=BB=BFWhen be76c2128234d94b47f7087152ee55d08bb65d88 added support fo=
r fetching
> > a missing submodule object by id, it
>
> Convention is to refer to published commits using the =E2=80=9Creference=
=E2=80=9D format supported by git log and git show :)

Oh, thanks for pointing that out! I missed it in the SubmittingPatches
doc. If I end up sending a v2 I'll include the update, but I assume
that alone isn't worth sending a new patch for?

If it helps to have it here, the corrected first paragraph should be:

When be76c21282 (fetch: ensure submodule objects fetched, 2018-12-06)
added support for fetching a missing submodule object by id, it
hardcoded the remote name as "origin" and deferred anything more
complicated for a later patch. Implement the NEEDSWORK item to remove
the hardcoded assumption by adding and using a submodule helper subcmd
'get-default-remote'. Fixing this lets 'git fetch --recurse-submodules'
succeed when the fetched commit(s) in the superproject trigger a
submodule fetch, and that submodule's default remote name is not
"origin".
