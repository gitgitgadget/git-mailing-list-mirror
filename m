Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387A127EFFC
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388141; cv=none; b=PqratNWDmTzHCJoN6R+eQU2vg9woB8ujgwoPn5+V1awNx+KBGdU/JPMZjdQJYGVrbcJ7zIsswhnOqRo3wNy8rRYo953eo7kWBh0hhMZqfrrqU3oggl9quE7o9rx/KfkBpSJGQOIGV9TXUJ1OMRXg0KuWO/+Nl/gpNsE3evdCGds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388141; c=relaxed/simple;
	bh=XTOVnkO1Yfn/qQh020yzUMUku+2BcpUvZH6iurzfsIk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DfbyHvzySSp9AoU4ffxw2R7hYxg9Mbc7XgvsUJ6vp/+rrXm62II9CL7znP13AAJJkW7YD7pzM/r3DDGLXwjES/kTYuW5CKRpzpsYywVRwp5f6KeaGE6NHks3yfbHg0RGIgduRSMJnwRz51EMQ0U9KLL1J60TbHLDUpS6EBmbR2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDycXswV; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDycXswV"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-742c7a52e97so5911702b3a.3
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751388139; x=1751992939; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjRougtrEH5RcXtLrF1Hq27gQujDXHMrCcDRD/D72C0=;
        b=PDycXswVcUIqZWltvRXr5e/WT9UEEQ/9W3TvytekEcuVWyV6pSJfynhBROMZQkaTdh
         r7IlXs6wDdIFsLnAU9YT/WqdmWKxosgeYKjX2rtEwXDd+gi9ZD29eJnwOFVuXNzFIcwe
         +HXwHT9nacl8XpeXRvCrymzhu8bLhWCTL9w3g7sfXBsyh+Y2FK0SYeCmtXPxtkIG5sYq
         w6RWFGLsFOYTkqwbScySJnbbWZbs6fz/DkaBmWOjyGLeDRfHBGA26pzcjSa2qLbFovf0
         TsptP84z+eV5a5BwoenoB5gYmGzkgugBMJ/M6xRe9nMIJzdQ3aI59V5ixZdM4obmQsNx
         6GRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751388139; x=1751992939;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BjRougtrEH5RcXtLrF1Hq27gQujDXHMrCcDRD/D72C0=;
        b=Xxoef9FN0o6mPlE0P6NdYJz/WhokhOlTEf1RDnN9WJfgcQC+Spbv366m481VAAavsp
         m0SqOlmEXLyC0HZwSdr4IuWRqws1STXKDdSJKFxpoUPf1XD7Ukcqk97Vv+gowwYjjuIb
         0n02NIrEB4PAxfx3gMgiOXkK6M8uzP8qmX7JIFwhMsNyWtXoAMDEernHySAqChV9VrQj
         UL0MFs1EpunEAgC+ymzul64EpSjAk38f91VE513GumMA6tmpRVqSTUoPt1JJ7aJgGtwB
         MjcJkFuEjwG6ACHiyV5sfZY7L7Q/epH9NSwjQSqtlY4HjvAU5TEEtetT5/xDJ+rqwdvk
         AweQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVRdvQx5Yj0fiNnDkiZFAvyQztP/lQFv47+Lfn93jgfwyFqtx8Cr5Rbh6UYqanSCyDNho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXMGSFToXFnRmXIBSVSN4uNBWfLzKK2uFDq9XoRAVDvzfY4xWA
	KN77mSA1GxfQXqJLsYHezx5IEydzKjfAD1pdUkhcC8qpn1Lx4ZAPv+QjZhGarg==
X-Gm-Gg: ASbGncsNxzlqJpKMjUVJfaWF5XAnZ05wYJzbwS3u3wznc+lTRHymhiyQCLH0l27GroL
	GSAyL5R3B9UuQqNalGzkx9j1xbI4gKvDJNPrCHE2x57gkJFtmdYiUkpN4X66cyWL4qRVbkem0X8
	0lY2tWdbo0zXqf/qOA0VPjZvk6GhJAnlW2JHddwXn4I3RIZVU6or+EQVO4YK8beO5YTJ6xcGebG
	j/XKgWzfohIxESpaqvZ2um3Yrhe7DcO+WGxA2ZBTp/pZwIfV8qNiFIAPqbF0dRzT+XZkchT1ZsV
	y+hOfnNv/EJBqe1bSi8OdKYxMkLSAghY2bPCXazdwts33TLOf2xACWUOLbQWTlYfPrP0xHBfVch
	Xcvsga8tYab4r9fK2B3uTtLtyfuSkuM/RquoBUg==
X-Google-Smtp-Source: AGHT+IGmmMDhKpLXOcBz6FIsELkJQrTEWh6O0vskmcTBZS0yEFzjhw+VHWpBd2pMZHwIzd7QHnop1w==
X-Received: by 2002:a05:6a21:999c:b0:220:879d:5648 with SMTP id adf61e73a8af0-220a16b8ed1mr27622078637.21.1751388139445;
        Tue, 01 Jul 2025 09:42:19 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af55745e1sm12091424b3a.88.2025.07.01.09.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 09:42:19 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>,  christian.couder@gmail.com,
  git@vger.kernel.org,  shyamthakkar001@gmail.com,  shejialuo@gmail.com
Subject: Re: [GSOC PATCH v2 2/2] builtin/prune: stop depending on
 'the_repository'
In-Reply-To: <aGPcKgR0G72JRSlM@pks.im> (Patrick Steinhardt's message of "Tue,
	1 Jul 2025 15:01:30 +0200")
References: <cover.1751296633.git.ayu.chandekar@gmail.com>
	<f70de9d549f2cb744810df7a9ee09e0b3626e62a.1751296633.git.ayu.chandekar@gmail.com>
	<aGPcKgR0G72JRSlM@pks.im>
Date: Tue, 01 Jul 2025 09:42:18 -0700
Message-ID: <xmqqikkbkglx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Jun 30, 2025 at 10:11:05PM +0530, Ayush Chandekar wrote:
>> @@ -173,20 +171,19 @@ int cmd_prune(int argc,
>>  	expire = TIME_MAX;
>>  	save_commit_buffer = 0;
>>  	disable_replace_refs();
>> -	repo_init_revisions(the_repository, &revs, prefix);
>> +	repo_init_revisions(repo, &revs, prefix);
>
> Does this work correctly when running outside of a repository? In
> general `cmd_prune()` is not executed and would instead die as it is
> declared as `RUN_SETUP`, without the `_GENTLY` suffix. But when the user
> asks for help we may still execute the function with a NULL pointer.

Good eyes.  "git prune -h" would safely exit in parse_options() in
such a case, but this part happens before the parse_options() call.

