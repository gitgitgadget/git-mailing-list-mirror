Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF62E2F5328
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564432; cv=pass; b=Ei1FD9+YEL8NTMiCD92FRfRPq+ehfg9THpL/E3YdHbGrIh7YV+lz1VkwYZp68RsqSiLwHQ+OxFlxZ9LmdcVle8bwKeCWXN99dNG2Fi1k4K+FBOgkv3RDr2Squxx+ThvuROj1dYU/sEY/YCGDJNhw2sMML2KiUIXyNui9/EhYNAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564432; c=relaxed/simple;
	bh=FDTGciOYoORMSS6ZvN06EGXwggk/G5SxNO2PeUPRmww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gv4Eb+IGIA/HfIQ8kR8wWh+1TnSTxeHVBvMqAcHmvBToMUWc1+h86vLorDqIiIy4JJ1qGzJJqrhafVvyMQlXCCi5JRZCo80bA42nq5y15JnQUpL0QuFtjlxPTYjJlR0isadn826SF5f2vFL2ByBmunJt4Ej5MYiHbbK2vv8Ri9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jT1KpJqh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HMbhcxbK; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jT1KpJqh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HMbhcxbK"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623H0fPn4030593
	for <git@vger.kernel.org>; Tue, 3 Mar 2026 19:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2fZKuAFMoS58GJHjC06kjpU2rtPMsP2/PD2RLnJNFgA=; b=jT1KpJqhOjIYLrKn
	2boYmddqh/7/jTW3GSZUL+MYJrM+JZ61R66B4ezUp2lKd2swrLY+HdJuH1q78SJS
	C9BWXl+/9WWWqZaSCyn329NtyqF15WsDxdNYvlk2AAAyn7/zqPZZEeqSbwaXAU2D
	YXXkKM3PqXuiLuh+paUdhPZoaKBnfa6rYIz/XuSjyWrEmKN8CCiHqKebvPPuTjNt
	xdilWs14O8XNEwekNGMKcjPLLE2MVzpSVYxdV79zn6cn9VNXEfisRIzAog1+kfua
	3iCyrm0jlX5hmnyoH4H7DHp0+Pj/w/gxcXhODh8xMyBRYfZxgDt/aL1GGRSvqOIl
	pw32lQ==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnuqu26xr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 03 Mar 2026 19:00:29 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-64cac777207so10111640d50.0
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 11:00:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772564429; cv=none;
        d=google.com; s=arc-20240605;
        b=efpSGbRDY5TEe56S59xTVfe0y8duA06KrcdMFb+N9yqbqAEECgRB2L+ehsCkF+b6vI
         UQ7J/b9IC3WWVcvYsGziCcIG5rg9WCzdzbnKAVxPSErf4liG2fwsWCNjUlLAc33OvJQg
         ItcanfNXmhzaL9HjOLgzwfvzpD+72PR2y9S36Fyw90AlaZUAREK8+949Co5Ilyn/cXHW
         PcCiNDXOT/z1c1OXc8fQQQLRENy/D5Ufk4n0F2SRyHv/nC15GPhnk+XOulMATUDjV4rx
         cxxZuOQn/HFixvxnkezxbDvwfGBe24ddozTYuA9a9dENvLZQHhWaGgSNsT3aYkAWRZap
         txXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2fZKuAFMoS58GJHjC06kjpU2rtPMsP2/PD2RLnJNFgA=;
        fh=DW7/E6WjsU7x309xCHuRB1/ZdJJbGvw5PKToTZNYdGo=;
        b=hX3jrDi6sElo/cf9pHAkIF1xiBfNI8JU4zNE300+TsmeD/1Y7BhVK2Pkr87CVE059Q
         VY3/MAQUZPcfjEJdnxuSsRv1PEAVHt36I+62BbYRvYWNamAoyk3mPv/146LAGMC4EiXN
         FR/8HzTsNbVEuT179xURMfDa2xn3C+kpowSNTmBwVG2F9kThe4/S+gXCv4rrVrhtEQd/
         AB16F8VdvYCkbon5mc/R3nNgLny/24VMHc1lJcavqrg+qHGrFNRWv8KDpS6rgXm/uaTE
         E/3Rkxj45h9o4OEOcmHn95AFyRcuiuiA0ovi6hwz+C62Q8YCXCubNWId0QhBQAimGFQD
         C0mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772564429; x=1773169229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fZKuAFMoS58GJHjC06kjpU2rtPMsP2/PD2RLnJNFgA=;
        b=HMbhcxbK66ni0YhzJmUueUJqxlyMBa06oUMSYdUUSumn0lS4oQex4Vh56ZqfAS0x6p
         SskvQvlAjPFe7L4fVCgQaS5UoZqbxui9lHfZcLh4b46CaCaYiUTrvwN737tsgcsNgmFv
         oRqxQY3RSoublJiHkYIozl4oBY4lGQZvUrd715n+sFtpZYcT9wExvgS4fsPo9R4UPhSK
         D9/tltn6HIHEx4l/co45ycM+2eNIPGBpDzZ12P6HiSbp0YBARce5/d3/xjLXW4dQWmsS
         KzMM0lLrWIxioN1wkQFgi8QPE0HFXeGXIcR+GXu9K4Xzh7KpgxzSQUKhBlmaMv7o3nS2
         4gvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772564429; x=1773169229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2fZKuAFMoS58GJHjC06kjpU2rtPMsP2/PD2RLnJNFgA=;
        b=BR+bTCIO8cLvRxj6C6Plbw9JvA1uZ1pczWm6u4GXp/DbSuZU+g/VVb2QMFMbJp4+SV
         N7QI3w4A+ePCFvOVC0bAfj14WutXIx/Pd1alateAK2oGuC91OfL66+LZbfTfsih6XAlf
         0ohUEYZ5xJQxwX9ufuYXPi1CqdE9ZP+ljk/tngoVI5vuttSwUHvbkz/ZWNXsv2kalqTs
         BNPmslCBxRGpxmOEH7AtRCPSATzpme2cCB9uOVDCzKmdJuhyyOfVM1D5N8A9n0DMNDtA
         ySfIE8PmyjRayH0izs7GNfFSDZQuiWqNaMq7OiyYLsdPMwnZ3vIsk7DNvym0UVO1ojYV
         jJUQ==
X-Gm-Message-State: AOJu0Yx8u3+SQEZb+cgBl6fRQ1ZLultA1OkoCvc60ct3HO/8GjPhunl+
	JlENzEHKooGWRcQE/dhEc5/qE2OxzlOJQtUxln74SzUqfpqS6uQ8kDO1PIejW1sajk26kIWXnyR
	aBbHhYSSkHh/9LsXYnXLFjcnlFSt+6dAHqgW+JOG8avBmSQB3ZDFdS8DX0M20qh2UqXqshL4qTU
	WDRf9YbdQBx6s0feg2SsrYEU2fRijO5Q==
X-Gm-Gg: ATEYQzznS8IPl9bVlzM1d3nIksnGOkkEog6A6Z36XGnd0SuT6svumg2eNBciLou+8wG
	djf2L4QBBMnVBMPbNdRlofkaQmPw2lzTYjHdOM/3UwCoWIF75vGHy4PTuc90FQy1qA7IIrocJnU
	l3TkHthdUMKpz7Qz+RFuGNPPO2YB65/2VeqYd7/kz1GM65/na5X5jRh6qQLhVxtr1IzBBFThiDd
	Myqbw8=
X-Received: by 2002:a05:690e:d4c:b0:63f:a488:ba46 with SMTP id 956f58d0204a3-64cc21417a5mr13518325d50.32.1772564429100;
        Tue, 03 Mar 2026 11:00:29 -0800 (PST)
X-Received: by 2002:a05:690e:d4c:b0:63f:a488:ba46 with SMTP id
 956f58d0204a3-64cc21417a5mr13518290d50.32.1772564428492; Tue, 03 Mar 2026
 11:00:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com>
 <20260301025327.3845292-1-nasser.grainawi@oss.qualcomm.com> <xmqqfr6hfyqq.fsf@gitster.g>
In-Reply-To: <xmqqfr6hfyqq.fsf@gitster.g>
From: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
Date: Tue, 3 Mar 2026 12:00:17 -0700
X-Gm-Features: AaiRm52zQMvMelTKTKu0vbbCG_Awl43oi68gPfXK-vf8R0zbOrj_ksMXEDS-MrY
Message-ID: <CAFcKa=-ei+93P_Rp+2eKWW+43aSyg_hxHb9K6X5KmXEcS1VGvg@mail.gmail.com>
Subject: Re: [PATCH v4] submodule: fetch missing objects from default remote
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
        Patrick Steinhardt <ps@pks.im>, Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=M85A6iws c=1 sm=1 tr=0 ts=69a72fcd cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=ybZZDoGAAAAA:8 a=EUspDBNiAAAA:8
 a=0BDtfAjI_xQBkO28fSIA:9 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
 a=0RhZnL1DYvcuLYC8JZ5M:22
X-Proofpoint-GUID: 7o-sQSz2q2tu4j1mJYpD4Ttn0Se3jit8
X-Proofpoint-ORIG-GUID: 7o-sQSz2q2tu4j1mJYpD4Ttn0Se3jit8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE1NCBTYWx0ZWRfX51kxfS6dmOsT
 IhTD8b27o/JC6uEZIwm2r2xU8kmnHVNJiCdHcJZm4/tsFYbDORbGWr55TYur3kYUb3hl52A1J8j
 8SOIsnxuHrKKfj0JYF/XDA7TuCGZFgqYfKMo5MHuhtsRzSkmMSn9OJz7rx4JXcs6e/spwcElEd3
 Q17hoNkc6k3S+zqpxZkxiUNO6tgDtVzf++gPN3vWyS6AkFuKfF9PzAIUk8HnxVhfdNi2XUyVHnl
 VVb1WShVHaWTh1WJSP8I83GS6bWtMh4jQ+a5ojCHWVkfWzhnphQvYu9cJR2aPs02JThoeBCsFyL
 QwsRQu8Ag23Noa7qOp1DtCdQ6InW0xwibQ17/m3aOdHtzjhfD/+J9bBmnLVNI8IkT8Sh/9P1r59
 4/J83iAfIN6eL+454lbIDziHjTWH5TIubzSr7QbRD71wW73HMViyWXfrQiRy6bK3+oS/5fel4Ul
 fyQ75D1k+aS2o9iYWwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030154

On Mon, Mar 2, 2026 at 7:11=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Nasser Grainawi <nasser.grainawi@oss.qualcomm.com> writes:
>
> > When be76c21282 (fetch: ensure submodule objects fetched, 2018-12-06)
> > added support for fetching a missing submodule object by id, it
> > hardcoded the remote name as "origin" and deferred anything more
> > complicated for a later patch. Implement the NEEDSWORK item to remove
> > the hardcoded assumption by adding and using a submodule helper subcmd
> > 'get-default-remote'. Fixing this lets 'git fetch --recurse-submodules'
> > succeed when the fetched commit(s) in the superproject trigger a
> > submodule fetch, and that submodule's default remote name is not
> > "origin".
> >
> > Add non-"origin" remote tests to t5526-fetch-submodules.sh and
> > t5572-pull-submodule.sh demonstrating this works as expected and add
> > dedicated tests for get-default-remote.
> >
> > Signed-off-by: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
> > ---
> > I removed Jacob Keller's Reviewed-By since there are more significant
> > edits to the tests in v4 that they haven't reviewed.
> >
> > v4 includes fixes for the issues Junio patched in seen and I confirmed
> > it merges cleanly to seen (with v3 reverted) as well as next and passes
> > tests.
>
> The tests in this patch seems to be broken.  I didn't notice it
> before merging it to 'seen', so tonight's integration CI is expected
> to fail at the tip of 'seen'.
>
>
>
> *** prove (shell & unit tests) ***
> [18:10:13] t5526-fetch-submodules.sh .. 39/?
>         error: bug in the test script: test_when_finished does nothing in=
 a subshell

And this is how I learned about TEST_SHELL_PATH. My Ubuntu machine has
sh linked to dash, so these errors weren't showing up for me.

Also, I just noticed I have $pwd in a couple places and need that to be
$(pwd), so I will send both those fixes.
