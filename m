Received: from mx0a-000f7c01.pphosted.com (mx0a-000f7c01.pphosted.com [66.159.248.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F421C155389
	for <git@vger.kernel.org>; Sat,  1 Nov 2025 01:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.159.248.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761961631; cv=none; b=Y56TO4MjdC66DSLMa1ITEC2HWlHnTgIh6qD4Xz+hYCclfBtYgiSbsFbPK/+Yi5m1BugTqVUOuYsFt/BbYNEaf5Qp+/x3cuscFI4wInMMfQMgDC/EU3ExKM7K/jCPkVRtz+WVfNEjBMYIKBJWIBYadw8BMN+ZKCLOasZtj0PFzwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761961631; c=relaxed/simple;
	bh=uJVmWpNpopM2QWv8Nvep8gWjLitBMR5QJOHAMSUedQg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=newIvG26RDGDQR9IUaQo6bv6lcezRuVzaUfKKQ+EvibSBIGgqQfUp/4Bty7ZDXo4VEtMAmPIASPPbFa9kRDf5xIKrjFnrLTrg59B5nfD5cf3aIZtQmQFfTCuGLje35ADMUkLNkGOg1EYIeOmykdiY2Chx4K9AGVmSvETq69NGeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metropolis.io; spf=pass smtp.mailfrom=metropolis.io; dkim=pass (2048-bit key) header.d=metropolis.io header.i=@metropolis.io header.b=UsB5Ndbg; dkim=pass (2048-bit key) header.d=metropolis.io header.i=@metropolis.io header.b=Sbuyd2CM; arc=none smtp.client-ip=66.159.248.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metropolis.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metropolis.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metropolis.io header.i=@metropolis.io header.b="UsB5Ndbg";
	dkim=pass (2048-bit key) header.d=metropolis.io header.i=@metropolis.io header.b="Sbuyd2CM"
Received: from pps.filterd (m0443656.ppops.net [127.0.0.1])
	by mx0a-000f7c01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VFxkxD3595185
	for <git@vger.kernel.org>; Sat, 1 Nov 2025 01:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metropolis.io;
	 h=content-type:date:from:message-id:mime-version:subject:to; s=
	pphosted; bh=uJVmWpNpopM2QWv8Nvep8gWjLitBMR5QJOHAMSUedQg=; b=UsB
	5NdbgM2/mVwJjhkuppsPrteUbRuqyOsotVMYbpttm9SdVkSoVTTeUF65iSTeQZD0
	UtnlFTFAwokHvcirA0+7D1epio/LtCR3+SzirCOGuI4CeYzInkfVoeL6CP7Yw1LH
	4LBpEpvYTvAJsrJ2MD5jCC4xqEU9pCunWIFwyUNoZ+o4KGI+hneblaDA4JX21gGS
	r9j1/kUk9DmbwhX/Ftfvri35xxIbGXKJqXOkT984WcanBjsj9IHxVyZ/RsvqqINg
	64zkYbp7VUuedkSKTD1teWSlGYnTqnlMQbIVrsm5k4Ft0gSSMzbgfphDLh08PV9S
	ihNkqd+Ee00lGn3/D6A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-000f7c01.pphosted.com (PPS) with ESMTPS id 4a5089gwsn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Sat, 01 Nov 2025 01:39:12 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-79a3c16b276so56070466d6.0
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 18:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metropolis.io; s=google; t=1761961151; x=1762565951; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uJVmWpNpopM2QWv8Nvep8gWjLitBMR5QJOHAMSUedQg=;
        b=Sbuyd2CMmUsGu3Zgd4TEf6QL426SENJy3NwzgjiBm1en3JfFtqo76jeiIW7ciuPcu7
         u0wfIUPbh+y4YSdwiCrkTQCEHaVAQD3pBBQy15HTTF3R2Hv+D9HG75wT0mBRuH+fTA1y
         4sQNw3FnbavK5w2Hm5DwhPrkOhTvikZhlmhDKl2LblXJBGiB10EF3O84S2nGKRpc5JSA
         qPuJAzuGqqVHMjJb0OKgX+8h1skANlFRY8R7CyV60mZ275xSQJXr6gwATxALHTdJtqvo
         WKoj/ra35po50HFGqvZ+Jy8nGUjZfLNKCIvDSKwZmvqmj+pv8xGTxkdagOlvCX6M6zlC
         /FVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761961151; x=1762565951;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uJVmWpNpopM2QWv8Nvep8gWjLitBMR5QJOHAMSUedQg=;
        b=GRT2n2pKZZx7rEd3YxTHD98qpENYMZ4PnSfw9lrRoo+JmPUiGzMeDH/RdkQyZ3RqBV
         mhwgPze0YT2zIZQWkPj30sWL4wyAd01XvrT1fuHF2EpXXQB/pjwheJZiM5uGBPvHfvur
         G9OPD3AV7wLopDVa+uAn/Mc7F108PxOllgnwyt6Hh3SLyBPuukDqo3G2ZEkSpr8ZpDzc
         nEdmpOe4hwNq5rZ3ANm7cpJ2UFElBI64QFWXz4SfczCtv/x708Ik5RN3sTRKsjbUojji
         Qfvf9ufrXHuoR3dMzxQs5DZnCJ3y2zmzCdwjwbzZKAurvbZrGKP3xiZyj8KmRJWCY/p4
         Hscg==
X-Gm-Message-State: AOJu0Yw3FxhHmbYj3QSX+yAKBF3pLVHt++JQBpCwf9HZpoENWNUkted0
	hS3BtFSclsouQTteEjN8i4trck/Prq/ozOb5s8unrfQgPA6uJmugMf9O5eIdFHwVE3rP4FI1awQ
	WSEeWROgL+ZjiIW3J9Pq/HW2R8rvDq/G2zfCblumXUqRdiOks4Uy0EXP6QaUXYQzL27jR7iP6XM
	84LwvkDkciLMY/ZpU6bCTUs6LFgG9eIMaVj917xdU=
X-Gm-Gg: ASbGnct5c9dUeZPRUzLhQUwCgL/ch/lXIwupUcAbdnuX0p3rjjX2lNliAxigeGvDsdA
	BIgD1jnIZiw8fdRkge6dgi8YA9xCTjAjW6+uPfDpWhHrC7jSeNt3M2ktf9cJCU6DFv92Fco5XGk
	PvXYP3x9Vn1LNBcqp7FXU8qdLbhj9/VGhPE19tQs78rLcojvro53Gtcw==
X-Received: by 2002:a05:6214:da2:b0:880:1be2:82d4 with SMTP id 6a1803df08f44-8802f317687mr63194326d6.26.1761961151566;
        Fri, 31 Oct 2025 18:39:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU3gfnMvg/FTJbbniEpA5tLUSErgmY8wIvOipeS23WeGg03pzv4P/z2aNm5rcM5TnB22R95Y+LfFbIt1tU59I=
X-Received: by 2002:a05:6214:da2:b0:880:1be2:82d4 with SMTP id
 6a1803df08f44-8802f317687mr63194206d6.26.1761961151176; Fri, 31 Oct 2025
 18:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Woodard <mwoodard@metropolis.io>
Date: Fri, 31 Oct 2025 20:38:55 -0500
X-Gm-Features: AWmQ_bkKke4HsrF58j3ii9v8ZRnKfj2KT5RoOZ5nC9mPMgbnxYwUPMBaUbNBMMI
Message-ID: <CAJ6i6FDqj0yCymuGd+f89XQvTLGRj3nVC-36Z4tbJfwNRKSt+w@mail.gmail.com>
Subject: git remote rename command help
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: 4v8LgbzW7EFnRVNepBzmY61j8fv6AhAH
X-Authority-Analysis: v=2.4 cv=XLs9iAhE c=1 sm=1 tr=0 ts=690564c0 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=2EukRn8VhYUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=d1NFmZyc0IEKV_nbD6EA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=c9OMC2MNn3O6V6TCevYZ:22
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: 4v8LgbzW7EFnRVNepBzmY61j8fv6AhAH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAxMiBTYWx0ZWRfX2SRZU53RVTgP
 UYVEBrXxfRplwRE3Ub2W/QgwHDd27AUK4JLrn4xmK9Ff6my2Xz+wk9ZXHrdvyXCKtB6E5lH0xoE
 sdEMCkxvvv26gjRGHE7bJHTgdubdicesFg2SM8AeCW/Ph7miqHy6ydAL9ZeXcZunIk4ffHxhh0m
 9RAYiKfoP6NQAiSypXwWAyS68wMs0xyD3/FUdJRMgTXoam9D7fTFQMa6m3oghE4EWdE0hCVG5WO
 iJUlUIZToffMKuZScSzHOV8/dDqRGyjhkFqRoaBZxBPj00BsOtFrcgnBbpxCf5r77s8d+28BVwX
 Y2IZhYYuNMNd4/eKJsPl8QVZxGwGS7WeSyc/BysxiRDi/e8SPbOsWF/yJvMPBuhzvy/XQObkUt1
 QJFzHppLqM3KirZifddpn1m0mYAIKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511010012

Hello,

I entered the command "git remote rename Old_Name New_Name" but it
appears to only have affected the Local Repo I am working with. Other
requests or connections to remote repo still see the Old_Name. What am
I missing?

Michael Woodard | SP+ | A Metropolis Company | Manager, IT Operations

Mobile: 251.463.2791
