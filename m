Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC12D27586C
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751384619; cv=none; b=fmh1qKaUrLH3LkPPqObL1Bv6sAEe/bDDY6CbgGmb9sYbXh7CdbovAGs34cmDa8eP/8V4CNhtXKp4oGbiucxjwXXAYtFzPBHFQW8gUj//M42uVzoUqBluEuHbpRvX7yybaORVe69YqbggWSYPR3v1nb25+5oz+vjup0UOxeaw0ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751384619; c=relaxed/simple;
	bh=vLwWaJCgi4hf9q5nhU68Lb2/nvVCy66MXrDP2nIWlW4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rn894XTJfLa3cj69eRSknZ3M3SagPkjSWCHH0icpVyhx2fIMoWo/lTPz3cFpvamY+i31xixqj2k2oqlCvEtADzU+JV4SeBunFXeUYRqbIXRpxtlOXF6llGYZPFeR6lh6fp0/YHGTwIMip3w/nOvNhQVgdR2EFGz/l4ESFdsW6zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXC2GRjS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXC2GRjS"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73972a54919so3295510b3a.3
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 08:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751384617; x=1751989417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6yKERvqL8I5vzmGGDOfA3ChVQkowBs+68x9NjS974eM=;
        b=gXC2GRjSo2xn6c4MrLpth8B88INB59xjXfsoc655QIaWYsYSstQY0nZO9KNFBvJLGX
         uWmf22X5xcixc8n64H4jB1BCYfwwoSaknMuQZHlFq2YJiAEzopAazv3dcdaz9H5eqBFC
         F/TzJWnWWND99MzHz//F6fW51PVJknlajgIBxaIota35p7YIYvvfcOWqClGxE+IqZd35
         v3ZpM5GFTEIIeqTizUY3Po+Bejs3Zgt6h4nqprTHmQVS6WMOeRht1mqayGZBJi5AGSfZ
         Rx/kRmo1Bj6g/xI6DWD4YRz4dSviIBxxwrakvsOgVuWsf0eMVbB1IvVNlufIWrOyOS3c
         GW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751384617; x=1751989417;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6yKERvqL8I5vzmGGDOfA3ChVQkowBs+68x9NjS974eM=;
        b=VXEqZ4XgqLLXYUqjSfd499Mq54scUOiqWm+ESDHhbMPmkLrJU71kBmGsAWf2242VU+
         mbXDIsBalsjbXuKFeDSK7uPRVQb0Tztx7DdtMSjVUW8QGRxf7RVDfQpq1an5OYZoKGQn
         P4Jh+jtw2YJ78GerfaMxIwaz47aYkiNC4CkSQwoRSMFLxp6fu7svyxQCk/M1Tn68Igb1
         rOqxREgsPniRSs8r0YUH0Ze/JCc/JmSIaS41QqYM2K593KMfQH6XGF2vavKPeE8tyubk
         KC1Y/92Fo6uevQPSP4dKsxcZMsrY+DNT0m0pfUNH6FQtrQwbTgB9NtdSdqKYiiaCKG9F
         FjMA==
X-Forwarded-Encrypted: i=1; AJvYcCVpPozyZmZXaUvjy6E4m094fTXAKoJeS+b5tAtLwFXIfq5rE2wle7sV+zxdymWTt9EodFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw50VLjEfUJaggEZKvaW+LaG4JJ6RBc048y7OpaZR4C6Y+/YZTI
	rG3RAnIXkQ6ocvfRGGLKwzZIDvw49udlbSpma2qGK2lGZ2Hsb6Z6S6vX
X-Gm-Gg: ASbGncsd9KHWgPlJ889vLboSVYhQHXP0bzG/qcmtt5nwc/eorVF5Dh1uLX3sNVufPEZ
	RD8A67IiL87LX9y9Vi1Rns7SvUm4/lH6qmKukHdykT+gzxAMDhUMdvNyrex6aklR57Dl6pBrzfl
	vYY9ycShPLX63ck2AiNndqlIZlHpLNc4DEMMVax+1+owTIWRpVXJhN5z4OmWlV6D5lIk2Q7uxkJ
	1iYuEoWgVzzqFemBpX+pjNnD4RfURnr+DsXMTYm3SU/7AABu5MQzALCtB4NDEB2J0eftJ3AJ6ns
	ZFRNYVSdHdpktXB0Og7zTEgIEJTQYkHr1OpDa4VVt+6kDCMFvXu7FaurdhD5m47HUqmsNzdAdxu
	b9je6sLyNqCDR1flP4EoI5M6eVsKhdNcizKiSVQ==
X-Google-Smtp-Source: AGHT+IFOWA4uN3SGXjS9saIu/D+MCQ2cSQ8mn6pbMjajSuhU7NEG1mEM1ZvUtBDegcpOc00d5gFvAg==
X-Received: by 2002:a05:6a00:2290:b0:749:1d18:2c74 with SMTP id d2e1a72fcca58-74af6eec695mr23862886b3a.10.1751384616964;
        Tue, 01 Jul 2025 08:43:36 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af558102bsm12962618b3a.105.2025.07.01.08.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 08:43:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Lidong Yan <yldhome2d2@gmail.com>,  git@vger.kernel.org,  Lidong Yan
 <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH 2/2] bloom: enable multiple pathspec bloom keys
In-Reply-To: <aGOhY2YuJZNG8ovj@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Tue,
	1 Jul 2025 10:50:43 +0200")
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
	<20250625125541.3048632-3-502024330056@smail.nju.edu.cn>
	<xmqqy0td8fa9.fsf@gitster.g> <aGOhY2YuJZNG8ovj@szeder.dev>
Date: Tue, 01 Jul 2025 08:43:35 -0700
Message-ID: <xmqqfrfflxw8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Fri, Jun 27, 2025 at 06:50:22AM -0700, Junio C Hamano wrote:
>> Totally outside the topic, but I wonder if we can further optimize
>> by adding an early rejection using .nowildcard_len?  Instead of
>> allowing a wildcarded "dir/*" pathspec element from disabling the
>> Bloom filter altogether, we could say "dir/ is not possibly altered,
>> so there may be dir/A, dir/B, etc., in the directory, nothing that
>> would match dir/* wildcard would have been modified", couldn't we?
>
> Indeed, that's what I demonstrated back in:
>
>   https://public-inbox.org/git/20200529085038.26008-35-szeder.dev@gmail.com/

Heh, I am always impressed that some people seem to have infinitely
long scrollback buffer ;-)  It is curious why nobody else noticed
and advocated for your patch back then.

