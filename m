Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7869370AE5
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849973; cv=pass; b=dLd9TrNi0mvpsopFL0rfdHicF4jaGbaSDwpWUeBH2LXgRaIy2vrI+1C+OEXaBAzXtR8/IkIUgc15acaxvWpw0XxvtqkJq5Qd2Z+FXwOTSz7ilw565g1X/SzThqaTNXqs2Us1Da2x3Eoyv0r9s+XQI3q3sgjmp6WN1Zp9C0rD05Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849973; c=relaxed/simple;
	bh=ubIxZ83rU2DZN/H7hdOwI3F46oGdJafV1K6smGDfGR4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBzhMEfu0AyBiaCrQOhY4+yLO3euOqfUx1KSYqWE3c6RoaGKSHrmrE/vTgnPDerq9KaT5RE12lis6fWgwTc2g7G9pV3JuqSeCdbs08CNdNSt3zMTHQehGaXIF6c14BZGRMgyw3ZfTDg4eRC1rOgwu2d+gftzfek/WwQNdCkecQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2jgJDeJ; arc=pass smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2jgJDeJ"
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7ac5b4011a4so3869369137.2
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 03:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790849970; cv=none;
        d=google.com; s=arc-20260327;
        b=VRdB8eWvjox7qV83DrC3siC2f2+Ywa/RVpp9qT+2JpGi/cIhALWOx1vFB89XldWraJ
         yQ31ZMrWKd8RKpTCL49uKqfHxWkuhyRQ1i0MjtG/cNsSkV7QK/nJ4h71K+njt9EsoDdx
         ku7lb8whYrLOdO3fzbClKMlIO9c/FceaKXRGJQeIfVWyCqXdJg4hkvqP/6uOTap6LI/B
         psK2uzvoGZGNGdwHPXw6lRxgYhowtbo9J1Fvy8VijJ/AVkCL3Oljk3//Plh2b/0WF6wH
         sb+44k9/Yb7kqMYHplUOv1o0XeweMNsnpBnExr3Tih5wTaWi3uGa1c5G+SGwY+qvLKFw
         nNaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=U3JakrshkxDV6htBmrGCZXlP34FhMmC0Cxd6mTXg9q8=;
        fh=Z+zMUlcZAS1mUy9ZjC4HQjbXAaylW+o90czjUdqFPJE=;
        b=IoChtDJigPQX9aQbqsSaU+74eT7IUSnFCKn0ojk3rU9NvR8jdeYe+FvEEByulzynCq
         IXUwLewya82KRz88ECV9tpbRq5+gD19EUydf7RomCCm2kPneHPiGl8h0NKqdhapUotSY
         sUpmAbwnU9SwjJeruNQFiomeQfOLHbBlcc32pYAbhqKlGxGdd7dIo3yuTk9FPLjlVitU
         dZuhgJIX2lSUJGMmnerOCKKl/Q9EsvDvcpMMMy1WBsfWAQrsMP4/dkA/4W5ERs57ILny
         DyyHeLFe8iGXll5Ylgin/2W/9bu+fYrnCmRsX4rPteEgAFQq93ngzYWd4WeVZ9l0isOj
         m/aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790849970; x=1791454770; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U3JakrshkxDV6htBmrGCZXlP34FhMmC0Cxd6mTXg9q8=;
        b=c2jgJDeJIlRK3hDohvF2bNq31/1I8PXWVeQ1Zjx313WTGk4y502CpTn9wPul0aezxw
         PsjTxRhlKxc5F0KaqHEctYpLapg1djBZGR3ejCxO+fNF+vtJYXYJysYaxkfLJHfC6dhe
         FZXvuPR5XYTuzmXrX1b3nUqm5YorG5h5Wv3jp9mohBBzthaUdmGQAYaYWYHqemr7Zyrq
         JsMN4Eok2jdc6QMPchBfQ3Hp4Cdk/LMV7rbvL617PCtDzY4oAf37sOGiNrpiSx0SLnSt
         3PODleCx5QovTKDMnkzMtCUUaSzBJCnxgw12C4v84ri7dZpxSNqLEr6d5r0xUp2XHS6f
         Xz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790849970; x=1791454770;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U3JakrshkxDV6htBmrGCZXlP34FhMmC0Cxd6mTXg9q8=;
        b=oUXkCxzETsIdx57gFXyxnDOIIuCpoxPpRfRfIlU+q+CnS+dfVzoM1QKtr1km+MF/hJ
         cyqJLREejcw5EQ/7w4DXSBh+1idXPqOk1WsnmLyzUvfrlMv8Gz94LioMoaXgYEh9rg1h
         7OH/6a/nN5F6RCSWj2G25vpWIDvV8vhgECz090Oy4rHI7iwwi97QQhcQiqKYmdQgPjor
         SmUO2vpC7DGNZChZ7oHkBXvdCTLWYaUCfr38or4dZ6xvvlTF1nJtRBcYlYXkym/RfzFM
         vCE+D+WZ6VLRVXRdLM3sw5bn1kqB09z4ax3a7q8kyfIRzuVqi5cOWZxrj3PihT9SzkP7
         H7UA==
X-Forwarded-Encrypted: i=1; AKwUvBx2Qw62xWnhHUmeu3NYWk/6p28Z8Q/PkWChR2NH9oRKo4ZtXkifDTDRLaMXUUKLUbdqnR8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfVbEaFcMf8fAZJMbdqI11o/rCotsmJfRFdEEtQQYQqnKaajJN
	rTtZrVwoZTIjeXFLSL8ii9MlxsuujPE0xwgh3YjCCHvMnpD0IsHtE03V3YOuxXNq3D+1tWYWVhp
	0hAQ2vnws9/csBLHOZaDpaM5Ol0cK20Fh2A==
X-Gm-Gg: AYBFou35ajJtRnUMuDfCKGZBWyYRuO1tgmcw3LZpcUEv82A4qJ/HUqX/oksnwdU6Yg3
	CD4NbLfOGlFG+puLizPCA2BJ16HDHKX6uM1JtMCskglQwIvuOlEeR+XRzQmM9d4HfXrffvdXKYM
	bsIlswQUCiAvjtkl6s1mSb+KVNA1MawF0jyAu/yFz+YQwXT9uomRTaH58dsLQpvMzk3MIlsRtW/
	1LcFn/XXNW6ijyHBjPPupKUF4QH6Uj5KCus09mz47/Dj5JaZ5jhtAxWLOoMV6ONHYrfNaKug6XD
	oTSsBJqIjDdmaBsoCJUNkSqN4OmXbfcnAKtbsmb8Lssl7//mdsLlgIFVveM1CaBpXUKoezH//rd
	SmwdODlp/6/HM2rTiWNwQzNdXFrcEqQkXkvpc20HTDfLn3g==
X-Received: by 2002:a67:e7c3:0:b0:7be:44da:1519 with SMTP id
 ada2fe7eead31-7be7309b225mr1171790137.19.1790849970494; Thu, 01 Oct 2026
 03:19:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Oct 2026 05:19:29 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Oct 2026 05:19:29 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261001-pks-reftables-fix-timezone-format-v2-0-a4fd1f7cd21a@pks.im>
References: <20260929-pks-reftables-fix-timezone-format-v1-0-3df105a95ed1@pks.im>
 <20261001-pks-reftables-fix-timezone-format-v2-0-a4fd1f7cd21a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 1 Oct 2026 05:19:29 -0500
X-Gm-Features: AclHuK-J30Tr_0zS1pu8dX9g5njdUQHG_1UVAkyoFGaxV3NiYGMzmT1I8MRFbVg
Message-ID: <CAOLa=ZRVt=e3MqjLY=UkitfSg_YjpsfFjeDsEmqJQm-5YhopxA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] refs/reftable: fix on-disk representation of
 reflog timezones
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Josh McKinney <git-bugs@lists.joshka.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000568cc3065cc4c087"

--000000000000568cc3065cc4c087
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> it was reported [1] that the way we store reflog timezones with the
> reftable format has a mismatch with the reftable specification. While
> the spec says that reftables should be stored as a signed offset in
> minutes, we store them in the "[+-]HHMM" format that we typically use in
> commit headers, for example.
>
> This patch series fixes this bug by making our on-disk representation
> match the specification. This will of course make us reinterpret old
> reftables. But ultimately, the fallout caused by this change is somewhat
> limited as we only ever use reflog timezones for display purposes. So
> yes, we'll display a wrong timezone. But it's not used as part of any
> kind of computations.
>
> The series is built on top of v2.56.0.
>
> Changes in v2:
>   - Improve readability of one of the converted sites that now use
>     `minutes_to_tz()`.
>   - Improve test coverage.
>   - Link to v1: https://patch.msgid.link/20260929-pks-reftables-fix-timezone-format-v1-0-3df105a95ed1@pks.im
>

The range-diff looks in order. This version looks good to me!

[snip]

--000000000000568cc3065cc4c087
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 294f8ea314051ee0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xK002OFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOTM1Qy80aDltT3JYWWFrN2FZUlFIMURBVlBIeGo4SQpOTCtaTHlSS1E4
cGEwR1RSalVDamJMRjlMN1dSNjlPSlZMd3FxNW9KRXFGck1pUkJEUTByS0xUM05JUXMvNjVPCnZP
c2ZCZ2IyaFBXWEhBQXI1VXJNQ0JFaFViRld6OGR3TWxldmg3cHZqMHRDRlNiL3VuUHNYaExBMGRp
aVJCT0UKYVpxYkJZamp1elNTSlp5RWlwUUJFbU9wSlh3Ym4wVzNNUUtwMnFqREllaE1yeHdsUXo4
b2ZveWZMUE51eUpSbwpPTzhRYTl3YkF2T2M1Y2NXN1Z0VWRXVDErM1JBV09GeUNqSkNIOEdrdFZa
a1RhK3dqVnRHTlpRTTVkZklYanJzClNCWFYwZFBkQ3NjMjd3NU9hLytoQ1NmdWlxZEE0RnRDNElM
eE83OEUzODlIdGpIMmZkMVJrT2grQm90djlMUlgKcjBFOGMyRDd3QS9jTmxPZjNvazV0YjMzdXc5
Y1hqYk53L2t0cTJOaVRidlFhOGFlbXBzSlFIbmNsbUlmUjZCTwpMYjVvU1JWQUVXdlJaYkFxUndQ
eFhneEdDWmU1SEZrSTZReWNjU2JwZ3RhT29MSDVVWWlMMHBDb1BhcXVRcFY4Clo1VG50enh2cmt2
OVFDVHAzZk9TK3Jtb256bVFWbmg4QkJkZkRtST0KPVBzVU0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000568cc3065cc4c087--
