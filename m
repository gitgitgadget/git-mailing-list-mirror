Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B1F223DD4
	for <git@vger.kernel.org>; Sun,  9 Nov 2025 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762713327; cv=none; b=HR28IAZ7ougxaYmBxhLI8zINwE+E6r4uilNyVV3OCVLar9LAiKBBu3uoBF7Lso1ZdeYI3FQ4t4qiHVqHx2DgagPLSL60ildXombut9rzT/mN9D/0OJHGg824dQhcQD2MymoXcLquYQ8aU9ZeLZEMijDY+GVzf8cL+hHGYl+lGWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762713327; c=relaxed/simple;
	bh=nDhJPRExPZh10vU0dAtrNMuB9IEETyXqpw6VGMtlePU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwzCdDTFFL6gHykpIbYrgrkgG6jYCSk+xDvICInNLip1ulTaz522kflfh8YXGqFlvIyibfouP+4ULpmfpsEgbVI0a6XFxZwqy6l/iE57etZyIn/yhQIzgAjLjZ3tGHOifDW3FEFAtgZiGHJXDAeaCN/q+R4fTgimin3Mz8mZmr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=s00vr44U; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="s00vr44U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762713313; x=1763318113; i=l.s.r@web.de;
	bh=A80kapPOHYJCfPpGp+Ljk2XKStmwq5pcdwBucwXug0w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=s00vr44UWGQN3NLf+3+STb5+7CKRwOv5LHAjYh5VjojUPPdWkMp79qo2rBOLkw5x
	 SRuoU8ZcTddHKolr5VJAzFsPx/Uu+bCKa/nNPX3AGSFHqFqD+DD/ujnkP4v95qqSu
	 CW0OTNuZZ+NH0X01dniKvUTzk2E+zlJrLjVUyLgXo8WjOxkPEWDt64TWUNAhy05mI
	 gDK6kv/vbv4cYRkq2xOBYkj5QdOxQtJkqjwqG14MxGI1XsKk/sqta5ixwBqKHk2jp
	 jIcsNMYBObj3UKF0i6QlkLno1IEN/3swBsQWC9dh06jgDpzFXQsV6m/R2Hf67Kk2J
	 fC+de5cG+GUEabzHHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.146.25]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3V26-1vIiDi3RuU-00AgLe; Sun, 09
 Nov 2025 19:35:12 +0100
Message-ID: <916cf3cc-185f-447d-845d-a65eddee4a36@web.de>
Date: Sun, 9 Nov 2025 19:35:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] diff: disable rename detection with --quiet
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Git <git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <CALnO6CBsj+aMvHJoUQ+LHAtXhcFhQeH8AuHyrX+rumur6MQQog@mail.gmail.com>
 <8796cd59-2335-4674-823d-d682ce7b7f8e@web.de>
 <CALnO6CC+ke1L7T+dO13B0FSjLyJqihKHKZaa-B4dh9guxk7z0Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CALnO6CC+ke1L7T+dO13B0FSjLyJqihKHKZaa-B4dh9guxk7z0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nsGd+tMxy3vGXc0PXwuXSGqhCXz3+udHJo2DGDTPIZQT4PEUyXF
 4dH5G6xDolA1FgsKxD/r2a2liyVlWhjkOt39gDJWDCNIgnRZbshqIIRFMsJua6XZQFXrCol
 C0+l0jzyHftFn20Nz32/uB08GD7xjWmXYQ4IIkI3BLBXu++2JTavB4bYmq2SqknGfSizpFr
 rIg62pWwwae4SIreODTpw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5LctKcrfXcU=;9evbkVJeLaD0vg7bInIhcN/h2Xz
 UW1cF9GcIDieLfzkldTVnGkthy9hDd2BF9rD/IcN16E7uzQs3RNSGbKidkK9g/sTxIIiVZ2ih
 EEkelv2zD0yYXHvsxs2DRx/LC8rWig4An+7ye0W0Jk5s2DEDO83G42yQ6jil4GzoUcpfqlRsQ
 mv4CNFYgLdxkTqNkW+SMr9iqUzFgsTdXHAoyS3Q7MQYXg789FqFc5q1fn/LYfVnNXzoZVe3k6
 QG+hkA2eEsVQ9B0uDHANa22BFLVzLORM7QlUUT58kwPiftRkmtWD8POSi8T9aCOLL5SlQC4w7
 WF2T2OSxWabSJGmaUnGUOtgq1OCQuEi1Rbgrd307N3VP1JuDWko4Uv5Y4MQQLjcFG9svkdaez
 gC5bCs6b/4KFdf0brHuO8SBOPGxSLRhQkxqWlDL+o4QbyZWpBsSu8p/4mwGClwWnOp87K6UPC
 RMUh2Q4KCT4lHHhpX0S6IwetYNNa0RMOjPa5vaKc9Maxee+lGyPt8Jj6+bUsU4FwBXsnb3x56
 LVHil7JPAqCfRdXg7GuxxHoyay7MpwpQHCQLmlJCPOUOHz53HD2Rf3oJ5bKM5+jpTqdYw4NiH
 eRDGfhFwtBjnetEsjtwGNCNlFRTz2+KPpbZB286SoLuaKhkCy5oeWwY/QLMlLRHiSDwEzkGEt
 ODi3testrpLgBnp1CyByGT4W8ZbtVFzk9RvE32EXM9beU5BHl/HDhUtOmVO+vLyd6MIqt1ZTJ
 O6bc/gIzT09bZ/CrxI+V8jJfqJ7WT7IdH8VHt5r5gpjPya42WWh6OzyVrXoC24RvukhGlK93y
 l/x5OQFSzerHsz83DQC7Zz575qkuRYcwc0rnZ6GvioK41Zkqe95oj2Q2bxtNuTGipsM+NVY2P
 UMU52NrZzzSJiGfVx7NEN0m5CyYmMna2DK8JrkHj8RzCCvtNh9CmChc0XQc7kBktkNhQ5JBcd
 BTZYWtW43kpHIomUWCjfeqRGVlafpK8Dgml4BxbpU8rYEPK7rogIo3zJn08Qj28ILuDVF5++e
 7TVnk5cMpGeXNZswAyN67s82Dc1GIC8lNiQNBwzJgn9n8lnWoWYqnRWN53Dh14epRtf06wmOy
 uwTSA0sQgaXh0adb9hHnVKVpGFmgF9x3KLj2TswmVpTelCTAxqVpEBqAE1YT9X0iwezXivRlE
 6MIFHYuSbvcHBM2GnnAgK2wia8TMXD68c07Vv/dJdSHXw1k1PUMghL1EaNRrf+ystixitC28B
 3i4ntEhkFLLwlMGRGs+nTpuJF8RHDhlznvI2NmGME0iKxh6UMBIOxtvsPY6/Um4DlXkiYWL4t
 fySNQBIXSymt3PyQXSt94bRoqkSvktPqcB9Q3cu1rDlFbCPJpK2gadiT86POmEpRCC/xVtMUY
 BZsrfALnIpV1Da1RK6LDPbyr5Immb8WZkLcU6pxYxKoFi/DAFcB9Pw9LcMEsoVAxfwCGrJAIW
 2VPSMLRcN9MrkqegKW/onLAEjV1W9ij6cznE8LIdD5ZldLiIouFXijHstl+bOlTbfa5LH7Zf3
 cVsvZplNnSuvPfNywuOacpiO/GKevucSt64iNXijQny1tQsQ+4iNgb8DyzpPBin1ONLHKws+F
 KpkHS6Xmm5Ia7cKDpBiID6Alvl7xiUqCd9I2zlXueMD4It5ITd5WI7Zphur13on/jtsnzojQI
 yXnaVSPrOXX3OcfASdBycIwDujHdDOaUiT+L4qhDOpwWkAci4fK/CgGHPenIEO/3bYIvb7wbX
 saiS9auTLK1mKR8wYIr2INsHtoeQ4gA8BjCj2xU4c5A4Ji029h1vvbs+lt7SoSTFxFZVZu3Pn
 mqhf7PqLSLcFbdh1F060NRYsyKGlELY98brHfsebUDfGJ1xcP6ENg+53XtevTfHQfecyyOTH3
 rg8Y/IbVAopD6HxcyBJm/FFcFLjPSWgtKiSKtl3lEVclI39OD8D4E2/xtcrG5y4EV/s1IeuZt
 IktuHGVh2R+dGXC7yzGS92aorYO1ZpAUVzVQILbJeYjbMBzX6b7wFErI9Ghl0XozQNMLFp1TK
 o2uBi8B8XnW1oK592o7sDDE19XMDp45AeO+0jUwxEbTxq+g8Ulc8CN6ZOUk1ZffEBAZdG6AN2
 F2EjLXIw1ZfjP/fb57dC84C/7CdpxXjJGBxBvpKgD8MzhhKmhkUiyEA7gQiDBTNkQbMcZ2lKr
 i+LTjjORzzB0EUeg+dg/FQVxDofpJL7lLffMURM8mvl93cMUP8S4hQRzznG1/akx0IYD2ntye
 vYQWCDXyB3N9emu57MfrWjf2I/in17XvxdmNQPSuqLBRyZ5UEVM+LhqNytXMHnSOyXIIY3enV
 l3ab/e3HHeJUgosvyXm5MeMpL+2yKhvJmZwyRGu4C4MKDJzB27G09g2FUS3A79W3Uo5Mm5rI/
 F+p+FIcTvpF5Jgwp5yqRHQVj+Lv2Wxb1ynxNma4r1kA9uN8ijvw7lVG6eNGMykLCib+Of7sgT
 CckLgA6d5WlC9Cpnxw7aLD4oOoFM+cTWME+ZDZi7Ecev93Y4DeMAQ2NxKbssAvDjZF1NJm27w
 ulNTVAjNq21grysKWrFLTKw83wXZ58whHXDLjPqS86XHKZRZTBxYbtkvR1KCc9DjBdXmX0j6X
 kFjYea6Sw2f1oHgMjdWeeTQvYaz4gEZV393NlBHSzGk4DkLQC4lr8COsQA3F61ML5AvERCcSr
 6hwhpCV/Nhc7sFogQ2egipDR5eyB/43IyBBafRrUkYKJq/p69a1m6mYmLmvsJwFoaskszQ6Fc
 qW5vOT5sDyqDVZfr9/UwHZT5f8vpZUvw6LkCMcrjsjIlkhMvE4npbrtOJALsbwURRJs0P3MG3
 KMgyOVOi2PXbs7bDBRGBXNDn+ujLdjhJKwq7G3Z3+SHQPl59BUtWAUnGwUChHvVzeel4zyFau
 V2URy/amrb+uxCWfLzU9zAnvwJQdh+6DBjSm+ELGOPqNGAy1eKDE40d8/b2cLkJW9hpRzHMau
 vqhNCELvr0b11AOsk30eXlg+NxqwBPIujgbm1EaKUkeAWRu7CbFtNAWNyR86cCbcF6/IpcdvU
 udGJqUNQS1wXaS8xrrGNtPaW6GhEC+Dljag++2xvHvW5K3RtJveAS02+QZmJVmSG0pYHf+j4D
 pRJuU8iNROkC5T6DmwF78MixaKyI35a8cZsxmsM0aaqanEOPouHXUqsb99VYZvTh3hj+x/B6H
 CqespzC4z0j1U39giDANTILfd/ZKxfFV5678/RF1MlH6nFXbb75u21vkqu5oc39h25XvYuu38
 jtksx8iaiNyJWW1YyPRd/Yp7bs/nfMK/eOTzU2oNFTDVNedfCwTOx5DrvFCypDmJxEYEsv35a
 piEogLwNHj5OU3NfUMvTvbXrDOUE4b8XBltF+7sC/VspzcGQRKbsJA1xutKhYZuQtMRbOApi5
 wPK/3Qblv5sd5jaWUJG5c10SElR8521HI9U/2U0wwZCDfHIgdutLfceGndFVpKm8fOPyCvXne
 jgSyAMgojMUts6ZxkOEAAF+DIShWhBGc/+LBGMcUJPATDV983iGBDHADNtrKe34eCoEhGGxWC
 KMufAJD9W6NmrnFmOQ6tFIEfGJqEB0tEcx9XM/TJN1iDqPALk2FYMgxcEJYuwtzQoV4+C0PNs
 znLPT7vPpr7rAzoxrjSwWvjv7J2CCd8ST8Sl3Pn6lE5IkmgBiUEqdDJ6CaTs2gz17rrBSipIV
 NnsaQ9RgTuKOQVBicPgNzYBDbaStSasfP3EifdL3w1k1V9Isn4FETAe48Qtk1haJm8Z1mEbdJ
 AW2kpC3y4uaHFmarEu4vIeIDx7/5pDli0UL5e1lSsgR8Z2zqR50w9+k9ytiMw5NfLLMDiURIH
 TBGi83JRE/b6F4GdpwTPz12ap3LUUkE09RbdBBFEhY1AaEGMRhVh9fOynE6Ax4OI9+GEkihle
 JOCoY/XXGN5WQjxxMpCKX+ayKMEqV1QD0WeSZcEgYSm6lj1REHakD/OK+xXBL6nwg02UvCVML
 u7GWaW+aC31SSyrcFpLbbRaBksi65OyLYvB4B0lF5tGDu1EVg0fhMNeQgiRbb5JpNT3ZkKgXD
 idynTxxkV74MYmb7h4YSqLaBZi1fnPwoHYjT6X5LWfXmcKR5mngTubu0SRDKrwx/uKnBK6z4o
 tEt2lZk0A0sMF32ms8ZK2RhKiDWL43EyjJBM3HvDwxazP9JYTUUZQ7be43W6gYiM3tSzY5Gcx
 XxrdpiYz+a0Bf+pkHzJcyY97QWaxZkZgkiEYYNbXXgBEVvKgKWqXaoHdD7AGVQxMyEq3WpjYU
 GEzK0xfE5uW29weqZdlRj8nwF0exY+dhwXvmPMsEP2KC8Z4zx+6B3ZwEjYI0q9hzzVmGhBpD3
 Y6I4cOYiGriZ95syQNA/QRIt2TZOol8ul64Z3dBpRdC7RSiO4yifHDNOtUnOIng2ViqRNmlSn
 Rk/2YQbDnky3HjnogavLtTYgqD17ids5a20NONzUzr012r2Ei9n05W8EGVwwTf7jTslujTUV3
 CIM1Lm/KX3naVuoab97xVVlXAyy6ygEqZ2JHNuJPYwrs8GJxPdfPaSYu/fEPWQ7hTCn6FMGJI
 NLLclNURmNpQQ6VmqzBTJyRqDB4avOHobQNHwLzjxr1lME6dwX9HuDueOV3Xqu8p1SDKDX1E6
 63tK1v05G1d3khsPGz0z7wey3x76w0e+v5mdZjseN5cNep3T6srItCBVUgNioLckYnBMkrGs6
 Wyag4YD+0otyiiJ1uvNSCykm2SiS4lcrjiKCRIqBT49guAhKuUnHFs4LZUVmDdHbZ++sw7jkV
 bYBlZ/kYXgi5gUZEZK6JeXmzmT28jlllMSCA8aDQGiQwUe2GNFKvmirOmXHTaklPGqGQnMUs2
 40a91yro4YjrJjA1HtbU0C5SWntEKqBF+8Dklqscm99FRFWv/x9kJijj45RoW6KLk6TeBbXId
 ZerVoUqLjstXsEHQ7gNqkrddfrk8O34zSVj6VxA84udE7LhOHVv67WCL212wl6dzw58SvqsE8
 yVaD+VWgolQnarxQ0d1LS+UCdGf1bgBiHKJ5KzlrL6oCxsZ8w/+UaIYEJ1/XCjGbn1GcECdfm
 BoybW2G3U8W1mZ5ptVzEPmzSfg=

On 11/9/25 6:34 PM, D. Ben Knoble wrote:
> On Sun, Nov 9, 2025 at 11:43=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de>=
 wrote:
>>
>> This actually fixes the error code when using the options --cached,
>> --find-copies-harder, --no-ext-diff and --quiet together:
>> run_diff_index() indirectly calls diff-lib.c::show_modified(), which
>> queues even non-modified entries using diff_change() because we need
>> them for copy detection.  diff_change() sets flags.has_changes, though,
>> which causes diff_can_quit_early() to declare we're done after seeing
>> only the very first entry -- way too soon.
>=20
> This does describe the behavior I saw, but it seems to me that, if we
> have changes, then we ought to be able to quit early for --quiet, no?
>=20
> So there's some other knock-on effect that causes quitting early to be
> wrong here, and I'm not exactly sure what it is (other than the diff
> queues being different sizes when we hit relevant parts of
> diffcore_std, though it's the working case that has the larger queue).
> So I'm having a hard time tying this paragraph to the actual issue
> (mostly due to my complete unfamiliarity with the diffing subsystem).

run_diff_index() calls diff-lib.c::diff_cache() to queue up index
entries.  As mentioned above it only queues up the very first one, no
matter if it's a change or not.  In Git's repo this would be
.cirrus.yml.  That's not the end of it, yet, though.  It then calls
diffcore_std(), which calls diffcore_rename() to remove non-changes
from the queue and overwrites flags.has_changes based on whether the
queue is empty now.

Ren=C3=A9

