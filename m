Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C55C2EF652
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012555; cv=pass; b=G+BGiZKfjbbpmK4bB9x535wGfiIwVQD9DUzsbxihDO7fs3T6w8jOIUg+ynJNJjLjqUH92htJzwZ7onq0HMtCr+EPZEK2ev9Mv2aZxxHWngnRDNyzqhK+WNPss9yPTD1vakiuKU648ik9elCw4Lw4ftFHQlXhMwhZdqu3/YvVCmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012555; c=relaxed/simple;
	bh=pDIJq0RTXt+t5C/UZFt9YQUyZImdSf4DC/PtRS4uf6o=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkaV2CCWLcbgEAAeihSebPxVOamwwmHCX79QIjf7oH+RwatgVDo2aaFjoHr1STScsppLFC0LKpVcKVsyn+7//+8ibKKHh1iL0e8bwQpDAEYpEf+DxaCFxd95UPNGJnuUxNFe6cmTx8w40NzojGR+67/WN46nNFhUlmOdiBwQcP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1JB5gXs; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1JB5gXs"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5ff0c095b69so207764137.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 01:42:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772012553; cv=none;
        d=google.com; s=arc-20240605;
        b=Yi60f5oN5oTCa+yqfveSmReq9FN3hVAIuVCMoGRL5JIkqxGZASNiJ0nElJhhEz5r6P
         zDJmeLYBK7kKnCX5unHfMGi013tZczZId5LwdCL4Fyi4U56dIu+DUu5/HtDCoFIL6pxz
         1YrFWBhj1woF+Pt6n/enUJobkL89V6gY6M7mRa3UkGvscIOklQ03leLiPTZdLlAu/Cgk
         47zGX5X9ifvhqCrOrpwsdlWCa0VYWr8N/yK2IUwyOy2hXJIYd9eksBmmNDrW4FUsawTj
         cJqWw607bYiyrYx/2EttB6wv4pN6UWTjjoWlNr7jTZlFCnAbGJyTPWNOsp8o3PKWhCY1
         KdBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=46mxisf+9Tk1mOTxPXZrSYJCZvl8tSed2pwCq67d/iE=;
        fh=ptHWnPX6rs4czHct1+PkfmUM+9yw+/ZOEexTIh7+2Qg=;
        b=cTbB+MWgbn8Rh3sbf8LAShc2B3emk8+oyjLqMmNxP3UToQi5k+i4/OYS1ETijWbFVA
         cxGGdvYzUQS1yBmOnkHuERf9toMTmepXLjsxjwnSoLSE+XEpc3D6SNFYxuLv7GpgiJO5
         Aq2keKmBHXO039UEgzZICCWDVg7dJVAKncStWJTrK6vjuZ5leQCUylDxloSGLRKsbtTJ
         t98swTe5qdlhghVjAcNcVqz7r/+iTpL11cx95BWzDH98v10w3tKJn6yjapuFSv5xQpoH
         31FqWEcoK8pfGeSs9wEvwFaAKH9LEKcLZ/iJLdgsV8wKZTRgGo85anj7d4Bxc9I4eNIu
         qr6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772012553; x=1772617353; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=46mxisf+9Tk1mOTxPXZrSYJCZvl8tSed2pwCq67d/iE=;
        b=L1JB5gXsMncZYPX4NUfRv+AFMXaGEaN7oqA3jPI678uDJ4zZZtP+D/PWwoMbdNs0Mr
         IY5yUtAe+RZnKEtlTvG7OLmfq34cvGRLZnw3aNqKIMqRA0ylLaqm6yY+j+izHm7aW5to
         IUuu53qnrUjyGCN9PUCHwFL49BC+JDGANSRvFSGEwv/7URfdBNTVaFHudA78ePR0CYLE
         yXt9bT0E1SxCUCmlhvPN3iQbirTu/kMPvU7s5LOlI0sKSq4OfsqSV1TT6D3G+qFBOASX
         +UPVFHO0ghdgGcTA3Q59jjFQa8PsqWSrfxpSKeI4sbS7Urc660UUbKS2eFaXz7Fcg+C2
         JivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772012553; x=1772617353;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46mxisf+9Tk1mOTxPXZrSYJCZvl8tSed2pwCq67d/iE=;
        b=vyerTrQvoFF9cZh31z5yyj3MAaw9tX+C4d+BIyKrXmKAbC7WbsYkju93ih4l0BJRwV
         ndsI88CQg4R6uU6wE7vBFOpDUXREVdWs0rZelbJl37KHDOxucs8kMZDSCxbqdWpPYiuF
         JUre73l8SxLatJqK/p2tiKvuZASGRT2BNzpIsuT1SK7ThKEzaakNqNRmnspN9e18Vzp8
         lCZVWxZMLzLVoxRKfeT1NJomW1SmbhKy3w+PX/k/hSuAnytWEHRbdZfSr1AS7TxDXDUK
         +yFhWtyfQsJ2E82nutvPGnbdRDx8MovRTZPJ4sW3sSiOhPc7psoqWumKrG3BPwxIEhID
         hIlA==
X-Forwarded-Encrypted: i=1; AJvYcCUlQkodgtjD2gbOUPfzM5YV89qfGfADOKIVlJzcyV10KQXYjX9X9iYcCYEeoL5t99aaxuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpOccOqXYclJHuPlnBL7i62ripWkzbgrVen9O60dQpi1EdaPhC
	OTkovuiOFtSCz4CLcRL7Jp0mTCMho5E/TKFOfuV6aaG+4qf3QM9biHEpI4bvoEcBs5/Kwm+oCiQ
	EON4HVW2bjsR15j8X/dZh/QYfw9P9IpI=
X-Gm-Gg: ATEYQzzONr4TSpo/wwgJspEssaqSrg4DUiD24tPkXffaIcwBkfPiGfPevwhBwLRK//k
	5WUwJtCs3IExcBNfChpFOquzNye9Huhxx8etSsNrgD1Obl3gpxjFzo25jK75x4JQZc/gfU2f9p6
	MmMTwD+0qweoFHe26aSnFa1CNDv/SzBWqLbzJtVucxC2foLdjG+JzrUhrMmN91lFpkZIOQmuAVN
	bFWJevQbW702Rja2rnuiI9yH/Zu1gWFAQFEnABCUxJdkvoA2L6uoME9fKze0nLnsvCD3c3m9Fsa
	3tKM6GrZvc1JG6qA8OkbtU6xsDxvDziITtFMarxmUKhM9MJ/ZCCm
X-Received: by 2002:a05:6102:1606:b0:5fd:efb0:8562 with SMTP id
 ada2fe7eead31-5feb3158c8fmr6687533137.39.1772012553015; Wed, 25 Feb 2026
 01:42:33 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Feb 2026 04:42:32 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Feb 2026 04:42:32 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqikbnmdjf.fsf@gitster.g>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com>
 <aZwx6F-ZeQ-LZv1M@pks.im> <CAOLa=ZQ2qaSbxaEfK-ngZUfM-WwPhiFF6wYRK68=0QJ9P-5BnA@mail.gmail.com>
 <xmqqikbnmdjf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Feb 2026 04:42:32 -0500
X-Gm-Features: AaiRm51D-m7E-U5w3HPD24UfDpAZjzCaKUSH-d7EBiucWb4mXeBC6Rj9fj19maw
Message-ID: <CAOLa=ZTejaVY_fvMsGdw_ZmcQijDex6=43RKHBM9HWv05u17Gg@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] refs: allow setting the reference directory
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, toon@iotcl.com, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: multipart/mixed; boundary="000000000000c2b4a6064ba2d28a"

--000000000000c2b4a6064ba2d28a
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>>> On Mon, Feb 23, 2026 at 09:01:35AM +0100, Karthik Nayak wrote:
>>>> Changes in v8:
>>>> - Fix a typo/grammar in commit 4.
>>>> - In the final commits tests, avoid creating a file for text
>>>>   comparison.
>>>> - Link to v7: https://patch.msgid.link/20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com
>>>
>>> Thanks, I'm happy now with the current version based on the range-diff.
>>>
>>> Patrick
>>
>> Thanks for the reviews.
>
> Let me replace what I have with this latest and mark the topic for
> 'next', then.
>
> Thanks, all!

There was an issue with the doc rendering and small nits that Toon
suggested, so I pushed a new version. Hope you can replace it with the
latest for 'next'.

Thanks and sorry for the churn.

--000000000000c2b4a6064ba2d28a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b98a1074f10dbf23_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tZXhBWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0lmQy80bHllMnFvb2FtMXZ0bjVqemhnd3FLNmQxVQo1MUFwRllIKzAr
dHBGTnRTL2k0N0c5ODFpNDFPaU1vTFQvNkRIQUFMNS9Pc1pHZE9iaU1TZ1VOTVY2VU9YMnJlCnl6
Vzc2S21nMkVBOHhYcFRyU2IxZEg5dXRoTStJS2F6bUlUSEdRZHhEbWNacE1pQUVzVlZla2t0S0h5
amZnQloKSWVsa3RVc1JQWEprVHVEcStSZFVVd2l5cUhhdmFlNzNsZno5eEhqZk5JdWczbjB2U1o2
OXJIRUtreTZoU2lCRgpxSHZzMjVNUmpucmw5eUp3dEhNVnNjTmI3L3JyblQ1VkNSazRQcElSVTIv
VXY3VHFjTGRxWndpbXEvYWU0dUdjClV1ZEthUHBKV0pjL3VldEdXTDJwUG9mQ2UxUk1GNU5IVzk4
MFkzZjBoendhRG9nR0YrRVpIR2pNalVpQXExMkUKU0pCWW9Jbno0THU0T1hXenFweGVEVXFGa2ls
cHp4bm92cDdNZ0dWcEExZ29XNkRUTkUzdDVsMnpFNmk5eE4rUQorc0k1c093cDFuY3lmbE5mTURZ
dWd2N1hjUjJXRytIUWhtNFdseERzUGNPcWkrUk9Sa0NIZEg5K0JVTUFQR2NHCkJEa1IvbENrbHFG
Y2RMc2NEVmpnRVJEQkhCcy9veFR0Vi9qUzdaaz0KPXhLelcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c2b4a6064ba2d28a--
