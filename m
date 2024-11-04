Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182B81ADFE2
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730713174; cv=none; b=vGXhEi16H0N5EZ9UR34yj9vaKeCsb4E9uoLxOjPJ4DHs2/HdmWG15/ORHUt1L6TqAOsqlJZp0Swoklpc+YnuBxlsBr4iqzHRu7qYOGuOErMBl33uRQepTWEDCckLkg02aTipX7z+xMecIPNfdcjnYU7WIv5tv6dzD0Tw8uA0Ig4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730713174; c=relaxed/simple;
	bh=BOmOWELgcOLufSU5nySZHWXcfsJL7xIBtpsSTmUjp7w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AzmxYEs7H8bT6rnfKS08QKI/R/qloS/3ClTlnFUvKXH+IJ8C1vpRxf4udPrgKDh6rkp0zRRLwj0FpTUXQzDwn0Ute8mYxYCbmqiHdhvSz7cBVhcjWF9d6h3m1FNX1RCiTH74ADiBmFYwkQ8CVMDWhd5Qp+85NER7NpI/72QNN7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4QZ0C13; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4QZ0C13"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-84fc0212a60so1072647241.2
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 01:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730713172; x=1731317972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DZXyX4JBlXXe4WE/AUPG3lVY8M9EXWsUCxsowEteRuk=;
        b=a4QZ0C136znWs0CUxW7enuOFjyNEeOMmsPboZrti+Qp/0CcDOpzIz3jlfO3ItRThon
         oah+Z9Sn8CTdBYnaafBCJoY+JaDKymIude1PWwsrKrQELXMPjAFH9a52JRaU4pTxOEA1
         8YFHIdZ0vbL3shMlY9T9Nf7Qy9/yXFpHedUSA1tda0zZfmS/JJDbrsQhbak/kVV74/Am
         JcJM8murEAtDCTfWhp1/f90hZaZLPsoefPRxBvRvdJF3artPYoNLMK5uFAsx36ARRQUJ
         99im46++eY8qNc5jiRedPPEBvht1QZLGDz66CW2FcdLHGaw8ecLhBD9xfdCgFdEdsOaQ
         8tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730713172; x=1731317972;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZXyX4JBlXXe4WE/AUPG3lVY8M9EXWsUCxsowEteRuk=;
        b=TEuOp2nXSaKKynwwZmxLvFzIPvN/nwtI1HwqkpMnoLi5kqjZ5Mj0Wuv7+PtSyY6pRK
         C+EgEVtO4rya0+pqPnwBLVde10mmU8zV9WNKrfaRP+pVu6MoWPXo9iU4mAXHshbcWkvy
         jqituOB/9UtX7VCLhVybcS3uWbpN1yDaEFOpfAX5SNXaf2on4AVPNlfKwq3HF3r/++Zp
         V6u0OkPCTzW+wVDx5bgmdfVaaI4ka85rHDJk7jn0OvfGfN7sCcyxkK1ZA13CH75qg0kJ
         xGymd0KK+ZWgqVPCDleHwpRk7eNVU7F/iaL01Xbzn0aHoVpoZtk9r0/CiEBu/UYQE6UT
         KidA==
X-Forwarded-Encrypted: i=1; AJvYcCXGi4n4SSSmuC8Sbm92q7D1ngkKx+5/B9KQ/O+uYoLHVKmfovbiy1wVKnPPqUijmxYrr3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxheicK2JMfV30yn3UASfOb3ofgoouIhjGndDq+rNDALdPb+I0n
	+PYRzZMLSn+bgfPaX8SP3dwfTPXNZdU22i2irE1gTfNAFlt1m54u0vU7mVMajO5C2A0pK8/ErUK
	JZOBEd7FoXfkK4V9hTMtIjZa3mr0=
X-Google-Smtp-Source: AGHT+IH1Hoo+TCNxu10XTaNTekcRvgGaOVeHxeWZjjfKO7L/mpsmthE2V0TvAFe3n1NmP59wsnLpP+OuRXFMJ1Pc3fY=
X-Received: by 2002:a05:6102:290b:b0:4a5:b712:2c94 with SMTP id
 ada2fe7eead31-4a95430e304mr13855482137.14.1730713171965; Mon, 04 Nov 2024
 01:39:31 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 4 Nov 2024 01:39:31 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241101172939.GA2337295@coredump.intra.peff.net>
References: <cover.1729504640.git.karthik.188@gmail.com> <cover.1730366765.git.karthik.188@gmail.com>
 <ZyPjJKYZzeFGLxin@nand.local> <ZyTnhrBLuvesK1yB@nand.local>
 <CAOLa=ZTp=QqD0P2zhGunrOfmAebwvLJ20bQq9Tog3eLaO9pwoA@mail.gmail.com> <20241101172939.GA2337295@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 4 Nov 2024 01:39:31 -0800
Message-ID: <CAOLa=ZT8dvpvJ75Oe_PV4_osi7rw3EJnH2SSzUVame-eQvOruA@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] packfile: avoid using the 'the_repository' global variable
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d2df170626130fff"

--000000000000d2df170626130fff
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Fri, Nov 01, 2024 at 11:07:48AM -0500, karthik nayak wrote:
>
>> Thanks for letting me know, I think the fix is simply
>>
>> diff --git a/packfile.c b/packfile.c
>> index f626d38071..737cd60377 100644
>> --- a/packfile.c
>> +++ b/packfile.c
>> @@ -27,8 +27,8 @@
>>  #include "pack-objects.h"
>>
>>  struct packfile_config {
>> -	unsigned long packed_git_window_size;
>> -	unsigned long packed_git_limit;
>> +	unsigned long long packed_git_window_size;
>> +	unsigned long long packed_git_limit;
>>  };
>>
>>  #define PACKFILE_CONFIG_INIT \
>
> Wait, why did these change from "size_t" to "unsigned long" in your
> series in the first place? If the goal is moving them into a struct,
> they should otherwise retain the same types, no?
>
> Two asides, one for your series and one #leftoverbits:
>
>   1. Since these are now fields of packfile_config, do they need the
>      long packed_git_ prefix anymore? Just window_size and limit would
>      be nicer, I'd think.
>

Moving them to repo_settings means we'd have to keep the long names,
otherwise, I agree the shorter names would be better.

>   2. I can imagine you might have used "unsigned long" because they are
>      parsed with git_config_ulong(). That is OK on Linux, where size_t
>      and "unsigned long" are the same size (either 32- or 64-bits). But
>      on Windows I think it means that you cannot configure a window
>      larger than 4GB on a 64-bit system. Or ironically you cannot set a
>      total limit larger than 4GB, even though the default is 32TB. ;)

Yup that's the reason I changed them. TIL about size_t and how it works.
Thanks, I'll change the types accordingly and push a new version soon.

>
> -Peff

--000000000000d2df170626130fff
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 61bd644a78d000f0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jb2xsSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMllWQy80cnFSQmQxdXVoaXRUeERsdG93WVNPTFBlcwpvL0RaQTlLWTdB
ZkwzS2lseG95aHhjTFAwSmRVVTk5RTQ5cDhKTzVUV2JDSjZUQzZ1VStwTTRCR3ZpMXhGWHo4Cmxa
TEg3TDlNUTd6N2YrakcyNE5OWU00UGZ0Z2MwWlJaeXRWdjRKNHZreWdrRHljczY0MFBzUnprN2Nr
RXVhZ24KQU9wN3l3aXRNUmpVRlpqNzV6Y001elJ5SzlZR2paVk9YSEpuejRSMFpCNzF1akhaQ2pp
bGZtUytMVStXb2EwUwp2WHh2cFpqQkErSEdSZCt1WU5Xaklqc1RCci9rVWFCVGMrNEFNRXdBRWU4
cnN5czdZM1ljaDc3V0luMVhtTE9QCk4xTldXSWtpenRoRDVSNEFndjg1VU9tM1RQTDY2TCtqdEdV
WFRhTUVmcXpjVEc1aUx2ejIxZDZ0c2d3SkZJK0cKenM5Y05vckhuUGVpaGwzRG1PcDl1SzVkd1R6
cXdGdDA4QTgzNndmN1ArTk5jOFArMU9STHhveDNtRDgraThHQgpaSEV6L0x4THhxZ2swa1Y3cURJ
dUxzcmQ5TVRTeXlEMm1pOGRKK205S2hnemRIMzdaU2RRNEQwS1B3aEszZWF5Ck1IR0ZuS0VlYXFw
WVhrQ1NCZ01sT283ck9nSnpLa0g2aDRmRFBPTT0KPVlIVnoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d2df170626130fff--
