Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4D11EFF8E
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996049; cv=none; b=lGOg9vLGAFZZciUW4FdxPMGqA5v8se5yFqupGO4r/7FSur6FY7MNwR7o/u8iSYzsXSk0LZuZ7i2TlKadEohjrKvQeurJrpT7P1tFGIjmjES49bl8y9TWyO6XhIAvUin9LSI0+Ge/XKj8lCrkMIuXMOKynj01pHV2Ii+KVWaMtRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996049; c=relaxed/simple;
	bh=ez4BRteFdNRrLIWfIcm8fJoklW8HBCGLTcS7CaS+sYE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjK0dKZiQeUFbT4HcvJvp7ErE1ZdQaG0LSw8CEfAI0AQzrVV/GD7hmBAtX0LyelB1SxS59vxIYytmsOGkaXYH+N4MrQ6Afz/3lTMaqDhk7ZY9hcKWDHMR5e0OnD2/VP23b4qvCG+ru2y9Uj8R6PL0qJvrqUR3ilrstEanuFYq1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvaaujLH; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvaaujLH"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-867129fdb0aso3827712241.1
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 02:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740996046; x=1741600846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ez4BRteFdNRrLIWfIcm8fJoklW8HBCGLTcS7CaS+sYE=;
        b=SvaaujLHb5skrIBLQD1ZB1vYrFEg7Ofe/ovp2U1v307aOzQBKH66oA/aWjKzrWcw9p
         9mqeUiGawt2fMJl2Wx9o6CcEetS6Dwu12TVILprVzsTyED+bWbIPGaTSZJA4WNt/nU7B
         AnL44bJelnxY939x1Q8UH11uSdfNGSlaIowV5GEuiiUBaNlq7fLgJEUkXcfOzu17yhCP
         PX4+tdYqBu7KJYTCJIzybAuXM+2BLimSpDK/Ev8upBBkd2foukU/8c0H1ETYSVfoIhBZ
         kSbIsdqb+H0xBdVZQKf7e9pcWQJRHtAMCB+VR5Cmf3FIpzwUvsThtWu766C42Q8VXXgW
         dklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740996046; x=1741600846;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ez4BRteFdNRrLIWfIcm8fJoklW8HBCGLTcS7CaS+sYE=;
        b=QSoDQIDuujEX87dwf9wL/ca98YHgfazIxkYMlq3Fptuvqr/5P0R1y2M3jBH7UA3Rrl
         W3npPdDTO0PQ02jwQxfneaqNT0ZuBzHmDgKlKkt4S06ltok8RAL3vzeHRq13LHUkyZ4Z
         f2J8BZ6F8/A+ykbXTUywTQ9a/QlAcfFTNkzhO5qUXJH6kLJ4s1QHidWWtZX2GJmr3Djp
         OIGrp3oCzET0sj/s38NT8s91UjhXsUWJ5WMjJOY/xXOjZbDrOBpn1LztsE1bG18NlxrP
         fGGwkcjF+1JV9ycb2cMqi4Bvaq+d7rOn5b+JXoFqyBfg4yYMo/86blTQjVtSklPEu3vo
         zftA==
X-Forwarded-Encrypted: i=1; AJvYcCXgma6MAcObIVofMeC8FricEVxFsKBLJuMogNxTZWJOyPei6Mjsyz1K0SQtKBzzosCHyu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXDuMt4AaItTcbnUc1xmkZbamz4I7KDrsnbo2L1sxT8yeB0t4Z
	sjtEKnVpMUe3liF+KvaREQiUWlukGZIglzIbWTyy1fXOjMAn3oJqjH95VfFwkEsW6h1cQ01D7gd
	I+rB+gqwl1hRtKEXD3glYuFm6HXTKJ4my
X-Gm-Gg: ASbGncuUZ9K+x6XUu0U6m8d5z340xbWNW0c6h7Xog/agbUWn/KoJxAoQvT6SXIrDDgU
	DKq5memiwsbqsUAPuwQuO1st5DDwitMrPYxytw99KTgSOUmnvTKQMG1oKGThswX0Tgup0YznH4x
	6mvXz3/pFdi58u+NEPAKJyu4/vSYG27Bj35nNcnpKtFdrIyPyeUAWWDcrKfUhI
X-Google-Smtp-Source: AGHT+IH0LOPT4sgEcH6nxP5pcXjz6eg5yZAPJaIDaxX0kdCuffpXrTbUnp/U5SgusYF9rT4xJ0QLSC5L12ijpXiMIhI=
X-Received: by 2002:a05:6102:4691:b0:4bb:9b46:3f71 with SMTP id
 ada2fe7eead31-4c0448e10d1mr8496601137.8.1740996046170; Mon, 03 Mar 2025
 02:00:46 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Mar 2025 02:00:45 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <6C29409D-691B-471F-B08C-83E14D35EE13@gmail.com>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com> <6C29409D-691B-471F-B08C-83E14D35EE13@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 3 Mar 2025 02:00:45 -0800
X-Gm-Features: AQ5f1Jp0XWeaIL5JwBRLf4cH7kfmkC2eWaMMocg89WI01spGWVqZ8W3vqR8mefw
Message-ID: <CAOLa=ZSHETyzEyyJvP-VT9CbvrJt_jV65nEyCOzR3YGRgFNkrQ@mail.gmail.com>
Subject: Re: Git in GSoC 2025
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>, Jialuo She <shejialuo@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000e34902062f6d3ac4"

--000000000000e34902062f6d3ac4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Hi Christian, Patrick, Ghanshyam, Karthik, Jialuo and all,
>
>
> On 19 January 2025 3:43:29 pm IST, Kaartic Sivaraam <kaartic.sivaraam@gma=
il.com> wrote:
>>Hello everyone,
>>
>>It is that time of year. GSoC Org Applications for 2025 are open now[1].
>>They are due before Tuesday, February 11 at 1800 UTC. It's good to see th=
at few contributors have already started working on microprojects this year=
 :-)
>>
>
> I'm glad to announce that we've successfully been selected as a mentoring=
 organization for GSoC this year[1]!
>
> Christian, Patrick and Karthik,
>
> As you're already members of the organization kindly log in to the GSoC p=
ortal to read and accept this year's Program Rules and Org Member agreement=
. Let me know once that's done. I could then add you to this year's program=
.
>

That's amazing news. I've signed up. Thanks for handling all of this!

>
> Ghanshyam and Jialuo,
>
> As you're new to the program, I've sent you an invite. You should've got =
an e-mail about it. Kindly sign up via the same to read an accept the Progr=
am Rules and Org Member agreement. Let me know once that's done. I could th=
en add you to this year's program.
>
> Let's look forward towards for a great summer this year! :-)
>
> [[ References ]]
>
> [1]: https://summerofcode.withgoogle.com/programs/2025/organizations/git
>
> --
> Sivaraam
>
> Sent from my Android device with K-9 Mail. Please excuse my brevity.

--000000000000e34902062f6d3ac4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2f7c6fd4d142a890_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mRmZja1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMk4vQy80cFJCekJySVhhdTdHR3hheHBJZUE1UFlxbgpnamkyamErOU85
WE04RkJxVUpINW1yaDVUSXk4Tmt3K1VQRk1xU2tMblgxVFRpOW4rRHgrVVNYK2pEdDRFanNyCjNw
MTBnbGpkb05PYVJjSURrczRPd1VSNFA3bkJ2dC84VTlUUzZnSGwwOWJvQlpzaEVOSDVEYXgxa0F3
TTgwVFoKM2dOclVPS3dLRVljSU9CQ2k1Y2FPVTdsajN4QU5mRHM0bVJZRmdEM1JaeXhKQlY3bVBx
Wkx5cjM0TUNNdWlRbwp4S2RHSXJSMCtQN1B1OHh4b1lrSDZqcUU0NTVhUTdEUHc0QU5oV2hzdlhP
SDA1aFBxQ1RrM1JZUkZ2NldXMmpvCm44N2VlVFVPblBhYmJXVk8xL09BckFnR0c0Q29GU2tHcnlO
L0k4aWZ1NHdKeUxYcDZCNXhOUEFJKzgzdmJiSi8KendpTUZJVzNKSUtCd2s1d2o2NDMwQS9PTlYy
M3BMYXdJMUpUTjgxUmVzcVhjTldocjdoUGFQUy8wZWlJbVFHYwpyWUxXWnp3eENQeUd6UngyL3Nw
emhCT013bXFsVUx3Y0s1a2VMU2JOdlN6djErWXE1MUdQbjUzQVpVOC9OY0VGClpMSlRtdHhnZjFq
SU54bys3Vm9DTnVOVko0YXdVL0FqSklaZDR4MD0KPWdqVzMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e34902062f6d3ac4--
