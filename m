Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5996D26AD4
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490705; cv=none; b=iC4SyokF6xywgTRYBYUnwu/zgCH+3+MtKZLVyoj+YDq+DC9xx+9bv7kk5puag/+U3ASSyAOY1VZkaHSGXOdRQUyWzyUvrb2c5lHa8++FpU+EelKR3uaSJyHxox43Cy7Izn+V+gcDB0vRcKtjh7eC9x5B/LA/nNQSayax6yfnoPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490705; c=relaxed/simple;
	bh=kz+rRiNktBI1ABfvpbdeu3Hcj/hib5BaS6oBKQXShyU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/JZs1Oqh+nqaCHrT1nKFE7DaDLB/FYb1AE1H3ZVFAqsvxX7E0NwMhYvt+ve6hBwSbDvWoXAMOhzvfawCGRHkE7kZuN1FaGw6vbgC7BZqvpQFKpCYFrcU9y9UaqlYZD2GBw1rmkBrpEpQYEF3Vxr3jDk5GWGxJdbSPAsVs1VuMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RK3qRXbD; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RK3qRXbD"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4afacb253a3so542757137.0
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 05:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733490703; x=1734095503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kz+rRiNktBI1ABfvpbdeu3Hcj/hib5BaS6oBKQXShyU=;
        b=RK3qRXbDBAELvcwaCdKfwRQ/TneHOki7YGBtE23ZglhQmrsWeVrvfLWNv4y/9yMWUP
         amqGBU4TdqPV7WGcVvILL1sYR7IAleNWmPVzgcuUckUQ10qkwqVQvlY73xWPnatwBzcQ
         mBiI7Bg1fiNvHPnQT/ub0Bv/h+Ou6Nopk++sXlguVx3ngMIM5y4PJdRBf5f/0QuEIo5z
         CGKN7RxtrHHHpBDgiu10fW6eceKGCQJvAOw4JTgw7oYEl4DIHP2pBClDWPoYrx+HvawH
         lF/VKd24dsYiXnhtJD/2WlObUGOzTpxn7+ymodd96ccK0/rsW+5D/t31mmsluupjiCc6
         QyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733490703; x=1734095503;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kz+rRiNktBI1ABfvpbdeu3Hcj/hib5BaS6oBKQXShyU=;
        b=qlBW2gAvfRM18AKOwmx6NV+2zdAHo0qWGUFGkH/V533jLb+Q6AIyRuWVP+XXmfSS2+
         ZSOtXJZWBNNnd0rpRA8pdyiU/6KS/W4KdZveesklTiBZxCfvA6W8N0/EuKzSEstozxaQ
         la2BSsxIoO8Zl/D8Dd5m8SRawDAyLq+GQNwqAHeQK9SiPCHMNQupjgJbBSMnOq8SZLHv
         BVnVMNvdrmV8T/58Mtm5j2/PGhi6b8ZRvOc2zafQIQMjhO0xthd1xLX8BohpdjFoR0nA
         +r7iW5w9r7Md8r1UQJSCDorWpTay+sR76mcCRIFrf98zK/Q5j8TXjHfHle3OulwsH6z3
         sZvg==
X-Forwarded-Encrypted: i=1; AJvYcCXQDLlm7T0/I2K3p8OO9m7Hw/jwFspCTnM8bD7XW9HcMRKxhW8lFBOpO98vIB60PD7IS9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YypPq+DxZ9mNJzJAHtP4iZ5GVs3JO4vo3DLmtb9g2QLgpnUB4+s
	X0EoH3szH14z5YvM8opaNEisPUjqXdbdRAWj7YkDLZFippnl6GomOYf1shG6fER4HwY8SjrdDRd
	DZnq64ty54+DXnX3BbABL3OW50Ik=
X-Gm-Gg: ASbGncu7KBqhxfAvaF/6aASH2kR1Gjiqw0X2AUvJ2HaoLqWaur4ID0dlhvNxBOWdRjq
	N8C3gx78YShJPRprlb9vnTBNoXkEAAA==
X-Google-Smtp-Source: AGHT+IGJGqWRnsobU0E/SfhIqBh3CeyFJkZBBgTW1Er0cRdLM4RXYDsHW/BdtyTnvzeXsyb7QXP+WAPRKUczY6nWlJ8=
X-Received: by 2002:a05:6102:5127:b0:4af:c31d:b4e8 with SMTP id
 ada2fe7eead31-4afcaa8a77dmr3000923137.14.1733490703219; Fri, 06 Dec 2024
 05:11:43 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Dec 2024 13:11:42 +0000
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im> <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 6 Dec 2024 13:11:42 +0000
Message-ID: <CAOLa=ZSLEsfDLaH57enc81FCqLMPvgDj1+-fdsMHOVip5W2iLQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] Start compiling with `-Wsign-compare`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000966079062899c1bb"

--000000000000966079062899c1bb
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> when compiling with DEVELOPER=YesPlease, we explicitly disable the
> "-Wsign-compare" warning. This is mostly because our code base is full
> of cases where we don't bother at all whether something should be signed
> or unsigned, and enabling the warning would thus cause tons of warnings
> to pop up.
>
> Unfortunately, disabling this warning also masks real issues. There have
> been multiple CVEs in the Git project that would have been flagged by
> this warning (e.g. CVE-2022-39260, CVE-2022-41903 and several fixes in
> the vicinity of these CVEs). Furthermore, the final audit report by
> X41 D-Sec, who are the ones who have discovered some of the CVEs, hinted
> that it might be a good idea to become more strict in this context.
>
> Now simply enabling the warning globally does not fly due to the stated
> reason above that we simply have too many sites where we use the wrong
> integer types. Instead, this patch series introduces a new macro that
> allows us to explicitly mark files that generate such warnings. Like
> this, we can adapt the codebase over time and hopefully make this class
> of vulnerabilities harder to land.
>

I tested the changes with clang and GCC and everything seems good. I
went through the changes themselves and have nothing to add.

Thanks

[snip]

--000000000000966079062899c1bb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e63d14eb8111d927_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kUytBMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNldFREFDSCtRWnFWUmVXbVVkRitOcFhwei9UeG5PQworcEJWeUZ0R21a
ZnBSaFR1Z2FXNjQwaEN4UkljOGNLNlk2aEZ4S2tpUHNmYlZwSlk1TEoxSTQwNzhtMjJtQnRDCmdQ
aHd1a29Pc2IxUjhIWW5Za0lmQTJVNmhRbTNEVzVvUjhNMHFlRk8yUk1kbGdmbHJ6SlBZVmJTc3Bt
R2ZJekIKVFNLdndqRjZrR0ZiMzFPV3orQXVqOWxzVktQN2Q4S2E5RmRzWWRzUU5NU21ubmc5MldG
M1huQmxFbFhCMnphKwpJWlpqOS9nRWltNk1xdDNBbEZyUDFCZUpZUHNMMHl6MEdTS0JoU1E4RFRp
eGFBUFJmS2FTZzdiY3pVWlJXakRDCk5WRHZiNUw1V1VwQkNJL2JNTkF1YWw2SG82TDNUWlFTMHUx
R002QlRvb0hOdS85TUtkSU5od1BnT0VITy9OZDMKdnBuVVF0SnZLWUtKekV1WS8xS3lZYTljMkxR
ZjRXeEl3RjQwNS9aZEVHcUpSUFRKOW0rbCtZd1hwdGV0REZLNAowdUpHVEZVTDd0ZnE5TzlVdGFZ
WE03a1VCSzM1c0Q4UitBTTNHZEdxL3NWbFdyVEVGUUt5OEo2MzNhSXc1MlVPClVCekJMWThoMEJD
Z01CaFlCY3VBZnBsQVJiUm9uVjVHMFpCeFBWMD0KPU9ZM1AKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000966079062899c1bb--
