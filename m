Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9415F3C28
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623573; cv=none; b=mDslxaxtkPoElUZCnDf9e1ysEDYD7iDDZDOxgugtn/d+cG8vfUPGlG/zErIdBoM2wRLTDmFGTP/ksjvP5M3+Fqbaqdg1G1oIIdvPfyNwyZYH+wbwEZRnqUoNbvT/GvUmCp2fJu0j/fCQ5RhMgQ+7SedgGWM+25GdEMMI0ne/QOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623573; c=relaxed/simple;
	bh=uy+stx5A1GHxEw8euTc+B9gRCgy9H3E8GNRpeqwfjT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+EuKhh0MXk1YHZFYLl9iiAfp2Wu8EDKD8/Kb2I3HwgwJov+0qsZgwIY+V2MH/mYuhpfnsb7uH+icn/ee8zWiyK4BHVEBKAggAaRr3YtsyqKLkQ2ZfdtEu4Ogr9jTvyYeo+0DzOOu5JnrWov6WMcPl5jb4HNcIyZTfaJFv53QPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bp8JAvvJ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp8JAvvJ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35dc1d8867eso300442f8f.0
        for <git@vger.kernel.org>; Wed, 05 Jun 2024 14:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717623570; x=1718228370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2cYvBmFOIhpg2Dod0Qs0tmSimi56H38oY7ILJ+zJjXU=;
        b=Bp8JAvvJYn0sgBPUbkCmaq1JF0K0m6pbAHqFXtRkKG+BU7dBsFkFsNpSxt4LCQJ8hq
         Hr7iGaILIkTIV7DlLu4IlvyyMBlzND7G/F+X+AfhTmIj6YbxiLsfGYu82TmM+t8bKAUo
         FPmPIQM1UgPrhv3Bdf5dc3P9jwvlBnaIXFJFHanjlUJZcR2xyAElyJ7q2snV7heHYm5E
         /gpjLlU2Efkw6KHIdn2a3cRlbLnGdx7PHeGkVZ43zCAf6+ZhxqistknkWlqa+/26sP6s
         OjM7GVXZBwvAF7zXDPw+hFkeUoJpISlsDiRuay+eoYt3MJQ3X9/k+p2cFEnhkORfy+V3
         OlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717623570; x=1718228370;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2cYvBmFOIhpg2Dod0Qs0tmSimi56H38oY7ILJ+zJjXU=;
        b=eVkhJXrTk5y2lE73eLWYM2ihHKUWKzSW3jsk3H6LRDRqu//fH/DJDctOdaxy7OKbUA
         KRxBs5vn0vFm42Qwmhjo/HEx5Ud9+wPP4Vzpnwwui0aXzBRNfOQ1/1c9ocu//KKeGGBE
         Gw5D8rNj3l/FLMV9kjOOJKypWb2aUtwMyycP20kmQ0AsAkUo3jcE7ZHFProxA3m/5qN5
         oqYWRURk5b5GobTswb7nt6RX9ZQVpiR4RW9Xp6X/xAgCaNc3tOH7fowhHIScZn1MZhKl
         bfSrJn57XmYy3nnFzCDaWKKusquTNtcu+G9/aWGHhNn1ilHhKPcd66Ty8/Bni8Gi/iFT
         9KAg==
X-Gm-Message-State: AOJu0YwVbcjyQpxvu+wX/phxogr/0e1RK5LjeNi8tEKCK+LGIwKMliry
	WN0mR4815Y7ck6NqRTZ1IBXYjsj/kT8QYN63zjF4Ip2ELd4O0Fz4zse0Ig==
X-Google-Smtp-Source: AGHT+IESBxpjJIDbEHsP041nRXWB0m9GgjclFm67AQzqfrQiQGXMhO6qr1oUuBlXpIaLQV/YqKIQiQ==
X-Received: by 2002:adf:e68f:0:b0:354:e0e8:33ea with SMTP id ffacd0b85a97d-35e8ef94698mr2713794f8f.66.1717623569546;
        Wed, 05 Jun 2024 14:39:29 -0700 (PDT)
Received: from gmail.com (52.red-88-14-62.dynamicip.rima-tde.net. [88.14.62.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0f57sm15804064f8f.12.2024.06.05.14.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 14:39:29 -0700 (PDT)
Message-ID: <054e2032-8d09-491a-bc33-309fb20fa9bc@gmail.com>
Date: Wed, 5 Jun 2024 23:39:28 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] format-patch: assume --cover-letter for diff in
 multi-patch series
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
References: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>
 <14365d68-ed04-44fe-823b-a3959626684e@gmail.com>
 <cb6b6d54-959f-477d-83e5-027c81ae85de@gmail.com> <xmqqr0dbqfv8.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqr0dbqfv8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Jun 05, 2024 at 01:44:27PM -0700, Junio C Hamano wrote:

> > +	git format-patch -v2 --range-diff=topic main..unmodified &&
> > +	test_when_finished "rm v2-000?-*" &&

At any rate, I agree with you this is confusing.

I'll address this and the other similar ones in t3206, in a
preparation patch within this series.

However, I'll refrain for two or three days before sending a new
iteration.

Thanks.
