Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729F91A8419
	for <git@vger.kernel.org>; Sat, 31 May 2025 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748726471; cv=none; b=gL9z2hvKkb65n+z8/VlpsLHUS+kR/GOWsdF/b6j8JNTYEnjmNhMJ6joRsp/gISAEfx/oj+gf8skNL8hHTxiDOW/z1FfWaw8AGFHyuhJCBInFj7pJLw+X3+O6IZzBZP98zMjbdJmzAb0bVU5MElll4betWmjTbTLC3tJx91ErEmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748726471; c=relaxed/simple;
	bh=nlEw250cPjVYCbbQLtT4FP2umKc0Z7h6Tvi2n49oPes=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyOXMoW9GE7Gtk0JQzLraCJ8X7lhXjKIhcQfqEugxrA68H1yRW3t13eMxwxMOtxqThYlEaPw3JmE1CyzSiGs7AI1kWxlW0vd6I4GfN427+Vb34wzp82ku1il5ee6WYu3MTgvHsLQ1Tts7PeugfG+BYMZYShHRWky1ms8AQwsLVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhzCjurj; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhzCjurj"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-52413efd0d3so1029752e0c.2
        for <git@vger.kernel.org>; Sat, 31 May 2025 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748726468; x=1749331268; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ya8bBbNJASd1sJRvhYxEktvj0g52Zl31q1VXTDS7kio=;
        b=HhzCjurj8ijm5n0K5DIN7a9I+beHa811s/PKUm7tnbzO67jm5sZ00vLP28FFZ9JGAy
         mDtsj5+3odxQesuRcpCj3EavExGYlST46UvStsZeBPrZmuFNPN5flBcI1N7DSjrYfaw3
         YdifPqkexwTmnIlh7fydlW2NCLrypS8soubH/0SL5CGcBaZmW83FjagbeLURMZOi6xFT
         xMG+meokow1q58OdxbvzntcWW9m2IX1sAHtF0p1CswivF3oqD2ApBI6SW/gVy5W26J+s
         p1Yg3/kSQhLzbKYYP392c+gn3zdqNf3FwfaiDH7vVjgkteZ5mbG5LtYM2jxVoLIlxp4r
         xtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748726468; x=1749331268;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ya8bBbNJASd1sJRvhYxEktvj0g52Zl31q1VXTDS7kio=;
        b=Y+BIFDoHNKPFUQVkr/XDbAB2E5oJln8v4KtWmdlC8k2xnwy0Rtv8XU4slkwQbtOy3v
         N2vCYA/hc43ENJtf9bNOLXWRq/pLVA49RDqrDv16GchD27E8qS56oOrvCGc/DGV6Qqvx
         vD9vV8T+IlaFHtNmCwAZCxv4tQ4+6OfuSeiBm/ywBCTAmPMSyD6qy2UNxJwpeHFDbSRh
         vXIsShhMZ+oAGG9mLVNGkQguMN4P+AGZ6a50iqdONGYiktKaj6833jdm/XgwW5ZrW2MW
         qTA+D+sHkauCIuQVZ+9qZJ/R5zJvgM67+tNxkvilVdf02PtmBfaxffgGO6QNVPLrW/H5
         e+bA==
X-Forwarded-Encrypted: i=1; AJvYcCVFzJRxdb+/YvSMlXByk4Mm9v395g+x9jmzDD9UVWPAfIZxh6G7tVxITfAUKWt3KT5n/qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww12EZDR1jYQsGbh4foNHhOhWoNLrB+81Wzqsn5/yDABg0nXmw
	HvUxkcKg1UZV9jxZ0LV/WTidGV9D7vE1SXLAPmgYUI8NQH0vJWxiAsZ3xrQizLc6LoNjgdDknmz
	97G3QgQT+LBxqOyXAlNU7+rQMzp7hZA4=
X-Gm-Gg: ASbGnctjVPD/oG3c/cihhiXTdjwXnhVbJZBr9j+ReJWNS7QJsLf7hM0bfhvGQBzHUIY
	7LdVfAdNooJXza2I0hfchRQeB3x+poLnxfOW7fMZ0N0WPywijisi36xQVzblCannMGVosVicVzS
	1b8hY+7t7O2J+xff31ut/qioFnggdS/RFz6r7Bl1rLrMvfS+zP6d9pO84o7tXp09gZkcaSwWaew
	Jbh4CRKywnb2f5t
X-Google-Smtp-Source: AGHT+IFkBxq8HjsLBEZtnzSaM9VT/MT6C+kr9JSIEVYeJxJZaygWl7Il1vdOnb/TOIhC4cMsWzXaaaghgQ0GuZS/ifI=
X-Received: by 2002:a05:6122:250f:b0:52c:3a36:a82d with SMTP id
 71dfb90a1353d-53084bf98e6mr5670135e0c.5.1748726468212; Sat, 31 May 2025
 14:21:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 May 2025 14:21:06 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 May 2025 14:21:06 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250530-pks-meson-tap-v3-5-676f5e41f2e4@pks.im>
References: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im> <20250530-pks-meson-tap-v3-5-676f5e41f2e4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 31 May 2025 14:21:06 -0700
X-Gm-Features: AX0GCFvJifaoiNLkhHxNjYNIA48tCAe7KLdxsZE4rEzC366VzkTH5xTk632nNCQ
Message-ID: <CAOLa=ZSvzq7LPiyp5aggr=yUCTkwpaZf=u3-Wyzh4sn5XVSOSQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] t/test-lib: don't print shell traces to stdout
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	Todd Zullinger <tmz@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: multipart/mixed; boundary="000000000000f29ef00636751b43"

--000000000000f29ef00636751b43
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> We have several flags like "--verbose", "--verbose-only" or "-x" that
> cause us to generate shell traces. The generated tracing output is split
> up in these cases so that the test's stdout is printed to file
> descriptor 3 whereas its stderr is printed to file descriptor 4.
> Depending on which options have been given, we then end up either:
>
>   - Redirecting both file descriptors to a file.
>
>   - Redirecting them to stdout and stderr, respectively.
>
>   - Closing them in case we're running in none-verbose mode.
>
> The second case causes problems though when passing output to a TAP
> parser. We print the test's stdout to the console's stdout, and that
> results in broken TAP output.
>
> Fix the issue by instead redirecting the test's stdout to the shell's
> stderr. This makes it impossible to discern stdout from stderr, but
> going by my own experience I never came across a usecase where I would
> have needed this distinction.
>

Fair enough. I wonder how we can retain this distinction, perhaps write
stdout to user provided file. Or add some prefix to distinguish the two
when output to stderr. Nevertheless, this should be fine.

The changes itself look good to me.

[snip]

--000000000000f29ef00636751b43
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fcb652e596a30c49_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nN2NzRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meHFUQy85ZFFHM2o1SlM2NUR4SnVrV0g4S0NHSXFrQQo4NklWV1NNZkFD
T3ZkZCtuQ0RXTkNWc3pKWWErekdRcFR3bHgwWVp1NmhuWlYwNTdIeTZCNUpHVEZma2FHOVVCCmtE
K1ZpYnFKTldjMEFlVzkyNmVmQW8zMmUrMTNMVHl2NzhBcWVxTU5xd2VIakxXWk4xREdDTGx3WGxQ
bmhmcFYKNk1LNGdEUmxlekowamZzVmJWZC9DL1BlczRXZ0tzWlA1WGsxbmlvZFZ2OU9TRW1xUkpR
TGhXQ2laRXRrMktTcgp5UDFwS0gwditmS1FLbTVRNE1vQk1oKytRMjYyU3pOQWcyRll4THIrT3Zm
RlpBMXZUUktudmlSR3Y1NUNmeUpCCnhsaWtKM1FXTnNvTW9ObG9sSFpadVRxMnNiSHpVYWNLVjlx
MnpMTWFzblE5cm11MjFFRWxjYTJQSUlpRHBsTkgKRm9yYkwxc1p0YUduaTVua3dRaDdaanFzVlhP
RUVIbDN5Y0RLRXNNTEdsR0JsM3VlNWI4azFBUDMzM3dXZWg4bApobk1jTXkxbGVDRk1HUUdJMENI
cUxtY3MxNTdEeEZDS09oakJBZkRxSm9HSUY1MUVlRWhrOTIwdmNoRVdpdmIxClUrekVZdGprREw1
MEoyLzBzSDRWMjhiTW95T3FvbXJkVFBkM0luQT0KPWxDdUwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f29ef00636751b43--
