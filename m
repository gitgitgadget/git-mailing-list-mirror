Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D106A3596B
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009393; cv=none; b=pmwqE4apWlgj3LbpJSxWhpLiv0Zsb8Np42nF7+ymZDEA3xPWdIA+Z0wuU88NZRTJDizIBO/okLmv0B3Gl/j8nEussF11fA2S+2BQ8bWVwAsFnIVpK6ZoLAHiWEit0QSoyReoFWlsl6GWdeMtb2gjIyZMlimrvXcjAtgw3ap9LWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009393; c=relaxed/simple;
	bh=Wz8hgAoXzy955Qyjc+m6HSL8zTKpcP74ROar3WaugXM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hN8Kr9MZ9Ks5Xlxtyx2eXfh+RUGV8EE+VZ9eMVnmI2iqK8Q5xIMJBi7gXRvkmJobrNiSWISRp4k4kprQplcXcmkuiX0Mwiut3xibgBtSniT2dAVwED0ZS3Us2VihkfcPgajq3avCCez+iZEu8BDlwiLxGPKWo4fFH8V18cE7N1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FK9QPfPG; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FK9QPfPG"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-53939ecca0bso706692e0c.0
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 07:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755009391; x=1755614191; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PKPO1REzjG/k8ZB4RFL7LageVYknxZp/7XVZcpQEfNQ=;
        b=FK9QPfPGSDBT08l3ysm2P95XHlQuodv9qUTlfhKXFOAYsry6eEdjhTJVgGxxvYz4XX
         4sRV47jQF5GuD+Lt1eqhdaNO1dPz7QQLFtdwPmzXlNQ1lhblTnzw/8Lq4p/HhPTce91I
         v5hZiSneGlNK5IViprAe36MV/H0jPpNgIzi4OZ7dGGc++N8BLYUf8uFyUEoISc9E1Ss4
         aL7l5Uo5jWj9OUW92jjooagV769TZ4H21/8+ETDsdajjpBCDwpFYRUI1aOC3+Ec66pWv
         vIdZkI0mB/adFkv8BKPM6kTCUn9aA3EC9YBfuCx7XJccNeZIs8ifHt3D+8LaUWTe5CW9
         f2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755009391; x=1755614191;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKPO1REzjG/k8ZB4RFL7LageVYknxZp/7XVZcpQEfNQ=;
        b=dWQe+jyP1JVoOMb2OzXX+N7jAPnm9Cl12mAH5P2o82Z9r6rdruz1EGnnFFDQZZ8Lgj
         jyG9COpjSBIsiCa9Rc9XW5aOwL/KzHqzHHiEBrTKgMUCTbn3N01Ixkokjoi/+LP5hd0k
         EH/ruS88ugSIXHgAbssisCBMoj5WxFnx2C+2O8FM+DIAjliMe/NAkkLZWkODos+br09A
         NduozIwp9jEQyW7eYMBx2c/8av0A511YsJW46MLVIcz+v72g9vncpEAlBhhqsifCmURm
         ggt+kLJLkJQW9o0hFHByl3gN9BJ4GfBuhFPBn4zjslcmc4w7kGmK228fZiwL7vv0EOlO
         lHkw==
X-Forwarded-Encrypted: i=1; AJvYcCXDJmV/DWdGDF4izKhtTwl4n3uBsTHr2WeEVlxJaGVXVAdhWXCRW6ylX9U+NQLmGMqprBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFb3rojq60vq/0nRJw9HXlvKsrFmJRH2Jzsv4+SW8sVbasYDrd
	NeTwNg9W6cifjX8d1gcu9Eyo+1zx8m9me5iC0EkUntXAa5oqHCzp51WWHPaAKqjiC+PNAN/xG/T
	A7XG8sOvkOiylwM2CI1ywowyzQb5YmQM=
X-Gm-Gg: ASbGncsWYy97u6GO0ICiwDXoZs1/8CpTVkZ7VGSEkYXpsuuhXBfv0SUPLBmLA97FkFG
	uvxOgYub4dyxkjqiB3NJDpIqPyclpkT7FIaEVPgrt4Z2lAfKPkJNDrjcKjb2EHT996GgfMnq0Ma
	aUoo71M41crVV/0YvFYxo1qajMuDED92h4f55n3ZbP9MhVMhl2+7luv7dxUgVfWEfmsFSmMZZDq
	vHGsstu
X-Google-Smtp-Source: AGHT+IH+oman7NpsVCj8FGlYJgJdIhOvAuKBMi3NxegoyY3t/0eB6vL+urPkAcTnzBZ+RP8oE/rVBUxGYgkdudWPT8Q=
X-Received: by 2002:a05:6122:1694:b0:539:1154:d149 with SMTP id
 71dfb90a1353d-53b08e0d107mr6039e0c.9.1755009390578; Tue, 12 Aug 2025 07:36:30
 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Aug 2025 07:36:29 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Aug 2025 07:36:29 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq349wy5hg.fsf@gitster.g>
References: <1a32a666-fcf4-4f05-a468-2afa07fa0e2d@web.de> <CAOLa=ZQqY8MDTs846mkVsxXrmOmC5O_sv6BxUHqYjGk1Ag+Osw@mail.gmail.com>
 <xmqqtt2d3l3c.fsf@gitster.g> <CAOLa=ZQGaZA=Yynv5JkYpSbYBczfVnemwmzABrqB6er19Utfeg@mail.gmail.com>
 <xmqq349wy5hg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 12 Aug 2025 07:36:29 -0700
X-Gm-Features: Ac12FXyvBn4Ct3DLJYB6XMTNnUDaIWeYkTUeJfo4j8L9RML-PLAuUYEJOBeMnis
Message-ID: <CAOLa=ZR_ACey173CvkMPQ5DXwGKei+2L-JEWqGueX3NhDXk=5Q@mail.gmail.com>
Subject: Re: [PATCH] for-each-ref: call --start-after argument "marker"
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Git List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000004db088063c2bf745"

--0000000000004db088063c2bf745
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>>> -		OPT_STRING(  0 , "start-after", &filter.start_after, N_("start-after"), N_("start iteration after the provided marker")),
>>>>> +		OPT_STRING(  0 , "start-after", &filter.start_after, N_("marker"), N_("start iteration after the provided marker")),
>>>>>
>>>>
>>>> Ah! I did fix a typo here, but your fix is better. Thanks.
>>>
>>> Here where?  Is that "fix a typo" something I should go around and
>>> make sure I do not miss?
>>
>> I meant my earlier patch fa0f4e46f5 (for-each-ref: reword the
>> documentation for '--start-after', 2025-07-28) which is merged to master
>> now.
>
> Hmph, so what does mentioning of your earlier typofix add to review
> of this new patch?  We should revert your earlier change and replace
> it with this one?  Or there were two typos, you fixed only one, and
> this patch ties a loose end left by it (but then that is not what
> I'd describe "yours is better", so I am still puzzled)?
>

I was referring to the fact that I made the change from "start-start" to
"start-after", but "marker" would've been the better replacement, so my
review was concluding that while I was here and made a change it still
was lacking.

"yours is better" is poor choice of words.

> Thanks.

--0000000000004db088063c2bf745
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9a2ca4a895fcfe16_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pYlVXd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNEcxQy85U3lmaDlmTkVCMjhpN04zWWNCSFBkVjlWRQpvckNRUmRWS1F4
bG1qMFV0MEZVMFhtQ00zeVJmRTNaZnFGMHBXODFsUm82VWIyNk92WUthVkMwTzZjYUNPT01NCmVF
VlU3YWx2OEI5dURFSHRxZ2lQMmE4TS8xbzFTR1VIZy9SdHhpTU5scnJTazN3Z2tFeGYrNXM3bzFi
bGZXL3UKai9rZzVHYjRKWUFjV1RlNnk3NHZBZVhKdUtzZUcvcExvWkkwTG53aHhkYWVOQ0hFNEJ2
NjhKWmRPNk5KVS9oeQp3SDFkNnpqZEtqM1h5OEE1dU1jUVlHbkxIc0pNQnIzZ0IwQlFMbEs3TmUv
MW1KUGltd2FtOEE4bmgzQWdBSjR4CnkwdU5QQkF3RTQzYk5wN3NES3BzTk9rZ3kxeXZlb25sWUVH
d0FMbDcyR3Job2Z4MFVsUC9pVVZmTXJ3ckdiQU4KQzduQS8xeGI0TG9FRFRJZDNVcDFjMEg3U2JV
YzZucHlHOTBzUThSemRXYlZQSFo0SWhod21HWVFBRkFyVi80cApCZWVOb3hLbkxVQXdXTFFtcVYw
Snd2RlpMWkY3NVdWWi9jOXdSWUxDQXdXK0xMWHJIZE9BaThhNmN4dENPVktUCmJoSmNWWWNNblJ5
enNYYTVwUnVlcnM4Y2s3amdGWWVmbDRFbm8zWT0KPThOZHgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004db088063c2bf745--
