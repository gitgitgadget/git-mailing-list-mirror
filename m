Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFF021885C
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741387365; cv=none; b=rzq7JCZ7TPDXB40UB5gZjrDFpQELFASkuC2RTgMqE5VyTBdYTmcjj/iq5EgSXL1G4p0whu4MWe/mml5jrUuknn5Jk2bCwnlNtPW7kJsllY7c8jkRQfWv0zlihv7ktf6CAViFdb8BijsBPKHX4OzM9+qxMV8ZsbqfFUJ0XS6ujp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741387365; c=relaxed/simple;
	bh=S8QRFuOBhygtIGZf3Xr6HT+UJg+uCMFpKiYOvLU1DbM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIsVSa9ZuPZ1DqApQV3eaT9WTykkJoSzSDaYXfVcl17BRgCMBWxVw982j+NKJNI9AdelDf9Gg3DkpjrxlSCELwe3pV4aT/KhN+eIZJwdSUo2Pgc67yivug2IBST8k78owkOujrZwnWG155aI7lJDLFXiwLBDlDpm03Xk+ZU5VEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqaQ25Qb; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqaQ25Qb"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-86715793b1fso1013883241.0
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 14:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741387361; x=1741992161; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8gw97BHL9DneqfDv7JqGYPXbZxiurnDCzz/FIHRyLlo=;
        b=lqaQ25Qb2vleNX8I2oTIAEQOr6VXDUoQUaPZk8xnsdkoYK57/HlgF6SvcS86lhxig/
         anwvf381KURsiVKz75TWS5jVHHbSfOGkwCNGuLwgkCXxXrLuPYWxULdmLQ43nu1OyLU8
         lhT7KGH6yp4MEhOTYxuzIunBPOgl/+hOrVyTZ1QmXm6aUp05sX4romW9t4ioZ5qb0rTm
         6vXJfaFDGEIuFQwVPPIVT+3N4gJMolJPYS42fZTRq4D+mKv2iB5b88tWLCLfycd/puwz
         Eg5DFc4+qhMqZDSUQiah0jDd9QvrfOeN/JVJ5UP38Zj9sBqYBtINeUNhPiCXe2Yw5VGo
         GuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741387361; x=1741992161;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gw97BHL9DneqfDv7JqGYPXbZxiurnDCzz/FIHRyLlo=;
        b=YMJi3aN/+JSOYPn3q+iQa4kEzv/e5SruNPrDlaI+AcoPJJhgxAMOL+WnPOjjlGgqoA
         fasocEefYmrDLN305QHG4MKcYmInZFO8kGLsnuXaRndQN+wDJhrqRtBO9rHzGj63/lt3
         DEQiETu7lcgGnbET0YMuPKNZ9sq/MRBmSDNPx0P5Jq0UTBRtQ3hSApMVSxUhII6RrjqP
         p29Cxgs1DpbU/AdWYxu6aUEiaaEHmqmOQYm6VjIskitvcEWKSAL6wt9pTHiAtEUdkYlo
         I316F1t+kgy+azL7qabwxBABBLwFjCpKuWJ5ed7i0HlXlt80qtcgvU2CKqupbscNRNgH
         GRUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNNlMFHYKAJGs586DHjjAYJ9BUcjUYsYYSt3KwV/bGThQGsFLYsjtjwL8kQHZsIytrMjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGTb/4WbGYrQi+bEDBeoqi4CdT17YfG99oTlQpjcTGkBuLVwUn
	TU52J3GJ1lbJVwipdeKY1Pu1lIB74IRaomQa5I/TDBqxlZLDlCHBez22xeydjr5UxkpxiETRClw
	a01igmMO4sUDKWbR6hxSX1Fvx5cc=
X-Gm-Gg: ASbGncu/KFY2vQnc9taXyrwlJHdqtRnOwAz3tBjfQgkXPBrbVuihEDrTsuyyUXY8bNm
	XuCilBW6aThQWarQrHH8W/rTIWL8RJ0WwtuQUqAb5haXHOt2MIyNsjm3oC1IRqwSzl+7OdxZsLs
	km9NQXTHqOhEQ4TTwyZ/6/SIv+YrKyiECnE2h3l4CyV5ctNo7UnBHtEDmzIojl
X-Google-Smtp-Source: AGHT+IGuQL/7idX4UsYoVKub1mG87P/sl8V6g4Wa2XdBVHHelb/WR4ptIG4fd5wn943iejwVFaEC1vAnb9tlsk9N6HM=
X-Received: by 2002:a05:6102:41a8:b0:4c1:9526:a635 with SMTP id
 ada2fe7eead31-4c30a6c1c87mr3923157137.17.1741387360996; Fri, 07 Mar 2025
 14:42:40 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Mar 2025 14:42:39 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <56cf842a-7c1f-4354-b191-35bcc1e139bd@gmail.com>
References: <pull.1871.git.1741018310447.gitgitgadget@gmail.com>
 <pull.1871.v2.git.1741171357627.gitgitgadget@gmail.com> <xmqqzfhzlbie.fsf_-_@gitster.g>
 <082af6a3-a7ba-440d-af84-6c59827a2929@gmail.com> <56cf842a-7c1f-4354-b191-35bcc1e139bd@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 7 Mar 2025 14:42:39 -0800
X-Gm-Features: AQ5f1JpsWUaLtBESl8vaLlFpVuVeqcKZ3pYGnfaVAkGbwoC5Yy-_Yuu86970ljc
Message-ID: <CAOLa=ZRdqk-VXX4LWptqx3C3ABxNcxU+5cDTPxWt3k9UW1m3OA@mail.gmail.com>
Subject: Re: [PATCH] docs: fix check-docs with WITH_BREAKING_CHANGES
To: Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: multipart/mixed; boundary="00000000000011b574062fc8572b"

--00000000000011b574062fc8572b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FPhillip Wood <phillip.wood123@gmail.com> writes:

> On 07/03/2025 10:32, Phillip Wood wrote:
>> On 05/03/2025 15:53, Junio C Hamano wrote:
>>> We correctly omit builtin/pack-objects.o from BUILTIN_OBJS, but
>>> forgot to add "git pack-redundant" on the EXCLUDED_PROGRAMS list,
>>> which made "make check-docs" target notice that the command has been
>>> removed but still is documented.
>>>
>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>> ---
>>> =C2=A0 * The command is still listed in the resulting "git help git"
>>> =C2=A0=C2=A0=C2=A0 output, as cmd-list.perl does not yet know which com=
mands on the
>>> =C2=A0=C2=A0=C2=A0 list are to be ignored under WITH_BREAKING_CHANGES.
>>
>> Good catch. It seems the meson build was also forgotten in 68f51871df8
>> (builtin/pack-redundant: remove subcommand with breaking changes,
>> 2025-01-22) as we still compile builtin/pack-redundant.c and build the
>> documentation. We should probably wrap the function declaration for
>> cmd_pack_redundant() in builtin.h with "#ifndef WITH_BREAKING_CHANGES"
>> as well though I don't think that is urgent.
>
> I just had a look at fixing the meson build but it seems to be tricky as
> the manpage sources are stored in a meson dictionary and meson
> dictionaries are immutable so I don't know how one is supposed to
> conditionally add items.
>

But dictonaries can be combined [1]. So we could probably do something
like I've added below.

[1]: https://mesonbuild.com/Reference-manual_elementary_dict.html

-- 8< --

diff --git a/Documentation/meson.build b/Documentation/meson.build
index 0a0f2bfa14..fcfec63e9b 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -96,7 +96,6 @@ manpages =3D {
   'git-notes.adoc' : 1,
   'git-p4.adoc' : 1,
   'git-pack-objects.adoc' : 1,
-  'git-pack-redundant.adoc' : 1,
   'git-pack-refs.adoc' : 1,
   'git-patch-id.adoc' : 1,
   'git-prune-packed.adoc' : 1,
@@ -205,6 +204,14 @@ manpages =3D {
   'gitworkflows.adoc' : 7,
 }

+manpages_breaking_changes =3D {
+    'git-pack-redundant.adoc' : 1,
+}
+
+if not get_option('breaking_changes')
+  manpages +=3D manpages_breaking_changes
+endif
+
 docs_backend =3D get_option('docs_backend')
 if docs_backend =3D=3D 'auto'
   if find_program('asciidoc', dirs: program_path, required: false).found()
@@ -475,7 +482,7 @@ endif
 # Sanity check that we are not missing any tests present in 't/'. This che=
ck
 # only runs once at configure time and is thus best-effort, only. Furtherm=
ore,
 # it only verifies man pages for the sake of simplicity.
-configured_manpages =3D manpages.keys() + [ 'git-bisect-lk2009.adoc',
'git-tools.adoc' ]
+configured_manpages =3D manpages.keys() +
manpages_breaking_changes.keys() + [ 'git-bisect-lk2009.adoc',
'git-tools.adoc' ]
 actual_manpages =3D run_command(shell, '-c', 'ls git*.adoc scalar.adoc',
   check: true,
   env: script_environment,

--00000000000011b574062fc8572b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 85808d6ab5c82823_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mTGRsNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meHF0Qy80bDZmT1pnU1YwNU54TnZEMVY1UWVzc1k4OQp4WFcrVVRpaTZ6
Q3dVMm1PYlR1N2E2dmpNUWFUREs1Y2tCaDNkNzdndVFiOFlJK2d5V2Mxc0JMLzJzU2JEcDdICkll
TEsxZW95SGI0anVWdEVUdk1WYWU0d3BWMS9ZaEdwMURPTTJlekQyZGsyTzZQRmQwZGtIUm1pUFd0
MENqaE8KM1F5OGZibU5wSkd0WWF1bUd3Zis2VVYyNTFIbzNoUlBMVjUxeFpRZEpSYTdtZVFpc0lZ
anhpcFE5eGNFUDNQLwozSU5QTlVjUHZwdlZHWHRDRFpRWjdxQXFBUEV3L2tLR1pmdGNySzFnLzdh
UHpHSEtTTSs5ekNHRFJXanhMRy92CmlQR0pqdFg4NzZBWDRxV00yNzEwVG1aTzFoVG1LRWxwOWxY
VHExQk1iSGdBNlpZQmJWWG8zMVMycU9tNnl4dlgKSnZiQkJXZm1qSm01TEtDQ1lKR3V4V0Z5SFo4
MWtOeHpkS1p3Z1pyOHBIMUxZVW9DVjJvSzNvS1FueXAyMXp3MwpHTzBRZVplOS9sc043VHhzZDV1
dm5RTGNadVA0R2NBWVBjenNRR2wvU0VDdkoxQnV4TnlwRVBwU3JiOElhYXlQCm8rSjJiRFBtVklu
MUFuc1BKeS9BQWVrU2JFYlc0OHpWMVk4YlBLOD0KPTR4NWgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000011b574062fc8572b--
