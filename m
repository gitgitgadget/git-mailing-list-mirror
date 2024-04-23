Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D43560B9C
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869342; cv=none; b=fjc3RyOpHcZ0oeYMGnOlTw5stweGJo4wLEBCqhwQ6SOiJaj1ykwWa8O+9G6VePyJitxKja7/cREdtpqOoxGas2w46cCxbV4D3xrN1GYjN3bSBokBU4r4qiPYhNQdDgplGBIUfwOMt7Yem27Ef196eQi/VZASgtIDUlCffZW6rMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869342; c=relaxed/simple;
	bh=v4uMoQA+c2tIIsOVFO3z6BBBgvbQcOqONaTIs5AmJTs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7V/8og0GVajZ9aSwXP6RVqe7dav4NAE6ibFHj0Wrvbd5qfSACc1QRJ/MswFR1wQhQaUoiPpaHqd5RvGVewlk3u10caugzXzGMsEhzJUzcyAj+pQ8LFaI/VRKFylZm8tAWnDVZALx69vQEhGHiBKOYzW49WIplIsRho0Hk5538g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZmoBP+6; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZmoBP+6"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ea2375d8d0so4392397a34.0
        for <git@vger.kernel.org>; Tue, 23 Apr 2024 03:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713869340; x=1714474140; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1un+f4V0gPq7ly3q/AYkAHqd28yHr+CcsQPXzE1c9w4=;
        b=HZmoBP+68H1g5E6vtLIfqEIhfXwxlNIchuXmiU5PtCrNG6vDaBnJMffkN/wa1HCryu
         RKdaf2/Ln+g9v3nGmFQaceWpnsNaaqfL1A+OsFafUgLnQfFoqPxmi+npF8W3AkctHrWD
         vZfdqkg5KjnMF1IXOFdUW9Qb7k5cj7bjMwm+X755LHuVFVY8EzIBOEHxhPBNpmCktON7
         BLlKpEl6pD0MvsqaMeY2U6qbE7RRXTkNuiVoAr9rk3ARosCUxq4XhD0n2kiXJgbgZV5+
         i0lFBRxWPj8hE3z5pxEJXPf9E/F7S8tHP/Q73qCOJUGVyomYubal4HmCGCgXuonECO09
         x36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713869340; x=1714474140;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1un+f4V0gPq7ly3q/AYkAHqd28yHr+CcsQPXzE1c9w4=;
        b=bArfHGx/jZT+q1tbFVtnPdnEAbmOv5w45mH945Oi1Xv7GXAJ9yKbn2tV/Go9IRjLW3
         TsZcTW61GTW2wmiRzots1jXdB9rSiCkDBhCL7Ew6eGQyArM/lCUW5VNJ0G2s9bSXXw/B
         rX0hsB99MR3e3Wjfh2G0wITffCWgzh8XlC4uTl8zN4VD3f/Vlb9NeTJrDp/iGgeyoSlr
         5quYJ4RuV8JVSa8qDLPnuDWKHzXs3d1rgtUBrsAJCw9UW5NW8NcAPc7b8CUYH9uABoWU
         ITBsqVw7EKXwOFNDiF/AWzfF0uOuBSXrLepGBG+oiojgZ65vvNQCn78Ty5PWY//o64rH
         jqJg==
X-Forwarded-Encrypted: i=1; AJvYcCUba/nuo9YGmmTpqM98A5RQ2IqDx1q91gTibdsDtDzDGPHFkSCXUSltjq8IysMS4OC4+352kUS9zXBEOYQhO+M8uOH0
X-Gm-Message-State: AOJu0YziAxot4vz3uh3jUcAnXzUvG0ut3EvYsfZkRRhmka1trB+m3z2e
	MM8iJuVfuijjDuY98Eoh5uu361cybJexX5/5pGc9rcP6UUQRFGWyWbMjSwTqVwEYZOJfzGK0sen
	Y5aXnlgFNPK9PK7RfOcsapuW4tLo=
X-Google-Smtp-Source: AGHT+IF6xK/GPvAiHdKxO64VhJoQcV28tR5f2ZG8Ig+CBIE/d8cofzhIq+OCDieZcte39JP/hjAbrI0tEzY/SFEH62U=
X-Received: by 2002:a05:6870:41c1:b0:21e:7751:312c with SMTP id
 z1-20020a05687041c100b0021e7751312cmr16095391oac.30.1713869340021; Tue, 23
 Apr 2024 03:49:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Apr 2024 06:48:59 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZidVxMcTOd9ga9TL@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com> <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-2-knayak@gitlab.com> <ZiI8AfkJL4O3K7Xk@tanuki>
 <CAOLa=ZT8=1qDbsHhk2gnVfgcGOLv11+WgvyB_DtuB7=hPL+jyw@mail.gmail.com> <ZidVxMcTOd9ga9TL@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Apr 2024 06:48:59 -0400
Message-ID: <CAOLa=ZQsfxsNCQ6GF4jv+KN7U6uHxA5w6x9jNjrn+zDTmRox6g@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] refs: accept symref values in `ref_transaction[_add]_update`
To: Patrick Steinhardt <ps@pks.im>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000003439e80616c14df2"

--0000000000003439e80616c14df2
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Apr 19, 2024 at 01:09:39PM -0500, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > On Fri, Apr 12, 2024 at 11:59:02AM +0200, Karthik Nayak wrote:
>> >> From: Karthik Nayak <karthik.188@gmail.com>
>> > [snip]
>> >> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>> >> index 56641aa57a..4c5fe02687 100644
>> >> --- a/refs/refs-internal.h
>> >> +++ b/refs/refs-internal.h
>> >> @@ -124,6 +124,19 @@ struct ref_update {
>> >>  	 */
>> >>  	struct object_id old_oid;
>> >>
>> >> +	/*
>> >> +	 * If (flags & REF_SYMREF_UPDATE), set the reference to this
>> >> +	 * value (or delete it, if `new_ref` is an empty string).
>> >> +	 */
>> >> +	const char *new_ref;
>> >> +
>> >> +	/*
>> >> +	 * If (type & REF_SYMREF_UPDATE), check that the reference
>> >> +	 * previously had this value (or didn't previously exist,
>> >> +	 * if `old_ref` is an empty string).
>> >> +	 */
>> >> +	const char *old_ref;
>> >
>> > I think one important bit of information here would be how to handle the
>> > update from a plain ref to a symref or vice versa. Would I set both
>> > `REF_SYMREF_UPDATE` and `REF_HAVE_NEW`/`REF_HAVE_OLD`?
>>
>> I'll now remove `REF_SYMREF_UPDATE` and add documentation around the
>> usage on `new_target` and `old_target`, where if either of them are set,
>> they take precedence over `old_oid` and `new_oid`. The `new_target` will
>> ensure that the ref is now a symbolic ref which points to the
>> `new_target` value. While the `old_target` will treat the ref as a
>> symbolic ref and check its old value.
>>
>> `REF_HAVE_NEW`/`REF_HAVE_OLD` should however never be set by users of
>> ref.c, this is set internally. See REF_TRANSACTION_UPDATE_ALLOWED_FLAGS.
>
> Should they really take precedence, or should it be forbidden to pass
> both old target and old object ID or new target and new object ID,
> respectively? I'd rather claim the latter, and that should be detected
> such that there is no bad surprises here.
>
> Patrick

I think after that email, I agreed to Phillip's suggestion [1] and now
I've added an explicit check for this.

[1]: https://lore.kernel.org/git/CAOLa=ZSwtOQXwbgregzKMtVA30wUCH8R=8D7u1+KGnsGEDD1oA@mail.gmail.com/

--0000000000003439e80616c14df2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7a04479058f06bbc_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1Zbmtoa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN1U1Qy85Z2xwM3VqdndwNmsvcUtzL2J0UnlXSDFGRwoycWkwdzhPN2ZF
TG9sTkVocG5qQXhZd2xjUkRxcFNpbW9wNCttbndUMnI4UjJueElpVElMdno4VUVCOXd4azBlClo1
OU1HZmV2MFhESUVUT1JiVVd3ZG40ZWd1bUlpSFdwNk9EdHRpRXAwRHc2TUMwSjVaQ3lpaThGcC9I
a3AxTE0KVHZrZ2pHSkJtQVJvZ3RISHJod3lmd1lXVG5kRmJZQVN4VHJpZzVTbmIrNTU5d0xUck1Q
aG1TWUtseDBSN3QwVQpvOEg4N0RCSEQ3aVB4UktIYkcxTk9Kbml3UHV6OXFiM0pLdS96NE5INWNN
WFVOTGxyQWxBTG5kdEFlQkcyQW5kCjVYY2JIVERJdHYxZkp5cVQ4THRhVlRpbjR3TndWRy9EVklZ
dG1ONkgzZXlhYjQwa3hkWk5qeEk2YnFrdCtPQjgKS2FrMDVxeGg2NU9Id0xvVUphWFRJL3ZGeFgz
L1ZRU2FMeU1ielQ5QmFvSnMvQlkzbDV5dXpHby9WbERHWWZPQQoxMGdGN0JQM1FRT3hVRU9HQUxj
Uk1kSW5UUVo5ZGg2aG9Ya1FlaU1qSHcvdWRJYmhqSUdMdkhSRFZnc3huZElSCktSRytDOU52amt3
R0JNWldxdnNVT2xrbG5wTTJETkJxcGdzcGVuaz0KPXhSTUcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003439e80616c14df2--
