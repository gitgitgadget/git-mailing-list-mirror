Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EE2267F71
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881043; cv=none; b=YRAtpOicRr3oYDTKIfG/uOjosZDbvt3ZEm/eLKz3vswGuFvaN8gviYQCvprx4WwMSw3Wcw4XM0PWB53F67S8WNEa9CxLS0YrVXwVnpAHZxj8FwhI5LqSsyvyqvGskwABsGq2K8vB1fCSovbAXfrEOYlkPDGv/LYVroTY5jgS+Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881043; c=relaxed/simple;
	bh=lpFkjvUPUKZL67tPS+KwuKa7l6ZOeifuKYYmKFd41nI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSNYvVrg9lNPHNkB9O9BSb43w6RYqzhy12a4gN9Zqi3u8Z/GyGed/D2QS/DvRFECzEJ9gpaZEGK1T5qijiYcWyfeUT0WQ2ssMyRlNuRzwSwVdjgg/dzYw5hnMPMjK7stauB5upTiNwrsDMRTtqlRRmsUH0TlvDGnG1tPdsJc0M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JloG2Xhf; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JloG2Xhf"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-86d30787263so499958241.1
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 08:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741881040; x=1742485840; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FH4JgfBb8msamxu12noWz0gf/Z1DzI8wiqyTSjXcW/k=;
        b=JloG2XhfXI0zUAYF9WTOeg9gPbjypWl3Jw5ftfHBNxq4P8nhVfBIUcEe2njemvePiF
         LZCLsb4e8vWtfvqaWeRbsVbXAn2DyCcJxF7XffJCOxo3V0PHLqmcEf4/GIUHYGm5Oh3u
         ePQF4CeZLZpufKSLYH9FiJxJlX5h+2zy8SNU7Yynb58doGyrCo+PJwRmzzG8C3KrUHuf
         15SLZz/JD5aYeiYd06MEiY+NPBWnnq/GaFE79GVOsMy2gvcQX/NbfMQPJk0LVKzqWvty
         0yyxzWPLUuqyVqQVbSpjwyBgHJ0VO2lvy5AWAIk4teYzI6wG8eG7IjIxHeWMWX9Qokbj
         GkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741881040; x=1742485840;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FH4JgfBb8msamxu12noWz0gf/Z1DzI8wiqyTSjXcW/k=;
        b=dOhjCzAgXBC42u0Mj3RqKXehVgulKamrZC+WfxeSwj2WrBH0j+WAfil8xe94fW6Ifu
         jCoNH99r3RMyFE/j86ZefNMXaG30KiCjgzJ1hLBnOnvp+JNczPCdf9AeXaBDRZf/37OY
         CIDYzevry69x5VPrwC2fZtQWFS4470qHwjPw7ywhHg+ZKNwDTeQGXN1GA0r2CIES5vOH
         DS9iMAWFBDo3hLT9BImFxqspqRetaqe4ZITru1U1b/quN+rnt/61vxON49KuCmRlJk+d
         2ECY006+waf04V3fqp2KLSrZ2hagYpFFa2hEl40ttdVHyMYO/wMUjZ3By2EP1b7OFPzf
         JJZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvVkkJVW/LT8uvBBPHkjodZ9eA8KDIMH1C5BnIcJL0IhfACWpa3WAe9oEIPbhvr1TdCsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0BP1/dhFksTBlFbSY+ls0EByMmXiU4f2BnP8SNLdjs+LzVno3
	/heeUTATPJC4p51FHDlOfVvrLUFYfEyTVZMiRsQE/ZCHcM3sVIIGhO6LRUKeWqmkm83Uh6GO3G6
	rNJbZQBMxbSSbvWfGQZDaqFPO4E4=
X-Gm-Gg: ASbGncvrsgoAlMHLydkQxk8/gyDfj5IZa9UPomoYXvpy1bHn6kubDOmEArnSoWmJrtu
	f9hrZgJ/jbIYPYLjtrOWq3TULqtxV8eVO/D5y5VUOpG/XKiK5P6HonEj3IwQEbyIxhJAbIdtd7X
	kb0/tDzi5DOxJZig/Y5v0FcQOVkEA=
X-Google-Smtp-Source: AGHT+IEuQsncvouQW+WSfbGnyc7CzmqcM0m1MjbSBAYk5/ZKnb2WWcG3J3OQrEeb4EBbe0q5i241bmfqp0OGpzXrc3s=
X-Received: by 2002:a05:6102:808b:b0:4c1:91e0:d5d6 with SMTP id
 ada2fe7eead31-4c37ec756f0mr776523137.12.1741881040273; Thu, 13 Mar 2025
 08:50:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Mar 2025 11:50:39 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqcyelq714.fsf@gitster.g>
References: <a3aa5f99-63ce-4be5-8d64-fb6e226b3bf9@gmail.com>
 <CAOLa=ZRNJD7NqceGQ4B8ox+50m2q1nU1t29x7O0roc=-_4ww0w@mail.gmail.com> <xmqqcyelq714.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Mar 2025 11:50:39 -0400
X-Gm-Features: AQ5f1JpgbmcXTPIQ6WYZDsRKqc1Nt1aov1T39sAzxYw7vCLUaTNCUaw5wXpF0tM
Message-ID: <CAOLa=ZQWWh2952HDazcdYkDxBAeuCS+KWQk66zVGZyb+foE1WA@mail.gmail.com>
Subject: Re: [GSoC PATCH] pathspec: fix sign comparison warnings
To: Junio C Hamano <gitster@pobox.com>
Cc: Arnav Bhate <bhatearnav@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a5b0a106303b48cb"

--000000000000a5b0a106303b48cb
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Also a bigger question is, shouldn't the type of `pathspec.nr` and
>> 'istate.cache_nr' be the actual change required? Shouldn't they be set
>> to 'size_t'?
>
> Please do not blindly advocate the idea that size_t is always the
> right type for any countables.  It is not.
>
> Platform natural way to count things is either "unsigned int", if
> you are only counting, or "int", if you need to be able to signal an
> unusual state other than "here is now many we have in the set", like
> how index related functions uses (-pos-1) to signal a location in
> the same range with different meanings.

I agree there is more nuance here, and that is what I was trying to
clarify too.

In this particular case, since `istate.cache_nr` is used for capturing
the number of elements in `index_state.cache` and the fact that we also
use ALLOC_GROW on it, would suggest that the type should be 'size_t'.
But I don't know much about the usage of 'index_state' itself, so I'll
take what you say.

--000000000000a5b0a106303b48cb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c183f553c7483e16_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mUy9zMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1hnQy80bHY5Y01iTjRCaCs3T29Pa2RrUFI4MDVjZQpPbG9peXJPTGZ0
b1p4bENsM2VxenM0eGFtdE1uZGl1OGNQU0grZXdZZGlTQ2xtSExFUGE5bDRoL3JFWEZQNnROCkRD
YkRKQVdaWG1ZUmMvODEzUEQwZFdzeG1IeXFXUC80bjBXRjFJVXd2ZnE1UjBxN21UL3RFaHQ2M1Nx
aEFIa3QKZlZoWm5tTzVYT2tNNiswKzBVckltRThYU3owdmxBWkdWSE5tQzgxdnJISjJQWTZFSGNB
WjRYS2RmQkhCaUwwaAppQnUveDc5blZBNkJaaldpY1dNdDFvaG1lWkpoeGZCYTVHNkxWTXdIbW4w
ejc1RllWY3p2RGdGVkg3UEk2Vk1XCjRueU52NFBaZzQ0WmI3b1NMM1k0TzJNZnZtb2tSV0J6Y0hw
dE50Rnh2dktycjBxL29IangxMmE4a21CdTJ1TDAKUmNmZjhoRFdQdjY2OVJSYUhCd05UWnU0SjRt
d3RjNHZFNzVwbDVxVExoVk8zTnlGUGJNRzZWMitSeUZNanFEeAphNW84cmpMcDJXQms2eVh1Ykky
bjFFUVVpYW5uK2hhbC9xM21vakdtK01ndTFzQkdQTGs0em1SQ3ZzNU1FRGxkCkNyNUg1M0ovQ2pK
UmhsSythcDd0NDgwWTJTRDVMK0JHYTVhSS9tbz0KPTdCM0UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a5b0a106303b48cb--
