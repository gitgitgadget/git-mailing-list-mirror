Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74821219311
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661698; cv=none; b=mIJc++VP6WoieEi+iHbjsRQTcPojcPXfOzdgl4QbX3G514/b3fn/1d9a4h1tf4iNqZhK5GQ+/BSX4R4v83vejaSj5FzVqyy3VwhuHxWGNYaTKfc1y1eHVpRVOOcSREXTkka2V2xQm3iXGojwxGtrbF2NLMeBTvaQi8s5roBHt3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661698; c=relaxed/simple;
	bh=Ig4/9vmANy4Jefh50JcV/LabWNl+tLLapPAq2/MZavg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lius10q+fF+eJ1T6rFW4FTcXBjAGVoX6QQvT/ghQRqzhCnliquT/UAsboFmt8JifLiqr10OeZMxdSJUuC7Y42ziIOjOptnKEmFRhRhAgBvYuxWERfMjpQ9y4rjSfAdq2TXo5Q1UnhfiBe6FejGyiezMDuhkQ8rYLwe6joIK5EMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/WK6Cd0; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/WK6Cd0"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-87ecac3e17cso2543191241.3
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 03:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752661695; x=1753266495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ccao800h+8sMGLNiRTyxctKPBOj3dq9mzRk8olzpVhA=;
        b=A/WK6Cd0aYMQRcOCa02bXYj7oQpenHa/BGRZshrZg9ivc16s9BLIOjp9TH7WdOxaG/
         2cH/4mBI3/Dm3Hf32q7xyHJw01HmIz+C/nNAb9aIt8xYwRtCCGVMn/gBtH2xWPi3X6o3
         eRdIQQ/ZQPdgt8mV4z5jvFEPSlFCPsUs++P2FHn7qnLv+XpRqZadKQyK5HVfsDYQOvLQ
         UWGg0SRGwC4GWmxMDdUvNb8cSqKb8HjqKiE0uZyNttBpquseTqviztdddOMK5Hvfd4m/
         QBfkIynbwVDxo7RqlO5Sm2TUzsoguLcyB3AnoVvbV2ULQsv/56ey4EhB/lPkxpZC3gBp
         ne+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752661695; x=1753266495;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ccao800h+8sMGLNiRTyxctKPBOj3dq9mzRk8olzpVhA=;
        b=qPSwiKm2cOqrgauvD3NF65MDfPbtKTzDr/bDT8dJr57JwR2e1LMgp1fdwi2j65Te4F
         3t3mKOvE52zbWG4C/vOkBKeXloYTcmN/w+8ghvExFTfa9SWvcSy5wkAUT4b4JtpSsji7
         a7QnpdJ6/yzASVaR6N46Mja7SU2qGYvv01vcZ/AY8viIV8ZjTGB7oM9vxmfd4ggRr7jJ
         SFnVICieF9PvXf9ZogTBEg8n7KYNq/Q/cmb0YynwmmAi0uoIHpTfLkkcrKj2XOzbTdsz
         AyowJl2nL525mlOp+Fn66sEXPHOP79C2Anyzt2ylsx67JNAJ6FqSFyJHGvMSQX/ns4a0
         zq1g==
X-Forwarded-Encrypted: i=1; AJvYcCXO6ZHg6kvBIsJS4plw+XBqHeBxSZpCDcjb4ZQRzTqz8kYIja+PJLf5ZtOTr0oOZlvEDM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaZyUOGvfavUdqC497rovd/dUIuhOGIMoR+gHv2AKREdouRoCd
	JC9syHR9kpNbWRBLZ182kQH3iVKVud9DuLI4d1PfHjk5Fn9SmmqX2D3TK4eNaRvqa4il0T0JaXy
	07WQiMLQoHlJtYG+uIt1U58cGoykdHdkKqTX6
X-Gm-Gg: ASbGncvqUyODOF5IdB38W6NaB3I7FXvwK4zbdUYyX2y1MQRTYP48Zz2Al5oFa2xi1b3
	7sN01JooqMnMju+9CxbjxpRlo6ZxHeN3kM71QLaIk46OXPn7StjtpwHH9w0Kt4/2Tn5jZLYgNWI
	XOkFiEhFzZ/Gl+f83xEyWypEGyEpjAzO0blPRYPHL+Ktv0Bqi7SLtQ6CeTdqVbsSzhWpzhkuYQg
	VvtKpM=
X-Google-Smtp-Source: AGHT+IGQV2/jbw4BNEKC1n3nWi/X9w7eehzEOTOTD/UWS7antYeQd6RNuuOxI+/V/bG6v+ut0K0s68H40wH82qOxGkk=
X-Received: by 2002:a05:6102:32d0:b0:4e1:48ee:6f36 with SMTP id
 ada2fe7eead31-4f95f41a546mr683520137.19.1752661695310; Wed, 16 Jul 2025
 03:28:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Jul 2025 03:28:14 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Jul 2025 03:28:14 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <80e5cd3b9df80cbda58630cae20ff7ca44793d8f.1752658700.git.phillip.wood@dunelm.org.uk>
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
 <cover.1752658700.git.phillip.wood@dunelm.org.uk> <80e5cd3b9df80cbda58630cae20ff7ca44793d8f.1752658700.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 16 Jul 2025 03:28:14 -0700
X-Gm-Features: Ac12FXyZczTHSPtj99iLUUJOAPOnKPv-wD0k07bu-og2AeCX0E0nTsZJzIPez1k
Message-ID: <CAOLa=ZSXE8n883i8RxD2ovokNPYsxainzBdp4v7qeTuCfNo0mw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] strbuf: convert predicates to return bool
To: Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	"Brian M . Carlson" <sandals@crustytoothpaste.net>, Elijah Newren <newren@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000c2f1db063a0959cc"

--000000000000c2f1db063a0959cc
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Now that the string predicates defined in git-compat-util.h all
> return bool let's convert the return type of the string predicates
> in strbuf.{c,h} to match them.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  strbuf.c | 28 ++++++++++++++--------------
>  strbuf.h | 12 ++++++------
>  2 files changed, 20 insertions(+), 20 deletions(-)
>

Nit: same here as the previous patch

$ ./ci/run-style-check.sh @~1
diff --git a/strbuf.c b/strbuf.c
index 6c3851a7f8..d9e040c13b 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -38,7 +38,7 @@ bool starts_with_mem(const char *str, size_t len,
const char *prefix)
 }

 bool skip_to_optional_arg_default(const char *str, const char *prefix,
-				 const char **arg, const char *def)
+				  const char **arg, const char *def)
 {
 	const char *p;

diff --git a/strbuf.h b/strbuf.h
index a580ac6084..d2ff9839a9 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -679,10 +679,10 @@ bool starts_with_mem(const char *str, size_t
len, const char *prefix);
  * skip_prefix(arg, "--key=", &arg) to parse such an option.
  */
 bool skip_to_optional_arg_default(const char *str, const char *prefix,
-				 const char **arg, const char *def);
+				  const char **arg, const char *def);

 static inline bool skip_to_optional_arg(const char *str, const char *prefix,
-				       const char **arg)
+					const char **arg)
 {
 	return skip_to_optional_arg_default(str, prefix, arg, "");
 }

[snip]

--000000000000c2f1db063a0959cc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 90747c63548224a9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oM2Zyd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNE1WQy85ZWVCMDhZaEEwOXhKb1p5SU11SE84NGM3eQpmYkpvU0NYK1E1
aXNCNDdGWjl3WWFPNXZsSEdvMVlLcENsOHB1dFE4Z0x1SmZEMGE2SkJkNjAwK28ycVJlZ0tECjV0
cU4vN1I1eTdrZ2NUTDlnb3JQc1FvMnUvUTE3Ylgvbm9ZOS9icUJEa2h4b2RYUUVCSVNrcjdxVEFt
bjVPbkoKOStTTVBadEJqa3l1ZkFzb1NJcThvbVVQWlMvRngzSGFEd0k2aHNuRDBVdlowRXlWM1F6
VmhHamdmWVg5T0ZKVwpUd2xUNC9zUkxSZmYza0tZc0FpbExRbk5iL3RhS2NoZkF6dkEzeWdXeWtZ
UDNTQWZwQUdqVk5FRzNyeHlZZ2ZoClpKYlByOWpPRWJqZjJQNEN4dnYwTWhvNGFVV0V5VDd4SXRt
bGtrZjdmQnpVOVVOV3Zyb1d4ZVJSNWxzT2M3VFEKdjg2dDZDcjdmY0NYRG40L1VTaTY4bU9scE9H
L0NKVEp2aGdjYURrZHZreHc5cS9kUUdEMms5Vzl3RThlNEdveApiRTFCeEZ5NTZ6eHBrL1JuOWhF
ZzhHR25VV3VKV2pRQUVNWVVYbnl3a0ZGd3F4VjJvV0wzNDRmUmFwU3ByMUtnCnRTczNYbFcyeHNy
SUhpTmhxMjdYc0RYbkxYUzd1akRLQzB4d1liQT0KPVJPWGwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c2f1db063a0959cc--
