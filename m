Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD379321457
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702925; cv=pass; b=F72NhGIjhNYp2UEYYU/ycj/QCewww+1KuhVlKrC1z7dx+TJ/kWSBX4vDcNuc6dOov+bKH6SFQRMgghJRUCfCm9QSzHJZOo+PZTrKQ9rfToUc4BLt/VwodhZxYuqdRWa6EvnvsgmkhWxt71vDmImr9F0khMeoJj5ak56VoviK6eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702925; c=relaxed/simple;
	bh=gx/iWMm3jnnuJwkKyZVt+9FIyxKAoI1cuToOCDXPUWs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTcHeFwQ4XmSdFz48L3KilOIQViAOKaH5hIwF6GxDfFD60fyvWFtJW10e46svB5yhVKLIzfPLj0H8oAt05rvzspcv+e2ESmh2CGKxPtm2Pi3oLpCz/4Zc3OZE/1Q+pDvrYniN1JLhngwJlVsfGeieo0hQB2Xj4ylBl90nvh2Yt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QC+vyORk; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QC+vyORk"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-76b3036d2d4so435635137.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 03:21:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786702915; cv=none;
        d=google.com; s=arc-20260327;
        b=eNLKHmAU6Mv/6h8taxE6Kp92eUonYkROsMvn4/js7wJ6bGKmAZa1XUbYaV8EgS1bhG
         GEqv7as7yYALy0F+rXZAvrP4bh9KFAC2Gzo8PZ4tavQcan4be7zJHmOl3IrNIA+Vebm9
         Uq5cO3EmE/xetIsKXb4lXX/bqqibTGCb2BLHocoT0rJpFmnU84vL9d/Iaenz2HbLwF4S
         OvA8op86pmDHkdO7zGjYT46WZK5LgUKXJ3xhLEbTEj3m1ZwnXnamcQx2vm4kzqvzDt6b
         XhjooBCYWQuqyrKtKCIk0Lt2m00XQiNDAco2g8pzuVP+nbt7LO6omCavKewCL5Z/TaE9
         7d1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=cpuNaKo05siq9X9KzkpCtKDPehkQXR6UfwijAkxguZE=;
        fh=v/V76+LuF2RGp6DmUGFhUkrKk8VeK7EKgDv/LZJenA8=;
        b=rWowASx+ZzoHSHDIG/9K0LP17N8D706DC7HaBqzoHv1urjIahKOZKZzp9lCjQpG78v
         PzO+haW2maZfaNqlBImKqBoYDxGz748zdBCgc2qzNquBvhJU5jENZ6JPoJbugG92wVgH
         DvyyA/vRRqajr69sAvoeOPJkYUmWr0T4I+ZyIhoIfOY2UnqKFS91upaBXCqBdEKrBB1w
         oKowd06ZVun56T8BGvWEnOxj2iSgwzloe0s6QORyqIWpw8DK503Ld8ura5U/wji34Jlp
         UW6xEB4KiPF6vUYmfnZmlfzlmY4ylp0NZCqfYtNQcaiCcYfzHjXLFBGcyRCFuNjzqZ2s
         zUMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786702915; x=1787307715; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cpuNaKo05siq9X9KzkpCtKDPehkQXR6UfwijAkxguZE=;
        b=QC+vyORkfClyZvJI3zYHc9LRgXHLnBTZOUJYHgdCZ6S5bpQRjy5p7nYBkXlKO4u7TX
         A97GwZqBHfFT+6dBybRqLd58Cc0IN3ZWFbMTXAzMXFdfqHw9TiU/5XwaP5frqKF88Dge
         xpZ7LWWmkKPE9hEUINiTNq6pVRc6Ku4rqSFu9Rl5OHxuqF91wt68O7sk5mv1au+V0t1Y
         wWLAi/GDbjNhz5HgkCW/gnlxcQ990st8p01NgToebaBBrvL8JUanYyK8lRADtQu2mPW/
         +CdRydOHzAg3Nl0WcTLbmTbpPoX06l3Wu4D8aD7gPgqvdusRn2Bru2l8pXIaiCnybHjf
         bVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786702915; x=1787307715;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cpuNaKo05siq9X9KzkpCtKDPehkQXR6UfwijAkxguZE=;
        b=ikI6OYiipvSad19QQEaGBt4l9+3NJaVg3Q2P+PaAov5BjQ4M0hAe28MkkChS9eQAW7
         7UColUSCIZKXr4BUG2GfJYAiBJoQY3qKoO+tmjNQ7Z8cRUmQBqy2xQF/sdSKEnxDvXMO
         VsddNvFFqWh4sbpWQFBgGcvb28zcN9WyOaAsFBWF1Yv/rEzLZlz5EYYQDShWB3hNv6v+
         MkhzYH+Bh5RDXn1FNC8tyjKpp5pMxM1moxqtT61Vi6ycCn/XZB+BZF+KbVWmFlAf+db7
         10SddDS1r3NKZDnl68VRPceyeN2zMZBya4jZaKhRDU//tqvi84BO+jXqnabYd3P+T2vC
         5Lzw==
X-Gm-Message-State: AOJu0Yybz8DBoVbmBuJVVyglAO2RUfYY45f7zIGVB+QhnN4SQlbLCnOM
	rprGnGWesFNqE2Cr1/9r6Backpvu58r2huIpPfvu8+UrghC8XGgzAFDEmZkziemkxzaQ0WHESv5
	x+wRH3uCFMc6cPed/NFHaf97JpL2Wne8=
X-Gm-Gg: AR+sD12fjfY/gt+/qUhIEXoxKwkMSmVdIExWWw8ae0kMW5kC21Huac3JbcgxXWEfLcf
	wpITcu5DLShaaQrT0pppHwnq4KBUwsZie99lh4Atm5XisM772h6sEXwVa5TgtkzWF6BhmWy+BUp
	Z/rzBQriUyigitsKepOPLYIbtBLqhs7z+lbxKdmgBEZ7yIrwHD/BvYmSD2zTQVndtcRdm0hUbIv
	Z07By+lxrz1GnZMjF5K0nSL7UILxLOFxfI8awEGQvFRaGAk8jJS0moTsPr7Cl/UIm2JAYpV/Evq
	E/7L1bohUVrgTo8WKap5fhxjvb1gTBwwbYKRQAvZzfbdhqd4DN/XpTS7yD7LuoSUh+KFbSwKI4U
	zOshwSNbWL9Vw1XzKaWEC97/al9zatY9Nrg==
X-Received: by 2002:a67:e70d:0:b0:739:5cfb:50f4 with SMTP id
 ada2fe7eead31-76f2e0997b2mr935657137.11.1786702914859; Fri, 14 Aug 2026
 03:21:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Aug 2026 03:21:54 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Aug 2026 03:21:54 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <an3DzPKAFqygOS65@pks.im>
References: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
 <20260812-pks-odb-eagerly-prepare-alternates-v2-1-522b9a5bc1ea@pks.im>
 <CAOLa=ZTsumAT6U8+pJQmNjYL6Rt=JkvTJ0V7KQ7MvLYkThTFYA@mail.gmail.com> <an3DzPKAFqygOS65@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Aug 2026 03:21:54 -0700
X-Gm-Features: AcwNN1VEsKufbMWGqs_gj3wTWEdRZc2mkU7jCO1cuZTgNpuDnypzs5j0kjOAKLo
Message-ID: <CAOLa=ZQARq2eoVegh1BsnKrvd9MuraNFJ3htKDxQ5H25WJUs1w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] odb: decouple source path comparisons from `the_repository`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000008f4abb0658ff30ee"

--0000000000008f4abb0658ff30ee
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Aug 13, 2026 at 05:23:39AM -0700, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > diff --git a/odb.c b/odb.c
>> > index bd02d8ad54..51da386f22 100644
>> > --- a/odb.c
>> > +++ b/odb.c
>> > @@ -29,8 +28,32 @@
>> >  #include "trace2.h"
>> >  #include "write-or-die.h"
>> >
>> > -KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
>> > -	struct odb_source *, 1, fspathhash, fspatheq)
>> > +static int odb_source_paths_cmp(struct object_database *o,
>> > +				const char *a, const char *b)
>> > +{
>> > +	if (o->source_paths_icase < 0) {
>> > +		int icase = 0;
>> > +		repo_config_get_bool(o->repo, "core.ignorecase", &icase);
>> > +		o->source_paths_icase = icase;
>> > +	}
>> > +
>>
>> Nit: couldn't this be simplified to
>>
>> if (o->source_paths_icase < 0)
>>    repo_config_get_bool(o->repo, "core.ignorecase", &o->source_paths_icase);
>
> Not quite, as that wouldn't handle the case where the configuration
> isn't set. So we'd retain it as -1 and do the config lookup every single
> time.
>
> We could rewrite like this:
>
> 	if (o->source_paths_icase < 0 &&
> 	    repo_config_get_bool(o->repo, "core.ignorecase", &icase))
> 		o->source_paths_icase = 0;
>
> But I'd argue that this is harder to read.
>
> Patrick

Ooh, yes, makes sense. It's better as is :)

--0000000000008f4abb0658ff30ee
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d7e28f37dc9899e0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wKzdFQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMmRwQy85THd0Zi9DT0xTQ2RvSkZBSzVOYkVWWTFYKwpERWpmMjVJTDN0
QkhZY0gwWHJGdTBMQ2lYdDB0U0ZOS0VraEpaMEhWSytTeENBYUZhWDVQTTZoVnE1T0hHbytwCmFz
Tit5cHpPTHFkalppSW9MZWpoYjJZaTN5N2NpWjdsQk5YcXdRNTk5L2lJWHZWeUZzSU13S2gyRVJv
eVFsTFMKd25PYnBWNGVYZlJ3QTMvNTZiT0EzMHNmKzVJandDcG9rOE9FaG0vbGNxZFdlK2RKbzJN
QlFQd3o3TTU0Y2FoZwpLcXlBRVlnYlowTk9uakJ0SVlOT1Q3aWlqSTBsUDFaRDNqNEswWlNqaldU
TnlUWTV1U0VhU1RZRkVtOHJVelN5CmJlTDczTjFBYjc2ZzhjR0MxYzh6MGhWSGV0ejQyQllWS0Zx
Ynd3L3dFWWJoZ3UyT3V6RjJnNGRNSmJGbklEN3kKc0s5aCtOdndmREF4NXFYM3k1ME0vQTF6cklZ
R1FNSFY4NXhsOWdjMjRyemF6VmF5OCtTL3V1emV5SDBqWVB4UAoycWVpSFB4SG9sZVhWaU40VUNR
bnJqVGdWMzl1QnAwL1VIWjk0NVk0bTRZQmNhZS9IMk4xTVdRUnZ3S2dEazBFCldlUVdwN0VvNmFF
cys3a3V0TUROSWZLZG0ranVBWnRGSExwSnB1ND0KPVpyK0UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008f4abb0658ff30ee--
