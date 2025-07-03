Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F647299924
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545445; cv=none; b=C2DfCGgiOMkn5nVT4vHV7VEb59GSpX7K6ZwMUNywvYDXlWWrjF+AxDcGN95CGmIiVGyzukn6JX6mCtqvhpsiPF1f3V2Z6ZAtYdD8Y3O3fhhC/ktFJJ6wfFqEueukONHXnjRF5lc3ww0Evqz+gqo/SHnOofKVoQBUl6FTjE9cFUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545445; c=relaxed/simple;
	bh=BE7w2MQ1ofWRwyn304plmRa2yj2LfzvitSe8+uTMxP4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iC1zfplvxk3/dWw7/SETvBpWs49ftB9oyzMKa2odBDBJnyhvET34hYA0pJIvQFyOLhKP+UstKIXlwHFjdj6twu92UtYfsjTV3YML4z2r7lqCFGCnUnz01nxOwZTUBcnzNUzl1wCuGi62oQQ7nYZ7UjkjkhHP/hkZ++l3f2VWvag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpNBme/V; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpNBme/V"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-530d764149eso2477485e0c.1
        for <git@vger.kernel.org>; Thu, 03 Jul 2025 05:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751545443; x=1752150243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/x0cZitdaZkFxj0tpvwwJiP5k/MchGneazxNxFiTsPw=;
        b=FpNBme/VwK9eV3nZmWgxN2cLaIYkun3dYtSmvTu3PKkM35jpdO1/Mj0/E1CxIMdoxc
         AA4Cox1qwta9ktrMXwCJB6jeygIfci/u/ojZeQjUFkZBxHxyJ/bJDk+KUFSAsDeRgWPt
         w/EqyYtzOiAjzPK96EjHiK8zymOqpMNuEc60XLZBnzIG5nfp3HzMoBnYmwYPxbProQ3t
         J0lxNUw4TQ/b35BQNshSOkGrSn8JX6BsCqR8dMcwNuw0wl0shop+qkjjHeQ6fUNnImQv
         EF5tgefrajS4G1I+NQRp0WBojw2kpnr96siVkOdYpcOBU6t45nQJ/xEL48rmHNtsWXLf
         3QCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545443; x=1752150243;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/x0cZitdaZkFxj0tpvwwJiP5k/MchGneazxNxFiTsPw=;
        b=uCPZMdisyDNigRieN0iTSOTZnyfKkCNkPZW+IOer0qOA5KXVjFsSE3TCwIgGDbnQWI
         uqdp2weE00+jX1y+nAMFJKx/ePyh2Vw4fbga/S7SVpMBEULzaguSQtLVCo2hvkRrg+8D
         RRnZ0DaSFuqCcw1I68gfpOmPkubZZ/WgiKD0OojhvPHvtWkj/mg5e7FRM1MCIkOMCCT4
         qhR2XM7xdlL37yZdmNsIP/Y3KsEIEhY3NSTTtpgsPHubR/eKCCFinXiD0CR8QVL2R0Us
         3cV7Mngp57L5jHqcXB2XFIshontAirzWpEZJRRhTgNjZPNXosyveEXy8CjOXIl6EWCZl
         QL1g==
X-Gm-Message-State: AOJu0YzAMipU3wf/CIVs3sYxh1IbJMMtslAp9zINfJnNZZomzeT684Bt
	VkBuk3PpyiX89wea1+H1/ZjZZoGOFZknGNm/uCQ6Nci+PSeNb17XpDaSAM6SeXnCKwlrcSlZOEK
	STICNxseVTV8Ip2fhCwMnWmJsdA/Ka418cg==
X-Gm-Gg: ASbGncssHvk1DHgWrVIZt89ffOfpLllyI+9xES/w/j9HuOnom4IMuYgZjCN0t5/0JeV
	CvC9jtLu5j909QA9Nqa0t2sMkL+OgJJxuRbuArK6orUDt7iZQkSy/MGVlu1weLHhRv0ck1dtYfd
	C+paMOhXLLdRTuKFSXCYoCChQ4qDXYn+iIv/4uAHCPe5c9
X-Google-Smtp-Source: AGHT+IEjeZKquJafZd7Ie5zQ7nCsO7K+bA17mX1QaIjrUiFaGOUkL3KACwYuVeogfBcEKbeuzKMrRTk9S2iJJAMre+k=
X-Received: by 2002:a05:6122:8f81:b0:530:7101:68eb with SMTP id
 71dfb90a1353d-534674f7f37mr2288791e0c.4.1751545442863; Thu, 03 Jul 2025
 05:24:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Jul 2025 08:24:01 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aGZslJSks2GF3uB7@pks.im>
References: <20250703-pks-reftable-default-backend-v2-0-5a27e72a8c5e@pks.im>
 <20250703-pks-reftable-default-backend-v2-1-5a27e72a8c5e@pks.im>
 <CAOLa=ZTJOqqr25Sj0YSAc9rDmar2qZiVD3H+K6qhdN3qKdqbGw@mail.gmail.com> <aGZslJSks2GF3uB7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 3 Jul 2025 08:24:01 -0400
X-Gm-Features: Ac12FXzXBizY1kSbDtSl3b6axxLmFZ1D5NFxHGc-_tD5dYofacUuY6Iu2KeRiJY
Message-ID: <CAOLa=ZQUp6S3yQ-zCfPxCvwoJeiPdXh5U9mojH+9-P1RAAa2gg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] BreakingChanges: announce switch to "reftable" format
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com, 
	Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000ee29a90639057332"

--000000000000ee29a90639057332
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Jul 03, 2025 at 12:54:24PM +0200, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > diff --git a/setup.c b/setup.c
>> > index f93bd6a24a5..f0c06c655a9 100644
>> > --- a/setup.c
>> > +++ b/setup.c
>> > @@ -2541,6 +2541,8 @@ static void repository_format_configure(struct repository_format *repo_fmt,
>> >  			repo_fmt->ref_storage_format = ref_format;
>> >  	} else if (cfg.ref_format != REF_STORAGE_FORMAT_UNKNOWN) {
>> >  		repo_fmt->ref_storage_format = cfg.ref_format;
>> > +	} else {
>> > +		repo_fmt->ref_storage_format = REF_STORAGE_FORMAT_DEFAULT;
>> >  	}
>> >  	repo_set_ref_storage_format(the_repository, repo_fmt->ref_storage_format);
>> >  }
>>
>> Shouldn't this change be instead made to REPOSITORY_FORMAT_INIT?
>
> It made me a bit uneasy to change `REPOSITORY_FORMAT_INIT` as it is used
> in several places. So I opted for the more contained change.
>
> In any case, I found the logic to be hard to follow anyway as it is not
> immediately clear where the default value actually comes from without
> the `else` branch. So I consider it a good change regardless. In fact, I
> would argue we could go even further and change `REPOSITORY_FORMAT_INIT`
> to be set to `_UNKNOWN`. Same for the hash.
>

Exactly, I just read your patch and the existing code around it and was
a bit confused because I couldn't pinpoint where we set the default to
'_FILES' when there is no ENV or config setup.

I think changing `REPOSITORY_FORMAT_INIT` to be set to `_UNKNOWN` makes
a lot of sense combined with your change. I'll leave it to you if you
want to include that in this series or not.

> Patrick

Thanks!

--000000000000ee29a90639057332
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a2f9f940d45eac69_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1obWRsOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOHIxREFDYXJFSldJTzFZdEFEVmhWT0xrL3Q1ZzlHRQpuU001RVM1bnR5
M3B1bThGVDlwRTZqbkQreGF6emxzQVF0Z3A2MnBFOWE1RVlrQ3lDdkNVWDNLWmRycmxGSTNJCjBY
VDFBWWdqOTE4ZmtQaFV5M3NJSWZra3R4RkxpQldYNmcrTVRhRE9ZRUJVejA1cVZEdXkwVTJ5QUxz
cEdLV1gKM2NVd1FYMTJva0lIeHc1dDN1aDZEQnkzZEREYXpIVXU1U21zVzJxM2ZvU1hkY0hFbGZv
MnpJTTRYbjI2dXE4Mgp0K3NEcHRhaElLdFB0RG1YZ2Y4aldWc2RmdHljSGtQcDRNK1pNWXlUMkFL
aWY3alNXM1dxV3hqK0twMnV4NmxXCnJGd3ExckIvTEZIalVwOENQU3NNeFYzekJuWVFrTHJ3bVUx
SjlHby9UWkRLWHVnT3dLYzZ4TUxZZnFrU3lGUy8KaHVuZ2dHZ2U2VndMdWV3Ym54MjNmQWZ1Nksw
NGVIN1hBWW03VHl0cjdzclRmZERpQ05MUVRvR3dPTzRVckFZQQoxRm9tb0JlbFI3V3I1c1BEcVZu
aWVWY0N0TnBrRjZGZGNxK21KL1hsQzRsNDRkY1JqVUoxZFZlNFVSaE9YWVpLClRya0J4NDhnNmEz
alZOckxDZ1lmYUtSQnVPZ1BqUCtubndUdHBrcz0KPWN0RUsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ee29a90639057332--
