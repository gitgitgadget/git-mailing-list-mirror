Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5943A35DE
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 20:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594754; cv=none; b=s8mYiechdskaNGAyOvy9gJBxjJy6mse/h2WJNsHYtIoNO9N7XjAMI5Lmm0leU0aWa7nnKYb4k2CBsLMGGrv7tPyl2xHEWBFzxB3fENH5nI0th4J1YapZaF51UsJ6QvVxT1Mzi6o/h2XoRqyJkDHJMFvX/NNmD3iDMRVbcXDTbbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594754; c=relaxed/simple;
	bh=jbtWjm5EL8qquNLlBNmDGw2jOZ8IC4H6kOzqu1O00II=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvkol7g2pwGs+TVmkqw/sbnpc3jQqW2fnlHcw6YQr81QUerLJH4HBFEXdQpamoXmz3DTyqLBNjImpaVOlSK/wAk0XFik5AdW1878UDyuJjRzqLHaTZYUl4+FLWaejglVMYjDrtRK2zS/sYseSDnbxAK3taiqlgdGnUU4CPNCJqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=hZSfyGDl; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="hZSfyGDl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768594746; x=1769199546; i=l.s.r@web.de;
	bh=Yib/3fNJdHzZw1Nd0bjazwCl3SENn2zdogf8Y9RwqxU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hZSfyGDlWWTQq0npytMinhm4zayyIsI7gpm8N/V+iri1fNBSEPPj71jv6rU98zA8
	 OwTHnl2XjTiBas0FSMWACe7bPpl1Z9z63IxASmLvlK6GogwKoNa15JPt3vqIvdYPp
	 XJ11rBN/q8hM1ht6VeNO/H7zAVJ5Yfscc5yAaAqf7weFqxj/mFULps9v2MB6QiiMa
	 ce9uhAQXRu1KkMEAKlcw1YTmW/3O/QBjiczDfU996MixzTEV0vQkG1C7DgMyczA90
	 xta+BihUudYoirBQSDTJH3owqCmClkULViWk5iJpcZM3l++9C/abvRBjsTTr7gD5R
	 9UruHa2PVWm2kuZC9g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.19.215]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mv3UY-1vyNCc21Fg-00r1J3; Fri, 16
 Jan 2026 21:19:06 +0100
Message-ID: <07ca298a-ad32-4998-88ff-d69c04418fdd@web.de>
Date: Fri, 16 Jan 2026 21:19:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] xdiff: remove dependence on xdlclassifier from
 xdl_cleanup_records()
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <f9b10e71d23f8b4fa34dcffb371cf5a173760409.1767379944.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <f9b10e71d23f8b4fa34dcffb371cf5a173760409.1767379944.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x1f50lNyi9gJO2yxyK7WOzDq8DlPlUKaK7mA3yyotAaZwElzduC
 2RRvMxgmn4RqMf3vbCBJy51I0vYE3mOK/asVVq+3C1xKumt7l0TGYLkzdCJp6e9/n1OsuGa
 b+iOZy4fhMI3yvyGE4hl9Ly0EFWuhTWGVj3pG1RCimeiyMgqWxQ35cFzuJSiBtNS62FbIxY
 ddDDZ9KZzkPdiMzjSEAYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:O8IZb7pRauo=;qxazVfg0byi9gVWy+1ADgil1KCj
 eqMM1LbA+sdJ24A9URC8vg7Ax5MhhFx9t67YiWoAIyimxx++zganGvyV+In3LlEUtSD/EuqOm
 wfR6mpccXb3gppGFC+WX4qpN+OJUSlDDlbPqkAisqIlJ+glS4dn0VehyEUdy9ptKbKnTR2/6I
 92MpHos4gah+sM05xnXd1XIkcBhaP6OCUXsoyDp7M+wq4Vw8KCCdbUxVk+vJcqrgUzRS36f6v
 27PS6jMAqhB+h1EtRCQpsX5aEJxkOUr99+FTz5ykB88HuJseXcVry0T8LA2h3Q9qbBIiqKdCp
 q1PmnlYDOH47xjTMf0jaKWPEI1yDwSqqhZNbVgQU5rCfkEJguhRGd6G1ETWksoy9cnZ3jRdGV
 ub5FhzHeoeZ5d/DLUgPHFYVEzGdTgY1wm0AHQg+nahR8NiBh4GQKtn5djsfyQ8iPpC0TRm75i
 vrEVBPBgODIQcqP+9yn6kO3mC9LT57O2/bcP+1NxNG04mYtU0XUfJ1YKBnF4skODe9b9WRXnD
 b28Q1jbCIooEtA7qFTcIE1oPfvxRRprjnyjJAh8WDNWHjfvKaRJsZUpVx64I5I0giWzdtJF1e
 w7bwO6HWZPM2pfb0oyCXMRF96BkIjdfe4eUKg5eByFe48niw4WjOyKKD+bP7ddQjHOMeEaVTd
 ITGrQFOmNrF20HvsoR6HPlk5xHW3dLI0Erwz2fiT2gWLsH7GRef3+M9dw2eiFW4XMa8s240kh
 Bztr4oSRFOyzy/FQY0tey8WZgnjzDRbJBWivPGL0eW5BLuN308qEZefjK+1cxSb2mBFxXCm8s
 noTMJnnZuRd5p0sEimrV9o4zK/DE6jDHSflxpSNF7e/CiQ/209asbcztAlfzS7THv7t+z+SzD
 nt/b5pChI/7KWnfMT0BA4HEYliikheo+Bq8xFaUokHywpysIuqZ6yZkrjRdvFrRukPK3WXJwB
 Zqk2PG/uPAxnxeTOL9JyoRXZNU2i7S1FwVG58sFjqRIiq25ndzzqD3gqn5Mz7BGEg5hfN8yMO
 dBNtEwHsdpFrViLN9cFRk/XAvEeeBrM8ZYbf4t5D22a2ch4lPqQrnJ0IAChfLojVgUHWCUCLW
 iUP/3MSj7Tsi6v3uNDYD/7C2LYmfUsfr7S+EMzvrN3HPbGqwxJjNeD3trkGRKhq7qu+EbKNIi
 1X0Wyg4jhEMlvELQnPonLcb8ke1KAUoU4tZRXTEw63HBIy+7twWoF292JpptGEiX3f4n6eSCr
 pvoB274zHm7zd2NZsfa8Rh01SmHOX/qnkRZqcjT8SRmCQcaZO2taPP5FKzGqzjDzobCuxVdP8
 +sWCmIa690BFq924QlhsgFKRu0jbICYd8YvBvBp/e9vTxs51HkZoRUZHdzEhKO0oyg4Bv6qNk
 GKrZlDT6wnz/XhOUmJqy17d4l9lV4LfOXSF/e0tBL3BZi+ftqg95RpE7AVPJ8BctCl2SdOs04
 d6Q8rQgu/2pyRf/QytmwTf1sG8kjISzFGN6dGiAnTPUanTY8x/sgPLCW5zfePDHeDuOsnm2s0
 op7maFb5ioiF4jLtLUQB1tnLg4xpy2FgvP3HywA3gwPUCzqTil3R+smRJvFE98Bnlu4GMng10
 H4HUX4/S4MjHDcEhMzvJ8NohDDayFdg7/mw+a+JTF7xU/vQH1Q4yZLrEdvg4PkUPvBynm594K
 p95KkdS2Wk6N5nAbcU6YXqa+azwzYiY58J/3B2x8idx3iSXTVfFhkdY81XyqTSNGTBnnE3VrR
 TiZrlbLlRd+MN65ZCSj0WgONxJLF0XCGwHlmfwQyhb4fyNAUEBHg7HL3CjXuv35e6fMkeifDe
 XGJAago6RLZ/FEMECQe0qqKSaPBfUjKaMtcWCEq/hLE4SfAeIm/9LZuDwWfdLM/FOT9bIazD8
 libH1JI48tNznU6ZULLSBSZSCa2EJL6Re9edy0VPHoUt3+FAgWbfDLOpBwG9NncoLeTpLWw3n
 CXuFom2mPwMZPHks9pyDVHibbkkHVzLhO+/rIICcMMGmYhXP9ZohCXxLlIKxWxgKGKv0yWDwZ
 KjoXU2DgYA989vY8fmeSlsM/D/p3KeVQ69lDxPw3ntq9h5OcDHbs36udH7ocrfU+WEsbRZ2z8
 wiRFI9BSRq7OpbQyfltdWPO3QfKB8uA2uB+aa4fa9O48+39CuFaiMng0U11iSm2qmMHjNHO2h
 lr8jiFEfFebM5M5Jx/C9p7OZuFegHcL07OTEi41hkUCblpQemEWKFOYXwrgfh9X/sMOxLi+7n
 ogdaXVsY1oos7OFBx9mxhjk1U/poj4/YhW7vqau+HV6SAadroedE9rNfEqeGJD5VHQ0kIGmpk
 RAzUOi204cOQuBQjWf5/G8dDOqIBsVDyWFn8CHKZJc9CAPRe0Pk7cxAju+lXbrWh3D8qnO/5v
 j35/KfHSxHLd2vfpTKMRVyWCwBRa6CJ3YhF6zswX5UlBPEK0PCbw6RpSVPK6N8Tt8KMU8kxWX
 GjwO2CcvlwcgKwwia1fjZ4c76hKp4HJDMpf+gWB+y9wZtWz+CJ4E8sCCBV5mwcTVW4iWX6gxI
 UcYAzkcpksGOm2CUtdzpn3inOg9BV55Q0nZyEIufAEZ+XJVe65rzcV595aUHmWQjiqJ/rAmKl
 4sb9NwQePQTcPnPmMVfq5MLrmN0+uIhXWHZesdkKMuhQlNg1xmRP03TkUXAd/GKxXtmj/NmEl
 TT/rqWmtmqFdwCG/DMgQwFRwe7r4auBLSC7jP93nU2CKw/gxrB/lQmIkPM3k3lz2zJ0YBruB/
 iYM8XYpSlx4J/Amipzps73Kvu8Zbck9y39L5J0mzDYgUvsu6tmtUgoFMpMHU/vLU/lf4DYGsC
 MlcuwkdSs8MlaL7MSCDqx1mVcFrUrY32/0QTjCNuVJ/gzj3wbBl9qF52G7nF4xn8mN8RIYieN
 9Zl+tRVaZFXIGc9D6vJdPkpOVvhHuWSjvxK67ak7yLjV5DL+2c1qTe3EqczufLpFD/QwAcRKg
 Jt3flCeejEfhs5FjIg9DNnIUin5ygt2A6PZDt697WVLk706uoI8WCMp1KWcP+YqAcNtCSW09o
 iKXtZvn+weQpkLP5vUkQ6b2jF4p13QzRWoIY4VGDSbmvRtC0uaDQM/iYlJuSqGYB3nvbAnO5b
 MgAqAB6Y1bnJhoDjWToZ+r36mwKKZ6TanW8/GUVo9E+RN2Sk6qjirm0Y/ZgAN9SHOznovFDzp
 EannvV19HFXNfR5Z62k87C4rdJlo+tqkna/AnuQcbkeu9Nu9x7VMCvlkKOtsBPSUJq1FEo7L4
 jS61/+A4xzx2gJM5XAXoTl+8cZ+RT7BJd2wiTuDJzF6LqSmlp1jEr7wNfu6iN/tgdHueMoCgh
 hQTo9bJHia++Z1JA5QgMxirCv5YFlRA1T5KX0lL2jei8zA922R3ukFY10xlNTHEYQrQ1XldQ3
 Y5zL37M1yewQ/6mHKUaPYjXeljp2wMN1xdiDLUqnn/uVK9ObU7WHtVVqgqBilj+MzYjQWPczb
 6ryEg5TfQJyRdz0OPDUU5mKpBXjMa07RWc/gqjwHmpeUR2AQBZkKOCSDZV3OVXH9MW4A5PG66
 bZymTsni6Mvt8Sv7aq5V6NQLH7rgABLkbfbpLkZBxcRZ7AZqU76Uci/Zpb3e530reAFXCUWUK
 GTBbeuGk9yfvMxCcs+TPqL9NuPD2kFXndWDJzGhV63jFitKnfgUgmiUJ8JEY/IEi/iSGGzIwv
 iaHn58rOKJjzyPTRly4/LIdwYt278B6ukZkQBz+meWBPP973+VOP751v3yJQoqePg5DA5WiR2
 P7/KBjCBTCHYRIwjGaRYQhCeCVXHdxUszC7dNhkVblnuzfARsdp+IUGvnpLskHzPs+fHcZnfd
 Pyvhm9cmmAgPLpCDiV0osbcZgjtZn1OStjlA277+0hR4U1pXfH2TgALg9iuL2QdCAURlQZQOS
 kPwB6yJeAScezqO97Ly+A7GuHrusk7EhnAPNNj7qO9PgjaUfEGw4rLaWYAcSS3fDN12GuK4dE
 uYyNxJU76EPO16tpSjdgZ0G2lnLaoRDcwawpDdlX10W+zuCNMY9EOOVYxDCK4pHW+/XdYtSRD
 tlVve8/mClLf7ekWswSWrq1AB2n3d/P8ibNrbKHrGSB5j+vo93KknjEexaZc3CNb/Piods5Sz
 NytQvpPIaYVEP6S/kNZyNfgddV6drgtfccZvhvIsCvXDX+/WnVY/hZptLho7cy/wrCtH3kDmx
 LtrYPtVvwLCAwbc8NlcHpuuD/j5FSDRusWlUqGXJQ8iIvxPIoJq9s1wgFvTehBKBjbca6mctg
 jsn11PVU3NXowZ2+y1R94kqeOOkQEh2MxwsPpLYOexQgsvwvm1I3RWUqY8pby6PrkvTHzjOXd
 GO3KBwXRifB6FtGk/ULS5Vor2EENOAfkMaBoaS8hQl6G3nFk1vMFzhh8ruonYW/IPYUJ5GAHN
 lqCU0hq0c9s6DMQBbfg8qA3HCivaDr+B/1KFO1g9Wxgl5HhCjA1oGX2Ubw0ytTEzF/V904R5h
 CujyRBvIPlFpRzanpnU1XOL98x5EcMdClDovBWrInoR0a8a2AV/lSRbRq2Wq0tSd3pG9EdOuZ
 FcyhLcRFNSjarD05DVxIvK16jgO9qb+wLSERKU9M/jHsa9k+ZH0s5kvP3MaNTEoNav7MfiBuu
 9L+WLmSJkhh4jHpb78Jc5F6oxPVX0LloluuIRdUFzxMHPyy50aOMolKUT45FQWdJv++LX44vs
 67o7g4wYYziQG0ezbcRI6Gx32xEa44AosicL/EpW4TVnLLs7GlecnKv+dS1V6Eel6QXw6hKtM
 akUDU00qEdpTy1+uQYunqnyCIkujCECR8rhTZoanEYqkaRW/K6VVtc4DA+uFck2rC2K/vL/Z0
 aQCqrwoCGVLca0SHhuDcR11X7DH9xBi8uDvsLIBK/HEvwUf6zog6YPlPnrBkOT26Xw8OHJ+ZL
 WlS8Hiasb2OVcaJ6ywmjfKJdEHSeCGmhHV+UuLn0+wIuciFXe8rGAZKsZ2HDWL90GmBpYna+x
 0nOGBoLEluZ1bxYov35dOFwPHYLz/EkRcQMIMrN/5ZBVLtmL75mgBRxaQCbZWlmsbfybzd5yJ
 /1lZln5SIPBXgyGadyXqGTEZETKvJpQ2oL/phvnK0zHHvA2KHUwXxKviGQGbbjkdEjruX5VNq
 1ba0U9Jj4wKLs/eOHLqp9ublk4ToWC3iTx7By3Kbm20BwJnUtibhIngDwjTfsA6bmWKUSYfvC
 MuufwvuBN6vycNXXAxZd7EUd6X1OP

On 1/2/26 7:52 PM, Ezekiel Newren via GitGitGadget wrote:
> @@ -253,22 +250,44 @@ static bool xdl_clean_mmatch(uint8_t const *action=
, long i, long s, long e) {
>  	return rpdis1 * XDL_KPDIS_RUN < (rpdis1 + rdis1);
>  }
> =20
> +struct xoccurrence
> +{
> +	size_t file1, file2;
> +};
> +
> +
> +DEFINE_IVEC_TYPE(struct xoccurrence, xoccurrence);
> +
> =20
>  /*
>   * Try to reduce the problem complexity, discard records that have no
>   * matches on the other file. Also, lines that have multiple matches
>   * might be potentially discarded if they appear in a run of discardabl=
e.
>   */
> -static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
> -	long i, nm, mlim;
> +static int xdl_cleanup_records(xdfenv_t *xe, uint64_t flags) {
> +	long i;
> +	size_t nm, mlim;
>  	xrecord_t *recs;
> -	xdlclass_t *rcrec;
>  	uint8_t *action1 =3D NULL, *action2 =3D NULL;
> -	bool need_min =3D !!(cf->flags & XDF_NEED_MINIMAL);
> +	struct IVec_xoccurrence occ;
> +	bool need_min =3D !!(flags & XDF_NEED_MINIMAL);
>  	int ret =3D 0;
>  	ptrdiff_t dend1 =3D xe->xdf1.nrec - 1 - xe->delta_end;
>  	ptrdiff_t dend2 =3D xe->xdf2.nrec - 1 - xe->delta_end;
> =20
> +	IVEC_INIT(occ);
> +	ivec_zero(&occ, xe->mph_size);

This array is presized here.  It is neither grown nor shrunken.
CALLOC_ARRAY would work just as well, at least at this point, no?

> +
> +	for (size_t j =3D 0; j < xe->xdf1.nrec; j++) {
> +		size_t mph1 =3D xe->xdf1.recs[j].minimal_perfect_hash;
> +		occ.ptr[mph1].file1 +=3D 1;
> +	}
> +
> +	for (size_t j =3D 0; j < xe->xdf2.nrec; j++) {
> +		size_t mph2 =3D xe->xdf2.recs[j].minimal_perfect_hash;
> +		occ.ptr[mph2].file2 +=3D 1;
> +	}
> +
>  	/*
>  	 * Create temporary arrays that will help us decide if
>  	 * changed[i] should remain false, or become true.
> @@ -288,16 +307,14 @@ static int xdl_cleanup_records(xdlclassifier_t *cf=
, xdfenv_t *xe) {
>  	if ((mlim =3D xdl_bogosqrt((long)xe->xdf1.nrec)) > XDL_MAX_EQLIMIT)
>  		mlim =3D XDL_MAX_EQLIMIT;
>  	for (i =3D xe->delta_start, recs =3D &xe->xdf1.recs[xe->delta_start]; =
i <=3D dend1; i++, recs++) {
> -		rcrec =3D cf->rcrecs[recs->minimal_perfect_hash];
> -		nm =3D rcrec ? rcrec->len2 : 0;
> +		nm =3D occ.ptr[recs->minimal_perfect_hash].file2;
>  		action1[i] =3D (nm =3D=3D 0) ? DISCARD: (nm >=3D mlim && !need_min) ?=
 INVESTIGATE: KEEP;
>  	}
> =20
>  	if ((mlim =3D xdl_bogosqrt((long)xe->xdf2.nrec)) > XDL_MAX_EQLIMIT)
>  		mlim =3D XDL_MAX_EQLIMIT;
>  	for (i =3D xe->delta_start, recs =3D &xe->xdf2.recs[xe->delta_start]; =
i <=3D dend2; i++, recs++) {
> -		rcrec =3D cf->rcrecs[recs->minimal_perfect_hash];
> -		nm =3D rcrec ? rcrec->len1 : 0;
> +		nm =3D occ.ptr[recs->minimal_perfect_hash].file1;
>  		action2[i] =3D (nm =3D=3D 0) ? DISCARD: (nm >=3D mlim && !need_min) ?=
 INVESTIGATE: KEEP;
>  	}
> =20
> @@ -332,6 +349,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, =
xdfenv_t *xe) {
>  cleanup:
>  	xdl_free(action1);
>  	xdl_free(action2);
> +	ivec_free(&occ);
> =20
>  	return ret;
>  }
