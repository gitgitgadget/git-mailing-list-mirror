Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CFC43634E
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772212855; cv=pass; b=VFFVBIKJ3JgF0b2hwdSBHo8CNW/Ua+Xyiqw7gmSq6D42QVzXcr3aSokUwYgsDPUQimOVigHRIA0E2iQIq4cVPC7/7GmYkDPa7kuNwJHd8rc9jTC59po0/uy4CyBYQNOIPgrm09adG/OghFUqiQzp/O8ehruVaZ8cNVgL08WoaXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772212855; c=relaxed/simple;
	bh=y+ci4wcne6IEm0o8M4loIgvcJzhKKs2d7GbobBbnWJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGnHaRUFOTfJAbh+I8WHZFMdVDsb5p6zvX5EOVQ5YCWT/hJLmnIw6fQt2kgudFD+44ShmWO9YoKTqBJ+cASl0P9lDM5vR2HEjGAMJ1WESEE6+zghbPK0tqD8eQuUK79Ni5etxQ9J1mPHXG9o0/Ril8zi8sLiGfMDsqXAo+LoWAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KhPt4Z5K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X1ySsbGj; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KhPt4Z5K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X1ySsbGj"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RH0GHb702145
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 17:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o7UImo1lY8xFxbtIg60h1YwlWUK5T7uwgrIr6ifYCFQ=; b=KhPt4Z5KLPMsvuA8
	taV2yeT1JYZnnrjlqjCx9evGFXgNdb1rNDxNA2Ckw80dzZn5a+cINcDlzVh9kYEK
	zf9FfrgkgJRx2SON0+qLjPoG16e399P5Afz2+8G3OCCl3B7+rdX5DcdGkbHYN0go
	qCFXdbLZO1WwWAbu6Q3bl9jr/IYzX4cWp9kk2v1Tp2jMueQc3GAftwGHBEQSD12x
	jXCxPmeCH/snPpNmlExzZejl8rRiNsoiDtN450W093eoK8fo1TXgqtds5pPJG+0q
	FwHB5/lRp5Q9zy3CGXo7NcOoFrHAp1cBIaVwxOqgUhsthq+oqTk9oGdJESsCTtyG
	al4SGA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ck8x89efp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 17:20:51 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7986f771f69so19739657b3.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 09:20:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772212850; cv=none;
        d=google.com; s=arc-20240605;
        b=D/D096vZsvZAaWD4e9/yDI9eup7vm6M6/m+bMzUqqgNKYW3Hw/oKh0mUXjmrDojpOl
         9YtblTphwxIEMfcaaP23/stvnzOl+F8g4WQk7zchFKlR8UMjbka1K1Fi460+qieSWRh5
         sS1ZFhfS19YEz53Qe1UgclpwO7WJYfBANv1cRs+0hCRc4J8JPg3ljxizfhNtlGfR8Q4M
         ZsH/myM0YsOWnr/761b4u5IUaltk5tvoLdWmTk/+2WoXPQt+neD3VZstbTJfeYYyweJZ
         nuCY/IY1su2G2zUzAAAp/H/i8rl+JdTCv8WJC71JsPql6REdxqJfjAGEqf3brjoSZvOw
         a0Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o7UImo1lY8xFxbtIg60h1YwlWUK5T7uwgrIr6ifYCFQ=;
        fh=DW7/E6WjsU7x309xCHuRB1/ZdJJbGvw5PKToTZNYdGo=;
        b=b2q5jAWY8O6SMyxQW7/GaJ+5IbeiHt3lCwmDTeT1twe3sXEsy3arcQlZ84134v9P4a
         KR5C0fjWEIimcdumaOd8nfifE1RLAL+xMFxIxvkv582ZzNkwFwllVboFKOESaV2IaIhi
         /oTbh4ozfQdwi+3tsBXaov47W1n3QExSrAz1a6kXMhrbv6eIhMA3GWtKUbIPeZmUdjWl
         /o1Bx6PcuPkh7VzE5P65RgxEwAWQ1ly33Y0Em6QZ3d0ieWC1ioc0UZy65pGtRum5uK9x
         SQ/no5AROtZ5CM2nxw0UbHRe40/xHPL1SKyNffY8AUNLD5KuD2bCBZLRYAEhTVAMi0Hn
         IAAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772212850; x=1772817650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7UImo1lY8xFxbtIg60h1YwlWUK5T7uwgrIr6ifYCFQ=;
        b=X1ySsbGjI3m2npqcx82KMOTkwRcGIrNAzaUUOHqxw7uldde/a+sSYbgxBlUchBf5na
         BhEwTQORqLJyu2EvE+C55fFuCUIzckO7gPN5elEGlx96yPducEU2HM/8qDbqIB7JH7ta
         sI8qpk0NWPNBf8hPQv8W40hJVbnOqu19OWnXPLk5FV6E1JSRVELmK2nNEV0hBkPxlQ8P
         lo7DAM8s2GY3y6Z1O/WoRvoQj1FGpRLL1Ml1TwHc0Sz8dDGqqRIWtvcGLJOi9av3B/sS
         T8C8f3XOW9pFpeBj0e8MHmPDqv+GO55dbUC5IOz7KoFKkelEiD+X/PeXAliK68ufyf3v
         8bJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772212850; x=1772817650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o7UImo1lY8xFxbtIg60h1YwlWUK5T7uwgrIr6ifYCFQ=;
        b=BEE9dfrpLOHf0OwBhrgHriptlOITwlUK/MDRtBbvo/MIoK0btlz/Q5QUmYCDELQIa5
         SP3WDTM48IsqtW0MSYC9KNmeXL17jwKJaH2vbOBVOPN8Asdlyvit91hSXf6uUKdCjB1A
         5J2t+SYUXiDFfI7Klr0LvhgTdGMIJVRf7KWiKDN/O6og/AB4Ny3IinfwbbKi5pMbc1Xt
         3bdiORSbi3XqLeEYr6H0M+34XImh0eHFgPMzOAFam8a78uzl6aJqRnOEr8h+frLmK6cM
         GwzzB7zfYsEOc7UVw4hGke+BUjocqzBspo7M3Z8lTodIuaQh4xtEREqgHaTW3gFCNG4I
         Y9fQ==
X-Gm-Message-State: AOJu0YwSlxxwYAGD/MmbHOxJzK7Ffzkg+IZ5pXmvl2vNxRAVYL82yQxp
	xkddn/nwQc7VmdoOUCLjNlgfmYYmcGkw9Dsq+5Zf1SGjztNIdpiEoLtJFEHwTCWI+u/xE5IVfrW
	DibtKhlOfBBRAT/+EP0KZ1iGVNy6cPx3z4lOuOYjzTUg/Da3oM4Nc36Q/jo+OVCBKc2p+l7CB3Y
	ULUPtWONTQZytXjEy945ZBnD0XeTxRvg==
X-Gm-Gg: ATEYQzx2/q9KfYL7ZA9llK2w+pydu/YQAc/DDOAHmdLxaHn4cWcI22OocQtPDLDKSk5
	7hDOr38/yFayyUZFbxvX6qgrz1j/QlGL0dL8TSGHKKqrwszS0SSMZLj04XQ4FoljVjDJUc/8OaM
	rProbNgADLFPt8uRp/EXItjv0RQGsUKIstyYgWe2KM4Qcz7cN3VDb7gYKy43nTuePadcnj2ctA3
	i2jGSDS
X-Received: by 2002:a05:690e:4349:b0:644:4eec:22a with SMTP id 956f58d0204a3-64cc2e7b07bmr2740625d50.2.1772212850336;
        Fri, 27 Feb 2026 09:20:50 -0800 (PST)
X-Received: by 2002:a05:690e:4349:b0:644:4eec:22a with SMTP id
 956f58d0204a3-64cc2e7b07bmr2740606d50.2.1772212849930; Fri, 27 Feb 2026
 09:20:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114194815.1049888-1-nasser.grainawi@oss.qualcomm.com>
 <20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com>
 <xmqq4iobhpvg.fsf@gitster.g> <xmqqms23lpn2.fsf@gitster.g> <xmqqzf53t3fm.fsf@gitster.g>
In-Reply-To: <xmqqzf53t3fm.fsf@gitster.g>
From: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 10:20:38 -0700
X-Gm-Features: AaiRm53zg3W9i8hqBiCgrwosXLBErbqh535JW9QzwRWJP9Biz3avZVM3nwOW5Kg
Message-ID: <CAFcKa=-hQUnYKRRZzjmiUBbLtnq-oMe6TbiXwro1WrjQxX+MMA@mail.gmail.com>
Subject: Re: [PATCH v3] submodule: fetch missing objects from default remote
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
        Patrick Steinhardt <ps@pks.im>, Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=WZwBqkhX c=1 sm=1 tr=0 ts=69a1d273 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=NEAV23lmAAAA:8 a=ybZZDoGAAAAA:8
 a=gaOGgTSRbUhMxM0C5nwA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
 a=0RhZnL1DYvcuLYC8JZ5M:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE1NCBTYWx0ZWRfXxfkBf+YG8WL/
 37MoabQ99pASw4hv6Ipxa5f2vUKfjgU6hNnTQUKtbLkaIPPEwUBCEZZVOexfi/guIMUS5Nqxvyp
 888Ui4JRL+XRvm2R9Jk6+wH1rYcc2Dd91h8FYAp8YtwOBQtw2IG5gOZXc0d8xr7kvKP5MA5/kNA
 V3GrCPijmvHuWX0ktvm7wUiNHXLxpOA+oA2bsjYudLggxy8uINBApCLSPQm5MTGlbUgpRsw5yWF
 vlprkmHXQci6IojckSvlfFrrOSD+Cgw6f5YM2ijcRjRSncw9tUzHF+ixW9nm9PfMvJiSCWzv0Er
 AUVeteM5axwBVEiUKVNWHBqLHc2Wc4bEXyfU3+0rTYTIahauQcpWBFZLK5py6NhGpo+eZ6MDDjj
 ieRBSRNFCP7wcHNO7dDlKsucl86uoqqBTr91TIM3e5IOy8yunJE51pG0x1KKJtWiUDioabdcO+0
 ZCVRVfCsLG0L35QNA2Q==
X-Proofpoint-ORIG-GUID: V6Km0IOqzSc90INTA4RcwDsmnwyGTSfO
X-Proofpoint-GUID: V6Km0IOqzSc90INTA4RcwDsmnwyGTSfO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_03,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270154

On Fri, Feb 20, 2026 at 4:12=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> >> ...
> >> This test assumes that the first branch created by default is
> >> 'master', which will break in one of the CI jobs:
> >>
> >>   https://github.com/git/git/actions/runs/21304166518/job/61328461844#=
step:9:1942
> >
> > For now, I've queued two fix-up patches on top of the posted patch
> > to avoid CI breakages when the topic is merged to 'seen'.  One is to
> > rename t7425-submodule-get-default-remote.sh to t7426-submodule-get-def=
ault-remote.sh
> > (both filename and the reference to it in t/meson.build), and the
> > other one is the following.
> >
> > ----- >8 -----
> > Subject: [PATCH] SQUASH??? fixup
> >
> > The test as posted breaks when run with
> >
> >     $ make WITH_BREAKING_CHANGES=3DYesPlease test
> >
> > as the added part assumes that the default branch name is "master".
> >
> > This band-aid is sufficient for the purpose of the maintainer to get
> > the CI passing, but the real solution should probably be done better
> > in such a way that the latter step does not have to rely on the
> > creation of "anchorpoint" in the previous step.  I'll leave it to
> > the contributor of the topic.
> > ---
>
> This was from about a month ago, and we haven't heard from you.
> Will we see a hopefully small and final update [PATCH v4] of this
> topic sometime soon?
>

Yes, sorry about the delay. I was aiming for thorough and landed at
tardy. I'll get my replies to your inline comments sent shortly and
hopefully the v4 soon after that.
