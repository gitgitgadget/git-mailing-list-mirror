Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD923213240
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738836835; cv=none; b=saWH4xyjsvZ1m+yUxHsdx9vATx1FRMm0AJsE5T0EKIkdlzV8UhIqWVZmeaiHFVxa1X2Ziie6xt4/8UfvUvnuovfY5Atcz/BJ4N1VI0IgCj4mZXRty3+8m/h9icRk6hF99LhHajL73Ebb01ztqUkTfgdeoHZR8GnIzv5PAuS/KWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738836835; c=relaxed/simple;
	bh=XBhjdwVNjyeVE1FJbDfGxw3L6d4jfYOT+ZYNRoMJ6XM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdGD0ixI2iRqFS7Yxd7b3lvqG6N6fWglXudkhNHMi08Gs1KKdiae4eDktT95H1ZCVsQtavsFwDniMghmMi3XhurcmOmXuyxjwkEewQoP45gH1r1kA+kPS90QEyxoISY2G0Bea38uxCSoyfX0rNH8cXeWS5cNO6WjJSj0U7kVSd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+8O42GS; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+8O42GS"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f9c3ef6849so1269462a91.3
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 02:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738836833; x=1739441633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sAf4nXpa4fdBBck3p9Xxb6RSUnNyuRD7yZvSkAL1Yto=;
        b=U+8O42GSMFAJKJEXjV1YW2lNHMaBGLJl4MPdSFH5Cd9ITT54heddQWYaoL10qF8gsh
         VtC9gZVLTTpzmDXBaRG2GgscDMLzbXLy1MaCpw42zM4wGkq7DAeFuPzEiocCK+U62Ypx
         IbPM8aLYtxBdgEO5FaW3n61bQ5SrOwJSUB3re5t3JrmuIkfBxkkmdH0VuV8DtxLj6IE0
         49ub8qGE19n8JRNk0egXS9ibI2jyh4A8y8MawgJTKr1FlRkoV1Xem6OCzXPYl2ePuQVu
         Cz4z3JXPjnmXbbtr1JYM0doxQp8doL3QzaIQ+BHZcSSUHGMP0jlvwaQ7vA5m749BZZfc
         WJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738836833; x=1739441633;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sAf4nXpa4fdBBck3p9Xxb6RSUnNyuRD7yZvSkAL1Yto=;
        b=K9EGxmdwEgRMUkxxfxquAWR3dlbPnBCa6RiE1XBGDCbt9RpjTgFtvmQ4y+579sXjzS
         p/XX76fpVfN7lN6ZhcVG7sd8n0gtlZ2Eb3GyokNsevDsSyqtQiZBZJwIFewoOBeG6SR3
         E35unb3hhZIdEzi/hgTeMDaV0+W3l5p7yy2I3R8a3dbsiIyv2upMcA2SnJuwLG63fjko
         Di9Ml0Zs74UqazYVtQcPDp0+bZGUxZtFzIduWCNX+TxJHm36wnqbNe42hTYr+elrVZWi
         8pQ6/24UzzEzjrdskvtVa0JVP6MDGjidBHn0I2vIrk2aodSga5BrEMAYY3e0QmSIkVGC
         bRAA==
X-Gm-Message-State: AOJu0YwxH5ssWtfCkjPlJnsw+R8iFZO1z7i1NBRHIwjKAhnFnJirzaNR
	TAlz0vDqVo011RVy6iqGhlOLLDUZSSOxvfCkmgwuVLLZ2ioLpVu/vQrfO2xgrEQeJHiNEe1agOn
	MFoZpSVw42DiETHN2AZrdh0wZtFc=
X-Gm-Gg: ASbGncs9g2SeNW1hw3fgQiBzdDz1Zow4BGm/UmmrKlc9o8Xe0KqcXgk3dEgoM3TlFD6
	KgSfJYwS3yIOZ3PsktQPTA45826xxgq4jLMx7ZttCvK95gmT94NEpXbAzz97QGdO2o8HAwkQamA
	JPxsgsunDdMhtcDk2X/P0IthyFTHF5ow==
X-Google-Smtp-Source: AGHT+IHLz+16OOIPeC0J1DoIINT6SFF5kQqtVpZt1d8EcP2ashLRorrb/SymYwNWJZx3sAczAtik8Uqp5g3wKvtuz+4=
X-Received: by 2002:a17:90b:2782:b0:2ee:b26c:10a0 with SMTP id
 98e67ed59e1d1-2f9e0810f41mr10453797a91.24.1738836832962; Thu, 06 Feb 2025
 02:13:52 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Feb 2025 02:13:50 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAPhwyn32CmjtKu5ivxS9=AJ-h+5GskDUp=rUGvofv-aWLhH8Ng@mail.gmail.com>
References: <20250201064202.76116-1-meetsoni3017@gmail.com>
 <20250204040558.34766-1-meetsoni3017@gmail.com> <20250204040558.34766-2-meetsoni3017@gmail.com>
 <CAOLa=ZShqCkyabVK2PU-XXpx9QS3_W=9QMH6ioJB=t8Ec2NYqg@mail.gmail.com> <CAPhwyn32CmjtKu5ivxS9=AJ-h+5GskDUp=rUGvofv-aWLhH8Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Feb 2025 02:13:50 -0800
X-Gm-Features: AWEUYZk22Had_3_PVI1vm-mPTw4lUNWh6_JTbh44b5POwEbxJfOVI4-UlmDIP5g
Message-ID: <CAOLa=ZQmALUCY1CiJZG-S3fgRvD_wj8ZwSj5dV-9X=f5NpLVfw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v4 1/5] remote: rename function omit_name_by_refspec
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shubham.kanodia10@gmail.com, 
	Jacob Keller <jacob.e.keller@intel.com>, Junio C Hamano <gitster@pobox.com>, 
	Pavel Rappo <pavel.rappo@gmail.com>, Jacob Keller <jacob.keller@gmail.com>, 
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, Matthew Rogers <mattr94@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000c06172062d767f16"

--000000000000c06172062d767f16
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Meet Soni <meetsoni3017@gmail.com> writes:

> On Tue, 4 Feb 2025 at 14:30, Karthik Nayak <karthik.188@gmail.com> wrote:
>>
>> Meet Soni <meetsoni3017@gmail.com> writes:
>>
>> > diff --git a/remote.h b/remote.h
>> > index bda10dd5c8..66ee53411d 100644
>> > --- a/remote.h
>> > +++ b/remote.h
>> > @@ -261,11 +261,7 @@ int resolve_remote_symref(struct ref *ref, struct=
 ref *list);
>> >   */
>> >  struct ref *ref_remove_duplicates(struct ref *ref_map);
>> >
>> > -/*
>> > - * Check whether a name matches any negative refspec in rs. Returns 1=
 if the
>> > - * name matches at least one negative refspec, and 0 otherwise.
>> > - */
>> > -int omit_name_by_refspec(const char *name, struct refspec *rs);
>> > +int refname_matches_negative_refspec_item(const char *refname, struct=
 refspec *rs);
>> >
>>
>> Nit: The first sentence is now duplicated by the function name as
>> mentioned in the commit message. But aren't we loosing information by
>> removing the second sentence?
>>
> Correct. I considered keeping the second sentence for clarity, but that o=
ther
> function signatures in the codebase don=E2=80=99t include comments solely=
 describing
> return values. To maintain consistency with the existing style, I
> opted to remove
> it. Let me know if you think an alternative approach would be better!

I think its okay as-is for now :)

>> >  /*
>> >   * Remove all entries in the input list which match any negative refs=
pec in
>> > --
>> > 2.34.1

--000000000000c06172062d767f16
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a3109dc39dea63f3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1la2kxc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNXdLREFDZWF3ZGc4MXNjWWVhQ1dSQ2NQV1d5OG9XNgpIdGE2eG5IMkV6
TXFqam9lVnpjOElRSXMzQ3dycEJFQlNyR3U3amVDNmRneEUxNHI4YVcwZVlrVy8rcXNLc1VNCk5Y
blNsV0FDcDhQeGNsRjAzRy9vWXB0dkdJNDJ1QjQzZWl4R0F2czhWQzI4b2h2cW5RazJyblo3eUMz
Tm1sUkMKWXVOR3lsN2RuenZCc0R1YnZiQVl4amNPdmlDVFJSR0wyRXp6MFp1VGVSck5kUERMb08v
ejVMT0pRYVlhZ0RMTQpZK05KOGU5T1d5OVNnV0Y5MmY1cG1nNTBrQ25TOW9HSE9WckJMQkMvM1oy
RjREbFkyRnZTV05TOFNTSjBhOS9YCk5YeXVLczVkWi80c3BCdnBWYUczUzF1R1BDbkVTQkIyWG00
bEFXenNyQnRtdGJqU2c0aGhyQnBxa2RxWmNZWGQKendaUWs5NVlmRnc1eDFhYXBpQ1cwTGMwNEpO
cnl4QkluSUpuV1lWcGUyRE0yS3JOVjhvaWVpZGs1a2V1SlI3ZgpUTi9PaW8ySDV0RDFzOEluMFVC
OFluV1RFUjgyeDZTU3JCcjZtUmhXR3pJcjF0ZzBLWjZiTS80YnlkMjhKSG0rCktSekpaQU1lMjRU
UXBDdE80UXFmUWRUaWZwWDJyZlJaSW5IOVNyOD0KPVBoVHIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c06172062d767f16--
