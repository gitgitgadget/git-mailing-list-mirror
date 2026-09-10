Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5346833F59A
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057976; cv=pass; b=VUhRRurxscEahWFxeLcDyplYYa7pyYUIXuQKx71r8nCx3MbWWxZ7SXutShG/59m0WoUWlC2jxpaWP0y5ueGvTo85f5LUpIMcSSe4q210O1qcerG7H9aeG+eL4+CE17PQ/I3ObbWDYjA1MO/bMat8Bl91u5jnCZnLXjekK3jppnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057976; c=relaxed/simple;
	bh=ITs7mfAiQa9kmuJh+U9H+nuSULJjKgLxsOBZXRY0ut0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzV2t8lN1LGW/QRfY2p3Hk83AAaweEGMZrgryxVxbE2zRwmP6GsbgH34Ay3UcSlrsfrSEgAJdCpcJ1tz+CG7lVE3xC7oujO4Cg6sRtjmKL6u0UALJuv1FAe7sx2x9LBMvH+p0wp5XGLz3dctD2k6aKi5frBIa8+DETceN7wFuOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVmzWWDn; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVmzWWDn"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-791b0163eb3so399024137.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 09:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789057974; cv=none;
        d=google.com; s=arc-20260327;
        b=cIRxqAKgg/7fTLzYG7NOgLX65VYbe5KHKWCrZ2d4qK72QpVu4xP7fvtqGLQI/FpX0V
         lacNGGxTebjQCZO4wcnuWJbJNS+Xt5RChr7CoHfmzyU5MFC7uNcCqaftZlsETBt7yppO
         rw1omWC8JHd9h80CN4wv5ZbDvSTjUfwlZ8PtrsqRsfVyCgIfFXTK2bh+CA5+5Lvxg7OU
         p5ru7yvUXmIEOTGCPQBWvydACVA+M3h60lFEJcEVFLlyphaslTIokI1sKUlMQz8BL6Hs
         jrVbFvY2StuMrd7esmjdyov8Z8FHBibwHzkvIiNaaYUy3G26H5jGCjq4v7gNopQ9Sxb3
         V+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=6e2DwZroSFkFOTWkjvm+fXTfGYpMdTVt6s99VHKbjdQ=;
        fh=D4uDqIpMAU76UF3y7kLhifPMaIKyWsi4/hRzYZ8Ccvc=;
        b=Lgd5x2mZbN2dKLn3ROrRTfD3JCkKW5Hxg0OU04z3nhKkY98BaHwVnaYfXXP/4apbw9
         YQe/g8H/MFqqUOfnq7YUKPPUKJwwBg5VlaB9nLfrhqJ8mXZqFBloZ/XyZi1XTh1YEWX8
         DMSWLOy97n9oGBOPd0Xi4m9QJ1av8c8GU8GFqNj5jL3Pe8HmDeCs5d+tryeEgVsTCe0Y
         r8QLV3snG5yuXsng76u7DAsnMpj/kEfL9c2LLlRcu0R2YZdY0qPiEjgspl+jaqUo2MPf
         xDt0fhHrIC7xfimK2kbz+cY1WK330Z/SA5vtjFMpi6EtH+k9sMUo+vo8nruYmLI34Fus
         cWhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789057974; x=1789662774; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6e2DwZroSFkFOTWkjvm+fXTfGYpMdTVt6s99VHKbjdQ=;
        b=MVmzWWDnk0ZQN7I1mBp19AurNXBEBE6AYk4oCv/xbVgjsCZHoZ+UbOHgVdaiCUDPT/
         yE3Ho5i5mE089os2E6GTKoiPeAM5/UvjyoTLsOpEivgzXIhP5GJ5xdMNkmXXQvdjl+hd
         7JBhYa6JSXojy2PTdizDCPWuBfXoSXuL9q4Q7ABviAPJ6f5S8qz5umx06TJtzNYjL74U
         aXqKeu5S/YPn6jEd0oIzpn/su+3eHWJbMaedbyjo6Z25VQWX9gBTpYI7WW1cK3LrMBdB
         oiXr0iE8mvmlZbbKWpplqFw/N1qnNp0KOK2d9zEl4KDoQDbGE4PA+RB4bF5olZXLd9gG
         tW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057974; x=1789662774;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6e2DwZroSFkFOTWkjvm+fXTfGYpMdTVt6s99VHKbjdQ=;
        b=Yl/W7vmyCbDgyzhJ3+1dKwJpa1gjQuZPLbyCSwRBGdSu/dJaCpWH3h+ZQ+iuBuIL9Y
         P5TpHSj3IalkBJoWb5XfyAUrS9RN1fc4mkYDl0AfWiRI45teb9f6NLi/x1yHfVVgRGTD
         4tujOyJmaa3mybove0JOxFo4sdv/UzL763lS8JHoGScShCd7l6URWsxE1ywtpfjxG7rl
         k+RiudInYSJnQlHbEudgwiM7n5nhtCvfqF5AEh/123ebdFFC0acK/ncykFvukYZnto0C
         IRxEh8natQZO6jOwXHhlJ4Ny87t/0XSDb1GvWnNSkl15n55650ukd3Cfi3CobiyMs25E
         SP/A==
X-Gm-Message-State: AFuF++lxWc/xZcv4C7+Fub2vdGSlU9qluWvpsBelaCcJHijuTvIgtBGQ
	Cm36lZEvBq61MuUMnMpnp230I8dBk8zvnBJ/pF4COrUmadw7MmAxq5Cvfk++lj6mnsMAMZ2cT/O
	Vk+ECg38LrmR8v6wQ8Kq+g2dVU7dkYU4=
X-Gm-Gg: AYBFou21HFrakfID8wzpood1S+2+UKllpbby1FcCkhTibxnkUgZOHWt7K4Rep3gzkX4
	SfvGxjpzmpxpFJqNGHq8MAdDInuqW2WiilwZHhixWeoOIMnpCtkMGqGyTkDNTVSBtWxXdx4R0mM
	xrEErSQQ8MKYOml5rwT/StZrBwwHkFprZlsVlveIMheJtQ5WDrBLchMMs9Qai1cLtRYkxMvb4H0
	76yVO3EwXidkeYSP84D0X0cyGsRgYu0TENHdDf5CqvIynhcya6Ise+NUdKQjoJsalRHn1Frz/KB
	s/6ONAoxcqVuMjmmdPpNknQLMmU6zOqo8LJnrJHSCCqWET0InBhZ/1cDbMRxq+/oQbMX+GlxnWt
	qcCQ05+ECsNfIK+ZHq1cac2op5wkbhT37UYa79dLF1AxR
X-Received: by 2002:a05:6102:1499:b0:790:c8c6:c0bd with SMTP id
 ada2fe7eead31-790c8c6c0eamr7128600137.4.1789057973806; Thu, 10 Sep 2026
 09:32:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 09:32:52 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 09:32:52 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqjyotokyg.fsf@gitster.g>
References: <20260909-758-introduce-hook-v9-0-3043d417e0ee@gmail.com>
 <20260909-758-introduce-hook-v9-4-3043d417e0ee@gmail.com> <xmqqjyotokyg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 09:32:52 -0700
X-Gm-Features: AcwNN1Vtdmt3xDGZNsr0IZ_vLoRw0IyQiHssCXeGzkXL0csQrHJ9vs9-9SJ6avg
Message-ID: <CAOLa=ZROrWmr=2O+NrkNsJU8Zyz5rGbH30SRazjv0kzDF1RtTA@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] hook: introduce the receive-report hook
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com, 
	kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: multipart/mixed; boundary="000000000000038847065b23855f"

--000000000000038847065b23855f
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +static void override_cmds_error(struct command *commands, const char *err)
>> +{
>> +	for (struct command *cmd = commands; cmd; cmd = cmd->next)
>> +		cmd->error_string = err;
>> +}
>
> Doesn't this leak existing cmd->error_string if it is owned?  In
> other words, something like
>
> 	for (struct command *cmd = commands; cmd; cmd = cmd->next) {
> 		if (cmd->error_string_owned)
> 			FREE_AND_NULL(cmd->error_string_owned);
>                 cmd->error_string = err;
> 	}
>
> is in order, perhaps?

You're right, I thought of writing a test for this, my idea was to
create a test where we override a pre-allocated string. But, unless we
always do `cmd->error_string = cmd->error_string_owned = <string>`,
`cmd->error_string_owned` can end up pointing to something allocated,
while `cmd->error_string` is replaced. Eventually we'll call
`free(cmd->error_string_owned)`. So the memory leak is never realized.

Either ways, I'll also add a test which triggers this path.

--000000000000038847065b23855f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7d21dadb17114531_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xaTI3TVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN0c2Qy85ckJ3UVQvUHA2Y29NZ01uQ2NDbnIvWWtXWQoxajh5SzBXSVRu
UHJ1MzdoS0tGcFlyU3BNdlpsMzVsSVV6dkRORmhYeGcwWTR1V2ZpeDhkd1pPNHpxMHg5UW1WCnNS
UmUveWpkaXY2ZlpJN2Y3ZWRnRnFHSHZPUndxUTZ4NVAzcmpQcE5KWmNmME5QU3RrSmJaeXN5TUsz
cCtUcXgKNDZqWDBkcEJRcTJ3M3hJTmtoR3ppL0R4VEZUYUFQMkRaaUVsMjV4VkxwNW95RGZzM01J
YjhoVzk1VXl2ZTl6cgptMTk2NzJrMHBQUUk5bWZ4eUtMU0IrWkVKQ0xJbVErbnBqMGVxcWcrdyti
dVZsamNHWXF1WGthTkRXcTBMWTd4ClpXeDBWUVBEaGNqL2cyVlJGWDlGODhPRUtCSGlBdUJNTFdZ
NlIzbXhUMy9jZG5oYWcyWUwrZXVYL01GdEtlTGEKNGR3cjEyWE5GcFQxeHlENFowWTk0SktDdTZU
RC9WQkphNk5xY0dnSXUyN3UzZEh4QmVVVUtBVnBmaFNmVWRGNwplMGtadHZaZEluZTFXN0Q3NnlQ
M29jUXdiMEladTZNT3hmZDZ6aEF0QUw0dFlINkpjTGY4U2x2T2poSnVhNTQ4CjRibm1GVlRHeXAw
R09Eb0xKeitNaDM3aVRoSzZyNWI0VG0raU9sYz0KPU5NaTcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000038847065b23855f--
