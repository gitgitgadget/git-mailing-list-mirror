Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E971DDAB
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 00:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768956517; cv=pass; b=mvebrewT0ipWqxqg+PpQ4D0pDnp/FJG6ivZoy3I7ox7v8m2DiQhnW3okPSpxNVAzh1XWIGL0f3dgOhRpmDWxSPPIZ8vr9UPoli4pQweNtayfhyy7EpynK8nsrd3MBN6P9OUqnjT79bonfEm7oZVe2tmI0W71ow7n8v+N/ZBAv2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768956517; c=relaxed/simple;
	bh=sY5WQlg/n9iMv+bb83imBK0+XWw1HfrFb4SnuLIvf00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcdZHl9op6h37+52sDnGXyq6ftGb7q9xMnBfpjlolHZp7hBSOPyKzkl9ISooxWOP4cy2knEC46IMWUX2qhHO2kUbcOKhutS4EVk0XkuY41OUz9y6+rbS0t/DFU2pKZoYxTXy/2dpApy9mPL6bKCdevxhh3U8meWj3ijhDr3ydu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=feIMtFZ9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CznHsiK3; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="feIMtFZ9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CznHsiK3"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KKrmPr1036448
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 00:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pd/iwAHERZzLpKzHSHXXeE45Dbzka7On+2WGfbEfxtE=; b=feIMtFZ9v7CB4thi
	Jz80JXT+fjq4CBg9F1xQcILBmELTZePv2f5FeRT3twSkwl+RVXtpm3xKfyvbY/HA
	9akZ0JBvhEji45+en/NpAyN6KXusIhp1o4HmtzaIxDp22hCpiNfTSCsWBmaG2nDD
	v6naoVz4zwRU7rLjp/PkAYw3EQMdItTJfnY1ssJBqLYZUk0OU0t2Hvtn8sJ4aJ+/
	d7aMQh/sd2Gvu4sZQHtQXnmlIAnPP5AqfDEF1D772rLRXHytKMdYDwPcVMkXuS4P
	4AyJALGJYiUSrebN49LLZ7QVZ0uiG9BhYMqWI7FAfmZllNWzunR1YuxZlyvznjrL
	WFwWHQ==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bth55gnx9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 00:48:35 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-78f9d077d9cso35762247b3.3
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 16:48:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768956514; cv=none;
        d=google.com; s=arc-20240605;
        b=Y+rMcltu4uob9xJX/G29QHr+TpVyEu8pmq6SsRzF2oNvkasi4hQPKqdTu1PGtWMC6t
         SUt+UB+VpcYCutX/SEy/XDrPDWvuh2dDx6TAeNR3eIdu9j2nSRlkOXig0wwczBTS2ceA
         k9cQ3Q2+0D6Q/uW7hmQP/PBC5oGC0xQiloQLdjN8MKjJZ71sRgdGFYffbDthi2swnnwl
         L0d4Wjw1tPS+ndM1VcBYVlHxybhflqGoOXZ/YxigVTrVrDOyWdxwjORY/vIGrQGvoczf
         iPELCSsk+TtsNez65wEd9Byh1Z5weouU4ihSNdLDrx5jpzOxb7wnJVheMiCBR6m+nu//
         7y0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pd/iwAHERZzLpKzHSHXXeE45Dbzka7On+2WGfbEfxtE=;
        fh=zG6l4MpnN0pimYJTNHdPZ5Qyx57T2wk94vZuTgSYaNg=;
        b=I3Mbls8k2bW+gvwonMwlvBLKd+XvlcxzoYiPlSt3yEAgF28YnUW6ekCgKO60whRuAO
         NN0pmsMy8htCFCgjZFnTw+l060zuwTYWXsU1dD8py0vrJ3zQVDqlhoToEzL+8c5JvzS4
         BPmWs1P0sLeb8pHVWAgvvisv530uxtcMTK7daOt/Knndh0t+/dEfr7cFG6VcmAcpzxak
         jg183zt1pJHUT/p06+uwpc3tZNj2VMcUxKMoTcZ3KwANG5/SjrnUPbFs2ZCRJeV9L87t
         V3kOtB0XoLKwkYNwMrQ7nPAA4EI7u8em4ZZAx/WZbpHPHu/6McxHo3ZJrtVQ1/FZMVKd
         fJwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768956514; x=1769561314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pd/iwAHERZzLpKzHSHXXeE45Dbzka7On+2WGfbEfxtE=;
        b=CznHsiK3xLNvOZ2j/AtLxL74qQxm04QNu43WfdIL33D6bcycUox4s1jsZubeUKUHkX
         QWQnIZwAYI7G/KJr9h1ttcPnXS9ieLhLgfrBdPtKa+yf9ZFlPxPLglpPWjanp2l1IClk
         1Spqd4ElOvZNDx08YorB9eXJXiWlg4cXmLp6RyT1W6L4hVrRKHGoBXbwFuQWMW54B+r0
         WjsTmEW7zLZ0Z5YFzZs1lihObFWKTVIa4Gms1l9w81PQWuNhqz3jM3btu8lvw9CAV2Px
         8PhTaTi7YLuMgXA/5f+BKMlWiwNoXTfEImThsQzcEEF9sv20HuGRo20DUE7fRNsjc/Tz
         6UfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768956514; x=1769561314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pd/iwAHERZzLpKzHSHXXeE45Dbzka7On+2WGfbEfxtE=;
        b=jn7HtuJgN7nIM/0ZD5jHcMVZfrMnsy7Z/G3761fe3XpVoPEdFDMj73ARyMy0JYqBO/
         rQ6F3tLuQzYBNNV+5lCcyqPLDM16KYGQ2WWq9uf7r4ZrWGjcHzz730P71n1YfmAsu35D
         UKOdeT+/msNsh2xeoV4NlCZYh2OILfgxg4LDziWgLL4bSdw35DV/KNwj4Y/oLPYk146d
         b6fbfpb2yjpG0wksDyTKgTbauWDnp++1r9rnMQOoX8PGrYt1ZTfhv8q3E+CNvrnjPBzy
         BgKkJ16nDAtBPKJr9f4JXNG2yzAtqC4Nt+ZPYLSsy6vuVotWawuUV6sCS4cvra9sIWq/
         SYDg==
X-Gm-Message-State: AOJu0YwzdN933Q3UoL1RYIVMmb8F5XX7kv54OsIOLBENet2XJ+OKkGn8
	sElbbWWqDZdMVF5nVNfvmzqIfJcyKxSrCVdWWRYHmZ5s8L0OVQ+Bb9s28shxUYVzzHDaBSvYwnt
	/0kXzvJrt91dMXm9F6zceKebWeF4DA3hJPPHeKTINVzPK/arIw6UU70elV05ohAWmdkuWmJSq2D
	djXUNbJOIncY3LPuQN2Ske7xCBtiX9fLuqc3I6g4o4
X-Gm-Gg: AZuq6aKYPlvTFnhQbEEtd/D83e8ujDJasZ7lYO/dgcxkC78HyHr3l6xsMa+u3yYTLpT
	TrrR9vSNwWFeEZ460N7On0VpE4iSLcCllvp5l+zP3Ztt1uCjEOqu9199kNtmsdbGTWAn2dgpal9
	jkLtsuHqMZZREij4N5apwhZryWWUtPmOEmja3WG640Gbl49J1yo7CBWYoWQv/OZvguAuA=
X-Received: by 2002:a05:690c:6187:b0:786:504a:4fe7 with SMTP id 00721157ae682-7940a48c730mr30332147b3.67.1768956514254;
        Tue, 20 Jan 2026 16:48:34 -0800 (PST)
X-Received: by 2002:a05:690c:6187:b0:786:504a:4fe7 with SMTP id
 00721157ae682-7940a48c730mr30332067b3.67.1768956513921; Tue, 20 Jan 2026
 16:48:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112213612.2761854-1-nasser.grainawi@oss.qualcomm.com> <20260114194815.1049888-1-nasser.grainawi@oss.qualcomm.com>
In-Reply-To: <20260114194815.1049888-1-nasser.grainawi@oss.qualcomm.com>
From: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 17:48:23 -0700
X-Gm-Features: AZwV_Qh56zO5b7EVZSfSdcozmjutxU8lEwjr7FihDv0ELwhHvul42lmV8S3KTV8
Message-ID: <CAFcKa=9jRS2-6wdhUaV0riFNaM+WB60BMho3pYQs_YXU2EvB6Q@mail.gmail.com>
Subject: Re: [PATCH v2] submodule: fetch missing objects from default remote
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: PC1kxlfC11IwHDkXW4t2rlZq6s4UZP9O
X-Authority-Analysis: v=2.4 cv=Oa6VzxTY c=1 sm=1 tr=0 ts=69702263 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=R8ldu1P_3NlJKfyr1kEA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDAwNCBTYWx0ZWRfX4+AI09UBQIUp
 VkUTyC1tQyFrgIl+b6sZCExIE1hGt3nmJKiLrLPIfcj2lojOGTWjNxotkVlfUcqkzHVIoxIX4ol
 wPnvbMc76PrOj3DX5NylE05WZK7Ukx6vYNbqqwUkCk3wIce0+QBtOCcfy7Bfj7mVq4BCNsLwyR8
 1WNVsbqFhCuFeZW1UnR6hElB3gWS+CwZ+4KEF8lRaIlsYe+Ml61w+F9Q2Iae69rTpS8LrGV7G56
 onu4s2yQdz5Ja6VNPcm/Dr1GICnXS2jAbnWAzQ2Gni/IvMgKgbRcrJxukDPoflpaagv20s5J32A
 N5DOxN1V1R7BQxAc8j/rhevaV14UlBVgL8tpaPUgpWBIa24HwWFBFcQTohrCsOl8GnbCMQkJRS9
 KjI1HfmgfTbBc/M8JjfzoYVVB6gRy9cWZwJye305RWQiKOvkfHNsPHC47qt6PjZLpqTVGhFumHR
 gHWm7bO2bPQ0aqweMfQ==
X-Proofpoint-GUID: PC1kxlfC11IwHDkXW4t2rlZq6s4UZP9O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_06,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210004

On Wed, Jan 14, 2026 at 12:48=E2=80=AFPM Nasser Grainawi
<nasser.grainawi@oss.qualcomm.com> wrote:
>
> Signed-off-by: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>

I realized I missed adding Jacob's Reviewed-by.

Reviewed-by: Jacob Keller <jacob.keller@gmail.com>

> diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
> index 45f384dd32..868dd6d130 100755
> --- a/t/t5572-pull-submodule.sh
> +++ b/t/t5572-pull-submodule.sh
> @@ -257,7 +257,26 @@ test_expect_success 'fetch submodule remote of diffe=
rent name from superproject'
>         git -C a-submodule reset --hard HEAD^^ &&
>
>         git -C child pull --no-recurse-submodules &&
> -       git -C child submodule update
> +       git -C child submodule update &&
> +       test_path_is_file child/a-submodule/moreecho.t
> +'
> +
> +test_expect_success 'fetch submodule remote of different non-origin name=
 from superproject' '
> +       git -C child/a-submodule remote rename origin o2 &&
> +
> +       # Create commit that's unreachable from current master branch

The single quote in this comment is breaking the test. Sorry I didn't
re-run the tests before sending the patch. I'll wait for any other
comments and otherwise include this fix in a v3 tomorrow.

> diff --git a/t/t7425-submodule-get-default-remote.sh b/t/t7425-submodule-=
get-default-remote.sh

FYI, this test name conflicts with the new test added in topic
ar/submodule-gitdir-tweak (they both use t7425). Renaming this test to
't7426-...' and updating the name in t/meson.build is sufficient to
have all tests passing with 'seen'.
