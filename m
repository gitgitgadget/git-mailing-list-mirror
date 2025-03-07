Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D440192B7F
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741381325; cv=none; b=PQSmORVIgwlED3ZB4vag63XMsxMEnapqv3ME7yeeBFH11b5GrsN8pffQWjODr3ZAyktU5Ai9DkhdXNbrguoyRj8ovCTzIg4z3gUMqLaYBvuxQu6idFBURkEuNKo6pFvKrf45yy0rB53sYVaMGB72T4Wfrqj2L+KSXv2k7ctUP0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741381325; c=relaxed/simple;
	bh=Hi7DJwAIOR9FDFAkJ4H7M4i2CMNhEvXW279Ftz5uoFY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JShyeFx113T0ywv91aMDBnN/7YoqBL1sBbVefJzZYdCs3hal9aUcTVQyEGnLTvBDZqmMYwNpD6kyPYF7aRUWcbIZjtA2fCQUP1kMTIs+BBJ4jav8iLh9YiffdMqISolgb0iWK6nJ9wWsCuSx8MLeEffeAdLO7WPUmCWHkLFS0o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvHEjC0k; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvHEjC0k"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86911fd168dso930166241.1
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 13:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741381323; x=1741986123; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JplmOE8HRVLdCWHsMgXDagdrXng/7eclwpKsPOsXbtE=;
        b=cvHEjC0kGVeu3gMNfAu/dR9OMaaiwHljq85nDnqh7VnHHYcmBa6biaP5WmsiP7zXza
         RvgJYDGv+o+HnpYtBTICthvafz874weIYuNwY5/F6wv99BJOAoyRuv1Ln59pGkEAY5YU
         ohNGbsjghnrJbP49D+0+OvjReq3OhsMpPNyIXDvSnkPOQLc4l4F7oyoGDgXoJwEAhJGb
         DZLPLc5yv4vgHghlKNvaN6Q9fQEaBZrIMJngG8pSBcZ5BxBJU520ejb2h04wUv5kE926
         Ub1mVx4l6S4+XdG7aSy6LgGJCFA+M84DwC3V7lOsDUFZVrs2QXRhuzcdqKF45KZtII7R
         ecyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741381323; x=1741986123;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JplmOE8HRVLdCWHsMgXDagdrXng/7eclwpKsPOsXbtE=;
        b=lSog5mkxxIoaXGE+P2F93J94m6xCqGrtMjqxzxw5KhRRFhOJPBbYojDhsCYi1+UVVZ
         /TjwJSO3B/JCa8lmEYONAC6VZwswFmA9ZV7I5qnzzAMj0A48eys4JM1e3rbyjrEp43s2
         cbZRqeZrrtFLQxreC0qTJ/0P4GD1CFRiSy8sngUiTaOha/aA0Gh0SUgQ/PN72Rgmbq5g
         4TheoT1aecHAExVIkI/M5hQN5TZHWHYReF35ji+mcpwDEhsyPD1J87fuGuYY2D9bo3bz
         6yksiF+lv0HlNx85eaEvUG+M5MUvorMaYSk4cnHq7U9ButaUHaeE5t39QP1ikSpqSQ9o
         lq3g==
X-Gm-Message-State: AOJu0YymkEesHYaoZxfwtYMiQHWBl6wM2MWDrIOyh5A9lMtmhNrjL4RL
	fYvPGPRpxJpIrpGW7jiZlsTQb55tOwyxIZLPwOBEYGwyqn+mI5ES36ffQvTKdZ0ZM2QrPUWyeuy
	iJvBNF3+zIxOxMLZE3L1qYA6zC3I=
X-Gm-Gg: ASbGnctynZ9jwekEY9D/ir2LYXgE5IR8E/i9WJy0DgLOn6F7qdTMwJhgLVLS+ajsgj5
	OJ2uW4RvZBneOcUQyOU46DxTk7qPlR9T8EV2IgXDZtbK+oC8LeUlkljjPlcmRhWA273zUpkVZUb
	vPge2vd8ku2Z4ClSwDGu/Ja9eSB/l3nQGvjU4UTysNzXEpl2Icqod+7UpyFZMs
X-Google-Smtp-Source: AGHT+IEQuaL0rRio1faPv9Cn9ASFwc1nSp47545NNhaGnPWuLwnwJfbpZBoL8MYi1i9nkVN42CTJOG0zIpNOdhjLHIw=
X-Received: by 2002:a05:6102:1625:b0:4af:c519:4e7f with SMTP id
 ada2fe7eead31-4c30a67b918mr3395667137.18.1741381322834; Fri, 07 Mar 2025
 13:02:02 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Mar 2025 15:02:02 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250307195057.GA3675279@coredump.intra.peff.net>
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
 <20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com> <20250307195057.GA3675279@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 7 Mar 2025 15:02:02 -0600
X-Gm-Features: AQ5f1JqiwWx_dVaJ4YqlE_utMZwCaN10Bx3M5Inp5ApDhM08SBqs58TEVmfSvD0
Message-ID: <CAOLa=ZRXZqE3ezA_ync1Z68sZfquSK2xCOKogNHc8unNcJpvbw@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] refs: implement partial reference transaction support
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="0000000000002ac52c062fc6ef80"

--0000000000002ac52c062fc6ef80
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Wed, Mar 05, 2025 at 06:39:01PM +0100, Karthik Nayak wrote:
>
>> @@ -1456,6 +1471,13 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
>>  					    update->refname,
>>  					    oid_to_hex(&update->old_oid));
>>  				return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
>> +
>> +				if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
>> +					strbuf_setlen(err, 0);
>> +					ret = 0;
>> +					continue;
>> +				}
>> +
>>  				goto error;
>>  			}
>>  		}
>
> This new code isn't reachable, since we return in the lines shown in the
> diff context.
>
> Should it have been "ret = REF_TRANSACTION_ERROR"... in the first place?
> I think the "goto error" was already unreachable, so possibly the error
> is in an earlier patch. (I didn't look; Coverity flagged this in the
> final state in 'jch').
>
> -Peff

It should have bee `ret = REF_TRANSACTION_ERROR_NONEXISTENT_REF` and it
should have been in the previous commit!

Thanks for reporting!

--0000000000002ac52c062fc6ef80
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 38da0fe983dc78ee_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mTFhzZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meWtjQy8wZHdFUEJxbTk3eHZPQit1elFtQk5ZcXN2TQpVTjR3Z2lzdlpJ
U1NqaXJjNEJWKzRxTENDQy9yNVNEcnZyN0VKbkZVOU5KU3BVVFlqdVhoWGNJVm9BcGZyVVVGClh1
aHltenp6RHJMZGRTTExmTk0waHpVV1VEOG1UNkRzTjdXNkwxYndqcjE5QUh3QzVSVlJNTzM1Sk1L
cnFZRWQKOUpIREFFSFlueE5LRXRkNjdsa0JBSGhERjJVNERpQ1RCNnhWdFphbUozK3YvUWF3N3BT
WS9IcnZHTnZLZjltQQp4RWJISWNrR0tVNFdnQXhPRy9WaG1qT0U0SUkyZDBTZ3ZWa2dPd1JoQlJi
MUY5NEo2aDRaZkU0QmdCbWw3OU1uCkYwaDg1L3Q1SkwrOFFic1VsQy91ays4dDV4aFRkMVlXTGls
ZXNoWG9DRVZGczVIbDlhdytRVFFsTHBERCt1WlYKd1ViUlFKODRtZmxrSlMyRWM4N0pDTyszU2Jh
S1Y2SmF6eXZsajBOWEJicFlwSDl0ZlJPQmFvVGNZSEh2elN4WQpnWG01cklGek5LaU4vSnpGNU1Y
dDdLSkJpV3F2dGlyc0llSll2Vk9FN3VvMGhqQ2cwV1pqM0tvekNpbGJXUzRsCjBEMWh4V0xvclRP
WFVEdkxUczNvaVZnREJQSS9DTkM3VHVjOVdrcz0KPVZIQU4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002ac52c062fc6ef80--
