Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A291DB127
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898693; cv=none; b=MMuVZDKCX2w3a0t7Y9qZZZKF/5Zq3Cs3skL2Yx2fGFw8MYohROEHwpWIaBglG9p5l+uJctap0bQFvZhQsdrwymQHkbdXoW7WtktQdirM0johbApMh/vcWE7hn2iEazhaAlLHH2COTyUSrGPen0jVT/DzpKC1utG+t2FiebQWnRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898693; c=relaxed/simple;
	bh=nBFDbltGANp3lltbI+uSJ8Yb4cp/fobCJDbAqS43OWY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D21YuJcWJR/l75A1KLjcgwNH7QWXQ0PfkspNd2rSXbAUpIbM6jUyc2AnPQHcOIuvLRnTdqA+Ppp47vIqmjGP9gI8I5WAWyBYCvfFAexIazpYWqETkgyVlq6d1N7GqdX5YvMSvTpV0p6bCI0Kj5qCXqagSdIXPXp5g4i+fvT7wqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJCwOGbp; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJCwOGbp"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5242f137a1eso2380453e0c.1
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 03:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742898690; x=1743503490; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7F7zWY1hyb6mtfaQoE+dRttaIukPwKyBUfgLTHCTiLY=;
        b=VJCwOGbphsRBpYChJEUq7Iq6ks1cl6ZJ6fNeOufxvONeCizlRuLILAZMGZyf6a3p7y
         huVWR+izTTDW9BmIZeKeTnXlAbGCDKSDFajerhJeAEXkoD+rfibzFZ/FPptqWtaXdUuV
         qG4vhaF2gYUxRSaWTB/xsLOUM6ZmYeAw0/gYopeaSkRCFdbmWw9SYDld8akjXE/N/i9s
         C8XX4pQIWQecvnKvzN4LQyC0drAmSiqU1lm81icFVrKajrNIHhPWKOiAxQLAOeEfBOqP
         nmymfrShRty8ZutZKbZ3nXBbswHuzIvohTN7LNjKLLD25/NgK1ZMds6+vcp9/Vr2fa8w
         4oIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742898690; x=1743503490;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7F7zWY1hyb6mtfaQoE+dRttaIukPwKyBUfgLTHCTiLY=;
        b=RB3CbwAUNHhNzBbDYQoYz81zTjatS0URsieWs4jHPEzcdy8PpSx6g4/CjmKtkbFi64
         6k6fEAZjMD9MS/TFuncFhQktHdNhun65XWGDJYy/jgIp4WSoJYjzKgDFA6ABABNquwdy
         Wowmagz6T2KL8v7IsDNtLhvJa/bvuZRfTGaJMOl8yLCZCP7Ge4+K8Yp+a9vvtQcltBle
         OXYLZZrWP//0+zQsyE2b2eV4LP6eHFEjDrNF2T6IcNtvIRFKt90B+LcYVp4qmK8S5rL4
         /9QY+spuZHo/YoxAC8+PBLCFWzB/8H5kT+Ab/bZ4Gvq18pI4JRJQ43xUa5CGhD9T9R/z
         m5Fg==
X-Gm-Message-State: AOJu0Ywe6lAOVkEd+qdzihTwyRGAJ3VKIP8EsPfrRR7v6jq4NhS60zSE
	Hw99ipGfhDcg5iI+Q2JYBkieBUFh7If0hn4ShuGUR/aS+jVJnXv9K+EHtqAbt8GFpWfzLxTIjd8
	215TeKv1H2ZP9AAn9bS8zkwGtJYc=
X-Gm-Gg: ASbGncv7t7o0XfNn2JaQSAxe4Zkq2DumccwO3nJjW9Bng6yBhUHZ058W4GtBGjeieHx
	3cR3uvgPd8K9BODm29UDsrcXPQUZOCp/Yv3sQrOLqL9/SGuoyZCL8C1xMb9c3U4cNU2MxMvLnKg
	jVXK/i/YkFu+ak5CbceGPOotEzMBEu3hgFHyHwR8rg21jsSELwp4j33F19Wm09b5i3Zz4l/gg=
X-Google-Smtp-Source: AGHT+IFe/0c/pKF6was7ohbobhqRGjBfUh4UHV9i6ERpGdMG26IRD5C/3ldkL7yEEP/AGMVOGDS7TWgANEJIQmSSUCQ=
X-Received: by 2002:a05:6122:4312:b0:518:865e:d177 with SMTP id
 71dfb90a1353d-525a8560bc1mr10742373e0c.9.1742898689864; Tue, 25 Mar 2025
 03:31:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Mar 2025 06:31:28 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <875xjxwlb6.fsf@iotcl.com>
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
 <xmqqzfhbrb78.fsf@gitster.g> <Z-Ew_12NWX_5qATN@pks.im> <87a59aww8j.fsf@iotcl.com>
 <CAOLa=ZTHb6ZFmpDpSwzUTiDs44gY-W3aqBooAMyORK8Xs3YQxQ@mail.gmail.com> <875xjxwlb6.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Mar 2025 06:31:28 -0400
X-Gm-Features: AQ5f1Jo89ir0BhiYNFWDm_qrbVzBJhTm9Mrm9IC-SdhatpCWd4l_Brtr7V61fi8
Message-ID: <CAOLa=ZRZB0hidGGvepOQFaMaHbBqnGO_Qh38vqBZFvScbs4xzw@mail.gmail.com>
Subject: Re: [PATCH] blame: fix unblamable and ignored lines in porcelain mode
To: Toon Claes <toon@iotcl.com>, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000004a17460631283907"

--0000000000004a17460631283907
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> I'm curious, how would it be different, if they blame down to the same
>> commit? My understanding was "unblamable" and "ignored" are tied to
>> commits.

[snip]

> And now with the `.git-blame-ignore-revs` file:
>
>     $ git -c blame.markUnblamableLines=true -c blame.markIgnoredLines=true blame varint.h --ignore-revs-file .git-blame-ignore-revs -l --porcelain
>     d2c1898571a6a2324593e92163e8754880e0c1fb 1 1 3
>     author Junio C Hamano
>     author-mail <gitster@pobox.com>
>     author-time 1333493588
>     author-tz -0700
>     committer Junio C Hamano
>     committer-mail <gitster@pobox.com>
>     committer-time 1333495484
>     committer-tz -0700
>     summary varint: make it available outside the context of pack
>     filename varint.h
>             #ifndef VARINT_H
>     d2c1898571a6a2324593e92163e8754880e0c1fb 2 2
>             #define VARINT_H
>     d2c1898571a6a2324593e92163e8754880e0c1fb 3 3
>
>     d2c1898571a6a2324593e92163e8754880e0c1fb 6 4 2
>             int encode_varint(uintmax_t, unsigned char *);
>     d2c1898571a6a2324593e92163e8754880e0c1fb 7 5
>             uintmax_t decode_varint(const unsigned char **);
>     d2c1898571a6a2324593e92163e8754880e0c1fb 8 6 2
>
>     d2c1898571a6a2324593e92163e8754880e0c1fb 9 7
>             #endif /* VARINT_H */
>
> So every line now blames down to commit
> d2c1898571a6a2324593e92163e8754880e0c1fb. The lines which used to
> blame down to 554544276a604c144df45efcb060c80aa322088c should be marked
> as "ignored", but we only emit the details once for each commit. The
> commit details (author, committer) are only relevant once, but the
> "ignored" info can differ for each line (as you also can see in the
> non-porcelain format).
>

Ah! So if a rev is ignored via the `--ignore-rev[s-file]` flag, then the
parent revision is shown in the blame. It could happen that in porcelain
mode the parent revision is clubbed with previous lines if they share
the same revision. This would skip the 'unblamable' or 'ignored'
information.

This would be solved in '--line-porcelain' since details aren't clubbed.

I agree, it makes the most sense to only do this in 'line-porcelain'
mode.

> We could make the output look something like:
>
>     $ git -c blame.markUnblamableLines=true -c blame.markIgnoredLines=true blame varint.h --ignore-revs-file .git-blame-ignore-revs -l --porcelain
>     d2c1898571a6a2324593e92163e8754880e0c1fb 1 1 3
>     author Junio C Hamano
>     author-mail <gitster@pobox.com>
>     author-time 1333493588
>     author-tz -0700
>     committer Junio C Hamano
>     committer-mail <gitster@pobox.com>
>     committer-time 1333495484
>     committer-tz -0700
>     summary varint: make it available outside the context of pack
>     filename varint.h
>             #ifndef VARINT_H
>     d2c1898571a6a2324593e92163e8754880e0c1fb 2 2
>             #define VARINT_H
>     d2c1898571a6a2324593e92163e8754880e0c1fb 3 3
>
>     d2c1898571a6a2324593e92163e8754880e0c1fb 6 4 2
>     ignored
>             int encode_varint(uintmax_t, unsigned char *);
>     d2c1898571a6a2324593e92163e8754880e0c1fb 7 5
>     ignored
>             uintmax_t decode_varint(const unsigned char **);
>     d2c1898571a6a2324593e92163e8754880e0c1fb 8 6 2
>
>     d2c1898571a6a2324593e92163e8754880e0c1fb 9 7
>             #endif /* VARINT_H */
>
> It feels odd to me only the "ignored" info is emitted and the rest
> of the details isn't. But that might be just me...
>

I'm with you on this, this would also require us to explain this odd
exclusion where only for 'ignored' and 'unblamable' lines we output
details on every commit. But the other way is also an exclusion, where
we would say that 'ignored' and 'unblamable' lines are only shown in
'--line-porcelain'.

But the latter can be extended into the former in the future but not the
other way around. So I would say it makes more sense to restrict it to
'--line-porcelain' in that sense.

> --
> Toon

--0000000000004a17460631283907
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 99bc29e9748aa08a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1maWhmOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM050Qy93TXNwTTJpZHJFbUdjcjAwaUhuTHAwUndQNgp2T3c1WGVoTyto
N2o5Tzk5OTVtY1cwUG1GaHZUOHJiRGhjOExFZ0tWUXZURi9WRjRuL1NsQnhFcE1SZUFVcTBrClA5
d3NSUnZESm1WSEhPbXRsUDVwY2RyNXhoTnlRWEpSMjNYRmdyd2djVXpkTHljdUx6YzhCYU5ZTHRi
L01nZ08KdjB6VnM2UnNUdUMxUXhVWCtxdjg5UkpwU01rZ0c5cUdZMXlaYVliVzduQjZvSWlvV2U0
SWl1NmNCOVFkNXpTZAo4c0t6cVp5Nmg0NTVxc3NZSHF6d3ljUk9CeDFtbzVPVDZuQVBpc2pRYnRP
UUZRQUdpTWtqT0dMS0pHQkdCVFNECkdSWlBmK3E2Z1JQL3dtRVpQVk5hdXVqckZvYkVMUlJ5RzFN
RDB3Y3NweGg5bkorUzBFY0ZDZlhvYngyTG1hTnYKTVV6dGFTQ3RzTjhrcDlReGV1VFp1bEFLYWh2
YkNzZUxSSFFtc09NelVKZ0dMdmJlK1ZycGxnaVF0UE1NaUJTWgowMXhQWWtHL0NZODcwUGJyc3k3
UyszalRIUExXVUw3OFJaVFk4amcxa1Ixd2xEbTVtbmMrUVRpN29xd3JWZnN1CnhXS2hYS3k1TExV
MWNSdDlOMkNUamkwYVo4T2piR0NWNkpGYlE3MD0KPTc3STgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004a17460631283907--
