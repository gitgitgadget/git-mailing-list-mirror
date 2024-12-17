Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D120E1DF963
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432345; cv=none; b=uQqJCYhFNy/MOr+4D2efmil94G/tu9/1TlTM9IS7DQaMBk7ra3wuaZzcJFN2ay6cXKZQ7viiEdUUJuCMkoHdOlyL9lqRBJVcWU8MLe2yDNlx3ZQlzbIJtI/nCSwSdcqlC846ghRrztaxdmKe2PAjrWJooW61D49sUrI+GXJum+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432345; c=relaxed/simple;
	bh=e3I3ejsOu1vohiy1q23EJOV2oOY48jLzGWlxCk1vXsc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UZ95hyOGxPtLJbdOzLLgdedkKUoN+dBDxVBtsnMi7gnVRnQopUuujFC24D4jeVDUkU+VjwVC9WWKzGyX8CEH48Dg6A7ICzfslytF2371D9pyAuObXf7kLHesoBivG7rfgmtL67+Gk7XrlA/U56MCRkOpOTiRGjy5X9C5EP/99vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFJdVcEc; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFJdVcEc"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso3867534276.1
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 02:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734432343; x=1735037143; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=joz6dXs2ni1t6aL6oFx6LjtZ9peWM6YhT7Q0EJxwyBY=;
        b=ZFJdVcEc3I7hGGOQMRKU3xWD51qixlo4F1dvIe49b+6Y2K07nNDzJwdi28f4y0KDHS
         8+xJ5K9/DGe7+7xvv1NeXDX6kYeKD2UY2s0RDwcDy32nGyjzL/OyDVtuNGcCa9VjLh8O
         6Z2FKQ0q29seZOvVk0xBXagsyPV/I6NGHsjT0+pm4xW1+ct6iUs7mlse45l3y6UYPOPK
         KtsTrJFCOFTGe9t/IGLzgQaRIWaMebKU8nBymJ3rCwncBouB7ye819VOksEn4EMWZjBI
         n/vtrSa77EPjNWdIFpakQC0QHTiV8rdYS5UxZyNHYG3C9uHjmEsJi1hENDfzUV/HgAeb
         y0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734432343; x=1735037143;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=joz6dXs2ni1t6aL6oFx6LjtZ9peWM6YhT7Q0EJxwyBY=;
        b=v9Q46a+hHOC6T4uBvI2bLWjdxhbj6GCbFnQ638zkw/xeVJMKJNTIGtv3UUc5W5m3wY
         cGWoHrN/PySUhwn3Su996hVUIQdbk/M2wPrPjEf2LHZ7IdrTQ5hW23NVQsNfmyWx93bh
         GUTaWWnek5lbOC6xaj2fx+53H6eHaMNJHgU+f+5j/+XRWwqHs+TrTbROIHXpAnOZtW1f
         8R3vYwdn3lGpv8dpbth8Z89EkrXCqzmNEIO9sNZoqusm1Zz6v3EWmv7XY3Cp/B6UGWGw
         bvz+gMUyWpc9hXLIJpUiA3l4Gf4gee+36XcKdz0IC7zGnJiA4TrcDQq12V5rRvApMeCN
         ue8w==
X-Gm-Message-State: AOJu0YwV+38M64h8hkRTVC/vQHxvj7jjrUbxhPt0ELBckusr9CrEQdOX
	Vf7dAEkL8TpXzbijHpwFKLFoae6jTe93JX3ZMljjcJoMKYsxww4DcdKtU248fGIjauCYbMvOZsN
	Kb6az9DfkRWxFNdgeY6rCiuj/jdMZiw==
X-Gm-Gg: ASbGnctXkAMa/wXRKUcKJV9caFCw3Bq6UPlmQuG4QR/D45Kk+sgGiG1jk4iE40pTrnb
	wiiI23rMfFh4S8dA8NFCThaeRxYdD/e0LAyQGUM1RZaMQ6kM0l72sejG1mw9DGgRECZKm+Cwu
X-Google-Smtp-Source: AGHT+IEF/JxlCJj2XmFjE4cqULijvaag6eF7ClkuTmuR0dfcrDdTAF4yI22lnYIALyJlcrju9nJt03/X4u+vPAg7RGI=
X-Received: by 2002:a05:6902:260b:b0:e4c:bd70:8532 with SMTP id
 3f1490d57ef6-e4cbd709302mr6243239276.23.1734432342700; Tue, 17 Dec 2024
 02:45:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?SXN0dsOhbiBHZXJnZWx5IMOJZGVz?= <edesig@gmail.com>
Date: Tue, 17 Dec 2024 11:45:37 +0100
Message-ID: <CAKZ0Q3e3+RtLaQmsW+QCWtv1m05bOGptS8XnZTB1fV=w+ErxEA@mail.gmail.com>
Subject: Bug report
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000acea56062974ff6a"

--000000000000acea56062974ff6a
Content-Type: multipart/alternative; boundary="000000000000acea55062974ff68"

--000000000000acea55062974ff68
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Developers,

I attached my report about some minor inconsistency of the behaviour of the
gitdir directive used within includeIf in the global git config file.

Best regards
=C3=89des I. Gergely

--000000000000acea55062974ff68
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Developers,<div><br></div><div>I attached my report a=
bout some minor inconsistency=C2=A0of the behaviour of the gitdir=C2=A0dire=
ctive used within includeIf in the global git config file.</div><div><br></=
div><div>Best regards</div><div>=C3=89des I. Gergely</div></div>

--000000000000acea55062974ff68--
--000000000000acea56062974ff6a
Content-Type: text/plain; charset="US-ASCII"; name="git-bugreport-2024-12-17-0930.txt"
Content-Disposition: attachment; 
	filename="git-bugreport-2024-12-17-0930.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m4sc6tfd0>
X-Attachment-Id: f_m4sc6tfd0

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCgpJIGFkZGVkIGEgY29uZGl0aW9uYWwgaW5jbHVkZSB0byBteSBn
bG9iYWwgZ2l0Y29uZmlnIGZpbGUgd2l0aCBhIGBnaXRkaXJgIGNvbmRpdGlvbgp3aGVyZSB0aGUg
Z2xvYiBhZnRlciBnaXRkaXIgcmVmZXJlZCBhIHBhdGggdW5kZXIgYSBzeW1saW5rZWQgZGlyZWN0
b3J5LCBhbmQgY2FsbGVkCmBnaXQgY29uZmlnIC1sYCBmcm9tIGEgc3ViZGlyZWN0b3J5IG9mIGEg
cmVwb3NpdG9yeSwgd2hpY2ggbWF0Y2hlcyB0aGUgZ2xvYiBhYm92ZS4KCgpXaGF0IGRpZCB5b3Ug
ZXhwZWN0IHRvIGhhcHBlbj8gKEV4cGVjdGVkIGJlaGF2aW9yKQpgZ2l0IGNvbmZpZyAtbGAgc2hv
d3MgdGhlIGtleXMgZnJvbSB0aGUgaW5jbHVkZWQgZmlsZSB3aGVuIGl0J3MgY2FsbGVkIGluIGFu
eSAKc3ViZGlyZWN0b3JpZXMgb2YgdGhlIHJlcG8uCgoKV2hhdCBoYXBwZW5lZCBpbnN0ZWFkPyAo
QWN0dWFsIGJlaGF2aW9yKQpgZ2l0IGNvbmZpZyAtbGAgc2hvd3MgdGhlIGtleXMgZnJvbSB0aGUg
aW5jbHVkZWQgZmlsZSB3aGVuIGl0J3MgY2FsbGVkIGluIHRoZSAKcmVwbydzIHJvb3QgZGlyZWN0
b3J5LCBidXQgbm90LCB3aGVuIGl0J3MgY2FsbGVkIGluIGEgc3ViZGlyZWN0b3J5LgoKV2hhdCdz
IGRpZmZlcmVudCBiZXR3ZWVuIHdoYXQgeW91IGV4cGVjdGVkIGFuZCB3aGF0IGFjdHVhbGx5IGhh
cHBlbmVkPwpUaGUgYmVoYXZpb3VyIG9mIGBnaXQgY29uZmlnIC1sYCBpbiBzb21lIHN1YmRpcmVj
dG9yaWVzIG9mIHRoZSByZXBvLgoKQW55dGhpbmcgZWxzZSB5b3Ugd2FudCB0byBhZGQ6CjEpIEkg
d2FzIGFibGUgcmVwcm9kdWNlIHRoaXMgYmVoYXZpb3VyIG9uIGFuIFVidW50dSBob3N0ZWQgb24g
V1NMMiB3aXRoIHRoZSBmb2xsb3dpbmcgc2NyaXB0CmBgYAojIS91c3IvYmluL2VudiBzaAoKcmVh
ZG9ubHkgTElOS0VEX0RJUj0iJChta3RlbXAgLWQpIgpyZWFkb25seSBURVNUX0RJUkVDVE9SWT0i
JEhPTUUvZGVidWdfZ2l0X2luY2x1ZGVJZiIKcmVhZG9ubHkgVEFSR0VUX0RJUkVDVE9SWT0iJFRF
U1RfRElSRUNUT1JZL3RhcmdldCIKcmVhZG9ubHkgUkVQT19ESVJFQ1RPUlk9IiRUQVJHRVRfRElS
RUNUT1JZL3JlcG8iCnJlYWRvbmx5IFJFUE9fU1VCRElSRUNUT1JZPSIkUkVQT19ESVJFQ1RPUlkv
c3ViZGlyIgpyZWFkb25seSBHTE9CQUxfQ09ORklHPSIkKG1rdGVtcCkiCnJlYWRvbmx5IENPTkZJ
R19UT19CRV9JTkNMVURFRD0iJFRBUkdFVF9ESVJFQ1RPUlkvLmdpdGNvbmZpZyIKCmRlYnVnKCl7
CgkiJEAiID4mMgp9CgojIFByZXBhcmUgZGlyZWN0b3JpZXMKdW5saW5rICRURVNUX0RJUkVDVE9S
WQpsbiAtcyAkTElOS0VEX0RJUiAkVEVTVF9ESVJFQ1RPUlkKbWtkaXIgLXAgIiRSRVBPX1NVQkRJ
UkVDVE9SWSIKCiMgUHJlcGFyZSBjb25maWcgZmlsZQpjYXQgPiAiJEdMT0JBTF9DT05GSUciIDw8
IEVPRgpbY29yZV0KICAgICAgICBmaWxlTW9kZSA9IGZhbHNlCiAgICAgICAgZWRpdG9yID0gdmlt
Cltpbml0XQoJZGVmYXVsdGJyYW5jaD1ncmFuZG1hc3RlcgpbaW5jbHVkZUlmICJnaXRkaXI6JFRB
UkdFVF9ESVJFQ1RPUlkvIl0KICAgICAgIHBhdGggPSAkQ09ORklHX1RPX0JFX0lOQ0xVREVECkVP
RgoKY2F0ID4gIiRDT05GSUdfVE9fQkVfSU5DTFVERUQiIDw8IEVPRgpbdXNlcl0KICAgICAgICBl
bWFpbCA9IHRlc3RAbWFpbC5jb20KICAgICAgICBuYW1lID0gVGVzdCBVc2VyCkVPRgoKZGVidWcg
ZWNobyAiZ2xvYmFsIGNvbmZpZyBhdCAkR0xPQkFMX0NPTkZJRyIKZGVidWcgY2F0ICIkR0xPQkFM
X0NPTkZJRyIKZGVidWcgZWNobwpkZWJ1ZyBlY2hvICJjb25maWcgdG8gYmUgaW5jbHVkZWQgYXQg
JENPTkZJR19UT19CRV9JTkNMVURFRCIKZGVidWcgY2F0ICIkQ09ORklHX1RPX0JFX0lOQ0xVREVE
IiAKCgpjZCAiJFJFUE9fRElSRUNUT1JZIgoKZGVidWcgZXhwb3J0IEdJVF9DT05GSUdfR0xPQkFM
PSIkR0xPQkFMX0NPTkZJRyIKZGVidWcgZ2l0IGluaXQKRklMRV9UT19DT01NSVQ9IiRSRVBPX1NV
QkRJUkVDVE9SWS9maWxlIgpkZWJ1ZyB0b3VjaCAiJEZJTEVfVE9fQ09NTUlUIgoKZGVidWcgZ2l0
IGFkZCAiJEZJTEVfVE9fQ09NTUlUIgpkZWJ1ZyBnaXQgY29tbWl0IC1tICJpbml0aWFsIGNvbW1p
dCIgLiAKCmVjaG8gdXNlciBjb25maWcgb2J0YWluZWQgZnJvbSB0aGUgcmVwbyByb290CmdpdCBj
b25maWcgLWwgfCBncmVwIHVzZXIKCmNkICIkUkVQT19TVUJESVJFQ1RPUlkiCmVjaG8KZWNobyB1
c2VyIGNvbmZpZyBvYnRhaW5lZCBmcm9tIGEgcmVwbyBzdWJkaXIKZGVidWcgcHdkCmdpdCBjb25m
aWcgLWwgfCBncmVwIHVzZXIKYGBgCk9uY2UgSSBzYXZlZCBpdCBpbnRvIHRoZSBleGVjdXRhYmxl
IGByZXByb2R1Y2Uuc2hgIGZpbGUgcnVubmluZwpgYGAKLi9yZXByb2R1Y2Uuc2ggMj4gL2Rldi9u
dWxsCmBgYApnaXZlcyB0aGUgZm9sbG93aW5nIG91dHB1dApgYGAKdXNlciBjb25maWcgb2J0YWlu
ZWQgZnJvbSB0aGUgcmVwbyByb290CnVzZXIuZW1haWw9dGVzdEBtYWlsLmNvbQp1c2VyLm5hbWU9
VGVzdCBVc2VyCgp1c2VyIGNvbmZpZyBvYnRhaW5lZCBmcm9tIGEgcmVwbyBzdWJkaXIKYGBgCmlu
c3RlYWQgb2YKYGBgCnVzZXIgY29uZmlnIG9idGFpbmVkIGZyb20gdGhlIHJlcG8gcm9vdAp1c2Vy
LmVtYWlsPXRlc3RAbWFpbC5jb20KdXNlci5uYW1lPVRlc3QgVXNlcgoKdXNlciBjb25maWcgb2J0
YWluZWQgZnJvbSBhIHJlcG8gc3ViZGlyCnVzZXIuZW1haWw9dGVzdEBtYWlsLmNvbQp1c2VyLm5h
bWU9VGVzdCBVc2VyCmBgYAoyKSBXb3JrYXJvdW5kCkNoYW5naW5nIHRoZSBnbG9iIGluIHRoZSBn
aXRkaXIgZGlyZWN0aXZlIHRvIG9uZSByZWZmZXJyaW5nIHRvIGFuCmFic29sdXRlIHBhdGggcmVz
b2x2ZWQgbXkgaXNzdWUuCgpQbGVhc2UgcmV2aWV3IHRoZSByZXN0IG9mIHRoZSBidWcgcmVwb3J0
IGJlbG93LgpZb3UgY2FuIGRlbGV0ZSBhbnkgbGluZXMgeW91IGRvbid0IHdpc2ggdG8gc2hhcmUu
CgoKW1N5c3RlbSBJbmZvXQpnaXQgdmVyc2lvbjoKZ2l0IHZlcnNpb24gMi40Ny4xCmNwdTogeDg2
XzY0Cm5vIGNvbW1pdCBhc3NvY2lhdGVkIHdpdGggdGhpcyBidWlsZApzaXplb2YtbG9uZzogOApz
aXplb2Ytc2l6ZV90OiA4CnNoZWxsLXBhdGg6IC9iaW4vc2gKbGliY3VybDogOC41LjAKemxpYjog
MS4zCnVuYW1lOiBMaW51eCA1LjE1LjE1My4xLW1pY3Jvc29mdC1zdGFuZGFyZC1XU0wyICMxIFNN
UCBGcmkgTWFyIDI5IDIzOjE0OjEzIFVUQyAyMDI0IHg4Nl82NApjb21waWxlciBpbmZvOiBnbnVj
OiAxMy4yCmxpYmMgaW5mbzogZ2xpYmM6IDIuMzkKJFNIRUxMICh0eXBpY2FsbHksIGludGVyYWN0
aXZlIHNoZWxsKTogL2Jpbi9iYXNoCgoKW0VuYWJsZWQgSG9va3NdCg==
--000000000000acea56062974ff6a--
