Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC6A3B52E0
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768490465; cv=none; b=e242LtN61Yee3W0afyJCWQD2r91yrhRT0U2wAFVYBGqJMGh1TOkEDFkxma1h4+h/VTBasVWH91llP+8s40kKg6tcD3+eSRYX3nUy5rF/W5lSe6ugvl4kro6Dk8Dw9INNGt473FPV8ApCJR6umIFZqR+r0rEZyzcuJow0CSrBPro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768490465; c=relaxed/simple;
	bh=VD6o08pY539O1fTc8sYjkR0nVPl1IQ8ZaT449u/hccY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1TW6u8ix5cKsnpGvkY6Y76SVyF/pvVhf1hfqcyc/RI+nT8BBONZC9WHHW2rNypxnvoQYOWfEb4zFW1LWZDS1oVakz1ibzpUKDSeFKJPh9peBwDXtcf/0PfVieS7HXjzd9VgM0RlCC53ia6pS/OIyaV7rLO+s5qczlzSeKVtCZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcmSK6ZX; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcmSK6ZX"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9412edb5defso287526241.0
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 07:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768490452; x=1769095252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HoSXNg0rAGZabodLdDJmqy+VmmyYTSmJsUpOzxZOEjo=;
        b=mcmSK6ZXxNYhclq/kG6R0og/CedVILWdq2tdTI+jS+oER3z5uEwgktkhMPBYT32naz
         5VpjQv2wMblrBm0MjyfZMMxD1eWrFQNpfKu825DO65dZ3gPuTYs/nAh2pEDyGXaN6h+5
         1Tm5SKQh4XjfDDyqvOuG/MHYdRG9IqOEWzFuYh05XfWNqAKkN2XWLYGz3+e5zYsHt38a
         5gJiqvQpyLNp3WHvl0OfH+SysxeyoUfF7QiTNCwUK10mWZpPyXeuqI9yIN+4NfkqtXMd
         LekUMXbqBtNTAXUYB17nZPWyLe6yx0nYNGc1sTO4KkqAjuqjATCruVDEGeS/y4a2IIQ9
         mW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768490452; x=1769095252;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HoSXNg0rAGZabodLdDJmqy+VmmyYTSmJsUpOzxZOEjo=;
        b=nuD+JaZkrD0Df0dwmQdM6J51igp1wRRLntN16UbJYvuCiiZdQS5WHtCSHU7wOhM3hZ
         EJANs9BmK3kRLvPa70BWLHPx6pC0bchX/FMDJYC9L6q93Hv9ii+qXjINXvAuuFV0WQ8P
         6WiQBNZErhv7FmuSmvTOhyf2Z9g7EeDTDw2ikX7kK0J4SZrIZHpWNtRqUuq/FUmtUwze
         KIcL9FJV/WPuCC4trtZdd5MsYRc+iCnI1rsrewetP1cFAipI+6ih0WSBoZJhiPUiKBcg
         2Uat3T1dQW6mj6xHjADPTTVrznqOKDpfyCi8REWyN9/+i8aqglTGRFRDEzdw98BFHzmM
         Z6aw==
X-Gm-Message-State: AOJu0YzJ02MoXDSAnBwQ84uGArX4eNFGlDjxsgHPNSni7TuAA0fHHCPc
	HbMRGCUSwC/bxelx5w2vmanEXYgO7wFQVQcmPXyjuvCSTnmOziBqS9DtUIlqnjgDwIH3XXkm33I
	8mboQlhIxxmmNpBh/4D1rggTinDJbskK0fA==
X-Gm-Gg: AY/fxX62/l7Qa2Z6/EGPRN4V+XZivNM1zy7OW6sxtBMd8I/SZ2UfYRnXfdk0n57wQOZ
	2WnwIAOlLHYImjswjkzPjnYMILXUSbdnwqgrZ6ZqJch1FISMUeVL7D5rZNzbnolFTiYrKQpW10R
	2zT/k/5pBWPqL80g3fxxHwWoRBlzRBnoVMZgOHrHYSzo49G9yggjLQtt5MukSA9g8elWej/b+qj
	aUImdw4Q/a/H0HTdCm5uQuRidQMKXE0LLfA6hqeq1srlI4c5wgGd0HDhxxbRdBngLYsIw==
X-Received: by 2002:a05:6102:5801:b0:5ee:a05e:f7b5 with SMTP id
 ada2fe7eead31-5f17f6b2f79mr2533810137.44.1768490451916; Thu, 15 Jan 2026
 07:20:51 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 07:20:50 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 07:20:50 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260114180040.GH885771@coredump.intra.peff.net>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
 <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-5-f5f8b173c501@gmail.com>
 <20260114180040.GH885771@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Jan 2026 07:20:50 -0800
X-Gm-Features: AZwV_QiRM3uih0AdAXFSkNkPDkBKJiEtTP_HoxVVR8-a_U09H3Ja-YBHtIp0E9Y
Message-ID: <CAOLa=ZQ0ETE+SzRV+M-xzEQFRTjdhSMseHjwnJ314yqPw8BPYA@mail.gmail.com>
Subject: Re: [PATCH 5/6] fetch: utilize rejected ref error details
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, newren@gmail.com
Content-Type: multipart/mixed; boundary="0000000000002cf08506486ec54d"

--0000000000002cf08506486ec54d
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Wed, Jan 14, 2026 at 04:40:46PM +0100, Karthik Nayak wrote:
>
>> @@ -1674,9 +1674,11 @@ static void ref_transaction_rejection_handler(const char *refname,
>>  			"branches"), data->remote_name);
>>  		data->conflict_msg_shown = true;
>>  	} else {
>> -		const char *reason = ref_transaction_error_msg(err);
>> -
>> -		error(_("fetching ref %s failed: %s"), refname, reason);
>> +		if (details)
>> +			error("%s", details);
>> +		else
>> +			error(_("fetching ref %s failed: %s"),
>> +			      refname, ref_transaction_error_msg(err));
>>  	}
>
> OK, so here we're writing to stderr anyway, and now we'll just give the
> more detailed data. Makes sense (though like Junio, I do wonder if the
> existing message might provide more details in some cases).
>
> BTW, I think there is still a related fallout for git-fetch. Even with
> your patch, doing this:
>
>   $ git fetch . v1.0.0:refs/heads/foo
>   From .
>    * [new tag]               v1.0.0     -> foo
>   error: cannot update ref 'refs/heads/foo': trying to write non-commit object f665776185ad074b236c00751d666da7d1977dbe to branch 'refs/heads/foo'
>
> will not put anything in the status table. Whereas in v2.50.0 and
> earlier, we get:
>
>   $ git.v2.50.0 fetch . v1.0.0:refs/heads/foo
>   error: cannot update ref 'refs/heads/foo': trying to write non-commit object f665776185ad074b236c00751d666da7d1977dbe to branch 'refs/heads/foo'
>   From .
>    ! [new tag]               v1.0.0     -> foo  (unable to update local ref)
>
> Note the "!" and the "unable to update local ref" message in the status
> table.
>
> -Peff

This one is a bit harder to crack, earlier we were getting reference
update results right as we added individual updates. Now that
information is only received at the end when it is committed, we just
don't have that information.

One way is to delay this output until we commit everything. But we don't
want to iterate over refs unnecessarily, so probably store these in a
list, and then iterate over them.

I'll try and add a patch for this too. Thanks for reporting.

--0000000000002cf08506486ec54d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: cf255fbbaa3c94c4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1scEJkRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMC9zQy9zR01ka0RYNWxoeDBtbnNqdHBHMGRBb0xLUgp5S2JWWDNaY1Nq
ZVNiY2x2blU5elRZOTNUR1J4ME1RTFNPa0dRWCtjTUwvQzVCL3B5MTByM3ArTE9wemliQ3lQClpE
YWcvWVE0TWxpVTB3Zk5OSjJlTjRZVGgrbWUxWjZHS3BDWUM4L09JZmJSWXk1N2locGdlQU54UDkw
R0IrMHgKT3VNTUZ4WTNKcG1wY2pKcE04RFNqcGtvTW9nRzROU1JwbWdDd0RLY2tNQjk5SG5aUENL
Wlh1TnhXTWZ2aHV0RgprUWxqY1pHQklocjRPMWRPQWYrS01FRXJyZjFKalJYL1NaRW5SUXFFSllU
R0JFNVJvTnRuYUhRZysrNVhXYmtiCnZGUWFnb084cVBjSCtGc2JNaC9VeVR1UmVodG1VdEJuWENv
d3UzaGk5OU1DZnlwZnZxMjhGak1DcnVuRCt4SkwKdmFzUnlJT3Fna3pSY2ZXZnpCSDg2NlBTNE8r
RHZCKzZkbEpUWXY3UFd1di8wWmNmYkpzclF5cHVodXZoV0dKSQp4NGs0TmNDbmc3Zy9MNnB1SWNO
MHZJRUwzTEtHSExqVEphOHFacFhqNGVkbFZDVUJaTCsyUnYzSTdxSW5MTUg3ClExdEQza0NIVWJz
UDNYSFdRZkJja0FVdGJnMTFHVVJIaWFrZ0ZtRT0KPXFMOEYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002cf08506486ec54d--
