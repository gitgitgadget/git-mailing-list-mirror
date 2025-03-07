Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD9721A43C
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354119; cv=none; b=O3RggQ4FzgTwsiBYdfGgy9OuRbrPrsniYmuVr8/bIn4memVKCbLb7H9nexlRmdSSPERE0hPZvHsnv99e0NFVLYlnoOZzk/y8x0M+0+6KQRdQSF2y9/ete3pRQLKc4ndKgSI+m0FH4jE9OtUS2p5u59FVBCParR7TYZwYdGf1Mp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354119; c=relaxed/simple;
	bh=2NSVRi45Py6C9hgArDG62/zk3vh/YOC2xhVdLgrcVGg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CI0X+hjLMm4s2/HsT/jxuaTsrZ7pDmY0BvTdoat5TnPJrW8z78Z5o2e8UB6INqXvkI6FoksBF4ruPF6eVSJ0t8sUZEwf7ORoKuW8rGWotLQhkZk9CCemXLlmKSDg3FIGJ3hBFMSeWZ14JYK2nHPk1FsW/8st9oj/SrvvlGbZKHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbp4fd9x; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbp4fd9x"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86d3805a551so703128241.3
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 05:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741354116; x=1741958916; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7mtXK3nP324t+GHmtYvYFoIF6Jb2+2C7Zcsuc0gV+YA=;
        b=fbp4fd9xsFf8xPhabypFkGkGzNBg8AyDBRnBPZV6ewGPTRqw3fWrk/B48D529Qy/OJ
         xsZ4Sz6PNYtlNL0rh8NBF6XAg36vD9/f1LfsvaYg5TZt3k7zeK/lH09GqXBoCU/3S5/R
         3YSgdfE/xusWkM096wrO6T2VZMelYxIBoEKe0lhxL616mAPTciyzSwLwAssu+PFnlIZg
         amxSB2mJsWx4QVi1/AZfkARYJXCuxHWY4lWbxY/yGBEBmjZ181pJrXXNDl7QGQe325II
         BlFnXg0YqNry/HdR2q/Qc/Mgi90z2zC6lQYdnSj8CXfEHLDKQx2oGMS5OQcwuTIXx6zQ
         +k2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741354116; x=1741958916;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7mtXK3nP324t+GHmtYvYFoIF6Jb2+2C7Zcsuc0gV+YA=;
        b=cSa3Se47MrS0cIB0ynpfrI5FndAskvgVPYvy/hfQ0Kpdyva1lw9PEOlcdgIpZOND6B
         2zYtwo7K7WG3yTjpJtirLN9mZIedQG7cIvU4HM0UKmdJUwgwIgQtM/2dP0S43Sm4pE3M
         pNMGDtmNB+6N9/0wM9W3HXZRa0SGd/W0Ik8dnqOocCgpoem6C2bbCvvKOjwieMTtVuID
         h4j8mYCMNONb9FqCXUpBx7ZYpx5s07JP+G73PNcV5FfaQNB1Bp7YxgdtqZU0NylF2KS6
         tJsszOk3VKeLVy9qCdLcQcq0m94Y3mjyZTZEoSMfYgyxJiD4YCeqiNXszhV95D18VFW+
         ltiQ==
X-Gm-Message-State: AOJu0YxqfIcuaJQ2tCtjhGI2NWiGVenXBrMcg0M6ar8mqOHiSi8i5poB
	gkwoyTyE83BjSZwu6WL2Gu9IMjrhDWR9F2naAVAqzriVtYSvYDH6vruPJj72cvIsEwVjIXvAIjh
	rW3XoIqTCLBEgbJTNh3XZ0HcdUXGSg/Sy
X-Gm-Gg: ASbGncs/GUR+KooHqXzdZc6XBa5YMgFvFWHiXyaqzPAbyOKdavCWeb6cyq99ycj5kRb
	xgq0hDKUdBfZhTEjniaS6bM/t43dFdyCJ1Wp2FtLn9SSR5Ax9kKaXST4vxFOvUkWBKIakDlte8l
	IQhZ8ImxJkCJjrqjO0RoHrL1DIrGo=
X-Google-Smtp-Source: AGHT+IHBcRC86vYyGSzIm4smcwxrSQlW5q5Ax11gn83gLSy2FqJO9l5Zgxqs+WT4KRdCO2HfR1N2zNLSnXijdvszS8Y=
X-Received: by 2002:a05:6102:3fa7:b0:4bb:9b46:3f8a with SMTP id
 ada2fe7eead31-4c30a5016d4mr2257485137.2.1741354116668; Fri, 07 Mar 2025
 05:28:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Mar 2025 05:28:35 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z8rtuZysCngh5FQd@pks.im>
References: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
 <20250307-493-add-command-to-purge-reflog-entries-v1-2-84ab8529cf9e@gmail.com>
 <Z8rdg90kxmKHHbyh@pks.im> <CAOLa=ZSMLwt53TwziCe71UbKWgRyNgg5VvUwTUUDkN60ymmFPA@mail.gmail.com>
 <Z8rtuZysCngh5FQd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 7 Mar 2025 05:28:35 -0800
X-Gm-Features: AQ5f1JrZKz2xqy-VKQpAIwIAT5Up_yXcNQdLdulJdadHPzIgLhVDl8nQ0L5SEaw
Message-ID: <CAOLa=ZT4+LOrjnKVJ=8DZsxd=ij7UhO32iLotyj3_7ko+A0osw@mail.gmail.com>
Subject: Re: [PATCH 2/2] reflog: implement subcommand to drop reflogs
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008d8826062fc099fd"

--0000000000008d8826062fc099fd
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Mar 07, 2025 at 06:53:31AM -0600, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > On Fri, Mar 07, 2025 at 12:17:26PM +0100, Karthik Nayak wrote:
>> >> @@ -447,10 +456,56 @@ static int cmd_reflog_exists(int argc, const char **argv, const char *prefix,
>> >>  				   refname);
>> >>  }
>> >>
>> >> +static int cmd_reflog_drop(int argc, const char **argv, const char *prefix,
>> >> +			   struct repository *repo)
>> >> +{
>> >> +	int i, ret, do_all;
>> >> +	const struct option options[] = {
>> >> +		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all references")),
>> >> +		OPT_END()
>> >> +	};
>> >> +
>> >> +	do_all = ret = 0;
>> >
>> > Can't we initiailize the variables directly when declaring them?
>> >
>>
>> We can, let me fix it! I'll also move the initialization of 'i' down to
>> the loop while we're here.
>
> You can also avoid declaring `i` here at all and just declare it inside
> the loop.
>
> Patrick

Yup, this is what I was trying to convey too :)

--0000000000008d8826062fc099fd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1754ba048b3dabb1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mSzlJSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMmRWREFDYTVnQVBrYmRQbk9FTWEzdG91dXhDRWl4cworNVRPdkhqck1J
aGNiMkVaUlZFVDcrYURjblVSU011ZXdxajY5MUxkOUxEd0xZNzYwbGZPU01BS0ZZeTB4L3dLClBi
TzVGdjhJL216SGNDNnphblNFS29rRzZvZVplWjA4Y1dtTmF1REQ4UFhwbGs1N1d2dklVa05zSVFU
Z0lNZmEKUmZVNUJtbEt0T0l6QmdEZjdtR3dlR3JpRFEzM3ZWOFJIYWpva0k0VXRhd0lGbDlROTBr
d05Rai9zTWZNcllSTAoxYUsvSjdkUEY2VnBjNVVDVnlKNFdIQU9oNm5tbiswUDVONFc0SnFFZ2Vq
NnRVeXcvc3IwRmZ2QnBLMjlCWWZPCnljSzBQMmdZSHdVRHVnTDU0c1NjTkI0RHJxVXIrQkVCQURx
UzMyNUl4WmZDdTgzdEtQREhTTnpzelhZSFJXTVYKQ2czL0hWTkxpYzdTL21OZDRUNEhYRzI5WmN5
c0NKcW1wQVlhb3NpODBXZVdWc0ZWM0RqTmhTaUVJR2RVTWxndwppL0VWMVNPWS85SzRDbzk2OFJr
bTFJS3pUVlYzd2Vsc1Z4RTFSeXQraEswV3VrbzBFTTRrMkxvM0p4SXRJQlpVCjNaY1F4VGZuNDhh
MFZMR3U2RDNhcWNRUms1aTUxSTVxcnhsOWh3dz0KPS96Rm0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008d8826062fc099fd--
