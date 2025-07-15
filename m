Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F8A2D541B
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573001; cv=none; b=RYT2zmgz1gmT2q4q4rvpwHTx0wHwRhPfhAEDpEzP9H4uRMaYCT/pGFFH2RwU8AHVOJTXUhE2GtVg1t8g6IR5oDeA3et2Vg2gRyH9LquzWI4Zb2yKSEmgRed6kp93ETE8ukD8lObBgimiSbCIMn2hlBMuiIcArc+lI7NcoYb4jJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573001; c=relaxed/simple;
	bh=Y8duxS4teSaAF+wMGDwKkTWYhQn26bHF5Cr7a6YCcuU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTDd69iCa5I5sIBG9/f4RwRywwkFj01XGGc3oL8LEzwfliNnO1id3K/WxxwnvNZZYEmzjI/J7icReL/b9I32rToMq5WTvwfmvXHdo9/gM0x6UbSstikf7jzy4EIQSXFWOZR7WMvROjd7WRYBOCqP0GLKy9Ac2icSaX3hLYT8ixY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgkuIUFV; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgkuIUFV"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-52b2290e28eso1380147e0c.3
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 02:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752572999; x=1753177799; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wjr8yG+4m0P2ZbPBWNNYe2f+GAUfgxM2hlIbyFmgW4s=;
        b=lgkuIUFVK5E5Fhw4JOPG7FD5bnCQLBuZfV4jwL2mBPSDPeuh1fbQpRCF6K9iTzu7dI
         gvFMyR6wwni/f6EdI6qMVc3lcwdIGU7BXwwnkQEo1lKx0ZuPeKQpTmJm5C4fXm9bmlth
         G6lPGz8LugfRYBagb54VGHIySNK82EpMxUv79MIi0C7gybsaaYh62glD/Cu4k3Kvs8us
         N2fmS0i8tjpq0fPcS8Co4TWSE3ZamJPC7p6FOIIZMXy2fqPE31fRe75Zt3q/OgGdpfTR
         xmPogTz/CZcPWvJWdq+Uc+QKgWC66h/XIQa/9setotqAEplhoFGddAEvXXwZ51XHADbb
         /epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572999; x=1753177799;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wjr8yG+4m0P2ZbPBWNNYe2f+GAUfgxM2hlIbyFmgW4s=;
        b=UwK55u4f2kGZNn3ef5sqsMUlBUEhfpJtreqxJKimo49aREOgGIPHFuzcpo+cor+S56
         BW2+SllNcYbX29BkSuLPQrU2XyqONl8RFMKnep5sv+JQWy81FLzesCehMRiVM0kmSFIy
         Ax8tcgJoekYJ2UmV0NJwj9PpnblAPLAxR6Uw1X5jvhsnUXl+aWgnV42baYSWnYY+L9iJ
         b0XjIWVJwmrj71HKKp+p3DPrUVh9P5qHSgCqixe2U9z/ab5KzdFO645g/IiNI4qwi78Z
         bpmd7gkiFQJGNjgElc54H0VKjortmcaJbY2plhRib7Ocsp5Qh9rkSAyibUtt+BCtZaUp
         jFFQ==
X-Gm-Message-State: AOJu0YwFiFcflUEAraO48oH6k5jPgYBMAX5QpmaJiSFhiyLhtbxzyueO
	YAuOqfXosJcU/NetUfXkYrb2q/iRFuCP75ePpWEHQY8Al+D7oyAhkANrfm5U0028awEOriGtWQe
	aNmDS6Qtml2+/DCp165KfiFXL6d4t8/4=
X-Gm-Gg: ASbGncvjGk6SRCB0rHkm/Fg9MVnIvlyiLnO31UUgkFe/o8/pB35FuoQmOdtwZMSNJTi
	ef3HCvlcBztspN9b3+5zC6ppFsjeurYdQ5FdrHu9aUClJtI9zWO76SmvB4vd4cQYbYFC+zBPDYQ
	Ib6LflXOH/aMYakWDuC4W5n0MF7F4PcmbMVoW24dBM8m5k4OI2A1zqVQqgF987FCk96AXYdIk+w
	mIEG+EfK5vqntjCXG4dZ2O3plNHf3VBQ+kyPeF8
X-Google-Smtp-Source: AGHT+IHnJe8SSzR7OfpSXpKWq9feTugNRvhuj86xukWu5GOMaeLZG/k5KjtjODaPHIecBVyH1gTi+EltDnM43IY/a94=
X-Received: by 2002:a05:6102:549f:b0:4d7:11d1:c24e with SMTP id
 ada2fe7eead31-4f6e2e8358fmr7971282137.21.1752572998609; Tue, 15 Jul 2025
 02:49:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Jul 2025 04:49:57 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Jul 2025 04:49:57 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqms96u38z.fsf@gitster.g>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250711-306-git-for-each-ref-pagination-v4-0-ed3303ad5b89@gmail.com>
 <CAP8UFD0anB4dPDf99-w6dyZNNGuOKU-b30_k322D0EsWE0cKPQ@mail.gmail.com> <xmqqms96u38z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Jul 2025 04:49:57 -0500
X-Gm-Features: Ac12FXwx3RlL4Gjy624DTeVgrZ4j7JEgBIerFv-K9Kqx2sQOeyUMOBshixMfa1o
Message-ID: <CAOLa=ZRT70g90+e-Mhy_USaXqLpDVamRm5dXc-r_fF2PHPQyPw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] for-each-ref: introduce seeking functionality via '--start-after'
To: Junio C Hamano <gitster@pobox.com>, Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, schwab@linux-m68k.org, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="0000000000000692f00639f4b3e1"

--0000000000000692f00639f4b3e1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Fri, Jul 11, 2025 at 6:20=E2=80=AFPM Karthik Nayak <karthik.188@gmail=
.com> wrote:
>>
>>> Initially I was also planning to cleanup all the `refs_for_each...()`
>>> functions in 'refs.h' by simply using the iterator, but this bloated th=
e
>>> series. So I've left that for another day.
>>
>> I wonder if there is a plan to add the '--start-after' option to `git
>> branch` and `git tag` too?
>
> Good question.
>
> "git for-each-ref" is for scripters, "git branch/tag" are for
> humans.  And humans do not page (outside "more/less").
>
> So while it may be trivial to expose the feature to these Porcelain
> commands, it is not obvious that it is a good idea worth cluttering
> "git tag -h" output.

Agreed, since the functionality is built into 'ref-filter', it should be
easy to expand to these commands. But I don't see the need for it.

Karthik

--0000000000000692f00639f4b3e1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 89b453ce8ec68dec_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oMkpFUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMWJQQy8wUm9jNDZMclA1QzVYMTg1bFEwSGxCamZFYgpEc3lCZTFOck9P
N09odHMxeUU0REEyWG9ody9FUjJJMEFXM1A4L01UMzBWR2IrUGp3SVpDRGJHSGhCSS9HUlhXCmVI
WlNLTlBQK01oRVlGQ0R5aWIyZmJ5bnJsOFJHYVVheCtaczI4N29VT2xFR1A0dkF2dVlLeUxpQXFu
V2VKaEoKMHBCNDVZZ3lUd0Z3VGljcDhnRC96dlNIRXdWdHJTZkh4YzZQL0JZNFJUakdVTW11TGYw
UDM0MW1BZmhYZlJrQgp4emFQc1pwM1J4S2g5cjBYa3FIQ1U4dFRER1Nlc3VlcUhmbUpMVUJYMHdv
b1ByUjZzRkRncW1oMnRabTVrN2pKCjFMUmNIZ053YzdlUFB5ZmM5RmpBc3dWbjdPWTV5R0tiMnEv
MTAwbXluSHVpQ1lUaVcvaGZRYngxUjN5UVZMWjQKVU9yVk9VUnNLMEZwZ2lva2Q4ZmNqeUg2b0Ir
bGFROTFsLys0aWRxdkFpVDgreXFmYjFYV2FVNVRLU25EOHlGSwo3OEVGb0QrK1g1cGRGcGtrQjht
SVRxbWxVRXUxNEpOanBVUlFXMXlnVHBJcVJGTHNxTWJjd2hiSWU3RTFZWElTClRTM2xnUXVlNnEv
b2FuME9hMzYvQk5JUHg3RFBVRXFYYUhObU84VT0KPTdud3oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000692f00639f4b3e1--
