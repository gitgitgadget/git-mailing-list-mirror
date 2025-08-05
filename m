Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAADF9C0
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 01:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754356942; cv=none; b=dpch6GpeWNNATOGYnEeIK3sNs097lDJl66QFBTvm3Q9tMj22E7uvM+vSKHHIDptgCyZcx9pGClh6PzyiL2FSHovI34UmMyg7KzoJ6//1fZNn0RZ+IMwqV5x+hOzt+03uiwjRT8hNLOOYuPSWc1NOu7EoqivNBRs8Eg5mjzm87VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754356942; c=relaxed/simple;
	bh=xCDL1NSBTk6VR7pTFk6RXz8PPRlxLtCrU+2OizUegho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSw/hCqdJXhsECyfdDT2Z/WHzKCSgsClD+/cq7vNPCs2UhZCF64crLoBM/pjUlegp9cqbBTuPCJL3w7qdh2L5Hvb5BmSgGeQhxZmvOXC+dxvaQWWdJK1X2YitUc6MkTtjl/Y0sr11XC0hyi9oOSCmv5OuFEN3EOVoEoNl9K5orA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJxyX7M0; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJxyX7M0"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-615c29fc31eso7863589a12.0
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 18:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754356939; x=1754961739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOQldFwg6t4h13kcR5QtrsxT0kY7ttwFACMiR1waYTE=;
        b=YJxyX7M0lk0mi94Fn53UE/5sY7Kn58+SznxPaSNsDx1ofYrgp3tdZfGGtnvnxGzUL1
         pkV5yxl58jTG4SmHQW0btZ3XsBzR9W0oyygYwN89/AEcm6UkOgkEgnUfWZiAQWJDVLv5
         KGI696LVtO0OmvuqwqfBOcpiLExQul8FqRXatX+UYp+kSDfoDCzaAjcEtaWKAqv4hzkI
         HYTqw77Tsmszm7quP5qO3kjnCAqZNG9y57u++BDIBeOc7vE/W8py7fsMQo4FOUtu11Dt
         vGzraStW07d2py/aUJdEblDgEP1T28N/SzJtY9TgJIcFI6sY7pFdtgFEpCpvm+cqf+m4
         v1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754356939; x=1754961739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOQldFwg6t4h13kcR5QtrsxT0kY7ttwFACMiR1waYTE=;
        b=w/M9PBDYvqg/b/z2yUxCi5xIH2O1nNPdJ4JhNZDElK5vmkh35wpw47UDMqfVHZyM7+
         cCPAI5BQrrCLvfJXodLrRUJZdCnAvGU7WCv6HLkZEWt8mv4lTt9Rp6De7EeHbfdcTWpy
         x3KhaYDqze3hVVvQhfC4hC6SUqUWKZPEHnJX4vesHhVmxx9cr07p3S+Pbv86Clnl4iB+
         FY0ia0xCzYCXeCtl0ZquAbr4SlsZU4lvyl0d3+y7C2G9XiWcpNd/bjmcaDAVyG9Wj9I3
         GPO75KEr2HokzmTseJcAffx0C5I5ZxEWI56LFo1I7WFv/tv1ZxeDSPNZrZzG2WFcbQQm
         Xg3A==
X-Gm-Message-State: AOJu0YzqnFT1+nRVi6mL7GtYifnwJXi7H4qeODOiVp0mr29r+6AsE0F1
	SJZ8SGafKSaOmzsyznH8B0Z4qEgWU4nknsUcj/eK8uK3XmnBwUuE9SCPQIaLhKJCRVlmujmZBej
	6vhf7OCURts1B2Paew5NyQ2gBR4VSumI/A6sX
X-Gm-Gg: ASbGncv29HEO0mrvgbU30mpTB22l/fZXMSeMHxRPOZiJSZunTPJJRDQ7A3evOX+xurO
	TZUV/BIIjmB/7U0gn2uaosFKVV0DTQgr2sNgROWdIxPu9r/Fb2nLm+MtNPUXJTK3yF/L3RzNAHc
	hP2oZAUlih5qrpi0NIOgdWpUmSKGR0YZfgyYXlV5Nbm0gjypc6s2ox3ZnrwnL8t0ZJ6mYy1putj
	TjJzCelhEOj7LQt/hBTv/rEAVpiEl7x59U3TFVEuw==
X-Google-Smtp-Source: AGHT+IGul2Hn3s1pSYEtjayxoZA0IHSTWnYzJD+bxgpqsExWb5Jm7QlScY+B2YFL3SeNWRAT/tL4m9ZP/SHHx++agEY=
X-Received: by 2002:a17:906:c147:b0:ae3:caba:2c07 with SMTP id
 a640c23a62f3a-af9400220ccmr1150330166b.18.1754356938968; Mon, 04 Aug 2025
 18:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqms8fbilv.fsf@gitster.g>
In-Reply-To: <xmqqms8fbilv.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 4 Aug 2025 21:22:07 -0400
X-Gm-Features: Ac12FXxLOpVE8_jHsgmdL9P1IV1fatEHxntX4Df7ebET172mhlinXqqfWkqV01c
Message-ID: <CALnO6CDm5n0oZsXzvKz89jVg7E_h=1gqPFs2x7-UojdcY_Di_w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2025, #01; Sun, 3)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 4:23=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
> * dk/help-all (2025-08-03) 4 commits
>  - builtin: also setup gently for --help-all
>  - parse-options: refactor flags for usage_with_options_internal
>  - t1517: fixup for ua/t1517-short-help-tests
>  - Merge branch 'ua/t1517-short-help-tests' into dk/help-all
>  (this branch uses ua/t1517-short-help-tests.)
>
>  "git cmd --help-all" outside repository.
>
>  Breaks t1517.296 under SANITIZE=3Dleak?
>  source: <20250803012613.54086-1-ben.knoble+github@gmail.com>

I don't see the link in the linux-leaks job of a recent CI run [1].
When I build with

    make SANITIZE=3Dleak CC=3Dgcc-14

(since clang on my system doesn't support -fsantize=3Dleak for
x86_64-apple-darwin21.6.0) and then

    (cd t && prove t1517*)

then I get

    t1517-outside-repo.sh .. ok
    All tests successful.
    Files=3D1, Tests=3D392, 22 wallclock secs ( 0.10 usr  0.01 sys +  5.26
cusr  4.40 csys =3D  9.77 CPU)
    Result: PASS

So I don't think this topic is the problem. This is true whether I use
my copy of the topic or the one you publish (4c8db1e55c (builtin: also
setup gently for --help-all, 2025-08-03)).

[1]: https://github.com/benknoble/git/actions/runs/16706744996/job/47285921=
358
