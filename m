Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBFF4746D4
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058412; cv=pass; b=hU7crQLKEme0WNk0ikNcrQdTQKSrZeE9/4iiWB3kFDmGR/AWp7v3Vzy1we6P6XGmCTEG0Y8NPxr8hvSth1/dK7BvReQApa+6VGmBo8/N8WgipbqTMcYwSUggSFCG3hBvLUN3wp2hmSysCNln6M4+gbUK+8aqSJKVOKHfWuJltbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058412; c=relaxed/simple;
	bh=XXe/AeTZ8mim6YxLONJIqU4PSumNbEzmiwLtrNzugbg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXs63BP2dFBx5B63baqKcAw/3FIpsVTR81mM2rMkM9NdkvCGQktHo7PYmOxLOn4nzuUFcJFMKw7NclTvwe0it7sTQ6jL6axyYckLKhOQbajTzqaNWMe+ysqhsuFj8OMlDuZ/Edv11ZdJv6rhyZTomT+QysInRp+Q4TzjwJAjmUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKtQ1jRi; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKtQ1jRi"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-96723c7151eso17769241.2
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 09:40:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789058409; cv=none;
        d=google.com; s=arc-20260327;
        b=MsO67pxuLMWWBcJcjT324eq7WLZO1kz7f0slisYgOzwDvkMLywRS3EGGKdeC+n2diM
         kiwkmTfjkxDn/FYpp2YC/34jtTXfk3ZcXcCi3gehX6FnqXuhUFjIcMuvGjUtoJ+NCtea
         P5wV3hcbTfiz5GJIkCqcjI8l4vlFKfK0iTzchQfZVmpDmP8H5qJ6Y3nCBvFs1ugLJ+OS
         aydD5LX0fyuOiCKGbqzn5epIpGcpzpbgP9ckHRgW1jWAbQzA9t4lcTj0tGltCNPJOAuy
         27H0UZjcMjREJ6VGP38ulnuOjTgTA8Ip5+KseIDfkT8Wnk83XSn5frRjtbQeaL0VGo2O
         UpVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=LypqwmkE9dIhwSSxMl5PnieOnS6RW72vNMbWa3ukw4Y=;
        fh=zK1xbS/Wm9rq8Pz5yO3XjFsLjFla8VoLLCLyDrk6NTY=;
        b=HHaC6MRvVD7BZKRQ2YHofcTe28XphWBsOOpxtoHsL0J5HGgS462yd8nmrPEg5Pz6Yw
         LliiS8PNPNKsymB1sLjUwTBzdwkxacTbB4ST7wT/rTED8qCgX6/DG9VrjtPjerByfCdA
         kSnH1rUdei6XezZwYCLYOeoC52c5MK3Ai4UY08FWMObhCoWfagyYqQTYYk2bq6hcGBQN
         AM2gnSPwWPMhrq2KRwp2bHzxJjc94mlHyc/tfRa/wX/lmBl1VLzwA05rtPCIfJjnnpWK
         ZdC5iQLKkvK3osZhqyhVO/0b09vPre8w0DEuE2PypNO+paHagRJqQ9HV0UAaDAjOQSR1
         4tMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789058409; x=1789663209; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LypqwmkE9dIhwSSxMl5PnieOnS6RW72vNMbWa3ukw4Y=;
        b=RKtQ1jRiEp7LFfkUtnOE83w0iot+uoDAdVuzefdgTdN5+GPjpaYu1hXlWeqL5oEmFQ
         c+En8sslLg/eeGSNw2zBTmVDG4RaepyX1go0Zt4RJZXYa0kJYtQiqRp4wCyayVBUtJxO
         AWHJDnwvlqe+UcqwBGBtcUy73w5EYmiIgl+n2YAMWmh3CDyl5L2oGPQtqIyCWtDgt1/F
         F6NADlW8aCWB9goY+P1GUKpVE8EE/MocpeH9lkWNVtju5mPSVLrG6hkclvHbxCkc/x33
         e7d0AkTkeKI0eTyh2K86KLlbearDKkdXa3X1jZV+bnZpZEpZaFTkmkC/T0AmyuCLco/r
         PilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789058409; x=1789663209;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LypqwmkE9dIhwSSxMl5PnieOnS6RW72vNMbWa3ukw4Y=;
        b=SoLAYoiorIWOOd+ZYbftGuDv3kSSglggEby9zKlMnPA3IuVVZIaO9jpq11hJZy6Fwy
         cQ2O/jeiqZljO1ZPtvOPPb2MiCQvLp1KjMUvT8FmwdBDFPj/VpM2UvOg/us+AKtFLkxX
         ua7/7zySigICHsY4XUYDhT2I/F3j8KdU3H6yZYI46vsHdF6U5A7m7/Z1BuhKyXGNcQoa
         Iou0aQ6ry5Y7Os1iHvofEkeHFFr67ELnK7V3XSbexRNpAUmKvMToWMR/8H2yJLzY/YPK
         KsYxN0FiIziBki7Ypr6DMIDdL+7U27EehsD+kGx4lkt4U2LQdO7DjvcuK1ROqkkctSxM
         wz+w==
X-Forwarded-Encrypted: i=1; AKwUvBykEjlELxJhEIxTC/B7hM+CY3voWUfmfc3qBS0vtmaW66xSXcoOB2tS57P0eSvFhgkDXas=@vger.kernel.org
X-Gm-Message-State: AFuF++lSoAKoB2DRGqcd4PFNVXAzIFJLbPTdxvHejxUfjuf2Wtr0U9c7
	VRkOxqayyM3G1Su4KAzXzZgLkEJiGBrQhgq/LTh95a8e0udilbPg5TbIgkVyykb7YK3nMgfXHWt
	hMqcfjfaa7HeTQ4EgcMB+h93nP69Hu2k=
X-Gm-Gg: AYBFou0sovpEaYLPv45HBJjNECA+ssnjxIVgIDR0Rk3WfnMPiXSST5i5iA4yYRmqiL0
	UiiCn0fyKH1xk0lA3Cp4Tp5TKx0uR2A+Mdtr6FEyCVTJXR+zSs/BYGh7nI+vKsmJqdtKKkmB6f1
	t5iF0D5u6Ahm557ARGsUahIiHEQNoJkSql4iZ7z7gnVK010Su5IOyTwc3WpVSICBGCyj5OcFpkW
	GPIHv4FnRKoBHMNgk1ipIaryOfSnnecaYWFGl9wMxyzgWqGNh7JE9p8ouUr4V7sSxxNFretTDk0
	HlCFtHYd6DzgXTQF2mQnlA+6XSZikaKb38g3VAW2oj6J9Dcxs7zIwSXin3yqPiaYiFOYrDVKWaz
	Q8o6fTbuu8szUK9zwRqDYEPDzV+hoxrvYnMv5Sd1kMLvM/l2C6qs8i0Y=
X-Received: by 2002:a67:c982:0:b0:785:76cd:ce88 with SMTP id
 ada2fe7eead31-792a54a64d2mr72378137.3.1789058408984; Thu, 10 Sep 2026
 09:40:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 09:40:07 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 09:40:07 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260910040214.GA240960@coredump.intra.peff.net>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
 <20260909-758-introduce-hook-v9-0-3043d417e0ee@gmail.com> <aqF0mbWgYU5rMR-f@pks.im>
 <xmqqh5jys5mx.fsf@gitster.g> <20260910040214.GA240960@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 09:40:07 -0700
X-Gm-Features: AcwNN1VD5BMl7eeecqfDJ_UGbGjafxCTcKfwZkHHFwF4439kZmcTtkgRJrX0178
Message-ID: <CAOLa=ZSnbGf9pf9nPdt6vfje1VzC04Gax=svYBRKDTc_owR6Ng@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] hook: introduce the receive-report hook
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, jltobler@gmail.com, 
	kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: multipart/mixed; boundary="000000000000f3661f065b239e20"

--000000000000f3661f065b239e20
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Wed, Sep 09, 2026 at 10:20:54AM -0700, Junio C Hamano wrote:
>
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > On Wed, Sep 09, 2026 at 04:51:35PM +0200, Karthik Nayak wrote:
>> >> Changes in v9:
>> >> - Fix a bug where we were causing a BUG() when no report was requested.
>> >>   It is perfectly valid for clients to skip the report and we shouldn't
>> >>   fail when they do so. Thanks Junio!
>> >
>> > It's curious that nothing has failed because of this. Are we lacking
>> > tests here?
>>
>> The "send-pack" client we have will ask for report if the server
>> side advertises report-status or report-status-v2 capabilities, and
>> there is no way to disable it nor there is no practical need to give
>> a way to do so, so unless we are willing to write a custom client,
>> or a configuration to disable server capability advertisement, such
>> a test is a bit impractical to write.
>
> You can do it with a t/interop test, but we don't have any that push.
> This triggers the BUG() when HEAD is master plus the v8 patches:
>
> diff --git a/t/interop/i5800-push.sh b/t/interop/i5800-push.sh
> new file mode 100755
> index 0000000000..b3035b555a
> --- /dev/null
> +++ b/t/interop/i5800-push.sh
> @@ -0,0 +1,29 @@
> +#!/bin/sh
> +
> +VERSION_A=.
> +VERSION_B=v1.0.0
> +MAKE_OPTS_B="NO_OPENSSL=TooOld"
> +
> +test_description='push to/from older client'
> +. ./interop-lib.sh
> +
> +test_expect_success "create repo to be served by $VERSION_A" '
> +	git.a init --bare dst.git
> +'
> +
> +test_expect_success 'create commit in client' '
> +	git.b init-db &&
> +	echo content >file &&
> +	git.b add file &&
> +	git.b commit -m foo
> +'
> +
> +test_expect_success "push with $VERSION_B" '
> +	git.b push --exec="git.a receive-pack" \
> +		dst.git HEAD:refs/heads/foo &&
> +	echo foo >expect &&
> +	git.a -C dst.git log -1 --format=%s foo >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_done
>
>
> Ironically the test succeeds despite the BUG(), because the client isn't
> expecting a status report, so it happily returns while the server side
> dies.
>
> I think the interop suite is probably more trouble than its worth,
> though. Nobody really runs it, and there are all kinds of hidden gotchas
> in trying to build old versions of Git. So this is more of a fun answer
> than a serious suggestion to add to the series.
>
> -Peff

This looks easier than I thought, thanks for this, I will skip adding an
interop test for the reasons you've also stated :)

--000000000000f3661f065b239e20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 18206d816cbe6978_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xaTNXVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNys4Qy85U0JYeXdIY2pFRWk5bEphdEhSQzlqcGdmWQp1VDNwTndwYzRn
ejdqeENDV3FjWGN0eFByallxZGMrU1J4Qy9QNVJmVlFmMXRWTzdmQ1J1dGw4TUVDUVFVM3Z1CnY2
dWw2UnJ4dkljNWVHc3pZaklKY3k5V2ZHYi9wZVlwaysxVGROMERJSnhNV0srM3ExcnhWM3NxdG12
a0MyM1oKNTIzdG41UHkzSXBCWWtKVHBzTjBidWV6ekd0V1FYczgxZjNiQitlTi9IVmU1dExYL2Rj
c05DWmVPcTRoVENrdApIYUFhblh2WTI0UzdLZjVua1V1RDAzUWcvYXlJeDVPckE5WUE1Q3FqTzNt
OTdHd2tvNlV1cmlLNENyVUFYUWZ3ClVtQzlJcXpnb0hydU9tODZRZnR3ZkpZRVRld2x0MTZoVHNH
TUFuOVhmOGRrZ0ZqYVVWMzUxQXA1SVZJYzRlYjkKaXR3Vm9FMFVFcjhYRGtJaXZDU25lNDQzbDVh
VUh1ME40QU95bU5BRTh4ZzRKUnFzQkk4SGd5SUhJWFdLZ3VEVgpvNUFwdVQ1cWlQS1pvY09PYUMv
Qk9mcVkxcFdRRTgxTU5rZzNzSVE4dGNxOSt1ZkVoMUI5UUgzQ2w2RlRUL09lCmZYQlVFVC9pd0JW
NmlyN3NTY21tNXBDRFdMdE1kdm5RSGFJUTVwaz0KPSswUHIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f3661f065b239e20--
