Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8108722129A
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744373634; cv=none; b=N4wvrnthseM1Zq6ws7mvTS2CuAQkYUhvzjNT17WX23f7SUmQjt277esXzg7+u3XFeOqb7F4GY6MBROeRhNyyg77dJa8ptDlprLUBbcZfm/DdD0e9hZOxiDGhqUfKmTQGsTR4meoaK8T4GGb1GrLgK2uj3HYL0i7pjTCTlOti3l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744373634; c=relaxed/simple;
	bh=dIBSvpXqZjKbiiRvZe/vIx2O1i4pYp+yqFaUy4W8xxE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6dj4YXSbL9Xk3QirdDEMq8KpwmpPkk6b8xf26Pdky9g00vX1gfp30yzjX0weOyM/kQ4VUOzLXDBh6NBO2b9cO0BKKCfY7IAl0kVupzuuZ6pQtPkKpW1p7Fhypcob1XGPz7AQWpvftbwQXZayPcNBnIuWbqfTQ3cznDay0Lk1Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gp9/1vcB; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp9/1vcB"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-523f721bc63so2616874e0c.0
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 05:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744373631; x=1744978431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Op4G4r0HRZVi6vw6UP77O2lVxpOxKv8i3MbEZuTB74M=;
        b=Gp9/1vcBsECGxPUS3iYoKV5rMGlWRYI3T3/pRAJy1IOkUdvGPvqdeUPPptDeFSgOcJ
         zDECUQURrHG51Ch680iPnzTtlEe935YBeQCV9eOCFP3SvONIXboXqXXL8wMyjBOwfGkl
         +N1Mh87FxcSyHs8wRicDO6C6a/EjF38dG2xF9tFQlDUt/IgArv08oHVvyavymUStC6MM
         lNmcHjgswnX/3/Z0NTj+PqyhvIYsCWOOYa48SMe7Z6t1xb5PbK4/2Ae+EcfkYjf/aP0+
         nB2zldtcUOzj3mMlF76w2xXSJUbR1Jp07qqkDN1YAnn5akJfEj9tbb2AAX7haiVTyI4F
         87wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744373631; x=1744978431;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Op4G4r0HRZVi6vw6UP77O2lVxpOxKv8i3MbEZuTB74M=;
        b=Z1DLLGZHVczppMRXpqvQxhb4oJvM5Gzqo12HAdjm5ftDg1h6l3OurgEgMTM3IAvi1A
         OJHv/kaNIDmgc/LCDqhH2o0jTe+TRO84cOd4cGZyHoge9MKO+SYse6fRSnUb5zDia7IC
         iRlvdMhjkWb2Wx8kESNPza6qQG6l6QgsY+ybc3BHJ7in6BtvaIol0CyOL47CSQEZVAdC
         HH+2h4rVvEE463nVvmw9lsdfnid2cM3ILu3j2UPoxUPe7QYua8iDGWWCMmhgDMso554g
         4bCcySQOmpgJNrAN/1Ukhi17bacRs5tb8XGbVPUfTIXldYFzH+WIdla/LcKdl3IVe7Rf
         Flmg==
X-Gm-Message-State: AOJu0YxdSlX3Td6LPeAB+tV8sQPdSTwrQkD6zj7rTa3xhBp1AQmWYGpN
	QS1w4C/q3/GYXkhu/DpQY9f3USj6T/OrLxUnkAUcQk9LOYA+IGN59z/9WdFbcN0Hu0nWRIzDjs5
	HbAU8LTl6Wn7Kx4Kzkfk5Y1UNNis=
X-Gm-Gg: ASbGncs5uFFaZ+L/2BROUd2gjGKJj3vh04JDHIJYX9dZNf4WUyUxDRHrP+p3wYT/dvB
	hX63I8LX7771sV3X9y3SBr/SgdezIasn8OSjgM4eXh5STOLpUToaj35O0KkD0vGUOwrFbt+jRCW
	bnxTYpd3C5UKJYeEh4j5hy
X-Google-Smtp-Source: AGHT+IGG56auwXzoYm3z0CBN+IzClNS18RKyyTOtPJf2oHqNlaahQk3t8kl+Y4oLMGjayON7SAqkDxZxe9VB3fm2WlY=
X-Received: by 2002:a05:6122:da3:b0:51f:a02b:45d4 with SMTP id
 71dfb90a1353d-527c2e94963mr1907767e0c.1.1744373631321; Fri, 11 Apr 2025
 05:13:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Apr 2025 05:13:50 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Apr 2025 05:13:50 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z_jptp_xj2gpJ65s@pks.im>
References: <20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com>
 <20250410-505-wire-up-sparse-via-meson-v2-2-acb45cc8a2e5@gmail.com> <Z_jptp_xj2gpJ65s@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Apr 2025 05:13:50 -0700
X-Gm-Features: ATxdqUEGZOzANlS_NGJhLbAF373vit3lihFQhAWZ3q35SmoM52_NU1oZLbOon58
Message-ID: <CAOLa=ZQvM+PPJMMmQ2XQrK5Z=j178rJVEY01X0u6ozfgPLhyFQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] meson: move headers definition from 'contrib/coccinelle'
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, toon@iotcl.com
Content-Type: multipart/mixed; boundary="000000000000a6adbe06327fa2ef"

--000000000000a6adbe06327fa2ef
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Apr 10, 2025 at 01:30:32PM +0200, Karthik Nayak wrote:
>> diff --git a/meson.build b/meson.build
>> index e98cfa4909..790d178007 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -633,6 +633,28 @@ builtin_sources = [
>>    'builtin/write-tree.c',
>>  ]
>>
>> +third_party_sources = [
>> +  ':!contrib',
>> +  ':!compat/inet_ntop.c',
>> +  ':!compat/inet_pton.c',
>> +  ':!compat/nedmalloc',
>> +  ':!compat/obstack.*',
>> +  ':!compat/poll',
>> +  ':!compat/regex',
>> +  ':!sha1collisiondetection',
>> +  ':!sha1dc',
>> +  ':!t/unit-tests/clar',
>> +  ':!t/unit-tests/clar',
>> +  ':!t/t[0-9][0-9][0-9][0-9]*',
>> +]
>> +
>> +headers = []
>
> I think we should make sure that this variable isn't declared at all
> unless `git.found()`. Otherwise, we may accidentally it it even though
> it does not contain anything sensible.
>

Fair, I wonder if we should treat 'third_party_sources' similarly, but
since it is static, it should be fine.

> Patrick

--000000000000a6adbe06327fa2ef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f2094d06501edcbd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mNUIzMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meHJ3Qy85YVZJYm9wbFlHdTAxdGl3dHZ3RTQ2cWtxNApCeDdQOUkrRnMx
eEY5WHY0RXBjV2pvc1poV3IyNFFmbTBGL0cxdnpsK2VabjJwSVJ4U2ZVd0NjN3E5SmozZGNjCmpS
aWsveWlqTU5WOElnaHVCUEcxQWdXV241TnV1aDdHdjYyTm1UK2s4KzZaVlFtUUg5eFViN3RBNXRr
eGVaS3AKQ0RXU2haWFBlQXJ5YU5wOVc5b0xJcmp2Zk5TQUVmNGMwV2V5OGw1clR1NGxmUTRzenVk
Umg5UlcyajBFUmNmeApkMjdmS0J0czVNd0RLOUlyOThRMGRDcXdhL3JnSkxDVmROYlFyaTRHMTdI
UXhRRUgyZ0wxVmFabkMvWnpJQmI1CmZoa3ViL2FyRlVTVndCZkd3MjRESlFyeTJKajVLU0tEd0Q2
bERkanZMN01DQ0R0aUZXKytVZytRYUNMRTZpbmUKUVJuKytyTUJxVEFHc0lFMmd1VUVXOVFDbllN
ZE1FOHI0ZDJ3cVQwZE1CeENtSm9Wd2ZSd2gzWVMvUEN5KzZxSwowSFY2R215SHFQdCtVYXFrUG1X
dU5iTVZZZFNub3p2S2d4Znl2amhtNDVvUjlFR2xHNE1VWGFER2RkbEtiV2tmClZmU1EvUkFDRzNo
a1Z6VFJpQ1VvNksxRjBlU0huT0FuWDJoRHpTMD0KPXhCSnEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a6adbe06327fa2ef--
