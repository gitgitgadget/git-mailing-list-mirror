Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10C1502BE
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741344539; cv=none; b=tCEBvmmDHQsNFeZZe2mZDiEeOXQUZKRsmKmisT2DbtLilnhbjObX61skstc1YILbhn/eyabukPC97r31DuPgMcfkXTCQgAsqoQad75y//9aJoQRXQFNzpAMKWbqz+INVzjRHwvoSb3KbVHjjxMmaWM6p5tqnGck1M4MSv5+KQ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741344539; c=relaxed/simple;
	bh=waNVKU8zkbKl6WNS+uH9OAhq1NJcWU4fgS8LRf6SgHQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOxy+0V6fxoGfeNPVd20/zlGJIRqCBs+VPo//7eRhD4xLXYg1DGZsllidpdrGMcTalEkZnpBKSzzrib7FfREBEJFk0FBi+c10XZij5fJ1T0rp4vBDIznzoxHyR5MINWvAN24uu5FnE8XsGLuCKCB7DuYZYR/Q7doCFz3f6qMQ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6TV2zJR; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6TV2zJR"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-52364925cfeso2839155e0c.0
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 02:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741344536; x=1741949336; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=i+kcd0fGSQ5jVGMHu0kWKoPfrUNQFr8DF8CHqB7aYN8=;
        b=N6TV2zJRNGi6dH54j+IECIXwRh42VlmOPdOlO1qS5CEyqqooSaX3HAkZOJc4rSQNvj
         TPLnlmHMnBJ9p9hJDdqRi6eLYipueU02rzStb81K8jcFNJP7xV+D38/nY0uFlcREK4lw
         nGxj5yLzzbH2soNvsee3BeorP+CQRrXZ1gE/A3iUXLb3A6/52XdB4a6cyoEwtkUxYL1N
         ZWFWuF6KffdtfN8AHgYc8PSj1xI40Vby9Kzoukd9hrrWrpLCOnbFJ3/ihcD4I9kOXKpA
         uC14yqID2jGTDafdBoVVa6ZH2CubAn50J/3werr0uOWA+7sORtCUsbY2IVbcH8kzNa0i
         od3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741344536; x=1741949336;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+kcd0fGSQ5jVGMHu0kWKoPfrUNQFr8DF8CHqB7aYN8=;
        b=BFe4Y518hvAScgaCDdDP4K4PAPX2EDBx6VgXwO6ueMBSLzPnAlmS0vHq8NXUnKgWLC
         eE3mXvRUIjtAvyvH+G8NhVrjq8NuPVz9sX+jjqSGw3I1TsHKzrFjdTcXT80f0i62EXFR
         G52aEgrCTOrg8JYfSYEfeD67+pj89yHo8SUQJ4lgopMCGzmpAonsOdNK2mPOZNl34Vkd
         B4aD2bltnT0Wtcym6ucLp1wSUM9pjql3uDphGzlB8x3YNw85gWZRU0FX7PFs9Quje4OC
         pTZq+VjGIlCzy2nhl/HBXCy3cMp5Jh20I9EYN/LA+BULL20DENHft8fD/2eIxRlwNmeX
         xBPg==
X-Gm-Message-State: AOJu0YyUvrjJGOAYgkDnriaXwEskcu3BP3kWV21ZFYs8ePEg7YbDL59r
	S1SR24sP9IdXH/UhfcWCOUTDp6hR1z4FFHCPu3YZjxrDG0IkHZjncMQyE6uLGvYJK+NqcS2LTgu
	M1R5JyL3HIGabYoMfXuP/KaeIMUk=
X-Gm-Gg: ASbGnctVpFFausFg8XAJOJKyc2ce30gfnP+mM7e4Mct811lq6M99zR9ukRTRBtIB1Mc
	XQ/v0jUvOwRbcUuPc2PBv/O240vqMGWhOwUiwnOulKBl9bXXmjR8+6ES11zqxmInVo4qKHC/W6Q
	W3NrB3eH5ah5JF5g5UQkYS7U+QPFg=
X-Google-Smtp-Source: AGHT+IGAfa7+TOzvKzBepgK5zYJ1EGJwOEWg6Xtb3sxgt8UqecTNUWx4xEE6VpVFg6qH08fBvSZ2gsGv266yc+y9sAw=
X-Received: by 2002:a05:6102:4a83:b0:4c1:9439:f7a with SMTP id
 ada2fe7eead31-4c308bbeafbmr1946427137.2.1741344536526; Fri, 07 Mar 2025
 02:48:56 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Mar 2025 02:48:55 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqldtmvyfa.fsf@gitster.g>
References: <xmqq7c591sus.fsf@gitster.g> <Z8XJnJEHZd1dFE96@ArchLinux> <xmqqldtmvyfa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 7 Mar 2025 02:48:55 -0800
X-Gm-Features: AQ5f1Joiyzy5MnCmZ_gY5apQzaoXkGEhJgFbJBkvcP1pRZyj3W3UrSFKO4cDdhY
Message-ID: <CAOLa=ZSe01-ziQi5SB+aZX8rtA7ZtzgapW7nH7+afO2yKPDaaQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2025, #09; Fri, 28)
To: Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="000000000000881fb1062fbe5e8a"

--000000000000881fb1062fbe5e8a
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> shejialuo <shejialuo@gmail.com> writes:
>
>> On Fri, Feb 28, 2025 at 04:45:31PM -0800, Junio C Hamano wrote:
>>
>>> * sj/ref-consistency-checks-more (2025-02-27) 9 commits
>>>  - builtin/fsck: add `git refs verify` child process
>>>  - packed-backend: check whether the "packed-refs" is sorted
>>>  - packed-backend: add "packed-refs" entry consistency check
>>>  - packed-backend: check whether the refname contains NUL characters
>>>  - packed-backend: add "packed-refs" header consistency check
>>>  - packed-backend: check if header starts with "# pack-refs with: "
>>>  - packed-backend: check whether the "packed-refs" is regular file
>>>  - builtin/refs: get worktrees without reading head information
>>>  - t0602: use subshell to ensure working directory unchanged
>>>
>>>  "git fsck" becomes more careful when checking the refs.
>>>
>>>  Comments?
>>>  source: <Z8CMx7O19PMs9sVY@ArchLinux>
>>
>> I think I have addressed the comments from you, Patrick and Karthik.
>> Could we make the patch into "next"?
>
> Mine was merely a small kibitzing on the logic flow structure, and I
> didn't really looked at the larger picture beyond that part of the
> code I looked at.  Let's hear from Patrick and Karthik (cc'ed) if
> they find the result of the updates satisfactory.
>

Sorry I missed this email. I did review an earlier version of the series
and it did look good to me, haven't reviewed the latest version (but
that's not a blocker from my side).

> Thanks.

--000000000000881fb1062fbe5e8a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: cf7062e3f40ee823_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mS3p4WVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md3BwREFDT2xQMnJMZTZuQUdZZWMvU0k4VFVLeWdacApMSUtiUVlOUW5S
SFBzQnJybU5RRE5tdVhONy9hREZUZG10aXhxK0RkY2JWNXdnQWlJSlN6bC9TaTdISHdZUTRpCkMw
aXlINlNGdG9JUURURXhxSVllYkZTTGZKUURjR015UUdUN1p6NERReEJNWitVY1NaWGYwdS9GTE9u
cVQ3RnEKVGIvUjl0QXFpazA2dGhkbFdQTVJsdGdrRk1ac1FCcHh6WG9NLzE3clRmU3VlZEpPOG5j
ckxFRmFUNlZrOWhscgpJc01SbVBIVmoxUk53aG9PL0VITVhYS25WcmlLSklWc1cyVWlEckVpZHkv
dmI4UFdFR3hxc0pSRmgxeE1RTGVRCitwZ1dESWVHbzlFdU9JY3hwZTlZTHh4SHNWVHJLWVFRUmFS
MHIzYXFHRU9yZkJuRG8wTnNpTUtOdll1OWVzU0IKSmZxc1EyaTBNanhsWFBWOEl4cm5YMlRyUTR1
Sks4QU9kSnVOWWtacTFEUnJ1YnZQZzRSdGlxUklLKzRMaDJyaQpUOWdjSXk0ci8xZDRUWndQMjl5
azIrdnlieUVBOG82QWVQNEJJRk9kK1ZIRFNGZW9ZNVFOeXkxcnA1cXQzRGdyCjBhdm0vMkRJNEd3
OFI4S3d6N3NYTlVPc1krQWp2TlluRXU2QUFkOD0KPVN2SEEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000881fb1062fbe5e8a--
