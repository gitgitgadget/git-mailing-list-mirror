Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEEE20C03F
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744276406; cv=none; b=ReGE5DzLoiJUywyhOhQlYlcbtASsevniLK+NBZUl3s3pbMFoFEtW8HE0l2xuF/vKo7uOu+UUKtEWON3jcM+oZGrdZ3PT2MVZpezdcSJkI93akZPwRU7DQ/oCqzQRFsKlNtgJ9Hc1QdvjRlWjRJWXG4DhhYqkrJMPF/nWJoeuhTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744276406; c=relaxed/simple;
	bh=ejxvrRldlf7GH8bUEe89NHbdHvOhG0mPKGQYkj1AcYs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjEDBqO6wFCdrZAXdbn3SZhGdKg6FKE5eZUVx+LerR4/rj0qK78S9yUKqrjOPjxQWey6y6T1+xMo3T+lX/r2ouAZP87brtRu9M5xcCc8f/3dfiKdZthDGDHSZ03uWw0jkn6Yu6ZH907q0+9fA5l6H29ynQU/hkSGTd/Fob+bGgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtBUuwWn; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtBUuwWn"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86718c2c3b9so225084241.2
        for <git@vger.kernel.org>; Thu, 10 Apr 2025 02:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744276403; x=1744881203; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wkfrvCGzW0xq8s3K2njHn7XNLpL8rcbiFuaqIBFW7Bw=;
        b=NtBUuwWn26K/yduZEn6a4kmjzTgFim1nKlmhBuCd353h9fB0rMRNj0HqtaGbLZ2DeD
         KbFizI1HF7lND8jjI3n87hm4xYSsKBUVKXJvs5ijG7bzlkz+gJFyWPIB6iSN+XmLtusA
         kr0tRvuo/lcQXZJLYxKZ1scG8xE61TbfNP6aAbt+SGAoPhgpBFuXwpdXqUIjym4/4es2
         37V1Ar0/pCuxgxK21L0fQ1kS9stbNNLA9LmD1Y5AblWtcPG//2MZKy27uGfiCjVHcnya
         GFd33rgb5/ev5ERU+KUNr/0tA0eOV8A2X5sqmgEFCCLgI9+3hVQ3MPfJZ6/vbcbfUNcJ
         kOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744276403; x=1744881203;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wkfrvCGzW0xq8s3K2njHn7XNLpL8rcbiFuaqIBFW7Bw=;
        b=ShdtA7RXcOmg4uQ5ODSCHMiGaGueLXP5AgJxWlFqN+L0qEL+2sCs6emmHk5ldoLeHf
         DXoIYKxEqywE+2ucEHE2aEyPeom/9ysEYBHtyw6y6IPoZR9rxK8Knkd+vgqoTQ6BpGW9
         I7H+yptfjJ15nZw10GYshcWyFV29eP7jh5D8zOfrGin9v5E6fLCEj05mQ27ioYfyplQr
         DIXDvoyAyD6RqEBHDUBUauzFkGGZ4iweaA28qaprYbzn8lIsaTr4l6laBvxueE7RQVYR
         cFPnKafZoAgNyFieE+JM+8e8fSfsk6t61lpSx034w+s10W5juEdOYQWw1Sz8wHbYR0++
         FMIw==
X-Gm-Message-State: AOJu0Yz+o3g6oF8hIHlijdbUDIlHY+xNaTjMQQsDavf8ICjg3RuEd62Y
	VPyz4o4HNfwN2yk9cK7howgwX93cM2Cbic83ph4TeQHZH3HPjdy1CIsd/Yug5Ey1pfcdmZX+Y/y
	RPeksQissL3q7qqfmjnBnfVmBN6hgq6Cx
X-Gm-Gg: ASbGncvzEGSqnEu65t3878uXDtR0Bpbkd1pMeJEPp34xDXvfjcVRCbKoM0nebfWCmYu
	XkUUaPa3E3Y6mg2W38LKRHXWvngNGscWKXy5t5OUoQOmHJoqVaNOHJ4CZCiZ0kSxcTM3LKRE8YD
	TdDhXOe0eawPxdf2agA9dYTCEYagWmTAtklh6n+RfULr06MC4U868CTwc=
X-Google-Smtp-Source: AGHT+IENy2/D/IwH8NQktgssOvbKZKDd0xvSY2kyx+QI4VbnJedf/cWTWmjbDTiXVfXqG9nVHxgLsBAwpSIjlUEI9Ng=
X-Received: by 2002:a05:6102:32ca:b0:4bb:cf25:c5a7 with SMTP id
 ada2fe7eead31-4c9d34ad25cmr1329285137.7.1744276403454; Thu, 10 Apr 2025
 02:13:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Apr 2025 02:13:22 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Apr 2025 02:13:22 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqsemiuwhx.fsf@gitster.g>
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
 <20250408-505-wire-up-sparse-via-meson-v1-3-17476e5cea3f@gmail.com> <xmqqsemiuwhx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Apr 2025 02:13:22 -0700
X-Gm-Features: ATxdqUFm_1izbnkzlZO3yd6USYp4voOW8x1iC9pD7XB7S8pvzESj8rIk370_4Lw
Message-ID: <CAOLa=ZTRAQJjYU2cvxOw=tmCkQH7CLm027B5ZkGSg10qdGQENg@mail.gmail.com>
Subject: Re: [PATCH 3/3] meson: add support for 'headers-check'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, toon@iotcl.com
Content-Type: multipart/mixed; boundary="0000000000006b2486063268ff5c"

--0000000000006b2486063268ff5c
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The Makefile supports a target called 'hdr-check', which checks if
>> individual header files can be independently compiled. Let's port this
>> functionality to meson, our new build system too.
>
> Good goal.
>
>> Let's avoid the abbreviation and name the target 'headers-check', which
>> is easier to read.
>
> This is a bit dubious.  Are developers supposed to keep track of
> correspondence between the long establish name and the new name this
> patch just came up with?  For how long?
>

Fair enough.

> If we make it one of our goals to name the build target in
> pronounceable ways, that is perfectly fine, and it would be a good
> task to allow "make headers-check" be a synonym for "make hdr-check"
> (and do the same on the meson side), and deprecate hdr-check in a
> cycle or two (this is not end-user facing, so the transition period
> can legitimately be much shorter than usual.
>
> But we still need to have some transition period to help those who
> build from the source adjust their set-ups that have called "make
> hdr-check" for a long time.

Well put. My intention was that anyone using meson will anyways have to
change from `make <target>` to `meson compile <target>`. So they
wouldn't mind <target> changing too.

But it would be nicer to keep both the old target and the new
replacement and eventually remove the old target. Will do that and send
in a new version.

--0000000000006b2486063268ff5c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 94df406568ea55a2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mM2k3RVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1menpDQy80MkdxZjFQL1F0QXdFMUliOTl1akdJYjRSRgpQY3NZNWxCR0h4
dTBzVXhZOWxaZzk0bHErbEc1d3ZhNHZzY2lRb2p1dm9SWlF5UmlMUWNjaXB1VExPaWtCUXdJCitN
ajI3Nmd2NThtKzlQYU9ob0QzUVR4VENNaFlYc0VLbnJkdng0N2NEcGhEb20rOHBUL09BdjN4U3NE
U1NHVXYKcFFXRmRJZFpadmwzSlprR2xUeHFKMFhGMVBqWm9SVFZGdXJSV1pPYmlOT0krMGdnbjN3
MWpLWFBHZkRXTC90cAptWVZDT0k1cGQ0MkVVRjM2VUt2dFY0Z3lxUWc2bWErdStKZHE2WGZRNStR
VDkzbjBETDY3cGtmeUt3aWxobVVUCk5hY3lsT3RhWW5NeDhSVEVtOHhsTHJNTEpMS1RsVk85cmlF
RkUrdVRqWFZ0LzB5a0owTXl3b2c2QW1RQnhkQzgKRmhOV3pQaVo4SDk5UDg3OFF6ci9reWFKNU1l
YzJKaXFiVVFWaDVTcERmSnFzQ05HckRpdTdhWjFLaWxCZC9pcwpoQUJOa1dlck9Ed1hiTEZlRXpV
NEVDR0t4T0ZEUXdSMHpISXFqc0lialhNZHZMTUFOU1ZUb05xUEtKU2N4RlRWCnY4bjNSK0ZoY283
UXpmRHFYUXlhT1pPbStHTEZtSU9WSkUwVFo2VT0KPU5WengKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006b2486063268ff5c--
