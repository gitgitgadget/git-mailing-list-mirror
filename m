Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A87243951
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768760635; cv=none; b=OQXLY5KvXFjQ9ujJDcqagT4ql+/1aVWKCrvwOygOyEbG9oSkhILd+NGrEpVZLzV9R9MErsLqnsCCkweCdxc18W/4oBOz4+cfsmLoDJc8InZwObil1wnpe1HF4l5WrCdpCK5lGv5mTiLf39N9BW+3ZfXSdsnmV7bx3bIx4lcdrnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768760635; c=relaxed/simple;
	bh=v0CvNUM2zhEFsP32O5WzfY9kcESdAm+FofO447DbvqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQ7zSH4VfG0eOL/9uXfKE3vaBCz0w6L49i3koDvNDQ5bQyV3X+wD9Y9IWuDiEPoLgyftGRdPTNS4L1QyfbJ7ytrfUs9dVY4Rc9LOxSPvS4sHPPJgtUP4RdtPL/jJjgrHfmHuXj6c2OBEvRqgmw5PKQhu+LVGd9Ssk/BpwflFkac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=jJKuJl+J; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="jJKuJl+J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768760629; x=1769365429; i=l.s.r@web.de;
	bh=eNJbhz7K08fVAJ1FADVHAiW2O70zcS3E/Gp4z4PXiyo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jJKuJl+J/npefEHaSXXcmx7TAdH3PG8swie/6A4422HFJKwY3i+K2Dn0pfheo5/r
	 LQccQvwk0eBrzM4kXrtwrvRZrZinvezjCjmoe5CBrRCwaxcRh2qyHA7pnvBvpZgoM
	 uE7q7sqmiECOmdzWlTgSa+ej7ZrWOH4VLuYzrtpiTqOgwqt90knGjZOy5ExOS4pMf
	 dqLV7IynaRy3LgQVSfZyvb6a6HKt43AzLH7+TGBPy4NMfBOhznrzDCwPjmSTSTtwu
	 4XJL10dbl3H2vLvwD5sWvys01vUVuM2o/Xj0Y+/IgDF297Toz4ubJKo0eJ2JPP1q1
	 WKUzdp2f7a6VxGf67g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.19.215]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MP384-1vR86z1VvQ-00IGLF; Sun, 18
 Jan 2026 19:23:49 +0100
Message-ID: <914e4157-557e-4ea4-9b17-b6b1cb078283@web.de>
Date: Sun, 18 Jan 2026 19:23:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] xdiff: remove dependence on xdlclassifier from
 xdl_cleanup_records()
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <f9b10e71d23f8b4fa34dcffb371cf5a173760409.1767379944.git.gitgitgadget@gmail.com>
 <07ca298a-ad32-4998-88ff-d69c04418fdd@web.de>
 <CAH=ZcbDw0_Od3+zuGLsy3Z=bLR-4ByH8Fguiuw_MyLTi=U7gcQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAH=ZcbDw0_Od3+zuGLsy3Z=bLR-4ByH8Fguiuw_MyLTi=U7gcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aWjkYdRcy/xbgcZep+gNvBIhrXCh5mXA+qnByyGEwmfoGZasnUC
 /KQXPR9HAOZfWIrsIb7xWc7IlJE0EcKsuGkCJRtzUBGISm3wqZHvy9vhCmvuIvJZ/Zc1nAm
 hEp78c3RZcnNvBw3U4V6lK/jo7hISiqJToaYons/9tE+Pe1Kg8cLWIauiEXQdV9Hhz0eobW
 h88j6yYt7lxz/0tZmQO1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3mXWzWrpQ7U=;/eQaIaNpEb2buk8xKTDp1OzI6qr
 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

On 1/17/26 5:34 PM, Ezekiel Newren wrote:
> On Fri, Jan 16, 2026 at 1:19=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de>=
 wrote:
>>
>> On 1/2/26 7:52 PM, Ezekiel Newren via GitGitGadget wrote:
>>> @@ -253,22 +250,44 @@ static bool xdl_clean_mmatch(uint8_t const *acti=
on, long i, long s, long e) {
>>>       return rpdis1 * XDL_KPDIS_RUN < (rpdis1 + rdis1);
>>>  }
>>>
>>> +struct xoccurrence
>>> +{
>>> +     size_t file1, file2;
>>> +};
>>> +
>>> +
>>> +DEFINE_IVEC_TYPE(struct xoccurrence, xoccurrence);
>>> +
>>>
>>>  /*
>>>   * Try to reduce the problem complexity, discard records that have no
>>>   * matches on the other file. Also, lines that have multiple matches
>>>   * might be potentially discarded if they appear in a run of discarda=
ble.
>>>   */
>>> -static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
>>> -     long i, nm, mlim;
>>> +static int xdl_cleanup_records(xdfenv_t *xe, uint64_t flags) {
>>> +     long i;
>>> +     size_t nm, mlim;
>>>       xrecord_t *recs;
>>> -     xdlclass_t *rcrec;
>>>       uint8_t *action1 =3D NULL, *action2 =3D NULL;
>>> -     bool need_min =3D !!(cf->flags & XDF_NEED_MINIMAL);
>>> +     struct IVec_xoccurrence occ;
>>> +     bool need_min =3D !!(flags & XDF_NEED_MINIMAL);
>>>       int ret =3D 0;
>>>       ptrdiff_t dend1 =3D xe->xdf1.nrec - 1 - xe->delta_end;
>>>       ptrdiff_t dend2 =3D xe->xdf2.nrec - 1 - xe->delta_end;
>>>
>>> +     IVEC_INIT(occ);
>>> +     ivec_zero(&occ, xe->mph_size);
>>
>> This array is presized here.  It is neither grown nor shrunken.
>> CALLOC_ARRAY would work just as well, at least at this point, no?
>>
>>> +
>>> +     for (size_t j =3D 0; j < xe->xdf1.nrec; j++) {
>>> +             size_t mph1 =3D xe->xdf1.recs[j].minimal_perfect_hash;
>>> +             occ.ptr[mph1].file1 +=3D 1;
>>> +     }
>>> +
>>> +     for (size_t j =3D 0; j < xe->xdf2.nrec; j++) {
>>> +             size_t mph2 =3D xe->xdf2.recs[j].minimal_perfect_hash;
>>> +             occ.ptr[mph2].file2 +=3D 1;
>>> +     }
>>> +
>>>       /*
>>>        * Create temporary arrays that will help us decide if
>>>        * changed[i] should remain false, or become true.
>>> @@ -288,16 +307,14 @@ static int xdl_cleanup_records(xdlclassifier_t *=
cf, xdfenv_t *xe) {
>>>       if ((mlim =3D xdl_bogosqrt((long)xe->xdf1.nrec)) > XDL_MAX_EQLIM=
IT)
>>>               mlim =3D XDL_MAX_EQLIMIT;
>>>       for (i =3D xe->delta_start, recs =3D &xe->xdf1.recs[xe->delta_st=
art]; i <=3D dend1; i++, recs++) {
>>> -             rcrec =3D cf->rcrecs[recs->minimal_perfect_hash];
>>> -             nm =3D rcrec ? rcrec->len2 : 0;
>>> +             nm =3D occ.ptr[recs->minimal_perfect_hash].file2;
>>>               action1[i] =3D (nm =3D=3D 0) ? DISCARD: (nm >=3D mlim &&=
 !need_min) ? INVESTIGATE: KEEP;
>>>       }
>>>
>>>       if ((mlim =3D xdl_bogosqrt((long)xe->xdf2.nrec)) > XDL_MAX_EQLIM=
IT)
>>>               mlim =3D XDL_MAX_EQLIMIT;
>>>       for (i =3D xe->delta_start, recs =3D &xe->xdf2.recs[xe->delta_st=
art]; i <=3D dend2; i++, recs++) {
>>> -             rcrec =3D cf->rcrecs[recs->minimal_perfect_hash];
>>> -             nm =3D rcrec ? rcrec->len1 : 0;
>>> +             nm =3D occ.ptr[recs->minimal_perfect_hash].file1;
>>>               action2[i] =3D (nm =3D=3D 0) ? DISCARD: (nm >=3D mlim &&=
 !need_min) ? INVESTIGATE: KEEP;
>>>       }
>>>
>>> @@ -332,6 +349,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf=
, xdfenv_t *xe) {
>>>  cleanup:
>>>       xdl_free(action1);
>>>       xdl_free(action2);
>>> +     ivec_free(&occ);
>>>
>>>       return ret;
>>>  }
>=20
> In Rust the memory management macros defined in git-compat-util.h will
> not be available. ivec was built expressly to bridge the gap between C
> and Rust. I'm avoiding using those macros because I'm trying to get C
> programmers familiar with how Rust's Vec operates without forcing them
> to read and write in Rust. Also, it makes converting from IVec to Vec
> super easy.
>=20
> ivec_zero() also sets length and capacity. Also CALLOC_ARRAY needs to
> know the type of the pointer which ivec_zero() does not have access
> to. This is one of the few ivec functions that does not have a direct
> equivalent in Rust's Vec, but is faster than what is logically
> equivalent in Rust.
>=20
> In Rust the closest safe equivalent would look like:
>=20
> let size =3D 35;
> let mut vec =3D Vec::<u64>::new();
> vec.reserve_exact(size);
> vec.fill(0);  // requires that T implements the `Copy` trait
>=20
> The unsafe version would look like:
> let size =3D 35;
> let mut vec =3D Vec::<u64>::new();
> vec.reserve_exact(size);
> unsafe {
>     std::ptr::write_bytes(vec.as_mut_ptr(), 0, size * size_of::<u64>());
> }

I was being unclear and made a few assumptions here.  My point was just
that this is a fixed-size array and doesn't need to be stored in a
variable-sized container.  This is the first Ivec user, and I would have
expected it to exercise the push function.  I assume accessing a
fixed-size array via FFI would be a lot easier since allocation and
growth are out of the picture.

Ren=C3=A9

