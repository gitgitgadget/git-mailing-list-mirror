Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE663BC687
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906440; cv=pass; b=OXdEyCbvIy4Tgn8XsDytKLhq9TnXbc4B1CWkjXJyrJ8qrYjwsLszE6ygJjPpMybSG9bw6wRGMu3GLuNHd4wCvZnUkZzoxT/exN8GP8Li8bm3hEtFKqL1kpgpqc4nr2xpbwJLaj/mbgpexOyhmkuFl22PFcPjXljGEIoBD+GsNwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906440; c=relaxed/simple;
	bh=LQ0K3KnyYFA3k2TtUyv9dgiJjHcqjTwHStpZU3qrvow=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=F5XIbO0hY3l1eok7UM/+M8+M1jbI2+8xmOsJhLKN5z/7ZuvQf4O5IRc7bTjppXrPtBHVQUMhNmVbxZMnhZN59RLFhs+dg/NEVxCX2g3Mxx6wXO1dDVmFo0PhCW1HN4Ciugxrm2kGN8lb8SC4HOjXQbVSSlEvMSCTxWBqSR+lP3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tvh.com; spf=pass smtp.mailfrom=tvh.com; dkim=pass (1024-bit key) header.d=tvh.com header.i=@tvh.com header.b=bWoSXfMR; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tvh.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tvh.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tvh.com header.i=@tvh.com header.b="bWoSXfMR"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso2609062a12.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 04:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782906436; cv=none;
        d=google.com; s=arc-20260327;
        b=AvN451tS3qOqSYDJNxhvQ6HhfX4T8OBwaR2L4ovNPlxTWI9IzbYx1rut23zhPRE5CP
         oqLvN3FECEy9a2i6nNpoBC5YwTY+h2EnLINW6LPAMSCWSIOtYZTdsQuBo0e3f3pb+J/T
         5HWseOebnG951Xu0YUyjk6A4CY65vgJlWAuIrwXqfnXHuOB4o/LAwDCtajeSnXFHb4Ck
         BeSSS7whjaie6sAS8oPPh2J4FshO+AqZCDzTuuhkV7CATUyE84cDrZraS0p7pAzgDzeG
         8JarCoLjPUPhpbSxzt2oN0DcmKrmPUuMyF8eBRL3QzfX3Wd1cciSwQuCW1pqY6XLmmBG
         iYUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=u44iL0QCXJRo4cSQL9akyL1FLpylI+C/7qwCkvRZX8E=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=Mc8Qhc9Q4vt5QoKLH4ChyNW+sGmccQTdw4MGtMWAc4UN74FqCB7yBHlry/ZvPeAmYg
         6NKMq6U1smagjbqz8Q5zxW3nECfljtbokIyYj8fHkFRGBMKZItVPSg7h4bSjlRcXCuE6
         OsjeL3XcndafKs5W2Bb1xkuzXJbHfn8PZ+kEVoO4AgRTCxBxh8bIO7/0PTEgk5widLKY
         wJceSyc3QRytYb1ecROXaS2+R7KnaErdwNN+3Ty/SS6oJxLYh5fAv9BIoU5hGXvYAcXt
         gmyUgfXBGZM1J/utzhy8L+fIomHPQD3cklBVF4q8YvUk0l/7B07XW2NuvzOaXmZAeoj+
         ucIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tvh.com; s=google; t=1782906436; x=1783511236; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u44iL0QCXJRo4cSQL9akyL1FLpylI+C/7qwCkvRZX8E=;
        b=bWoSXfMRfaN3UWPJoMl51nStmWlKDynzgXaQvA5+qO5LxWsM6qzpQ1Yn1SdaGvCVXt
         Q4+XTAU4I+Sp3sFNX3aq6yog03znmhRRlDaRswmQRtvMPUUJKTJW6AMjVITYREor4F5r
         KOHfYnwyT8momoK4+Srha302jV/MtKWQ/yr98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782906436; x=1783511236;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u44iL0QCXJRo4cSQL9akyL1FLpylI+C/7qwCkvRZX8E=;
        b=swEwMsPW3AKEy4GUHmXlcjZWHGZIy/3WiAV5EALS4LwdQIjoWwk7fHerfKWkvxRMVf
         FlQf65XPJGfY9akshv2pbaNgQ1YKc2bLn5JeutqEM+XFxofhviiJpnSPBNf3/9G79/PB
         ivqfoGRN+wVq4grVgvpovvZ6mBlFbTYAvoWvBHk96Km+wr4AR8TFwBD2FL+OEZ2q6C+r
         9ItztVSz/MQ7aMj89u2gFT0hu4xsc8QeL2XXhfruodFp6Z+TaIGasQGjry+wpqBqptqp
         /Sn9OpS2tImCdxgGNyKwzHhrZQYObo+NY/HrmybpLXdYMdjwtqQ1feEVuA68Z40Fsfj8
         VjEQ==
X-Gm-Message-State: AOJu0Yw0UfUQm8fNVidhUrZoH/2odKUpMQ91C9JXwaFGYC6J/4UdrON4
	b1x1d9sunLLax0AzlVXMO6zR29nxJRy28xj76jXLnaselgh8LitNR7g8AKJRIzgG79yMN3EGhgl
	BOmLkledk6skUdUYn0acDHRWcI5HIQq80IWibffPgHWqwK3IyUOBKg1gW8TGPR7+ESrmJZSroi2
	5OQj+bbVB2ciUrMeZYz5QHzsOlgIBtXyH/IRE=
X-Gm-Gg: AfdE7ckXrCxBg4G1fq8DP5BNWdm7JWgzxu/diUdX+GTIhMEJ5Axzp6BiPyP6Y3y4Wm3
	tC1pAa9zk+ScJh/cJK3eaqDLiKrUf6+2GOHuPGYxXLRDqEiJGPmW041FDsI2n4AJfhuw7xOHpcz
	+GJx64u2cHwg/xhjMj5WHAJtt+Suo2Brll7OgLWB8A2La9xB+O0SgBdx0a1F2YyTtuIdj9eDlJs
	mG2tosK+KAZ63sMmARfbu4HYLg+Zx7Zuurn52+6rAOjY6z4ucCG1iGgma87Xt8ZOY5ydww=
X-Received: by 2002:a17:907:6d25:b0:c12:7e41:3904 with SMTP id
 a640c23a62f3a-c12a7b4e7d4mr78480166b.16.1782906436067; Wed, 01 Jul 2026
 04:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hayk Avetisyan <hayk.avetisyan@tvh.com>
Date: Wed, 1 Jul 2026 13:46:50 +0200
X-Gm-Features: AVVi8Cda8eH7_hwlboCmE-wIip0LrNjhQM3jwGHJW0PHRgfIp3tg2o5dcbhBo68
Message-ID: <CACwZ3KFCJSqj-fwU8WH0=_53mPSZ-uaxdCcSuEEL7=eyJu4APw@mail.gmail.com>
Subject: A bug
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ca6fab06558b40e8"

--000000000000ca6fab06558b40e8
Content-Type: multipart/alternative; boundary="000000000000ca6fab06558b40e6"

--000000000000ca6fab06558b40e6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please, find the bug report attached.
--=20

Kind Regards,


*Hayk AvetisyanSenior Software Engineer*
M +32 476 030611 =E2=80=A2 hayk.avetisyan@tvh.com

*TVH PARTS HOLDING NV*
Vichtseweg 129 =E2=80=A2 BE-8790 WAREGEM
T +32 56 43 42 11 =E2=80=A2 F +32 56 43 44 88 =E2=80=A2 www.tvh.com

--=20


****=C2=A0DISCLAIMER=20
<https://media.tvh.com/content/pdf/various/Email-disclaimer.pdf>=C2=A0****

This=20
message is delivered to all addressees subject to the conditions set forth=
=20
in the attached disclaimer, which is an integral part of this message.=C2=
=A0Your=20
privacy is important to us. We use your personal data only in compliance=20
with data protection laws. For further information on how we process your=
=20
personal data,=C2=A0please consult our=C2=A0Privacy Policy=20
<https://www.tvh.com/privacy-policy>.=C2=A0By communicating with us, you=20
unambiguously consent to our use of your personal data as explained in the=
=20
Privacy Policy.=C2=A0The information contained in this communication may be=
=20
confidential and may be subject to the attorney-client privilege.

--000000000000ca6fab06558b40e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br clear=3D"all"></div><div>Please, find the bug rep=
ort attached.</div><span class=3D"gmail_signature_prefix">-- </span><br><di=
v dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature">


<div><br><div style=3D"font-family:Arial;font-size:12px;color:#000000;text-=
decoration:none">Kind Regards,<br><br><b><font color=3D"#E4002b">Hayk Aveti=
syan</font><br>Senior Software Engineer</b><br>
M +32 476 030611 =E2=80=A2 <a href=3D"mailto:hayk.avetisyan@tvh.com" target=
=3D"_blank"><font color=3D"#000000">hayk.avetisyan@tvh.com</font></a><br><b=
r><font color=3D"#E4002b"><b>TVH PARTS HOLDING NV</b></font><br>Vichtseweg =
129 =E2=80=A2 BE-8790 WAREGEM<br> T +32 56 43 42 11 =E2=80=A2 F +32 56 43 4=
4 88 =E2=80=A2 <a href=3D"http://www.tvh.com" target=3D"_blank"><font color=
=3D"#000000">www.tvh.com</font></a></div></div></div></div>

<br>
<p>****=C2=A0<a href=3D"https://media.tvh.com/content/pdf/various/Email-dis=
claimer.pdf" target=3D"_blank">DISCLAIMER</a>=C2=A0****</p><p style=3D"text=
-align:justify">This message is delivered to all addressees subject to the =
conditions set forth in the attached disclaimer, which is an integral part =
of this message.=C2=A0Your privacy is important to us. We use your personal=
 data only in compliance with data protection laws. For further information=
 on how we process your personal data,=C2=A0please consult our=C2=A0<a href=
=3D"https://www.tvh.com/privacy-policy" target=3D"_blank">Privacy Policy</a=
>.=C2=A0By communicating with us, you unambiguously consent to our use of y=
our personal data as explained in the Privacy Policy.=C2=A0The information =
contained in this communication may be confidential and may be subject to t=
he attorney-client privilege.</p>
--000000000000ca6fab06558b40e6--
--000000000000ca6fab06558b40e8
Content-Type: text/plain; charset="UTF-8"; name="git-bugreport-2026-07-01-1333.txt"
Content-Disposition: attachment; 
	filename="git-bugreport-2026-07-01-1333.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mr20fq0s0>
X-Attachment-Id: f_mr20fq0s0

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCkluIHRoZSBsYXN0IHR3byBHaXQgZm9yIFdpbmRvd3MgcmVsZWFz
ZXMgKDIuNTUuMCBhbmQgdGhlIHZlcnNpb24gaW1tZWRpYXRlbHkgYmVmb3JlIGl0KSwgR2l0IEJh
c2ggY2hhbmdlZCBob3cgaXQgaGFuZGxlcyBrZXlib2FyZCBpbnB1dCB3aGlsZSBhIGxvbmfigJFy
dW5uaW5nIEdpdCBjb21tYW5kIGlzIGV4ZWN1dGluZy4gUHJldmlvdXNseSwgd2hpbGUgYSBHaXQg
Y29tbWFuZCB3YXMgc3RpbGwgcnVubmluZywgeW91IGNvdWxkIGFscmVhZHkgdHlwZSB0aGUgbmV4
dCBjb21tYW5kLiBXaGVuIHRoZSBydW5uaW5nIGNvbW1hbmQgZmluaXNoZWQsIHlvdXIgcHJl4oCR
dHlwZWQgY29tbWFuZCB3b3VsZCBhcHBlYXIgY29ycmVjdGx5IGluIHRoZSBwcm9tcHQsIGFuZCB5
b3Ugb25seSBuZWVkZWQgdG8gcHJlc3MgRW50ZXIgdG8gZXhlY3V0ZSBpdC4gSW4gdGhlIHJlY2Vu
dCB2ZXJzaW9ucywgdGhpcyBubyBsb25nZXIgd29ya3MgY29ycmVjdGx5LiBJZiB5b3UgdHlwZSBh
IGNvbW1hbmQgZHVyaW5nIHRoZSBleGVjdXRpb24gb2YgYSBwcmV2aW91cyBvbmUg4oCUIGZvciBl
eGFtcGxlOiAiZ2l0IHJlYmFzZSAtaSBIRUFEfjMiIOKAlCBhbmQgdGhlIHJ1bm5pbmcgY29tbWFu
ZCBmaW5pc2hlcyB3aGlsZSB5b3UgYXJlIHN0aWxsIHR5cGluZywgb25seSB0aGUgbGFzdCBwYXJ0
IG9mIHlvdXIgaW5wdXQgYXBwZWFycyBhdCB0aGUgQmFzaCBwcm9tcHQuIFRoZSBiZWdpbm5pbmcg
b2YgdGhlIGNvbW1hbmQgaXMgaW5zdGVhZCBpbnNlcnRlZCBpbnRvIHRoZSBWaW0gZWRpdG9yIHRo
YXQgb3BlbnMgZm9yIHRoZSBpbnRlcmFjdGl2ZSByZWJhc2UuIEZvciBleGFtcGxlLCBpZiB0aGUg
cHJldmlvdXMgY29tbWFuZCBmaW5pc2hlcyByaWdodCB3aGVuIHlvdSB0eXBlIHRoZSBmaW5hbCBw
YXJ0ICJBRH4zIiwgQmFzaCB3aWxsIHNob3cgb25seSAiQUR+MyIuIFByZXNzaW5nIEVudGVyIHJl
c3VsdHMgaW4gYW4gZXJyb3Igc3VjaCBhczogIlNvcnJ5LCBidXQgc3VjaCBhIGNvbW1hbmQgZG9l
cyBub3QgZXhpc3Q6ICdBRH4zJyIuIEFmdGVyIHJldHlwaW5nIGFuZCBleGVjdXRpbmcgdGhlIGZ1
bGwgY29tbWFuZCBhZ2FpbiwgVmltIG9wZW5zIGFzIGV4cGVjdGVkLiBIb3dldmVyLCBpbnNpZGUg
dGhlIHJlYmFzZSB0b2RvIGxpc3QsIGV4dHJhIGNoYXJhY3RlcnMgYXBwZWFyIGJlZm9yZSB0aGUg
Y29tbWl0IGhhc2guIEZvciBpbnN0YW5jZSwgYSBsaW5lIHRoYXQgc2hvdWxkIGJlICJwaWNrIGFi
NTQ2ODciIGJlY29tZXMgIkhFYWI1NDY4NyIuIFRoZSBpbnNlcnRlZCAiSEUiIGNvbWVzIGZyb20g
dGhlIGJlZ2lubmluZyBvZiAiSEVBRH4zIi4gSXQgYXBwZWFycyBpbnNpZGUgVmltIGJlY2F1c2Ug
dGhlIC1pIGZsYWcgYXV0b21hdGljYWxseSBwdXRzIFZpbSBpbnRvIGluc2VydCBtb2RlLCBzbyB0
aGUgcHJlbWF0dXJlbHkgY2FwdHVyZWQga2V5c3Ryb2tlcyBhcmUgdHlwZWQgZGlyZWN0bHkgaW50
byB0aGUgZWRpdG9yIGluc3RlYWQgb2YgdGhlIEJhc2ggcHJvbXB0LiBJbiBzdW1tYXJ5OiBXaGVu
IHR5cGluZyBhIGNvbW1hbmQgZHVyaW5nIHRoZSBleGVjdXRpb24gb2YgYSBwcmV2aW91cyBHaXQg
Y29tbWFuZCwgcGFydCBvZiB0aGUgaW5wdXQgaXMgaW5jb3JyZWN0bHkgc2VudCB0byBWaW0gaW5z
dGVhZCBvZiByZW1haW5pbmcgaW4gR2l0IEJhc2guCgpXaGF0IGRpZCB5b3UgZXhwZWN0IHRvIGhh
cHBlbj8gKEV4cGVjdGVkIGJlaGF2aW9yKQpJIGV4cGVjdGVkIHRoZSBwcmUtdHlwZWQgY29tbWFu
ZCB0byBhcHBlYXIgb25jZSB0aGUgY3VycmVudCBjb21tYW5kIHdhcyBkb25lLgoKV2hhdCBoYXBw
ZW5lZCBpbnN0ZWFkPyAoQWN0dWFsIGJlaGF2aW9yKQpJbnN0ZWFkIHRoZSBjb21tYW5kIHdhcyB0
eXBlZCBhcyBhIHNpbXBsZSB0ZXh0IGluIHRoZSBWSU0gZWRpdG9yLCBvbmNlIGl0IHdlbnQgb3Bl
bi4KCldoYXQncyBkaWZmZXJlbnQgYmV0d2VlbiB3aGF0IHlvdSBleHBlY3RlZCBhbmQgd2hhdCBh
Y3R1YWxseSBoYXBwZW5lZD8KVGhlIGRpZmZlcmVuY2UgaXMgdGhhdCBpdCBjb3JydXB0ZWQgdGhl
IGZpbGUsIHdoaWNoIHdhcyBub3QgZXhwZWN0ZWQuCgpBbnl0aGluZyBlbHNlIHlvdSB3YW50IHRv
IGFkZDoKClBsZWFzZSByZXZpZXcgdGhlIHJlc3Qgb2YgdGhlIGJ1ZyByZXBvcnQgYmVsb3cuCllv
dSBjYW4gZGVsZXRlIGFueSBsaW5lcyB5b3UgZG9uJ3Qgd2lzaCB0byBzaGFyZS4KCgpbU3lzdGVt
IEluZm9dCmdpdCB2ZXJzaW9uOgpnaXQgdmVyc2lvbiAyLjU1LjAud2luZG93cy4xCmNwdTogeDg2
XzY0CmJ1aWx0IGZyb20gY29tbWl0OiBiZjVhZmRlY2MxMDQ3ODM5N2Q3MDU5ZDA3NTczNjMwOTAy
ZmIyZTJmCnNpemVvZi1sb25nOiA0CnNpemVvZi1zaXplX3Q6IDgKc2hlbGwtcGF0aDogRDovZ2l0
LXNkay02NC1idWlsZC1pbnN0YWxsZXJzL3Vzci9iaW4vc2gKcnVzdDogZGlzYWJsZWQKZmVhdHVy
ZTogZnNtb25pdG9yLS1kYWVtb24KZ2V0dGV4dDogZW5hYmxlZApsaWJjdXJsOiA4LjIxLjAKT3Bl
blNTTDogT3BlblNTTCAzLjUuNyA5IEp1biAyMDI2CnpsaWI6IDEuMy4yClNIQS0xOiBTSEExX0RD
ClNIQS0yNTY6IFNIQTI1Nl9CTEsKZGVmYXVsdC1yZWYtZm9ybWF0OiBmaWxlcwpkZWZhdWx0LWhh
c2g6IHNoYTEKdW5hbWU6IFdpbmRvd3MgMTAuMCAyNjEwMCAKY29tcGlsZXIgaW5mbzogZ251Yzog
MTYuMQpsaWJjIGluZm86IG5vIGxpYmMgaW5mb3JtYXRpb24gYXZhaWxhYmxlCiRTSEVMTCAodHlw
aWNhbGx5LCBpbnRlcmFjdGl2ZSBzaGVsbCk6IEM6XFByb2dyYW0gRmlsZXNcR2l0XHVzclxiaW5c
YmFzaC5leGUKCgpbRW5hYmxlZCBIb29rc10KcG9zdC1jaGVja291dApwb3N0LWNvbW1pdApwb3N0
LW1lcmdlCjpyZS1wdXNoCg==
--000000000000ca6fab06558b40e8--
