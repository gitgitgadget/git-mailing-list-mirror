Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C74E19D087
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 07:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758872658; cv=none; b=LOkyYikRIozOoVY+kQWxI7n796kCppLEVrc5Ezc2RzTFyl4mv1zPlPiCLXs+5wRyX6EXxdCFsTGKptqMsPXCNgPFnE/ZDtlQ5j6UsfkA86f1KB45rq2kJCiUpDyKFscL1wr9w/touEejSPOV+vcOFAOqjq3O88KAoHuzxc+UysI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758872658; c=relaxed/simple;
	bh=NYBw0WYAOe0wvPh4T9uKdWElH6YLuEjX7rvcL/uAiJE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXi9mwdRur6IYLdpr5ZfAeYRgk93dOTM1mrWNczbJ5UqDD5/9eGNM3Km++eEnJg5Nwh1cdmZl7yW2M4PL8EQldY+0Mg9+rkIBf8cKh3BtEFclQKI1uzFy3tQTo37fCqi5FSDbBoHngnxBVUHHmxJDNoEZahTVTnF9DK2bYeDp4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FabUsrdp; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FabUsrdp"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-89018ea5625so804840241.0
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 00:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758872656; x=1759477456; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NQc5M6Y335Nqo/7VLVtuPTzx2MjJcL+DwAZ29xis16Q=;
        b=FabUsrdpfE5Ce22XBMFfHoFDPtlLYiHLORD8OxJct9WZLi7iDW0QORuJCgPZDlG8UT
         wy1QyNSkjn7lDjSDTgtVkJF6c/0KOA2lDtlBOvKTJP13faSrWPnLcjW7qfsVf/OphPoJ
         DwxzeC/DqLL9KEYxvpavZPQeqAG5Xv3cpjenV0I2I9IVQZub2pew1URUU28EFGa+KxxN
         RHmRcUx9T84j4Nv6LOqcWKb3PZ7Bih6dYkHaldo8XtpPkzuFtH/zPhMe3+Ndujm53gtc
         U39EpC/+kvnJwI3UgKEwR678pbrdS7b234R+WwHw8jBdi2pfbwglkqqzpVff6uUp5bR4
         NveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758872656; x=1759477456;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQc5M6Y335Nqo/7VLVtuPTzx2MjJcL+DwAZ29xis16Q=;
        b=Nr8q93kjZC2st6fd9fMhkCP3I2vc74jkGzuSX5YqtEBp6hrwZtSMeACL0Jotj3NE2c
         bm8tJuc3DAwlrHLSP1dWrnX1Ue0/kG6Del6jENCyoLBXSm/uYnkRTDbpk9cdC4Ty4b1o
         E0frOKNjCKdFkXJ9OorYPJJckpQJD2/dfHWDGm0vRu8hMzAsjesy8F8NTZ7kOYlJV1hJ
         jLMqliFi1ojMH0iP2RNgSh+I9dvHsY/YkNLpGVcDJmlxJwBq49Kw9+C7+uCCOY+5mtxZ
         dAMggRj7zBBoycnLhngv51d01a91JxdpA0cItwO6VjvfbEEx0eitXvwPN2/APZSat6MY
         Oppw==
X-Gm-Message-State: AOJu0YwTON/kQYkPqQukdTmBHA4sgndPFY/zt6wYw18AarGxJfEIvHnF
	Rp2Qo4EF5R7WWmz4gFT5ZLcmYhWjNB2LCGb05SgM/83+r1llxJQ75m9aGsSHdAkckdg2dnUY59J
	iFzW+QTpQu8M5f61QBmeSuaIlgtOH7m0=
X-Gm-Gg: ASbGncuFfjQp8eeyh5wKfvYTIuz74SCuEd5eP2vKeJ9/Rk8IVqcMWlnjutRtDz8+q10
	X5Qaddl7HthLISqowDpFGv8ggRQa9jgvAPXkfiOcpU4bY/ARimKu8fxLGQLgbaBMu0t8DNxjRNR
	ahctyc4fD3b1O1DmTS/z7BVNBViEOF/J4E7GziTJkkpzRescI09afmg/tWsSjIpNnVI/rvtda9Q
	WnQ2O7aSDHzLRgNxZgK042TOAxRQWb96m1rRfVi/jhP8Veg4Irc
X-Google-Smtp-Source: AGHT+IHwujMbRS4G3I7RPda6YLBM9hy6tW6mYAFXWU+wrrGfgyEQ7zvHT9u+qzjndRG0gkhsk+yfsf6Vgnjal2LLRGM=
X-Received: by 2002:a05:6102:161e:b0:4fb:142:f4c0 with SMTP id
 ada2fe7eead31-5acb9e315fcmr2618873137.0.1758872656179; Fri, 26 Sep 2025
 00:44:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Sep 2025 00:44:13 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Sep 2025 00:44:13 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZSfL1CVCNjD0Vi3kpQqLM6t7YVa=G2ChGpaza6WOjZTCw@mail.gmail.com>
References: <20250924-583-git-for-each-ref-start-after-v1-1-c73be2b5db5a@gmail.com>
 <20250925-583-git-for-each-ref-start-after-v2-1-3613b5a27ff1@gmail.com>
 <xmqqbjmyh353.fsf@gitster.g> <CAOLa=ZSfL1CVCNjD0Vi3kpQqLM6t7YVa=G2ChGpaza6WOjZTCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 26 Sep 2025 00:44:13 -0700
X-Gm-Features: AS18NWB9eodjaDnz_pzww5XYNgupQcqHd0gXjZeHoQJxC8e1xRceXsPf5xWItxo
Message-ID: <CAOLa=ZSrzq0yeLJpMMg4Jf2vWkRC-9D9=9hxHveK+=F+ZF2L+w@mail.gmail.com>
Subject: Re: [PATCH v2] refs/ref-cache: fix SEGFAULT when seeking in empty directories
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000e0a71f063faf739c"

--000000000000e0a71f063faf739c
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
>>> index c180e0aad7..e5e5df16d8 100644
>>> --- a/refs/ref-cache.c
>>> +++ b/refs/ref-cache.c
>>> @@ -539,7 +539,7 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
>>>  				 */
>>>  				break;
>>>  			}
>>> -		} while (slash);
>>> +		} while (slash && dir->nr);
>>>  	}
>>
>> This is at the tail of a "do { ... } while (...);" loop, but inside
>> the loop I see this construct:
>>
>> 			for (idx = 0; idx < dir->nr; idx++) {
>> 				cmp = strncmp(refname, dir->entries[idx]->name, len);
>> 				if (cmp <= 0)
>> 					break;
>> 			}
>> 			/* don't overflow the index */
>> 			idx = idx >= dir->nr ? dir->nr - 1 : idx;
>>
>> i.e., if we scan all the dir->entries[] elements in the innter loop
>> and did not find any hit, idx would become dir->nr and this inner
>> loop runs to the end.  If (dir->nr == 0), then ?: operator [*] would
>> become the idx = (dir->nr - 1);  And that idx is used for a while
>> before we get to this "while (slash && dir->nr)".
>>
>
> This wouldn't happen because before the loop starts, we set:
>
>    dir = get_ref_dir(iter->cache->root);
>
> So, `dir` will always have an entry (i.e. 'refs') in the first
> iteration, after that, the checks in the while section  of the 'do {}
> while (...)' loop will kick in.
>
>> And then tha tis used like this.
>>
>> 			if (slash)
>> 				slash = slash + 1;
>>
>> 			level->index = idx;
>> 			if (dir->entries[idx]->flag & REF_DIR) {
>> 				...
>>
>> IOW, isn't this check a bit too late?  I wonder if we can leave at
>> the beginning of the outer loop, even before sort_ref_dir(dir), when
>> dir->nr is zero, or something?
>>
>>
>
> We could add it there too. I can't see the merit of one over the other.
> But if you see it being more readable. I'll happily make that change.
>

Just to clarify, I will hold off on re-rolling till we make a decision
around this, as if we decide to keep the check as it currently is, there
is no reason to re-roll.

[snip]

--000000000000e0a71f063faf739c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: cf3e66497f964d87_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qV1JFd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md05LQy93TUYzY3E5NDNtbnNJV0I4VlhEQ3BlUkdHRgpKd1pDM1huTDda
bmYydTNETFF5NWZaQUhuTGhKd0ZHOXViUnd0WS9lNEJUR0ltbkZMQ2FLNjZxc0RWcXhYZlk3CnJY
VGJmVjdUaHcwYkVQOTR2Y2J5OFlzalpLMkRqa0tPL3JtaWxxTXpNQkk0TWlmSUNrblJ3TndUYkha
amtPMlIKTk85US9Ic3RoQ1pHeTUvL0tJY0o0VVNLZVErbCsrQWlXSUZGY3MzdS9HTklXei85ZlFy
MEt6UWEvZDNGNmZsUgovWE55MEsyNnNNTXJud0dwdk9nd3NMMXZTbENxVVhKelBHaWppR010OHZv
ZDBEZ1hEYXErWkJueTU5RC94N0pnCkUxWklOK1JKa2REN2FSaGVXNUJMYnRsUCtSNWhFekQvUHZN
L0s2RkhwTFM5cVJkdTJYblEyWUZHbHUxVkx3NVEKSFJFY000YkFnM3ZyRFNzRDhVL0hLWTJMbEI0
WGZpV1ZXMDFWY09oc1h2K0MyNXVQRFJmeERnWm0xa0piUmdxRAp0VE1zR2EyYktPRXNpYTJ1b1Iw
dVZPRjh0VHBFL0xMWndmUzMwM2FhK2pmNGxTdlp3QkpsWlhycHNGSjF1VEozCnIyTHY1TGhhQ2lx
dzlsS242aUVPUFdUMGxKbk4ydGNyNDg4ai9qUT0KPS9nYS8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e0a71f063faf739c--
