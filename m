Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9800E145B16
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754556698; cv=none; b=oIZm/nWOdiWi4TFKquRXG3z3PoTITF1m6wrZEiqAkf+YlCVtZBfT4EM2eYhH+YNx/TSBCPfuYt8a6ERdkYjJ2ebt7pdOd0vGvQaFeMt0uOq78UkmhogwL0kV2yjGdKOFR8lTBPveZcBE+GWJhdY9+2EwkDMzGS/ovKiSwMpaUD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754556698; c=relaxed/simple;
	bh=J2X6LtIpHQGpIVGYMOIuRjcnVUPDHEwNX9j9oQkSwmo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjaqnPzYnzMnWXIiA29KnleUX7DGQQ69QxEgHPygZa30YR7va88ecaEycP3H/ZLXmTwKUMIB2WeJb3P/gj8OqSBkIGWFlUqmQH5RRmJDl8BLop7hkXfRMyNBk3tEx5wJRJplyTiPJJf8IK11AHVLX5biXDzhsHaX4jwnaQP3RPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/L8rF5y; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/L8rF5y"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4fec0d6fe30so156296137.0
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 01:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754556694; x=1755161494; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti9+lvcV6Vjku/Iccj0Ug7GT0V3fnskS8P6txlrFcZc=;
        b=c/L8rF5yiEm4KHj23KOJ+jZXA/d+A+UrmAvUpSiP0D2bZYvqGtLZyFagkwJR9wYkXI
         L+Gq9BxClfZ9zoUpmN41jtervw+jOr9xNYKNWwGbeXqv8Mu0wCm3msLXSWThvyBdD9Hw
         y+RpsU5rE705R/qNpiO0n5uNYsIACW9uhOf8LnUpLmwH+hSGeYsv3B8h/YM5S5Se7ljs
         OKY+kQiyLUFz1GDUypsU9ZtElJXOYRxT1M/ReYIdgMhTy+W3Q5yqmuaI2xTM8qOI7axu
         HeCRRxJ3oWMBP0c5Zl4aWt9KnouUHD4cco1HPGjgrXRMOWssDfK5cqcrWD70EoA+8mDA
         6Fiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754556694; x=1755161494;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti9+lvcV6Vjku/Iccj0Ug7GT0V3fnskS8P6txlrFcZc=;
        b=h9sHJkKRzDdpPkytCQD99Waj329jNoBELzYvLtniV9Q/uRLITaCcxzyzk9tpEsfHEc
         C/bl00mxS140O7iCjAeGZVFozbeVorClZKemY72sk05y/pbuPVKs11tLnX5V5hDdQfle
         tym3EHgbZhjlZphtn3DrJwwiapse7i3UFapXVRVI5UqIe2wuGDa2GfeGELCbYEy5HylI
         yj5MKVwbOlNISNBmyhq+OsojWyJZtouJ/92JcqPIlwaMey2tEWCfjqAS52J/xiqdlacA
         RcW4rrm3sPjhDBCJ6Cd0bte/BVesmIgXUsRp5OmqVThS5RamCAfzzdLfKLs+yIXBH1t/
         hUsw==
X-Forwarded-Encrypted: i=1; AJvYcCW9yto3Il0ZbZoCSUQOyQit4L2+jDpHoqmsPBZtmgi5YdtnSAOQ51Ed39N4yQgjiESYihg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc+DEMkouilIYw83dtQg5piTD3JdFA2+2zQANszqjUpYwfxGIL
	x+8mQmSbfObXInNaCYhC39adNdawqNhjCTh85XM76O6jy9bYorspZDqMKpQtHVz0mZQWN01HkOL
	0nCFoIxSIlmtUzJX55pu7eE45xq701WT2JirK
X-Gm-Gg: ASbGnctE7w6DsbE1gCo7kfC8F8S+cgijDIrzX10VcQ3ipcBunRlsveto1piTrsV49zM
	IKS7fJTTmfzZbQ6SnJKEXi4RQy+r1xvY3A+A6eQFxGSXDzUh7bJe1hQSN/lXusRjDMAUCvPMsyL
	DA46bzkXJf7BVNR1SnkPfy8YoAghcyGuj+B+jsxOBSpFDmEA1bBXpu1MXqHAE2E4/plTgnP240S
	r3P6Q==
X-Google-Smtp-Source: AGHT+IHY/aquDec8XMOtWOMILcDrGAlSpN8ySA6WmIIYjqEwvXa0F6SYXRe7IHh612h+G2AvLRhgRJ+Q/CYC5UIz1Ao=
X-Received: by 2002:a05:6102:358e:b0:4ec:c4f8:c4d3 with SMTP id
 ada2fe7eead31-50378c2e28cmr2398608137.5.1754556694384; Thu, 07 Aug 2025
 01:51:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Aug 2025 04:51:33 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Aug 2025 04:51:33 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZTA_3po038J7DGxk=gEM3JkkH5afBeRqTJLcKNM87hmxQ@mail.gmail.com>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
 <20250729-b4-pks-midx-deduplicate-source-info-v1-5-748db2eda3b5@pks.im> <CAOLa=ZTA_3po038J7DGxk=gEM3JkkH5afBeRqTJLcKNM87hmxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 7 Aug 2025 04:51:33 -0400
X-Gm-Features: Ac12FXxkw7kM8JqBl3J7AFVej1yRQ3isOQCRoUHIghP4bN7No0v6XPo7LaB2ZoM
Message-ID: <CAOLa=ZQxu6tCMyUWzmDnEnKs=ydsC3Av=UX6v_ZYyxZQBV3aEA@mail.gmail.com>
Subject: Re: [PATCH 5/8] midx: load multi-pack indices via their source
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="00000000000081fc16063bc290a8"

--00000000000081fc16063bc290a8
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> To load a multi-pack index the caller is expected to pass both the
>> repository and the object directory where the multi-pack index is
>> located. While this works, this layout has a couple of downsides:
>>
>>   - We need to pass in information reduntant with the owning source,
>>     namely its object directory and whether the source is local or not.
>>
>>   - We don't have access to the source when loading the multi-pack
>>     index. If we had that access, we could store a pointer to the owning
>>     source in the MIDX and thus deduplicate some information.
>>
>>   - Multi-pack indices are inherently specific to the object source and
>>     its format. With the goal of pluggable object backends in mind we
>>     will eventually want the backends to own the logic of reading and
>>     writing multi-pack indices. Making the logic work on top of object
>>     sources is a step into that direction.
>>
>> Refactor loading of multi-pack indices accordingly.
>>
>> This surfaces one small problem though: git-multi-pack-index(1) and our
>> MIDX test helper both know to read and write multi-pack-indices located
>> in a different object directory. This issue is addressed by adding the
>> user-provided object directory as an in-memory alternate.
>>
>
> Doesn't this commit only fix the 'read' side of things i.e.
> 'cmd_multi_pack_index_verify'.
>
> Shouldn't we squash the next commit into this? Otherwise, writing midx
> present in a different object directory is broken as of this commit no?
> For e.g. in 'cmd_multi_pack_index_expire' we call
> 'handle_object_dir_option' which would add it as an alternate obd, but
> we don't use the return value at all.
>
> [snip]

Reading into the next commit, I see these paths internally call
'lookup_multi_pack_index' which would find the right source, so this
commit does work as expected. So all good.

--00000000000081fc16063bc290a8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 234aeb01edefa8a6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pVWFSUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN3JOQy85Ris1REtRa25pN2xRWFJaRHB1K1dhRXdkdQo0MWh2cHlUUmsr
ejE4cmoxbmpXQzhnN2lzdjh2Nm80cnBVaUN1MGFCMU50SldLOGZJMmtoWFErSTZBUE1wKzZmCnF3
L3puMjFZNUFDUU8yYzZuRE15OEFiUTVnRVI1Y3YwV0t3V2MxV0x5Vjkwc2FMSDhvTmpUaFhWYTdU
L0ZYZmQKc0lvRnFvL3hqR0xvcXRWbnArRjVnd2JQRmFSZU1nRmdYbU4xcXRsKzAyZzdHTWlZbE5p
TVJVR1FmaFFlUS83agplYnRtckJxN0YvTjBCNkpqalp3OXR2YzdPUVBxNC9DQmFaVTZUcGpsZFh2
cVJhWXU1akFtV29zb0lBcDFhS3hqCmQ5L2tMNTg0WVN3bkJJbGU1ZlBmUWJLRHdUMlV2WTViUzcr
aGVHOHdLUk44dVFLLzhucERhVkdtdjBnN3RFVncKUWlsWlBtclQrcHJORWxLSXAySzI4Rnc2YS9i
bStNNWJYUldmdE9EWjZMaHJ2NXVVZXpoYVVoNjVuNVVXbzEwRApyclEveTBqOGV5STR2aCtTLzdO
WDQvTkdmRm9nKzV3RkM3MC9NbzlVMG5ibytvMnhKTlpFTlJEU0RZa3VubEpSCnVFRHFwSXF2Zkp2
QU0wd1VpdUpNcnlSMnFxZFpmcTRTYzJvdXRQaz0KPTV0cDgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000081fc16063bc290a8--
