Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846A5197A7A
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913424; cv=none; b=TpLKf2vLqILQHKiVtpOLS1xlN+jjxdhUpBu4ds+I6AEG1AGEAy30PufAyxpygcaiC7elRv15WoY0Ac04bV9Hy67Mqu8PtubYyWiRBDfFWVGEEmfqT2MRp+2dYKso6i3JEpesRLuXxDbrTho4howehFO272rNg54yZw6dLRaUM+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913424; c=relaxed/simple;
	bh=s7YjbFuyi4KMYAz3nODb3nRQCQeq120gAzdrIF2wXjs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9YjKScuZd8SP0dRdvziRuRZ/9YCUI1sAo20xLa0eR7YlJ1V8n1uK34lmAFGJGmM2hdaTxHNpCJUty3FXgYprNP5fMMZk9R7fYMJ6fMgVxE1eFNtr0iOdp2gOENdfvsDB3BItJbBfcNioIqvpg6IHYwwpow+anLPqpas7PIy9II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFkFohQC; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFkFohQC"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-51eb18130f9so3037238e0c.3
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742913421; x=1743518221; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s7YjbFuyi4KMYAz3nODb3nRQCQeq120gAzdrIF2wXjs=;
        b=YFkFohQClNJhDZIb9VeNaE0//O7k0DIJ3AohJg0HgJvv5sZvAXiXYytd2dw4DAl2WI
         sMNF+DLj/qyQwyPO5/kM5zTs0x/MWXW8e0mDS7luuSNOdFq5McPd5LImW2zxjaIahzVo
         UHEuyuI3VzdBWKTDJ1PeT2I3LifjNCpAUspd1aqv8lkKCcGRCyvhXiHVR57UI4b//ppk
         n9fbiIKWMsyKUPsG9btDAD+dvIRzbULwVxUmCRnGS3puCoIaFgeT3jWXpdlNrvAKt0gM
         nOz0jzLo6QV3fuFOmaL5jgHgknXho+S+AUovviG6Aoi67P9yCd4xzLD8qD5i0Bv+ldNm
         wXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742913421; x=1743518221;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s7YjbFuyi4KMYAz3nODb3nRQCQeq120gAzdrIF2wXjs=;
        b=FbpIN8C5nz+BFX39SwkFZcNABNtRDOT+v4AdzEi2COid4oUxofSTLObqcb6UX+bwIw
         QDLT/NI4KBN6d95lEHuuxSwf2MVhT/eye8Zoy4hH1tB0XvAKepo40O/+OgH5m2eHhkeo
         d8t2KAMcds3Bx4SQllPICwdeAhnU/cCxLYyTM1hQkimEIGWwvuJ2gM9Bc7aLrY99t+Hi
         a5Cb41FcdXtJHApnhsG/fGNoweD/71pHvBuFPoUwGh6rk380U/f4sg2QKykCx3vI8zXj
         XDI9uxlaz0N9zzCQUQeWoK028VmMiNF4sXZJ7AhJ2AHUpWv4EqzkQPaGsBcgi6VttFft
         iMnA==
X-Gm-Message-State: AOJu0YwZ8gVwdeq/IpkyZ1Sw6GEGHbTAxprVyPwph/lUSAsHlPt5kOwk
	DkrMFR9F7eaFfTNVuInryXnaNYLRMpzpPfxxZVrE5uP994BcvGiq4ux7g2Q+OjqJ5ycjxlLvji9
	ykk0kYxyrnMiZM1wqmGzCoOuT2vw=
X-Gm-Gg: ASbGnctkhPrW78nhH4S4h5kpjEiUzBlt5iKbdUD0MKl5iqZvt3P36zGMMNpZcYRwkf6
	btIDXqbqAJB9pxalG5WsCHvJVUSoM+LRfUn25cWatPJl0EEn4xjgSn8vOaJy3PGMq59SUkEmuFt
	K/75fP5hQa6JTFZe95YBK6k9kZq8aqwVB7wKJ2J5fwQgmCNFgphiPqk1D/1rqw
X-Google-Smtp-Source: AGHT+IF7xTIMLgD+aylazf/Sb1KIVD1Sq5wgDLhcBjnQJVdTgw/vYKn0LFKyIGggzoNhaRr5IQDs7CpXA2zYwWAp/2A=
X-Received: by 2002:a05:6122:da1:b0:520:5185:1c77 with SMTP id
 71dfb90a1353d-525a84de673mr12434092e0c.7.1742913421120; Tue, 25 Mar 2025
 07:37:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Mar 2025 14:37:00 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z-Kf9ovF8zAemgUP@pks.im>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com> <Z-Kf9ovF8zAemgUP@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Mar 2025 14:37:00 +0000
X-Gm-Features: AQ5f1Jqmm4PxpmRv__C_LBJf1sx9oWC0AhCjyHy1LotD6hVEQtqt5XKrNj2eRRw
Message-ID: <CAOLa=ZQqknrcrkc=kGsybB5TJPgxH5HKAtL3HMu1uKYkX0NicQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Avoid the comma operator
To: Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: multipart/mixed; boundary="000000000000574ed006312ba707"

--000000000000574ed006312ba707
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Mar 25, 2025 at 08:01:48AM +0000, Johannes Schindelin via GitGitGadget wrote:
>> The comma operator
>> [https://en.cppreference.com/w/c/language/operator_other#Comma_operator] is
>> rarely used in C anymore, and typically indicates a typo. Just like in these
>> instances, where a semicolon was meant to be used, as there is no need to
>> discard the first statement's result here.
>
> The changes look obviously good to me, thanks. The reftable library and
> backend also had several instances where the operator was used by
> accident, and I've gotten rid of those over time. They typically don't
> do any harm as the result is essentially the same, but sometimes they
> may cause issues. And at the very least they cause confusion.
>
> It would be great if there was a compiler warning we could enable for
> cases where the operator likely isn't intentional. But I couldn't find
> any, unfortunately.
>

Clang does have '-Wcomma' [1], which seems to be exactly what we want.

[1]: https://clang.llvm.org/docs/DiagnosticsReference.html#wcomma

> Thanks!
>
> Patrick

--000000000000574ed006312ba707
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bac38d2accef64aa_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1maXY0b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mKzZVQy85bVN5MEFTdUJGOWw2NWJGcCtubkhZQUFTVApjMHpVRjk0Uk1u
dFBiRTRYRjVTYWZQWENLOWNHSWFuTWNQeDQwRWd6dnBCSVVMRXNWaGtOUHhqdkp6NmFrWHV2Ckph
YXBPWllYSHcvZ0tmMXh2WnM2VDRreDJRMUdWRnp5RkplNUoyd0JjWi9nRDZ2YmppVzh2SkxoQ2lt
dlFNZlQKL0lYR3U3SXppUzl5TmlyKzNYOWZuVW9OOGZFQVJDb2F4WEZuNE9kaGQ2Zy9yVklHSWdP
TXhJSE5TaysxUjFiMgpYdUNiSm9XSXlPUEQ1T0wvZWtXUVRJcjluUnNoVmlFMjZla2VyZUtDdzFL
N0JiTEMrcEVYWU9udnJ4VDI1bTNtCnQvS255OTFwRUJEa3hpbUNFQUs4NVBoSVBLQ2dMRkVnTzhC
TjNGLzRqdXpHbTZONmZEbGRpejhVcmVieEptOWsKZXVuRG5NK3c2M2JKbi91QmlRRHNjRk5hcXcw
Sk9kWTJmV1IyUGlSSGdqeXRmOHNsR1hJd0tVeHRzcG9BM3hzdApROTFobSt4S2VSMUFjbE9GRm9n
dTlzVDVLSUROZ0RKVndNRlY1cmdJanVDL2tTQmlEMnllT09xSnc4VERJdDFHCjJMYkVjakJEa1Q1
ZUcxVWNyZDBoVTlDM3pmMVIzSytuTkFUOGN6Yz0KPUh2MlUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000574ed006312ba707--
