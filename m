Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEC315534D
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519198; cv=none; b=kOPfz4rrSbDxymqreVSrXBDK4ew7YY0YKhKxvOcTPDOtg8K0nVMBZcqmvNHj85uXU1IRo/iiiwo75RwhEBFc47ihMX3SJ0Q94Cmt35c0TNHkNrpsNU1FoPftqgk+HJhlgiW1fqI9SPUFQKP5a6etA6WJ9KT9iNCC3IWydd0uV+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519198; c=relaxed/simple;
	bh=FnWhNNWmRL2+Whs1Z0Rnim5kJynUUX5liJi6Mns1UGw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7vxqfTUitIGcsSNO1dIq4268eSdyl8kPj/aaxjlxHbrMTuUuvFcl4wkmsQkQPhHmwtPsLqAGdpsK7s0x5ibiJqi7bqT52LYrWZ9JefwNsreYlV5YlYEY/JBfbp5ssghJrCCU7AvePcLfuASBdHKQQkLNA9Pl6mZFT6CevzkF7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcVf3qhM; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcVf3qhM"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-25e3d388580so2821937fac.0
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 02:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720519196; x=1721123996; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KjLwvyVzLAeFtcv8IRLn7MCSyhcLbsJVFlPAslocelM=;
        b=UcVf3qhMMdTQHo7/xdIaO2Ibk6FFXBkDcYPcjIDQKB3Bb0thZ32LWyPXdhXJU9H3wK
         1f5EIFLr15vzkTs+b+jgIecdp1NHHrukQ6vi2NM5GuyNJYsAA0ubcUA6ayWt1O83DFCN
         vc8m/iApKxeD5/Hu/QNMlXqY5RDStRfhaNbg6Z1n/inzOY8O/ZeAu6GoNghbuFJX4eB3
         R5vrDuaUpjIbwxYxZUFXtVgujN5XHBQHExwW33PluWRB56I5FgxajSRNzvBv2loBHocx
         S/LVpN1E2G5nKTr7jyqBVhORH2yF7ey9nNvCzSSVeB2U5rjvzsAe0d2I5E7RhwCxY0Gt
         Xisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720519196; x=1721123996;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KjLwvyVzLAeFtcv8IRLn7MCSyhcLbsJVFlPAslocelM=;
        b=oQYN4QN/s9mAFM03c1Y5g+tgohmtQOPl2W1EhpQE2/bNLme5qlyB1N+XpqlTpeQJjl
         /Rj14xPqTKGGWugkpwPSxeWsjHeM5pJujXJcJscoVdUgMBcj1W1ddnwtAEt4CLTL2eMe
         G+yMCDK5/CzT4JxfdIJr5aZg0zt3Hd3dJbddsHg4aYeFAbESn6zf/mCyMZyFJ5W1nEuo
         OG50A1BZlqMJNrsz6DCogjZcVpJ5JdBuLYAURAUXPrZr9s1eIZwuTw17Ab/zMju+/CCq
         xbHDJxFPrTTOKXCdHxxGaFAuDEVLT0EVqFFEekcamUGYWA2S2WqUa622Tp3zmvTC/XYH
         d69w==
X-Gm-Message-State: AOJu0YwhhYWHigjsKLi9hUmPLHHpbHIpmSr76edS3Ub/F5g2UdjHxxk9
	QOFbX1vCSR1t2lSq56jfA5StvouTIpky5btC6xlMN6nwY0sGeJJKi6FhFEOCjryNOoaMHxuprga
	YM7zM3OSpMm2wk2fQWykksjxNTQE=
X-Google-Smtp-Source: AGHT+IES6yyJ2PWb5ShjuNN/ZLLzWI5rcBOrCf3DyrBl2Jkh8EIYbttrK7TGm44A4swHrJNPf4fAyew2pzTDU6ZiD5s=
X-Received: by 2002:a05:6871:1c8:b0:23d:225a:9443 with SMTP id
 586e51a60fabf-25eaebc7d8amr1417242fac.41.1720519196379; Tue, 09 Jul 2024
 02:59:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jul 2024 02:59:55 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqsewjelrh.fsf@gitster.g>
References: <20240708140350.622986-1-karthik.188@gmail.com> <xmqqsewjelrh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 9 Jul 2024 02:59:55 -0700
Message-ID: <CAOLa=ZT6kmP=z1FG_aoZfEnZdqtW3Hmy8D9WsJrM55CUNioCoQ@mail.gmail.com>
Subject: Re: [PATCH] builtin/push: call set_refspecs after validating remote
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, peff@peff.net
Content-Type: multipart/mixed; boundary="00000000000087a6d5061ccd976f"

--00000000000087a6d5061ccd976f
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Since 9badf97c4 (remote: allow resetting url list),
>
> Please do not be original in places where it shouldn't matter.  Use
> "git show -s --format=reference" that includes the datestamp to help
> readers judge how old the problem is.
>

Will do.

>> we reset the remote
>> URL if the provided URL is empty. This means any caller of
>> `remotes_remote_get()` would now get a NULL remote.
>
> "NULL remote" meaning?
>
> If you have this:
>
>  [remote "multi"]
> 	url = wrong-one
> 	url = wrong-two
> 	url =
>
> and ask "remotes_remote_get()" to give you the remote "multi", you'd
> get a remote whose URL array has no elements.  Is that what you are
> referring to?

I was referring to the 'struct remote *' being 'NULL'. I think Jeff
explained this in his email reply to this.

>> The 'builtin/push.c' code, calls 'set_refspecs' before validating the
>> remote.
>
> There is a comment about "lazily grab remote", so it is very
> understandable.
>
>> This worked earlier since we would get a remote, albeit with an
>> empty URL. With the new changes, we get a NULL remote and this crashes.
>
> You'd really really need to clarify what you mean by "a NULL remote"
> if you want the proposed log message and the change to be
> understood.  The change made by 9badf97c (remote: allow resetting
> url list, 2024-06-14), as far as I can tell, can make the strvecs
> that hold URL and pushURL in a remote structure empty, but it does
> not otherwise destroy the remote structure, or nullify a pointer
> that points at the remote structure.  So I am completely lost here.

I will amend the commit to the following:

Since 9badf97c42 (remote: allow resetting url list, 2024-06-14), we
reset the remote URL if the provided URL is empty. When a user of
'remotes_remote_get' tries to fetch a remote with an empty repo name,
the function initializes the remote via 'make_remote'. But the remote is
still not a valid remote, since the URL is empty, so it tries to add the
URL alias using 'add_url_alias'. This in-turn will call 'add_url', but
since the URL is empty we call 'strvec_clear' on the `remote->url`. Back
in 'remotes_remote_get', we again check if the remote is valid, which
fails, so we return 'NULL' for the 'struct remote *' value.

The 'builtin/push.c' code, calls 'set_refspecs' before validating the
remote. This worked earlier since we would get a remote, albeit with an
empty URL. With the new changes, we get a NULL remote this causes the
check for remote to fail and raises the BUG.

---

I hope this makes it clearer

--00000000000087a6d5061ccd976f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 372148010c3353d9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hTkNob1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOElVQy85ckZlbnVQeXd1cHBTUDZjT3lUSVAzbEowTQp4Rk1yQURpakFV
WDBHcmVBVG1TOG5iNzR4VEt4aUFCY2pBbFdXb2ovZXJHQjNHSUI2alpyeU15U0pLUXVLYUNwCmxl
RXZGZWFNdHlqTVlhOThKbFVJbEJwVVF4cFp2SVRBR3E1QXRIUjF3aFNoWDdkemVpSW8vaFJqeDlC
aTE3OHQKSnVZV1hyZjhlQlJMME9vNC9JTk5Wb0IzVTVIWDl5OFN6a2Vvb0l1N01idi92by9ueEZ0
cUdoK1BMUVYrMjVSawpyVXdCNkV5aHJ4OGdEZ2tWTmFUWXBLTHdUV2MyOHR0eTlLcXd0ZEdxa2FK
NXFwU2dRRVh1bVByanFhTDE0ZkFPCnJpcDNheTg4VVhzZmR3T2ZUN2xLYy8xOHVQM1VvenBOd2Nq
dXB3Y3FNcGdGbmVGenhuVytCK0VyRnN0TXZvVU4KUmxZVm5ZOWhnUUlCQUp1d0lNL1JzQzdUSTdq
N0tZWVhTZnY3eDBUMTVPdVZzUEJKZ2NycHhHUDRVUEVzcmRxLwpHMi9wSk1CZ0lNTzVycG80UFVO
NEpOdTdpTGFlRkoyQzJMLzQzM3ZldGRYYm1nblEzY0wvcE5iRXVtUkgvek0vClRWQkJmaTlJSGdG
WVVaQlk0MU9ZWFhPZ29pVksyWlo0N0I2U0M4OD0KPTA1WFcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000087a6d5061ccd976f--
